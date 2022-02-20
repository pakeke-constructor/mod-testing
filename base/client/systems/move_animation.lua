
--[[

Handles moving animation of entities.

TODO:
Currently, all move animation entities have the exact same cycle.
Change this by having a table that maps `[ent] --> current_cycle` 
to offset each entity animation

]]



local anim_group = group("image", "moveAnimation", "vx", "vy")



local tick = 0

local DEFAULT_ANIM_SPEED = 2 -- seconds to complete animation loop

local EPSILON = 0.00001


local ent_to_direction = {
    --[[
        [ent] = current_direction_of_this_ent
    ]]
}

--[[
    directions are as follows:
    `up`, `down`, `left`, `right`
]]




anim_group:on_added(function(ent)
    ent_to_direction[ent] = "down"
end)


anim_group:on_removed(function(ent)
    ent_to_direction[ent] = nil
end)




local distance = math.distance
local abs = math.abs

local function getDirection(ent)
    local manim = ent.moveAnimation
    local entspeed = distance(ent.vx, ent.vy)
    if entspeed > manim.activation then
        local dir
        if abs(ent.vx) > abs(ent.vy) then
            -- Left or Right
            if ent.vx < 0 then
                dir = "left"
            else
                dir = "right"
            end
        else
            -- up or down
            if ent.vy < 0 then
                dir = "up"
            else
                dir = "down"
            end
        end
        return dir
    else
        -- The entity is not going fast enough;
        -- return it's previous direction
        return ent_to_direction[ent]
    end
end


local function updateEnt(ent)
    local manim = ent.moveAnimation
    local dir = getDirection(ent) -- should be up, down, left, or right
    local spd = manim or DEFAULT_ANIM_SPEED

    local anim = ent.moveAnimation[dir]
    -- TODO: Chuck an assertion here to ensure that people aren't misusing
    -- the moveAnimation component. (all directions must be defined)
    local len = #anim

    -- minus epsilon to ensure that we don't hit the top len value,
    -- plus 1 because of lua's 1-based indexing.
    local frame_i = math.floor(((tick % spd) / spd) * len - EPSILON) + 1
    local frame = anim[frame_i]
    ent.image = frame
end


on("update", function(dt)
    tick = tick + dt
    for i=1, #anim_group do
        local ent = anim_group[i]
        updateEnt(ent)
    end
end)
