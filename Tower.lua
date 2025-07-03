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

function Tower.Object(bl)
	bl.tower_center_requires = bl.tower_center_requires or {}
	bl.dependencies = bl.dependencies or {}
	if bl.tower_consumable then
		bl.tower_center_requires[#bl.tower_center_requires+1] = ("c_" .. bl.tower_consumable)
	end
	if bl.tower_blind then
		bl.tower_center_requires[#bl.tower_center_requires+1] = ("bl_" .. bl.tower_consumable)
	end
	if current ~= nil then
		bl.dependencies[#bl.dependencies+1] = current
	end
	return SMODS[bl.object_type](bl)
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

local Load = {}

local current = nil


-- load stuff
local dirs = NFS.getDirectoryItems(mod_path .. "items")
for _, dir in ipairs(dirs) do
	print("[Tower] Loading compat " .. dir)
	if not (dir == 'Balatro' or dir == "Cryptid") then
		current = dir
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
current = nil