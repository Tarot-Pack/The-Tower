Tower.GenericBoosters({ -- order 1 - 3
	key = "slime",
	kind = "slime",
	atlas = "pack",
	pos = { x = 0, y = 0 },
	order = 1,
	config = { extra = 5, choose = 2 },
	cost = 5,
	weight = 1,
	soul_card = "j_tower_pinky",
    amount = 3,
    colour = G.C.GREEN,
    secondary_colour = G.C.BLUE,
    name = "tower_slime",
    type = "Tower-Slime",
	group_key = "k_tower_slime_pool",
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

Tower.AuthorBooster("pikaboy10", {
	atlas = "pack",
	pos = {x = 3, y = 0},
	config = { extra = 5, choose = 2 },
	order = 4,
	amount = 3,
	weight = 1,
	cost = 5,
    colour = HEX('2f9e68'),
    secondary_colour = HEX('fe37af'),
})