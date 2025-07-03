function Tower.Achievement(props) 
    props.atlas = props.atlas or "tower_achievements"
    if props.pos == nil and props.rank ~= nil then
        props.pos = { x = props.rank - 1, y = 0 }
    end
    if props.hidden_pos == nil then
        props.hidden_pos = copy_table(props.pos)
        props.hidden_pos.y = props.hidden_pos.y + 1
    end
    if props.hidden_name == nil then
        props.hidden_name = true
    end
    if props.hidden_text == nil then
        props.hidden_text = false
    end
    if props.bypass_all_unlocked == nil then
        props.bypass_all_unlocked = true
    end
    if props.order == nil and props.rank ~= nil then
        props.order = props.rank * 100
        props.order = props.order + (props.rank_order or 0)
    end
    if props.unlock_condition == nil then
        local key = props.key
        props.unlock_condition = function(self, args)
            if args.type == "tower_" .. key then
                return true
            end
        end
    end
    props.object_type = "Achievement"
    return Tower.Object(props)
end
function Tower.achieve(thing)
    if type(thing) == "string" then
        thing = {
            type  = thing
        }
    end
    thing.type = "tower_" .. thing.type
    return check_for_unlock(thing)
end

function buildAchievementsTab(mod, current_page)
    current_page = current_page or 1
    fetch_achievements()
    local achievement_matrix = {{},{}}
    local achievements_per_row = 3
    local achievements_pool = {}
    for k, v in pairs(G.ACHIEVEMENTS) do
        if v.mod and v.mod.id == mod.id then achievements_pool[#achievements_pool+1] = v end
    end

    local achievement_tab = {}
    for k, v in pairs(achievements_pool) do
        achievement_tab[#achievement_tab+1] = v
    end
    
    table.sort(achievement_tab, function(a, b) return (a.order or 1) < (b.order or 1) end)
    
    local row = 1
    local max_lines = 2
    for i = 1, achievements_per_row*2 do
        local v = achievement_tab[i+((achievements_per_row*2)*(current_page-1))]
        if not v then break end
        local temp_achievement = Sprite(0,0,1.1,1.1,G.ASSET_ATLAS[v.atlas or "achievements"], v.earned and v.pos or v.hidden_pos) -- only change is actually using hidden_pos (i made a pull req for this)
        temp_achievement:define_draw_steps({
            {shader = 'dissolve', shadow_height = 0.05},
            {shader = 'dissolve'},
        })
        if i == 1 then 
            G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = (function()
                G.CONTROLLER:snap_to{node = temp_achievement}
                return true
            end)
            }))
        end
        temp_achievement.float = true
        temp_achievement.states.hover.can = true
        temp_achievement.states.drag.can = false
        temp_achievement.states.collide.can = true
        --temp_achievement.config = {blind = v, force_focus = true}
        temp_achievement.hover = function()
            if not G.CONTROLLER.dragging.target or G.CONTROLLER.using_touch then 
                if not temp_achievement.hovering and temp_achievement.states.visible then
                    temp_achievement.hovering = true
                    temp_achievement.hover_tilt = 3
                    temp_achievement:juice_up(0.05, 0.02)
                    play_sound('chips1', math.random()*0.1 + 0.55, 0.12)
                    Node.hover(temp_achievement)
                    if temp_achievement.children.alert then 
                        temp_achievement.children.alert:remove()
                        temp_achievement.children.alert = nil
                        v.alerted = true
                        G:save_progress()
                    end
                end
            end
            temp_achievement.stop_hover = function() temp_achievement.hovering = false; Node.stop_hover(temp_achievement); temp_achievement.hover_tilt = 0 end
        end

        -- Description
        local achievement_text = {}
        local maxCharsPerLine = 30
        local function wrapText(text, maxChars)
            local wrappedText = {""}
            local curr_line = 1
            local currentLineLength = 0
        
            for word in text:gmatch("%S+") do
                if currentLineLength + #word <= maxChars then
                    wrappedText[curr_line] = wrappedText[curr_line] .. word .. ' '
                    currentLineLength = currentLineLength + #word + 1
                else
                    wrappedText[curr_line] = string.sub(wrappedText[curr_line], 0, -2)
                    curr_line = curr_line + 1
                    wrappedText[curr_line] = ""
                    wrappedText[curr_line] = wrappedText[curr_line] .. word .. ' '
                    currentLineLength = #word + 1
                end
            end
        
            wrappedText[curr_line] = string.sub(wrappedText[curr_line], 0, -2)
            return wrappedText
        end
    
        local loc_target = (v.hidden_text and not v.earned) and {localize("hidden_achievement", 'achievement_descriptions')} or localize(v.key, 'achievement_descriptions')
        if type(loc_target) == 'string' then loc_target = wrapText(loc_target, maxCharsPerLine) end
        local loc_name = (v.hidden_name and not v.earned) and localize("hidden_achievement", 'achievement_names') or localize(v.key, 'achievement_names')

        local ability_text = {}
        if loc_target then 
            for k, v in ipairs(loc_target) do
                ability_text[#ability_text + 1] = {n=G.UIT.R, config={align = "cm"}, nodes={{n=G.UIT.T, config={text = v, scale = 0.35, shadow = true, colour = G.C.WHITE}}}}
            end
        end
        max_lines = math.max(max_lines, #ability_text)
        achievement_text[#achievement_text + 1] =
        {n=G.UIT.R, config={align = "cm", emboss = 0.05, r = 0.1, minw = 4, maxw = 4, padding = 0.05, colour = G.C.WHITE, minh = 0.4*max_lines+0.1}, nodes={
            ability_text[1] and {n=G.UIT.R, config={align = "cm", padding = 0.08, colour = G.C.GREY, r = 0.1, emboss = 0.05, minw = 3.9, maxw = 3.9, minh = 0.4*max_lines}, nodes=ability_text} or nil
        }}

        table.insert(achievement_matrix[row], {
            n = G.UIT.C,
            config = { align = "cm", padding = 0.1 },
            nodes = {
                {n=G.UIT.R, config = {align = "cm"}, nodes = {
                    {n=G.UIT.R, config = {align = "cm", padding = 0.1}, nodes = {{ n = G.UIT.O, config = { object = temp_achievement, focus_with_object = true }}}},
                    {
                        n=G.UIT.R, config = {align = "cm", minw = 4, maxw = 4, padding = 0.05}, nodes = {
                            {n=G.UIT.R, config={align = "cm", emboss = 0.05, r = 0.1, padding = 0.1, minh = 0.6, colour = G.C.GREY}, nodes={
                                {n=G.UIT.O, config={align = "cm", maxw = 3.8, object = DynaText({string = loc_name, maxw = 3.8, colours = {G.C.UI.TEXT_LIGHT}, shadow = true, spacing = 1, bump = true, scale = 0.4})}},
                            }},
                            {n=G.UIT.R, config={align = "cm"}, nodes=achievement_text},
                        },
                    },
                }},
            },
        })
        if #achievement_matrix[row] == achievements_per_row then 
            row = row + 1
            achievement_matrix[row] = {}
            max_lines = 2
        end
    end

    local achievements_options = {}
    for i = 1, math.ceil(#achievements_pool/(2*achievements_per_row)) do
        table.insert(achievements_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#achievements_pool/(2*achievements_per_row))))
    end

    local t = {
        {n=G.UIT.C, config={}, nodes={ 
        {n=G.UIT.C, config={align = "cm"}, nodes={
        {n=G.UIT.R, config={align = "cm"}, nodes={
            {n=G.UIT.R, config={align = "cm", padding = 0.1 }, nodes=achievement_matrix[1]},
            {n=G.UIT.R, config={align = "cm", padding = 0.1 }, nodes=achievement_matrix[2]},
            create_option_cycle({options = achievements_options, w = 4.5, cycle_shoulders = true, opt_callback = 'achievments_tab_page', focus_args = {snap_to = true, nav = 'wide'},current_option = current_page, colour = G.C.RED, no_pips = true})
        }}
        }}
    }}}
    return {
        n = G.UIT.ROOT,
        config = {
            emboss = 0.05,
            minh = 6,
            r = 0.1,
            minw = 6,
            align = "tm",
            padding = 0.2,
            colour = G.C.BLACK
        },
        nodes = t
    }
end
