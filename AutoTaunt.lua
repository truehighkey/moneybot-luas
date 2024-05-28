local slots = { "0" , "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8" };
local dropdown = ui.add_dropdown("Taunt slot", slots) dropdown:set_visible(true)
local title = ui.add_label("Taunt slot 0  is the default \n weapon taunt.")
callbacks.register("player_death", function(e)
    local local_player = entity_list.get_local_player()
    local attacker_userid = e:get_int("attacker")
    local attacker = entity_list.get_by_user_id(attacker_userid)
    
    if local_player and attacker and local_player:get_index() == attacker:get_index() then
        console.exec("taunt ".. dropdown:get())
    end
end)