if not Tower then
	Tower = {}
end
Tower.FeatureWL = {}
Tower.Meta = SMODS.current_mod;
Tower.DescriptionCard = SMODS.Center:extend({
	set = "Description Cards",
	pos = { x = 0, y = 0 },
	config = {},
	class_prefix = "desc",
	required_params = {
		"key",
	},
	no_doe = true,
	inject = function(self)
		if not G.P_CENTER_POOLS[self.set] then
			G.P_CENTER_POOLS[self.set] = {}
		end
		SMODS.Center.inject(self)
	end,
	set_card_type_badge = function ()
	end
})
G.P_CENTER_POOLS["Description Cards"] = {}

local mod_path = "" .. SMODS.current_mod.path
Tower.path = mod_path
Tower.Config = SMODS.current_mod.config or {}


SMODS.current_mod.optional_features = {
	retrigger_joker = true,
	post_trigger = true,
	cardareas = {
		unscored = true,
	}
}

Cryptid.mod_whitelist["Tower"] = true
if not Cryptid.mod_gameset_whitelist then Cryptid.mod_gameset_whitelist = {} end
Cryptid.mod_gameset_whitelist["tower"] = true
Cryptid.mod_gameset_whitelist["Tower"] = true

local towerConfigTab = function()
	tower_nodes = {}
	tower_nodes[#tower_nodes + 1] = {
		n = G.UIT.R,
		config = { align = "cm" },
		nodes = {
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = localize("cry_set_enable_features"),
						colours = { G.C.WHITE },
						shadow = true,
						scale = 0.4,
					}),
				},
			},
		},
	}
	tower_nodes[#tower_nodes + 1] = UIBox_button({
		colour = G.C.CRY_GREENGRADIENT,
		button = "your_collection_content_sets",
		label = { localize("b_content_sets") },
		count = modsCollectionTally(G.P_CENTER_POOLS["Content Set"]),
		minw = 5,
		minh = 1.7,
		scale = 0.6,
		id = "your_collection_jokers",
	})
	left_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
	right_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
	config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { left_settings, right_settings } }
	tower_nodes[#tower_nodes + 1] = config
	tower_nodes[#tower_nodes + 1] = create_toggle({
		label = localize("tower_main_menu"),
		active_colour = HEX("b31b41"),
		ref_table = Tower.Config,
		ref_value = "menu",
	})
	tower_nodes[#tower_nodes + 1] = create_toggle({
		label = localize("tower_skip_book"),
		active_colour = HEX("b31b41"),
		ref_table = Tower.Config,
		ref_value = "disable_book",
	})
	tower_nodes[#tower_nodes + 1] = create_toggle({
		label = localize("tower_show_banned"),
		active_colour = HEX("b31b41"),
		ref_table = Tower.Config,
		ref_value = "show_banned",
	})
	return {
		n = G.UIT.ROOT,
		config = {
			emboss = 0.05,
			minh = 6,
			r = 0.1,
			minw = 10,
			align = "cm",
			padding = 0.2,
			colour = G.C.BLACK,
		},
		nodes = tower_nodes,
	}
end

SMODS.current_mod.config_tab = towerConfigTab





Tower.object_queue = {}
Tower._is_lib = true
Tower.AfterAllLoadedCallbacks = {}
Tower.AfterAllLoaded = function (obj)
	Tower.AfterAllLoadedCallbacks[#Tower.AfterAllLoadedCallbacks+1] = obj
end
local inj = SMODS.injectItems;
function SMODS.injectItems(...)
	inj(...)
	for i, v in ipairs(Tower.AfterAllLoadedCallbacks) do
		v(...)
	end
end


local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	smcmb(obj, badges)
	if not SMODS.config.no_mod_badges and obj and obj.tower_credits then
		local function calc_scale_fac(text)
			local size = 0.9
			local font = G.LANG.font
			local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
			local calced_text_width = 0
			-- Math reproduced from DynaText:update_text
			for _, c in utf8.chars(text) do
				local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
					+ 2.7 * 1 * G.TILESCALE * font.FONTSCALE
				calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
			end
			local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
			return scale_fac
		end
		if obj.tower_credits.art or obj.tower_credits.code or obj.tower_credits.idea or obj.tower_credits.custom then
			local scale_fac = {}
			local min_scale_fac = 1
			local strings = { "The Tower" }
			for _, v in ipairs({ "idea", "art", "code" }) do
				if obj.tower_credits[v] then
					for i = 1, #obj.tower_credits[v] do
						strings[#strings + 1] =
							localize({ type = "variable", key = "cry_" .. v, vars = { obj.tower_credits[v][i] } })[1]
					end
				end
			end
            if obj.tower_credits.custom then
                strings[#strings + 1] = localize({ type="variable", key = obj.tower_credits.custom.key, vars = { obj.tower_credits.custom.text } })
            end
			for i = 1, #strings do
				scale_fac[i] = calc_scale_fac(strings[i])
				min_scale_fac = math.min(min_scale_fac, scale_fac[i])
			end
			local ct = {}
			for i = 1, #strings do
				ct[i] = {
					string = strings[i],
				}
			end
			local cry_badge = {
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							colour = Tower.Meta.badge_colour,
							r = 0.1,
							minw = 2 / min_scale_fac,
							minh = 0.36,
							emboss = 0.05,
							padding = 0.03 * 0.9,
						},
						nodes = {
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = ct or "ERROR",
										colours = { obj.tower_credits and obj.tower_credits.text_colour or G.C.WHITE },
										silent = true,
										float = true,
										shadow = true,
										offset_y = -0.03,
										spacing = 1,
										scale = 0.33 * 0.9,
									}),
								},
							},
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
						},
					},
				},
			}
			local function eq_col(x, y)
				for i = 1, 4 do
					if x[i] ~= y[i] then
						return false
					end
				end
				return true
			end
			for i = 1, #badges do
				if eq_col(badges[i].nodes[1].config.colour, Tower.Meta.badge_colour) then
					badges[i].nodes[1].nodes[2].config.object:remove()
					badges[i] = cry_badge
					break
				end
			end
		end
	end
end

function Tower.Object(bl)
    if not bl.dependencies then
        bl.dependencies = {}
    end
    if not bl.dependencies.items then
        bl.dependencies.items = {}
    end
	if bl.tower_blind then
		bl.dependencies.items[#bl.dependencies.items+1] = ("bl_" .. bl.tower_blind)
	end
	if bl.object_type == "Blind" then
        bl.dependencies.items[#bl.dependencies.items+1] = "set_tower_blinds"
	end
	if bl.tower_consumable then
		local index = string.find(bl.tower_consumable, '_')
		local prefix = string.sub(bl.tower_consumable,1,index-1)
		local modTable = {
			tower = "Tower",
			cry = 'Cryptid',
			entr = 'entr'
		}
		print(prefix)
		if modTable[prefix] and (not ((SMODS.Mods[modTable[prefix]] or {}).can_load)) then
			return
		end
	end
	bl.pools = bl.pools or {}
    if bl.pools['Tower-Slime'] then
        bl.dependencies.items[#bl.dependencies.items+1] = "set_tower_slime"
	end
    if bl.pools['Tower-Terra'] then
        bl.dependencies.items[#bl.dependencies.items+1] = "set_tower_terraria"
	end
    if bl.pools['Print'] then
        bl.dependencies.items[#bl.dependencies.items+1] = "set_tower_prints"
	end
    if bl.rarity == "tower_apollyon" then
        bl.dependencies.items[#bl.dependencies.items+1] = "set_tower_apollyon"
	end
    if bl.rarity == "tower_transmuted" or bl.set == "tower_transmuted" then
		bl.soul_set = 'Spectral'
		bl.soul_rate = 0 -- don't ask.
		bl.hidden = true;
        bl.dependencies.items[#bl.dependencies.items+1] = "set_tower_transmuted"
	end
    if bl.tower_credits and bl.tower_credits.idea and (Entropy or bl.object_type == "Joker" or bl.object_type == "Consumable") then
		for i, author in pairs(bl.tower_credits.idea) do
			bl.pools["Tower-" .. author] = true
		end
	end
	if (#bl.dependencies.items > 0) and (bl.object_type == 'Joker' or bl.object_type == 'Consumeable') then
		local is_good = true;
		for k, c in pairs(SMODS.ContentSet.obj_table) do
			if c.set == "Content Set" then
				for i, v in ipairs(bl.dependencies.items) do
					if v == c.key then
						is_good = false;
						break
					end
				end
			end
		end
		if is_good then
			bl.dependencies.items[#bl.dependencies.items+1] = "set_tower_misc"
		end
	elseif bl.object_type == 'Joker' or bl.object_type == 'Consumeable' then
		bl.dependencies.items[#bl.dependencies.items+1] = "set_tower_misc"
	end

	if Tower._is_lib then
		local val = SMODS[bl.object_type](bl)
		if bl.init then
			bl.init(val)
		end
		return bl
	else
		if bl.order == nil then
			bl.order = -999
		end
		if Tower.object_queue[bl.order] == nil then
			Tower.object_queue[bl.order] = {}
		end
		Tower.object_queue[bl.order][#(Tower.object_queue[bl.order])+1] = bl
	end
end
for i, v in pairs({ --[["Achievement",]] "Atlas", "Blind", "Center", "Back", "Booster", "Consumable", "Edition", "Enhancement", "Joker", "Voucher", "Challenge", "DeckSkin", "DrawStep", "Gradient", "Keybind", "Language", "ObjectType", "PokerHand", "Rank", "Suit", "Rarity", "Seal", "Sound", "Stake", "Sticker", "Tag", "Shader" }) do
	Tower[v] = function (bl)
		bl.object_type = v
		return Tower.Object(bl)
	end
end

-- load stuff
local files = NFS.getDirectoryItems(mod_path .. "lib")
for _, file in ipairs(files) do
	print("[Tower] Loading library " .. file)
	local f, err = SMODS.load_file("lib/" .. file)
	if err then
		error(err)
	end
	f()
end
Tower._is_lib = nil
local Load = {}

local current = nil


-- load stuff
local dirs = NFS.getDirectoryItems(mod_path .. "items")
for _, dir in ipairs(dirs) do
	print("[Tower] Loading compat " .. dir)
	if not (dir == 'Balatro' or dir == "Cryptid" or dir == "The Tower") then
		current = dir
	else
		current = nil
	end
	local files = NFS.getDirectoryItems(mod_path .. "items/" .. dir)
	for _, file in ipairs(files) do
		print("[Tower] Loading file [ " .. dir .. " " .. file .. " ]")
		local f, err = SMODS.load_file("items/" .. dir .. "/" .. file)
		if err then
			error(err)
		end
		f()
	end
end
local things = {}
for i, v in pairs(Tower.object_queue) do
	things[#things+1] = {to_number(i), v}
end
table.sort(things, function (a, b)
	return a[1] < b[1]
end)
for i, v in pairs(things) do
	for z, q in ipairs(v[2]) do
		local val = SMODS[q.object_type](q)
		if q.init then
			q.init(val)
		end
	end
end
current = nil
Tower._is_lib = true

local oldfunc = Game.main_menu
Game.main_menu = function(change_context)
	local ret = oldfunc(change_context)
	if not Tower.Config.menu then return ret end
	-- adds a Tower Tarot to the main menu
	local newcard = Card(
		G.title_top.T.x,
		G.title_top.T.y,
		G.CARD_W,
		G.CARD_H,
		G.P_CARDS.empty,
		G.P_CENTERS.c_tower,
		{ bypass_discovery_center = true }
	)
	-- recenter the title
	G.title_top.T.w = G.title_top.T.w * 1.7675
	G.title_top.T.x = G.title_top.T.x - 0.8
	G.title_top:emplace(newcard)
	-- make the card look the same way as the title screen Ace of Spades
	newcard.T.w = newcard.T.w * 1.1 * 1.2
	newcard.T.h = newcard.T.h * 1.1 * 1.2
	newcard.no_ui = true
	newcard.states.visible = false

	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0,
		blockable = false,
		blocking = false,
		func = function()
			if change_context == "splash" then
				newcard.states.visible = true
				newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, true, 2.5)
			else
				newcard.states.visible = true
				newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, nil, 1.2)
			end
			return true
		end,
	}))

	return ret
end

Tower.AfterAllLoaded(function ()
	if Cryptid and Cryptid.pointerblistifytype then
		Cryptid.pointerblistifytype("rarity", "tower_apollyon")
		Cryptid.pointerblistifytype("rarity", "tower_transmuted")
		Cryptid.pointerblistifytype("set", "tower_transmuted")

		Cryptid.pointerblistify("c_tower_aether_monolith")
	end

	-- horrible
	local tempCard = {
		ability = {
			extra = {},
			immutable = {}
		}
	}
	local fake = false;
	if not G.GAME then
		G.GAME = {
			modifiers = {
				
			}
		}
		fake = true
	end
	local old = SMODS.get_probability_vars
	local flagged = {
		j_space = true,
		j_8_ball = true,
		j_gros_michel = true,
		j_business = true,
		j_bloodstone = true,
		j_cavendish = true,
		j_reserved_parking = true,
		j_hallucination = true,
		j_oops = true,
		j_tower_forgotten_die = true,
		j_ortalab_woo_all_1 = true
	}
	for i, v in ipairs(G.P_CENTER_POOLS["Joker"]) do
		if (v.pools and v.pools['Dice'])
		or (flagged[v.key]) then
			Tower.ProbabilityJoker:inject_card(v)
		elseif v.loc_vars then
			local flag = false;
			SMODS.get_probability_vars = function (...)
				if not flag then
					Tower.ProbabilityJoker:inject_card(v)
					flag = true
				end
				return 1, 1
			end
			pcall(v.loc_vars, v, {}, tempCard) -- bad bad bad
		end
	end
	SMODS.get_probability_vars = old
	if fake then
		G.GAME = nil
	end
end)