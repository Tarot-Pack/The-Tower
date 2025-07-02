Tower.Achievement({
	key = "true_positive",
    rank = 2
})

Tower.Achievement({
	key = "rock_and_rock",
    rank = 2,
    unlock_condition = function (self, args)
        if args.type == 'discard_custom' then
            if #args.cards == #G.playing_cards then
                return true
            end
        end
    end
})

Tower.Achievement({
	key = "sus_victory",
    rank = 1,
    rank_order = 9,
})

Tower.Achievement({
	key = "victory",
    rank = 2,
    unlock_condition = function (self, args)
        if args.type == 'win' then
            local highest_win, lowest_win = get_deck_win_stake(nil)
            if highest_win >= 5 then
                return true
            end
        end
    end,
    rank_order = 10,
})

Tower.Achievement({
	key = "flush_zero",
    rank = 2,
    unlock_condition = function (self, args)
        if args.type == 'hand' and args.handname == 'Flush Five' and args.scoring_hand then
            local zeros = 0;
            for k, v in ipairs(args.scoring_hand) do
                if v.base.value == 'tower_0' then
                    zeros = zeros + 1
                end
            end
            if zeros == #args.scoring_hand then
                return true
            end
        end
    end,
})

Tower.Achievement({
	key = "will_of_iron",
    rank = 3,
    unlock_condition = function (self, args)
        if args.type == 'win' then
            local highest_win, lowest_win = get_deck_win_stake(nil)
            if highest_win >= 9 then
                return true
            end
        end
    end,
    rank_order = 10,
})

Tower.Achievement({
	key = "clusterfuck_you",
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