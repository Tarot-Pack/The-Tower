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
-- load stuff
local files = NFS.getDirectoryItems(mod_path .. "items")
for _, file in ipairs(files) do
	print("[Tower] Loading item " .. file)
	local f, err = SMODS.load_file("items/" .. file)
	if err then
		error(err)
	end
	f()
end