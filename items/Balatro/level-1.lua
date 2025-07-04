Tower.Blind({
	name = "tower-blueprint",
	key = "blueprint",
	pos = { x = 0, y = 5 },
	atlas = "blinds",
	order = -1,
    mult = G.tower_unknown,
    boss_colour = HEX("3e60d4"),
    boss = {
        level = -1 --anywhere
    },
    dollars = G.tower_unknown,
    TowerBeforeBlindSet = function(self, blind, reset, silent)
        G.GAME.round_resets.ante = G.GAME.round_resets.ante + 1 -- ante up!!!
        local slot = self:TowerGetSlot();
        local boss = get_new_boss(slot)
        self:set_blind(G.P_BLINDS[boss]) -- blueprint chaining is possible (and possibly laggy if you get absurdly (un)lucky)
        Tower.PerscribeBoss(G.GAME.round_resets.ante, slot, boss)
        G.GAME.round_resets.ante = G.GAME.round_resets.ante - 1 -- ante down!!
        return false
    end
})