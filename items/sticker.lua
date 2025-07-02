SMODS.Sticker{
	atlas = "stickers",
	pos = { x = 10, y = 10 },
	key = "virus",
	no_sticker_sheet = true,
	badge_colour = HEX("12f254"),
    rate = 0,
	order = 999999,
    sets = {
 		Joker = true,
        ["Playing Card"] = true,
        Consumable = true
 	}
}
Tower.onCalculate(function (context, ret) -- do virus calc in batch
    if context.ending_shop then
        local viruses = {}
        local pool = {}

        for i, v in ipairs(G.jokers.cards) do 
            if not v.ability.tower_virus then 
                pool[#pool+1] = v 
            else
                viruses[#viruses+1] = v
            end
        end
        for i, v in ipairs(G.playing_cards) do 
            if not v.ability.tower_virus then 
                pool[#pool+1] = v 
            else
                viruses[#viruses+1] = v
            end
        end
        for i, v in ipairs(G.consumeables.cards) do 
            if not v.ability.tower_virus then 
                pool[#pool+1] = v 
            else
                viruses[#viruses+1] = v
            end
        end
        for i = 1, #viruses do
            if #pool == 0 then break end

            local center, i = pseudorandom_element(pool, pseudoseed('tower_virus'))
            table.remove(pool, i)
            center.ability.tower_virus = true
        end
        local destroy = {}
        for i, v in ipairs(viruses) do
            if pseudorandom(pseudoseed('tower_virus_break')) <= 0.25 then
                destroy[#destroy+1] = v
            end
        end
        if #destroy == 0 then return end
        SMODS.destroy_cards(destroy)
    end
end)

SMODS.Sticker{
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

SMODS.Sticker{
	atlas = "stickers",
	pos = { x = 10, y = 10 },
	key = "food",
	no_sticker_sheet = true,
	badge_colour = HEX("9174e1"),
    rate = 0,
	order = 999999,
    calculate = function (self, card, context) -- do virus calc in batch
        if context.end_of_round then
            local center = card;
            if not Card.no(center, "immutable", true) then
                check = true
                Cryptid.with_deck_effects(center, function(cards)
                    Cryptid.manipulate(cards, { value = 0.75 })
                end)
            end
        end
    end,
    sets = {
 		Joker = true,
        ["Playing Card"] = true,
        Consumable = true
 	}
}

SMODS.Sticker{
	atlas = "stickers",
	pos = { x = 10, y = 10 },
	key = "notrigger",
	no_sticker_sheet = true,
	badge_colour = HEX("9174e1"),
    rate = 0,
	order = 999999,
    sets = {
        ["Playing Card"] = true,
 	}
}