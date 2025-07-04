Tower.Blind({
	tower_is_tarot = true,
	name = "tower-eclipse",
	key = "eclipse",
	pos = { x = 0, y = 6 },
	atlas = "blinds3",
	order = 3,
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


G.tower_emperor_selection.misc[#G.tower_emperor_selection.misc+1] = 'bl_tower_eclipse'

Tower.Blind({
	tower_is_tarot = true,
	name = "tower-seraph",
	key = "seraph",
	pos = { x = 0, y = 7 },
	atlas = "blinds3",
	order = 3,
    mult = 4,
    boss_colour = HEX("fff3ae"),
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


Tower.Blind({
	tower_is_tarot = true,
	name = "tower-instability",
	key = "instability",
	pos = { x = 0, y = 8 },
	atlas = "blinds3",
	order = 3,
    mult = 4,
    boss_colour = HEX("292929"),
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


G.tower_emperor_selection.suits[#G.tower_emperor_selection.suits+1] = 'bl_tower_instability'

Tower.Blind({
	tower_is_tarot = true,
	name = "tower-blessing",
	key = "blessing",
	pos = { x = 0, y = 9 },
	atlas = "blinds3",
	order = 3,
    mult = 4,
    boss_colour = HEX("00ffb2"),
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


-- G.tower_emperor_selection.misc[#G.tower_emperor_selection.misc+1] = 'bl_tower_blessing'
-- emperor should not select blessing

Tower.Blind(Tower.ObsidianOrb({
	name = "tower-automaton",
	key = "automaton",
	pos = { x = 0, y = 10 },
	atlas = "blinds3",
	order = 3,
    mult = 4,
    boss_colour = HEX("b6ff00"),
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