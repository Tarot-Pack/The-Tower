Tower.Back({
    key = "shimmered",
    atlas = "decks",
    pos = {x = 0, y = 0}, 
    dependencies = {
        items = {
            "set_tower_transmuted",
            "desc_tower_mult_rank"
        }
    },
    loc_vars = function ()
        return {
            vars = { Tower.getLocalization(Tower.Eternal()).name }
        }
    end,
    collection_loc_vars = function ()
        return {
            vars = { Tower.getLocalization(Tower.Eternal()).name }
        }
    end,
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    v.ability.tower_shimmer_mult = true
                end
                
                local bucket = SMODS.add_card({
                    key = 'j_tower_shimmer_bucket',
                    area = G.jokers,
                })
                Tower.Eternal():apply(bucket, true)
                G.GAME.tower_random_shimmer = true

                return true
            end
        }))
    end,
})

Tower.Shimmer = Tower.Shimmer or {}

local old_emplace = CardArea.emplace;
Tower.Shimmer.DeckCardareaWhitelist = function() return {"consumeables", "hand", "pack_cards", "shop_jokers", "shop_vouchers", "shop_booster", "jokers"} end
function CardArea:emplace(card, location, stay_flipped) 
    if not card then return end
    for i, v in ipairs(Tower.Shimmer.DeckCardareaWhitelist()) do
        if G[v] == self then
            G.GAME.shimmer_chance = G.GAME.shimmer_chance or 0.5
            if G.GAME.tower_random_shimmer and (pseudorandom(pseudoseed("tower_randomshimmer")) < G.GAME.shimmer_chance) then
                if Tower.Shimmer.CanApply(self, card, {card}) then
                    Tower.Shimmer.Apply(self, card, {card})
                    G.GAME.shimmer_chance = G.GAME.shimmer_chance - 0.01
                end
            end
            break
        end
    end
    return old_emplace(self, card, location, stay_flipped)
end

local old_end_round = end_round
function end_round(...)
    G.GAME.shimmer_chance = 0.5
    return old_end_round(...)
end

local old_new_round = new_round
function new_round(...)
    G.GAME.shimmer_chance = 0.5
    return old_new_round(...)
end