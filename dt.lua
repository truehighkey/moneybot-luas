local Draggable = require("Draggables")
local xx, yy = render.get_screen_size()
local charge = Draggable(xx/2-77, yy/2+110, 150, 75)
local menuaccent = ui.get('Misc', 'Main', 'Other', 'Menu Accent Color')
local critfont = render.create_font("Tahoma Bold", 15, 590, 0x200)
local chargeprog = 0

local function round_rectangle(pos, w, h, corner_size, corner_percentage, outline, color)
    local c_table = {}

    for k = 0, 3 do
        for i = 1, corner_percentage - 1 do
            local cm = math.rad(i + ((45+90*k) - (corner_percentage/2)))
            local cx = math.cos(cm) * corner_size
            local cy = math.sin(cm) * corner_size

            if k == 3 then
                table.insert( c_table, vertex(pos[1] + w + cx, pos[2] + corner_size + cy) )
            elseif k == 2 then
                table.insert( c_table, vertex(pos[1] + corner_size + cx, pos[2] + corner_size + cy) )
            elseif k == 1 then
                table.insert( c_table, vertex(pos[1] + corner_size + cx, pos[2] + h + cy) )
            elseif k == 0 then
                table.insert( c_table, vertex(pos[1] + w + cx, pos[2] + h + cy) )
            end
        end
    end

    if outline and #c_table > 0 then
        render.polyline(c_table, color)
    elseif #c_table > 0 then
        render.polygon(c_table, color)
    end
end

local function chargecount(x, y, width, height)
    local chargetext = "Ticks " ..tostring(exploits.get_shift()).. "/" .. tostring(exploits.get_max_shift())

     if exploits.is_charging() or exploits.is_charged() then
         chargeprog = math.min(chargeprog + 0.012, 1)
     elseif exploits.did_warp() or exploits.did_shift() or not exploits.is_charged() then
         chargeprog = math.max(chargeprog - 0.035, 0)
     end

     if engine.in_game() and engine.is_connected() and client.is_alive() and not user.is_game_ui_visible() then    
         local chargewidth = math.floor(chargeprog * 104)

         if exploits.is_ready() then
            render.text({x  +35, y + 20}, color(255, 255, 255), critfont, 2, chargetext)
        elseif exploits.is_charged() then
             render.text({x +35, y + 20}, color(255, 255, 255), critfont, 2, chargetext)
         elseif exploits.is_charging() then
             render.text({x +35, y + 20}, color(255, 255, 255), critfont, 2, chargetext)
         else
             render.text({x +40, y + 20}, color(255, 255, 255), critfont, 2, chargetext)
             render.text({x +40, y + 60}, color(255, 255, 255), critfont, 2, "Not Ready")
         end
         round_rectangle({x+20, y+34}, width-47, height-69, 7, 30, true, color(15, 15, 15))
         round_rectangle({x+20, y+34}, width-47, height-69, 7, 20, false, color(15, 15, 15))
         round_rectangle({x+20, y+34}, chargewidth-1, height-69, 7, 20, false, menuaccent:get())

     end
 end
charge:set_draw_function(chargecount)