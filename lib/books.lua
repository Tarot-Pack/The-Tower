G.viewed_book = 5
G.TOWER_BOOK_OFFSET = 5
G.P_BOOKS = {}
function math.T_pow(a, b)
    a = to_big(a);
    b = to_big(b);
    return a:pow(b)
end
Tower.SetupSteps = {}
function Tower.SetupStep(obj)
    if type(obj) == 'function' then
        local func = obj
        obj = {
            UIDEF = func
        }
    end
    if obj.enabled == nil then
        obj.enabled = function ()
            return true
        end
    end
    Tower.SetupSteps[#Tower.SetupSteps+1] = obj
end
function Tower.UIDEFBookSelection()
    local UI_NODES = {}
    
    UI_NODES[#UI_NODES+1] = {n=G.UIT.O,
        config={id = nil, func = 'RUN_SETUP_check_book', insta_func = true, object = Moveable() }
    }
    local cont = {n=G.UIT.R, config={align = "cm", minh = 5, minw = 6.8, colour = G.C.CLEAR}, nodes=UI_NODES}
    local root = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
        cont
    }}
    return root
end
Tower.SetupStep({
    UIDEF = Tower.UIDEFBookSelection,
    enabled = function ()
        return not Tower.Config.disable_book
    end
})

function G.FUNCS.tower_next_setup_step()
    G.TowerSetupStep = (G.TowerSetupStep or 0) + 1;

    local tab_but = G.OVERLAY_MENU:get_UIE_by_ID("tab_but_" .. localize('b_new_run'))
    G.FUNCS.change_tab(tab_but)
end
function G.FUNCS.tower_previous_setup_step()
    G.TowerSetupStep = (G.TowerSetupStep or 0) - 1;

    local tab_but = G.OVERLAY_MENU:get_UIE_by_ID("tab_but_" .. localize('b_new_run'))
    G.FUNCS.change_tab(tab_but)
end

function Tower.setup_book(book)
    G.GAME.tower_book = book or G.tower_default_book
    if Tower.Config.disable_book then
        G.GAME.tower_book = 1
    end
    for i = 1, G.GAME.tower_book do
        G.P_CENTER_POOLS.Book[i].modifiers()
    end
end
local old_exit_overlay_menu = G.FUNCS.exit_overlay_menu;
function G.FUNCS.exit_overlay_menu(...)
    if G.TowerSetupStep and G.TowerSetupStep > 0 then
        G.FUNCS.tower_previous_setup_step()
        return
    end
    return old_exit_overlay_menu(...)
end

local oldRemove = UIBox.remove;
function UIBox:remove(...)
    if G.OVERLAY_MENU == self then G.TowerSetupStep = nil end
    return oldRemove(self, ...)
end

local old_run_setup_option = G.UIDEF.run_setup_option
function G.UIDEF.run_setup_option(_type) 
    G.TTTY = _type
    if _type ~= 'New Run' then
        G.TowerSetupStep = nil
        return old_run_setup_option(_type);
    end
    if G.TowerSetupStep == nil then
        G.TowerSetupStep = 0
    end
    if G.TowerSetupStep < 0 then
        G.TowerSetupStep = 0
    end
    if G.TowerSetupStep == 0 or not Tower.RenderedSetupSteps then
        Tower.RenderedSetupSteps = Tower.RenderedSetupSteps or {}
        for i, v in ipairs(Tower.SetupSteps) do
            if v.enabled() then
                Tower.RenderedSetupSteps[#Tower.RenderedSetupSteps+1] = v.UIDEF
            end
        end
    end
    if G.TowerSetupStep > #Tower.RenderedSetupSteps then
        G.TowerSetupStep = nil
        return nil
    end
    local playbutton = {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
        {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            {n=G.UIT.C, config={align = "cm", minw = 5, minh = 0.8, padding = 0.2, r = 0.1, hover = true, colour = G.C.BLUE, button = (G.TowerSetupStep == #Tower.RenderedSetupSteps and "start_setup_run") or "tower_next_setup_step", shadow = true, func = (G.TowerSetupStep == #Tower.RenderedSetupSteps and 'can_start_run') or nil}, nodes={
                {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                    {n=G.UIT.T, config={text = (G.TowerSetupStep == #Tower.RenderedSetupSteps and localize('b_play_cap')) or localize('b_next'), scale = 0.8, colour = G.C.UI.TEXT_LIGHT,func = 'set_button_pip', focus_args = {button = 'x',set_button_pip = true}}}
                }}
            }}
        }}
    }}

    local ui
    local insert_at
    if G.TowerSetupStep == 0 then
        ui = old_run_setup_option(_type)
    else
        ui, insert_at = Tower.RenderedSetupSteps[G.TowerSetupStep](from_game_over)
        if ui == false then
            G.TowerSetupStep = G.TowerSetupStep + 1;
            return G.UIDEF.run_setup_option(_type)
        end
        insert_at = insert_at or {}
        insert_at.obj = insert_at.obj or ui
        insert_at.index = insert_at.index or #insert_at.obj.nodes+1
        insert_at.obj.nodes[insert_at.index] = playbutton
    end
    return ui
end

function Tower.get_book_sprite(_book, _scale)
  _book = _book or G.tower_default_book
  _scale = _scale or 1
  local book_w = 2.4*(36.5)/41
  local book_h = 2.4*(48.5)/41
  local book_sprite = Sprite(0,0,_scale*book_w,_scale*book_h,G.ASSET_ATLAS[G.P_CENTER_POOLS.Book[_book].atlas or "books"], G.P_CENTER_POOLS.Book[_book].pos)
  book_sprite.states.drag.can = false

  return book_sprite
end

G.FUNCS.RUN_SETUP_check_book_name = function(e)
    local _stake_center = G.P_CENTER_POOLS.Book[G.viewed_book]
    if e.config.object and G.viewed_book ~= e.config.id then 
        --removes the UI from the previously selected back and adds the new one

        e.config.object:remove() 
        e.config.object = UIBox{
        definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
            {n=G.UIT.O, config={id = G.viewed_book, func = 'RUN_SETUP_check_book_name', object = DynaText({string = localize{type = 'name_text', key = _stake_center.key, set = _stake_center.set},maxw = 4, colours = {G.C.WHITE}, shadow = true, bump = true, scale = 0.5, pop_in = 0, silent = true})}},
        }},
        config = {offset = {x=0,y=0}, align = 'cm', parent = e}
        }
        e.config.id = G.viewed_book
    end
end

function G.UIDEF.viewed_book_option()
    G.viewed_book = G.viewed_book or G.tower_default_book
    G.PROFILES[G.SETTINGS.profile].MEMORY.book = G.viewed_book
    local _stake_center = G.P_CENTER_POOLS.Book[G.viewed_book]

    local ret_nodes = {}
    if _stake_center then localize{type = 'descriptions', key = _stake_center.key, set = _stake_center.set, nodes = ret_nodes} end 

    local desc_t = {}
    for k, v in ipairs(ret_nodes) do
        desc_t[#desc_t+1] = {n=G.UIT.R, config={align = "cm", maxw = 5.3}, nodes=v}
    end

    local book_sprite = Tower.get_book_sprite(G.viewed_book)

    local book_w = 2.4*(10)/41
    local book_h = 2.4*(11)/41
    return {n=G.UIT.R, config={align = "cm", minw = 2.5, padding = 0.1, r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes={
        {n=G.UIT.R, config={align = "cm", padding = 0.2, colour = G.C.BLACK, r = 0.2}, nodes={
            {n=G.UIT.C, config={align = "cm", padding = 0}, nodes={
                {n=G.UIT.O, config={object = book_sprite}},
            }},
            {n=G.UIT.C, config={align = "tm", minw = 3.7, minh = 2.1, r = 0.1, colour = G.C.L_BLACK, padding = 0.1}, nodes={
                {n=G.UIT.R, config={align = "cm", emboss = 0.1, r = 0.1, minw = 4, maxw = 4, minh = 0.6}, nodes={
                {n=G.UIT.T, config={text = localize{type = 'name_text', key = _stake_center.key, set = _stake_center.set}, scale = 0.35, colour = G.C.WHITE}},
                }},
                {n=G.UIT.R, config={align = "cm", colour = G.C.WHITE, emboss = 0.1, minh = 2.2, r = 0.1}, nodes={
                {n=G.UIT.R, config={align = "cm", padding = 0.03, colour = G.C.WHITE, r = 0.1, minh = 1.5, minw = 5.5}, nodes=desc_t}
                }}       
            }},
        }},
    }}
end

local oldDef = Blind.defeat;
function Blind:defeat(silent)
    G.GAME.tower_best_score = math.max(G.GAME.chips, G.GAME.tower_best_score or to_big(0))
    G.GAME.tower_past_blinds = G.GAME.tower_past_blinds or {};
    G.GAME.tower_past_blinds[#G.GAME.tower_past_blinds+1] = self.config.blind.key
    return oldDef(self, silent)
end

local old_upt = Game.update
function Game:update(dt)
    old_upt(self, dt)
    if G.GAME.tower_chambered ~= nil then
        local new_pos = {x = G.GAME.blind.config.blind.pos.x, y = G.GAME.blind.config.blind.pos.y + (3 - (G.GAME.tower_chambered or 3))}
        if new_pos.x ~= G.GAME.blind.pos.x or new_pos.y ~= G.GAME.blind.pos.y then
            G.GAME.blind.pos = new_pos
            G.GAME.blind.children.animatedSprite:set_sprite_pos(G.GAME.blind.pos)
        end
    end
    if G.GAME.modifiers.cry_force_edition then
        G.GAME.modifiers.TowerForceEdition = G.GAME.modifiers.cry_force_edition -- not stake related at all
    else
        G.GAME.modifiers.cry_force_edition = G.GAME.modifiers.TowerForceEdition -- not stake related at all
    end
end

local old_blind_tag = create_UIBox_blind_tag

function create_UIBox_blind_tag(blind_choice, run_info)
    if G.GAME.modifiers.tower_no_skip then
        return {n=G.UIT.R, config={id = 'tag_container', ref_table = _tag, align = "cm"}, nodes={}}
    end
    return old_blind_tag(blind_choice, run_info)
end

function Tower.build_book_chain(book)
    if not book.applied_books then
        return {}
    end
    local applied = {}
    local stack = {book}
    while #stack > 0 do
        local item = stack[#stack];
        applied[#applied+1] = item
        stack[#stack] = nil
        if item.applied_books then
            for _, s in pairs(item.applied_books) do
                stack[#stack+1] = G.P_BOOKS[s]
            end
        end
    end
    return applied
end

Tower.Books = {}
Tower.Book = SMODS.GameObject:extend {
    obj_table = Tower.Books,
    obj_buffer = {},
    class_prefix = 'book',
    unlocked = false,
    set = 'Book',
    atlas = 'book',
    pos = { x = 0, y = 0 },
    injected = false,
    required_params = {
        'key',
        'pos',
        'applied_books'
    },
    pre_inject_class = function(self)
        G.P_CENTER_POOLS[self.set] = {}
        G.P_BOOKS = {}
    end,
    inject = function(self)
        if not self.injected then
            -- Inject book in the correct spot
            self.count = #G.P_CENTER_POOLS[self.set] + 1
            self.order = self.count
            if self.above_book and G.P_BOOKS[self.above_book] then
                self.order = G.P_BOOKS[self.above_book].order + 1
            end
            for _, v in pairs(G.P_BOOKS) do
                if v.order >= self.order then
                    v.order = v.order + 1
                end
            end
            G.P_BOOKS[self.key] = self
            table.insert(G.P_CENTER_POOLS.Book, self)
            -- Sticker sprites (book_ prefix is removed for vanilla compatiblity)
            if self.sticker_pos ~= nil then
                G.shared_stickers[self.key:sub(7)] = Sprite(0, 0, G.CARD_W, G.CARD_H,
                G.ASSET_ATLAS[self.sticker_atlas] or G.ASSET_ATLAS["stickers"], self.sticker_pos)
                G.sticker_map[self.key] = self.key:sub(7)
            else
                G.sticker_map[self.key] = nil
            end
        else
            G.P_BOOKS[self.key] = self
            SMODS.insert_pool(G.P_CENTER_POOLS.Book, self)
        end
        self.injected = true
        -- should only need to do this once per injection routine
    end,
    post_inject_class = function(self)
        table.sort(G.P_CENTER_POOLS[self.set], function(a, b) return a.order < b.order end)
        for _,book in pairs(G.P_CENTER_POOLS.Book) do
            local applied = Tower.build_book_chain(book)
            book.book_level = 0
            for i,_ in ipairs(G.P_CENTER_POOLS.Book) do
                if applied[i] then book.book_level = book.book_level+1 end
            end
        end
        G.C.BOOKS = {}
        for i = 1, #G.P_CENTER_POOLS[self.set] do
            G.C.BOOKS[i] = G.P_CENTER_POOLS[self.set][i].colour or G.C.WHITE
        end
    end,
    process_loc_text = function(self)
        -- empty loc_txt indicates there are existing values that shouldn't be changed or it isn't necessary
        if not self.loc_txt or not next(self.loc_txt) then return end
        local target = (G.SETTINGS.real_language and self.loc_txt[G.SETTINGS.real_language]) or self.loc_txt[G.SETTINGS.language] or self.loc_txt['default'] or self.loc_txt['en-us'] or
            self.loc_txt
        local applied_text = "{s:0.8}" .. localize('b_applies_stakes_1')
        local any_applied
        for _, v in pairs(self.applied_books) do
            any_applied = true
            applied_text = applied_text ..
                localize { set = self.set, key = v, type = 'name_text' } .. ', '
        end
        applied_text = applied_text:sub(1, -3)
        if not any_applied then
            applied_text = "{s:0.8}"
        else
            applied_text = applied_text .. localize('b_applies_stakes_2')
        end
        local desc_target = copy_table(target)
        table.insert(desc_target.text, applied_text)
        G.localization.descriptions[self.set][self.key] = desc_target
        SMODS.process_loc_text(G.localization.descriptions["Other"], self.key:sub(7) .. "_sticker", self.loc_txt,
            'sticker')
    end,
    get_obj = function(self, key) return G.P_BOOKS[key] end
}

G.FUNCS.change_book = function(args)
  G.viewed_book = args.to_key
  G.PROFILES[G.SETTINGS.profile].MEMORY.book = args.to_key
end

G.FUNCS.RUN_SETUP_check_book = function(e)
    if (G.viewed_book ~= e.config.id) then
        e.config.object:remove()
        e.config.object = UIBox {
            definition = G.UIDEF.book_option(),
            config = { offset = { x = 0, y = 0 }, align = 'tmi', parent = e }
        }
        e.config.id = G.viewed_book or G.tower_default_book
    end
end

G.FUNCS.RUN_SETUP_check_book2 = function(e)
    if (G.viewed_book ~= e.config.id) then
        e.config.object:remove()
        e.config.object = UIBox {
            definition = G.UIDEF.viewed_book_option(),
            config = { offset = { x = 0, y = 0 }, align = 'cm', parent = e }
        }
        e.config.id = G.viewed_book or G.tower_default_book
    end
end

function G.UIDEF.book_description(_stake)
  local _stake_center = G.P_CENTER_POOLS.Book[_stake]
  local ret_nodes = {}
  if _stake_center then localize{type = 'descriptions', key = _stake_center.key, set = _stake_center.set, nodes = ret_nodes} end 

  local desc_t = {}
  for k, v in ipairs(ret_nodes) do
    desc_t[#desc_t+1] = {n=G.UIT.R, config={align = "cm", maxw = 5.3}, nodes=v}
  end

  return {n=G.UIT.C, config={align = "cm", padding = 0.05, r = 0.1, colour = G.C.L_BLACK}, nodes={
    {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
      {n=G.UIT.T, config={text = localize{type = 'name_text', key = _stake_center.key, set = _stake_center.set}, scale = 0.35, colour = G.C.WHITE}}
    }},
    {n=G.UIT.R, config={align = "cm", padding = 0.03, colour = G.C.WHITE, r = 0.1, minh = 1.5, minw = 5.5}, nodes=desc_t}
  }}
end

function G.UIDEF.book_option()
    local middle = {
        n = G.UIT.R,
        config = { align = "cm", minh = 4, minw = 8.8 },
        nodes = {
            { n = G.UIT.O, config = { id = nil, func = 'RUN_SETUP_check_book2', object = Moveable() } },
        }
    }
    local current_book_index = 1
    local book_options = {}
    for i, v in ipairs(G.P_CENTER_POOLS.Book) do
        book_options[#book_options+1] = v
    end

    return {
        n = G.UIT.ROOT,
        config = { align = "tm", colour = G.C.CLEAR, minw = 8.5 },
        nodes = { create_option_cycle({
            options = book_options,
            opt_callback = 'change_book',
            current_option = G.viewed_book,
            colour = G.C.RED,
            w = 10,
            mid = middle,
            focus_args = {snap_to = true},
        }) }
    }
end

local old_init = Game.init_game_object;
function Game:init_game_object()
    local game = old_init(self);
    setmetatable(game.banned_keys, {
        __index = function (self, key)
            if SMODS.Centers[key] then
                local v = SMODS.Centers[key];
                if G.GAME.modifiers.tower_no_jokers and v.set == 'Joker' then
                    G.GAME.banned_keys[v.key] = true
                    return true
                end
                if G.GAME.modifiers.tower_no_consumables then
                    for _,s in ipairs(SMODS.ConsumableType.ctype_buffer) do
                        if v.set == s then
                            G.GAME.banned_keys[v.key] = true
                            return true
                        end
                    end
                end
            end
            return nil
        end
    })
    return game
end
G.tower_default_book = 6
