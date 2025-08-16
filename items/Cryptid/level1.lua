Tower.Blind({
    tower_is_code = true,
    name = "tower-crash",
    tower_consumable = "cry_crash",
    key = "crash",
    pos = { x = 0, y = 11 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("ff0000"),
    boss = {
        level = 1
    },
    dollars = 4,

    set_blind = function ()
        G.GAME.FPS_CAP = 15
        G.GAME.modifiers.tower_crash_infection = true
    end,
    cry_after_play = function ()
        G.GAME.FPS_CAP = math.floor(G.GAME.FPS_CAP / 2)
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-keygen",
    tower_consumable = "cry_keygen",
    key = "keygen",
    pos = { x = 0, y = 12 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("ff9000"),
    boss = {
        level = 1
    },
    dollars = 4,

    set_blind = function ()
        if G.GAME.blind.disabled then return end
        if #G.jokers.cards == 0 then
            local fu = SMODS.add_card({
                set = "Joker",
                key = "j_joker",
                stickers = { "tower_fuckyou" }
            })
            SMODS.Stickers.tower_fuckyou:apply(fu, true)
            Tower.Eternal():apply(fu, true)
        end
        local randomJoker = pseudorandom_element(G.jokers.cards, pseudoseed('tower_keygen'))
        SMODS.Stickers.banana:apply(randomJoker, true)
        randomJoker:set_perishable(true)
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-payload",
    tower_consumable = "cry_payload",
    key = "payload",
    pos = { x = 0, y = 13 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("347bea"),
    boss = {
        level = 1
    },
    dollars = 4,

    cry_before_play = function ()
        local halfDollars = G.GAME.dollars / 2
        ease_dollars(-halfDollars)
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-exploit",
    tower_consumable = "cry_exploit",
    key = "exploit",
    pos = { x = 0, y = 14 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("954bd1"),
    boss = {
        level = 1
    },
    dollars = 4,

    cry_after_play = function ()
        if G.GAME.blind.disabled then return end
        local options = {};
        local lvl = nil;
        for i, v in pairs(G.GAME.hands) do
            if lvl == nil then
                lvl = v.level;
            end
            if v.level == lvl then
                options[#options+1] = i
            elseif v.level < lvl then
                lvl = v.level
                options = { i }
            end
        end
        Tower.forceExploit(pseudorandom_element(options, pseudoseed('tower_exploit')))
    end,
    disable = function ()
        Tower.forceExploit(nil)
    end,
    defeat = function ()
        Tower.forceExploit(nil)
    end,
    set_blind = function ()
        if G.GAME.blind.disabled then return end
        local options = {};
        local lvl = nil;
        for i, v in pairs(G.GAME.hands) do
            if lvl == nil then
                lvl = v.level;
            end
            if v.level == lvl then
                options[#options+1] = i
            elseif v.level < lvl then
                lvl = v.level
                options = { i }
            end
        end
        Tower.forceExploit(pseudorandom_element(options, pseudoseed('tower_exploit')))
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-malware",
    tower_consumable = "cry_malware",
    key = "malware",
    pos = { x = 0, y = 15 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("27dc40"),
    boss = {
        level = 1
    },
    dollars = 4,

    set_blind = function ()
        local pool = {}
        for i, v in ipairs(G.jokers.cards) do 
            if not v.ability.tower_virus then pool[#pool+1] = v end
        end
        for i, v in ipairs(G.playing_cards) do 
            if not v.ability.tower_virus then pool[#pool+1] = v end
        end
        for i, v in ipairs(G.consumeables.cards) do 
            if not v.ability.tower_virus then pool[#pool+1] = v end
        end
        if #G.jokers.cards == 0 and #G.playing_cards == 0 and #G.consumeables.cards then
            Tower.achieve("antivirus")
        else
            local center = pseudorandom_element(pool, pseudoseed('tower_virus'))
            center.ability.tower_virus = true
        end
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-nperror",
    tower_consumable = "cry_nperror",
    key = "nperror",
    pos = { x = 0, y = 16 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("2aeaa9"),
    boss = {
        level = 1
    },
    dollars = 4,
    cry_after_play = function ()
        if G.GAME.blind.disabled or G.GAME.tower_np_error_cards then return end
        G.GAME.tower_np_error_cards = {}
        for i = 1, #G.play.cards do
            G.GAME.tower_np_error_cards[i] = G.play.cards[i].config.card
        end
    end,
    disable = function ()
        G.GAME.tower_np_error_cards = nil
    end,
    defeat = function ()
        G.GAME.tower_np_error_cards = nil
    end,
	debuff_hand = function(self, cards, hand, handname, check)
        if G.GAME.blind.disabled or not G.GAME.tower_np_error_cards then return false end
        local bad = false;
        local pool = copy_table(G.GAME.tower_np_error_cards)
        for i, v in ipairs(cards) do
            local index = -1
            for q, z in ipairs(pool) do
                if z.suit == v.config.card.suit and z.value == v.config.card.value then
                    index = q
                    break
                end
            end
            if index == -1 then
                bad = true
                break;
            end
            table.remove(pool, index)
        end
        if #pool > 0 then
            bad = true
        end
		if
			bad
		then
			G.GAME.blind.triggered = true
			return true
		end
		return false
	end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})


Tower.Blind({
    tower_is_code = true,
    name = "tower-rework",
    tower_consumable = "cry_rework",
    key = "rework",
    pos = { x = 0, y = 17 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("d7266c"),
    boss = {
        level = 1
    },
    dollars = 4,

	cry_before_play = function ()
        local nukeDueToNeg = {}
        local reworkOrder = {'e_tower_truenegative'}
        local added = {}
        for i, v in pairs(G.P_CENTERS) do
            if v.set == "Edition" and i ~= 'e_tower_truenegative' then
                added[#added+1] = {i, v}
            end
        end
        table.sort(added, function (a, b) return a[2].order < b[2].order end)
        for i, v in ipairs(added) do
            reworkOrder[#reworkOrder+1] = v[1]
        end
        for i, v in ipairs(G.hand.highlighted) do
            local key = "e_base"
            if v.edition ~= nil then
                key = v.edition.key
            end
            local index = nil
            for i, v in ipairs(reworkOrder) do
                if v == key then
                    index = i 
                    break
                end
            end
            if index == nil then
                index = 0
            end
            index = index - 1
            if index < 0 then
                nukeDueToNeg[#nukeDueToNeg+1] = v 
            else
                v:set_edition(reworkOrder[index], nil, false)
            end
        end
        if #nukeDueToNeg > 0 then
            Tower.achieve('imaginary')
            SMODS.destroy_cards(nukeDueToNeg)
        end
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind(Tower.ObsidianOrb({
    tower_is_code = true,
    name = "tower-merge",
    tower_consumable = "cry_merge",
    key = "merge",
    pos = { x = 0, y = 18 },
    atlas = "blinds3",
    order = 1,
    debuff_text = "tower_debuff_merge",
    mult = 2,
    boss_colour = HEX("e44fc9"),
    boss = {
        level = 1
    },
    dollars = 4,

	pick = function ()
        if G.GAME.tower_merg_choice then return G.GAME.tower_merg_choice end
        local ret = {}
        ret[Tower.blindFromOffset(G.GAME.blind:TowerGetSlot() + 1)] = true
        ret[Tower.blindFromOffset(G.GAME.blind:TowerGetSlot() + 2)] = true
        G.GAME.tower_merg_choice = ret
        return ret
    end,
    cleanup = function ()
        G.GAME.tower_merg_choice = nil
    end,
    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
}))

Tower.Blind({
    tower_is_code = true,
    name = "tower-commit",
    tower_consumable = "cry_commit",
    key = "commit",
    pos = { x = 0, y = 19 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("23c2dc"),
    boss = {
        level = 1
    },
    dollars = 4,

	cry_before_play = function () -- i copied this from cryptid's commit.. what is going on here????
        local candidates = {}
        for i, v in ipairs(G.jokers.cards) do
            if not v.ability.eternal then
                candidates[#candidates+1] = v
            end
        end
        if #candidates == 0 then
            -- lmfao
            local fu = SMODS.add_card({
                set = "Joker"
            })
            SMODS.Stickers.tower_fuckyou:apply(fu, true)

            return
        end
        local joker = pseudorandom_element(candidates, pseudoseed('tower_commit'))
		local deleted_joker_key = joker.config.center.key
		local rarity = joker.config.center.rarity
		joker.getting_sliced = true
		local legendary = nil
		--please someone add a rarity api to steamodded
		if rarity == 1 then
			rarity = 0
		elseif rarity == 2 then
			rarity = 0.9
		elseif rarity == 3 then
			rarity = 0.99
		elseif rarity == 4 then
			rarity = nil
			legendary = true
		end -- Deleted check for "cry epic" it was giving rare jokers by setting rarity to 1
		joker:start_dissolve()
        local card = create_card("Joker", G.jokers, legendary, rarity, nil, nil, nil, "cry_commit")
        card:add_to_deck()
        G.jokers:emplace(card)
        card:juice_up(0.3, 0.5)

    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-machinecode",
    tower_consumable = "cry_machinecode",
    key = "machinecode",
    pos = { x = 0, y = 20 },
    atlas = "blinds3",
    order = 1,
    mult = G.tower_unknown,
    boss_colour = HEX("ffffff"),
    boss = {
        level = 1
    },
    dollars = G.tower_unknown,

	loc_vars = function(self, info_queue, center)
		return {
            main_start = {
                Cryptid.randomchar(codechars6),
                Cryptid.randomchar(codechars6),
                Cryptid.randomchar(codechars6),
                Cryptid.randomchar(codechars6),
                Cryptid.randomchar(codechars6),
                Cryptid.randomchar(codechars6)
            }
		}
	end,
	collection_loc_vars = function(self, info_queue, center)
		return {
            main_start = {
                Cryptid.randomchar(codechars6),
                Cryptid.randomchar(codechars6),
                Cryptid.randomchar(codechars6),
                Cryptid.randomchar(codechars6),
                Cryptid.randomchar(codechars6),
                Cryptid.randomchar(codechars6)
            }
		}
	end,
    TowerBeforeBlindSet = function (self, blind, reset, silent)
        G.GAME.tower_machinecode_old_ante = G.GAME.round_resets.ante
        local value = G.GAME.round_resets.ante;
        local min = -5;
        if (min + value) < 2 then
            min = 2 - value
        end
        local max = min + 10
        value = value + pseudorandom(pseudoseed("tower_machinecode_ante_glitch"), min, max) -- ante forced to be at least 2
        G.GAME.round_resets.ante = math.pow(value, pseudorandom(pseudoseed("tower_machinecode_ante_glitch")) + 0.5) -- random pow
        self:set_blind(Tower.getBlinds(function (blind)
            return blind.tower_is_code or blind.tower_is_planet or blind.tower_is_spectral or blind.tower_is_tarot
        end, 1, pseudoseed("tower_machinecode_blind"))[1], reset, silent)
        return false
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-spaghetti",
    tower_consumable = "cry_spaghetti",
    key = "spaghetti",
    pos = { x = 0, y = 21 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("e43222"),
    boss = {
        level = 1
    },
    dollars = 4,

    set_blind = function ()
        local pool = {}
        for i, v in ipairs(G.jokers.cards) do 
            if not v.ability.tower_food then pool[#pool+1] = v end
        end
        if #G.jokers.cards == 0 then
        else
            local center = pseudorandom_element(pool, pseudoseed('tower_speg'))
            center.ability.tower_food = true
        end
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-seed",
    tower_consumable = "cry_seed",
    key = "seed",
    pos = { x = 0, y = 22 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("2ad45e"),
    boss = {
        level = 1
    },
    dollars = 4,

    set_blind = function ()
        if G.GAME.blind.disabled then return end
        G.GAME.tower_seed_old_prob = G.GAME.probabilities.normal
        G.GAME.probabilities.normal = 0
    end,

    disable = function () 
        G.GAME.probabilities.normal = G.GAME.tower_seed_old_prob
    end,

    defeat = function () 
        G.GAME.probabilities.normal = G.GAME.tower_seed_old_prob
        G.GAME.tower_seed_old_prob = nil
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-patch",
    tower_consumable = "cry_patch",
    key = "patch",
    pos = { x = 0, y = 23 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("2ac5d4"),
    boss = {
        level = 1
    },
    dollars = 4,

	recalc_debuff = function(self, card, from_blind)
        if G.GAME.blind.disabled then return false end
        if card.ability.tower_seed_dbf == nil then
            if pseudorandom(pseudoseed("tower_seed")) > 0.5 then
                card.ability.tower_seed_dbf = 'debuff'
            else
                card.ability.tower_seed_dbf = 'flip'
            end
        end
		return card.ability.tower_seed_dbf == 'debuff'
	end,
    stay_flipped = function(self, area, card)
        if G.GAME.blind.disabled then return false end
        if card.ability.tower_seed_dbf == nil then
            if pseudorandom(pseudoseed("tower_seed")) > 0.5 then
                card.ability.tower_seed_dbf = 'debuff'
            else
                card.ability.tower_seed_dbf = 'flip'
            end
        end
        return card.ability.tower_seed_dbf == 'flip'
    end,
    set_blind = function(self, reset, silent)
        if reset then return end
        if G.GAME.blind.disabled then return end
		for i, card in pairs(G.consumeables.cards) do
            if card.ability.tower_seed_dbf == nil then
                if pseudorandom(pseudoseed("tower_seed")) > 0.5 then
                    card.ability.tower_seed_dbf = 'debuff'
                else
                    card.ability.tower_seed_dbf = 'flip'
                end
            end
            if card.ability.tower_seed_dbf == 'flip' then
                if card.facing == 'front' then card:flip() end
            else
                card:set_debuff(true)
            end
        end
    end,
    disable = function (self, reset, silent)
		for i, v in pairs(G.consumeables.cards) do
            v:set_debuff(false)
            if v.facing == 'back' then v:flip() end
        end
    end,
    defeat = function (self, reset, silent)
		for i, v in pairs(G.consumeables.cards) do
            v:set_debuff(false)
            if v.facing == 'back' then card:flip() end
            v.ability.tower_seed_dbf = nil
        end
		for i, v in pairs(G.jokers.cards) do
            v.ability.tower_seed_dbf = nil
        end
		for i, v in pairs(G.playing_cards) do
            v.ability.tower_seed_dbf = nil
        end
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})


Tower.Blind({
    tower_is_code = true,
    name = "tower-hook",
    tower_consumable = "cry_hook",
    key = "hook",
    pos = { x = 0, y = 24 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("c400c7"),
    boss = {
        level = 1
    },
    dollars = 4,

	cry_before_play = function(self)
        if G.GAME.blind.disabled then return end
        for i, v in ipairs(G.hand.highlighted) do
            v.ability.old_tower_notrigger = v.ability.tower_notrigger
            v.ability.tower_notrigger = true
        end
        if #G.hand.highlighted == 0 then
            return
        end
        for i, v in ipairs(G.hand.highlighted) do
            v.ability.tower_notrigger = true
        end
        if #G.hand.highlighted == 1 then -- fuck you
            SMODS.Stickers.tower_fuckyou:apply(G.hand.highlighted[1], true)
            return
        end
        local a = pseudorandom_element(G.hand.highlighted, pseudoseed('tower_hook'))

        a.ability.tower_notrigger = a.ability.old_tower_notrigger
	end,
    
    disable = function(self)
        for i, v in ipairs(G.playing_cards) do
            v.ability.tower_notrigger = v.ability.old_tower_notrigger
            v.ability.old_tower_notrigger = nil
        end
    end,

    defeat = function(self)
        if G.GAME.blind.disabled then return end
        for i, v in ipairs(G.playing_cards) do
            v.ability.tower_notrigger = v.ability.old_tower_notrigger
            v.ability.old_tower_notrigger = nil
        end
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-oboe",
    tower_consumable = "cry_oboe",
    key = "oboe",
    pos = { x = 0, y = 25 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("8a1df7"),
    boss = {
        level = 1
    },
    dollars = 4,

	cry_before_play = function (self)
        if G.GAME.blind.disabled then return end
        for k, v in ipairs(G.hand.cards) do
            SMODS.modify_rank(v, 1 - (pseudorandom(pseudoseed("tower_strength"), 0, 1) * 2))
        end
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-assemble",
    tower_consumable = "cry_assemble",
    key = "assemble",
    pos = { x = 0, y = 26 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("df2d80"),
    boss = {
        level = 1
    },
    dollars = 4,

	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        if G.GAME.blind.disabled then return mult, hand_chips, false end
        local trigger = false;
		if #G.jokers.cards > 0 then
            trigger = true
            mult = mult - #G.jokers.cards -- could be neg >:)
        end
		return mult, hand_chips, trigger
	end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-inst",
    tower_consumable = "cry_inst",
    key = "inst",
    pos = { x = 0, y = 27 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("df7c2d"),
    boss = {
        level = 1
    },
    dollars = 4,

	calculate = function (self, blind, args)
        if (not args.first_hand_drawn) and args.hand_drawn then
            for i, v in ipairs(args.hand_drawn) do
                v:set_debuff(true)
            end
        end
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-revert",
    tower_consumable = "cry_revert",
    key = "revert",
    pos = { x = 0, y = 28 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("d14225"),
    boss = {
        level = 1
    },
    dollars = 4,

    loc_vars = function ()
        return {
            vars = {
                3 * (G.GAME.probabilities.normal or 1),
                4
            }
        }
    end,
    collection_loc_vars = function ()
        return {
            vars = {
                3,
                4
            }
        }
    end,
	cry_before_play = function (self)
        if pseudorandom(pseudoseed("tower_seed")) < ((3 * (G.GAME.probabilities.normal or 1)) / 4) then
            G.E_MANAGER:add_event(
                Event({
                    trigger = "after",
                    delay = G.SETTINGS.GAMESPEED,
                    func = function()
                        G:delete_run()
                        G:start_run({
                            savetext = STR_UNPACK(G.GAME.cry_revert),
                        })
                    end,
                }),
                "other"
            )
        end
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

-- nevermind man..
--[[
local vsal = Tower.ObsidianOrb({
    tower_is_code = true,
    name = "tower-crfunction",
    tower_consumable = "cry_cryfunction",
    key = "crfunction", -- its called crfunction because naming it cryfunction breaks stuff????????
    pos = { x = 0, y = 29 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    debuff_text = "tower_debuff_cryfunction",
    boss_colour = HEX("3515df"),
    boss = {
        level = 1
    },
    dollars = 4,

    pick = function ()
        local tbl = {}
        local required = 3;
        if #(G.GAME.tower_past_blinds or {}) == 0 then return tbl end -- shouldn't even happen but..
        for i = #G.GAME.tower_past_blinds, 1, -1 do
            local key = G.GAME.tower_past_blinds[i]
            local bl = G.P_BLINDS[key];
            if bl and (bl.tower_is_code or bl.tower_is_spectral or bl.tower_is_tarot or bl.tower_is_planet) and key ~= "bl_tower_cryfunction" then
                tbl[key] = true
                required = required - 1;
                if required < 1 then
                    break
                end
            end
        end
        return tbl
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled and (#(G.GAME.tower_past_blinds or {}) ~= 0)
    end
})
Tower.Blind(vsal)]]

Tower.Blind({
    tower_is_code = true,
    name = "tower-run",
    tower_consumable = "cry_run",
    key = "run",
    pos = { x = 0, y = 30 },
    atlas = "blinds3",
    order = 1,
    mult = 2,
    boss_colour = HEX("9c21cf"),
    boss = {
        level = 1
    },
    dollars = 4,

	set_blind = function (self)
		G.cry_runarea = CardArea(
			G.discard.T.x,
			G.discard.T.y,
			G.discard.T.w,
			G.discard.T.h,
			{ type = "discard", card_limit = 1e100 }
		)
		local hand_count = #G.hand.cards
		for i = 1, hand_count do
			draw_card(G.hand, G.cry_runarea, i * 100 / hand_count, "down", nil, nil, 0.07)
		end
        G.GAME.tower_run_spend_all = true
		G.E_MANAGER:add_event(Event({
			trigger = "immediate",
			func = function()
				G.GAME.current_round.jokers_purchased = 0
				G.STATE = G.STATES.SHOP
				G.GAME.USING_CODE = true
				G.GAME.USING_RUN = true
				G.GAME.RUN_STATE_COMPLETE = 0
				G.GAME.shop_free = nil
				G.GAME.shop_d6ed = nil
				G.STATE_COMPLETE = false
				G.GAME.current_round.used_packs = {}
				return true
			end,
		}))

    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-class",
    tower_consumable = "cry_class",
    key = "class",
    pos = { x = 0, y = 0 },
    atlas = "blinds4",
    order = 1,
    mult = 2,
    boss_colour = HEX("c6e861"),
    boss = {
        level = 1
    },
    dollars = 4,

	cry_before_play = function (self)
		for i, v in ipairs(G.hand.highlighted) do
            v:set_ability(G.P_CENTERS.c_base, true, nil)
        end
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-global",
    tower_consumable = "cry_global",
    key = "global",
    pos = { x = 0, y = 1 },
    atlas = "blinds4",
    order = 1,
    mult = 2,
    boss_colour = HEX("038282"),
    boss = {
        level = 1
    },
    dollars = 4,

	set_blind = function (self)
		for i = 1, G.hand.config.card_limit do
            local card = SMODS.add_card({
                set = "Playing Card"
            })
            card:set_ability(G.P_CENTERS.m_tower_blank, true, nil)
            card.ability.cry_global_sticker = true
        end
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-variable",
    tower_consumable = "cry_variable",
    key = "variable",
    pos = { x = 0, y = 2 },
    atlas = "blinds4",
    order = 1,
    mult = 2,
    boss_colour = HEX("d65142"),
    boss = {
        level = 1
    },
    dollars = 4,

	cry_before_play = function (self)
        local options = {}
        for q, z in pairs(SMODS.Ranks) do
            options[#options+1] = q
        end
        for i, v in ipairs(G.hand.highlighted) do
            local option = pseudorandom_element(options, pseudoseed("tower_variable"))
            SMODS.change_base(v, nil, option)
        end
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-divide",
    tower_consumable = "cry_divide",
    key = "divide",
    pos = { x = 0, y = 3 },
    atlas = "blinds4",
    order = 1,
    mult = 2,
    boss_colour = HEX("d72b96"),
    boss = {
        level = 1
    },
    dollars = 4,

	set_blind = function (self)
        for i, v in ipairs(G.jokers.cards) do 
            Cryptid.with_deck_effects(v, function(cards)
                Cryptid.manipulate(cards, { value = 0.5 })
            end)
        end
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-multiply",
    tower_consumable = "cry_multiply",
    key = "multiply",
    pos = { x = 0, y = 4 },
    atlas = "blinds4",
    order = 1,
    mult = 2,
    boss_colour = HEX("6bcc36"),
    boss = {
        level = 1
    },
    dollars = 4,

	cry_after_play = function (self)
        G.GAME.blind.chips = G.GAME.blind.chips * to_big(2)
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-delete",
    tower_consumable = "cry_delete",
    key = "delete",
    pos = { x = 0, y = 5 },
    atlas = "blinds4",
    order = 1,
    mult = 2,
    boss_colour = HEX("acc44a"),
    boss = {
        level = 1
    },
    dollars = 4,

	set_blind = function (self)
        if #G.jokers.cards == 0 then return end
        local c = pseudorandom_element(G.jokers.cards, pseudorandom("tower_delete"));
		if not G.GAME.banned_keys then
			G.GAME.banned_keys = {}
		end
		if not G.GAME.cry_banned_pcards then
			G.GAME.cry_banned_pcards = {}
		end

    	G.GAME.cry_banished_keys[c.config.center.key] = true

        c:start_dissolve()
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-alttab",
    tower_consumable = "cry_alttab",
    key = "alttab",
    pos = { x = 0, y = 6 },
    atlas = "blinds4",
    order = 1,
    mult = 2,
    boss_colour = HEX("ff5ee1"),
    boss = {
        level = 1
    },
    dollars = 4,

    loc_vars = function ()
        return {
            vars = {
                G.GAME.probabilities.normal or 1,
                4
            }
        }
    end,
    collection_loc_vars = function ()
        return {
            vars = {
                1,
                4
            }
        }
    end,


	set_blind = function (self)
        if pseudorandom(pseudoseed("tower_seed")) > (((G.GAME.probabilities.normal or 1)) / 4) then
            return
        end
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.2,
			func = function()
				for j = 1, 1e10 do
					play_sound("tarot1")
					local tag = nil
					local type = G.GAME.blind:get_type()
					if next(SMODS.find_card("j_cry_kittyprinter")) then
						tag = Tag("tag_cry_cat")
					elseif type == "Boss" then
						tag = Tag(get_next_tag_key())
					else
						tag = Tag(G.GAME.round_resets.blind_tags[type])
					end
					add_tag(tag)
					G.GAME.blind:juice_up()
					delay(0.1)
				end
				return true
			end,
		}))
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled
    end
})


Tower.Blind({
    tower_is_code = true,
    name = "tower-ctrl_v",
    tower_consumable = "cry_ctrl_v",
    key = "ctrl_v",
    pos = { x = 0, y = 7 },
    atlas = "blinds4",
    order = 1,
    mult = 2,
    boss_colour = HEX("9e1219"),
    boss = {
        level = 1
    },
    dollars = 4,

	TowerBeforeBlindSet = function (self, blind, reset, silent)
        self:set_blind(G.P_BLINDS[G.GAME.tower_past_blinds[#G.GAME.tower_past_blinds]], reset, silent)
        return false
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled and (#(G.GAME.tower_past_blinds or {}) > 0)
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-reboot",
    tower_consumable = "cry_reboot",
    key = "reboot",
    pos = { x = 0, y = 8 },
    atlas = "blinds4",
    order = 1,
    mult = 2,
    boss_colour = HEX("630cf9"),
    boss = {
        level = 1
    },
    dollars = 4,

    loc_vars = function ()
        return {
            vars = {
                G.GAME.probabilities.normal,
                2
            }
        }
    end,
    collection_loc_vars = function ()
        return {
            vars = {
                1,
                2
            }
        }
    end,

	cry_after_play = function (self)
        if pseudorandom(pseudoseed("tower_seed")) > (((G.GAME.probabilities.normal or 1)) / 2) then
            return
        end

        G.FUNCS.draw_from_hand_to_discard()
		G.FUNCS.draw_from_discard_to_deck()
		ease_discard(
			math.max(0, G.GAME.round_resets.discards + G.GAME.round_bonus.discards) - G.GAME.current_round.discards_left
		)
		ease_hands_played(
			math.max(1, G.GAME.round_resets.hands + G.GAME.round_bonus.next_hands) - G.GAME.current_round.hands_left
		)
		for k, v in pairs(G.playing_cards) do
			v.ability.wheel_flipped = nil
		end
		G.E_MANAGER:add_event(Event({
			trigger = "immediate",
			func = function()
				G.STATE = G.STATES.DRAW_TO_HAND
				G.deck:shuffle("cry_reboot" .. G.GAME.round_resets.ante)
				G.deck:hard_set_T()
				G.STATE_COMPLETE = false
                G.GAME.chips = to_big(0)
                G.GAME.chips_text = number_format(G.GAME.chips)
				return true
			end,
		}))
    end,

    TowerInPool = function ()
        return G.GAME.modifiers.tower_code_enabled and (#(G.GAME.tower_past_blinds or {}) > 0)
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-declare",
    tower_consumable = "cry_declare",
    key = "declare",
    pos = { x = 0, y = 15 },
    atlas = "blinds5",
    order = 1,
    mult = 2,
    boss_colour = HEX("ff7930"),
    boss = {
        level = 1
    },
    dollars = 4,
    cry_after_play = function ()
        Tower.NillifyCard(G.play.cards)
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-log",
    tower_consumable = "cry_log",
    key = "log",
    pos = { x = 0, y = 16 },
    atlas = "blinds5",
    order = 1,
    mult = 2,
    boss_colour = HEX("f0ff61"),
    boss = {
        level = 1
    },
    dollars = 4,
    set_blind = function ()
        local log_again = {}
        for i = 1, 10 do
            log_again[#log_again+1] = G.deck.cards[#G.deck.cards + 1 - i]
        end
        local length = #G.deck.cards;
        G.deck.cards = {}
        for i = 1, length do
            G.deck.cards[#G.deck.cards+1] = copy_card(log_again[math.fmod(i - 1, #log_again) + 1]) -- devious
        end
    end
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-quantify",
    tower_consumable = "cry_quantify",
    key = "quantify",
    pos = { x = 0, y = 17 },
    atlas = "blinds5",
    order = 1,
    mult = 2,
    boss_colour = HEX("ff5364"),
    boss = {
        level = 1
    },
    dollars = 4,
    set_blind = function ()
        local j = {}
        for i, v in pairs(G.jokers.cards) do 
            j[#j+1] = v 
        end
        for i, v in ipairs(j) do
            Tower.CardifyJoker(v)
        end
    end,
})

Tower.Blind({
    tower_is_code = true,
    name = "tower-semicolon",
    tower_consumable = "cry_semicolon",
    key = "semicolon",
    pos = { x = 0, y = 9 },
    atlas = "blinds4",
    order = 1,
    mult = 2,
    boss_colour = HEX("d125b7"),
    boss = {
        level = 1
    },
    dollars = 4,
    set_blind = function () -- semicolon ended the implementation early
    	G.E_MANAGER:add_event(
			Event({
				trigger = "immediate",
				func = function()
					if G.STATE ~= G.STATES.SELECTING_HAND then
						return false
					end
					G.GAME.current_round.semicolon = true
					G.STATE = G.STATES.HAND_PLAYED
					G.STATE_COMPLETE = true
					end_round()
					return true
				end,
			}),
			"other"
		)
    end
})

