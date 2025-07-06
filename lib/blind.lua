G.tower_unknown = '???'

local old_rep = string.rep;
string.rep = function (str, amount) 
    if amount == G.tower_unknown then
        return G.tower_unknown
    else
        return old_rep(str, amount)
    end
end

local ffffffffff = G.FUNCS.cry_asc_UI_set;
G.FUNCS.cry_asc_UI_set = function(e)
    ffffffffff(e)
	if G.GAME.tower_exploit_override then
		e.config.object.colours = { darken(G.C.SECONDARY_SET.Code, 0.2) }
    end
	e.config.object:update_text()
end

local htuis = G.FUNCS.hand_text_UI_set;
G.FUNCS.hand_text_UI_set = function(e)
    htuis(e)
    if G.GAME.tower_exploit_override then
        e.config.object.colours = { G.C.SECONDARY_SET.Code }
    else
        e.config.object.colours = { G.C.UI.TEXT_LIGHT }
    end
    e.config.object:update_text()
end

local function remove_from_table(tabl, items, given_indices)
    local indices = {}
    if not given_indices then
        for i, v in pairs(items) do
            for q, z in pairs(tabl) do
                if z == v then
                    indices[#indices+1] = Q
                    break;
                end
            end
        end
    else
        indices = items
    end
    table.sort(indices)
    for i, v in pairs(indices) do
        v = v - i
        table.remove(tabl, v)
    end
end

Tower.DestroyCardsBeforePlay = function (cards)
    SMODS.destroy_cards(cards)
    remove_from_table(G.hand.cards, cards, false)
    remove_from_table(G.hand.highlighted, cards, false)
end

local start_run = Game.start_run
function Game:start_run(args)
    local value = start_run(self, args)
    for i, v in pairs(G.P_BLINDS) do 
        if v.tower_center_requires then
            for q, z in ipairs(v.tower_center_requires) do
                if not G.P_CENTERS[z] then
                    G.GAME.banned_keys[q] = true
                    break
                end
            end
        end
    end
    return value
end

function registerBlindMethod(name, def)
    Blind[name] = function (self, ...)
        if self.config.blind ~= nil and self.config.blind.key ~= nil then
            local bl = G.P_BLINDS[self.config.blind.key]
            if (bl ~= nil and bl[name]) then
                return bl[name](bl, ...)
            end
        end
        return def(self, ...)
    end
end

registerBlindMethod('TowerCheckWin', function (self)
    return G.GAME.chips - G.GAME.blind.chips >= to_big(0)
end)

registerBlindMethod('TowerCheckRoundTimeout', function (self)
    return G.GAME.current_round.hands_left < 1
end)

registerBlindMethod('TowerCheckRoundEnd', function (self)
    return self:TowerCheckWin() or self:TowerCheckRoundTimeout(self)
end)

registerBlindMethod('TowerDrawCard', function (self)
    return true
end)

registerBlindMethod('TowerModFinalScore', function (self, score, cards, poker_hands, hand, scoring_hand, mult, hand_chips)
    return score
end)

registerBlindMethod('TowerModChips', function (self, chips)
    return chips
end)

registerBlindMethod('TowerModMult', function (self, mult)
    return mult
end)

local old_emplace = CardArea.emplace;
function CardArea:emplace(card, location, stay_flipped) 
    if self.config.type == 'hand' then
        if not G.GAME.blind:TowerDrawCard(card, location, stay_flipped) then
            return
        end
    end
    if not card then return end
    return old_emplace(self, card, location, stay_flipped)
end

Tower.PerscribeBoss = function (ante, slot, boss) 
    G.GAME.tower_perscribed_bosses = G.GAME.tower_perscribed_bosses or {
    }
    G.GAME.tower_perscribed_bosses[ante] = G.GAME.tower_perscribed_bosses[ante] or {
        nil, nil, nil
    }
    G.GAME.tower_perscribed_bosses[ante][slot + 1] = boss
end

function Blind:TowerBeforeBlindSet(blind, reset, silent) -- manual def as registerBlindMethod doesnt work as it relies on name being set (before set_blind happens it isnt)
    if blind == nil then return true end
    if blind.TowerBeforeBlindSet then
        return blind.TowerBeforeBlindSet(self, blind, reset, silent)
    end
    return blind
end

function Blind:TowerGetSlot() -- no reason to override this like at all
    if G.GAME.blind_on_deck == 'Small' then
        return 0
    elseif G.GAME.blind_on_deck == 'Big' then
        return 1
    else
        return 2
    end
end

local old_score = SMODS.score_card
function SMODS.score_card(card, context)
    if G.GAME.tower_eclipse_no_trigger or card.ability.tower_notrigger then
        return
    end
    return old_score(card, context)
end

local init_game = G.init_game_object

G.get_inc_stake_ante = function()
    return math.floor(G.GAME.win_ante / 8)
end

G.get_half_ante = function()
    return math.floor(G.GAME.win_ante / 2)
end

function Tower.getBlinds(f, amount, seed)
    local pool = {}
    local ret = {}
    amount = amount or 1
    for i, v in pairs(G.P_BLINDS) do 
        if f(v) then pool[#pool+1] = v end
    end
    if #pool == 0 then
        for i = 1, amount do
            ret[#ret+1] = G.P_BLINDS['bl_tower_blank']
        end
        return ret
    end
    for i = 1, amount do
        local elem, ind = pseudorandom_element(pool, seed)
        table.remove(pool, ind)
        ret[#ret+1] = elem
    end
    return ret
end

local old_set = Blind.set_blind
function Blind:set_blind(blind, x, y)
    old_set(self, blind, x, y)
    if G.GAME.tower_machinecode_old_ante then
        G.GAME.round_resets.ante = G.GAME.tower_machinecode_old_ante;
        G.GAME.tower_machinecode_old_ante = nil
    end
end

function get_new_boss(level)
    local inc_stake_ante = G.get_inc_stake_ante();
    local half_ante = G.get_half_ante();
    if level == nil then
        level = 2
    end
    local blind_slot = level;

	--Fix an issue with adding bosses mid-run
	for k, v in pairs(G.P_BLINDS) do
		if not G.GAME.bosses_used[k] then
			G.GAME.bosses_used[k] = 0
		end
	end

    if G.GAME.modifiers.tower_spectral_rate ~= nil and ((G.GAME.round_resets.ante) % G.GAME.modifiers.tower_spectral_rate == 0) then
        level = level + 2
        if level < 4 and G.GAME.modifiers.tower_tarot_rate == nil then
            level = level - 1
        end
    elseif G.GAME.modifiers.tower_tarot_rate ~= nil and ((G.GAME.round_resets.ante) % G.GAME.modifiers.tower_tarot_rate == 0) then
        level = level + 1
    end
    G.GAME.perscribed_bosses = G.GAME.perscribed_bosses or {
    }
    G.GAME.tower_perscribed_bosses = G.GAME.tower_perscribed_bosses or {
    }
    G.GAME.tower_perscribed_bosses[G.GAME.round_resets.ante] = G.GAME.tower_perscribed_bosses[G.GAME.round_resets.ante] or {nil, nil, nil}
    if G.GAME.perscribed_bosses and G.GAME.perscribed_bosses[G.GAME.round_resets.ante] and blind_slot == 2 then
        G.GAME.tower_perscribed_bosses[G.GAME.round_resets.ante][3] = G.GAME.perscribed_bosses[G.GAME.round_resets.ante] -- make perscribed_bosses work while allowing finer control w/tower perscribed
        G.GAME.perscribed_bosses[G.GAME.round_resets.ante] = nil
    end
    if G.GAME.tower_perscribed_bosses[G.GAME.round_resets.ante][blind_slot + 1] ~= nil then
        local ret_boss = G.GAME.tower_perscribed_bosses[G.GAME.round_resets.ante][blind_slot + 1]
        G.GAME.tower_perscribed_bosses[G.GAME.round_resets.ante][blind_slot + 1] = nil
        G.GAME.bosses_used[ret_boss] = G.GAME.bosses_used[ret_boss] + 1
        return ret_boss
    end

    if G.FORCE_BOSS then return G.FORCE_BOSS end
    
    local eligible_bosses = {}
    function mainLoop()
        function tryagain()
            G.TowerApplyOverrides(function (k, v)
                if not v.boss then
                elseif v.boss.level == level and ((not v.TowerInPool) or v.TowerInPool(v)) then
                    eligible_bosses[k] = true
                end
            end)
            for k, v in pairs(G.GAME.banned_keys) do
                if eligible_bosses[k] then eligible_bosses[k] = nil end
            end
        end
        if (pseudorandom(pseudoseed("levelminusone")) < (1 / 10)) then -- 1 in 10 for level -1
            for k, v in pairs(G.P_BLINDS) do
                if v.boss then
                    if v.boss.level == -1 and ((not v.TowerInPool) or v.TowerInPool(v)) then
                        eligible_bosses[k] = true
                    end
                end
            end
            for k, v in pairs(G.GAME.banned_keys) do
                if eligible_bosses[k] then eligible_bosses[k] = nil end
            end
            local literallyanytrue = false;
            for k, v in pairs(eligible_bosses) do
                if v then
                    literallyanytrue = true
                    break
                end
            end
            if not literallyanytrue then -- to prevent blankage when 1 in 10 hits and all levelminusone blinds are banned
                eligible_bosses = {}
                tryagain()
            end
        else
            tryagain()
        end
    end
    
    if pseudorandom('tower_boss_soul_'..G.GAME.round_resets.ante) > 0.997 then
        G.TowerApplyOverrides(function (k, v)
            if not v.boss then
            elseif v.boss.soul_level == level and ((not v.TowerInPool) or v.TowerInPool(v)) then
                eligible_bosses[k] = true
            end
        end)

        for k, v in pairs(G.GAME.banned_keys) do
            if eligible_bosses[k] then eligible_bosses[k] = nil end
        end

        if #eligible_bosses == 0 then
            mainLoop()
        end
    else
        mainLoop()
    end

    local min_use = 100
    for k, v in pairs(G.GAME.bosses_used) do
        if eligible_bosses[k] then
            eligible_bosses[k] = v
            if eligible_bosses[k] <= min_use then 
                min_use = eligible_bosses[k]
            end
        end
    end
    for k, v in pairs(eligible_bosses) do
        if eligible_bosses[k] then
            if eligible_bosses[k] > min_use then 
                eligible_bosses[k] = nil
            end
        end
    end
    local _, boss = pseudorandom_element(eligible_bosses, pseudoseed('boss'))
    if G.GAME.bosses_used[boss] == nil then
        boss = "bl_tower_blank"
    end
    G.GAME.bosses_used[boss] = G.GAME.bosses_used[boss] + 1
    
    return boss
end
function Tower.blindFromOffset(offset)
    offset = offset - 1
    if offset < 0 then
        return "bl_tower_blank"
    elseif offset == 0 then
        return G.GAME.round_resets.blind_choices.Small
    elseif offset == 1 then
        return G.GAME.round_resets.blind_choices.Big
    elseif offset == 2 then
        return G.GAME.round_resets.blind_choices.Boss
    end
    -- offset is not this ante
    local ante = (math.floor(offset / 3) * 3) + G.GAME.round_resets.ante;
    local blindSlot = math.fmod(offset, 3)
    local old_ante = G.GAME.round_resets.ante;
    G.GAME.round_resets.ante = ante
    local boss = get_new_boss(blindSlot)
    Tower.PerscribeBoss(G.GAME.round_resets.ante, blindSlot, boss)
    G.GAME.round_resets.ante = old_ante
    return boss
end
local doNothing = function() end
G.TowerApplyOverrides = function (afterEach)
    afterEach = afterEach or doNothing;
    for k, v in pairs(G.P_BLINDS) do
        if v.boss then
            if v.boss.level == nil then
                if v.boss.showdown then
                    v.boss.level = 2
                    v.mult = v.mult * 1.5
                    v.dollars = 5
                else
                    v.boss.level = 1
                    v.dollars = 4
                end
            end
        end
        afterEach(k, v)
    end
end
G.TowerApplyOverrides()

function Tower.forceExploit(handtype)
    G.GAME.tower_exploit_override = handtype
end

local shatters = SMODS.shatters
function SMODS.shatters(card)
    if card.TowerShatter then
        return true
    end
    return shatters(card)
end


local old_toggle_shop = G.FUNCS.toggle_shop
G.FUNCS.toggle_shop = function(e)
    if G.GAME.tower_run_spend_all then
        if G.GAME.dollars >= to_big(0) then
            return
        end
        G.GAME.tower_run_spend_all = false
    end
    return old_toggle_shop(e)
end

local can_buy = G.FUNCS.can_buy
G.FUNCS.can_buy = function(e)
    if not G.GAME.tower_run_spend_all then
        return can_buy(e)
    end
    if ((G.GAME.dollars - G.GAME.bankrupt_at) < to_big(0)) and (e.config.ref_table.cost > 0) then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.ORANGE
        e.config.button = 'buy_from_shop'
    end
    if e.config.ref_parent and e.config.ref_parent.children.buy_and_use then
      if e.config.ref_parent.children.buy_and_use.states.visible then
        e.UIBox.alignment.offset.y = -0.6
      else
        e.UIBox.alignment.offset.y = 0
      end
    end
end

local can_buy_and_use = G.FUNCS.can_buy_and_use
G.FUNCS.can_buy_and_use = function(e)
    if not G.GAME.tower_run_spend_all then
        return can_buy_and_use(e)
    end
    if ((((G.GAME.dollars - G.GAME.bankrupt_at) < to_big(0)) and (e.config.ref_table.cost > 0)) or (not e.config.ref_table:can_use_consumeable())) then
        e.UIBox.states.visible = false
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        if e.config.ref_table.highlighted then
          e.UIBox.states.visible = true
        end
        e.config.colour = G.C.SECONDARY_SET.Voucher
        e.config.button = 'buy_from_shop'
    end
end

local can_reedem = G.FUNCS.can_redeem
G.FUNCS.can_redeem = function(e)
    if not G.GAME.tower_run_spend_all then
        return can_reedem(e)
    end
    if ((G.GAME.dollars - G.GAME.bankrupt_at) < to_big(0)) and (e.config.ref_table.cost > 0) then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.GREEN
        e.config.button = 'use_card'
    end
end

local can_open = G.FUNCS.can_open
G.FUNCS.can_open = function(e)
    if not G.GAME.tower_run_spend_all then
        return can_open(e)
    end
    if ((G.GAME.dollars - G.GAME.bankrupt_at) < to_big(0)) and (e.config.ref_table.cost > 0) then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.GREEN
        e.config.button = 'use_card'
    end
end

function Tower.ObsidianOrb(info)
    info = info or {}

    return {
        name = info.name,
        key = info.key,
        pos = info.pos,
        dollars = info.dollars,
        boss = info.boss,
        atlas = info.atlas,
        order = info.order,
        mult = info.mult,
        boss_colour = info.boss_colour,
        pick = info.pick,
        cleanup = info.cleanup or (function () end),
        tower_is_code = info.tower_is_code,
        tower_is_planet = info.tower_is_planet,
        tower_is_spectral = info.tower_is_spectral,
        debuff_text = info.debuff_text,
        set_blind = function(self, reset, silent)
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.set_blind then
                    s:set_blind(reset, silent)
                end
                if s.name == "The Eye" and not reset then
                    G.GAME.blind.hands = {
                        ["Flush Five"] = false,
                        ["Flush House"] = false,
                        ["Five of a Kind"] = false,
                        ["Straight Flush"] = false,
                        ["Four of a Kind"] = false,
                        ["Full House"] = false,
                        ["Flush"] = false,
                        ["Straight"] = false,
                        ["Three of a Kind"] = false,
                        ["Two Pair"] = false,
                        ["Pair"] = false,
                        ["High Card"] = false,
                    }
                end
                if s.name == "The Mouth" and not reset then
                    G.GAME.blind.only_hand = false
                end
                if s.name == "The Fish" and not reset then
                    G.GAME.blind.prepped = nil
                end
                if s.name == "The Water" and not reset then
                    G.GAME.blind.discards_sub = G.GAME.current_round.discards_left
                    ease_discard(-G.GAME.blind.discards_sub)
                end
                if s.name == "The Needle" and not reset then
                    G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
                    ease_hands_played(-G.GAME.blind.hands_sub)
                end
                if s.name == "The Manacle" and not reset then
                    G.hand:change_size(-1)
                end
                if s.name == "Amber Acorn" and not reset and #G.jokers.cards > 0 then
                    G.jokers:unhighlight_all()
                    for k, v in ipairs(G.jokers.cards) do
                        v:flip()
                    end
                    if #G.jokers.cards > 1 then
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.2,
                            func = function()
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.jokers:shuffle("aajk")
                                        play_sound("cardSlide1", 0.85)
                                        return true
                                    end,
                                }))
                                delay(0.15)
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.jokers:shuffle("aajk")
                                        play_sound("cardSlide1", 1.15)
                                        return true
                                    end,
                                }))
                                delay(0.15)
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.jokers:shuffle("aajk")
                                        play_sound("cardSlide1", 1)
                                        return true
                                    end,
                                }))
                                delay(0.5)
                                return true
                            end,
                        }))
                    end
                end

                --add new debuffs
                for _, v in ipairs(G.playing_cards) do
                    self:debuff_card(v)
                end
                for _, v in ipairs(G.jokers.cards) do
                    if not reset then
                        self:debuff_card(v, true)
                    end
                end
            end
        end,
        defeat = function(self, silent)
            for k, _ in pairs(self.pick()) do
                if G.P_BLINDS[k].defeat then
                    G.P_BLINDS[k]:defeat(silent)
                end
                if G.P_BLINDS[k].name == "The Manacle" and not self.disabled then
                    G.hand:change_size(1)
                end
            end
            self.cleanup()
        end,
        disable = function(self, silent)
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.disable then
                    s:disable(silent)
                end
                if s.name == "The Water" then
                    ease_discard(G.GAME.blind.discards_sub)
                end
                if s.name == "The Wheel" or s.name == "The House" or s.name == "The Mark" or s.name == "The Fish" then
                    for i = 1, #G.hand.cards do
                        if G.hand.cards[i].facing == "back" then
                            G.hand.cards[i]:flip()
                        end
                    end
                    for k, v in pairs(G.playing_cards) do
                        v.ability.wheel_flipped = nil
                    end
                end
                if s.name == "The Needle" then
                    ease_hands_played(G.GAME.blind.hands_sub)
                end
                if s.name == "The Wall" then
                    G.GAME.blind.chips = G.GAME.blind.chips / 2
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                end
                if s.name == "Cerulean Bell" then
                    for k, v in ipairs(G.playing_cards) do
                        v.ability.forced_selection = nil
                    end
                end
                if s.name == "The Manacle" then
                    G.hand:change_size(1)

                    G.FUNCS.draw_from_deck_to_hand(1)
                end
                if s.name == "Violet Vessel" then
                    G.GAME.blind.chips = G.GAME.blind.chips / 3
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                end
            end
        end,
        press_play = function(self)
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.press_play then
                    s:press_play()
                end
                if s.name == "The Hook" then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local any_selected = nil
                            local _cards = {}
                            for k, v in ipairs(G.hand.cards) do
                                _cards[#_cards + 1] = v
                            end
                            for i = 1, 2 do
                                if G.hand.cards[i] then
                                    local selected_card, card_key = pseudorandom_element(_cards, pseudoseed("ObsidianOrb"))
                                    G.hand:add_to_highlighted(selected_card, true)
                                    table.remove(_cards, card_key)
                                    any_selected = true
                                    play_sound("card1", 1)
                                end
                            end
                            if any_selected then
                                G.FUNCS.discard_cards_from_highlighted(nil, true)
                            end
                            return true
                        end,
                    }))
                    G.GAME.blind.triggered = true
                    delay(0.7)
                end
                if s.name == "Crimson Heart" then
                    if G.jokers.cards[1] then
                        G.GAME.blind.triggered = true
                        G.GAME.blind.prepped = true
                    end
                end
                if s.name == "The Fish" then
                    G.GAME.blind.prepped = true
                end
                if s.name == "The Tooth" then
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.2,
                        func = function()
                            for i = 1, #G.play.cards do
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.play.cards[i]:juice_up()
                                        return true
                                    end,
                                }))
                                ease_dollars(-1)
                                delay(0.23)
                            end
                            return true
                        end,
                    }))
                    G.GAME.blind.triggered = true
                end
            end
        end,
        modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
            local new_mult = mult
            local new_chips = hand_chips
            local trigger = false
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.modify_hand then
                    local this_trigger = false
                    new_mult, new_chips, this_trigger = s:modify_hand(cards, poker_hands, text, new_mult, new_chips)
                    trigger = trigger or this_trigger
                end
                if s.name == "The Flint" then
                    G.GAME.blind.triggered = true
                    new_mult = math.max(math.floor(new_mult * 0.5 + 0.5), 1)
                    new_chips = math.max(math.floor(new_chips * 0.5 + 0.5), 0)
                    trigger = true
                end
            end
            return new_mult or mult, new_chips or hand_chips, trigger
        end,
        debuff_hand = function(self, cards, hand, handname, check)
            G.GAME.blind.debuff_boss = nil
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.debuff_hand and s:debuff_hand(cards, hand, handname, check) then
                    G.GAME.blind.debuff_boss = s
                    return true
                end
                if s.debuff then
                    G.GAME.blind.triggered = false
                    if s.debuff.hand and next(hand[s.debuff.hand]) then
                        G.GAME.blind.triggered = true
                        G.GAME.blind.debuff_boss = s
                        return true
                    end
                    if s.debuff.h_size_ge and #cards < s.debuff.h_size_ge then
                        G.GAME.blind.triggered = true
                        G.GAME.blind.debuff_boss = s
                        return true
                    end
                    if s.debuff.h_size_le and #cards > s.debuff.h_size_le then
                        G.GAME.blind.triggered = true
                        G.GAME.blind.debuff_boss = s
                        return true
                    end
                    if s.name == "The Eye" then
                        if G.GAME.blind.hands[handname] then
                            G.GAME.blind.triggered = true
                            G.GAME.blind.debuff_boss = s
                            return true
                        end
                        if not check then
                            G.GAME.blind.hands[handname] = true
                        end
                    end
                    if s.name == "The Mouth" then
                        if s.only_hand and s.only_hand ~= handname then
                            G.GAME.blind.triggered = true
                            G.GAME.blind.debuff_boss = s
                            return true
                        end
                        if not check then
                            s.only_hand = handname
                        end
                    end
                end
                if s.name == "The Arm" then
                    G.GAME.blind.triggered = false
                    if to_big(G.GAME.hands[handname].level) > to_big(1) then
                        G.GAME.blind.triggered = true
                        if not check then
                            level_up_hand(G.GAME.blind.children.animatedSprite, handname, nil, -1)
                            G.GAME.blind:wiggle()
                        end
                    end
                end
                if s.name == "The Ox" then
                    G.GAME.blind.triggered = false
                    if handname == G.GAME.current_round.most_played_poker_hand then
                        G.GAME.blind.triggered = true
                        if not check then
                            ease_dollars(-G.GAME.dollars, true)
                            G.GAME.blind:wiggle()
                        end
                    end
                end
            end
            return false
        end,
        drawn_to_hand = function(self)
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.drawn_to_hand then
                    s:drawn_to_hand()
                end
                if s.name == "Cerulean Bell" then
                    local any_forced = nil
                    for k, v in ipairs(G.hand.cards) do
                        if v.ability.forced_selection then
                            any_forced = true
                        end
                    end
                    if not any_forced then
                        G.hand:unhighlight_all()
                        local forced_card = pseudorandom_element(G.hand.cards, pseudoseed("ObsidianOrb"))
                        forced_card.ability.forced_selection = true
                        G.hand:add_to_highlighted(forced_card)
                    end
                end
                if s.name == "Crimson Heart" and G.GAME.blind.prepped and G.jokers.cards[1] then
                    local jokers = {}
                    for i = 1, #G.jokers.cards do
                        if not G.jokers.cards[i].debuff or #G.jokers.cards < 2 then
                            jokers[#jokers + 1] = G.jokers.cards[i]
                        end
                        G.jokers.cards[i]:set_debuff(false)
                    end
                    local _card = pseudorandom_element(jokers, pseudoseed("ObsidianOrb"))
                    if _card then
                        _card:set_debuff(true)
                        _card:juice_up()
                        G.GAME.blind:wiggle()
                    end
                end
            end
        end,
        stay_flipped = function(self, area, card)
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.stay_flipped and s:stay_flipped(area, card) then
                    return true
                end
                if area == G.hand then
                    if
                        s.name == "The Wheel"
                        and pseudorandom(pseudoseed("ObsidianOrb")) < G.GAME.probabilities.normal / 7
                    then
                        return true
                    end
                    if
                        s.name == "The House"
                        and G.GAME.current_round.hands_played == 0
                        and G.GAME.current_round.discards_used == 0
                    then
                        return true
                    end
                    if s.name == "The Mark" and card:is_face(true) then
                        return true
                    end
                    if s.name == "The Fish" and G.GAME.blind.prepped then
                        return true
                    end
                end
            end
        end,
        debuff_card = function(self, card, from_blind)
            if card and type(card) == "table" and card.area then
                for k, _ in pairs(self.pick()) do
                    s = G.P_BLINDS[k]
                    if s.debuff_card then
                        s:debuff_card(card, from_blind)
                    end
                    if s.debuff and not G.GAME.blind.disabled and card.area ~= G.jokers then
                        --this part is buggy for some reason
                        if s.debuff.suit and Card.is_suit(card, s.debuff.suit, true) then
                            card:set_debuff(true)
                            return
                        end
                        if s.debuff.is_face == "face" and Card.is_face(card, true) then
                            card:set_debuff(true)
                            return
                        end
                        if s.name == "The Pillar" and card.ability.played_this_ante then
                            card:set_debuff(true)
                            return
                        end
                        if s.debuff.value and s.debuff.value == card.base.value then
                            card:set_debuff(true)
                            return
                        end
                        if s.debuff.nominal and s.debuff.nominal == card.base.nominal then
                            card:set_debuff(true)
                            return
                        end
                    end
                    if s.name == "Crimson Heart" and not G.GAME.blind.disabled and card.area == G.jokers then
                        return
                    end
                    if s.name == "Verdant Leaf" and not G.GAME.blind.disabled and card.area ~= G.jokers then
                        card:set_debuff(true)
                        return
                    end
                end
            end
        end,
        cry_ante_base_mod = function(self, dt)
            local mod = 0
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.cry_ante_base_mod then
                    mod = mod + s:cry_ante_base_mod(dt)
                end
            end
            return mod
        end,
        cry_round_base_mod = function(self, dt)
            local mod = 1
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.cry_round_base_mod then
                    mod = mod * s:cry_round_base_mod(dt)
                end
            end
            return mod
        end,
        cry_cap_score = function(self, score)
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.cry_cap_score then
                    score = s:cry_cap_score(score)
                end
            end
            return score
        end,
        cry_calc_ante_gain = function(self)
            local ante = 1
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.cry_calc_ante_gain then
                    ante = math.max(ante, s:cry_calc_ante_gain())
                end
            end
            return ante
        end,
        cry_before_play = function(self)
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.cry_before_play then
                    s:cry_before_play()
                end
            end
        end,
        cry_after_play = function(self)
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.cry_after_play then
                    s:cry_after_play()
                end
            end
        end,
        cry_before_cash = function(self)
            local decision_made = false
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.cry_before_cash then
                    decision_made = true
                    s:cry_before_cash()
                end
            end
            if not decision_made then
                G.GAME.cry_make_a_decision = nil
                G.STATE = G.STATES.ROUND_EVAL
                G.STATE_COMPLETE = false
            end
        end,
        get_loc_debuff_text = function(self)
            if not G.GAME.blind.debuff_boss then
                return localize(self.debuff_text)
            end
            local loc_vars = nil
            if G.GAME.blind.debuff_boss.name == "The Ox" then
                loc_vars = { localize(G.GAME.current_round.most_played_poker_hand, "poker_hands") }
            end
            local loc_target =
                localize({ type = "raw_descriptions", key = G.GAME.blind.debuff_boss.key, set = "Blind", vars = loc_vars })
            local loc_debuff_text = ""
            for k, v in ipairs(loc_target) do
                loc_debuff_text = loc_debuff_text .. v .. (k <= #loc_target and " " or "")
            end
            local disp_text = (G.GAME.blind.debuff_boss.name == "The Wheel" and G.GAME.probabilities.normal or "")
                .. loc_debuff_text
            if (G.GAME.blind.debuff_boss.name == "The Mouth") and G.GAME.blind.only_hand then
                disp_text = disp_text .. " [" .. localize(G.GAME.blind.only_hand, "poker_hands") .. "]"
            end
            return disp_text
        end,
        TowerCheckWin = function (self)
            local any = false;
            local result = true
            
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.TowerCheckWin then
                    result = result and s:TowerCheckWin()
                    if not result then break end
                end
            end

            if any then
                return result
            end
            return G.GAME.chips - G.GAME.blind.chips >= to_big(0)
        end,
        TowerCheckRoundTimeout = function (self)
            local any = false;
            local result = true
            
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.TowerCheckWin then
                    any = true
                    result = result and s:TowerCheckRoundTimeout()
                    if not result then break end
                end
            end

            if any then
                return result
            end
            return G.GAME.current_round.hands_left < 1
        end,
        TowerCheckRoundEnd = function (self)
            local any = false;
            local result = true
            
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.TowerCheckRoundEnd then
                    any = true
                    result = result and s:TowerCheckRoundEnd()
                    if not result then break end
                end
            end

            if any then
                return result
            end
            return self:TowerCheckWin() or self:TowerCheckRoundTimeout()
        end,
        TowerModFinalScore = function (self, score, cards, poker_hands, hand, scoring_hand, mult, hand_chips)
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.TowerModFinalScore then
                    score = s:TowerModFinalScore(score, cards, poker_hands, hand, scoring_hand, mult, hand_chips)
                end
            end

            return score
        end,
        TowerModChips = function (self, chips)
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.TowerModChips then
                    chips = s:TowerModChips(chips)
                end
            end

            return chips
        end,
        TowerModMult = function (self, mult)
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.TowerModMult then
                    mult = s:TowerModMult(mult)
                end
            end

            return mult
        end,
        TowerDrawCard = function (self, card, location, stay_flipped)
            local any = true
            for k, _ in pairs(self.pick()) do
                s = G.P_BLINDS[k]
                if s.TowerDrawCard then
                    if not s:TowerDrawCard(card, location, stay_flipped) then
                        any = false
                    end
                end
            end
            return any
        end,
        TowerInPool = info.TowerInPool,
    }
end


SMODS.Blind:take_ownership('bl_cry_obsidian_orb', Tower.ObsidianOrb({
    pick = function () return G.GAME.defeated_blinds or {} end,
    debuff_text = 'cry_debuff_obsidian_orb'
}))