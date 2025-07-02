function Tower.create_playing_card(t)
    local card = SMODS.add_card(t);
    card:set_base(G.P_CARDS[t.front]);
    return card
end
function Tower.create_playing_cards(list, properties)
    for i, v in ipairs(list) do
        local tbl = copy_table(properties);
        tbl.front = v;
        Tower.create_playing_card(tbl)
    end
end
local old_smods_calc = SMODS.calculate_context;
local on_calcs = {}
function Tower.onCalculate(f) 
    on_calcs[#on_calcs+1] = f
    return f
end
function SMODS.calculate_context(context, return_table)
    local ret = old_smods_calc(context, return_table)
    for i, v in ipairs(on_calcs) do
        v(context, return_table or ret)
    end
    if not return_table then
        return ret
    end
end