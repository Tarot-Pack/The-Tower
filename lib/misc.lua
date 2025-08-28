function Tower.create_playing_card(t)
    local card = SMODS.add_card(t);
    card:set_base(G.P_CARDS[t.front]);
    return card
end
function Tower.create_playing_cards(list, properties)
    for i, v in ipairs(list) do
        local tbl = copy_table(properties);
        tbl.front = v;
        Tower.create_playing_card(tbl)
    end
end
local old_smods_calc = SMODS.calculate_context;
local on_calcs = {}
function Tower.onCalculate(f) 
    on_calcs[#on_calcs+1] = f
    return f
end
local before_calcs = {}
function Tower.beforeCalculate(f) 
    before_calcs[#before_calcs+1] = f
    return f
end

function SMODS.calculate_context(context, return_table)
    for i, v in ipairs(before_calcs) do
        v(context) -- make modifications to context
    end
    local ret = old_smods_calc(context, return_table)
    for i, v in ipairs(on_calcs) do
        v(context, return_table or ret) -- interpret output or run things that do not need to modify context
    end
    if not return_table then
        return ret
    end
end

G.FUNCS.tower_use_joker = function(e, mute, nosave)
    local card = e.config.ref_table;
    local old = G.STATE
    if card.ability.set == 'Booster' then G.GAME.PACK_INTERRUPT = G.STATE end 
    G.STATE = (G.STATE == G.STATES.TAROT_PACK and G.STATES.TAROT_PACK) or
      (G.STATE == G.STATES.PLANET_PACK and G.STATES.PLANET_PACK) or
      (G.STATE == G.STATES.SPECTRAL_PACK and G.STATES.SPECTRAL_PACK) or
      (G.STATE == G.STATES.STANDARD_PACK and G.STATES.STANDARD_PACK) or
      (G.STATE == G.STATES.SMODS_BOOSTER_OPENED and G.STATES.SMODS_BOOSTER_OPENED) or
      (G.STATE == G.STATES.BUFFOON_PACK and G.STATES.BUFFOON_PACK) or
      G.STATES.PLAY_TAROT
      
    G.CONTROLLER.locks.use = true

    if card.children.use_button then card.children.use_button:remove(); card.children.use_button = nil end
    if card.children.sell_button then card.children.sell_button:remove(); card.children.sell_button = nil end
    if card.children.price then card.children.price:remove(); card.children.price = nil end

    card.config.center:use(card, area)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
            stop_use()
            G.STATE = old
            card:highlight(card.is_higlighted)
            G.CONTROLLER.locks.use = false
            return true
        end
    }))
end
G.FUNCS.tower_can_use_joker = function(e)
    if e.config.ref_table.config.center:can_use(e.config.ref_table) then 
        e.config.colour = G.C.RED
        e.config.button = 'tower_use_joker'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

local old_sell_and_use = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    local val = old_sell_and_use(card)
    if
		card.config
        and card.config.center
	then
        if card.config.center.use and card.config.center.set == "Joker" and (not ((card.area == G.pack_cards) or (card.area == G.hand))) and (card.config.center.mod.id == "Tower" or Tower.FeatureWL[card.config.center.mod.id]) then -- no using in joker pack if ever in one (only select)
            val.nodes[1].nodes[2].nodes[1] = {n=G.UIT.C, config={align = "cr"}, nodes={
                {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'tower_use_joker', func = 'tower_can_use_joker'}, nodes={
                    {n=G.UIT.B, config = {w=0.1,h=0.6}},
                    {n=G.UIT.T, config={text = localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
                }}
            }}
        end
        if card.config.center.tower_inescapeable and card.config.center.rarity ~= "cry_cursed" then -- exclude cry_cursed as cryptid will just do it for us
		    table.remove(val.nodes[1].nodes, 1)
        end
	end
    return val
end


function Tower.rgb2hsl(rgb)
    local r = rgb[1]
    local g = rgb[2]
    local b = rgb[3]
	local M, m = math.max( r, g, b ), math.min( r, g, b )
	local C = M - m
	local K = 1.0 / (6*C)
	local h = 0
	if C ~= 0 then
		if M == r then     h = ((g - b) * K) % 1.0
		elseif M == g then h = (b - r) * K + 1.0/3.0
		else               h = (r - g) * K + 2.0/3.0
		end
	end
	local l = 0.5 * (M + m)
	local s = 0
	if l > 0 and l < 1 then
		s = C / (1-math.abs(l + l - 1))
	end
	return {h, s, l, rgb[4]}
end

function Tower.hsl2rgb(hsl)
    local h = hsl[1]
    local s = hsl[2]
    local l = hsl[3]
	local C = ( 1 - math.abs( l + l - 1 ))*s
	local m = l - 0.5*C
	local r, g, b = m, m, m
	if h == h then
		local h_ = (h % 1.0) * 6.0
		local X = C * (1 - math.abs(h_ % 2 - 1))
		C, X = C + m, X + m
		if     h_ < 1 then r, g, b = C, X, m
		elseif h_ < 2 then r, g, b = X, C, m
		elseif h_ < 3 then r, g, b = m, C, X
		elseif h_ < 4 then r, g, b = m, X, C
		elseif h_ < 5 then r, g, b = X, m, C
		else               r, g, b = C, m, X
		end
	end
	return {r, g, b, hsl[4]}
end

local old_update_suit_colours = G.FUNCS.update_suit_colours;
G.FUNCS.update_suit_colours = function(suit, skin, palette_num)
    local colour = old_update_suit_colours(suit, skin, palette_num)
    G.C.MULT_SUITS = G.C.MULT_SUITS or {}
    for i, tex in pairs(G.C.SUITS) do
        local hsl = Tower.rgb2hsl(tex);
        hsl[1] = math.min(1, 0.725 - ((hsl[1] - 0.5) / 4));
        hsl[3] = 0.7 + (hsl[3] * 0.3);
        local final = Tower.hsl2rgb(hsl);
        G.C.MULT_SUITS[i] = final
    end
end


local old_never_scores = SMODS.never_scores
function SMODS.never_scores(c) 
    if c.ability.set == "Joker" then return true end
    return old_never_scores(c)
end

function Tower.MergeCards(card, other)
    if not (card.edition and card.edition.cry_double_sided) then
        card:set_edition({ cry_double_sided = true })
    end
	card.merged = true
	card.ability.immutable.other_side = copy_table(other.ability)
	card.ability.immutable.other_side.key = copy_table(other.config.center.key)
	card.ability.immutable.other_side.seal = copy_table(other.seal)
	if other.base.nominal ~= 0 then
		card.ability.immutable.other_side.base = copy_table(other.base)
	end
	other:start_dissolve()
	if next(find_joker("cry-Flip Side")) then
		card:remove_from_deck(true)
		Card.add_to_deck(card:get_other_side_dummy(), true)
	end
end

function Tower.CardifyJoker(j)
    if Entropy then
        local card = Tower.create_playing_card({ front = "nilsuit_nilrank" })
        card:set_ability(j.config.center)
        card.ability = copy_table(j.ability)        
        card:set_edition(j.edition or {}, nil, true)
        for k,v in pairs(j.edition or {}) do
            if type(v) == 'table' then
                card.edition[k] = copy_table(v)
            else
                card.edition[k] = v
            end
        end
        card:set_seal(j.seal, true)
        if j.seal then
            local safe_seal = type(j.ability.seal) == "table" and j.ability.seal or {}
            for k, v in pairs(safe_seal) do
                if type(v) == 'table' then
                    card.ability.seal[k] = copy_table(v)
                else
                    card.ability.seal[k] = v
                end
            end
        end
        card.debuff = j.debuff
        card.pinned = j.pinned

        j:remove()
    else
        G.jokers:remove_card(j)
        G.deck:emplace(j)
        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
        j.playing_card = G.playing_card
        j.ability.tower_return_to_jokers = true
        table.insert(G.playing_cards, j)
    end
end

function Tower.UncardifyJoker(j)
    G.deck:remove_card(j)
    G.jokers:emplace(j)
    j.playing_card = nil
    j.ability.tower_return_to_jokers = nil
    for i, v in ipairs(G.playing_cards) do
        if v == j then
            table.remove(G.playing_cards, i)
            break
        end
    end
end

local ev_intro = evaluate_play_intro

function evaluate_play_intro()
    local new = {}
    old_hl = G.play.highlighted;
    local new_hl = {}
    for i, v in ipairs(G.play.cards) do
        if v.ability.tower_return_to_jokers then
            Tower.UncardifyJoker(v)
        else
            new[#new+1] = v
        end
    end
    for i, v in ipairs(G.play.highlighted) do
        if v.ability.tower_return_to_jokers then
            
        else
            new_hl[#new_hl+1] = v
        end
    end
    G.play.cards = new
    G.play.highlighted = new_hl
    return ev_intro()
end


local deck_preview = G.UIDEF.deck_preview
G.UIDEF.deck_preview = function (a) 
    local val = deck_preview(a)
    for i, v in ipairs(G.playing_cards) do
        if v.ability.tower_is_temp then
            v.base.value = nil
            v.base.suit = nil 
	        v.ability.tower_is_temp = false
        end
    end
    return val
end

local view_deck = G.UIDEF.view_deck
G.UIDEF.view_deck = function (a) 
    local val = view_deck(a)
    for i, v in ipairs(G.playing_cards) do
        if v.ability.tower_is_temp then
            v.base.value = nil
            v.base.suit = nil 
	        v.ability.tower_is_temp = false
        end
    end
    return val
end

local your_suits_page = G.FUNCS.your_suits_page
G.FUNCS.your_suits_page = function (a) 
    local val = your_suits_page(a)
    for i, v in ipairs(G.playing_cards) do
        if v.ability.tower_is_temp then
            v.base.value = nil
            v.base.suit = nil 
	        v.ability.tower_is_temp = false
        end
    end
    return val
end

local old_delete = SMODS.Center.delete

SMODS.Center.delete = function(self)
    if self.rarity == "tower_transmuted" then
        SMODS.remove_pool(G.P_CENTER_POOLS[self.rarity], self)
    end
    return old_delete(self)
end

local old_insert_pool = SMODS.insert_pool;
G.tower_transmuted_pool_copy = {}
SMODS.insert_pool = function (pool, center)
    old_insert_pool(pool, center)
    if pool == G.P_CENTER_POOLS.tower_transmuted then
        local good = true;
        for i, v in ipairs(G.tower_transmuted_pool_copy) do
            if v.key == center.key then 
                good = false
                break
            end
        end
        if not good then return end
        old_insert_pool(G.tower_transmuted_pool_copy, center)
    end
end

Tower.AfterAllLoaded(function ()
    local old_enable = SMODS.Center.enable
    SMODS.Center.enable = function(self)
        if self.cry_disabled then
            if self.rarity == "tower_transmuted" or self.set == "tower_transmuted" or (self.pools and self.pools.tower_transmuted) then
                SMODS.insert_pool(G.P_CENTER_POOLS.tower_transmuted, self)
            end
        end
        return old_enable(self)
    end
    local old = SMODS.collection_pool;
    SMODS.collection_pool = function(base_pool)
        if base_pool ~= G.P_CENTER_POOLS.tower_transmuted then
            local val = old(base_pool)
            local actual = {}		
            for k, v in pairs(val) do
                if not (v.rarity == "tower_transmuted" or v.set == "tower_transmuted") then
                    actual[#actual+1] = v
                end
            end
            return actual
		else
            return old(G.tower_transmuted_pool_copy)
        end
    end

    local old_modsCollectionTally = modsCollectionTally
function modsCollectionTally(pool, set)
    if set == 'tower_transmuted' or pool == G.P_CENTER_POOLS.tower_transmuted then
        return Tower.CountTransmuted()
    end
    local obj_tally = old_modsCollectionTally(pool, set);
	if G.ACTIVE_MOD_UI and (Cryptid.mod_gameset_whitelist[G.ACTIVE_MOD_UI.id] or G.ACTIVE_MOD_UI.id == "Cryptid") then
		--infer pool
		local _set = set or Cryptid.safe_get(pool, 1, "set")
		--check for general consumables
		local consumable = false
		if _set and Cryptid.safe_get(pool, 1, "consumeable") then
			for i = 1, #pool do
				if Cryptid.safe_get(pool, i, "set") ~= _set then
					consumable = true
					break
				end
			end
		end
		if _set then
			if _set == "Seal" then
				pool = SMODS.Seal.obj_table
				set = _set
			elseif G.P_CENTER_POOLS[_set] then
				pool = SMODS.Center.obj_table
				set = _set
			end
		end
		for _, v in pairs(pool) do
			if v.mod and G.ACTIVE_MOD_UI.id == v.mod.id and not v.no_collection then
				if set then
					if v.rarity == "tower_transmuted" and set == "Joker" then
						obj_tally.of = obj_tally.of - 1
						if Cryptid.enabled(v.key) == true then
							obj_tally.tally = obj_tally.tally - 1
						end
					end
				end
			end
		end
	else
        local set = set or nil

        for _, v in pairs(pool) do
            if v.mod and G.ACTIVE_MOD_UI.id == v.mod.id and not v.no_collection then
                if set then
                    if v.rarity == "tower_transmuted" and set == "Joker" then
                        obj_tally.of = obj_tally.of-1
                        if v.discovered then 
                            obj_tally.tally = obj_tally.tally-1
                        end
                    end
                end
            end
        end
    end
    return obj_tally
end
end)

local old_inject = SMODS.Center.inject

SMODS.Center.inject = function(self)
    if self.rarity == "tower_transmuted" then
        SMODS.insert_pool(G.P_CENTER_POOLS[self.rarity], self)
    end
    if self.rarity == "tower_transmuted" and self.set == "Joker" then
        G.P_CENTERS[self.key] = self

        -- the same but with joker pool injection omitted
        for k, v in pairs(SMODS.ObjectTypes) do
            if k ~= "Joker" then
                -- Should "cards" be formatted as `{[<center key>] = true}` or {<center key>}?
                -- Changing "cards" and "pools" wouldn't be hard to do, just depends on preferred format
                if ((self.pools and self.pools[k]) or (v.cards and v.cards[self.key])) then
                    v:inject_card(self)
                end
            end
        end
    else
        return old_inject(self)
    end
end
Tower.AfterAllLoaded(function()
    -- added scaling
    local old_smds = SMODS.get_blind_amount;
    local old_blind_amt = get_blind_amount;

    get_blind_amount = function (...)
        if G.tower_ignore_scaling or G.GAME.modifiers.tower_ante_scaling == nil then
            return old_blind_amt(...)
        end
        G.tower_ignore_scaling = true
        local val = old_blind_amt(...)
        G.tower_ignore_scaling = false
        val = val * G.GAME.modifiers.tower_ante_scaling
        return val
    end
    SMODS.get_blind_amount = function (...)
        if G.tower_ignore_scaling or G.GAME.modifiers.tower_ante_scaling == nil then
            return old_smds(...)
        end
        G.tower_ignore_scaling = true
        local val = old_smds(...)
        G.tower_ignore_scaling = false
        val = val * G.GAME.modifiers.tower_ante_scaling
        return val
    end
end)

function Tower.BatchBooster(conf)
    if (conf.amount or 1) == 1 then return Tower.Booster(conf) end
    if conf.amount < 1 then return end
    for i = 1, conf.amount do
        local item = copy_table(conf)
        item.order = (item.order or 0) + i - 1
        item.pos.x = item.pos.x + i - 1
        item.key = item.key .. "_" .. tostring(i)
        item.name = item.name .. tostring(i)
        item.weight = item.weight / conf.amount
        Tower.Booster(item)
    end
end


function Tower.find_card(key, count_debuffed)
    local results = {}
    local areas = {SMODS.get_card_areas('jokers'), {G.consumeables}}
    for _, h in ipairs(areas) do
        for _2, area in ipairs(h) do
            if area.cards then
                for _, v in pairs(area.cards) do
                    if v and type(v) == 'table' and v.config.center.key == key and (count_debuffed or not v.debuff) then
                        table.insert(results, v)
                    end
                end
            end
        end
    end
    return results
end

function Tower.poll_pool_weighted(_pool_key, _rand_key)
    local is_soul = false;
    local rarity_poll = nil
    if pseudorandom('soul_'..(_rand_key or _pool_key)..G.GAME.round_resets.ante) > 0.997 then
        is_soul = true
    else
        rarity_poll = pseudorandom(pseudoseed(_rand_key or ('rarity'..G.GAME.round_resets.ante))) -- Generate the poll value
    end
    local available_rarities = SMODS.ObjectTypes[_pool_key].tower_rarities or {} -- Table containing a list of rarities and their rates
    local vanilla_rarities = {["Common"] = 1, ["Uncommon"] = 2, ["Rare"] = 3, ["Legendary"] = 4}
    if #available_rarities == 0 then return nil end
    -- Calculate total rates of rarities
    local total_weight = 0
    local compiled = {}
    for key, items in ipairs(available_rarities) do        
        if (key ~= 'tower_transmuted') and (#items > 0) then
            local v = {
                key = key,
                weight = 1,
                mod = 1
            }
            if v.key ~= "spec_none" then
                v.mod = G.GAME[tostring(v.key):lower().."_mod"] or 1
                -- Should this fully override the v.weight calcs?
                if SMODS.Rarities[v.key] and SMODS.Rarities[v.key].get_weight and type(SMODS.Rarities[v.key].get_weight) == "function" then
                    v.weight = SMODS.Rarities[v.key]:get_weight(v.weight, SMODS.ObjectTypes[_pool_key])
                else
                    v.weight = 0
                end
            else
                v.mod = 1;
            end
            v.weight = v.weight*v.mod
            if (is_soul and (v.weight <= 0)) 
            or ((not is_soul) and (v.weight > 0)) then
                total_weight = total_weight + v.weight
                compiled[#compiled+1] = v
            end
        else
            available_rarities[key] = nil
        end
    end
    -- recalculate rarities to account for v.mod
    for _, v in ipairs(compiled) do
        if (v.weight > 0) and (total_weight > 0) then
            v.weight = v.weight / total_weight
        end
    end

    -- Calculate selected rarity
    local weight_i = 0
    local selected_rarity;
    if is_soul then
        if #compiled == 0 then
            return nil
        end
        selected_rarity = pseudorandom_element(compiled, (_rand_key or _pool_key) .. "soul_rarity")
    else
        for _, v in ipairs(compiled) do
            weight_i = weight_i + v.weight
            if rarity_poll < weight_i then
                selected_rarity = v.key
            end
        end
        if selected_rarity == nil then
            return nil
        end
    end
    local pool = available_rarities[selected_rarity];
    local new_pool = {};
    for i = 1, #pool do
        if ((not pool[i].in_pool) or pool[i]:in_pool()) and not (G.GAME.banned_keys[pool[i].key]) then
            new_pool[#new_pool+1] = pool[i]
        end
    end
    return pseudorandom_element(new_pool, _rand_key).key
end
function Tower.GenericBoosters(conf)
    Tower.BatchBooster({
        key = conf.key,
        kind = conf.kind,
        atlas = conf.atlas,
        pos = conf.pos,
        order = conf.order,
        config = conf.config,
        cost = conf.cost,
        weight = conf.weight,
        amount = conf.amount,
        name = conf.name,
        tower_credits = conf.tower_credits,
        create_card = function(self, card)
            if
                (not G.GAME.used_jokers[conf.soul_card]) or next(find_joker("Showman"))
            then
                if pseudorandom(conf.key .. G.GAME.round_resets.ante) > 0.997 then
                    return create_card(conf.type, G.pack_cards, nil, nil, true, true, conf.soul_card, nil)
                end
            end
            return create_card(conf.type, G.pack_cards, nil, nil, true, true, Tower.poll_pool_weighted(conf.type, 'rarity'..G.GAME.round_resets.ante..conf.type), nil)
            --return create_card(conf.type, G.pack_cards, nil, SMODS.poll_rarity(conf.type, 'rarity'..G.GAME.round_resets.ante..conf.type), true, true, nil, conf.type)
        end,
        ease_background_colour = function(self)
            ease_colour(G.C.DYN_UI.MAIN, conf.colour)
            ease_background_colour({ new_colour = conf.colour, special_colour = conf.secondary_colour, contrast = 2 })
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card and card.ability.choose or self.config.choose,
                    card and card.ability.extra or self.config.extra,
                },
            }
        end,
        update_pack = function(self, dt)
            ease_colour(G.C.DYN_UI.MAIN, conf.colour)
            ease_background_colour({ new_colour = conf.colour, special_colour = conf.secondary_colour, contrast = 2 })
            SMODS.Booster.update_pack(self, dt)
        end,
        group_key = conf.group_key,
        cry_digital_hallucinations = {
            colour = conf.colour,
            loc_key = "k_plus_joker",
            create = function()
                local ccard = create_card(conf.type, nil, nil, nil, true, true, nil, "diha")
                local area = G.jokers;
                if ccard.ability.consumeable then
                    area = G.consumeables
                elseif other.ability.set == "Default" or other.ability.set == "Enhanced" then
                    area = G.deck
                end
                ccard.area = area;
                ccard:set_edition({ negative = true }, true)
                ccard:add_to_deck()
                area:emplace(ccard)
            end,
        },
    })
end

function Tower.AuthorBooster(author, cnf)
    Tower.GenericBoosters({ -- order 1 - 3
        key = author,
        kind = author,
        atlas = cnf.atlas,
        pos = cnf.pos,
        order = cnf.order,
        config = cnf.config,
        cost = cnf.cost,
        weight = cnf.weight,
        soul_card = cnf.soul_card,
        amount = cnf.amount,
        colour = cnf.colour,
        secondary_colour = cnf.secondary_colour,
        name = "tower_" .. author .. "_pack",
        type = "Tower-" .. author,
        group_key = "k_tower_" .. author .. "_pack",
        tower_credits = {
            idea = {
                author,
            },
            art = {
                "jamirror",
            },
            code = {
                "jamirror",
            },
        },
    })
end

local old_tower_joker = Tower.Joker;
local rarityOrderModifiers = {}
rarityOrderModifiers[1] = 0
rarityOrderModifiers[2] = 1
rarityOrderModifiers[3] = 3
rarityOrderModifiers[4] = 4
rarityOrderModifiers['cry_epic'] = 5
rarityOrderModifiers[5] = 6
rarityOrderModifiers["cry_exotic"] = 7
rarityOrderModifiers['tower_apollyon'] = 8
rarityOrderModifiers["tower_transmuted"] = 9
local poolOrder = {
    slime = 1
}
local shimmer_from_to_load = {}
function Tower.Joker(object)
    object.order = (object.order or 0) + ((rarityOrderModifiers[object.rarity] or 10) * 1000)
    if object.pools then
        if object.pools['Tower-Slime'] then
            object.order = object.order + (poolOrder.slime + 100)
        end
    end    
    if object.rarity == "cry_cursed" then
        if not ((SMODS.Mods['Cryptid'] or {}).can_load) then
            return
        end
    end

    if object.rarity == "cry_epic" then
        if not ((SMODS.Mods['Cryptid'] or {}).can_load) then
            object.rarity = 3
        end
    end
    if object.rarity == "cry_exotic" then
        if (SMODS.Mods['Cryptid'] or {}).can_load then
            object.tower_orig_rarity = object.rarity
        else
            object.rarity = "tower_apollyon"
        end
    end

    return old_tower_joker(object)
end

function Tower.HasPool(pool, item)
    return item.config.center and item.config.center.pools and item.config.center.pools[pool]
end

function Tower.RollDie(seed_key, max) -- max should be big or string
    max = to_big(max)
    local length = #tostring(max)
    local random = to_big(pseudorandom(pseudoseed(seed_key)));
    local number = tostring(math.floor(random * max)+1); -- (random * max) maximum is max - 1 but adding one makes it correct and provides the 1 minimum
    local digits = {}
    for i = 1, length - #number do
        digits[#digits+1] = 0
    end

    for i = 1, #number do
        digits[#digits+1] = tonumber(string.sub(number, i, i))
    end

    return number, digits
end

--[[
    Rules:
    I = 1
    V = 5
    X = 10
    L = 50
    C = 100
    D = 500
    M = 1000

    The symbols "I", "X", "C", and "M" can be repeated 3 times in succession, but no more.
    They may appear more than three times if they appear non-sequentially, such as XXXIX.
    "D", "L", and "V" can never be repeated.
    "I" can be subtracted from "V" and "X" only.
    "X" can be subtracted from "L" and "C" only.
    "C" can be subtracted from "D" and "M" only.
    "V", "L", and "D" can never be subtracted.
    Only one small-value symbol may be subtracted from any large-value symbol.
]]--

--mapping of possible addition values
local addition_map = {
    I=1,
    X=10,
    C=100,
    M=1000
    }

--mapping of substraction offsets (what can be substracted from each number)
local substraction_map = {
    V = 1,
    X = 1,
    L = 10,
    C = 10,
    D = 100,
    M = 100
    }

--mapping of roman numerals to arabic values
local numerals_map = {
    I = 1,
    V = 5,
    X = 10,
    L = 50,
    C = 100,
    D = 500,
    M = 1000
    }

function roman2arabic(str)
    local result = {}
    if str and type(str) == 'string' then
        local strLen = string.len(str)
        local resultPos = 1

        for i=1,strLen do
            local letter = string.sub(str, i, i)
            if not result[resultPos] then
                table.insert( result, numerals_map[letter] )
                --no need to increment since it's first number
            else
                if result[resultPos] == substraction_map[letter] then --can substract prev value
                    result[resultPos] = numerals_map[letter] - result[resultPos]
                    resultPos = resultPos + 1 --go to next one
                elseif result[resultPos] == addition_map[letter] then --can add prev value
                    result[resultPos] = result[resultPos] + numerals_map[letter]
                    --no increment -> can still add
                else
                    --no addition/substraction -> add a new number
                    resultPos = resultPos + 1
                    table.insert( result, numerals_map[letter] )
                end
            end
        end
    else
        print("roman2arabic: invalid input")
    end
    local arabicNum = 0
    for i, v in ipairs(result) do
        arabicNum = arabicNum + v
    end

    return arabicNum
end

--roman numerals possible based on order (placement in number - units, tens, hundreds, thousands)
local roman_nums_order = { {"I", "V", "X"}, {"X", "L", "C"}, {"C", "D", "M"}, {"M", "M", "M"} }

function Tower.ToRoman(num)
    local str = tostring(num);
    result = ""
    if str and type(str) == 'string' and (string.len(str) <= 4) then
        local strLen = string.len(str)
        local revStr = string.reverse(str)

        for i=1,strLen do
            local letter = string.sub(revStr, i, i)
            --probably there's a better way to transform a letter to a digit, but i don't know now
            local digit = string.byte(letter,1) - string.byte('0',1)
            local orderRes = ""

            local symbolReps = 0 --num of times symbol has repeated (must not be > 3)
            local substSymbol = 1 --symbol to substitute with (from roman_nums_order table)
            local substSymbolIncrement = 1 --can be 1 or 2, depending if we are before 5 or after 5 (e.g. if we need to use V or X)
            local j=1
            while j <= digit do
            	orderRes = orderRes .. roman_nums_order[i][substSymbol]
            	symbolReps = symbolReps + 1
            	if symbolReps > 3 then
            	    if i >= 4 then --max number of order thousands supported is 3
            	        orderRes = "MMM"
            	        break
            	    end
            	    orderRes = roman_nums_order[i][substSymbol]
            	    substSymbol = substSymbol + substSymbolIncrement
                 	orderRes = orderRes .. roman_nums_order[i][substSymbol]
                 	symbolReps = 0
			--check if next digit exists in advance  -> to remove substraction possibility
			if j+1 <= digit then
			    orderRes = roman_nums_order[i][substSymbol]
                            j = j+1 --go to next numeral ( e.g. IV -> V )
			    substSymbol = substSymbol - substSymbolIncrement --go back to small units
			    substSymbolIncrement = substSymbolIncrement + 1
			end
            	end
            	j=j+1
            end
            substSymbolIncrement = 1 -- reset increment for next order digit
	    result = string.format("%s%s", orderRes, result)
        end
    else
        return str
    end
    return result
end
local old_is_eternal = SMODS.is_eternal;
function SMODS.is_eternal(card, trigger)
    if card.config and card.config.center and card.config.center.tower_inescapeable then
        return true
    end
    return old_is_eternal(card, trigger)
end