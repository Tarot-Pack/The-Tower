local emperor_selection = {
    misc = {},
    multchips = {},
    suits = {},
}

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-fool",
	key = "fool",
	pos = { x = 0, y = 1 },
	atlas = "blinds",
	order = 1,
    mult = 4,
    boss_colour = HEX("ff9d96"),
    boss = {
        level = 3
    },
    dollars = 8,
    TowerCheckWin = function (self)
        return (G.GAME.chips - (G.GAME.blind.chips * to_big(0.8)) >= to_big(0) -- more or equal to 80% 
            and G.GAME.chips - (G.GAME.blind.chips * to_big(1)) <= to_big(0)) -- less than or equal to 100%
            and G.GAME.current_round.hands_left < 1 -- use all hands 
    end,
    TowerCheckRoundTimeout = function (self)
        return G.GAME.chips - G.GAME.blind.chips > to_big(0) -- instant loss
    end,
	loc_vars = function()
		return { vars = { 
            "80% of blind size",
            "blind size",
         } }
    end
})
emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_fool'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-wheel",
	key = "wheel",
	pos = { x = 0, y = 2 },
	atlas = "blinds",
	order = 1,
    mult = 4,
    boss_colour = HEX("25b900"),
    boss = {
        level = 3
    },
    dollars = 8,
	loc_vars = function(self)
		return { vars = { "" .. (G.GAME.probabilities.normal), 4 } }
	end,
	collection_loc_vars = function(self)
		return { vars = { 1, 4 } }
	end,

	debuff_hand = function(self, cards, hand, handname, check)
		if
			not check
			and (pseudorandom(pseudoseed("wofour")) > ((G.GAME.probabilities.normal) / 4))
			and not G.GAME.blind.disabled
		then
			G.GAME.blind.triggered = true
			return true
		end
		return false
	end
})
emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_wheel'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-tower",
	key = "tower",
	pos = { x = 0, y = 3 },
	atlas = "blinds",
	order = 1,
    mult = 4 + 1,
    boss_colour = HEX("4061a4"),
    boss = {
        level = 3
    },
    dollars = 8,

	calculate = function(self, blind, context)
        if G.GAME.blind.disabled then return end
		if
			context.full_hand
			and context.destroy_card
			and (context.cardarea == G.play or context.cardarea == "unscored")
			and not G.GAME.blind.disabled
		then
            G.GAME.blind:wiggle()
            G.GAME.blind.triggered = true
			context.destroy_card:set_ability(G.P_CENTERS.m_tower_crystal, true, nil)
            return
		end
		if context.discard then
            G.GAME.blind:wiggle()
            G.GAME.blind.triggered = true
            for i, card in ipairs(G.hand.highlighted) do
                card:set_ability(G.P_CENTERS.m_stone, true, nil)
            end
		end
	end,

    defeat = function (self)
        Tower.achieve("sus_victory")
    end
})
emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_tower'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-hermit",
	key = "hermit",
	pos = { x = 0, y = 9 },
	atlas = "blinds",
	order = 1,
    mult = 4,
    boss_colour = HEX("317a20"),
    boss = {
        level = 3
    },
    dollars = 8,
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        local trigger = false;
		if G.GAME.current_round.discards_left > 0 then
			G.GAME.blind.triggered = true
			mult = math.floor(mult / math.pow(2, G.GAME.current_round.discards_left))
            trigger = true
		end
		if G.GAME.current_round.hands_left > 0 then
			G.GAME.blind.triggered = true
            hand_chips = math.floor(hand_chips / math.pow(2, G.GAME.current_round.hands_left))
            trigger = true
		end
		return mult, hand_chips, trigger
	end,
})
emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_hermit'


-- suit blinds
SMODS.Blind({
	tower_is_tarot = true,
    name = "tower-sun",
    key = "sun",
    pos = { x = 0, y = 10 },
    atlas = "blinds",
    order = 1,
    mult = 4,
    boss_colour = HEX('f03463'),
    boss = {
        level = 3
    },
    dollars = 8,
    debuff_hand = function(self, cards, hand, handname, check)
        local bad = false;
        if G.GAME.blind.disabled then return false end
        for i = 1, #cards do
            if not cards[i]:is_suit('Hearts') then
                bad = true
                break;
            end
        end
        if bad then
			G.GAME.blind.triggered = true
        end
        return bad
    end,

    get_loc_debuff_text = function(self)
        return localize("tower_debuff_hearts")
    end,
})
emperor_selection.suits[#emperor_selection.suits+1] = 'bl_tower_sun'
SMODS.Blind({
	tower_is_tarot = true,
    name = "tower-moon",
    key = "moon",
    pos = { x = 0, y = 11 },
    atlas = "blinds",
    order = 1,
    mult = 4,
    boss_colour = HEX('275955'),
    boss = {
        level = 3
    },
    dollars = 8,
    debuff_hand = function(self, cards, hand, handname, check)
        local bad = false;
        if G.GAME.blind.disabled then return false end
        for i = 1, #cards do
            if not cards[i]:is_suit('Clubs') then
                bad = true
                break;
            end
        end
        if bad then
			G.GAME.blind.triggered = true
        end
        return bad
    end,

    get_loc_debuff_text = function(self)
        return localize("tower_debuff_moon")
    end,
})
emperor_selection.suits[#emperor_selection.suits+1] = 'bl_tower_moon'
SMODS.Blind({
	tower_is_tarot = true,
    name = "tower-world",
    key = "world",
    pos = { x = 0, y = 12 },
    atlas = "blinds",
    order = 1,
    mult = 4,
    boss_colour = HEX('413995'),
    boss = {
        level = 3
    },
    dollars = 8,
    debuff_hand = function(self, cards, hand, handname, check)
        local bad = false;
        if G.GAME.blind.disabled then return false end
        for i = 1, #cards do
            if not cards[i]:is_suit('Spades') then
                bad = true
                break;
            end
        end
        if bad then
			G.GAME.blind.triggered = true
        end
        return bad
    end,

    get_loc_debuff_text = function(self)
        return localize("tower_debuff_world")
    end,
})
emperor_selection.suits[#emperor_selection.suits+1] = 'bl_tower_world'
SMODS.Blind({
	tower_is_tarot = true,
    name = "tower-star",
    key = "star",
    pos = { x = 0, y = 13 },
    atlas = "blinds",
    order = 1,
    mult = 4,
    boss_colour = HEX('f06b3f'),
    boss = {
        level = 3
    },
    dollars = 8,
    debuff_hand = function(self, cards, hand, handname, check)
        local bad = false;
        if G.GAME.blind.disabled then return false end
        for i = 1, #cards do
            if not cards[i]:is_suit('Diamonds') then
                bad = true
                break;
            end
        end
        if bad then
			G.GAME.blind.triggered = true
        end
        return bad
    end,

    get_loc_debuff_text = function(self)
        return localize("tower_debuff_star")
    end,
})
emperor_selection.suits[#emperor_selection.suits+1] = 'bl_tower_star'
-- all suit blind

SMODS.Blind({
	tower_is_tarot = true,
    name = "tower-lovers",
    key = "lovers",
    pos = { x = 0, y = 0 },
    atlas = "blind_lovers",
    order = 1,
    mult = 4,
    boss_colour = HEX('ef838b'),
    boss = {
        level = 3
    },
    dollars = 8,
    debuff_hand = function(self, cards, hand, handname, check)
        if G.GAME.blind.disabled then return false end
        local currentlyHave = {}
        local needed = 0;
        local got = 0;
        for i,v in pairs(G.COLLABS.options) do
            currentlyHave[i] = false
            needed = needed + 1
        end
        currentlyHave['cry_abstract'] = false
        needed = needed + 1
        for i = 1, #cards do
            for k,v in pairs(currentlyHave) do
                if k == 'cry_abstract' and not v then
                    if (
                        (cards[i].ability.name == "Wild Card" and not cards[i].debuff) or cards[i]:is_suit(G.GAME.tower_sigil_suit) -- wild detection (check if wild directly and call back on suit check that will only work for wild-acting cards)
                        or SMODS.has_enhancement(cards[i], "m_cry_abstract")
                    ) then
                        currentlyHave[k] = true
                        got = got + 1
                    end
                elseif not v and cards[i]:is_suit(k) then
                    currentlyHave[k] = true
                    got = got + 1
                end
            end
        end
        if got < needed then
            G.GAME.blind.triggered = true
            G.tower_lovers_have = currentlyHave -- no need to save this
        end
        return got < needed
    end,

    get_loc_debuff_text = function(self)
        local missing = {}
        if G.tower_lovers_have == nil then
            return localize("tower_debuff_lovers")
        end
        for i, v in pairs(G.tower_lovers_have) do
            if not v then
                missing[#missing+1] = localize(i, "suits_plural")
            end
        end
        local text = localize("tower_debuff_lovers_missing")
        for i, v in ipairs(missing) do
            text = text .. v;
            if i ~= #missing then
                text = text .. ', '
            end
        end
        return text
    end,
})
emperor_selection.suits[#emperor_selection.suits+1] = 'bl_tower_lovers'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-temperance",
	key = "temperance",
	pos = { x = 0, y = 14 },
	atlas = "blinds",
	order = 1,
    mult = 4,
    boss_colour = HEX("98258b"),
    boss = {
        level = 3
    },
    dollars = 8,
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        if G.GAME.blind.disabled then return mult, hand_chips end
        local money = 0;
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.set == 'Joker' then
                money = money + G.jokers.cards[i].sell_cost
            end
        end
        G.GAME.blind.triggered = true

        if money == 0 then 
            return 0, 0, true
        end
        mult = math.floor(mult / money)
        hand_chips = math.floor(hand_chips / money)
		return mult, hand_chips, true
	end,
})
emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_temperance'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-magician",
	key = "magician",
	pos = { x = 0, y = 13 },
	atlas = "blinds2",
	order = 1,
    mult = 4,
    boss_colour = HEX("77e03a"),
    boss = {
        level = 3
    },
    dollars = 8,
	loc_vars = function(self)
		return { vars = { "" .. (G.GAME.probabilities.normal), 15, "" .. (G.GAME.probabilities.normal), 5 } }
	end,
    collection_loc_vars = function ()
		return { vars = { "" .. 1, 15, "" .. 1, 5 } }
    end,
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        if G.GAME.blind.disabled then return mult, hand_chips end
        local money = 0;
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.set == 'Joker' then
                money = money + G.jokers.cards[i].sell_cost
            end
        end
        local triggered = false;

        if pseudorandom(pseudoseed("levelminusone")) < (G.GAME.probabilities.normal / 15) then 
            ease_dollars(-G.GAME.dollars)
            triggered = true
        end

        if pseudorandom(pseudoseed("levelminusone")) < (G.GAME.probabilities.normal / 5) then 
            mult = 0
            triggered = true
        end
        if triggered then
            G.GAME.blind.triggered = true
        end
		return mult, hand_chips, triggered
	end,
})
emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_magician'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-hierophant",
	key = "hierophant",
	pos = { x = 0, y = 14 },
	atlas = "blinds2",
	order = 1,
    mult = 4,
    boss_colour = HEX("009dff"),
    boss = {
        level = 3
    },
    dollars = 8,
    TowerModMult = function (self, mult)
        if G.GAME.blind.disabled then return mult end
        return 1
    end
})
emperor_selection.multchips[#emperor_selection.multchips+1] = 'bl_tower_empress'
SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-empress",
	key = "empress",
	pos = { x = 0, y = 15 },
	atlas = "blinds2",
	order = 1,
    mult = 4,
    boss_colour = HEX("fe5f55"),
    boss = {
        level = 3
    },
    dollars = 8,
    TowerModChips = function (self, mult)
        if G.GAME.blind.disabled then return mult end
        return 1
    end
})

emperor_selection.multchips[#emperor_selection.multchips+1] = 'bl_tower_hierophant'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-justice",
	key = "justice",
	pos = { x = 0, y = 16 },
	atlas = "blinds2",
	order = 1,
    mult = 4,
    boss_colour = HEX("a0d7ce"),
    boss = {
        level = 3
    },
    dollars = 8,
	calculate = function(self, blind, context)
		if
			context.full_hand
			and context.destroy_card
			and (context.cardarea == G.play or context.cardarea == "unscored")
			and not G.GAME.blind.disabled
		then
            context.destroy_card.TowerShatter = true
			return { remove = not context.destroy_card.ability.eternal }
		end
    end
})

emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_justice'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-chariot",
	key = "chariot",
	pos = { x = 0, y = 17 },
	atlas = "blinds2",
	order = 1,
    mult = 4,
    boss_colour = HEX("76b1d7"),
    boss = {
        level = 3
    },
    dollars = 8,
    cry_before_play = function (self)
        if G.GAME.blind.disabled then return end
        G.GAME.TowerChariotClearDebuff = {}
        for i, v in ipairs(G.hand.highlighted) do
            if not v.debuff then
                G.GAME.TowerChariotClearDebuff[#G.GAME.TowerChariotClearDebuff+1] = v
            end
            v:set_debuff(true)
        end
        return 1
    end,
    cry_after_play = function (self)
        if G.GAME.blind.disabled then 
            G.GAME.TowerChariotClearDebuff = nil
            return 
        end
        for i, v in ipairs(G.GAME.TowerChariotClearDebuff) do
            v:set_debuff(false)
        end
        G.GAME.TowerChariotClearDebuff = nil
    end
})

emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_chariot'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-devil",
	key = "devil",
	pos = { x = 0, y = 18 },
	atlas = "blinds2",
	order = 1,
    mult = 4,
    boss_colour = HEX("ffb700"),
    boss = {
        level = 3
    },
    dollars = 8,
    
    TowerModChips = function (self, chips)
        if G.GAME.blind.disabled then return chips end
        chips = math.min(chips, math.max(G.GAME.dollars, 0))
        return chips
    end,
})


emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_devil'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-strength",
	key = "strength",
	pos = { x = 0, y = 19 },
	atlas = "blinds2",
	order = 1,
    mult = 4,
    boss_colour = HEX("ff003b"),
    boss = {
        level = 3
    },
    dollars = 8,
    
    cry_before_play = function (self)
        if G.GAME.blind.disabled then return end
        for k, v in ipairs(G.hand.cards) do
            SMODS.modify_rank(v, -pseudorandom(pseudoseed("tower_strength"), 1, 3))
        end
    end
})


emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_strength'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-hangedman",
	key = "hangedman",
	pos = { x = 0, y = 20 },
	atlas = "blinds2",
	order = 1,
    mult = 4,
    boss_colour = HEX("2a1f81"),
    boss = {
        level = 3
    },
    dollars = 8,

	debuff_hand = function(self, cards, hand, handname, check)
		if
			not G.GAME.blind.disabled
            and #cards < 3
		then
			G.GAME.blind.triggered = true
			return true
		end
		return false
	end,

	calculate = function(self, blind, context)
		if context.discard and not G.GAME.blind.disabled then
			for i, card in ipairs(G.hand.highlighted) do
				return { remove = not card.ability.eternal }
			end
		end
	end,
    press_play = function (self)        
        if G.GAME.blind.disabled then return end
        local card_pool = {}
        for i, v in ipairs(G.play.cards) do
            card_pool[#card_pool+1] = v
        end
        if #card_pool == 0 then return end
        local cards = {}
        for i = 1, math.min(2, #card_pool) do
            local q = pseudorandom(pseudoseed("tower_hangman"), 1, #card_pool)
            card_pool[q]:set_perishable(true)
            table.remove(card_pool, q)
        end
    end
})


emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_hangedman'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-judgement",
	key = "judgement",
	pos = { x = 0, y = 21 },
	atlas = "blinds2",
	order = 1,
    mult = 4,
    boss_colour = HEX("b26cbb"),
    boss = {
        level = 3
    },
    dollars = 8,
    
    set_blind = function (self, reset)
        if reset then return end
        pseudorandom_element(G.jokers.cards, pseudoseed('tower_judgement')).ability.tower_judgement_not_debuff = true
    end,
    recalc_debuff = function(self, card, from_blind)
        if G.GAME.blind.disabled then return false end
        if card.area ~= G.jokers then return false end
		return not card.ability.tower_judgement_not_debuff
	end,
    defeat = function ()
        for i = 1, #G.jokers.cards do
            G.jokers.cards[i].ability.tower_judgement_not_debuff = nil -- lil bro cannot keep this
        end
    end
})


emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_judgement'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-death",
	key = "death",
	pos = { x = 0, y = 22 },
	atlas = "blinds2",
	order = 1,
    mult = 4,
    boss_colour = HEX("b593ff"),
    boss = {
        level = 3
    },
    dollars = 8,
    
    cry_before_play = function ()
        if G.GAME.blind.disabled then return end
        if #G.hand.highlighted < 1 then return end
        if #G.hand.highlighted == 1 then 
            G.hand.highlighted[1]:set_edition("e_tower_truenegative", nil, true)
            SMODS.Stickers.tower_fuckyou:apply(G.hand.highlighted[1], true)
            return 
        end
        local cards = {}
        for i, v in ipairs(G.hand.cards) do
            if v.highlighted then
                cards[#cards+1] = v
            end
        end
        local copy = cards[#cards]
        for i = 1, #cards - 1 do
            local card = copy_card(copy, cards[i])
            card:set_edition("e_tower_truenegative", true, true)
        end
    end,
    disable = function ()
    end
})


emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_death'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-eclipse",
	key = "eclipse",
	pos = { x = 0, y = 6 },
	atlas = "blinds3",
	order = 1,
    mult = 4,
    boss_colour = HEX("4f00bf"),
    boss = {
        level = 3
    },
    dollars = 8,
    
    set_blind = function (self, reset)
        if reset then return end
        if G.GAME.blind.disabled then return end
        G.GAME.tower_eclipse_no_trigger = true
    end,
    defeat = function ()
        G.GAME.tower_eclipse_no_trigger = false
    end,
    disable = function ()
        G.GAME.tower_eclipse_no_trigger = false
    end,
})


emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_eclipse'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-seraph",
	key = "seraph",
	pos = { x = 0, y = 7 },
	atlas = "blinds3",
	order = 1,
    mult = 4,
    boss_colour = HEX("b593ff"),
    boss = {
        level = 3
    },
    dollars = 8,
    loc_vars = function(self, info_queue, card)
		return { vars = { 
            G.GAME.tower_seraph_play_cards or 5,
            0.25 * get_blind_amount(G.GAME.round_resets.ante) * 4 * G.GAME.starting_params.ante_scaling
        } }
	end,
    collection_loc_vars = function(self, info_queue, card)
		return { vars = { 
            "5",
            localize("tower_seraph_place")
        } }
	end,

	TowerModFinalScore = function(self, score)
        if G.GAME.blind.disabled then return score end
		return math.floor(math.min(0.25 * G.GAME.blind.chips, score) + 0.5)
	end,
    set_blind = function (self, reset)
        if G.GAME.blind.disabled then return end
        if reset then return end
        G.GAME.tower_seraph_play_cards = 5
    end,
    cry_after_play = function (self)
        G.GAME.tower_seraph_play_cards = G.GAME.tower_seraph_play_cards + 1
        G.GAME.blind:set_text()
    end,

	debuff_hand = function(self, cards, hand, handname, check)
		if
			#cards ~= (G.GAME.tower_seraph_play_cards or 5)
			and not G.GAME.blind.disabled
		then
			G.GAME.blind.triggered = true
			return true
		end
		return false
	end
})


SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-instability",
	key = "instability",
	pos = { x = 0, y = 8 },
	atlas = "blinds3",
	order = 1,
    mult = 4,
    boss_colour = HEX("b593ff"),
    boss = {
        level = 3
    },
    dollars = 8,


    debuff_hand = function(self, cards, hand, handname, check)
        local bad = false;
        if G.GAME.blind.disabled then return false end
        for i = 1, #cards do
            if not SMODS.has_enhancement(cards[i], "m_cry_abstract") then
                bad = true
                break;
            end
        end
        if bad then
			G.GAME.blind.triggered = true
        end
        return bad
    end,

    get_loc_debuff_text = function(self)
        return localize("tower_debuff_instability")
    end,
})


emperor_selection.suits[#emperor_selection.suits+1] = 'bl_tower_instability'

SMODS.Blind({
	tower_is_tarot = true,
	name = "tower-blessing",
	key = "blessing",
	pos = { x = 0, y = 9 },
	atlas = "blinds3",
	order = 1,
    mult = 4,
    boss_colour = HEX("b593ff"),
    boss = {
        level = 3
    },
    dollars = 8,

    TowerBeforeBlindSet = function (self, blind, reset, silent)
        self:set_blind(Tower.getBlinds(function (blind) 
            return blind.tower_is_spectral or blind.tower_is_tarot
        end, 1, pseudoseed('tower_blessing'))[1], reset, silent)
        return false
    end,
})


-- emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_blessing'
-- emperor should not select blessing

SMODS.Blind(Tower.ObsidianOrb({
	name = "tower-automaton",
	key = "automaton",
	pos = { x = 0, y = 10 },
	atlas = "blinds3",
	order = 1,
    mult = 4,
    boss_colour = HEX("dc7920"),
    boss = {
        level = 3
    },
    dollars = 8,
    pick = function()
        local blinds = {}
        for i, v in ipairs(Tower.getBlinds(function (blind) 
            return blind.tower_is_code
        end, 1, pseudoseed('tower_automaton'))) do
            blinds[v.key] = true
        end
        return blinds
    end,

    debuff_text = 'tower_debuff_automaton'
}))


-- emperor_selection.misc[#emperor_selection.misc+1] = 'bl_tower_automaton'

SMODS.Blind(Tower.ObsidianOrb({
	name = "tower-emperor",
	key = "emperor",
	pos = { x = 0, y = 16 },
	atlas = "blinds",
	order = 1,
    mult = 4,
    boss_colour = HEX("dc7920"),
    boss = {
        level = 3
    },
    dollars = 8,
    pick = function()
        if G.GAME.tower_emp_choice then return G.GAME.tower_emp_choice end
        local pool = {'misc', 'multchips', 'suits'};
        local tot = total;
        function chooseOne()
            local result, remove = pseudorandom_element(pool, pseudoseed('tower_emperor'))
            if result == 'misc' then
                return pseudorandom_element(emperor_selection.misc, pseudoseed('tower_emperor'))
            else
                table.remove(pool, remove)
                return pseudorandom_element(emperor_selection[result], pseudoseed('tower_emperor'))
            end
        end
        G.GAME.tower_emp_choice = { [chooseOne()] = true, [chooseOne()] = true }
        return G.GAME.tower_emp_choice
    end,
    cleanup = function ()
        G.GAME.tower_emp_choice = nil
    end,

    debuff_text = 'tower_debuff_emperor'
}))