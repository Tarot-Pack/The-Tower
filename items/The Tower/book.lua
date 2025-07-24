Tower.Book {
    name = "tower-base",
    key = "base",
    atlas = "book",
    sticker_atlas = "stickers",
    applied_books = {},
    pos = { x = 0, y = 0 },
    applied_books = {},
    modifiers = function()
        G.GAME.win_ante = 32; 
        G.GAME.modifiers.tower_tarot_rate = nil; -- no tarots
        G.GAME.modifiers.tower_spectral_rate = 16;
        G.GAME.modifiers.tower_code_enabled = true
    end,
    colour = HEX('c1294f'),
    config = {},
}

Tower.Book {
    name = "tower-planet",
    key = "planet",
    atlas = "book",
    sticker_atlas = "stickers",
    applied_books = { "base" },
    pos = { x = 1, y = 0 },
    modifiers = function()
        G.GAME.modifiers.tower_planets_enabled = true;
    end,
    colour = HEX('2fbadb'),
    config = {},
}

Tower.Book {
    name = "tower-tarot",
    key = "tarot",
    atlas = "book",
    sticker_atlas = "stickers",
    applied_books = { "planet" },
    pos = { x = 2, y = 0 },
    modifiers = function()
        G.GAME.modifiers.tower_tarot_rate = 8; -- every 8
    end,
    colour = HEX('ab7100'),
    config = {},
}

Tower.Book {
    name = "tower-sixtyfour",
    key = "sixtyfour",
    atlas = "book",
    sticker_atlas = "stickers",
    applied_books = { "tarot" },
    pos = { x = 3, y = 0 },
    modifiers = function() 
        G.GAME.win_ante = 64; 
    end,
    colour = HEX('715dc9'),
    config = {},
}

Tower.Book {
    name = "tower-immortal",
    key = "immortal",
    atlas = "book",
    sticker_atlas = "stickers",
    applied_books = { "sixtyfour" },
    pos = { x = 4, y = 0 },
    modifiers = function()
        G.GAME.modifiers.tower_boss_blind_immortal = true;
        G.GAME.modifiers.tower_no_skip = true
    end,
    colour = HEX('4874ff'),
    config = {},
}

Tower.Book {
    name = "tower-alltarot",
    key = "alltarot",
    atlas = "book",
    sticker_atlas = "stickers",
    applied_books = { "immortal" },
    pos = { x = 0, y = 1 },
    modifiers = function()
        G.GAME.modifiers.tower_tarot_rate = 1;
        G.GAME.modifiers.tower_spectral_rate = 1;
    end,
    colour = HEX('e15600'),
    config = {},
}

Tower.Book {
    name = "tower-scaling",
    key = "scaling",
    atlas = "book",
    sticker_atlas = "stickers",
    applied_books = { "alltarot" },
    pos = { x = 1, y = 1 },
    modifiers = function()
        G.GAME.modifiers.tower_ultra_scaling = true;
    end,
    colour = HEX('3100ff'),
    config = {},
}

Tower.Book {
    name = "tower-famine",
    key = "famine",
    atlas = "book",
    sticker_atlas = "stickers",
    applied_books = { "scaling" },
    pos = { x = 2, y = 1 },
    modifiers = function() 
        G.GAME.modifiers.tower_no_consumables = true;
        for _,v in ipairs(SMODS.ConsumableType.ctype_buffer) do
            G.GAME[v:lower()..'_rate'] = 0 -- none: ever
        end
    end,
    colour = HEX('ac7100'),
    config = {},
}

Tower.Book {
    name = "tower-nojokers",
    key = "nojokers",
    atlas = "book",
    sticker_atlas = "stickers",
    applied_books = { "famine" },
    pos = { x = 3, y = 1 },
    modifiers = function() 
        G.GAME.modifiers.tower_no_jokers = true;
        G.GAME.joker_rate = 0;
    end,
    colour = HEX('ff000e'),
    config = {},
}