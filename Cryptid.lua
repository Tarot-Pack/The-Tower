local unapply_to_run = Card.unapply_to_run

function Card:unapply_to_run(center, raw) -- this has to go after so it goes in Cryptid.lua
    if not raw and (self.edition and self.edition.tower_truenegative) then
        return self:apply_to_run(center, true)
    end
    return unapply_to_run(self, center)
end

local old_update_obj_registry = Cryptid.update_obj_registry
function Cryptid.update_obj_registry(m, force_enable)
    local val = old_update_obj_registry(m, force_enable)
    for i, v in ipairs(G.P_CENTERS) do
        if v.tower_orig_rarity then
            if Cryptid.enabled("set_cry_exotic") then
                v.rarity = v.tower_orig_rarity
            else
                v.rarity = "tower_apollyon"
            end
        end
    end
    return val
end

return {items = {}}