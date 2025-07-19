Tower.Rank {
    hidden = true,

	hc_atlas = 'rank_hc',
    lc_atlas = 'rank',

    key = '1',
    card_key = '1',    
    shorthand = '1',

    pos = { x = 1 },
    nominal = 1,
    value = '1',
    loc_txt = {
        name = '1',
    },

    next = { '2' },
    prev = { 'tower_0' },

    in_pool = function (self, args) 
        if args and args.initial_deck then
            return false
        end
        return true
    end
}

Tower.Rank {
    hidden = true,

	hc_atlas = 'rank_hc',
    lc_atlas = 'rank',

    key = '0',
    card_key = '0',
    shorthand = '0',
    pos = { x = 0 },
    nominal = 0,
    value = '0',
    loc_txt = {
        name = '0',
    },
    next = { 'tower_1' },
    prev = nil,

    in_pool = function (self, args) 
        if args and args.initial_deck then
            return false
        end
        return true
    end
}


Tower.Shader {
	key = "truenegative",
	path = "truenegative.fs",
}
Tower.Edition {
	key = "truenegative",
	weight = 0,
	shader = "truenegative",
	in_shop = true,
	extra_cost = -5,
    config = {
        card_limit = 1,
    },

    in_pool = function (self, args) 
        return false -- no
    end
}

local old_eval_card = eval_card
function eval_card(card, context)
    local ret, post = old_eval_card(card, context)
    local meta = BigMeta or OmegaMeta
    if (card.edition and card.edition.tower_truenegative) or G.GAME.tower_ritual then
        for i, v in pairs(ret) do
            for q, c in pairs(v) do
                if getmetatable(c) == meta or type(c) == 'number' then
                    v[q] = -c
                end
            end
        end
    end
    return ret, post
end

Tower.Challenge {
	key = "true_negative",
    id = "true_negative",
	order = 3,
    jokers = {
        {id = 'j_cavendish'},
    },
	rules = {
		custom = {
            {
                id = "cry_force_edition", 
                value = "tower_truenegative",
            },
            { id = 'tower_true_negative' }, -- explanation
            { id = 'tower_true_negativel2' }, -- explanation
        },
		modifiers = {},
	},
	deck = {
		type = "Challenge Deck",
        edition = "tower_truenegative"
	},

	update = function(self)
        self.restrictions.banned_keys = {}
        for k, v in pairs(G.P_TAGS) do
			if v.config and v.config.edition then
				self.restrictions.banned_keys[#self.restrictions.banned_keys + 1] = { key = k }
			end
		end
	end,

	restrictions = {
		banned_cards = {},
		banned_other = {},
        banned_tags = {}
	},
}

function get_challenge_int_from_id(_id)
  for k, v in pairs(G.CHALLENGES) do
    if v.id == _id then 
        if v.update then
            v:update()
        end
        return k 
    end
  end
  return 0
end


local old_cc = create_card;
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local card = old_cc(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if not card then return card end
    if G.GAME.modifiers.tower_no_jokers and _type == 'Joker' then
        card:start_dissolve();
    elseif G.GAME.modifiers.tower_no_consumables and not (_type=='Base' or _type == 'Enhanced' or _type == 'Joker') then
        card:start_dissolve();
    end
    return card
end

local old_sd = Card.set_edition;
function Card:set_edition(edition, immediate, silent, delay) 
    if (edition == "e_tower_truenegative" or (edition and edition.e_tower_truenegative)) and not (G.GAME.modifiers.cry_force_edition == 'tower_truenegative') then
        if self.edition and self.edition.tower_truenegative then
            edition = nil -- trolling
            Tower.achieve('true_positive')
        end
    end
    if G.GAME.modifiers["replace_edition_" .. ((edition and edition.key) or 'e_base')] and self.ability.set == 'Joker' then
        edition = G.GAME.modifiers["replace_edition_" .. ((edition and edition.key) or 'e_base')]
    end
    local val = old_sd(self, edition, immediate, silent, delay)
    check_for_unlock({ type = "tower_modify_card", card = self })
    return val
end
local apply_to_run = Card.apply_to_run

function Card:apply_to_run(center, raw)
    if not raw and self and (self.edition and self.edition.tower_truenegative) then
        return self:unapply_to_run(center, true)
    end
    return apply_to_run(self)
end

local old_sa = Card.set_ability;
function Card:set_ability(center, initial, delay_sprites)
    local val = old_sa(self, center, initial, delay_sprites)
    check_for_unlock({ type = "tower_modify_card", card = self })
    return val
end

function SMODS.modify_rank(card, amount) -- true neg is neg
    local rank_key = card.base.value
    local rank_data = SMODS.Ranks[card.base.value]
    local is_negative = card.edition and card.edition.tower_truenegative;
    local card_is_negative = is_negative;
    if amount > 0 then
        for _ = 1, amount do
            local selected;
            local behavior;
            if rank_data.key == 'tower_0' then
                is_negative = false
                if G.GAME.modifiers.cry_force_edition == 'tower_truenegative' then
                    break -- dip out of loop early to prevent escape from their fate
                end
            end
            if is_negative then
                selected = rank_data.prev
                behavior = rank_data.prev_behavior
            else
                selected = rank_data.next
                behavior = rank_data.strength_effect
            end
            behavior = behavior or { fixed = 1, ignore = false, random = false }
            if not next(selected) or behavior.ignore then
                break
            elseif behavior.random then
                rank_key = pseudorandom_element(
                    selected,
                    pseudoseed('strength'),
                    { in_pool = function(key) return SMODS.Ranks[key]:in_pool({ suit = card.base.suit}) end }
                )
            else
                local i = (behavior.fixed and selected[behavior.fixed]) and behavior.fixed or 1
                rank_key = selected[i]
            end
            rank_data = SMODS.Ranks[rank_key]
            if rank_data.key == 'tower_0' then
                is_negative = false
            end
        end
    else
        for _ = 1, -amount do
            local selected;
            local behavior;
            if rank_data.key == 'tower_0' then
                is_negative = true
            end
            if is_negative then
                selected = rank_data.next
                behavior = rank_data.strength_effect
            else
                selected = rank_data.prev
                behavior = rank_data.prev_behavior
            end
            behavior = behavior or { fixed = 1, ignore = false, random = false }
            if not next(selected) or behavior.ignore then
                break
            elseif behavior.random then
                rank_key = pseudorandom_element(
                    selected,
                    pseudoseed('weakness'),
                    { in_pool = function(key) return SMODS.Ranks[key]:in_pool({ suit = card.base.suit}) end }
                )
            else
                local i = (behavior.fixed and selected[behavior.fixed]) and behavior.fixed or 1
                rank_key = selected[i]
            end
            rank_data = SMODS.Ranks[rank_key]
            if is_negative and rank_key == '0' then
                is_negative = false
            end
        end
    end
    
    if rank_data.key == 'tower_0' then
        is_negative = false
        if G.GAME.modifiers.cry_force_edition == 'tower_truenegative' then
            is_negative = true
        end
    end
    
    if is_negative and not card_is_negative then
        card:set_edition("e_tower_truenegative", nil, true)
    elseif not is_negative and card_is_negative then
        if G.GAME.modifiers.cry_force_edition == nil then
            card:set_edition(nil, nil, true)
        else
            card:set_edition('e_'+G.GAME.modifiers.cry_force_edition, nil, true)
        end
    end
    return SMODS.change_base(card, nil, rank_key)
end
