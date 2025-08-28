local old_remove = Card.remove;
function Card:remove(...)
    for i, v in ipairs(G.fortunes or {}) do
        if v == self then
            table.remove(G.fortunes, i)
            break
        end
    end
    return old_remove(self, ...);
end
Tower.Fortune = SMODS.Center:extend({
	set = "Fortune",
	pos = { x = 0, y = 0 },
	config = {},
    unlocked = true,
    discovered = false,
	class_prefix = "fortune",
    no_doe = true,
	required_params = {
		"key",
	},
	inject = function(self)
		if not G.P_CENTER_POOLS[self.set] then
			G.P_CENTER_POOLS[self.set] = {}
		end
		SMODS.Center.inject(self)
	end,
	set_card_type_badge = function ()
	end,
})
function Tower.findFortune(name)
    if not G.fortunes then return nil end;
    local results = {}
    for i, v in ipairs(G.fortunes) do
        if v.ability.name == name then
            results[#results+1] = v
        end
    end
    return results
end
G.P_CENTER_POOLS["Fortune"] = {}
local old_start = Game.start_run
function Game:start_run(args)
    local value = old_start(self, args)
    for i, v in ipairs(G.P_BLINDS) do
        if v.tower_consumable and (not G.P_CENTERS['c_' .. v.tower_consumable]) then
            G.GAME.banned_keys[i] = true
        end
    end
    if (not (args.savetext and args.savetext.fortunes)) then
        G.fortunes = {}
    else
        G.fortunes = {}
        for i, v in ipairs(args.savetext.fortunes) do
            local card = Card(17, 5, G.CARD_W, G.CARD_H, G.P_CENTERS.j_joker, G.P_CENTERS.c_base)
            card:load(v)		
		    card.VT.h = card.T.h
            print(v)
            G.fortunes[#G.fortunes+1] = card
        end
    end
    return value
end
function Tower.AddFortune(key)
    local center = G.P_CENTERS[key]

    local card = Card(
        17,
        5,
        G.CARD_W,
        G.CARD_H,
        G.P_CARDS.empty,
        center
    )
    G.fortunes[#G.fortunes+1] = card
    return card
end

Tower.AfterAllLoaded(function ()
    local gcp = get_current_pool
    function get_current_pool(_type, _rarity, _legendary, _append, override_equilibrium_effect)
        if _type ~= "Joker" then return gcp(_type, _rarity, _legendary, _append, override_equilibrium_effect) end
        local chance = to_big(1);
        for i, card in ipairs(G.fortunes) do
            local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.boost_numerator, card.ability.extra.boost_denominator, 'tower-fortune')

            chance = chance * (to_big(1) - (to_big(numerator) / to_big(denominator)))
        end
        local chosen = pseudorandom_element(G.fortunes, pseudoseed('fortune_choice'));
        if SMODS.pseudorandom_probability(chosen, 'tower-fortune', to_number(to_big(1) - chosen), 1, 'tower-fortune') then
            local pool = {};
            for i, center in ipairs(G.P_CENTER_POOLS.Joker) do
                if not (G.GAME.banned_keys and G.GAME.banned_keys[center.key]) then
                    for q, card in ipairs(G.fortunes) do
                        if card.config.center.tower_boost and card.config.center.tower_boost(center) then
                            pool[#pool+1] = center.key; -- dont break here bc if card in multiple pools it should be more likely
                        end
                    end
                end
            end
            if #pool == 0 then
                return gcp(_type, _rarity, _legendary, _append, override_equilibrium_effect)
            else
                return pool, "tower_fortune" .. G.GAME.round_resets.ante
            end
        else
            return gcp(_type, _rarity, _legendary, _append, override_equilibrium_effect)
        end
    end
end)