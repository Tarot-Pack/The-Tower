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

function SMODS.calculate_context(context, return_table)
    local ret = old_smods_calc(context, return_table)
    for i, v in ipairs(on_calcs) do
        v(context, return_table or ret)
    end
    if not return_table then
        return ret
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
    G.jokers:remove_card(j)
    G.deck:emplace(j)
    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
    j.playing_card = G.playing_card
    j.ability.tower_return_to_jokers = true
    table.insert(G.playing_cards, j)
end

function Tower.UncardifyJoker(j)
    G.deck:remove_card(j)
    G.jokers:emplace(j)
    j.playing_card = nil
    j.ability.tower_return_to_jokers = false
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

function Tower.FormatArrowMult(arrows, mult)
    if Entropy and Entropy.FormatArrowMult then -- yoinked from Entropy so just fall back if exists
        return Entropy.FormatArrowMult(arrows, mult)
    end
    mult = type(mult) ~= "string" and number_format(mult) or mult
    if to_big(arrows) <= to_big(-2.01) then
        return "{"..arrows.."}"..mult
    end
    if to_big(arrows) < to_big(-1.1) then 
        return "="..mult 
    elseif to_big(arrows) < to_big(-0.1) then 
        return "+"..mult 
    elseif to_big(arrows) < to_big(6) then 
        if to_big(arrows) < to_big(1) then
            return "X"..mult
        end
        local arr = ""
        for i = 1, to_big(arrows):to_number() do
            arr = arr.."^"
        end
        return arr..mult
    else
        return "{"..arrows.."}"..mult
    end
end



function Tower.JokerBoosters(conf)
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
        create_card = function(self, card)
            if
                (not G.GAME.used_jokers[conf.soul_card]) or next(find_joker("Showman"))
            then
                if pseudorandom(conf.key .. G.GAME.round_resets.ante) > 0.997 then
                    return create_card(conf.type, G.pack_cards, nil, nil, true, true, conf.soul_card, nil)
                end
            end
            return create_card(conf.type, G.pack_cards, nil, nil, true, true, nil, conf.type)
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
                local ccard = create_card(conf.type, G.jokers, nil, nil, true, true, nil, "diha")
                ccard:set_edition({ negative = true }, true)
                ccard:add_to_deck()
                G.jokers:emplace(ccard) --Note: Will break if any non-Joker gets added to the meme pool
            end,
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
function Tower.Joker(object)
    object.order = (object.order or 0) + ((rarityOrderModifiers[object.rarity] or 10) * 1000)
    if object.pools then
        if object.pools['Tower-Slime'] then
            object.order = object.order + (poolOrder.slime + 100)
        end
    end
    if object.rarity == "cry_exotic" then
        object.tower_orig_rarity = object.rarity
    end
    return old_tower_joker(object)
end