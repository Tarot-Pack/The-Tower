Tower.Blind({
	tower_is_spectral = true,
	name = "tower-soul",
	key = "soul",
	pos = { x = 0, y = 4 },
	atlas = "blinds",
	order = 4,
    mult = 5,
    boss_colour = HEX("b5d2dc"),
    boss = {
        level = 4,
        soul_level = 3 -- chance for it to be in tarot slot
    },
    dollars = 10,
	recalc_debuff = function(self, card, from_blind)
        if G.GAME.blind.disabled then return false end
        if card.area ~= G.jokers then return true end
		return (card.config.center.rarity ~= 4) and (card.config.center.rarity ~= 'Legendary') -- dont debuff legendary
	end,
    set_blind = function(self, reset, silent)
        if reset then return end
		for i, v in pairs(G.consumeables.cards) do
            v:set_debuff(true)
        end
    end,
    disable = function (self, reset, silent)
		for i, v in pairs(G.consumeables.cards) do
            v:set_debuff(false)
        end
    end,
    defeat = function (self, reset, silent)
		for i, v in pairs(G.consumeables.cards) do
            v:set_debuff(false)
        end
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-wraith",
	key = "wraith",
	pos = { x = 0, y = 6 },
	atlas = "blinds",
	order = 4,
    mult = 5,
    boss_colour = HEX("c7b24a"),
    boss = {
        level = 4
    },
    dollars = 10,
    TowerModChips = function (self, chips)
        chips = math.min(chips, math.max(G.GAME.dollars, 0))
        return chips
    end,
	calculate = function(self, card, context)
        if G.GAME.blind.disabled then return end
		if context.post_trigger then
            local card = context.other_context and context.other_context.blueprint_card or context.other_card or nil;
            if card == nil then
                -- nope
            elseif (card.config.center.rarity ~= 3) and (card.config.center.rarity ~= 'Rare') then
                -- nope
            else
                -- nuke the money!!!!!!!!!!
                ease_dollars(-G.GAME.dollars)
            end
        end
	end,
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-incantation",
	key = "incantation",
	pos = { x = 0, y = 7 },
	atlas = "blinds",
	order = 4,
    mult = 5,
    boss_colour = HEX("ff0063"),
    boss = {
        level = 4
    },
    dollars = 10,
	cry_before_play = function(self)	
        if G.GAME.blind.disabled then return end
        for k, v in ipairs(G.deck.cards) do
            SMODS.destroy_cards(v)
        end
        for k, v in ipairs(G.discard.cards) do
            SMODS.destroy_cards(v)
        end

        for k, v in ipairs(G.hand.cards) do
            local found = false;
            for q, c in ipairs(G.hand.highlighted) do
                if v == c then
                    found = true
                    break
                end
            end
            if not found then
                SMODS.destroy_cards({ v })
            end
        end
	end,
})


Tower.Blind({
	tower_is_spectral = true,
	name = "tower-ankh",
	key = "ankh",
	pos = { x = 0, y = 8 },
	atlas = "blinds",
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
        local tower_bad_joker_list = {}

        tower_bad_joker_list[#tower_bad_joker_list+1] = "j_joker"
        print("added", "j_joker")

        tower_bad_joker_list[#tower_bad_joker_list+1] = "j_chaos"
        print("added", "j_chaos")

        tower_bad_joker_list[#tower_bad_joker_list+1] = "j_golden"
        print("added", "j_golden")

        tower_bad_joker_list[#tower_bad_joker_list+1] = "j_tower_blank"
        print("added", "j_tower_blank")

        if G.P_JOKER_RARITY_POOLS["cry_cursed"] ~= nil then
            for i,v in pairs(G.P_JOKER_RARITY_POOLS["cry_cursed"]) do
                tower_bad_joker_list[#tower_bad_joker_list+1] = v.key
                print("added", v.key)
            end
        end
        G.GAME.tower_ankh_joker_transform = pseudorandom_element(tower_bad_joker_list, pseudoseed("tower_ankh_badjoker"))

		local idx
        local immune = pseudorandom_element(G.jokers.cards, pseudoseed("tower_ankh_goodjokerig"))

        for i = 1, #G.jokers.cards do
			if not SMODS.is_eternal(G.jokers.cards[i]) and G.jokers.cards[i] ~= immune then
				local _card = create_card("Joker", G.jokers, nil, nil, nil, nil, G.GAME.tower_ankh_joker_transform)
				G.jokers.cards[i]:start_dissolve()
				_card:add_to_deck()
				_card:start_materialize()
				G.jokers.cards[i] = _card
				_card:set_card_area(G.jokers)
				G.jokers:set_ranks()
				G.jokers:align_cards()
			end
		end
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-blackhole",
	key = "blackhole",
	pos = { x = 0, y = 15 },
	atlas = "blinds",
	order = 4,
    mult = G.tower_unknown,
    boss_colour = HEX("7800ff"),
    boss = {
        level = 4,
        soul_level = 2 -- planet
    },
    dollars = 10,

    set_blind = function (self, reset)
        if reset then return end
        G.GAME.tower_blackhole_info = {}
        G.GAME.blind.chips = #G.handlist
        G.GAME.current_round.hands_left = #G.handlist
    end,
    defeat = function (self)
        G.GAME.tower_blackhole_info = nil
    end,
    disable = function (self)
        G.GAME.tower_blackhole_info = nil
    end,
    TowerModFinalScore = function (self, score, cards, poker_hands, hand, scoring_hand, mult, hand_chips)
        if G.GAME.blind.disabled then return score end

        G.GAME.tower_blackhole_info[hand] = true;
        return 1 -- score one point
    end,
    debuff_hand = function(self, cards, hand, handname, check)
        if G.GAME.blind.disabled then return false end
        if not G.GAME.tower_blackhole_info[handname] then
            return false
        end
        G.GAME.blind.triggered = true;
		return true -- hand already done
	end,

    get_loc_debuff_text = function(self)
        return localize("tower_debuff_blackhole")
    end,

})
Tower.Blind({
	tower_is_spectral = true,
	name = "tower-ectoplasm",
	key = "ectoplasm",
	pos = { x = 0, y = 17 },
	atlas = "blinds",
	order = 4,
    mult = 5,
    boss_colour = HEX("8c80ff"),
    boss = {
        level = 4
    },
    dollars = 10,

    set_blind = function (self, reset)
        if reset then return end
        if G.GAME.blind.disabled then return end
        local size = G.hand.config.real_card_limit or G.hand.config.card_limit;
        G.GAME.blind:wiggle()
        for i, v in pairs(G.jokers.cards) do
			if not (G.jokers.cards[i].edition and (G.jokers.cards[i].edition.negative or G.jokers.cards[i].edition.tower_truenegative)) then    
                size = size / 2;
                G.hand:change_size(math.floor(size - (G.hand.config.real_card_limit or G.hand.config.card_limit)))
                if (G.hand.config.real_card_limit or G.hand.config.card_limit) <= 0 then
                    G.STATE = G.STATES.GAME_OVER; 
                    G.STATE_COMPLETE = false -- lose instantly if hand size <= 0 (ignoring cryptid)
                    return
                end
			end
        end
    end

})
Tower.Blind({
	tower_is_spectral = true,
	name = "tower-sigil",
	key = "sigil",
	pos = { x = 0, y = 18 },
	atlas = "blinds",
	order = 4,
    mult = 5,
    boss_colour = HEX("ef838b"),
    boss = {
        level = 4
    },
    dollars = 10,
    set_blind = function (self, reset)
        if reset then return end
        if G.GAME.blind.disabled then return end
        G.GAME.tower_sigil_suitlist = {}
        for i,v in pairs(G.COLLABS.options) do
            G.GAME.tower_sigil_suitlist[#G.GAME.tower_sigil_suitlist + 1] = i
        end
        G.GAME.tower_sigil_suitlist[#G.GAME.tower_sigil_suitlist + 1] = "cry_abstract"
        G.GAME.tower_sigil_suit = pseudorandom_element(G.GAME.tower_sigil_suitlist, pseudoseed("tower_sigil_suit"))
    end,
    cry_after_play = function (self)
        if G.GAME.blind.disabled then return end
        G.GAME.tower_sigil_suit = pseudorandom_element(G.GAME.tower_sigil_suitlist, pseudoseed("tower_sigil_suit"))
    end,
    defeat = function (self)
        G.GAME.tower_sigil_suit = nil
    end,
    disable = function (self)
        G.GAME.tower_sigil_suit = nil
    end,
    debuff_hand = function(self, cards, hand, handname, check)
        local bad = false;
        if G.GAME.blind.disabled then return false end
        for i = 1, #cards do
            if G.GAME.tower_sigil_suit == "cry_abstract" then
                if not (
                    (cards[i].ability.name == "Wild Card" and not cards[i].debuff) or cards[i]:is_suit(G.GAME.tower_sigil_suit) -- wild detection (check if wild directly and call back on suit check that will only work for wild-acting cards)
                    or SMODS.has_enhancement(cards[i], "m_cry_abstract")
                ) then
                    bad = true
                    break;
                end
            else
                if not cards[i]:is_suit(G.GAME.tower_sigil_suit) then
                    bad = true
                    break;
                end
            end
        end
        if bad then
			G.GAME.blind.triggered = true
        end
        return bad
    end,

    get_loc_debuff_text = function(self)
        if G.GAME.tower_sigil_suit == 'Hearts' then
            return localize("tower_debuff_sun")
        elseif G.GAME.tower_sigil_suit == 'Spades' then
            return localize("tower_debuff_world")
        elseif G.GAME.tower_sigil_suit == 'Clubs' then
            return localize("tower_debuff_moon")
        elseif G.GAME.tower_sigil_suit == 'Diamonds' then
            return localize("tower_debuff_star")
        else
            return localize("tower_debuff_instability")
        end
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-familiar",
	key = "familiar",
	pos = { x = 0, y = 23 },
	atlas = "blinds2",
	order = 4,
    mult = 5,
    boss_colour = HEX("ff0080"),
    boss = {
        level = 4
    },
    dollars = 10,
    debuff_hand = function(self, cards, hand, handname, check)
        local bad = false;
        if G.GAME.blind.disabled then return false end
        
        for i, v in pairs(G.playing_cards) do
            if v:is_face() then
                bad = true;
                break
            end
        end
        
        if bad then
			G.GAME.blind.triggered = true
        end
        return bad
    end
})
Tower.Blind({
	tower_is_spectral = true,
	name = "tower-grim",
	key = "grim",
	pos = { x = 0, y = 24 },
	atlas = "blinds2",
	order = 4,
    mult = 5,
    boss_colour = HEX("b1ff00"),
    boss = {
        level = 4
    },
    dollars = 10
})

local old_add_to_hl = CardArea.add_to_highlighted;
function CardArea:add_to_highlighted(card, silent) -- this is so extremely specific that i will not define an api for it
    if self.config.type == 'hand' 
        and G.GAME.blind and G.GAME.blind.config.blind and G.GAME.blind.config.blind.key == "bl_tower_grim" 
        and not (
            card.base.value == "Ace"
            and not SMODS.has_no_rank(card)
			and not SMODS.has_enhancement(card, "m_cry_abstract")
        ) then
            return false
    end
    return old_add_to_hl(self, card, silent)
end


Tower.Blind({
	tower_is_spectral = true,
	name = "tower-talisman",
	key = "talisman",
	pos = { x = 0, y = 25 },
	atlas = "blinds2",
	order = 4,
    mult = 5,
    boss_colour = HEX("ffba01"),
    boss = {
        level = 4
    },
    dollars = 10,

    TowerModFinalScore = function (self, score)
        if G.GAME.blind.disabled then return score end
        if score > G.GAME.dollars then
            return G.GAME.dollars
        end
        return score 
    end,
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-aura",
	key = "aura",
	pos = { x = 0, y = 26 },
	atlas = "blinds2",
	order = 4,
    mult = 5,
    boss_colour = HEX("4600ff"),
    boss = {
        level = 4
    },
    dollars = 10,

    defeat = function ()
        G.GAME.tower_aura_edition = nil
    end,

    debuff_hand = function(self, cards, hand, handname, check)
        if G.GAME.blind.disabled then return false end
        local bad = false;
        for i, v in pairs(cards) do 
            if not v.edition then
                bad = true
                break;
            elseif not v.edition[G.GAME.tower_aura_edition] then
                bad = true 
                break
            end
        end
        if bad then
            G.GAME.blind.triggered = true;
        end
		return bad -- hand already done
	end,

    collection_loc_vars = function (self)
        return {
            vars = {
                localize("tower_edition")
            }
        }
    end,

    loc_vars = function (self)
        if not G.GAME.tower_aura_edition then
            local options = G.P_CENTER_POOLS["Edition"]
            local chosen = pseudorandom_element(options, pseudoseed('tower_aura'))
            G.GAME.tower_aura_edition = chosen.key:sub(3);
        end
        return {
            vars = {
                G.localization.descriptions.Edition["e_"..(G.GAME.tower_aura_edition or 'polychrome')].name
            }
        }
    end
})

Tower.Blind({
	tower_is_spectral = true,
	name = "tower-ouija",
	key = "ouija",
	pos = { x = 0, y = 27 },
	atlas = "blinds2",
	order = 4,
    mult = 5,
    boss_colour = HEX("01ffd1"),
    boss = {
        level = 4
    },
    dollars = 10,

    defeat = function ()
        G.GAME.tower_ouija_rank = nil
    end,

    debuff_hand = function(self, cards, hand, handname, check)
        if G.GAME.blind.disabled then return false end
        local bad = false;
        for i, card in pairs(cards) do 
            if G.GAME.tower_ouija_rank == "cry_abstract" then
                if not SMODS.has_enhancement(card, "m_cry_abstract") then -- evil 
                    bad = true
                    break
                end
            else
                if SMODS.has_no_rank(card) or SMODS.has_enhancement(card, "m_cry_abstract") then
                    bad = true
                    break;
                elseif card.base.value ~= G.GAME.tower_ouija_rank then
                    bad = true 
                    break
                end
            end
        end
        if bad then
            G.GAME.blind.triggered = true;
        end
		return bad -- hand already done
	end,

    collection_loc_vars = function (self)
        return {
            vars = {
                localize("tower_rank")
            }
        }
    end,

    loc_vars = function (self)
        if not G.GAME.tower_ouija_rank then
            local options = {}
            for i, v in pairs(SMODS.Ranks) do
                options[#options+1] = i 
            end
            options[#options+1] = "cry_abstract" -- we do a bit of trolling
            local chosen = pseudorandom_element(options, pseudoseed('tower_ouija'))
            G.GAME.tower_ouija_rank = chosen;
        end
        return {
            vars = {
                G.localization.misc.dictionary.ranks[G.GAME.tower_ouija_rank] or G.localization.misc.ranks[G.GAME.tower_ouija_rank] or G.localization.misc.dictionary.ranks.tower_0
            }
        }
    end
})


Tower.Blind({
	tower_is_spectral = true,
	name = "tower-immolate",
	key = "immolate",
	pos = { x = 0, y = 1 },
	atlas = "blinds3",
	order = 4,
    mult = 5,
    boss_colour = HEX("ff6800"),
    boss = {
        level = 4
    },
    dollars = 10,

    set_blind = function (self, reset)
        if reset then return end
        if G.GAME.blind.disabled then return end
        local debt = G.GAME.dollars
        ease_dollars(-(G.GAME.dollars * to_big(2)))
        local pool = {}
        for i, v in pairs(G.jokers.cards) do 
            if not SMODS.is_eternal(v) then
                pool[#pool+1] = v
            end
        end
        if #pool == 0 then return end
        table.sort(pool, function (a, b)
            return a.sell_cost > b.sell_cost
        end)

        for i, v in ipairs(pool) do
            if debt < to_big(0) then break end
            debt = debt - v.sell_cost
            v:sell_card()
        end
    end,
})


Tower.Blind({
	tower_is_spectral = true,
	name = "tower-dejavu",
	key = "dejavu",
	pos = { x = 0, y = 2 },
	atlas = "blinds3",
	order = 4,
    mult = 5,
    boss_colour = HEX("9174e1"),
    boss = {
        level = 4
    },
    dollars = 10,

    debuff_hand = function(self, cards, hand, handname, check)
        if G.GAME.blind.disabled then return false end
        local bad = false;
        for i, v in pairs(cards) do 
            if v.seal ~= G.GAME.tower_dejavu_seal then
                bad = true 
                break
            end
        end
        if bad then
            G.GAME.blind.triggered = true;
        end
		return bad -- hand already done
	end,

    collection_loc_vars = function (self)
        return {
            vars = {
                localize("tower_seal")
            }
        }
    end,
    defeat = function ()
        G.GAME.tower_dejavu_seal = nil
    end,

    loc_vars = function (self)
        if not G.GAME.tower_dejavu_seal then
            local options = G.P_CENTER_POOLS["Seal"]
            local chosen = pseudorandom_element(options, pseudoseed('tower_dejavu'))
            G.GAME.tower_dejavu_seal = chosen.key;
        end
        return {
            vars = {
                G.localization.descriptions.Other[string.lower(G.GAME.tower_dejavu_seal or "Red").."_seal"].name
            }
        }
    end
})


Tower.Blind({
	tower_is_spectral = true,
	name = "tower-hex",
	key = "hex",
	pos = { x = 0, y = 3 },
	atlas = "blinds3",
	order = 4,
    mult = 5,
    boss_colour = HEX("9f00ff"),
    boss = {
        level = 4
    },
    dollars = 10,

    set_blind = function (self, reset)
        if reset then return end
        if G.GAME.blind.disabled then return end
        local destroy = {}
        for i, v in pairs(G.jokers.cards) do
            if not (v.edition and v.edition.polychrome) then
                destroy[#destroy+1] = v
            end
        end
        SMODS.destroy_cards(destroy)
    end
})


Tower.Blind({
	tower_is_spectral = true,
	name = "tower-trance",
	key = "trance",
	pos = { x = 0, y = 4 },
	atlas = "blinds3",
	order = 4,
    mult = 5,
    boss_colour = HEX("01cfff"),
    boss = {
        level = 4
    },
    dollars = 10,
    
    defeat = function ()
        G.GAME.tower_trance_handtype = nil
    end,

    debuff_hand = function(self, cards, hand, handname, check)
        if G.GAME.blind.disabled then return false end
        local bad = handname ~= G.GAME.tower_trance_handtype;
        if bad then
            G.GAME.blind.triggered = true;
        end
		return bad -- hand already done
	end,

    TowerModFinalScore = function (self, score)
        if G.GAME.blind.disabled then return score end
        return math.min(score, self.chips / to_big(4))
    end,

    collection_loc_vars = function (self)
        return {
            vars = {
                localize("tower_handtype")
            }
        }
    end,

    loc_vars = function (self)
        if not G.GAME.tower_trance_handtype then
            local options = {}
            for i, v in pairs(SMODS.PokerHands) do
                options[#options + 1] = i
            end
            local chosen = pseudorandom_element(options, pseudoseed('tower'))
            G.GAME.tower_trance_handtype = chosen;
        end
        return {
            vars = {
                localize(G.GAME.tower_trance_handtype or "High Card", "poker_hands")
            }
        }
    end
})


Tower.Blind({
	tower_is_spectral = true,
	name = "tower-medium",
	key = "medium",
	pos = { x = 0, y = 0 },
	atlas = "blinds3",
	order = 4,
    mult = 5,
    boss_colour = HEX("ef838b"),
    boss = {
        level = 4
    },
    dollars = 10,

    set_blind = function (self, reset)
        if reset then return end
        if G.GAME.blind.disabled then return end
        if #G.deck.cards < 2 then
            if #G.deck.cards == 1 then
                G.deck.cards[1].ability.tower_bound = true
                SMODS.Stickers.tower_fuckyou:apply(G.deck.cards[1], true)
                return
            end
            local evilace = SMODS.add_card({
                set = "Playing Card",
                edition = "e_tower_truenegative"
            })
            SMODS.Stickers.tower_fuckyou:apply(evilace, true)
            return
        end
        local chosen = pseudorandom(pseudoseed("tower_strength"), 1, #G.deck.cards)
        for i, v in pairs(G.deck.cards) do
            if i ~= chosen then
                v.ability.tower_bound = true
            end
        end
    end
})

Tower.Sticker{
	atlas = "stickers",
	pos = { x = 0, y = 0 },
	key = "bound",
	no_sticker_sheet = true, -- do not the bound
	badge_colour = HEX("9174e1"),
    rate = 0,
	order = 999999,
    tower_credits = {
		idea = {
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
}

local old_dbf_hand = Blind.debuff_hand;

function Blind:debuff_hand(cards, hand, handname, check)
    G.tower_bound_debuff_triggered = false
    self.triggered = false
    for i, v in pairs(cards) do
        if v.ability.tower_bound then
            self.triggered = true
            G.tower_bound_debuff_triggered = 'card'
            break
        end
    end
    if not self.triggered then
        for i, v in pairs(G.jokers.cards) do
            if v.ability.tower_bound then
                self.triggered = true
                G.tower_bound_debuff_triggered = 'joker'
                break
            end
        end
    end
    if not self.triggered then
        for i, v in pairs(G.consumeables.cards) do
            if v.ability.tower_bound then
                self.triggered = true
                G.tower_bound_debuff_triggered = 'consumable'
                break
            end
        end
    end

    if self.triggered then
        return self.triggered
    end
    
    return old_dbf_hand(self, cards, hand, handname, check)
end

local old_get_loc_debuff_text = Blind.get_loc_debuff_text;
function Blind:get_loc_debuff_text()
    if G.tower_bound_debuff_triggered then
        return localize("tower_debuff_bound_" .. G.tower_bound_debuff_triggered)
    end
    return old_get_loc_debuff_text(self)
end


Tower.Blind({
	tower_is_spectral = true,
	name = "tower-cryptid",
	key = "cryptid",
	pos = { x = 0, y = 5 },
	atlas = "blinds3",
	order = 4,
    mult = G.tower_unknown,
    boss_colour = HEX("0035ff"),
    boss = {
        level = 4
    },
    dollars = 10,

    set_blind = function(self, reset)
        if reset then return end
        G.GAME.blind.chips = G.GAME.blind.chips * G.GAME.tower_best_score
    end,
    TowerInPool = function (self)
        return G.GAME.tower_best_score ~= nil
    end
})