local function CyanPrintCleanup(self)
    local istargeted = "tower_cyanprint_last_targeted_" .. tostring(self.unique_val)
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability[istargeted] then
            G.jokers.cards[i].ability[istargeted] = nil
            if not Card.no(G.jokers.cards[i], "immutable", true) then
                Cryptid.manipulate(G.jokers.cards[i], { value = 0.5 })
            end
        end
    end
end
local Card_remove = Card.remove;
function Card:remove(...)
    if self.ability and (self.ability.name == "tower-cyan_print") and (G.jokers) then
        CyanPrintCleanup(self)
    end
    return Card_remove(self, ...)
end
local Card_set_ability = Card.set_ability;
function Card:set_ability(...)
    if self.ability and (self.ability.name == "tower-cyan_print") and (G.jokers) then
        CyanPrintCleanup(self)
    end
    return Card_set_ability(self, ...)
end
local Card_update = Card.update
function Card:update(...)
    if self.ability.name == "tower-cyan_print" and (G.jokers) then
        local new_targeted;
        local last_targeted;
        local istargeted = "tower_cyanprint_last_targeted_" .. tostring(self.unique_val)
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == self then
                new_targeted = G.jokers.cards[i + 1]
            end
            if G.jokers.cards[i].ability[istargeted] then
                last_targeted = G.jokers.cards[i]
            end
        end
        if last_targeted ~= new_targeted then
            if last_targeted then
                last_targeted.ability[istargeted] = nil;
                if not Card.no(last_targeted, "immutable", true) then
                    Cryptid.manipulate(last_targeted, { value = 0.5 })
                end
            end
            if new_targeted then
                new_targeted.ability[istargeted] = true;
                if not Card.no(new_targeted, "immutable", true) then
                    Cryptid.manipulate(new_targeted, { value = 2 })
                end
            end
        end
    end
	return Card_update(self, ...)
end

Tower.Joker({
	name = "tower-cyan_print",
	key = "cyanprint",
	pos = { x = 1, y = 0 },
    blueprint_compat = true,
	pools = { },
	rarity = 3,
	cost = 8,
	atlas = "prints",

    tower_credits = {
		idea = {
			"jamirror"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	}
})

Tower.Joker({
	name = "tower-limeprint",
	key = "limeprint",
	pos = { x = 2, y = 0 },
    blueprint_compat = true,
	pools = { },
    config = {
        extra = {
            retriggers = 2
        }
    },
	rarity = 3,
	cost = 8,
	atlas = "prints",
	loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.retriggers
        }}
    end,
    calculate = function(self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then
            for i = 1, #G.jokers.cards do
                if (G.jokers.cards[i] == card) -- this is us
                and (context.other_card == G.jokers.cards[i + 1]) -- the retriggered joker is to the right of us
                and (G.jokers.cards[i - 1]) then -- there is a joker to sac to the left of us
                    SMODS.destroy_cards({ G.jokers.cards[i - 1] })
                    return {
                        message = localize("k_again_ex"),
                        repetitions = to_number(
                            card.ability.extra.retriggers
                        ),
                        card = card,
                    }
                end
            end
		end
    end,

    tower_credits = {
		idea = {
			"jamirror"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	}
})

Tower.Joker({
	name = "tower-yellowprint",
	key = "yellowprint",
	pos = { x = 3, y = 0 },
	pools = { },
    blueprint_compat = true,
    config = {
        extra = {
            pieces = 3
        }
    },
	rarity = "cry_epic",
	cost = 8,
	atlas = "prints",
	loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.pieces
        }}
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            for i = 1, #G.jokers.cards do
                if (G.jokers.cards[i] == card) -- this is us
                and (G.jokers.cards[i + 1]) then -- there is a joker to the right
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local copies = math.floor(card.ability.extra.pieces);
                            local tocopy = G.jokers.cards[i + 1];
                            if not Card.no(tocopy, "immutable", true) then
                                Cryptid.manipulate(tocopy, { value = (1/copies) })
                            end
                            for i = 1, (copies-1) do
                                local card = copy_card(tocopy, nil)
                                card:add_to_deck()
                                G.jokers:emplace(card)
                            end
                            return true
                        end,
                    }))
                    card_eval_status_text(
                        context.blueprint_card or card,
                        "extra",
                        nil,
                        nil,
                        nil,
                        { message = localize("k_duplicated_ex") }
                    )
                    return nil, true
                end
            end
            return
		end
    end,

    tower_credits = {
		idea = {
			"jamirror"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	}
})

Tower.Joker({
	name = "tower-springprint",
	key = "springprint",
	pos = { x = 4, y = 0 },
	pools = { },
	rarity = 2,
	cost = 8,
	atlas = "prints",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.setting_blind then
            for i = 1, #G.jokers.cards do
                if (G.jokers.cards[i] == card) -- this is us
                and (G.jokers.cards[i + 1]) then -- there is a joker to the right		
                    local joker = G.jokers.cards[i + 1]
                    local rarity = joker.config.center.rarity
                    joker.getting_sliced = true
                    local forced_key = nil
                    local options = {}
                    if Tower.IndexToRarity[rarity] then
                        rarity = Tower.IndexToRarity[rarity]
                    end
                    local pool = G.P_JOKER_RARITY_POOLS[rarity] or {}
                    for i = 1, #pool do
                        if not G.GAME.banned_keys[pool[i].key] then
                            options[#options+1] = pool[i].key
                        end
                    end
                    if #options == 0 then
                        forced_key = 'j_joker'
                    else
                        forced_key = pseudorandom_element(options, pseudoseed('springprint'))
                    end
                    G.E_MANAGER:add_event(Event({
                        trigger = "before",
                        delay = 0.75,
                        func = function()
                            joker:start_dissolve(nil, _first_dissolve)
                            _first_dissolve = true
                            return true
                        end,
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.4,
                        func = function()
                            play_sound("timpani")
                            local card = create_card("Joker", G.jokers, nil, nil, nil, nil, forced_key)
                            card:add_to_deck()
                            G.jokers:emplace(card)
                            card:juice_up(0.3, 0.5)
                            return true
                        end,
                    }))
                    return nil, true
                end
            end
            return
		end
    end,

    tower_credits = {
		idea = {
			"jamirror"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	}
})

Tower.Joker({
	name = "tower-pinkprint",
	key = "pinkprint",
	pos = { x = 5, y = 0 },
	pools = { },
	rarity = 2,
	cost = 8,
	atlas = "prints",
    config = {
        extra = {
            retriggers = 1
        },
        immutable = {
            toggle = false
        }
    },
    blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.retriggers
        }}
    end,
    calculate = function(self, card, context)
        if context.setting_blind and (not card.ability.immutable.toggle) then
            for i = 1, #G.jokers.cards do
                if (G.jokers.cards[i] == card) -- this is us
                and (G.jokers.cards[i + 1]) then -- the debuffed joker is to the right of us
                    card.ability.immutable.toggle = not card.ability.immutable.toggle;
                    G.jokers.cards[i + 1]:set_debuff(true)
                end
            end
        elseif (context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card) and (not context.other_card.debuff)  then
            for i = 1, #G.jokers.cards do
                if (G.jokers.cards[i] == card) -- this is us
                and (context.other_card == G.jokers.cards[i + 1]) then -- the retriggered joker is to the right of us
                    return {
                        message = localize("k_again_ex"),
                        repetitions = to_number(
                            card.ability.extra.retriggers
                        ),
                        card = card,
                    }
                end
            end
            return
		end
    end,

    tower_credits = {
		idea = {
			"jamirror"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror", 
		},
	}
})

Tower.Joker({
	name = "tower-print",
	key = "print",
	pos = { x = 6, y = 0 },
	pools = { },
	rarity = 3,
	cost = 8,
	atlas = "prints",
    config = {
        extra = {
            retriggers = 1
        }
    },
    blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.retriggers,
            G.jokers and ((G.jokers.config.card_limit - #G.jokers.cards + 1) * card.ability.extra.retriggers) or 1
        }}
    end,
    calculate = function(self, card, context)
        if (context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card) and (not context.other_card.debuff)  then
            for i = 1, #G.jokers.cards do
                if (G.jokers.cards[i] == card) -- this is us
                and (context.other_card == G.jokers.cards[i + 1]) then -- the retriggered joker is to the right of us
                    return {
                        message = localize("k_again_ex"),
                        repetitions = to_number(
                            G.jokers and ((G.jokers.config.card_limit - #G.jokers.cards + 1) * card.ability.extra.retriggers) or 1
                        ),
                        card = card,
                    }
                end
            end
            return
		end
    end,

    tower_credits = {
		idea = {
			"jamirror"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror", 
		},
	}
})

Tower.Joker({
	name = "tower-blue",
	key = "blue",
	pos = { x = 7, y = 0 },
	pools = { },
	rarity = "tower_apollyon",
	cost = 8,
	atlas = "prints",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if (context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local insert = copy_card(context.other_card, nil)
                    insert:add_to_deck()
                    G.jokers:emplace(insert)
                    return true
                end,
            }))
            return {
                message = localize("k_again_ex"),
                repetitions = 1,
                card = card,
            }
        end
        return
    end,

    tower_credits = {
		idea = {
			"jamirror"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror", 
		},
	}
})

Tower.Joker({
	name = "tower-greenprint",
	key = "greenprint",
	pos = { x = 0, y = 1 },
	pools = { },
	rarity = 2,
	cost = 8,
	atlas = "prints",
    config = {
        extra = {
            count = 1, -- starting at X1
            gains = 0.05,
        }
    },
    
	loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.count,
            card.ability.extra.gains,
        }}
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.count = G.P_CENTERS.j_tower_greenprint.config.extra.count
            return {
                message = localize("k_reset"),
            }
        elseif context.post_trigger then
            local other_card = context.other_context and context.other_context.blueprint_card or context.other_card or nil;
            if not other_card then return end
            if other_card == card then return end
            if (card.T.x + (card.T.w / 2)) < (other_card.T.x + (other_card.T.w / 2)) then
                local old = card.ability.extra.count;

                card.ability.extra.count =
                    lenient_bignum(to_big(card.ability.extra.count) + to_big(card.ability.extra.gains))

                Cryptid.apply_scale_mod(card, card.ability.extra.gains, old, card.ability.extra.count, {
                    base = { { "extra", "count" } },
                    scaler = { { "extra", "gains" } },
                    scaler_base = { card.ability.extra.gains },
                })

                return {
					message = localize({ type = "variable", key = "tower_planted" }),
                }
            end
        elseif context.joker_main and (to_big(card.ability.extra.count) ~= to_big(1)) then
            return {
                message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.count } }),
                Xmult_mod = to_big(card.ability.extra.count),
                colour = G.C.RED
            }
        end
        return
    end,
    blueprint_compat = true,

    tower_credits = {
		idea = {
			"Lil Mr. Slipstream"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror", 
		},
	}
})

Tower.Joker({
	name = "tower-goldprint",
	key = "goldprint",
	pos = { x = 1, y = 1 },
	pools = { },
	rarity = 3,
	cost = 8,
	atlas = "prints",
    config = {
        extra = {
            dollars_mod = 1,
            dollars = 0
        }
    },
    blueprint_compat = true,
    
	loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.dollars_mod,
            card.ability.extra.dollars
        }}
    end,
	update = function(self, card, front)
        card.ability.extra.dollars = 0
		if G.STAGE ~= G.STAGES.RUN then return end
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                local total = to_big((#G.jokers.cards) - i) * to_big(card.ability.extra.dollars_mod);
                card.ability.extra.dollars = total;
                return
            end
        end
	end,
    calculate = function(self, card, context)
        if context.joker_main and (to_big(card.ability.extra.dollars) ~= to_big(0)) then
            return {
                message = localize({ type = "variable", key = "tower_stonks" }),
                dollars = card.ability.extra.dollars,
                colour = G.C.MONEY
            }
        end
        return
    end,

    tower_credits = {
		idea = {
			"Lil Mr. Slipstream"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror", 
		},
	}
})


Tower.Joker({
	name = "tower-redprint",
	key = "redprint",
	pos = { x = 2, y = 1 },
	pools = { },
    config = {
        extra = {
            retriggers = 2
        }
    },
	rarity = "cry_epic",
	cost = 8,
	atlas = "prints",
    blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.retriggers
        }}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for i = 1, #G.jokers.cards do
                if (G.jokers.cards[i] == card) then -- this is us
                    if not G.jokers.cards[i - 1] then
                        if G.jokers.cards[i + 1] then
                            SMODS.destroy_cards({ G.jokers.cards[i + 1] })
                            return {
                                message = localize("k_eaten_ex"),
                                card = card,
                            }
                        end
                        return
                    end
                    SMODS.destroy_cards({ G.jokers.cards[i - 1] })
                    if G.jokers.cards[i + 1] then
                        G.E_MANAGER:add_event(Event({
                        func = function()
                            local card = copy_card(G.jokers.cards[i + 1], nil)
                            card:add_to_deck()
                            G.jokers:emplace(card)
                            return true
                        end,
                    }))
                        return {
                            message = localize("k_copied_ex"),
                            card = card,
                        }
                    else
                        return {
                            message = localize("k_eaten_ex"),
                            card = card,
                        }
                    end
                end
            end
		end
    end,

    tower_credits = {
		idea = {
			"Lil Mr. Slipstream"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	}
})

Tower.Joker({
	name = "tower-orangeprint",
	key = "orangeprint",
	pos = { x = 3, y = 1 },
	pools = { },
	rarity = 2,
	cost = 8,
	atlas = "prints",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local options = {}

            for i = 1, #G.jokers.cards do
                if #options >= 5 then
                    break
                end
                if G.jokers.cards[i].ability.name ~= "tower-orangeprint" then
                    options[#options+1] = G.jokers.cards[i]
                end
            end
            if #options == 0 then
                return
            end
            local other_card = pseudorandom_element(options, pseudoseed("tower_orangeprint"));
            return SMODS.blueprint_effect(card, other_card, context)
        end
    end,

    tower_credits = {
		idea = {
			"Lil Mr. Slipstream"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	}
})

Tower.Joker({
	name = "tower-purpleprint",
	key = "purpleprint",
	pos = { x = 4, y = 1 },
	pools = { },
	rarity = 3,
	cost = 8,
	atlas = "prints",
    blueprint_compat = true,
    eternal_compat = false,

    tower_credits = {
		idea = {
			"Lil Mr. Slipstream"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	}
})

Tower.Sticker{
	atlas = "stickers",
	pos = { x = 1, y = 0 },
	key = "sleeping_blessing",
	no_sticker_sheet = true,
	badge_colour = HEX("de4bde"),
    rate = 0,
	order = 999999,
    no_collection = true,
    eternal_compat = false,
    
    sets = {
 		Joker = true,
 	},

	tower_credits = {
		idea = {
			"Lil Mr. Slipstream",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
}

local old_ease_hands_played = ease_hands_played;
function ease_hands_played(mod, instant)
    if ((mod + G.GAME.current_round.hands_left) <= 0) and G.jokers then
        for i = 1, #G.jokers.cards do
            if (not G.jokers.cards[i].ability.eternal) and ((G.jokers.cards[i].ability.name == 'tower-purpleprint') or (G.jokers.cards[i].ability.tower_sleeping_blessing)) then
                if (G.jokers.cards[i].ability.name == 'tower-purpleprint') and (G.jokers.cards[i].ability.tower_sleeping_blessing) then -- special behaviour for purpleprint having sleeping blessing
                    G.jokers.cards[i].ability.tower_sleeping_blessing = nil; -- remove sleeping blessing and do not delete joker
                else
                    SMODS.destroy_cards({G.jokers.cards[i]})
                end
                if G.jokers.cards[i+1] then
                    G.jokers.cards[i+1].ability.tower_sleeping_blessing = true
                end
                return old_ease_hands_played(2 - G.GAME.current_round.hands_left, instant) -- set hands to 2
            end
        end
        return old_ease_hands_played(mod, instant)
    else
        return old_ease_hands_played(mod, instant)
    end
end


Tower.Joker({
	name = "tower-blackprint",
	key = "blackprint",
	pos = { x = 5, y = 1 },
    blueprint_compat = true,
	pools = { },
    config = {
        extra = {
            retriggers = 1
        }
    },
	rarity = 2,
	cost = 8,
	atlas = "prints",
	loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.retriggers
        }}
    end,
    eternal_compat = false,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.retriggers = lenient_bignum((G.GAME and G.GAME.tower_blackprint_retriggers) or 1)
	end,
    calculate = function(self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then
            for i = 1, #G.jokers.cards do
                if (G.jokers.cards[i] == card) -- this is us
                and (context.other_card == G.jokers.cards[i + 1]) then -- the retriggered joker is to the right of us
                    if not card.ability.eternal then
                        card.ability.immutable.destroy_flag = true -- can keep forever but no scaling... (note that eternal compat is off so eternal would have to be applied from a spectral)
                    end
                    return {
                        message = localize("k_again_ex"),
                        repetitions = to_number(
                            card.ability.extra.retriggers
                        ),
                        card = card,
                    }
                end
            end
		elseif context.after and card.ability.immutable.destroy_flag then
            G.GAME.tower_blackprint_retriggers = (G.GAME.tower_blackprint_retriggers or 1) + 1
            SMODS.destroy_cards({ card })
        end
    end,

    tower_credits = {
		idea = {
			"Lil Mr. Slipstream"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	}
})