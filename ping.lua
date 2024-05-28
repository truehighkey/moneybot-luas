local Draggable = require("Draggables")

local pingindicator = Draggable(35, 420, 150, 25)
local lp = entity_list.get_local_player()
local font = render.create_font("Tahoma Bold", 15, 590, 0x200)


local function paintping(x, y, w, h)
    local ping1 = server.get_ping()
    local lp_index = lp:get_index()
    local ping2 = pr.get_ping(lp_index)
    local extendping = ui.get('Misc', 'Main', 'Other', 'Extend Ping')
    local extend_key   = ui.get('Misc', 'Main', 'Other', 'Extend Ping Key')
    local extendamount = ui.get('Misc', 'Main', 'Other', 'Extend Amount')
    local extend_value = extendamount:get()
    local extend = extendping:get()
    
    
    if user.is_game_ui_visible() then return end

    if extendping:get() and extend_key:resolve() then
        render.text({x, y}, color(255, 255, 255, 255),font, "Real Ping: " .. tostring(ping1).." (+ " ..math.floor(extend_value+0.5).. ") ms")
    else
        render.text({x, y}, color(255, 255, 255, 255),font, "Real Ping: " .. tostring(ping1).." ms")
    end

    render.text({x, y+15}, color(255, 255, 255, 255),font, "Scoreboard: " .. tostring(ping2).. "ms")
end
console.print(tostring(extend))


pingindicator:set_draw_function(paintping)