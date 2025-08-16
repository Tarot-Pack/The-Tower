local old_inject = SMODS.ObjectType.inject_card;
local old_delete = SMODS.ObjectType.delete_card;
SMODS.ObjectType.inject_card = function (self, c)
	if not self.tower_rarities then
		self.tower_rarities = {}
	end
	local vanilla_rarities = {"Common", "Uncommon", "Rare", "Legendary"}
	local rarity = c.rarity;
	if vanilla_rarities[rarity] then
		rarity = vanilla_rarities[rarity];
	end
	rarity = rarity or "spec_none"
	if not self.tower_rarities[rarity] then
		self.tower_rarities[rarity] = {};
	end
	local found = false;
	for i = 1, #self.tower_rarities[rarity] do
		if self.tower_rarities[rarity][i].key == c.key then
			self.tower_rarities[rarity][i] = c
			found = true
			break
		end
	end
	if not found then
		self.tower_rarities[rarity][#self.tower_rarities[rarity] + 1] = c
	end
	if #self.tower_rarities[rarity] < 1 then
		self.tower_rarities[rarity] = nil
	end
	return old_inject(self, c)
end
SMODS.ObjectType.delete_card = function (self, c)
	if not self.tower_rarities then
		self.tower_rarities = {}
	end
	local vanilla_rarities = {"Common", "Uncommon", "Rare", "Legendary"}
	local rarity = c.rarity;
	if vanilla_rarities[rarity] then
		rarity = vanilla_rarities[rarity];
	end
	if not self.tower_rarities[rarity] then
		self.tower_rarities[rarity] = {};
	end

	for i = 1, #self.tower_rarities[rarity] do
		if self.tower_rarities[rarity][i].key == c.key then
			table.remove(self.tower_rarities[rarity], i)
			break
		end
	end
	if #self.tower_rarities[rarity] < 1 then
		self.tower_rarities[rarity] = nil
	end
	return old_delete(self, c)
end
Tower.Atlas({
	key = "modicon",
	path = "tower_icon.png",
	px = 32,
	py = 32,
})

Tower.Atlas({
	key = "tower_squarejokers",
	path = "tower_squarejokers.png",
	px = 89,
	py = 89,
})

Tower.Atlas({
	key = "blinds",
	atlas_table = "ANIMATION_ATLAS",
	path = "tower_blind.png",
	px = 34,
	py = 34,
	frames = 21,
})

Tower.Atlas({
	key = "blinds2",
	atlas_table = "ANIMATION_ATLAS",
	path = "tower_blind2.png",
	px = 34,
	py = 34,
	frames = 21,
})

Tower.Atlas({
	key = "blinds3",
	atlas_table = "ANIMATION_ATLAS",
	path = "tower_blind3.png",
	px = 34,
	py = 34,
	frames = 21,
})

Tower.Atlas({
	key = "blinds4",
	atlas_table = "ANIMATION_ATLAS",
	path = "tower_blind4.png",
	px = 34,
	py = 34,
	frames = 21,
})
Tower.Atlas({
	key = "blinds5",
	atlas_table = "ANIMATION_ATLAS",
	path = "tower_blind5.png",
	px = 34,
	py = 34,
	frames = 21,
})

Tower.Atlas({
	key = "blind_lovers",
	atlas_table = "ANIMATION_ATLAS",
	path = "tower_blind_lovers.png",
	px = 34,
	py = 39,
	frames = 21,
})

Tower.Atlas({
	key = "rank",
	path = "tower_rank.png",
	px = 71,
	py = 95
})

Tower.Atlas({
	key = "rank_hc",
	atlas_table = "ANIMATION_ATLAS",
	path = "tower_rank_hc.png",
	px = 71,
	py = 95
})

Tower.Atlas({
	key = "enhance",
	path = "tower_enhance.png",
	px = 71,
	py = 95
})

Tower.Atlas({
	key = "book",
	path = "tower_book.png",
	px = 73,
	py = 97
})

Tower.Atlas({
	key = "stickers",
	path = "tower_stickers.png",
	px = 71,
	py = 95
})

Tower.Atlas({
	key = "widejokers",
	path = "tower_widejokers.png",
	px = 96,
	py = 95
})

Tower.Atlas({
	key = "achievements",
	path = "tower_achievements.png",
	px = 66,
	py = 66,
})

Tower.Atlas({
	key = "jokers1",
	path = "tower_jokers1.png",
    px = 71,
    py = 95
})

Tower.Atlas({
	key = "prints",
	path = "tower_prints.png",
    px = 71,
    py = 95
})

Tower.Atlas({
	key = "consumables",
	path = "tower_consumables.png",
    px = 71,
    py = 95
})

Tower.Atlas({
	key = "madness_core",
	path = "tower_madness_core.png",
    px = 71,
    py = 95
})

Tower.Atlas({
	key = "description_cards",
	path = "tower_descriptioncards.png",
    px = 71,
    py = 95
})

Tower.Atlas({
	key = "pack",
	path = "tower_boosters.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "decks",
	path = "tower_decks.png",
	px = 71,
	py = 95
})

SMODS.Atlas({
	key = "sleeves",
	path = "tower_sleeves.png",
	px = 71,
	py = 95
})

SMODS.Atlas({
	key = "bigslime",
	path = "tower_bigslime.png",
	px = 171,
	py = 115
})

SMODS.ObjectType({
	key = "Tower-Slime",
	default = "j_tower_king_slime",
	cards = {}
})

SMODS.ObjectType({
	key = "Tower-pikaboy10",
	default = "j_tower_king_slime",
	cards = {}
})

SMODS.ObjectType({
	key = "Tower-jamirror",
	default = "j_tower_blank",
	cards = {}
})

SMODS.ObjectType({
	key = "Tower-cylink",
	default = "j_tower_coinflip",
	cards = {}
})

SMODS.ObjectType({
	key = "Tower-Terra",
	default = "j_tower_eye_of_cthulhu",
	cards = {}
})

Tower.TransmutedGrad = SMODS.Gradient {
	key = 'transmuted_grad',
	colours = { HEX('5a5efa'), HEX('6e44f7'), HEX('a534de'), HEX('dc5392'), HEX('e38e8d') },
	cycle = 1,
}

Tower.ChipMultGrad = SMODS.Gradient {
	key = 'chipmult_grad',
	colours = { HEX('FE5F55'), {0.8, 0.45, 0.85, 1}, HEX("009dff"), {0.8, 0.45, 0.85, 1} },
	cycle = 5,
}

SMODS.Rarity({
	key = "transmuted",
	loc_txt = {},
	badge_colour = Tower.TransmutedGrad,
	default = "j_tower_shimmer_slime",
})

SMODS.Rarity({
	key = "unique",
	loc_txt = {},
	badge_colour = HEX('333333')
})

SMODS.ConsumableType({
	key = "transmuted",
	prefix_config = { key = true },
	primary_colour = Tower.TransmutedGrad,
	secondary_colour = Tower.TransmutedGrad,
	collection_rows = { 4, 4 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_tower_aether_monolith",
	can_stack = true,
	can_divide = true,
	no_collection = true
})

SMODS.Rarity({
	key = "apollyon",
	loc_txt = {},
	badge_colour = SMODS.Gradient {
        key = 'apollyon_grad',
        colours = { HEX('ff0000'), HEX('e4a92e'), HEX('2ec4df'), HEX('2f52f2'), HEX('ec2fa5') },
        cycle = 1,
    },
	default = "j_tower_pinky",
})


SMODS.ContentSet({
	key = "blinds",
	atlas = "blinds",
	pos = { x = 0, y = 15 },
	cry_blind = true,
	cry_order = -5,
})

SMODS.ContentSet({
	key = "misc",
	atlas = "jokers1",
	pos = { x = 0, y = 2 },
	cry_order = -4,
})

SMODS.ContentSet({
	key = "slime",
	atlas = "jokers1",
	pos = { x = 2, y = 0 },
	cry_order = -3,
})

SMODS.ContentSet({
	key = "terraria",
	atlas = "jokers1",
	pos = { x = 2, y = 1 },
	cry_order = -2,
})

SMODS.ContentSet({
	key = "transmuted",
	atlas = "consumables",
	pos = { x = 3, y = 0 },
	cry_order = -1,
})

SMODS.ContentSet({
	key = "apollyon",
	atlas = "jokers1",
	pos = { x = 5, y = 0 },
	soul_pos = { x = 6, y = 0, extra = { x = 7, y = 0 } },
	cry_order = 0,
})

SMODS.DescriptionCard({
	key = "unbounded_pointer",
	atlas = "description_cards",
	dependencies = {
		items = {}
	},
	pools = {},
	pos = { x = -1, y = 0 }
})

SMODS.DescriptionCard({
	key = "empowered",
	atlas = "description_cards",
	dependencies = {
		items = {}
	},
	pools = {},
	loc_vars = function()
		return {
			vars = {'{','}'}
		}
	end,
	pos = { x = -1, y = 0 }
})

Tower.EmpoweredColour = HEX('ff0000')