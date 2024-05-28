local Draggable = require("Draggables")
local xx, yy = render.get_screen_size()

local critindicator = Draggable(35, 390, 150, 25)
local lp = entity_list.get_local_player()
local font = render.create_font("Tahoma Bold", 15, 590, 0x200)

local function paintcrit(x, y, w, h)
    local potential = crits.get_potential_crits()
    local available = crits.get_available_crits()
    local dmg = crits.get_excess_damage()
    local critcost = crits.get_cost()

    local crittext = available.. "/" ..potential.. " Potential crits"

    local crittext_width, _ = render.get_text_size(font, crittext)
    local crittext_xpos = x + (w - crittext_width) / 2 - 8

    if client.is_alive() and not user.is_game_ui_visible() then
        if crits.can_crit() and not crits.is_banned() then
            render.text({x , y}, color(124, 245, 118, 255), font, 1,"Crit Ready")
        
        elseif potential == 0 and available == 0 then
            render.text({x, y}, color(255, 135, 135, 255), font, 1,"Crits Unavailable")
        
        elseif crits.is_crit_boosted() then
            render.text({x,y}, color(81, 215, 252, 255), font, 1,"Crit Boosted")
        
        elseif crits.is_banned() then
            render.text({x ,y}, color(255, 135, 135, 255), font, 1,"deal " ..crits.get_unban_damage().. " damage")

        elseif available == 0 then
            render.text({x, y}, color(255, 135, 135, 255), font, 1,"Crits Unavailable")
        
        elseif crits.crits_disabled()  then
            render.text({x, y}, color(255, 135, 135, 255), font, 1,"Crits Disabled")
        end
        render.text({x ,y + 15}, color(255, 255, 255, 255), font, 1, crittext)


        if crits.can_crit() and not crits.is_banned() and dmg ~= nil then
                render.text({x , y + 30}, color(124, 245, 118, 255), font, 1, dmg .." damage")
        else return end
    end
end

critindicator:set_draw_function(paintcrit)