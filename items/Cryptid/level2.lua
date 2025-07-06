-- basic planet blinds
local planets = {
    {"asteroid_belt", "cry_Bulwark", "2b3b06", "cry_asteroidbelt"},
    {"void", "cry_Clusterfuck", "000000", "cry_void"},
    {"phobos_diemos", "cry_UltPair", "ffaeb6", "cry_marsmoons"},
    {"universe", "cry_WholeDeck", "ffffff", "cry_universe"},
    {"nibiru", "cry_None", "ffffff00", "cry_nibiru"}
}

local SPR_I = 9

for i, v in pairs(planets) do
    SPR_I = SPR_I + 1
    local hand = v[2];
    local key = v[1];
    local colour = v[3];
    local cons = v[4];
    Tower.Blind({
	    tower_is_planet = true,
        tower_consumable = cons,
        name = "tower-" .. key,
        key = key,
        pos = { x = 0, y = SPR_I },
        atlas = "blinds4",
        order = 2,
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

SPR_I = SPR_I + 1
Tower.Blind({
    tower_is_planet = true,
    tower_consumable = cons,
    name = "tower-neutronstar",
    key = "neutronstar",
    pos = { x = 0, y = SPR_I },
    atlas = "blinds4",
    order = 2,
    mult = G.tower_unknown,
    boss_colour = SMODS.Gradient {
        key = 'neutronstar_grad',
        colours = { HEX('ff0000'), HEX('e4a92e'), HEX('2ec4df'), HEX('2f52f2'), HEX('ec2fa5') },
        cycle = 1,
    },
    boss = {
        level = 2
    },
    dollars = 5,
    set_blind = function (self)
        local hand = pseudorandom_element(G.handlist, pseudoseed("tower_neutron"))
        G.GAME.blind.chips = G.GAME.blind.chips * to_big(G.GAME.hands[hand].level)
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_planets_enabled
    end
})
SPR_I = SPR_I + 1
Tower.Blind({
    tower_is_planet = true,
    tower_consumable = cons,
    name = "tower-planetlua",
    key = "planetlua",
    pos = { x = 0, y = SPR_I },
    atlas = "blinds4",
    order = 2,
    mult = 3,
    boss_colour = HEX("00007b"),
    boss = {
        level = 2
    },
    dollars = 5,
    cry_before_play = function (self)
        -- using G.GAME.blind feels like it shouldn't work
        update_hand_text(
            { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize("k_all_hands"), chips = "...", mult = "...", level = "" }
        )
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.2,
            func = function()
                play_sound("tarot1")
                G.GAME.blind:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end,
        }))
        update_hand_text({ delay = 0 }, { mult = "-", StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.9,
            func = function()
                play_sound("tarot1")
                G.GAME.blind:juice_up(0.8, 0.5)
                return true
            end,
        }))
        update_hand_text({ delay = 0 }, { chips = "-", StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.9,
            func = function()
                play_sound("tarot1")
                G.GAME.blind:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end,
        }))
        update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "-1" })
        delay(1.3)
        for k, v in pairs(G.GAME.hands) do
            level_up_hand(G.GAME.blind, k, true, -1)
        end
        update_hand_text(
            { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = 0, handname = "", level = "" }
        )
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_planets_enabled
    end
})
SPR_I = SPR_I + 1
Tower.Blind({
    tower_is_planet = true,
    tower_consumable = cons,
    name = "tower-sol",
    key = "sol",
    pos = { x = 0, y = SPR_I },
    atlas = "blinds4",
    order = 2,
    mult = 3,
    boss_colour = HEX("ffb300"),
    boss = {
        level = 2
    },
    dollars = 5,
    debuff_hand = function (self, cards, _, handname, check)
        if G.GAME.blind.disabled then return false end
        return G.GAME.current_round.current_hand.cry_asc_num <= 0
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_planets_enabled
    end
})

-- multi-planet blinds
local mplanets = {
    {"ruutu", {"High Card", "Pair", "Two Pair"}, "c77f00", "cry_Timantii"},
    {"risti", {"Three of a Kind", "Straight", "Flush"}, "4400f5", "cry_Klubi"},
    {"hertta", {"Full House", "Four of a Kind", "Straight Flush"}, "ff7575", "cry_Sydan"},
    {"pata", {"Five of a Kind", "Flush House", "Flush Five"}, "313d3e", "cry_Lapio"},
    {"kaikki", {"cry_Bulwark", "cry_Clusterfuck", "cry_UltPair"}, "f83b2f", "cry_Kaikki"}
}

for i, v in pairs(mplanets) do
    SPR_I = SPR_I + 1
    local hands = v[2];
    local key = v[1];
    local colour = v[3];
    local cons = v[4];
    Tower.Blind({
	    tower_is_planet = true,
        tower_consumable = cons,
        name = "tower-" .. key,
        key = key,
        pos = { x = 0, y = SPR_I },
        atlas = "blinds4",
        order = 2,
        mult = 3,
        boss_colour = HEX(colour),
        boss = {
            level = 2
        },
        dollars = 5,

        set_blind = function (self)
            G.GAME.tower_cry_multiplanet = copy_table(hands)
        end,
        TowerCheckWin = function (self)
            return (G.GAME.chips - G.GAME.blind.chips >= to_big(0)) and (#G.GAME.tower_cry_multiplanet == 0)
        end,
        TowerModFinalScore = function (self, score, cards, poker_hands, hand, scoring_hand, mult, hand_chips)
            if G.GAME.blind.disabled then return score end

            local index = nil;
            for i, v in ipairs(G.GAME.tower_cry_multiplanet) do
                if v == hand then
                    index = i 
                    break
                end
            end
            if index ~= nil then
                table.remove(G.GAME.tower_cry_multiplanet, index)
            end
            return score
        end,
        
        disable = function ()
            G.GAME.tower_cry_multiplanet = nil
        end,

        defeat = function ()
            G.GAME.tower_cry_multiplanet = nil
        end,


        TowerInPool = function ()
            return G.GAME.modifiers.tower_planets_enabled
        end
    })
end

