Tower.Consumable({
	set = "tower_transmuted",
	name = "tower-aether_monolith",
	key = "aether_monolith",
	pos = { x = 2, y = 0 },
    soul_pos = { x = 1, y = 0, extra = { x = 0, y = 0 }},
	cost = 4,
	atlas = "consumables",
	order = 1,
	can_use = function(self, card)
		return true
	end,
    
    can_bulk_use = true,
	bulk_use = function(self, card, area, copier, number)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				for i = 1, number do
                    local card = create_card("Joker", G.jokers, nil, "tower_apollyon", nil, nil, nil, "tower_aether_monolith")
                    card:add_to_deck()
                    G.jokers:emplace(card)
				    card:juice_up(0.3, 0.5)
                end
				return true
			end,
		}))
		delay(0.6)
	end,

	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, "tower_apollyon", nil, nil, nil, "tower_aether_monolith")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
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

-- shimmer bottle is pain

Tower.Consumable({
	set = "Spectral",
	name = "tower-shimmer_bottle",
	key = "shimmer_bottle",
	pos = { x = 3, y = 0 },
	cost = 4,
	atlas = "consumables",
	order = 1,

	dependencies = {
		items = {
			"set_tower_transmuted",
		}
	},

    config = {
        select = 1,
    },
    
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.select
			}
		}
	end,

	can_use = function(self, card)
		return Tower.Shimmer.CanApply(self, card, Tower.EntComp.GetHighlightedCards({G.consumeables, G.hand, G.pack_cards, G.shop_jokers, G.shop_vouchers, G.shop_booster, G.jokers}, card), card.ability.select)
	end,

	use = function(self, card, area, copier)
		Tower.Shimmer.Apply(self, card, Tower.EntComp.GetHighlightedCards({G.consumeables, G.hand, G.pack_cards, G.shop_jokers, G.shop_vouchers, G.shop_booster, G.jokers}, card))
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