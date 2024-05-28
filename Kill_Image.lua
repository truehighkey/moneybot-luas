local Draggable = require("Draggables")

local kill_icon_time = 0
local image1 = render.load_file("PATH TO 1ST IMAGE")
local image2 = render.load_file("PATH TO 2ND IMAGE")
local image_size_slider = ui.add_slider("Image Size", 100, 1, 60)


callbacks.register("player_death", function(e)
    local local_player = entity_list.get_local_player()
    local attacker_userid = e:get_int("attacker")
    local attacker = entity_list.get_by_user_id(attacker_userid)
    
    if local_player and attacker and local_player:get_index() == attacker:get_index() then
        kill_icon_time = client.get_curtime() + 1
    end
end)

local kill_image = Draggable(15, 15, 400, 400)

kill_image:set_draw_function(function(x, y, width, height)
    local image_size = image_size_slider:get()
    local screen_width, screen_height = render.get_screen_size()
    local image_width, image_height = render.get_image_size(image1)
    local scaled_width = image_width * (image_size / 100)
    local scaled_height = image_height * (image_size / 100)

    if client.get_curtime() < kill_icon_time then
        render.image(image2, {x, y}, {scaled_width, scaled_height})
    else
        render.image(image1, {x, y}, {scaled_width, scaled_height})
    end
    
    if ui.is_open() then
        render.image(image1, {x, y}, {scaled_width, scaled_height})
    else return end
end)
