Tower.Achievement({
	key = "imaginary",
    rank = 2
})
Tower.Achievement({
	key = "antivirus",
    rank = 3
})

Tower.Achievement({
	key = "darker_than_dark",
	rank = 3,
    unlock_condition = function (self, args)
        if args.type == "tower_modify_card" and args.card and args.card.edition and args.card.edition.tower_truenegative and args.card.config.center.key == "m_cry_light" then
            return true
        end
    end
})