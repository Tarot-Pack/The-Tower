Tower.Back({
    key = "shimmered",
    name = "tower-Shimmered Deck",
    atlas = "decks",
    pos = {x = 0, y = 0}, 
    dependencies = {
        items = {
            "set_tower_transmuted"
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
                G.GAME.tower_random_shimmer = G.GAME.tower_random_shimmer or 0;
                G.GAME.tower_random_shimmer = G.GAME.tower_random_shimmer + 0.5;
                G.GAME.tower_shimmered_decrease = 0.001
                for k, v in pairs(G.playing_cards) do
                    v.ability.tower_shimmer_mult = true
                end
                
                local bucket = SMODS.add_card({
                    key = 'j_tower_shimmer_bucket',
                    area = G.jokers,
                })
                Tower.Eternal():apply(bucket, true)

                return true
            end
        }))
    end,
})

if CardSleeves then
    CardSleeves.Sleeve({
        key = "shimmered",
        name = "Shimmered Sleeve",
        atlas = "sleeves",
        pos = { x = 0, y = 0 },
        config = { },
        unlocked = true,
        unlock_condition = { deck = "tower-Shimmered Deck", stake = 1 },
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
        trigger_effect = function(self, args) end,
        apply = function(self)
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.tower_random_shimmer = G.GAME.tower_random_shimmer or 0;
                    G.GAME.tower_random_shimmer = G.GAME.tower_random_shimmer + 0.5;
                    G.GAME.tower_shimmered_decrease = 0.001
                    for k, v in pairs(G.playing_cards) do
                        v.ability.tower_shimmer_mult = true
                    end
                    if self.get_current_deck_key() ~= "b_tower_shimmered" then
                        local bucket = SMODS.add_card({
                            key = 'j_tower_shimmer_bucket',
                            area = G.jokers,
                        })
                        Tower.Eternal():apply(bucket, true)
                    end

                    return true
                end
            }))
        end,
        init = function(self) end,
    })
end

Tower.Shimmer = Tower.Shimmer or {}

local old_emplace = CardArea.emplace;
Tower.Shimmer.DeckCardareaWhitelist = function() return {"consumeables", "hand", "pack_cards", "shop_jokers", "shop_vouchers", "shop_booster", "jokers"} end
function CardArea:emplace(card, location, stay_flipped) 
    if not card then return end
    for i, v in ipairs(Tower.Shimmer.DeckCardareaWhitelist()) do
        if G[v] == self then
            G.GAME.shimmer_chance = G.GAME.shimmer_chance or G.GAME.tower_random_shimmer
            if G.GAME.tower_random_shimmer and (pseudorandom(pseudoseed("tower_randomshimmer")) < G.GAME.shimmer_chance) then
                if Tower.Shimmer.CanApply(self, card, {card}) then
                    Tower.Shimmer.Apply(self, card, {card})
                    G.GAME.shimmer_chance = G.GAME.shimmer_chance - G.GAME.tower_shimmered_decrease
                end
            end
            break
        end
    end
    return old_emplace(self, card, location, stay_flipped)
end

local old_end_round = end_round
function end_round(...)
    G.GAME.shimmer_chance = G.GAME.tower_random_shimmer
    return old_end_round(...)
end

local old_new_round = new_round
function new_round(...)
    G.GAME.shimmer_chance = G.GAME.tower_random_shimmer
    return old_new_round(...)
end