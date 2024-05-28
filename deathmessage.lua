-- Lua requested by Xarq0n

callbacks.register("player_death", function(e)
    local local_player = entity_list.get_local_player()
    local victim_userid = e:get_int("userid")
    local attacker_userid = e:get_int("attacker")
    
    if local_player and victim_userid and attacker_userid then
        local victim_index = entity_list.get_by_user_id(victim_userid)
        local attacker_index = entity_list.get_by_user_id(attacker_userid)
        
        if victim_index == local_player then
            local attacker = entity_list.get_by_user_id(attacker_userid)
            if attacker  then
                local attacker_name = attacker:get_name()
                if attacker_name ~= local_player:get_name() then
                    console.exec("say " ..attacker_name.. " ｙｏｕ ｄｉｄｎｔ ｋｉｌｌ ｍｅ ｉ ｄｅａｄｒａｎｇ.") -- you can remove the ..attacker_name.. if you dont want the killer's name to be mentioned
                end

            end
        end
    end
end)