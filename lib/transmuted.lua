function Tower.transmuted_collection(args)
  _pool = G.P_CENTER_POOLS.tower_transmuted
  rows = SMODS.ConsumableTypes.tower_transmuted.collection_rows
  args = args or {}
  args.w_mod = args.w_mod or 1
  args.h_mod = args.h_mod or 1
  args.card_scale = args.card_scale or 1
  local deck_tables = {}
  local pool = SMODS.collection_pool(_pool)

  G.your_collection = {}
  local cards_per_page = 0
  local row_totals = {}
  for j = 1, #rows do
    if cards_per_page >= #pool and args.collapse_single_page then
      rows[j] = nil
    else
      row_totals[j] = cards_per_page
      cards_per_page = cards_per_page + rows[j]
      G.your_collection[j] = CardArea(
        G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
        (args.w_mod*rows[j]+0.25)*G.CARD_W,
        args.h_mod*G.CARD_H, 
        {card_limit = rows[j], type = args.area_type or 'title', highlight_limit = 0, collection = true}
      )
      table.insert(deck_tables, 
      {n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true}, nodes={
        {n=G.UIT.O, config={object = G.your_collection[j]}}
      }})
    end
  end

  local options = {}
  for i = 1, math.ceil(#pool/cards_per_page) do
    table.insert(options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#pool/cards_per_page)))
  end

  G.FUNCS.SMODS_card_collection_page = function(e)
    if not e or not e.cycle_config then return end
    for j = 1, #G.your_collection do
      for i = #G.your_collection[j].cards, 1, -1 do
      local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
      c:remove()
      c = nil
      end
    end
    for j = 1, #rows do
      for i = 1, rows[j] do
      local center = pool[i+row_totals[j] + (cards_per_page*(e.cycle_config.current_option - 1))]
      if not center then break end
      local card
      if center.tower_create_card then
        card = center.tower_create_card(center, G.your_collection[j].T.x + G.your_collection[j].T.w/2, G.your_collection[j].T.y, G.CARD_W*args.card_scale, G.CARD_H*args.card_scale)
      else
        card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w/2, G.your_collection[j].T.y, G.CARD_W*args.card_scale, G.CARD_H*args.card_scale, G.P_CARDS.empty, (args.center and G.P_CENTERS[args.center]) or center)
      end
      if args.modify_card then args.modify_card(card, center, i, j) end
      if not args.no_materialize then card:start_materialize(nil, i>1 or j>1) end
      G.your_collection[j]:emplace(card)
      end
    end
    INIT_COLLECTION_CARD_ALERTS()
  end

  G.FUNCS.SMODS_card_collection_page{ cycle_config = { current_option = 1 }}
  
  local t = create_UIBox_generic_options({
    colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_colour or (G.ACTIVE_MOD_UI.ui_config or {}).colour),
    bg_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_bg_colour or (G.ACTIVE_MOD_UI.ui_config or {}).bg_colour),
    back_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_back_colour or (G.ACTIVE_MOD_UI.ui_config or {}).back_colour),
    outline_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_outline_colour or
      (G.ACTIVE_MOD_UI.ui_config or {}).outline_colour),
    back_func = (args and args.back_func) or G.ACTIVE_MOD_UI and "openModUI_"..G.ACTIVE_MOD_UI.id or 'your_collection', snap_back = args.snap_back, infotip = localize('k_tower_transmuted_ex'), contents = {
      {n=G.UIT.R, config={align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes=deck_tables}, 
      (not args.hide_single_page or cards_per_page < #pool) and {n=G.UIT.R, config={align = "cm"}, nodes={
        create_option_cycle({options = options, w = 4.5, cycle_shoulders = true, opt_callback = 'SMODS_card_collection_page', current_option = 1, colour = G.ACTIVE_MOD_UI and (G.ACTIVE_MOD_UI.ui_config or {}).collection_option_cycle_colour or G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
      }} or nil,
  }})
  return t
end
G.FUNCS.your_collection_tower_transmuted = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu {
        definition = Tower.transmuted_collection({ back_func = 'your_collection' })
    }
end
function Tower.CountTransmuted()
  local obj_tally = { of = 0, tally = 0 }
  if G.ACTIVE_MOD_UI and (Cryptid.mod_gameset_whitelist[G.ACTIVE_MOD_UI.id] or G.ACTIVE_MOD_UI.id == "Cryptid") then
    local pool = {}
    for _, v in pairs(G.tower_transmuted_pool_copy) do
      if (not G.ACTIVE_MOD_UI or (v.mod and G.ACTIVE_MOD_UI.id == v.mod.id)) and not v.no_collection then
        obj_tally.of = obj_tally.of + 1
        if Cryptid.enabled(v.key) == true then
          obj_tally.tally = obj_tally.tally + 1
        end
      end
    end
  else
    local set = set or nil

    for _, v in pairs(G.tower_transmuted_pool_copy) do
      if (not G.ACTIVE_MOD_UI or (v.mod and G.ACTIVE_MOD_UI.id == v.mod.id)) and not v.no_collection then
        obj_tally.of = obj_tally.of+1
        if v.discovered then 
          obj_tally.tally = obj_tally.tally+1
        end
      end
    end
  end
  return obj_tally
end