Tower.Fortune{
    key = 'jack',
    pos = {x = 1, y = 0},
    discovered = true,
    no_doe = true,
    atlas = "fortunes",
    config = {
        extra = {
            retriggers = 1,
            boost_numerator = 1,
            boost_denominator = 4,
        },
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.retriggers,
                SMODS.get_probability_vars(card, card.ability.extra.boost_numerator, card.ability.extra.boost_denominator, 'tower-fortune')
            }
        }
    end,
    secondary_loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.retriggers
            }
        }
    end,
    tower_boost = function (center)
        local print = {
            j_blueprint = true
        }
        if print[center.key] or Cryptid.safe_get(center, "pools", "Print") then
            return true
        end
    end,
}
Tower.Fortune{
    key = 'egg',
    pos = {x = 2, y = 0},
    discovered = true,
    no_doe = true,
    atlas = "fortunes",
    config = {
        extra = {
            boost_numerator = 1,
            boost_denominator = 4,
        },
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                SMODS.get_probability_vars(card, card.ability.extra.boost_numerator, card.ability.extra.boost_denominator, 'tower-fortune')
            }
        }
    end,
    tower_boost = function (center)
        local egg = {
            j_egg = true,
            j_cry_megg = true
        }
        if egg[center.key] or Cryptid.safe_get(center, "pools", "Egg") then
            return true
        end
    end,
	calc_scaling = function(self, card, other, current_scaling, current_scalar, args)
        if self.tower_boost(joker.config.center) then
            return {
				scalar_value = lenient_bignum(to_big(current_scaling) * 2),
				message = localize("k_upgrade_ex"),
			}
        end
	end,
}
SMODS.Joker:take_ownership("egg", {
    calculate = function (self, card, context)
        if context.end_of_round and (not context.blueprint) and (not context.individual) and (not context.repetition) then
            card.ability.extra_value = lenient_bignum(to_big(card.ability.extra_value) + to_big(card.ability.extra))
            if (to_big(card.ability.extra_value) + to_big(card.base_cost)) > to_big(1e300) then
                card.ability.extra_value = to_number(to_big(1e300) - to_big(card.base_cost)) -- add sanity check for egg because of the egg fortune
                -- (this code will make the cost exactly 1e300)
            end
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end
}, true)
Tower.AfterAllLoaded(function()
SMODS.Joker:take_ownership("j_cry_megg", {
	calculate = function(self, card, context)
		if
			context.end_of_round
			and to_big(card.ability.extra.amount) < to_big(card.ability.immutable.max_amount)
			and not (context.individual or context.repetition or context.blueprint)
		then
			card.ability.extra.amount =
				lenient_bignum(card.ability.extra.amount + math.max(1, to_big(card.ability.extra.amount_mod)))
            for i, v in ipairs(G.fortunes or {}) do
                print(v.config.center.key)
                if v.config.center.key == "fortune_tower_egg" then
                    card.ability.extra.amount_mod = lenient_bignum(to_big(card.ability.extra.amount_mod) * to_big(2))
                    card_eval_status_text(
                        v,
                        "extra",
                        nil,
                        nil,
                        nil,
                        { message = localize("k_upgrade_ex") }
                    )
                end
            end
			if to_big(card.ability.extra.amount) > to_big(card.ability.immutable.max_amount) then
				card.ability.extra.amount = lenient_bignum(card.ability.immutable.max_amount)
			end
			card_eval_status_text(
				card,
				"extra",
				nil,
				nil,
				nil,
				{ message = { localize("cry_jolly_ex") }, colour = G.C.FILTER }
			)
			return nil, true
		end
		if
			context.selling_self
			and not (context.blueprint or context.retrigger_joker_check or context.retrigger_joker)
			and to_big(card.ability.extra.amount) > to_big(0)
		then
			for i = 1, math.min(card.ability.immutable.max_amount, math.floor(card.ability.extra.amount)) do
				local jolly_card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_jolly")
				jolly_card:add_to_deck()
				G.jokers:emplace(jolly_card)
			end
		end
		if context.forcetrigger then
			card.ability.extra.amount =
				lenient_bignum(card.ability.extra.amount + math.max(1, to_big(card.ability.extra.amount_mod)))
            for i, v in ipairs(G.fortunes or {}) do
                if v.config.center.key == "fortune_tower_egg" then
                    card.ability.extra.amount_mod = lenient_bignum(to_big(card.ability.extra.amount_mod) * to_big(2))
                    card_eval_status_text(
                        v,
                        "extra",
                        nil,
                        nil,
                        nil,
                        { message = localize("k_upgrade_ex") }
                    )
                end
            end
			if to_big(card.ability.extra.amount) > to_big(card.ability.immutable.max_amount) then
				card.ability.extra.amount = lenient_bignum(card.ability.immutable.max_amount)
			end
			for i = 1, math.min(card.ability.immutable.max_amount, math.floor(card.ability.extra.amount)) do
				local jolly_card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_jolly")
				jolly_card:add_to_deck()
				G.jokers:emplace(jolly_card)
			end
		end
	end
}, true)
end)
Tower.Fortune{
    key = 'lucky',
    pos = {x = 3, y = 0},
    discovered = true,
    no_doe = true,
    atlas = "fortunes",
    config = {
        extra = {
            lucky_amount = 1,
            lucky_amount_mod = 0.1,
            boost_numerator = 1,
            boost_denominator = 4,
        },
    },
    tower_boost = function (center)
        if Cryptid.safe_get(center, "pools", "ProbabilityJoker") then
            return true
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.lucky_amount,
                card.ability.extra.lucky_amount_mod,
                SMODS.get_probability_vars(card, card.ability.extra.boost_numerator, card.ability.extra.boost_denominator, 'tower-fortune')
            }
        }
    end,
    secondary_loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.lucky_amount,
                card.ability.extra.lucky_amount_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.pseudorandom_result and context.result then
            card.ability.extra.lucky_amount = card.ability.extra.lucky_amount + card.ability.extra.lucky_amount_mod
            return {
                message = localize('k_upgrade_ex')
            }
        elseif context.mod_probability then
            return {
                numerator = context.numerator * card.ability.extra.lucky_amount
            }
        end
    end, 
}