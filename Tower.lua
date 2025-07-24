if not Tower then
	Tower = {}
end
local mod_path = "" .. SMODS.current_mod.path
Tower.path = mod_path

SMODS.current_mod.optional_features = {
	retrigger_joker = true,
	post_trigger = true,
	cardareas = {
		unscored = true,
	}
}

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
function Tower.Object(bl)
	bl.tower_center_requires = bl.tower_center_requires or {}
	bl.tower_blind_requires = bl.tower_blind_requires or {}
	bl.dependencies = bl.dependencies or {}
	if bl.tower_consumable then
		bl.tower_center_requires[#bl.tower_center_requires+1] = ("c_" .. bl.tower_consumable)
	end
	if bl.tower_blind then
		bl.tower_blind_requires[#bl.tower_blind_requires+1] = bl.tower_blind
	end
	if current ~= nil then
		bl.dependencies[#bl.dependencies+1] = current
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
		SMODS[q.object_type](q)
	end
end
current = nil
Tower._is_lib = true