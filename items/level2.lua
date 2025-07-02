-- planet blinds
local planets = {
    {"pluto", "High Card", "6e6ee7"},
    {"mercury", "Pair", "460400"},
    {"uranus", "Two Pair", "fff100"},
    {"venus", "Three of a Kind", "ff443e"},
    {"saturn", "Straight", "b9d4ff"},
    {"jupiter", "Flush", "74bb83"},
    {"earth", "Full House", "411624"},
    {"mars", "Four of a Kind", "eaa221"},
    {"neptune", "Straight Flush", "2a4032"},
    {"planet_x", "Five of a Kind", "681b2b"},
    {"ceres", "Flush House", "00bfff"},
    {"eris", "Flush Five", "9effff"},
}

for i, v in pairs(planets) do
    local hand = v[2];
    local key = v[1];
    local colour = v[3];
    SMODS.Blind({
	    tower_is_planet = true,
        name = "tower-" .. key,
        key = key,
        pos = { x = 0, y = i },
        atlas = "blinds2",
        order = 0,
        mult = 3,
        boss_colour = HEX(colour),
        boss = {
            level = 2
        },
        dollars = 5,

        debuff_hand = function(self, cards, _, handname, check)
            if G.GAME.blind.disabled then return false end
            local bad = handname ~= hand;
            if bad then
                G.GAME.blind.triggered = true
            end
            return bad
        end,

        TowerInPool = function ()
            return G.GAME.modifiers.tower_planets_enabled
        end
    })
end