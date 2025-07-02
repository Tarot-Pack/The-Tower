function math.T_pow(a, b)
    a = to_big(a);
    b = to_big(b);
    if type(a) == 'number' then
        return a ^ b -- if b is somehow not a number causes crash
    end
    return a:pow(b)
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
    if G.GAME.stakeup_stake ~= nil and G.GAME.round_resets ~= nil and G.GAME.round_resets.ante ~= nil and G.jokers ~= nil then
        G.GAME.TowerStakesDoneAlready = G.GAME.TowerStakesDoneAlready or 1;
        G.GAME.stakeup_stake = math.max(math.min(math.floor((G.GAME.round_resets.ante - 1) / 8) + 1, 8), 1)
        for i = G.GAME.TowerStakesDoneAlready + 1, G.GAME.stakeup_stake do
            if i == 2 then 
                self.GAME.modifiers.no_blind_reward = self.GAME.modifiers.no_blind_reward or {}
                self.GAME.modifiers.no_blind_reward.Small = true
            end
            if i == 3 then self.GAME.modifiers.scaling = 2 end
            if i == 4 then self.GAME.modifiers.enable_eternals_in_shop = true end
            if i == 5 then self.GAME.starting_params.discards = self.GAME.starting_params.discards - 1 end
            if i == 6 then self.GAME.modifiers.scaling = 3 end
            if i == 7 then self.GAME.modifiers.enable_perishables_in_shop = true end
            if i == 8 then self.GAME.modifiers.enable_rentals_in_shop = true end
        end
        G.GAME.TowerStakesDoneAlready = G.GAME.stakeup_stake
    end
    if G.GAME.modifiers.cry_force_edition then
        G.GAME.modifiers.TowerForceEdition = G.GAME.modifiers.cry_force_edition -- not stake related at all
    else
        G.GAME.modifiers.cry_force_edition = G.GAME.modifiers.TowerForceEdition -- not stake related at all
    end
end

local stake_spr = get_stake_sprite;
function get_stake_sprite(_stake, _scale, _view)
  if not _view then return stake_spr(_stake, _scale) end
  _stake = G.GAME.stakeup_stake or 1
  G.GAME.stakeup_stake = _stake;
  _scale = _scale or 1
  local stake_sprite = Sprite(0,0,_scale*1,_scale*1,G.ASSET_ATLAS["chips"], G.P_CENTER_POOLS.Stakeup[_stake].pos)
  stake_sprite.states.drag.can = false
  local sp = stake_sprite.draw
  stake_sprite.draw = function(_sprite)
    stake_sprite:set_sprite_pos(G.P_CENTER_POOLS.Stakeup[G.GAME.stakeup_stake].pos)
    if G.GAME.stakeup_stake < 8 then return sp(_sprite) end
    _sprite.ARGS.send_to_shader = _sprite.ARGS.send_to_shader or {}
    _sprite.ARGS.send_to_shader[1] = math.min(_sprite.VT.r*3, 1) + G.TIMERS.REAL/(18) + (_sprite.juice and _sprite.juice.r*20 or 0) + 1
    _sprite.ARGS.send_to_shader[2] = G.TIMERS.REAL

    Sprite.draw_shader(_sprite, 'dissolve')
    Sprite.draw_shader(_sprite, 'voucher', nil, _sprite.ARGS.send_to_shader)
  end
  return stake_sprite
end

local old_blind_tag = create_UIBox_blind_tag

function create_UIBox_blind_tag(blind_choice, run_info)
    if G.GAME.modifiers.tower_no_skip then
        return {n=G.UIT.R, config={id = 'tag_container', ref_table = _tag, align = "cm"}, nodes={}}
    end
    return old_blind_tag(blind_choice, run_info)
end

-- do the funny (this is so horribly hacky that i think god might kill me)
G.P_STAKEUP = G.P_STAKES;
G.P_CENTER_POOLS.Stakeup = G.P_CENTER_POOLS.Stake;
G.P_STAKES = {}
G.P_CENTER_POOLS.Stake = {}
SMODS.Stake.inject = function(self)
    if not G.P_CENTER_POOLS.Stakeup then
        G.P_CENTER_POOLS.Stakeup = {}
    end
    if not G.P_STAKEUP then
        G.P_STAKEUP = {}
    end
    local P_STAKES = G.P_STAKES;
    if self.__is_book then
        self.set = "Book"
    elseif self.set == "Stakeup" then
        self.set = "Stake"
    end
    if self.set == "Stake" then
        self.set = "Stakeup"
        P_STAKES = G.P_STAKEUP;
    elseif self.set == "Book" then
        self.set = "Stake"
        self.__is_book = true
    end
    if not self.injected then
        -- Inject stake in the correct spot
        self.count = #G.P_CENTER_POOLS[self.set] + 1
        self.order = self.count
        if self.above_stake and P_STAKES[self.above_stake] then
            self.order = P_STAKES[self.above_stake].order + 1
        end
        for _, v in pairs(P_STAKES) do
            if v.order >= self.order then
                v.order = v.order + 1
            end
        end
        P_STAKES[self.key] = self
        table.insert(G.P_CENTER_POOLS[self.set], self)
        -- Sticker sprites (stake_ prefix is removed for vanilla compatiblity)
        if self.sticker_pos ~= nil then
            G.shared_stickers[self.key:sub(7)] = Sprite(0, 0, G.CARD_W, G.CARD_H,
            G.ASSET_ATLAS[self.sticker_atlas] or G.ASSET_ATLAS["stickers"], self.sticker_pos)
            G.sticker_map[self.key] = self.key:sub(7)
        else
            G.sticker_map[self.key] = nil
        end
    else
        P_STAKES[self.key] = self
        SMODS.insert_pool(G.P_CENTER_POOLS[self.set], self)
    end
    self.injected = true
    -- should only need to do this once per injection routine
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