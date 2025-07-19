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

local old_never_scores = SMODS.never_scores
function SMODS.never_scores(c) 
    if c.ability.set == "Joker" then return true end
    return old_never_scores(c)
end

function Tower.MergeCards(card, other)
    if not (card.edition and card.edition.cry_double_sided) then
        card:set_edition({ cry_double_sided = true })
    end
	card.merged = true
	card.ability.immutable.other_side = copy_table(other.ability)
	card.ability.immutable.other_side.key = copy_table(other.config.center.key)
	card.ability.immutable.other_side.seal = copy_table(other.seal)
	if other.base.nominal ~= 0 then
		card.ability.immutable.other_side.base = copy_table(other.base)
	end
	other:start_dissolve()
	if next(find_joker("cry-Flip Side")) then
		card:remove_from_deck(true)
		Card.add_to_deck(card:get_other_side_dummy(), true)
	end
end

function Tower.CardifyJoker(j)
    G.jokers:remove_card(j)
    G.deck:emplace(j)
    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
    j.playing_card = G.playing_card
    j.ability.tower_return_to_jokers = true
    table.insert(G.playing_cards, j)
end

function Tower.UncardifyJoker(j)
    G.deck:remove_card(j)
    G.jokers:emplace(j)
    j.playing_card = nil
    j.ability.tower_return_to_jokers = false
    for i, v in ipairs(G.playing_cards) do
        if v == j then
            table.remove(G.playing_cards, i)
            break
        end
    end
end

local ev_intro = evaluate_play_intro

function evaluate_play_intro()
    local new = {}
    old_hl = G.play.highlighted;
    local new_hl = {}
    for i, v in ipairs(G.play.cards) do
        if v.ability.tower_return_to_jokers then
            Tower.UncardifyJoker(v)
        else
            new[#new+1] = v
        end
    end
    for i, v in ipairs(G.play.highlighted) do
        if v.ability.tower_return_to_jokers then
            
        else
            new_hl[#new_hl+1] = v
        end
    end
    G.play.cards = new
    G.play.highlighted = new_hl
    return ev_intro()
end


local deck_preview = G.UIDEF.deck_preview
G.UIDEF.deck_preview = function (a) 
    local val = deck_preview(a)
    for i, v in ipairs(G.playing_cards) do
        if v.ability.tower_is_temp then
            v.base.value = nil
            v.base.suit = nil 
	        v.ability.tower_is_temp = false
        end
    end
    return val
end

local view_deck = G.UIDEF.view_deck
G.UIDEF.view_deck = function (a) 
    local val = view_deck(a)
    for i, v in ipairs(G.playing_cards) do
        if v.ability.tower_is_temp then
            v.base.value = nil
            v.base.suit = nil 
	        v.ability.tower_is_temp = false
        end
    end
    return val
end

local your_suits_page = G.FUNCS.your_suits_page
G.FUNCS.your_suits_page = function (a) 
    local val = your_suits_page(a)
    for i, v in ipairs(G.playing_cards) do
        if v.ability.tower_is_temp then
            v.base.value = nil
            v.base.suit = nil 
	        v.ability.tower_is_temp = false
        end
    end
    return val
end

Tower.AfterAllLoaded(function()
    -- added scaling
    local old_smds = SMODS.get_blind_amount;
    local old_blind_amt = get_blind_amount;

    get_blind_amount = function (...)
        if G.tower_ignore_scaling or G.GAME.modifiers.tower_ante_scaling == nil then
            return old_blind_amt(...)
        end
        G.tower_ignore_scaling = true
        local val = old_blind_amt(...)
        G.tower_ignore_scaling = false
        val = val * G.GAME.modifiers.tower_ante_scaling
        return val
    end
    SMODS.get_blind_amount = function (...)
        if G.tower_ignore_scaling or G.GAME.modifiers.tower_ante_scaling == nil then
            return old_smds(...)
        end
        G.tower_ignore_scaling = true
        local val = old_smds(...)
        G.tower_ignore_scaling = false
        val = val * G.GAME.modifiers.tower_ante_scaling
        return val
    end
end)