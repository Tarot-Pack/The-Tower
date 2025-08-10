Tower.Joker({
	name = "tower-Blank",
	key = "blank",
	pos = { x = 1, y = 0 },
	rarity = 1,
	cost = 0,
	atlas = "decks",
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
					colour = G.C.BLUE
				}
			elseif G.GAME.blind_on_deck == 'Big' then
				return {
					message = localize({ type = "variable", key = "a_mult", vars = { card.ability.extra.mult } }),
					mult_mod = to_big(card.ability.extra.mult),
					colour = G.C.RED
				}
			elseif G.GAME.blind_on_deck == 'Boss' then
				return {
					message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } }),
					Xmult_mod = to_big(card.ability.extra.xmult),
					colour = G.C.RED
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
			"pikaboy10"
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
					Xmult_mod = to_big(card.ability.extra.mult) * to_big(amount),
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
			"pikaboy10"
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
			"pikaboy10"
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
			"jamirror"
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
			"pikaboy10"
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
			"pikaboy10"
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
			"jamirror"
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
			"jamirror"
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
			"pikaboy10"
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
			"pikaboy10"
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
			"pikaboy10"
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
			"jamirror"
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
		self:set_cost()
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
			"pikaboy10"
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
	demicoloncompat = true,
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
}, true)

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
		return Tower.Shimmer.CanApply(self, card, Tower.EntComp.GetHighlightedCards({G.consumeables, G.hand, G.pack_cards, G.shop_jokers, G.shop_vouchers, G.shop_booster, G.jokers}, card), nil)
	end,

	use = function(self, card, area, copier)
		Tower.Shimmer.Apply(self, card, Tower.EntComp.GetHighlightedCards({G.consumeables, G.hand, G.pack_cards, G.shop_jokers, G.shop_vouchers, G.shop_booster, G.jokers}, card))
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
	},
})

local old_set_ability = Card.set_ability
function Card:set_ability(...)
	local val = old_set_ability(self, ...)
	if G.TANPAKU_CHECK then
		G.TANPAKU_MODIFIED[#G.TANPAKU_MODIFIED+1] = self;
	end
	self.tower_tanpaku_old = nil
	return val
end

local old_set_seal= Card.set_seal
function Card:set_seal(...)
	local val = old_set_seal(self, ...)
	if G.TANPAKU_CHECK then
		G.TANPAKU_MODIFIED[#G.TANPAKU_MODIFIED+1] = self;
	end
	return val
end

local old_set_base= Card.set_base
function Card:set_base(...)
	local val = old_set_base(self, ...)
	if G.TANPAKU_CHECK then
		G.TANPAKU_MODIFIED[#G.TANPAKU_MODIFIED+1] = self;
	end
	return val
end

Tower.Joker({
	name = "tower-tanpaku",
	key = "tanpaku",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
	display_size = { w = 96, h = 95 },
	pools = { ["Tower-Slime"] = true, ["Tower-Terra"] = true },
	config = {
		extra = {
			copies = 1,
			copies_mod = 1,
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.copies, 
				card.ability.extra.copies_mod, 
			}
		}
	end,
	calculate = function(self, card, context)
		if context.tower_before_consumable_used then
			G.TANPAKU_CHECK = true
			G.TANPAKU_MODIFIED = {}
			for i, area in ipairs({G.consumeables, G.hand, G.pack_cards, G.shop_jokers, G.shop_vouchers, G.shop_booster, G.jokers}) do
				if area then
					for i, v in pairs(area.cards) do
						if card.ability then
							local old = card.ability;
							card.ability = {}
							card.tower_tanpaku_old = old;
							card.ability.tower_tanpaku_old = old;
							setmetatable(card.ability, {
								__index = function (t,k)
									return t.tower_tanpaku_old[k]
								end,
								
								__newindex = function (t,k,v)
									t.tower_tanpaku_old[k] = v   -- update original table
									G.TANPAKU_MODIFIED[#G.TANPAKU_MODIFIED+1] = card;

								end
							})
						end
					end
				end
			end
		end
		if context.using_consumeable then
			card_eval_status_text(
				context.blueprint_cards or card,
				"extra",
				nil,
				nil,
				nil,
				{ message = localize("k_copied_ex") }
			)

			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.7,
				func = function()
					G.TANPAKU_CHECK = nil
					local old_cards = G.TANPAKU_MODIFIED; 
					local cards = {}
					local counted = {}
					for i, v in ipairs(old_cards) do
						if not counted[v.ID] then
							cards[#cards+1] = v;
							counted[v.ID] = true
						end
					end
					G.TANPAKU_MODIFIED = nil;

					for i, area in ipairs({G.consumeables, G.hand, G.pack_cards, G.shop_jokers, G.shop_vouchers, G.shop_booster, G.jokers}) do
						if area then
							for i, v in pairs(area.cards) do
								if card.tower_tanpaku_old then
									card.ability = card.tower_tanpaku_old
								end
							end
						end
					end

					local copies = card.ability.extra.copies
					for i, card in ipairs(cards) do
						for q = 1, copies do
							local _card = SMODS.add_card({
								set = card.config.center.set,
								key = card.config.center.key,
								area = card.area
							})
							copy_card(card, _card)
							if _card.area == G.shop_jokers then
								create_shop_card_ui(_card)
							end
						end
					end
					local old = lenient_bignum(card.ability.extra.copies)
					card.ability.extra.copies = lenient_bignum(to_big(card.ability.extra.copies) + to_big(card.ability.extra.copies_mod))
					Cryptid.apply_scale_mod(card, card.ability.extra.copies_mod, old, card.ability.extra.copies, {
						base = { { "extra", "copies" } },
						scaler = { { "extra", "copies_mod" } },
						scaler_base = { card.ability.extra.copies_mod },
					})


					G.E_MANAGER:add_event(Event({
						func = function()
							local cards = copy_card(context.consumeable)
							cards:add_to_deck()
							G.consumeables:emplace(cards)
							return true
						end,
					}))

					return true
				end
			}), queue)
		end
	end,
	rarity = "tower_transmuted",
	cost = 100,
	atlas = "widejokers",
	order = 2,
	blueprint_compat = true,
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
	},
})


Tower.Joker({
	name = "tower-coinflip",
	key = "coinflip",
	pos = { x = 7, y = 1 },
	pools = { ["Tower-Gambler"] = true },
	config = {
		extra = {
			one = 1,
			two = 2
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.one,
				card.ability.extra.two,
			}
		}
	end,
	rarity = 2,
	cost = 6,
	atlas = "jokers1",
	blueprint_compat = true,

	calculate = function(self, card, context)
		if context.post_trigger then
            local other_card = context.other_context and context.other_context.blueprint_card or context.other_card or nil;
            if other_card == nil or other_card.ability.set ~= 'Joker' then
                -- nope
            elseif pseudorandom(pseudoseed("coinflip")) < ((G.GAME.probabilities.normal * card.ability.extra.one) / card.ability.extra.two) then
                -- yipe
				return {
					message = localize('tower_inverted'),
					func = function ()
						other_card.ability.tower_joker_invert = not (other_card.ability.tower_joker_invert or false);
					end,
					card = other_card
				}
            else
				return {
					message = localize('k_nope_ex')
				}
            end
        elseif context.forcetrigger then -- globally flip
			if pseudorandom(pseudoseed("coinflip")) < ((G.GAME.probabilities.normal * card.ability.extra.one) / card.ability.extra.two) then
				return {
					message = localize('tower_inverted'),
					func = function ()
						G.GAME.tower_global_joker_invert = not (G.GAME.tower_global_joker_invert or false)
					end
				}
			end
		elseif context.joker_main then
		end
	end,
	demicoloncompat = true,
    tower_credits = {
		idea = {
			"cylink"
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
	name = "tower-ying_yang",
	key = "ying_yang",
	pos = { x = 8, y = 1 },
	pools = {  },
	config = {},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {}
		}
	end,
	rarity = 3,
	cost = 7,
	atlas = "jokers1",
	blueprint_compat = true,

	calculate = function(self, card, context)
		if context.post_trigger then
            local other_card = context.other_context and context.other_context.blueprint_card or context.other_card or nil;
            if other_card == nil or other_card.ability.set ~= "Joker" then
                -- nope
			else
                -- yipe
				return {
					message = localize('tower_inverted'),
					func = function ()
						other_card.ability.tower_joker_invert = not (other_card.ability.tower_joker_invert or false);
					end,
					card = other_card
				}
            end
        elseif context.forcetrigger then
			return {
				message = localize('tower_inverted'),
				func = function ()
					G.GAME.tower_global_joker_invert = not (G.GAME.tower_global_joker_invert or false)
				end
			}
		elseif context.joker_main then
		end
	end,
	demicoloncompat = true,
    tower_credits = {
		idea = {
			"cylink"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},

    in_pool = function(self)
        return next(find_joker("tower-coinflip"))
    end 
})

Tower.Joker({
	name = "tower-catalytic_meltdown",
	key = "catalytic_meltdown",
	pos = { x = 9, y = 1 },
	pools = { },
	config = {},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {}
		}
	end,
	rarity = "cry_epic",
	cost = 7,
	atlas = "jokers1",
	blueprint_compat = false,
	init = function ()
		Tower.Shimmer.Into["j_cry_sync_catalyst"] = { "j_tower_catalytic_meltdown" }
		Tower.Shimmer.Into["j_tower_catalytic_meltdown"] = { "j_cry_sync_catalyst" }
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			return {
				message = localize('tower_inverted'),
				func = function()
            		G.GAME.tower_global_joker_invert = not (G.GAME.tower_global_joker_invert or false); -- invert mult and chips globally
				end
			}
        end
	end,

	can_use = function(self, card)
		return true --#Tower.EntComp.GetHighlightedCards({G.jokers}, card) > 0
	end,

	use = function(self, card, area, copier)
		local cards = Tower.EntComp.GetHighlightedCards({G.jokers}, card);
		if #cards > 0 then
			for i, v in ipairs(cards) do
				if v.ability.set == "Joker" then
					v.ability.tower_joker_invert = not (v.ability.tower_joker_invert or false);
				end
			end
		else
			G.GAME.tower_global_joker_invert = not (G.GAME.tower_global_joker_invert or false); -- invert mult and chips globally
		end
	end,

	demicoloncompat = true,
    tower_credits = {
		idea = {
			"cylink"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	},

    in_pool = function(self)
        return next(find_joker("tower-ying_yang"))
    end 
})

Tower.Joker({
	name = "tower-99_percent",
	key = "99_percent",
	pos = { x = 10, y = 1 },
	pools = { ["Tower-Gambler"] = true, ["Meme"] = true },
	config = {},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {}
		}
	end,
	tower_inescapeable = true,
	rarity = 1,
	cost = 1,
	atlas = "jokers1",

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

local old_remove = Card.remove;
function Card:remove(...)
	if G.SETTINGS.paused then
		return old_remove(self, ...)
	end
	if self.config and self.config.center and self.config.center.tower_inescapeable then
		return false
	end
	return old_remove(self, ...)
end
local old_start_dissolve = Card.start_dissolve;
function Card:start_dissolve(...)
	if self.config and self.config.center and self.config.center.tower_inescapeable then
		return false
	end
	return old_start_dissolve(self, ...)
end
local old_shatter = Card.shatter;
function Card:shatter(...)
	if self.config and self.config.center and self.config.center.tower_inescapeable then
		return false
	end
	return old_shatter(self, ...)
end
local old_sell_card = Card.sell_card;
function Card:sell_card(...)
	if self.config and self.config.center and self.config.center.tower_inescapeable then
		return false
	end
	return old_sell_card(self, ...)
end
local old_can_sell_card = Card.can_sell_card;
function Card:can_sell_card(...)
	if self.config and self.config.center and self.config.center.tower_inescapeable then
		return false
	end
	return old_can_sell_card(self, ...)
end

Tower.AfterAllLoaded(function()
	local old_mod_chips = mod_chips;
	local old_mod_mult = mod_mult;
	function mod_chips(_chips)
		if G.tower_global_joker_invert then
			return old_mod_mult(_chips)
		else
			return old_mod_chips(_chips)
		end
	end
	function mod_mult(_mult)
		if G.tower_global_joker_invert then
			return old_mod_chips(_mult)
		else
			return old_mod_mult(_mult)
		end
	end
	local old_update_hand_text = update_hand_text;
	function update_hand_text(config, vals)
		if G.tower_global_joker_invert then
			local old_chips = vals.chips;
			vals.chips = vals.mult
			vals.mult = old_chips
			return old_update_hand_text(config, vals)
		else
			return old_update_hand_text(config, vals)
		end
	end
	local SMODS_calculate_individual_effect = SMODS.calculate_individual_effect;
	function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
		if scored_card and hand_chips ~= nil and mult ~= nil and
		((not (G.GAME.tower_global_joker_invert or false) and (scored_card.ability and scored_card.ability.tower_joker_invert))
			or ((G.GAME.tower_global_joker_invert or false) and (not ((scored_card.ability and scored_card.ability.tower_joker_invert) or false)))) then
			local old_mult = mult
			mult = hand_chips
			hand_chips = old_mult
			G.tower_global_joker_invert = true
			local ret, post = SMODS_calculate_individual_effect(effect, scored_card, key, amount, from_edition);
			G.tower_global_joker_invert = false
			old_mult = mult
			mult = hand_chips
			hand_chips = old_mult
			return ret, post
		else
			return SMODS_calculate_individual_effect(effect, scored_card, key, amount, from_edition);
		end
	end
end)

Tower.Joker({
	name = "tower-die_of_fate",
	key = "die_of_fate",
	pos = { x = 0, y = 0 },

	calculate = function(self, card, context)
		if context.joker_main then
            local number, digits = Tower.RollDie('die_of_fate', '88888888')
--[[
12010873																		= 1-12010873		= 12010873
12010873+17593235																= 12010874-29604108 = 17593235
12010873+17593235+17457012														= 29604109-47061120 = 17457012
12010873+17593235+17457012+17047819												= 47061121-64108939 = 17047819
12010873+17593235+17457012+17047819+16989919									= 64108940-81098858 = 16989919
12010873+17593235+17457012+17047819+16989919+3941256							= 81098859-85040114 = 3941256
12010873+17593235+17457012+17047819+16989919+3941256+3758989					= 85040115-88799103 = 3758989
12010873+17593235+17457012+17047819+16989919+3941256+3758989+88888				= 88799104-88887991 = 88888
12010873+17593235+17457012+17047819+16989919+3941256+3758989+88888+888			= 88887992-88888879 = 888
12010873+17593235+17457012+17047819+16989919+3941256+3758989+88888+888+8		= 88888880-88888887 = 8
12010873+17593235+17457012+17047819+16989919+3941256+3758989+88888+888+8+1		= 88888888-88888888 = 1
]]
			local probabilities = {
				{0,0,0,0,0,0,0,1},
				{1,2,0,1,0,8,7,4},
				{2,9,6,0,4,1,0,9},
				{4,7,0,6,1,1,2,1},
				{6,4,1,0,8,9,4,0},
				{8,1,0,9,8,8,5,9},
				{8,5,0,4,0,1,1,5},
				{8,8,7,9,9,1,0,4},
				{8,8,8,8,7,9,9,2},
				{8,8,8,8,8,8,8,0},
				{8,8,8,8,8,8,8,8}
			}
			function gteq(a, b)
				for i = 1, #a do
					if a[i] > b[i] then
						return true
					elseif a[i] < b[i] then
						return false
					end
				end
				return true
			end
			local item;
			if not card.ability.cry_rigged then
				for i = #probabilities, 1, -1 do
					if gteq(digits, probabilities[i]) then
						item = i;
						break;
					end
				end
			end
			if card.ability.cry_rigged then
				-- rigged is explosion
				return {
					message = (G.localization.descriptions.Other.cry_rigged.name) .. ": " .. localize('k_nope_ex')
				}
			elseif item == 1 then
				-- do nothing
				return {
					message = number .. ": " .. localize('k_nope_ex')
				}
			elseif item == 2 then -- X2 Mult
				return {
					message = number .. ": " .. localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.line_one } }),
					Xmult_mod = card.ability.extra.line_one,
					colour = G.C.RED
				}
			elseif item == 3 then -- X2 Chips
				return {
					message = number .. ": " .. localize({ type = "variable", key = "a_xchips", vars = { card.ability.extra.line_two } })[1],
					Xchip_mod = card.ability.extra.line_two,
					colour = G.C.BLUE
				}
			elseif item == 4 then -- X0.5 Mult
				return {
					message = number .. ": " .. localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.line_three } }),
					Xmult_mod = card.ability.extra.line_three,
					colour = G.C.RED
				}
			elseif item == 5 then -- X0.5 Chips
				return {
					message = number .. ": " .. localize({ type = "variable", key = "a_xchips", vars = { card.ability.extra.line_four } })[1],
					Xchip_mod = card.ability.extra.line_four,
					colour = G.C.BLUE
				}
			elseif item == 6 then -- X4 Mult
				return {
					message = number .. ": " .. localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.line_five } }),
					Xmult_mod = card.ability.extra.line_five,
					colour = G.C.RED
				}
			elseif item == 7 then -- X4 Chips
				return {
					message = number .. ": " .. localize({ type = "variable", key = "a_xchips", vars = { card.ability.extra.line_six } })[1],
					Xchip_mod = card.ability.extra.line_six,
					colour = G.C.BLUE
				}
			elseif item == 8 then -- ^4 Mult and Chips
				return {
					message = number .. ": " .. Tower.EntComp.FormatArrowMult(1, card.ability.extra.line_seven) .. ' Mult and Chips',
					Emult_mod = card.ability.extra.line_five,
					Echip_mod = card.ability.extra.line_five,
					colour = G.C.DARK_EDITION
				}
			elseif item == 9 then -- ^^4 Mult and Chips
				return {
					message = number .. ": " .. Tower.EntComp.FormatArrowMult(2, card.ability.extra.line_eight) .. ' Mult and Chips',
					EEmult_mod = card.ability.extra.line_six,
					EEchip_mod = card.ability.extra.line_five,
					colour = G.C.DARK_EDITION
				}
			elseif item == 10 then -- {8888888}8 Mult and Chips
				local value = '{8888888}' .. number_format(card.ability.extra.line_nine_number)
				if card.ability.extra.line_nine_arrows_changed ~= 1 then -- variable to check if changed
					value = Tower.EntComp.FormatArrowMult(card.ability.extra.line_nine_arrows, card.ability.extra.line_nine_number)
				end

				return {
					message = number .. ": " .. value .. ' Mult and Chips',
					hyperchip_mod = {card.ability.extra.line_nine_arrows, card.ability.extra.line_nine_number},
					hypermult_mod = {card.ability.extra.line_nine_arrows, card.ability.extra.line_nine_number},
					colour = G.C.DARK_EDITION
				}
			elseif item == 11 and G.P_CENTERS.c_tower_unbounded_pointer then -- UNBOUNDED POINTER
				local _card = create_card(
					"Consumeables",
					G.consumeables,
					nil,
					nil,
					nil,
					nil,
					"c_tower_unbounded_pointer",
					"die_of_fate"
				)
				_card:add_to_deck()
				G.consumeables:emplace(_card)				
				return {
					message = localize("tower_die_of_fate_pointer"),
					colour = G.C.RARITY.tower_apollyon
				}
			end
        end
	end,

	display_size = { w = 89, h = 89 },
	pools = { ["Tower-Gambler"] = true },
	config = {
		extra = {
			line_one = 2,
			line_two = 2,
			line_three = 0.5,
			line_four = 0.5,
			line_five = 4,
			line_six = 4,
			line_seven = 4,
			line_eight = 4,
			line_nine_arrows = 8888888,
			line_nine_arrows_changed = 1,
			line_nine_number = 8,
		}
	},

	loc_vars = function(self, info_queue, card)
		local value = '{8888888}' .. number_format(card.ability.extra.line_nine_number)
		if card.ability.extra.line_nine_arrows_changed ~= 1 then -- variable to check if changed
			value = Tower.EntComp.FormatArrowMult(card.ability.extra.line_nine_arrows, card.ability.extra.line_nine_number)
		end
		info_queue[#info_queue+1] = G.P_CENTERS.desc_tower_unbounded_pointer
		return {
			vars = {
				card.ability.extra.line_one,
				card.ability.extra.line_two,
				card.ability.extra.line_three,
				card.ability.extra.line_four,
				card.ability.extra.line_five,
				card.ability.extra.line_six,
				card.ability.extra.line_seven,
				card.ability.extra.line_eight,
				value
			}
		}
	end,
	
	rarity = 2,
	cost = 8,
	atlas = "tower_squarejokers",

    tower_credits = {
		idea = {
			"cylink"
		},
		art = {
			"jamirror",
		},
		code = {
			"jamirror",
		},
	}
})

Tower.Consumable({ -- unbounded pointer
	cry_credits = {
		idea = {
			"HexaCryonic",
		},
		art = {
			"HexaCryonic",
		},
		code = {
			"Math",
		},
	},
	dependencies = {
		items = {
			"c_cry_pointer"
		},
	},
	config = {cry_multiuse = 1e300},
	object_type = "Consumable",
	set = "Spectral",
	name = "cry-Pointer",
	key = "unbounded_pointer",
	pos = { x = 11, y = 3 },
	hidden = true,
	no_collection = true,
	order = 20001,
	atlas = "cry_atlasnotjokers",
	prefix_config = { atlas = false, key = true },
	can_use = function(self, card)
		return G.P_CENTERS.c_cry_pointer.can_use(self, card)
	end,
	use = function(self, card, area, copier)
		card.ability.cry_multiuse = 1e300;
		G.GAME.USING_CODE = true
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.USING_POINTER = true
				G.GAME.TOWER_POINTER_UNBOUNDED = true
				G.FUNCS.overlay_menu({ definition = create_UIBox_your_collection() })
				return true
			end,
		}))
		G.GAME.POINTER_SUBMENU = nil
	end
})

local old_upt = Game.update
function Game:update(dt)
	old_upt(self, dt)
	local anim_timer = self.TIMERS.REAL * 1.5
	local p = 0.5 * (math.sin(anim_timer) + 1)
	if G.P_CENTERS and G.P_CENTERS.c_tower_unbounded_pointer and cry_pointer_dt > 0.5 then
		cry_pointer_dt = 0
		local pointerobj = G.P_CENTERS.c_tower_unbounded_pointer
		pointerobj.pos.x = (pointerobj.pos.x == 11) and 12 or 11
	end
end


local old_exit_overlay_menu_code = G.FUNCS.exit_overlay_menu_code;
function G.FUNCS.exit_overlay_menu_code(...)
    if G.GAME.TOWER_POINTER_UNBOUNDED then
		G.GAME.TOWER_POINTER_UNBOUNDED = nil
	end
    return old_exit_overlay_menu_code(...)
end

Tower.AfterAllLoaded(function()
	Cryptid.pointerblistify('c_tower_unbounded_pointer')
	local ref = Cryptid.pointergetblist
	function Cryptid.pointergetblist(target)
		target = Cryptid.pointergetalias(target) or target
		if target == "c_tower_unbounded_pointer" then
			return {false, false, false} -- *****NO***** privilege escalation in my house
			-- continuing: there are some modded consumables that 'unbound' pointer like i do
			-- but still have some minor restrictions. these could be bypassed if i don't
			-- manually block it (as well as adding it to the regular blist) because my
			-- pointer can spawn any card, aside from blinds, meaning if a pointer spawns 
			-- this it 'privilege escalates' and is able to do more than originally intented
		end
		if G.GAME.TOWER_POINTER_UNBOUNDED then
			local old_a = Cryptid.pointerblisttype;
			local old_b = Cryptid.pointerblist
			Cryptid.pointerblisttype = {}
			local blist = {}
			for i, v in pairs(Cryptid.pointerblist) do
				if G.P_BLINDS[v] then
					blist[#blist + 1] = v
				end
			end
			Cryptid.pointerblist = blist
			local val = ref(target)
			Cryptid.pointerblisttype = old_a
			Cryptid.pointerblist = old_b
			return val
		end
		return ref(target)
	end
end)

Tower.Joker({
	name = "tower-die_of_chaos",
	key = "die_of_chaos",
	pos = { x = 1, y = 0 },

	calculate = function(self, card, context)
		if context.joker_main then
            local number, digits = Tower.RollDie('die_of_chaos', '22222222')

			local operand = 'chips'
			if math.fmod(digits[#digits-1], 2) == 1 then
				operand = 'mult'
			end			
			local probabilities = {
				{0,0,0,0,0,0,0,1},
				{0,2,0,2,0,2,0,2},
				{0,4,0,4,0,4,0,4},
				{0,6,0,6,0,6,0,6},
				{0,8,0,8,0,8,0,8},
				{1,0,1,0,1,0,1,0},
				{1,2,1,2,1,2,1,2},
				{1,4,1,4,1,4,1,4},
				{1,6,1,6,1,6,1,6},
				{1,8,1,8,1,8,1,8},
				{2,0,2,0,2,0,2,0},
			}
			function gteq(a, b)
				for i = 1, #a do
					if a[i] > b[i] then
						return true
					elseif a[i] < b[i] then
						return false
					end
				end
				return true
			end
			local item;
			if not card.ability.cry_rigged then
				for i = #probabilities, 1, -1 do
					if gteq(digits, probabilities[i]) then
						item = i;
						break;
					end
				end
			end
			print(item)
			if card.ability.cry_rigged then -- eq to op = 6
				-- rigged is explosion
				if operand == 'mult' then
					return {
						message = (G.localization.descriptions.Other.cry_rigged.name) .. ": " .. localize({ type = "variable", key = "a_mult", vars = { card.ability.extra[6] } }),
						mult_mod = card.ability.extra[6],
						colour = G.C.RED
					}
				else
					return {
						message = (G.localization.descriptions.Other.cry_rigged.name) .. ": " .. localize({ type = "variable", key = "a_chips", vars = { card.ability.extra[6] } }),
						chip_mod = card.ability.extra[6],
						colour = G.C.BLUE
					}
				end
			elseif item == 6 then -- item 6
				-- + mult or chips
				if operand == 'mult' then
					return {
						message = number .. ": "  .. localize({ type = "variable", key = "a_mult", vars = { card.ability.extra[6] } }),
						mult_mod = card.ability.extra[6],
						colour = G.C.RED
					}
				else
					return {
						message = number .. ": "  .. localize({ type = "variable", key = "a_chips", vars = { card.ability.extra[6] } }),
						chip_mod = card.ability.extra[6],
						colour = G.C.BLUE
					}
				end
			elseif (item == 5) or (item == 7) then -- item 5 and 7
				if operand == 'chips' then
					return {
						message = number .. ": " .. Tower.EntComp.FormatArrowMult(4, card.ability.extra[item]) .. ' Chips',
						Xchip_mod = {0, card.ability.extra[item]},
						colour = G.C.BLUE
					}
				else
					return {
						message = number .. ": " .. Tower.EntComp.FormatArrowMult(4, card.ability.extra[item]) .. ' Mult',
						hypermult_mod = {0, card.ability.extra[item]},
						colour = G.C.RED
					}
				end
			elseif item < 5 then -- item 1-4 
				if operand == 'chips' then
					return {
						message = number .. ": " .. Tower.EntComp.FormatArrowMult(4, card.ability.extra[item]) .. ' Chips',
						hyperchip_mod = {5 - item, card.ability.extra[item]},
						colour = G.C.DARK_EDITION
					}
				else
					return {
						message = number .. ": " .. Tower.EntComp.FormatArrowMult(4, card.ability.extra[item]) .. ' Mult',
						hypermult_mod = {5 - item, card.ability.extra[item]},
						colour = G.C.DARK_EDITION
					}
				end
			else -- item 8-11
				if operand == 'chips' then
					return {
						message = number .. ": " .. Tower.EntComp.FormatArrowMult(4, card.ability.extra[item]) .. ' Chips',
						hyperchip_mod = {item - 7, card.ability.extra[item]},
						colour = G.C.DARK_EDITION
					}
				else
					return {
						message = number .. ": " .. Tower.EntComp.FormatArrowMult(4, card.ability.extra[item]) .. ' Mult',
						hypermult_mod = {item - 7, card.ability.extra[item]},
						colour = G.C.DARK_EDITION
					}
				end
			end
        end
	end,

	display_size = { w = 89, h = 89 },
	pools = { ["Tower-Gambler"] = true },
	config = {
		extra = {
			1.2,	-- ^^^^1.2
			1.15,	-- ^^^1.15
			1.1,	-- ^^1.1
			1.1,	-- ^1.1
			1.1,	-- X1.1
			1,		-- +1
			0.9,	-- X0.9
			0.9,	--- ^0.9
			0.9,	-- ^^0.9
			0.85,	-- ^^^0.86
			0.8,	-- ^^^^0.8
		}
	},

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra[1],
				card.ability.extra[2],
				card.ability.extra[3],
				card.ability.extra[4],
				card.ability.extra[5],
				card.ability.extra[6],
				card.ability.extra[7],
				card.ability.extra[8],
				card.ability.extra[9],
				card.ability.extra[10],
				card.ability.extra[11],
			}
		}
	end,

	rarity = 2,
	cost = 8,
	atlas = "tower_squarejokers",

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
	name = "tower-die_of_will",
	key = "die_of_will",
	pos = { x = 2, y = 0 },

	calculate = function(self, card, context)
		if context.game_over then
            local number, digits = Tower.RollDie('die_of_will', '11111111')
	
			local probabilities = {
				{0,0,0,0,0,0,0,1},
				{0,1,1,5,4,1,7,4},
				{0,2,2,7,7,6,6,6},
				{0,3,3,8,1,4,5,1},
				{0,4,5,3,6,8,8,7},
				{0,5,6,6,0,4,2,2},
				{0,6,7,9,0,9,9,5},
				{0,7,9,0,5,2,0,6},
				{0,9,0,1,9,7,3,1},
				{1,0,1,3,1,1,9,2},
			}
			function gteq(a, b)
				for i = 1, #a do
					if a[i] > b[i] then
						return true
					elseif a[i] < b[i] then
						return false
					end
				end
				return true
			end
			local item;
			if not card.ability.cry_rigged then
				for i = #probabilities, 1, -1 do
					if gteq(digits, probabilities[i]) then
						item = i;
						break;
					end
				end
			end
			if card.ability.cry_rigged then
				if to_big(G.GAME.chips / G.GAME.blind.chips) >= to_big("0.9") then
					return {
						message = (G.localization.descriptions.Other.cry_rigged.name) .. " (90%): " .. "Saved",
						saved = true
					}
				end
			else
				if to_big(G.GAME.chips / G.GAME.blind.chips) >= to_big((9 - (item - 1))/10) then -- percent is from 90%-0%
					return {
						message = tostring(number) .. " (" .. tostring((9 - (item - 1)) * 10) .."%): " .. "Saved",
						saved = true
					}
				end
			end
        end
	end,

	display_size = { w = 89, h = 89 },
	pools = { ["Tower-Gambler"] = true },
	config = {
		extra = {}
	},

	rarity = 2,
	cost = 8,
	atlas = "tower_squarejokers",

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
	name = "tower-die_of_echoes",
	key = "die_of_echoes",
	pos = { x = 3, y = 0 },

	calculate = function(self, card, context)
		if context.joker_main then
            local number, digits = Tower.RollDie('die_of_echoes', '44444444')

			local operand = 'chips'
			if math.fmod(digits[#digits-1], 2) == 1 then
				operand = 'mult'
			end			
			local probabilities = {
				{0,0,0,0,0,0,0,1}, -- 8080808
				{0,8,0,8,0,8,0,8}, -- 5050505
				{1,3,1,3,1,3,1,3}, -- 2020202
				{1,5,1,5,1,5,1,5}, -- 1010101
				{1,6,1,6,1,6,1,6}, -- 	12121212
				{2,8,2,8,2,8,2,8}, -- 1010101
				{2,9,2,9,2,9,2,9}, -- 2020202
				{3,1,3,1,3,1,3,1}, -- 5050505
				{3,6,3,6,3,6,3,6}, -- 8080808
			}
			function gteq(a, b)
				for i = 1, #a do
					if a[i] > b[i] then
						return true
					elseif a[i] < b[i] then
						return false
					end
				end
				return true
			end
			local item;
			if not card.ability.cry_rigged then
				for i = #probabilities, 1, -1 do
					if gteq(digits, probabilities[i]) then
						item = i;
						break;
					end
				end
			end
			local message = '';
			local amount = card.ability.extra.amount;
			local old = lenient_bignum(card.ability.extra.amount)
			if item == 5 or card.ability.cry_rigged then -- Nope!
				message = localize('k_nope_ex');
			else -- XMult
				card.ability.extra.amount = lenient_bignum(to_big(card.ability.extra.amount) * to_big(card.ability.extra[item]))
				message = Tower.EntComp.FormatArrowMult(0, card.ability.extra[item])
			end
			if item ~= 5 then
				Cryptid.apply_scale_mod(card, card.ability.extra[item], old, card.ability.extra.amount, {
					base = { { "extra", "amount" } },
					scaler = { { "extra", item } },
					scaler_base = { card.ability.extra[item] },
				})
			end
			return {
				message = number .. ": "  .. localize({ type = "variable", key = "a_mult", vars = { card.ability.extra.amount } }) .. ' (' .. message .. ')',
				mult_mod = card.ability.extra.amount,
				colour = G.C.RED
			}
        end
	end,

	display_size = { w = 89, h = 89 },
	pools = { ["Tower-Gambler"] = true },
	config = {
		extra = {
			0,
			1.1,
			1.15,
			1.2,
			1.25,
			1.3,
			1.35,
			1.4,
			1.45,
			amount = 5
		}
	},

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra[2],
				card.ability.extra[3],
				card.ability.extra[4],
				card.ability.extra[5],
				card.ability.extra[6],
				card.ability.extra[7],
				card.ability.extra[8],
				card.ability.extra[9],
				card.ability.extra.amount
			}
		}
	end,

	rarity = 2,
	cost = 8,
	atlas = "tower_squarejokers",

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
	name = "tower-forgotten_die",
	key = "forgotten_die",
	pos = { x = 4, y = 0 },

	display_size = { w = 89, h = 89 },
	pools = { ["Tower-Gambler"] = true },
	config = {
		extra = {}
	},

	rarity = 2,
	cost = 8,
	atlas = "tower_squarejokers",

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

local Card_update = Card.update
function Card:update(...)
	if next(find_joker('tower-forgotten_die')) and (self.ability.tower_forgotten_choice == nil) then
		self.ability.tower_forgotten_choice = pseudorandom(pseudoseed('forgotten_die')) > 0.5
	elseif not (next(find_joker('tower-forgotten_die'))) then
		self.ability.tower_forgotten_choice = nil
	end
	return Card_update(self, ...)
end
local Card_use_consumeable = Card.use_consumeable
function Card:use_consumeable(...)
	local ggpn = G.GAME.probabilities.normal;
	if next(find_joker('tower-forgotten_die')) and (self.ability.tower_forgotten_choice == nil) then
		self.ability.tower_forgotten_choice = pseudorandom(pseudoseed('forgotten_die')) > 0.5
	elseif not (next(find_joker('tower-forgotten_die'))) then
		self.ability.tower_forgotten_choice = nil
	end
	if self.ability.tower_forgotten_choice ~= nil then
		if self.ability.tower_forgotten_choice then
			G.GAME.probabilities.normal = 1e9
		else
			G.GAME.probabilities.normal = 0
		end
	end
	local val = Card_use_consumeable(self, ...)
	G.GAME.probabilities.normal = ggpn
	return val
end