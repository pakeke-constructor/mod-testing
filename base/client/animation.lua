
--[[

Handles animations of entities.

TODO:
Currently, all animation entities have the exact same cycle.
Change this by having a table that maps `[ent] --> current_cycle` 
to offset each entity animation

]]


local anim_group = group("image", "animation")



local tick = 0

local DEFAULT_ANIM_SPEED = 2 -- seconds to complete animation loop

local EPSILON = 0.00001

local function updateEnt(ent)
    local anim = ent.animation
    local spd = anim.speed or DEFAULT_ANIM_SPEED
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

