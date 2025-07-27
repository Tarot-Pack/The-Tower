Tower.Sticker{
	atlas = "stickers",
	pos = { x = 10, y = 10 },
	key = "fuckyou",
	no_sticker_sheet = true,
	badge_colour = HEX("ff0000"),
    rate = 0,
	order = 999999,
    
    sets = {
 		Joker = true,
        ["Playing Card"] = true,
        Consumable = true
 	},

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

    apply = function (self, card, val)
        if val and card.ability.tower_fuckyou then
            local remove_ind = nil
            for i, v in ipairs(G.hand.highlighted) do
                if v == card then
                    remove_ind = i
                    break
                end
            end
            SMODS.destroy_cards({ card })
            if remove_ind ~= nil then
                table.remove(G.hand.highlighted, remove_ind)
            end
            Tower.achieve('clusterfuck_you')
            Tower.create_playing_cards({ 'H_1', 'C_2', 'S_3', 'D_6', 'H_8', 'C_10', 'S_J', 'D_Q'}, {
                edition = "e_negative"
            })
            return
        end
        card.ability.tower_fuckyou = val
    end,
}

Tower.Sticker{
	atlas = "stickers",
	pos = { x = 10, y = 10 },
	key = "notrigger",
	no_sticker_sheet = true,
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
    sets = {
        ["Playing Card"] = true,
 	}
}