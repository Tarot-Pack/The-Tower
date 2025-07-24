
local old_evaluate_poker_hand = evaluate_poker_hand

function evaluate_poker_hand(_h)
    local hand = {}
    for i, v in pairs(_h) do
        if not v.config.center.tower_no_handtype then
            hand[#hand+1] = v
        end
    end
    local results = old_evaluate_poker_hand(hand)
    if G.GAME.tower_exploit_override and not G.GAME.cry_exploit_override then
        if not results[G.GAME.tower_exploit_override][1] then
            for _, v in ipairs(G.handlist) do
                if results[v][1] then
                    results[G.GAME.tower_exploit_override] = results[v]
                    break
                end
            end
        end
    end

    return results
end

SMODS.Enhancement({
	key = "crystal",
    name = "tower-crystal",
    atlas = "enhance",
	order = 30,
	weight = 1,
	in_shop = false,
	extra_cost = 2,
    replace_base_card = true,
    no_suit = true,
    no_rank = true,
    always_scores = true,
    config = {
        bonus = 100,
        extra = 4
    },
    loc_vars = function(self)
        return {
            vars = { self.config.bonus, 1, self.config.extra }
        }
    end,
	get_weight = function(self)
		return 0 -- no
	end,
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and pseudorandom('crystal') < G.GAME.probabilities.normal/card.ability.extra then
            card:set_ability(G.P_CENTERS.c_base, true, nil)
        end
    end
})
SMODS.Enhancement({
	key = "blank",
    name = "tower-blank",
    atlas = "centers",
	order = 30,
	weight = 1,
	in_shop = false,
	extra_cost = -5,    
    replace_base_card = true,
    no_suit = true,
    no_rank = true,
    never_scores = true,
    tower_no_handtype = true,
    pos = { x = 1, y = 0 },

	get_weight = function(self)
		return 0 -- no
	end,
})