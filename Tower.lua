if not Tower then
	Tower = {}
end

SMODS.DescriptionCard = SMODS.Center:extend({
	set = "Description Cards",
	pos = { x = 0, y = 0 },
	config = {},
	class_prefix = "desc",
	required_params = {
		"key",
	},
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
	tower_nodes = {
		{
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
		label = localize("tower_skip_book"),
		active_colour = HEX("b31b41"),
		ref_table = Tower.Config,
		ref_value = "disable_book",
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
							colour = HEX("a58547"),
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
				if eq_col(badges[i].nodes[1].config.colour, HEX("a58547")) then
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

	if bl.tower_consumable then
		bl.dependencies.items[#bl.dependencies.items+1] = ("c_" .. bl.tower_consumable)
	end
	if bl.tower_blind then
		bl.dependencies.items[#bl.dependencies.items+1] = ("bl_" .. bl.tower_blind)
	end

	if bl.object_type == "Blind" then
        bl.dependencies.items[#bl.dependencies.items+1] = "set_tower_blinds"
	end
	bl.pools = bl.pools or {}
    if bl.pools['Tower-Slime'] then
        bl.dependencies.items[#bl.dependencies.items+1] = "set_tower_slime"
	end
    if bl.pools['Tower-Terra'] then
        bl.dependencies.items[#bl.dependencies.items+1] = "set_tower_terraria"
	end
    if bl.rarity == "tower_apollyon" then
        bl.dependencies.items[#bl.dependencies.items+1] = "set_tower_apollyon"
	end
    if bl.rarity == "tower_transmuted" or bl.set == "tower_transmuted" then
        bl.dependencies.items[#bl.dependencies.items+1] = "set_tower_transmuted"
	end

	if Tower._is_lib then
		return SMODS[bl.object_type](bl)
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
for i, v in pairs({ --[["Achievement",]] "Atlas", "Blind", "Center", "Back", "Booster", "Consumable", "Edition", "Enhancement", "Joker", "Voucher", "Challenge", "DeckSkin", "DrawStep", "Gradient", "Keybind", "Language", "ObjectType", "PokerHand", "Rank", "Suit", "Rarity", "Seal", "Sound", "Stake", "Sticker", "Tag", "Shader", "DescriptionCard" }) do
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
		SMODS[q.object_type](q)
	end
end
current = nil
Tower._is_lib = true