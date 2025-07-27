Tower.Joker({
	name = "tower-Blank",
	key = "blank",
	pos = { x = 1, y = 0 },
	rarity = 1,
	cost = 0,
	atlas = "centers",
	order = 1,
	blueprint_compat = true,
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
})

Tower.Joker({
	name = "tower-eye_of_cthulhu",
	key = "eye_of_cthulhu",
	pos = { x = 2, y = 1 },
	pools = { ["Tower-Terra"] = true },
	config = {
		extra = {
			chips = 15,
			mult = 15,
			xmult = 15,
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.chips,
				card.ability.extra.mult,
				card.ability.extra.xmult,
			}
		}
	end,
	rarity = 1,
	calculate = function(self, card, context)
		if context.joker_main then
			if G.GAME.blind_on_deck == 'Small' then
				return {
					message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.chips } }),
					chip_mod = to_big(card.ability.extra.chips),
				}
			elseif G.GAME.blind_on_deck == 'Big' then
				return {
					message = localize({ type = "variable", key = "a_mult", vars = { card.ability.extra.mult } }),
					mult_mod = to_big(card.ability.extra.mult),
				}
			elseif G.GAME.blind_on_deck == 'Boss' then
				return {
					message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } }),
					Xmult_mod = to_big(card.ability.extra.xmult),
				}
			end
		end
	end,
	cost = 2,
	atlas = "jokers1",
	order = 1,
	blueprint_compat = true,
    tower_credits = {
		idea = {
			"pikaboy10",
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
})

Tower.Joker({
	name = "tower-king_slime",
	key = "king_slime",
	pos = { x = 0, y = 0 },
	pools = { ["Tower-Slime"] = true, ["Tower-Terra"] = true },
	config = {
		extra = {
			chips = 12,
			mult = 10
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.chips,
				card.ability.extra.mult
			}
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local has_boost = false
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if (G.jokers.cards[i - 1] and G.jokers.cards[i - 1].config.center.key == "j_tower_queen_slime") 
					or (G.jokers.cards[i + 1] and G.jokers.cards[i + 1].config.center.key == "j_tower_queen_slime") then
						has_boost = true
						break
					end
				end
			end
			local amount = 0;
			for i = 1, #G.playing_cards do
				if G.playing_cards[i].base and G.playing_cards[i].base.value == "King" then
					amount = amount + 1
				end
			end
			if has_boost then
				return {
					message = localize({ type = "variable", key = "tower_big_bounce" }),
					chip_mod = to_big(card.ability.extra.chips) * to_big(amount),
					Xmult_mod = to_big(card.ability.extra.mult) * to_big(amount)
				}
			else
				return {
					message = localize({ type = "variable", key = "tower_bounce" }),
					chip_mod = to_big(card.ability.extra.chips) * to_big(amount),
				}
			end
		end
	end,
	rarity = 2,
	cost = 7,
	atlas = "jokers1",
	order = 2,
	blueprint_compat = true,
    tower_credits = {
		idea = {
			"pikaboy10",
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
})

Tower.Joker({
	name = "tower-queen_slime",
	key = "queen_slime",
	pos = { x = 1, y = 0 },
	pools = { ["Tower-Slime"] = true, ["Tower-Terra"] = true },
	config = {
		extra = {
			mult = 10,
			chips = 12
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult,
				card.ability.extra.chips
			}
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local has_boost = false
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if (G.jokers.cards[i - 1] and G.jokers.cards[i - 1].config.center.key == "j_tower_king_slime") 
					or (G.jokers.cards[i + 1] and G.jokers.cards[i + 1].config.center.key == "j_tower_king_slime") then
						has_boost = true
						break
					end
				end
			end
			local amount = 0;
			for i = 1, #G.playing_cards do
				if G.playing_cards[i].base and G.playing_cards[i].base.value == "Queen" then
					amount = amount + 1
				end
			end
			if has_boost then
				return {
					message = localize({ type = "variable", key = "tower_big_bounce" }),
					mult_mod = to_big(card.ability.extra.mult) * to_big(amount),
					Xchip_mod = to_big(card.ability.extra.chips) * to_big(amount)
				}
			else
				return {
					message = localize({ type = "variable", key = "tower_bounce" }),
					mult_mod = to_big(card.ability.extra.mult) * to_big(amount),
				}
			end
		end
	end,
	rarity = 2,
	cost = 8,
	atlas = "jokers1",
	order = 3,
	blueprint_compat = true,
    tower_credits = {
		idea = {
			"pikaboy10",
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
})

Tower.Joker({
	name = "tower-green_slime",
	key = "green_slime",
	pos = { x = 2, y = 0 },
	pools = { ["Tower-Slime"] = true, ["Tower-Terra"] = true },
	config = {
		extra = {
			mult = 0.1,
			chips = 0.1,
			money = 0.1
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult,
				card.ability.extra.chips,
				card.ability.extra.money,
			}
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize({ type = "variable", key = "tower_boring_bounce" }),
				mult_mod = to_big(card.ability.extra.mult),
				chip_mod = to_big(card.ability.extra.chips),
				dollars = lenient_bignum(card.ability.extra.money),
			}
		end
	end,
	rarity = 1,
	cost = 1,
	atlas = "jokers1",
	blueprint_compat = true,
    tower_credits = {
		idea = {
			"pikaboy10",
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
})

Tower.Joker({
	name = "tower-blue_slime",
	key = "blue_slime",
	pos = { x = 3, y = 0 },
	pools = { ["Tower-Slime"] = true, ["Tower-Terra"] = true },
	config = {
		extra = {
			chips = 10
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.chips
			}
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize({ type = "variable", key = "tower_bounce" }),
				chip_mod = to_big(card.ability.extra.chips),
			}
		end
	end,
	rarity = 1,
	cost = 1,
	atlas = "jokers1",
	blueprint_compat = true,
    tower_credits = {
		idea = {
			"pikaboy10",
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
})

Tower.Joker({
	name = "tower-purple_slime",
	key = "purple_slime",
	pos = { x = 4, y = 0 },
	pools = { ["Tower-Slime"] = true, ["Tower-Terra"] = true },
	config = {
		extra = {
			chips = 5,
			mult = 5,
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.chips,
				card.ability.extra.mult
			}
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize({ type = "variable", key = "tower_bounce" }),
				chip_mod = to_big(card.ability.extra.chips),
				mult_mod = to_big(card.ability.extra.mult),
			}
		end
	end,
	rarity = 1,
	cost = 1,
	atlas = "jokers1",
	blueprint_compat = true,
    tower_credits = {
		idea = {
			"pikaboy10",
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
})

Tower.Joker({
	name = "tower-pinky",
	key = "pinky",
	pos = { x = 5, y = 0 },
	soul_pos = { x = 6, y = 0, extra = { x = 7, y = 0 } },
	pools = { ["Tower-Slime"] = true, ["Tower-Terra"] = true },
	config = {
		extra = {
			chips = 2,
			mult = 2,
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.amount or 1, 
				Tower.EntComp.FormatArrowMult(card.ability.amount or 1, card.ability.extra.chips),
				Tower.EntComp.FormatArrowMult(card.ability.amount or 1, card.ability.extra.mult)
			}
		}
	end,
	update = function(self, card, front)
		if G.STAGE == G.STAGES.RUN then
			card.ability.amount = 0
			for i = 1, #G.jokers.cards do
				if Tower.HasPool('Tower-Slime', G.jokers.cards[i]) then
					card.ability.amount = card.ability.amount + 1
				end
			end
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize({ type = "variable", key = "tower_big_bounce" }),
				hypermult_mod = {
					card.ability.amount or 1,
					card.ability.extra.chips,
				},
				hyperchip_mod = {
					card.ability.amount or 1,
					card.ability.extra.mult,
				},
			}
		end
	end,
	rarity = "tower_apollyon",
	cost = 100,
	atlas = "jokers1",
	order = 2,
	blueprint_compat = true,
    tower_credits = {
		idea = {
			"pikaboy10",
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
})

Tower.Joker({
	name = "tower-spiked_slime",
	key = "spiked_slime",
	pos = { x = 8, y = 0 },
	pools = { ["Tower-Slime"] = true, ["Tower-Terra"] = true },
	config = {
		extra = {
			xchips = 1,
			xchips_mod = 0.1,
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.xchips_mod,				
				card.ability.extra.xchips
			}
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize({ type = "variable", key = "tower_big_bounce" }),
				Xchip_mod = card.ability.extra.xchips,
			}
		elseif context.destroy_card and context.cardarea == G.play then
			card.ability.extra.xchips = lenient_bignum(to_big(card.ability.extra.xchips) + to_big(card.ability.extra.xchips_mod))
			return {
				remove = not context.destroy_card.ability.eternal
			}
		end
	end,
	rarity = 3,
	cost = 10,
	atlas = "jokers1",
	order = 1,
	blueprint_compat = true,
	in_pool = function ()
		return next(SMODS.find_card("j_tower_king_slime"))
	end,
    tower_credits = {
		idea = {
			"pikaboy10",
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
})

Tower.Joker({
	name = "tower-red_slime",
	key = "red_slime",
	pos = { x = 9, y = 0 },
	pools = { ["Tower-Slime"] = true, ["Tower-Terra"] = true },
	config = {
		extra = {
			mult = 10
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult
			}
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize({ type = "variable", key = "tower_bounce" }),
				mult_mod = card.ability.extra.mult,
			}
		end
	end,
	rarity = 1,
	cost = 1,
	atlas = "jokers1",
	blueprint_compat = true,
    tower_credits = {
		idea = {
			"pikaboy10",
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
})

Tower.Joker({
	name = "tower-yellow_slime",
	key = "yellow_slime",
	pos = { x = 10, y = 0 },
	pools = { ["Tower-Slime"] = true, ["Tower-Terra"] = true },
	config = {
		extra = {
			dollars = 5
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.dollars
			}
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize({ type = "variable", key = "tower_bounce" }),
				dollars = card.ability.extra.dollars,
			}
		end
	end,
	rarity = 2,
	cost = 5,
	atlas = "jokers1",
	blueprint_compat = true,
    tower_credits = {
		idea = {
			"pikaboy10",
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
})

Tower.Joker({
	name = "tower-dungeon_slime",
	key = "dungeon_slime",
	pos = { x = 11, y = 0 },
	pools = { ["Tower-Slime"] = true, ["Tower-Terra"] = true },
	config = {},
	calculate = function(self, card, context)
		if context.selling_self then
			for i, v in ipairs(G.playing_cards) do
				if Cryptid.enabled("e_cry_gold") then
					v:set_edition("e_cry_gold", true, true)
				end
				v:set_seal('Gold')
				v:set_ability(G.P_CENTERS.m_gold, true, true)
			end
			for i, v in ipairs(G.jokers.cards) do
				if Cryptid.enabled("e_cry_gold") then
					v:set_edition("e_cry_gold", true, true)
				end
				v:set_seal('Gold')
			end
			for i, v in ipairs(G.consumeables.cards) do
				if Cryptid.enabled("e_cry_gold") then
					v:set_edition("e_cry_gold", true, true)
				end
				v:set_seal('Gold')
			end
			return {
				message = localize({ type = "variable", key = "tower_big_bounce" })
			}
		end
	end,
	rarity = "cry_epic",
	cost = 10,
	atlas = "jokers1",
	blueprint_compat = true,
    tower_credits = {
		idea = {
			"pikaboy10",
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
})

Tower.Joker({
	name = "tower-black_slime",
	key = "black_slime",
	pos = { x = 0, y = 1 },
	pools = { ["Tower-Slime"] = true, ["Tower-Terra"] = true },
	config = {},
	rarity = 2,
	cost = 5,
	atlas = "jokers1",
	blueprint_compat = true,
	calculate = function (self, card, context)
		if context.setting_blind then
			G.GAME.blind.chips = G.GAME.blind.chips * 0.9
			return {
				message = localize({ type = "variable", key = "tower_hidden_bounce" })
			}
		end
	end,
    tower_credits = {
		idea = {
			"pikaboy10",
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
})

Tower.Joker({
	name = "tower-shimmer_slime",
	key = "shimmer_slime",
	pos = { x = 1, y = 1 },
	shimmer_effect = function (self)
		local items = {}
		for i = 1, #G.P_CENTER_POOLS['Tower-Slime'] do
			if G.P_CENTER_POOLS['Tower-Slime'][i].key ~= "j_tower_shimmer_slime" then
				items[#items+1] = G.P_CENTER_POOLS['Tower-Slime'][i]
			end
		end
		self:set_ability(pseudorandom_element(items))
	end,
	pools = { ["Tower-Slime"] = true, ["Tower-Terra"] = true },
	config = {
		extra = {
			mult_mod = 0.1
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult_mod,
				to_big(1.5) * ((G.GAME and G.GAME.tower_shimmer_buff) or to_big(1))
			}
		}
	end,
	rarity = "tower_transmuted",
	cost = 1,
	atlas = "jokers1",
	blueprint_compat = true,
	calculate = function (self, card, context)
		if context.joker_main then
			G.GAME.tower_shimmer_buff = ((G.GAME and G.GAME.tower_shimmer_buff) or to_big(1)) * (to_big(1) + to_big(card.ability.extra.mult_mod))
			return {
				message = localize({ type = "variable", key = "tower_virtue_boing" })
			}
		end
	end,
    tower_credits = {
		idea = {
			"pikaboy10",
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
})

Tower.Joker({
	name = "tower-golden_slime",
	key = "golden_slime",
	pos = { x = 3, y = 1 },
	pools = { ["Tower-Slime"] = true, ["Tower-Terra"] = true },
	soul_pos = { x = 5, y = 1, extra = {x = 4, y = 1}},
	config = {
		extra = {
			emoney = 3.75
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.emoney
			}
		}
	end,
	rarity = "cry_exotic",
	cost = 5,
	atlas = "jokers1",
	blueprint_compat = true,
	calculate = function (self, card, context)
		if
			context.other_joker
		then
			local amount = 0;
			if context.other_joker.edition and context.other_joker.edition.cry_gold == true then
				amount = amount + 1
			end
			if context.other_joker.seal == 'Gold' then
				amount = amount + 1
			end
			if context.other_joker.config.center == G.P_CENTERS.m_gold then -- you never know...
				amount = amount + 1
			end
			if not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_joker:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			if amount > 0 then
				local old_money = to_big(G.GAME.dollars)
				local new_money = to_big(G.GAME.dollars)
				for i = 1, amount do
					new_money = new_money:pow(card.ability.extra.emoney)
				end
				ease_dollars(new_money - old_money, true)
				return {
					message = localize({ type = "variable", key = "tower_money_bounce" })
				}
			end
		end
		if context.individual and context.cardarea == G.play then
			local amount = 0;
			if context.other_card.edition and context.other_card.edition.cry_gold == true then
				amount = amount + 1
			end
			if context.other_card.seal == 'Gold' then
				amount = amount + 1
			end
			if context.other_card.config.center == G.P_CENTERS.m_gold then -- you never know...
				amount = amount + 1
			end
			if amount > 0 then
				local old_money = to_big(G.GAME.dollars)
				local new_money = to_big(G.GAME.dollars)
				for i = 1, amount do
					new_money = new_money:pow(card.ability.extra.emoney)
				end
				ease_dollars(new_money - old_money, true)
				return {
					message = localize({ type = "variable", key = "tower_money_bounce" })
				}
			end
		end
		if
			context.individual
			and context.cardarea == G.hand
			and not context.end_of_round
		then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
					card = card,
				}
			else
				local amount = 0;
				if context.other_card.edition and context.other_card.edition.cry_gold == true then
					amount = amount + 1
				end
				if context.other_card.seal == 'Gold' then
					amount = amount + 1
				end
				if context.other_card.config.center == G.P_CENTERS.m_gold then -- you never know...
					amount = amount + 1
				end
				if amount > 0 then
					local old_money = to_big(G.GAME.dollars)
					local new_money = to_big(G.GAME.dollars)
					for i = 1, amount do
						new_money = new_money:pow(card.ability.extra.emoney)
					end
					ease_dollars(new_money - old_money, true)
					return {
						message = localize({ type = "variable", key = "tower_money_bounce" })
					}
				end
			end
		end
		if context.forcetrigger then
			local old_money = to_big(G.GAME.dollars)
			local new_money = to_big(G.GAME.dollars)
			new_money = new_money:pow(card.ability.extra.emoney)
			ease_dollars(new_money - old_money, true)
			return {
				message = localize({ type = "variable", key = "tower_money_bounce" }),
				card = card,
			}
		end
	end,
    tower_credits = {
		idea = {
			"pikaboy10",
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
})

SMODS.Edition:take_ownership('polychrome', {
	loc_vars = function(self, info_queue, card)
		return { vars = { to_big(card.edition.x_mult) * ((G.GAME and G.GAME.tower_shimmer_buff) or to_big(1)) } }
	end,
	calculate = function(self, card, context)
		if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				Xmult_mod = to_big(card.edition.x_mult) * ((G.GAME and G.GAME.tower_shimmer_buff) or to_big(1))
			}
		end
	end
})

local old_number_format = number_format;
function number_format(num, ...)
	if G.GAME and G.GAME.blind and G.GAME.blind.name ~= '' and G.GAME.blind.blind_set and (num == G.GAME.blind.chips and next(SMODS.find_card("j_tower_black_slime"))) then -- this is cursed
		return '???'
	end

	return old_number_format(num, ...)
end

Tower.Joker({
	name = "tower-shimmer_bucket",
	key = "shimmer_bucket",
	pos = { x = 6, y = 1 },
	pools = { ["Tower-Terra"] = true },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {}
		}
	end,
	rarity = "tower_transmuted",
	cost = 1,
	atlas = "jokers1",
	blueprint_compat = true,
	
	can_use = function(self, card)
		return Tower.ShimmerCanUse(self, card, Tower.EntComp.GetHighlightedCards({G.consumeables, G.hand, G.pack_cards, G.shop_jokers, G.shop_vouchers, G.shop_booster, G.jokers}, card), nil)
	end,

	use = function(self, card, area, copier)
		Tower.ShimmerUse(self, card, Tower.EntComp.GetHighlightedCards({G.consumeables, G.hand, G.pack_cards, G.shop_jokers, G.shop_vouchers, G.shop_booster, G.jokers}, card))
	end,

    tower_credits = {
		idea = {
			"pikaboy10",
			"jamirror",
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},
})