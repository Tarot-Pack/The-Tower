local unapply_to_run = Card.unapply_to_run

function Card:unapply_to_run(center, raw) -- this has to go after so it goes in Cryptid.lua
    if not raw and (self.edition and self.edition.tower_truenegative) then
        return self:apply_to_run(center, true)
    end
    return unapply_to_run(self, center)
end

return {items = {}}