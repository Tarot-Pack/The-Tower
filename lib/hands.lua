Tower.PokerHand({
	key = "nil",
	visible = false,
	chips = 0,
	mult = 0,
	l_chips = -5,
	l_mult = -5,
	example = {},
	atlas = "blinds3",
	order_offset = 100000000000000000000000000000,
	visible = false,
	pos = { x = 100, y = 100 },
	evaluate = function(parts, hand)
		local pool = copy_table(G.GAME.tower_nil_pool or {});
		if #pool <= 0 or #hand <= 0 then return false end
		for i, card in ipairs(hand) do
			local good = false
			for q, match in ipairs(pool) do
				if match == "rankless" and SMODS.has_no_rank(card) or match == card:get_id() then 
					table.remove(pool, q)
					good = true
					break
				end
			end
			if not good then return {} end
		end
		return { hand }
	end,
})

function Tower.NillifyCard(cards)
	G.GAME.tower_nil_pool = G.GAME.tower_nil_pool or {}
	for i, card in ipairs(cards) do
		if SMODS.has_no_rank(card) then
			G.GAME.tower_nil_pool[#G.GAME.tower_nil_pool+1] = "rankless"
		else
			G.GAME.tower_nil_pool[#G.GAME.tower_nil_pool+1] = card:get_id()
		end
	end
end

local locca = SMODS.localize_box
function SMODS.localize_box(lines, args)
	lines = lines or {}
	return locca(lines, args)
end