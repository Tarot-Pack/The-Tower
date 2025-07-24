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
            if G.GAME.tower_book >= 5 then
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
            if G.GAME.tower_book >= 9 then
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