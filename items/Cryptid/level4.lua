Tower.Blind({
	tower_is_spectral = true,
	name = "tower-summoning",
    tower_consumable = "cry_summoning",
	key = "summoning",
	pos = { x = 0, y = 23 },
	atlas = "blinds4",
	order = 4,
    mult = 5,
    boss_colour = HEX("ff009f"),
    boss = {
        level = 4
    },
    dollars = 10,
    set_blind = function(self, reset, silent)
        if reset then return end
		for i, v in pairs(G.jokers.cards) do
            if not G.jokers.cards[i].ability.eternal then
                local _card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_canvas"); --create_card("Joker", G.jokers, nil, "cry_cursed", nil, nil, nil, "tower_summoning")
                G.jokers.cards[i]:start_dissolve()
                _card:add_to_deck()
                _card:start_materialize()
                G.jokers.cards[i] = _card
                _card:set_card_area(G.jokers)
                G.jokers:set_ranks()
                G.jokers:align_cards()
                _card:set_perishable(true)
                _card.ability.perish_tally = 1
            end
        end
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-typhoon",
    tower_consumable = "cry_typhoon",
	key = "typhoon",
	pos = { x = 0, y = 24 },
	atlas = "blinds4",
	order = 4,
    mult = 5,
    boss_colour = HEX("0060ed"),
    boss = {
        level = 4
    },
    dollars = 10,
    cry_before_play = function(self)
        local hand = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
        G.GAME.hands[hand].mult = 0
        G.GAME.hands[hand].chips = 0
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-meld",
    tower_consumable = "cry_meld",
	key = "meld",
	pos = { x = 0, y = 25 },
	atlas = "blinds4",
	order = 4,
    mult = 5,
    boss_colour = HEX("0060ed"),
    boss = {
        level = 4
    },
    dollars = 10,
    set_blind = function(self)
        local cards = {}
        for i, v in ipairs(G.jokers.cards) do
            if not (v.ability.immutable and v.ability.immutable.other_side) then
                cards[#cards+1] = v  
                Cryptid.with_deck_effects(v, function(cards)
                    Cryptid.manipulate(cards, { value = 0 })
                end)
            end
        end
        -- merge all un-merged (excluding a single card if odd amount of jokers)
        local loopTo = math.floor((#cards)/2)
        for i = 1, loopTo do
            if G.jokers.cards[i] then
                local selected_card, card_key = pseudorandom_element(cards, pseudoseed("tower_meld"))
                table.remove(cards, card_key)
                local selected_card2, card_key2 = pseudorandom_element(cards, pseudoseed("tower_meld"))
                table.remove(cards, card_key2)
                Tower.MergeCards(selected_card, selected_card2)
            end
        end
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-gateway",
    tower_consumable = "cry_gateway",
	key = "gateway",
	pos = { x = 0, y = 26 },
	atlas = "blinds4",
	order = 4,
    mult = 5,
    boss_colour = HEX("235bb0"),
    boss = {
        level = 5, -- level 5 never happens so soul_level is only way
        soul_level = 4
    },
    dollars = 10,
    set_blind = function(self, reset, silent)
        if reset then return end
        local destroy = {}
		for i, v in pairs(G.consumeables.cards) do
            if v.config.center.rarity ~= 'cry_exotic' then
                destroy[#destroy+1] = v
            end
        end
		for i, v in pairs(G.jokers.cards) do
            if v.config.center.rarity ~= 'cry_exotic' then
                destroy[#destroy+1] = v
            end
        end
		for i, v in pairs(G.playing_cards) do
            if v.config.center.rarity ~= 'cry_exotic' then
                destroy[#destroy+1] = v 
            end
        end
        if #destroy == 0 then
            return
        end
        SMODS.destroy_cards(destroy)
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-lock",
    tower_consumable = "cry_lock",
	key = "lock",
	pos = { x = 0, y = 27 },
	atlas = "blinds4",
	order = 4,
    mult = 5,
    boss_colour = HEX("b5d2dc"),
    boss = {
        level = 4
    },
    dollars = 10,
    loc_vars = function ()
        return {
            vars = { Tower.getLocalization(Tower.Eternal()).name }
        }
    end,
    collection_loc_vars = function ()
        return {
            vars = { Tower.getLocalization(Tower.Eternal()).name }
        }
    end,
    set_blind = function(self, reset, silent)
		for i, v in pairs(G.jokers.cards) do
            v.ability.tower_food = true
            Tower.Eternal():apply(v, true)
        end
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-vacuum",
    tower_consumable = "cry_vacuum",
	key = "vacuum",
	pos = { x = 0, y = 0 },
	atlas = "blinds4",
	order = 4,
    mult = 5,
    boss_colour = HEX("ff8c00"),
    boss = {
        level = 4
    },
    dollars = 10,
    cry_before_play = function(self, reset, silent)
        if G.GAME.blind.disabled then return end
        local destroy = {}
        local destroyCards = {}
		for i, CARD in pairs(G.jokers.cards) do
			if CARD.edition then
				destroy[#destroy+1] = CARD
			elseif CARD.seal then
				destroy[#destroy+1] = CARD
			end
        end
		for i, CARD in pairs(G.consumeables.cards) do
			if CARD.edition then
				destroy[#destroy+1] = CARD
			elseif CARD.seal then
				destroy[#destroy+1] = CARD
			end
        end
		for i, CARD in pairs(G.hand.cards) do
			if CARD.config.center ~= G.P_CENTERS.c_base then
				destroyCards[#destroyCards+1] = CARD
            elseif CARD.edition then
				destroyCards[#destroyCards+1] = CARD
			elseif CARD.seal then
				destroyCards[#destroyCards+1] = CARD
			end
        end
        if #destroy > 0 then
            SMODS.destroy_cards(destroy)
        end
        if #destroyCards > 0 then
            Tower.DestroyCardsBeforePlay(destroyCards)
        end
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-hammerspace",
    tower_consumable = "cry_hammerspace",
	key = "hammerspace",
	pos = { x = 0, y = 22 },
	atlas = "blinds4",
	order = 4,
    mult = 5,
    boss_colour = HEX("b5d2dc"),
    boss = {
        level = 4
    },
    dollars = 0,
    loc_vars = function ()
        return {
            vars = { G.GAME.round_resets.ante }
        }
    end,
    collection_loc_vars = function ()
        return {
            vars = { localize("tower_hammerspace_place") }
        }
    end,
    set_blind = function ()
        local alreadyHammer = (G.GAME.modifiers.tower_hammerspace or 0) > 0;
        G.GAME.modifiers.tower_hammerspace = (G.GAME.modifiers.tower_hammerspace or 0) + G.GAME.round_resets.ante
        if not alreadyHammer then G.GAME.modifiers.tower_hammerspace_temp_disable = true end
    	G.E_MANAGER:add_event(
			Event({
				trigger = "immediate",
				func = function()
					if G.STATE ~= G.STATES.SELECTING_HAND then
						return false
					end
					G.STATE = G.STATES.HAND_PLAYED
					G.STATE_COMPLETE = true
                    G.GAME.chips = G.GAME.blind.chips;
					end_round()
					return true
				end,
			}),
			"other"
		)
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-trade",
    tower_consumable = "cry_trade",
	key = "trade",
	pos = { x = 0, y = 22 },
	atlas = "blinds4",
	order = 4,
    mult = 5,
    boss_colour = HEX("b5d2dc"),
    boss = {
        level = 4
    },
    dollars = 10,
    set_blind = function ()
        for i, v in pairs(G.vouchers.cards) do
            v:unredeem()
            v:set_edition("e_tower_truenegative", true, nil)
            v:redeem()
        end
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-replica",
    tower_consumable = "cry_replica",
	key = "replica",
	pos = { x = 0, y = 22 },
	atlas = "blinds4",
	order = 4,
    mult = 5,
    boss_colour = HEX("b5d2dc"),
    boss = {
        level = 4
    },
    dollars = 10,
    
    TowerDrawCard = function (self, card, location, stay_flipped)
        card:set_ability(G.P_CENTERS.m_tower_blank, true, nil);
        return true
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-analog",
    tower_consumable = "cry_analog",
	key = "analog",
	pos = { x = 0, y = 8 },
	atlas = "blinds4",
	order = 4,
    mult = 5,
    boss_colour = HEX("00ff6d"),
    boss = {
        level = 4
    },
    dollars = 10,
    
    set_blind = function (self, reset)
        if reset then return end
        if G.GAME.blind.disabled then return end
        if #G.jokers.cards < 2 then return end -- zero and one joker dont do anything, no need to calc

		local idx
        local immune = pseudorandom_element(G.jokers.cards, pseudoseed("tower_ankh_goodjokerig"))

        local add = 0
        for i = 1, #G.jokers.cards do
			if not G.jokers.cards[i].ability.eternal and G.jokers.cards[i] ~= immune then
				local _card = create_card("Joker", G.jokers, nil, "cry_cursed", nil, nil, nil, "oppaggangmastyle")
				G.jokers.cards[i]:start_dissolve()
				_card:add_to_deck()
				_card:start_materialize()
				G.jokers.cards[i] = _card
				_card:set_card_area(G.jokers)
				G.jokers:set_ranks()
				G.jokers:align_cards()
                add = add + 1
			end
		end
        for i = 1, add do
            local ccard = create_card("Joker", G.jokers, nil, "cry_cursed", nil, nil, nil, "oppaggangmastyle")
            ccard:add_to_deck()
            G.jokers:emplace(ccard)
        end
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-ritual",
    tower_consumable = "cry_ritual",
	key = "ritual",
	pos = { x = 0, y = 8 },
	atlas = "blinds4",
	order = 4,
    mult = 5,
    boss_colour = HEX("00ff6d"),
    boss = {
        level = 4
    },
    dollars = 10,
    
    set_blind = function (self)
        if G.GAME.blind.disabled then return end
        G.GAME.tower_ritual = true
    end,
    disable = function (self)
        G.GAME.tower_ritual = nil
    end,
    defeat = function (self)
        G.GAME.tower_ritual = nil
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-adversary",
	key = "adversary",
    tower_consumable = "cry_adversary",
	pos = { x = 0, y = 8 },
	atlas = "blinds4",
	order = 4,
    mult = 5,
    boss_colour = HEX("00ff6d"),
    boss = {
        level = 4
    },
    dollars = 10,

    loc_vars = function ()
        return {
            vars = { Tower.getLocalization(Tower.Eternal()).name }
        }
    end,
    collection_loc_vars = function ()
        return {
            vars = { Tower.getLocalization(Tower.Eternal()).name }
        }
    end,
    set_blind = function (self)
        if G.GAME.blind.disabled then return end
        for i, v in pairs(G.jokers.cards) do
            v:set_edition("e_tower_truenegative", nil, true)
            Tower.Eternal():apply(v, true)
        end
        G.GAME.modifiers.tower_adversary = (G.GAME.modifiers.tower_adversary or 0) + 1 -- evil stacking
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-chambered",
    tower_consumable = "cry_chambered",
	key = "chambered",
	pos = { x = 0, y = 8 },
	atlas = "blinds4",
	order = 4,
    mult = 5,
    boss_colour = HEX("00ff6d"),
    boss = {
        level = 4
    },
    dollars = 10,
    
    set_blind = function (self)
        if G.GAME.blind.disabled then return end
        G.GAME.tower_chambered = (G.GAME.tower_chambered or 3)
    end,
    loc_vars = function ()
        return {
            vars = {4 - (G.GAME.tower_chambered or 3)}
        }
    end,
    disable = function ()
        G.GAME.tower_chambered = 1
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-conduit",
    tower_consumable = "cry_conduit",
	key = "conduit",
	pos = { x = 0, y = 8 },
	atlas = "blinds4",
	order = 4,
    mult = 5,
    boss_colour = HEX("00ff6d"),
    boss = {
        level = 4
    },
    dollars = 10,
    
    set_blind = function (self)
        if G.GAME.blind.disabled then return end
        if #G.jokers.cards == 0 then return end
        local options = {}
        local has = {}
        for i, v in pairs(G.jokers.cards) do
            local key = 'base'
            if v.edition ~= nil then
                for i, v in pairs(v.edition) do
                    key = i
                    break
                end
            end
            if not has[key] then
                options[#options+1] = key
            end
            has[key] = true
        end
        local ed = pseudorandom_element(options, pseudoseed('tower_conduit'))
        G.GAME.modifiers["replace_edition_e_" .. ed] = "e_tower_truenegative"
        for i, v in pairs(G.jokers.cards) do
            if ed == 'base' then
                if v.edition == nil then
                    v:set_edition("e_tower_truenegative", nil, true)
                end
            else
                if v.edition and (v.edition[ed]) then
                    v:set_edition("e_tower_truenegative", nil, true)
                end
            end
        end
    end,
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-source",
    tower_consumable = "cry_source",
	key = "source",
	pos = { x = 0, y = 8 },
	atlas = "blinds4",
	order = 4,
    mult = 5,
    boss_colour = HEX("00ff6d"),
    boss = {
        level = 4
    },
    dollars = 10,
    
    set_blind = function (self)
        if G.GAME.blind.disabled then return end
        if #G.jokers.cards == 0 then return end
        
        for i, v in pairs(G.jokers.cards) do
            if v.config.center.config ~= nil then
                v.ability.extra = v.config.center.config.extra
            end
        end
    end,
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-pointer",
    tower_consumable = "cry_pointer",
	key = "pointer",
	pos = { x = 0, y = 8 },
	atlas = "blinds4",
	order = 4,
    mult = math.huge,
    boss_colour = HEX("00ff6d"),
    boss = {
        level = 4
    },
    dollars = 10,
    
    set_blind = function (self)
        if G.GAME.blind.disabled then return end
    end,
    calculate = function(self, card, context)
        if (context.post_trigger and context.other_card.config.center.key == G.GAME.tower_pointer_needed) or (context.using_consumeable and context.consumeable.config.center.key == G.GAME.tower_pointer_needed) then
            G.GAME.blind.chips = 1
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end,
    defeat = function ()
        G.GAME.tower_pointer_needed = nil
    end,
    disable = function ()
        G.GAME.blind.chips = 1
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.GAME.tower_pointer_needed = nil
    end,
    loc_vars = function(self, info_queue, card)
        if G.GAME.tower_pointer_needed == nil then
            local things = {}
            for i, v in pairs(G.P_CENTERS) do
                if v.set == 'Joker' or v.consumeable then
                    things[#things+1] = i
                end
            end
            G.GAME.tower_pointer_needed = pseudorandom_element(things, pseudoseed("tower_pointer"))
        end
		return { vars = { 
            (G.localization.descriptions[G.P_CENTERS[G.GAME.tower_pointer_needed].set])[G.GAME.tower_pointer_needed].name
        } }
	end,
    collection_loc_vars = function(self, info_queue, card)
		return { vars = { 
            localize("tower_pointer_place")
        } }
	end,
})

Tower.Blind({
    tower_is_planet = true,
    tower_consumable = cons,
    name = "tower-white_hole",
    tower_consumable = "cry_white_hole",
    key = "white_hole",
	pos = { x = 0, y = 8 },
	atlas = "blinds4",
	order = 4,
    boss_colour = HEX("00ff6d"),
    mult = G.tower_unknown,
    boss = {
        level = 2
    },
    dollars = 5,
    set_blind = function (self)
        local mult = to_big(0)
        local chips = to_big(0)
        for i, v in pairs(G.GAME.hands) do
            if v.visible then
                mult = mult + v.mult
                chips = chips + v.chips
            end
            v.mult = 0
            v.chips = 0
        end
        local combined = mult * chips;
        local square = combined:pow(to_big(2))

        G.GAME.blind.chips = G.GAME.blind.chips * square
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_planets_enabled
    end
})