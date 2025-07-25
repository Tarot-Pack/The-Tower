Tower.ShimmerEffects = {}
Tower.ShimmerInto = {}


-- spectrals ( and the monolith )

Tower.ShimmerInto['c_soul'] = { 'c_tower_aether_monolith' }
Tower.ShimmerInto['c_tower_aether_monolith'] = { 'c_soul' }
Tower.ShimmerInto['c_cry_gateway'] = { 'c_soul', 'c_ankh' }
Tower.ShimmerInto['c_entr_beyond'] = { 'c_cry_gateway', 'c_entr_flipside' }
Tower.ShimmerInto['c_familiar'] = { 'c_incantation' }
Tower.ShimmerInto['c_incantation'] = { 'c_familiar' }
Tower.ShimmerInto['c_sigil'] = { 'c_ouija' }
Tower.ShimmerInto['c_ouija'] = { 'c_sigil' }
Tower.ShimmerInto['c_deja_vu'] = { 'c_talisman' }
Tower.ShimmerInto['c_talisman'] = { 'c_deja_vu' }
Tower.ShimmerInto['c_medium'] = { 'c_trance' }
Tower.ShimmerInto['c_trance'] = { 'c_medium' }
Tower.ShimmerInto['c_grim'] = { 'c_familiar', 'c_ouija' }
Tower.ShimmerInto['c_immolate'] = { 'c_talisman', 'c_hanged_man' }
Tower.ShimmerInto['c_black_hole'] = { 'c_cry_white_hole' }
Tower.ShimmerInto['c_cry_white_hole'] = { 'c_black_hole' }
Tower.ShimmerInto['c_hex'] = { 'c_aura' }
Tower.ShimmerInto['c_aura'] = { 'c_hex' }
Tower.ShimmerInto['c_cryptid'] = { 'c_fool', 'c_incantation' }
Tower.ShimmerInto['c_wraith'] = { 'c_judgement', 'c_fool' }
Tower.ShimmerInto['c_ectoplasm'] = { 'c_hanged_man', 'c_cryptid' }
Tower.ShimmerInto['c_cry_replica'] = { 'c_cryptid', 'c_cryptid', 'c_cryptid' }
Tower.ShimmerInto['c_cry_summoning'] = { 'c_wraith', 'c_wraith' }
Tower.ShimmerInto['c_cry_typhoon'] = { 'c_trance', 'c_trance', 'c_trance' }
Tower.ShimmerInto['c_cry_meld'] = { 'c_cryptid', 'c_cryptid' }
Tower.ShimmerInto['c_cry_lock'] = { 'c_wraith', 'c_ectoplasm' }
Tower.ShimmerInto['c_cry_vacuum'] = { 'c_immolate', 'c_cryptid' }
Tower.ShimmerInto['c_cry_hammerspace'] = { 'c_cry_theblessing', 'c_cry_merge' }
Tower.ShimmerInto['c_cry_trade'] = { 'c_cry_keygen', 'c_cry_keygen' }
Tower.ShimmerInto['c_cry_analog'] = { 'c_ankh', 'c_ankh' }
Tower.ShimmerInto['c_ankh'] = { 'c_judgement', 'c_hanged_man' }
Tower.ShimmerInto['c_cry_ritual'] = { 'c_aura', 'c_ectoplasm' }
Tower.ShimmerInto['c_cry_adversary'] = { 'c_ectoplasm', 'c_ectoplasm', 'c_ectoplasm' }
Tower.ShimmerInto['c_cry_chambered'] = { 'c_cry_ctrl_v', 'c_cry_ctrl_v', 'c_cry_ctrl_v', 'c_cry_adversary' }
Tower.ShimmerInto['c_cry_conduit'] = { 'c_aura', 'c_aura' }
Tower.ShimmerInto['c_cry_source'] = { 'c_medium', 'c_cry_automaton' }
Tower.ShimmerInto['c_cry_pointer'] = { 'c_cry_pointer' }

-- tarots
Tower.ShimmerInto['c_judgement'] = { 'c_fool', 'c_fool' }
Tower.ShimmerInto['c_emperor'] = { 'c_high_priestess' }
Tower.ShimmerInto['c_high_priestess'] = { 'c_emperor' }
Tower.ShimmerInto['c_empress'] = { 'c_heirophant' }
Tower.ShimmerInto['c_heirophant'] = { 'c_empress' }
Tower.ShimmerInto['c_hanged_man'] = { 'c_death' }
Tower.ShimmerInto['c_death'] = { 'c_hanged_man' }
Tower.ShimmerInto['c_moon'] = { 'c_world' }
Tower.ShimmerInto['c_world'] = { 'c_moon' }
Tower.ShimmerInto['c_sun'] = { 'c_star' }
Tower.ShimmerInto['c_star'] = { 'c_sun' }
Tower.ShimmerInto['c_hermit'] = { 'c_temperance' }
Tower.ShimmerInto['c_temperance'] = { 'c_hermit' }
Tower.ShimmerInto['c_chariot'] = { 'c_devil' }
Tower.ShimmerInto['c_devil'] = { 'c_chariot' }
Tower.ShimmerInto['c_tower'] = { 'c_heirophant', 'c_heirophant' }
Tower.ShimmerInto['c_lovers'] = { 'c_sun', 'c_star', 'c_moon', 'c_world' }
Tower.ShimmerInto['c_justice'] = { 'c_wheel_of_fortune' }
Tower.ShimmerInto['c_wheel_of_fortune'] = { 'c_justice' }
Tower.ShimmerInto['c_strength'] = { 'c_heirophant' }
Tower.ShimmerInto['c_cry_theblessing'] = { 'c_fool' }
Tower.ShimmerInto['c_fool'] = { 'c_cry_theblessing' }
Tower.ShimmerInto['c_cry_automaton'] = { 'c_cry_theblessing', 'c_fool' }
Tower.ShimmerInto['c_cry_seraph'] = { 'c_cry_instability' }
Tower.ShimmerInto['c_cry_instability'] = { 'c_cry_seraph' }
Tower.ShimmerInto['c_cry_eclipse'] = { 'c_sun', 'c_deja_vu' }

-- planets
-- multi-planets
Tower.ShimmerInto['c_cry_Timantii'] = { 'c_uranus', 'c_mercury', 'c_pluto' }
Tower.ShimmerInto['c_cry_Klubi'] = { 'c_jupiter', 'c_saturn', 'c_venus' }
Tower.ShimmerInto['c_cry_Sydan'] = { 'c_neptune', 'c_mars', 'c_earth' }
Tower.ShimmerInto['c_cry_Lapio'] = { 'c_eris', 'c_ceres', 'c_planet_x' }
Tower.ShimmerInto['c_cry_Kaikki'] = { 'c_cry_marsmoons', 'c_cry_void', 'c_cry_asteroidbelt' }
Tower.ShimmerInto['c_cry_voxel'] = { 'c_cry_declare', 'c_cry_declare', 'c_cry_declare' }

Tower.ShimmerInto['c_cry_asteroidbelt'] = { 'c_tower', 'c_pluto', 'c_pluto', 'c_pluto', 'c_pluto', 'c_pluto' }
Tower.ShimmerInto['c_cry_sunplanet'] = { 'c_planet_x', 'c_pluto' }
Tower.ShimmerInto['c_cry_planetlua'] = { 'c_black_hole', 'c_wheel_of_fortune' }
Tower.ShimmerInto['c_cry_nstar'] = { 'c_cry_Timantii', 'c_cry_Klubi', 'c_cry_Lapio', 'c_cry_Kaikki', 'c_cry_voxel', 'c_wheel_of_fortune' }
Tower.ShimmerInto['c_cry_universe'] = { 'c_cry_Timantii', 'c_cry_Klubi', 'c_cry_Lapio' }
Tower.ShimmerInto['c_cry_marsmoons'] = { 'c_jupiter', 'c_jupiter', 'c_uranus', 'c_uranus' }
Tower.ShimmerInto['c_cry_void'] = { 'c_jupiter', 'c_jupiter', 'c_uranus', 'c_uranus' }
Tower.ShimmerInto['c_earth'] = { 'c_mercury', 'c_venus' }
Tower.ShimmerInto['c_saturn'] = { 'c_pluto', 'c_mercury', 'c_venus', 'c_mars', 'c_planet_x' }
Tower.ShimmerInto['c_ceres'] = { 'c_earth', 'c_jupiter' }
Tower.ShimmerInto['c_eris'] = { 'c_planet_x', 'c_jupiter' }
Tower.ShimmerInto['c_neptune'] = { 'c_saturn', 'c_jupiter' }
Tower.ShimmerInto['c_uranus'] = { 'c_mercury', 'c_mercury' }
Tower.ShimmerInto['c_jupiter'] = { 'c_pluto', 'c_pluto', 'c_pluto', 'c_pluto', 'c_pluto', 'c_lovers' }
Tower.ShimmerInto['c_planet_x'] = { 'c_mars', 'c_pluto' }
Tower.ShimmerInto['c_mars'] = { 'c_venus', 'c_pluto' }
Tower.ShimmerInto['c_venus'] = { 'c_mercury', 'c_pluto' }
Tower.ShimmerInto['c_mercury'] = { 'c_pluto', 'c_pluto' }

-- code cards
Tower.ShimmerInto['c_cry_exploit'] = { 'c_cry_Timantii', 'c_cry_Klubi', 'c_cry_Lapio', 'c_cry_Kaikki', 'c_cry_voxel', 'c_cry_sunplanet', 'c_cry_sunplanet' }
Tower.ShimmerInto['c_cry_payload'] = { 'c_hermit','c_hermit' }
Tower.ShimmerInto['c_cry_malware'] = { 'c_heirophant', 'c_cry_automaton' }
Tower.ShimmerInto['c_cry_nperror'] = { 'c_cry_exploit', 'c_cry_ctrl_v' }
Tower.ShimmerInto['c_cry_rework'] = { 'c_aura', 'c_cry_keygen' }
Tower.ShimmerInto['c_cry_merge'] = { 'c_fool', 'c_cry_ctrl_v' }
Tower.ShimmerInto['c_cry_commit'] = { 'c_judgement', 'c_hanged_man' }
Tower.ShimmerInto['c_cry_machinecode'] = { 'c_cry_malware', 'c_cry_blessing' }
Tower.ShimmerInto['c_cry_spagetti'] = { 'c_cry_commit', 'c_judgement' }
Tower.ShimmerInto['c_cry_seed'] = { 'c_cry_keygen' }
Tower.ShimmerInto['c_cry_keygen'] = { 'c_cry_seed' }
Tower.ShimmerInto['c_cry_patch'] = { 'c_cry_vacuum', 'c_cry_automaton' }
Tower.ShimmerInto['c_cry_hook'] = { 'c_judgement', 'c_cry_eclipse' }
Tower.ShimmerInto['c_cry_oboe'] = { 'c_cry_blessing', 'c_cry_ctrl_v' }
Tower.ShimmerInto['c_cry_assemble'] = { 'c_empress', 'c_judgement' }
Tower.ShimmerInto['c_cry_inst'] = { 'c_ouija', 'c_sigil' }
Tower.ShimmerInto['c_cry_revert'] = { 'c_cry_reboot', 'c_cry_reboot', 'c_cry_reboot' }
Tower.ShimmerInto['c_cry_cryfunction'] = { 'c_cry_log' }
Tower.ShimmerInto['c_cry_log'] = { 'c_cry_cryfunction' }
Tower.ShimmerInto['c_cry_run'] = { 'c_cry_semicolon' }
Tower.ShimmerInto['c_cry_semicolon'] = { 'c_cry_run' }
Tower.ShimmerInto['c_cry_declare'] = { 'c_cry_automaton', 'c_pluto', 'c_pluto', 'c_pluto', 'c_pluto', 'c_pluto' }
Tower.ShimmerInto['c_cry_class'] = { 'c_cry_class' }
Tower.ShimmerInto['c_cry_variable'] = { 'c_cry_variable' }
Tower.ShimmerInto['c_cry_global'] = { 'c_cry_ctrl_v', 'c_cryptid' }
Tower.ShimmerInto['c_cry_quantify'] = { 'c_cry_ctrl_v', 'c_judgement' }
Tower.ShimmerInto['c_cry_divide'] = { 'c_cry_multiply' }
Tower.ShimmerInto['c_cry_multiply'] = { 'c_cry_divide' }
Tower.ShimmerInto['c_cry_delete'] = { 'c_cry_ctrl_v' }
Tower.ShimmerInto['c_cry_ctrl_v'] = { 'c_cry_delete' }
Tower.ShimmerInto['c_cry_reboot'] = { 'c_cry_alttab' }
Tower.ShimmerInto['c_cry_alt_tab'] = { 'c_cry_reboot' }





function Tower.ShimmerEffect(object)
    object.priority = object.priority or 1
    if object.can_use == nil then
        function object.can_use()
            return true
        end
    end
	Tower.ShimmerEffects[#Tower.ShimmerEffects+1] = object
end

function Tower.PickFixed(options, exclude, amount, key)
    local pool = {};
    for i, v in ipairs(options) do
        if v ~= exclude then
            pool[#pool+1] = v
        end
    end
    local results = {}
    print(amount, pool)
    for i = 1, amount do
        local elem, index = pseudorandom_element(pool, pseudoseed(key .. tostring(i), "fixed_prob"))
        results[#results+1] = elem
        table.remove(pool, index)
    end
    return results
end
Tower.IndexToRarity = {'Common', 'Uncommon', 'Rare', 'Legendary'}
Tower.RarityToIndex = {
    Common = 1, 
    Uncommon = 2, 
    Rare = 3, 
    Legendary = 4
}
Tower.RarityOrder = {'Common', 'Uncommon', 'Rare', 'cry_epic', 'Legendary'}
Tower.FinalRarities = {'cry_exotic', 'entr_entropic', 'tower_apollyon'}

function Tower.TableHasElement(table, elem)
    for i, v in ipairs(table) do
        if v == elem then
            return true
        end
    end
    return false
end


function Tower.IndexOf(table, elem)
    for i, v in ipairs(table) do
        if v == elem then
            return i
        end
    end
    return -1
end

Tower.ShimmerEffect({ -- fallback for jokers (decraft into two of lower rarity or two jimbos if common)
    priority = -1,
    can_use = function (self, other)
        if other.ability.set == "Joker" and (
            Tower.TableHasElement(Tower.RarityOrder, (Tower.IndexToRarity[other.config.center.rarity] or other.config.center.rarity))
            or Tower.TableHasElement(Tower.FinalRarities, other.config.center.rarity)
        ) then 
            return true
        end
    end,
    use = function (self, other)
        local rarityInto;
        if (Tower.IndexToRarity[other.config.center.rarity] or other.config.center.rarity) == 'Common' then
            rarityInto = 'jimbo'
        elseif Tower.TableHasElement(Tower.RarityOrder, (Tower.IndexToRarity[other.config.center.rarity] or other.config.center.rarity)) then
            rarityInto = Tower.RarityOrder[Tower.IndexOf(Tower.RarityOrder, (Tower.IndexToRarity[other.config.center.rarity] or other.config.center.rarity)) - 1];
        elseif Tower.TableHasElement(Tower.FinalRarities, other.config.center.rarity) then
            rarityInto = Tower.RarityOrder[#Tower.RarityOrder];
        end

        local centers;
        if rarityInto == 'jimbo' then
            centers = {'j_joker', 'j_joker'}
        else
            centers = Tower.PickFixed(G.P_JOKER_RARITY_POOLS[Tower.RarityToIndex[rarityInto] or rarityInto], other.config.center, 2, "shimmer_into"..other.config.center.key)
        end
        local area = other.area;
        other:start_dissolve()
        for i, center in ipairs(centers) do
            local _card = create_card("Joker", area, nil, nil, nil, nil, 'j_joker')
            _card:set_ability(center)
            _card:add_to_deck()
            _card:set_card_area(area)
            area:emplace(_card)
        end
        area:set_ranks()
        area:align_cards()
    end
})

Tower.ShimmerEffect({ -- Slime into shimmer slime and back
    can_use = function (self, other)
        if Tower.HasPool('Tower-Slime', other) and other.ability.set == "Joker" then
            return true
        end
    end,
    use = function (self, other)
        other:set_ability(G.P_CENTERS.j_tower_shimmer_slime)
    end
})

Tower.ShimmerEffect({ -- ortalab conversions (Tower.ShimmerOrtaConversions)
    priority = 1,
    can_use = function (self, other)
        if G.P_CENTERS[Tower.ShimmerOrtaConversions[other.config.center.key]] then -- check if conversion exists and joker to convert to exists
            return true
        end
    end,
    use = function (self, other)
        other:set_ability(G.P_CENTERS[Tower.ShimmerOrtaConversions[other.config.center.key]])
    end
})

Tower.ShimmerEffect({ -- Generic shimmer effect
    priority = 999999999,
    can_use = function (self, other)
        if (other.config.center.shimmer_into or Tower.ShimmerInto[other.config.center.key]) then
            local into = other.config.center.shimmer_into or Tower.ShimmerInto[other.config.center.key]
            if type(into) ~= 'table' then
                into = { into }
            end
            local filtered = {}
            for i, v in ipairs(into) do
                if G.P_CENTERS[v] then
                    filtered[#filtered+1] = V
                end
            end
            return #filtered > 0
        elseif other.config.center.shimmer_effect then
            return true
        end
    end,
    use = function (self, other)
        if other.config.center.shimmer_effect then
            other.config.center.shimmer_effect(other)
        else
            local into = other.config.center.shimmer_into or Tower.ShimmerInto[other.config.center.key]
            if type(into) ~= 'table' then
                into = { into }
            end
            if #into == 1 then
                other:set_ability(into[1])
            else
                local area = other.area;
                other:start_dissolve()
                for i, v in ipairs(into) do
                    local center = G.P_CENTERS[v]
                    print(v, center)
                    if center ~= nil then
                        local _card = create_card(center.set, area, nil, nil, nil, nil, v)
                        _card:add_to_deck()
                        _card:set_card_area(area)
                        area:emplace(_card)
                    end
                end
				area:set_ranks()
				area:align_cards()
            end
        end
    end
})
