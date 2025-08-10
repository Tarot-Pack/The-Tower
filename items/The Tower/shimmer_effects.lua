Tower.Shimmer = Tower.Shimmer or {}
Tower.Shimmer.Effects = {}
Tower.Shimmer["Into"] = {}

Tower.Shimmer.OrtaConversions = Tower.ShimmerOrtaConversions;
Tower.ShimmerOrtaConversions = nil

-- omens (any not here go into the default (inversion => Tower.Shimmer.Into[inversion] => invert each item in output) which usually don't make sense)
Tower.Shimmer.Into['c_entr_beyond'] = { 'c_entr_ward', 'c_entr_fervour' }
Tower.Shimmer.Into['c_entr_rend'] = { 'c_entr_weld' }
Tower.Shimmer.Into['c_entr_weld'] = { 'c_entr_rend' }
Tower.Shimmer.Into['c_entr_ward'] = { 'c_entr_feast', 'c_entr_master' }
Tower.Shimmer.Into['c_entr_ichor'] = { 'c_entr_dispel', 'c_entr_dispel', 'c_entr_dispel' };
Tower.Shimmer.Into['c_entr_rejuvenate'] = { 'c_entr_regenerate' };
Tower.Shimmer.Into['c_entr_crypt'] = { 'c_entr_statue', 'c_entr_disavow' };
Tower.Shimmer.Into['c_entr_dispel'] = { 'c_entr_evocation' };
Tower.Shimmer.Into['c_entr_evocation'] = { 'c_entr_dispel' };

-- spectrals ( and the monolith )
Tower.Shimmer.Into['c_soul'] = { 'c_tower_aether_monolith' }
Tower.Shimmer.Into['c_tower_aether_monolith'] = { 'c_soul' }
Tower.Shimmer.Into['c_cry_gateway'] = { 'c_soul', 'c_ankh' }
Tower.Shimmer.Into['c_familiar'] = { 'c_incantation' }
Tower.Shimmer.Into['c_incantation'] = { 'c_familiar' }
Tower.Shimmer.Into['c_sigil'] = { 'c_ouija' }
Tower.Shimmer.Into['c_ouija'] = { 'c_sigil' }
Tower.Shimmer.Into['c_deja_vu'] = { 'c_talisman' }
Tower.Shimmer.Into['c_talisman'] = { 'c_deja_vu' }
Tower.Shimmer.Into['c_medium'] = { 'c_trance' }
Tower.Shimmer.Into['c_trance'] = { 'c_medium' }
Tower.Shimmer.Into['c_grim'] = { 'c_familiar', 'c_ouija' }
Tower.Shimmer.Into['c_immolate'] = { 'c_talisman', 'c_hanged_man' }
Tower.Shimmer.Into['c_black_hole'] = { 'c_cry_white_hole' }
Tower.Shimmer.Into['c_cry_white_hole'] = { 'c_black_hole' }
Tower.Shimmer.Into['c_hex'] = { 'c_aura' }
Tower.Shimmer.Into['c_aura'] = { 'c_hex' }
Tower.Shimmer.Into['c_cryptid'] = { 'c_fool', 'c_incantation' }
Tower.Shimmer.Into['c_wraith'] = { 'c_judgement', 'c_fool' }
Tower.Shimmer.Into['c_ectoplasm'] = { 'c_hanged_man', 'c_cryptid' }
Tower.Shimmer.Into['c_cry_replica'] = { 'c_cryptid', 'c_cryptid', 'c_cryptid' }
Tower.Shimmer.Into['c_cry_summoning'] = { 'c_wraith', 'c_wraith' }
Tower.Shimmer.Into['c_cry_typhoon'] = { 'c_trance', 'c_trance', 'c_trance' }
Tower.Shimmer.Into['c_cry_meld'] = { 'c_cryptid', 'c_cryptid' }
Tower.Shimmer.Into['c_cry_lock'] = { 'c_wraith', 'c_ectoplasm' }
Tower.Shimmer.Into['c_cry_vacuum'] = { 'c_immolate', 'c_cryptid' }
Tower.Shimmer.Into['c_cry_hammerspace'] = { 'c_cry_theblessing', 'c_cry_merge' }
Tower.Shimmer.Into['c_cry_trade'] = { 'c_cry_keygen', 'c_cry_keygen' }
Tower.Shimmer.Into['c_cry_analog'] = { 'c_ankh', 'c_ankh' }
Tower.Shimmer.Into['c_ankh'] = { 'c_judgement', 'c_hanged_man' }
Tower.Shimmer.Into['c_cry_ritual'] = { 'c_aura', 'c_ectoplasm' }
Tower.Shimmer.Into['c_cry_adversary'] = { 'c_ectoplasm', 'c_ectoplasm', 'c_ectoplasm' }
Tower.Shimmer.Into['c_cry_chambered'] = { 'c_cry_ctrl_v', 'c_cry_ctrl_v', 'c_cry_ctrl_v', 'c_cry_adversary' }
Tower.Shimmer.Into['c_cry_conduit'] = { 'c_aura', 'c_aura' }
Tower.Shimmer.Into['c_cry_source'] = { 'c_medium', 'c_cry_automaton' }
Tower.Shimmer.Into['c_cry_pointer'] = { 'c_cry_pointer' }

-- tarots
Tower.Shimmer.Into['c_judgement'] = { 'c_fool', 'c_fool' }
Tower.Shimmer.Into['c_emperor'] = { 'c_high_priestess' }
Tower.Shimmer.Into['c_high_priestess'] = { 'c_emperor' }
Tower.Shimmer.Into['c_empress'] = { 'c_heirophant' }
Tower.Shimmer.Into['c_heirophant'] = { 'c_empress' }
Tower.Shimmer.Into['c_hanged_man'] = { 'c_death' }
Tower.Shimmer.Into['c_death'] = { 'c_hanged_man' }
Tower.Shimmer.Into['c_moon'] = { 'c_world' }
Tower.Shimmer.Into['c_world'] = { 'c_moon' }
Tower.Shimmer.Into['c_sun'] = { 'c_star' }
Tower.Shimmer.Into['c_star'] = { 'c_sun' }
Tower.Shimmer.Into['c_hermit'] = { 'c_temperance' }
Tower.Shimmer.Into['c_temperance'] = { 'c_hermit' }
Tower.Shimmer.Into['c_chariot'] = { 'c_devil' }
Tower.Shimmer.Into['c_devil'] = { 'c_chariot' }
Tower.Shimmer.Into['c_tower'] = { 'c_heirophant', 'c_heirophant' }
Tower.Shimmer.Into['c_lovers'] = { 'c_sun', 'c_star', 'c_moon', 'c_world' }
Tower.Shimmer.Into['c_justice'] = { 'c_wheel_of_fortune' }
Tower.Shimmer.Into['c_wheel_of_fortune'] = { 'c_justice' }
Tower.Shimmer.Into['c_strength'] = { 'c_heirophant' }
Tower.Shimmer.Into['c_cry_theblessing'] = { 'c_fool' }
Tower.Shimmer.Into['c_fool'] = { 'c_cry_theblessing' }
Tower.Shimmer.Into['c_cry_automaton'] = { 'c_cry_theblessing', 'c_fool' }
Tower.Shimmer.Into['c_cry_seraph'] = { 'c_cry_instability' }
Tower.Shimmer.Into['c_cry_instability'] = { 'c_cry_seraph' }
Tower.Shimmer.Into['c_cry_eclipse'] = { 'c_sun', 'c_deja_vu' }

-- multi-planets
Tower.Shimmer.Into['c_cry_Timantii'] = { 'c_uranus', 'c_mercury', 'c_pluto' }
Tower.Shimmer.Into['c_cry_Klubi'] = { 'c_jupiter', 'c_saturn', 'c_venus' }
Tower.Shimmer.Into['c_cry_Sydan'] = { 'c_neptune', 'c_mars', 'c_earth' }
Tower.Shimmer.Into['c_cry_Lapio'] = { 'c_eris', 'c_ceres', 'c_planet_x' }
Tower.Shimmer.Into['c_cry_Kaikki'] = { 'c_cry_marsmoons', 'c_cry_void', 'c_cry_asteroidbelt' }
Tower.Shimmer.Into['c_cry_voxel'] = { 'c_cry_declare', 'c_cry_declare', 'c_cry_declare' }
-- planets
Tower.Shimmer.Into['c_cry_asteroidbelt'] = { 'c_tower', 'c_pluto', 'c_pluto', 'c_pluto', 'c_pluto', 'c_pluto' }
Tower.Shimmer.Into['c_cry_sunplanet'] = { 'c_planet_x', 'c_pluto' }
Tower.Shimmer.Into['c_cry_planetlua'] = { 'c_black_hole', 'c_wheel_of_fortune' }
Tower.Shimmer.Into['c_cry_nstar'] = { 'c_cry_Timantii', 'c_cry_Klubi', 'c_cry_Lapio', 'c_cry_Kaikki', 'c_cry_voxel', 'c_wheel_of_fortune' }
Tower.Shimmer.Into['c_cry_universe'] = { 'c_cry_Timantii', 'c_cry_Klubi', 'c_cry_Lapio' }
Tower.Shimmer.Into['c_cry_marsmoons'] = { 'c_jupiter', 'c_jupiter', 'c_uranus', 'c_uranus' }
Tower.Shimmer.Into['c_cry_void'] = { 'c_jupiter', 'c_jupiter', 'c_uranus', 'c_uranus' }
Tower.Shimmer.Into['c_earth'] = { 'c_mercury', 'c_venus' }
Tower.Shimmer.Into['c_saturn'] = { 'c_pluto', 'c_mercury', 'c_venus', 'c_mars', 'c_planet_x' }
Tower.Shimmer.Into['c_ceres'] = { 'c_earth', 'c_jupiter' }
Tower.Shimmer.Into['c_eris'] = { 'c_planet_x', 'c_jupiter' }
Tower.Shimmer.Into['c_neptune'] = { 'c_saturn', 'c_jupiter' }
Tower.Shimmer.Into['c_uranus'] = { 'c_mercury', 'c_mercury' }
Tower.Shimmer.Into['c_jupiter'] = { 'c_pluto', 'c_pluto', 'c_pluto', 'c_pluto', 'c_pluto', 'c_lovers' }
Tower.Shimmer.Into['c_planet_x'] = { 'c_mars', 'c_pluto' }
Tower.Shimmer.Into['c_mars'] = { 'c_venus', 'c_pluto' }
Tower.Shimmer.Into['c_venus'] = { 'c_mercury', 'c_pluto' }
Tower.Shimmer.Into['c_mercury'] = { 'c_pluto', 'c_pluto' }

-- code cards
Tower.Shimmer.Into['c_cry_exploit'] = { 'c_cry_Timantii', 'c_cry_Klubi', 'c_cry_Lapio', 'c_cry_Kaikki', 'c_cry_voxel', 'c_cry_sunplanet', 'c_cry_sunplanet' }
Tower.Shimmer.Into['c_cry_payload'] = { 'c_hermit','c_hermit' }
Tower.Shimmer.Into['c_cry_malware'] = { 'c_heirophant', 'c_cry_automaton' }
Tower.Shimmer.Into['c_cry_nperror'] = { 'c_cry_exploit', 'c_cry_ctrl_v' }
Tower.Shimmer.Into['c_cry_rework'] = { 'c_aura', 'c_cry_keygen' }
Tower.Shimmer.Into['c_cry_merge'] = { 'c_fool', 'c_cry_ctrl_v' }
Tower.Shimmer.Into['c_cry_commit'] = { 'c_judgement', 'c_hanged_man' }
Tower.Shimmer.Into['c_cry_machinecode'] = { 'c_cry_malware', 'c_cry_blessing' }
Tower.Shimmer.Into['c_cry_spagetti'] = { 'c_cry_commit', 'c_judgement' }
Tower.Shimmer.Into['c_cry_seed'] = { 'c_cry_keygen' }
Tower.Shimmer.Into['c_cry_keygen'] = { 'c_cry_seed' }
Tower.Shimmer.Into['c_cry_patch'] = { 'c_cry_vacuum', 'c_cry_automaton' }
Tower.Shimmer.Into['c_cry_hook'] = { 'c_judgement', 'c_cry_eclipse' }
Tower.Shimmer.Into['c_cry_oboe'] = { 'c_cry_blessing', 'c_cry_ctrl_v' }
Tower.Shimmer.Into['c_cry_assemble'] = { 'c_empress', 'c_judgement' }
Tower.Shimmer.Into['c_cry_inst'] = { 'c_ouija', 'c_sigil' }
Tower.Shimmer.Into['c_cry_revert'] = { 'c_cry_reboot', 'c_cry_reboot', 'c_cry_reboot' }
Tower.Shimmer.Into['c_cry_cryfunction'] = { 'c_cry_log' }
Tower.Shimmer.Into['c_cry_log'] = { 'c_cry_cryfunction' }
Tower.Shimmer.Into['c_cry_run'] = { 'c_cry_semicolon' }
Tower.Shimmer.Into['c_cry_semicolon'] = { 'c_cry_run' }
Tower.Shimmer.Into['c_cry_declare'] = { 'c_cry_automaton', 'c_pluto', 'c_pluto', 'c_pluto', 'c_pluto', 'c_pluto' }
Tower.Shimmer.Into['c_cry_class'] = { 'c_cry_class' }
Tower.Shimmer.Into['c_cry_variable'] = { 'c_cry_variable' }
Tower.Shimmer.Into['c_cry_global'] = { 'c_cry_ctrl_v', 'c_cryptid' }
Tower.Shimmer.Into['c_cry_quantify'] = { 'c_cry_ctrl_v', 'c_judgement' }
Tower.Shimmer.Into['c_cry_divide'] = { 'c_cry_multiply' }
Tower.Shimmer.Into['c_cry_multiply'] = { 'c_cry_divide' }
Tower.Shimmer.Into['c_cry_delete'] = { 'c_cry_ctrl_v' }
Tower.Shimmer.Into['c_cry_ctrl_v'] = { 'c_cry_delete' }
Tower.Shimmer.Into['c_cry_reboot'] = { 'c_cry_alttab' }
Tower.Shimmer.Into['c_cry_alt_tab'] = { 'c_cry_reboot' }



Tower.Shimmer.Into["j_joker"] = {"j_half", "j_half"}

function Tower.Shimmer.Effect(object)
    object.priority = object.priority or 1
    if object.can_use == nil then
        function object.can_use()
            return true
        end
    end
	Tower.Shimmer.Effects[#Tower.Shimmer.Effects+1] = object
end

function Tower.PickFixed(options, exclude, amount, key)
    local pool = {};
    for i, v in ipairs(options) do
        if v ~= exclude then
            pool[#pool+1] = v
        end
    end
    local results = {}
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

function Tower.ShuffleInPlace(t, seed)
    for i = #t, 2, -1 do
        local j = pseudorandom(seed, 1, i)
        t[i], t[j] = t[j], t[i]
    end
end

local old_get_chip_bonus = Card.get_chip_bonus;
function Card:get_chip_bonus()
    if not self.ability.tower_shimmer_mult then return old_get_chip_bonus(self) end
    -- prevent nominal from scoring as chips for shimmer mult
    local old = self.base.nominal;
    self.base.nominal = 0;
    local val = old_get_chip_bonus(self);
    self.base.nominal = old;
    return val
end
local old_get_chip_mult = Card.get_chip_mult;
function Card:get_chip_mult()
    if not self.ability.tower_shimmer_mult then return old_get_chip_mult(self) end
    local val = old_get_chip_mult(self);
    if not self.config.center.replace_base_card then
        return val + self.base.nominal
    end
    return val
end

function Tower.IsTransmutedPlayingCard(card)
    return card.ability and card.ability.tower_shimmer_mult and not (card.config.center.replace_base_card or card.config.center.key == "m_stone")
end

Tower.Shader {
	key = "transmuted",
	path = "transmuted.fs",
}

Tower.DrawStep {
    key = 'transmuted_shader',
    order = 29,
    func = function(self)
        if self.ability.tower_shimmer_mult and not (self.config.center.replace_base_card or self.config.center.key == "m_stone") then
            self.children.front:draw_shader('tower_transmuted', nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

Tower.Shimmer.Effect({ -- multage
    priority = -1,
    can_use = function (self, other)
        if not G.P_CENTERS.desc_tower_mult_rank then return end -- disabling the desc card removes the mechanic
        if other.ability.set == "Default" or other.ability.set == "Enhanced" then
            return true
        end
    end,
    use = function (self, other)
        if not G.P_CENTERS.desc_tower_mult_rank then return end -- disabling the desc card removes the mechanic
        other.ability.tower_shimmer_mult = not (other.ability.tower_shimmer_mult or false) -- Spades of 5
    end
})

Tower.Shimmer.Effect({
    priority = 9999999999,
    can_use = function (self, other)
        if other.config.center.key == 'c_entr_entropy' then
            return true
        end
    end,
    use = function (self, other)
        local options = {}
        for i, v in pairs(G.P_CENTERS) do
            if v.consumeable and (not v.soul_set) then -- all non-soul consumables (all transmuted are marked as soul)
                options[#options+1] = v;
            end
        end
        for i = 1, 3 do
            local center, remove = pseudorandom_element(options, pseudoseed('tower_entropy_shimmer'))
            table.remove(options, remove)
            local _card = SMODS.add_card({
                key = center.key,
                area = other.tower_area or other.area,
            })
            if (other.tower_area or other.area) == G.shop_jokers then
                create_shop_card_ui(_card)
            end
        end
        other:set_ability(pseudorandom_element(options, pseudoseed('tower_entropy_shimmer')))
        other:set_cost()
    end
})

Tower.Shimmer.Effect({ -- fallback for jokers (decraft into two of lower rarity or two jimbos if common)
    priority = -1,
    can_use = function (self, other)
        if other.ability.set == "Joker" and (
            Tower.TableHasElement(Tower.RarityOrder, (Tower.IndexToRarity[other.config.center.rarity] or other.config.center.rarity))
            or Tower.TableHasElement(Tower.FinalRarities, other.config.center.rarity)
        ) and other.config.center.key ~= 'j_half' then 
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
            centers = {G.P_CENTERS.j_joker, G.P_CENTERS.j_joker}
        else
            centers = Tower.PickFixed(G.P_JOKER_RARITY_POOLS[Tower.RarityToIndex[rarityInto] or rarityInto], other.config.center, 2, "shimmer_into"..other.config.center.key)
        end
        other:start_dissolve()
        for i, center in ipairs(centers) do
            local _card = SMODS.add_card({
                key = center.key,
                area = other.tower_area or other.area,
            })
            if (other.tower_area or other.area) == G.shop_jokers then
                create_shop_card_ui(_card)
            end
        end
    end
})

Tower.Shimmer.Effect({ -- Slime into shimmer slime and back
    can_use = function (self, other)
        if Tower.HasPool('Tower-Slime', other) and other.ability.set == "Joker" and (G.P_CENTERS.j_tower_shimmer_slime) then
            return true
        end
    end,
    use = function (self, other)
        other:set_ability(G.P_CENTERS.j_tower_shimmer_slime)
        other:set_cost()
    end
})

Tower.Shimmer.Effect({ -- ortalab conversions (Tower.Shimmer.OrtaConversions)
    priority = 1,
    can_use = function (self, other)
        if G.P_CENTERS[Tower.Shimmer.OrtaConversions[other.config.center.key]] then -- check if conversion exists and joker to convert to exists
            return true
        end
    end,
    use = function (self, other)
        other:set_ability(G.P_CENTERS[Tower.Shimmer.OrtaConversions[other.config.center.key]])
        other:set_cost()
    end
})

Tower.Shimmer.Effect({ -- Entropy inverted consum compat
    priority = 999999998,
    can_use = function (self, other)
        if not Entropy then return false end
        if Tower.Shimmer.Into[Entropy.FlipsideInversions[other.config.center.key]] then
            local into = Tower.Shimmer.Into[Entropy.FlipsideInversions[other.config.center.key]]
            if type(into) ~= 'table' then
                into = { into }
            end
            local filtered = {}
            for i, v in ipairs(into) do
                if G.P_CENTERS[Entropy.FlipsideInversions[v]] then
                    filtered[#filtered+1] = v
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
            local into = Tower.Shimmer.Into[Entropy.FlipsideInversions[other.config.center.key]]
            if type(into) ~= 'table' then
                into = { into }
            end
            if #into == 1 then
                other:set_ability(Entropy.FlipsideInversions[into[1]])
                other:set_cost()
            else
                other:start_dissolve()
                for i, v in ipairs(into) do
                    local center = G.P_CENTERS[Entropy.FlipsideInversions[v]]
                    if center ~= nil then
                        local _card = SMODS.add_card({
                            key = center.key,
                            area = other.tower_area or other.area,
                        })
                        if (other.tower_area or other.area) == G.shop_jokers then
                            create_shop_card_ui(_card)
                        end
                    end
                end
            end
        end
    end
})

Tower.Shimmer.Effect({ -- Generic shimmer effect
    priority = 999999999,
    can_use = function (self, other)
        if (other.config.center.shimmer_into or Tower.Shimmer.Into[other.config.center.key]) then
            local into = other.config.center.shimmer_into or Tower.Shimmer.Into[other.config.center.key]
            if type(into) ~= 'table' then
                into = { into }
            end
            local filtered = {}
            for i, v in ipairs(into) do
                if G.P_CENTERS[v] then
                    filtered[#filtered+1] = v
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
            local into = other.config.center.shimmer_into or Tower.Shimmer.Into[other.config.center.key]
            if type(into) ~= 'table' then
                into = { into }
            end
            if #into == 1 then
                other:set_ability(into[1])
                other:set_cost()
            else
                other:start_dissolve()
                for i, v in ipairs(into) do
                    local center = G.P_CENTERS[v]
                    if center ~= nil then
                        local _card = SMODS.add_card({
                            key = center.key,
                            area = other.tower_area or other.area,
                        })
                        if (other.tower_area or other.area) == G.shop_jokers then
                            create_shop_card_ui(_card)
                        end
                    end
                end
            end
        end
    end
})

function Tower.Shimmer.CanApply(self, card, cards, max)
	if max == nil then
		if #cards == 0 then
			return false
		end
	else
		if #cards > max or #cards == 0 then
			return false
		end
	end
	for q = 1, #cards do
		local is_good = false
		for i = 1, #Tower.Shimmer.Effects do
			if Tower.Shimmer.Effects[i].can_use and Tower.Shimmer.Effects[i].can_use(self, cards[q], card.area, card) then
				is_good = true
				break
			end
		end
		if not is_good then
			return false
		end
	end
	return true
end

function Tower.Shimmer.Apply(self, card, cards)
	table.sort(Tower.Shimmer.Effects, function (a, b)
		return a.priority > b.priority
	end)
	Tower.EntComp.FlipThen(cards, function(item, area)
		for i = 1, #Tower.Shimmer.Effects do
			if Tower.Shimmer.Effects[i].can_use and Tower.Shimmer.Effects[i].can_use(self, item, area, card) then
				Tower.Shimmer.Effects[i].use(self, item, area, card)
				return
			end
		end
	end)
end