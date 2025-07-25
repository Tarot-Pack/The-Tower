G.FUNCS.your_collection_tower_transmuted = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu {
        definition = SMODS.card_collection_UIBox(G.P_CENTER_POOLS.tower_transmuted, SMODS.ConsumableTypes.tower_transmuted.collection_rows, { back_func = 'your_collection' })
    }
end
--[[
{ back_func = G.STAGE == G.STAGES.RUN and 'options' or 'exit_overlay_menu', contents = {
    {n=G.UIT.C, config={align = "cm", padding = 0.15}, nodes={
      UIBox_button({button = 'your_collection_jokers', label = {localize('b_jokers')}, count = G.DISCOVER_TALLIES.jokers,  minw = 5, minh = 1.7, scale = 0.6, id = 'your_collection_jokers'}),
      UIBox_button({button = 'your_collection_decks', label = {localize('b_decks')}, count = G.DISCOVER_TALLIES.backs, minw = 5}),
      UIBox_button({button = 'your_collection_vouchers', label = {localize('b_vouchers')}, count = G.DISCOVER_TALLIES.vouchers, minw = 5, id = 'your_collection_vouchers'}),
      {n=G.UIT.R, config={align = "cm", padding = 0.1, r=0.2, colour = G.C.BLACK}, nodes={
        {n=G.UIT.C, config={align = "cm", maxh=2.9}, nodes={
          {n=G.UIT.T, config={text = localize('k_cap_consumables'), scale = 0.45, colour = G.C.L_BLACK, vert = true, maxh=2.2}},
        }},
        {n=G.UIT.C, config={align = "cm", padding = 0.15}, nodes={
          UIBox_button({button = 'your_collection_tarots', label = {localize('b_tarot_cards')}, count = G.DISCOVER_TALLIES.tarots, minw = 4, id = 'your_collection_tarots', colour = G.C.SECONDARY_SET.Tarot}),
          UIBox_button({button = 'your_collection_planets', label = {localize('b_planet_cards')}, count = G.DISCOVER_TALLIES.planets, minw = 4, id = 'your_collection_planets', colour = G.C.SECONDARY_SET.Planet}),
          UIBox_button({button = 'your_collection_spectrals', label = {localize('b_spectral_cards')}, count = G.DISCOVER_TALLIES.spectrals, minw = 4, id = 'your_collection_spectrals', colour = G.C.SECONDARY_SET.Spectral}),
        }}
      }},
    }},
    {n=G.UIT.C, config={align = "cm", padding = 0.15}, nodes={
      UIBox_button({button = 'your_collection_enhancements', label = {localize('b_enhanced_cards')}, minw = 5}),
      UIBox_button({button = 'your_collection_seals', label = {localize('b_seals')}, minw = 5, id = 'your_collection_seals'}),
      UIBox_button({button = 'your_collection_editions', label = {localize('b_editions')}, count = G.DISCOVER_TALLIES.editions, minw = 5, id = 'your_collection_editions'}),
      UIBox_button({button = 'your_collection_boosters', label = {localize('b_booster_packs')}, count = G.DISCOVER_TALLIES.boosters, minw = 5, id = 'your_collection_boosters'}),
      UIBox_button({button = 'your_collection_tags', label = {localize('b_tags')}, count = G.DISCOVER_TALLIES.tags, minw = 5, id = 'your_collection_tags'}),
      UIBox_button({button = 'your_collection_blinds', label = {localize('b_blinds')}, count = G.DISCOVER_TALLIES.blinds, minw = 5, minh = 2.0, id = 'your_collection_blinds', focus_args = {snap_to = true}}),
    }},
    
  }}]]