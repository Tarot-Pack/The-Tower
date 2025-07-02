SMODS.Stake {
    name = "tower-base",
    key = "base",
    set = "Book", -- do not absorb
    atlas = "book",
    sticker_atlas = "stickers",
    unlocked_stake = "planet",
    applied_stakes = {},
    pos = { x = 0, y = 0 },
    sticker_pos = { x = 1, y = 0 },
    modifiers = function()
        G.GAME.win_ante = 32; 
        G.GAME.modifiers.tower_tarot_rate = nil; -- no tarots
        G.GAME.modifiers.tower_spectral_rate = 16;
        G.GAME.modifiers.tower_code_enabled = true
    end,
    colour = HEX('c1294f'),
    loc_txt = {}
}

SMODS.Stake {
    name = "tower-planet",
    key = "planet",
    set = "Book", -- do not absorb
    atlas = "book",
    sticker_atlas = "stickers",
    unlocked_stake = "tarot",
    applied_stakes = { "base" },
    pos = { x = 1, y = 0 },
    sticker_pos = { x = 2, y = 0 },
    modifiers = function()
        G.GAME.modifiers.tower_planets_enabled = true;
    end,
    colour = HEX('2fbadb'),
    loc_txt = {}
}

SMODS.Stake {
    name = "tower-tarot",
    key = "tarot",
    set = "Book", -- do not absorb
    atlas = "book",
    sticker_atlas = "stickers",
    unlocked_stake = "sixtyfour",
    applied_stakes = { "planet" },
    pos = { x = 2, y = 0 },
    sticker_pos = { x = 3, y = 0 },
    modifiers = function()
        G.GAME.modifiers.tower_tarot_rate = 8; -- every 8
    end,
    colour = HEX('ab7100'),
    loc_txt = {}
}

SMODS.Stake {
    name = "tower-sixtyfour",
    key = "sixtyfour",
    set = "Book", -- do not absorb
    atlas = "book",
    sticker_atlas = "stickers",
    unlocked_stake = "immortal",
    applied_stakes = { "tarot" },
    pos = { x = 3, y = 0 },
    sticker_pos = { x = 4, y = 0 },
    modifiers = function() 
        G.GAME.win_ante = 64; 
    end,
    colour = HEX('715dc9'),
    loc_txt = {}
}

SMODS.Stake {
    name = "tower-immortal",
    key = "immortal",
    set = "Book", -- do not absorb
    atlas = "book",
    sticker_atlas = "stickers",
    unlocked_stake = "alltarot",
    applied_stakes = { "sixtyfour" },
    pos = { x = 4, y = 0 },
    sticker_pos = { x = 0, y = 1 },
    modifiers = function()
        G.GAME.modifiers.tower_boss_blind_immortal = true;
        G.GAME.modifiers.tower_no_skip = true
    end,
    colour = HEX('4874ff'),
    loc_txt = {}
}

SMODS.Stake {
    name = "tower-alltarot",
    key = "alltarot",
    set = "Book", -- do not absorb
    atlas = "book",
    sticker_atlas = "stickers",
    unlocked_stake = "scaling",
    applied_stakes = { "immortal" },
    pos = { x = 0, y = 1 },
    sticker_pos = { x = 1, y = 1 },
    modifiers = function()
        G.GAME.modifiers.tower_tarot_rate = 1;
        G.GAME.modifiers.tower_spectral_rate = 1;
    end,
    colour = HEX('e15600'),
    loc_txt = {}
}

SMODS.Stake {
    name = "tower-scaling",
    key = "scaling",
    set = "Book", -- do not absorb
    atlas = "book",
    sticker_atlas = "stickers",
    unlocked_stake = "famine",
    applied_stakes = { "alltarot" },
    pos = { x = 1, y = 1 },
    sticker_pos = { x = 2, y = 1 },
    modifiers = function()
        G.GAME.modifiers.tower_ultra_scaling = true;
    end,
    colour = HEX('3100ff'),
    loc_txt = {}
}

SMODS.Stake {
    name = "tower-famine",
    key = "famine",
    set = "Book", -- do not absorb
    atlas = "book",
    sticker_atlas = "stickers",
    unlocked_stake = "nojokers",
    applied_stakes = { "scaling" },
    pos = { x = 2, y = 1 },
    sticker_pos = { x = 3, y = 1 },
    modifiers = function() 
        G.GAME.modifiers.tower_no_consumables = true;
        for _,v in ipairs(SMODS.ConsumableType.ctype_buffer) do
            G.GAME[v:lower()..'_rate'] = 0 -- none: ever
        end
    end,
    colour = HEX('ac7100'),
    loc_txt = {}
}

SMODS.Stake {
    name = "tower-nojokers",
    key = "nojokers",
    set = "Book", -- do not absorb
    atlas = "book",
    sticker_atlas = "stickers",
    unlocked_stake = nil,
    applied_stakes = { "famine" },
    pos = { x = 3, y = 1 },
    sticker_pos = { x = 4, y = 1 },
    modifiers = function() 
        G.GAME.modifiers.tower_no_jokers = true;
        G.GAME.joker_rate = 0;
    end,
    colour = HEX('ff000e'),
    loc_txt = {}
}