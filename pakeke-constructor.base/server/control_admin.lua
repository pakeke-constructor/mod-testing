
--[[

Handles ents that are being controlled by the player.

Currently there are no restrictions for moving your own entity;
this means that modified clients can teleport anywhere on the screen

]]


local constants = require("other.constants")


local function filterPlayerPosition(sender_username, ent, x,y,z)
    if not exists(ent) then
        return false -- DENY! Non existant entity
    end
    return ent.controllable and sender_username == ent.controller
        and ent.x and ent.y
end

server.filter("setPlayerPosition", filterPlayerPosition)



local function filterPlayerVelocity(sender_username, ent, vx,vy,vz)
    if not exists(ent) then
        return false -- DENY! Non existant entity
    end
    return ent.controllable and sender_username == ent.controller
        and ent.vx and ent.vy
end

server.filter("setPlayerVelocity", filterPlayerVelocity)




server.on("setPlayerPosition", function(sender_username, ent, x,y,z)
    --[[
        TODO: Make it so players cannot cheat by lying about their position!
    ]]
    ent.x = x
    ent.y = y
    ent.z = z or ent.z
end)



server.on("setPlayerVelocity", function(sender_username, ent, vx,vy,vz)
    local speed = math.distance(vx, vy, vz)

    if speed <= (ent.speed or constants.DEFAULT_SPEED) then
        -- check that the player aint cheating
        ent.vx = vx
        ent.vy = vy
        if ent.vz then
        ent.vz = vz
        end
    end
end)

