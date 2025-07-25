
if Entropy == nil then
    Tower.EntComp = {}
    function Tower.EntComp.GetHighlightedCards(cardareas, ignorecard, blacklist)
        local cards = {}
        blacklist = blacklist or {}
        for i, area in pairs(cardareas) do
            if area.cards then
                for i2, card in ipairs(area.highlighted) do
                    if card ~= ignorecard and not blacklist[card.config.center.key] and card.highlighted and not card.checked then
                        cards[#cards + 1] = card
                        card.checked = true
                    end
                end
            end
        end
        for i, v in ipairs(cards) do v.checked = nil end
        return cards
    end

    function Tower.EntComp.FormatArrowMult(arrows, mult)
        mult = type(mult) ~= "string" and number_format(mult) or mult
        if to_big(arrows) <= to_big(-2.01) then
            return "{"..arrows.."}"..mult
        end
        if to_big(arrows) < to_big(-1.1) then 
            return "="..mult 
        elseif to_big(arrows) < to_big(-0.1) then 
            return "+"..mult 
        elseif to_big(arrows) < to_big(6) then 
            if to_big(arrows) < to_big(1) then
                return "X"..mult
            end
            local arr = ""
            for i = 1, to_big(arrows):to_number() do
                arr = arr.."^"
            end
            return arr..mult
        else
            return "{"..arrows.."}"..mult
        end
    end
    function Tower.EntComp.FlipThen(cardlist, func, before, after)
        if not Talisman.config_file.disable_anims then
            for i, v in ipairs(cardlist) do
                local card = cardlist[i]
                if card then
                    G.E_MANAGER:add_event(
                        Event(
                            {
                                trigger = "after",
                                delay = 0.1,
                                func = function()
                                    if before then
                                        before(card)
                                    end
                                    if card.flip then
                                        card:flip()
                                    end
                                    return true
                                end
                            }
                        )
                    )
                end
            end
        else
            if before then
                before(card)
            end
        end
        for i, v in ipairs(cardlist) do
            local card = cardlist[i]
            if card then
                G.E_MANAGER:add_event(
                    Event(
                        {
                            trigger = "after",
                            delay = 0.15,
                            func = function()
                                func(card, cardlist, i)
                                return true
                            end
                        }
                    )
                )
            end
        end
        if not Talisman.config_file.disable_anims then
            for i, v in ipairs(cardlist) do
                local card = cardlist[i]
                if card then
                    G.E_MANAGER:add_event(
                        Event(
                            {
                                trigger = "after",
                                delay = 0.1,
                                func = function()
                                    if card.flip then
                                        card:flip()
                                    end
                                    if after then
                                        after(card)
                                    end
                                    return true
                                end
                            }
                        )
                    )
                end
            end
        else    
            if after then
                after(card)
            end
        end
    end
else
    Tower.EntComp = Entropy
end