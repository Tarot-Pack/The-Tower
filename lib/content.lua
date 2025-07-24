Tower.Atlas({
	key = "modicon",
	path = "tower_icon.png",
	px = 32,
	py = 32,
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
	key = "achievements",
	path = "tower_achievements.png",
	px = 66,
	py = 66,
})

SMODS.Atlas({
	key = "centers",
	path = "tower_balala_enhance.png",
	px = 71,
	py = 95
})

SMODS.Atlas({
	key = "jokers1",
	path = "tower_jokers1.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
	key = "pack",
	path = "tower_boosters.png",
	px = 71,
	py = 95,
})

SMODS.ObjectType({
	object_type = "ObjectType",
	key = "Tower-Slime",
	default = "j_tower_king_slime",
	cards = {}
})

SMODS.ObjectType({
	object_type = "ObjectType",
	key = "Tower-Terra",
	default = "j_tower_eye_of_cthulhu",
	cards = {}
})


SMODS.Rarity({
	key = "transmuted",
	loc_txt = {},
	badge_colour = SMODS.Gradient {
        key = 'transmuted_grad',
        colours = { HEX('5a5efa'), HEX('6e44f7'), HEX('a534de'), HEX('dc5392'), HEX('e38e8d') },
        cycle = 1,
    },
})

SMODS.Rarity({
	key = "apollyon",
	loc_txt = {},
	badge_colour = SMODS.Gradient {
        key = 'apollyon_grad',
        colours = { HEX('ff0000'), HEX('e4a92e'), HEX('2ec4df'), HEX('2f52f2'), HEX('ec2fa5') },
        cycle = 1,
    },
})