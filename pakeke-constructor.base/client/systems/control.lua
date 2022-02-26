
--[[

Handles player control


]]

local control_ents = group("controllable", "controller")


local UP = "w"
local LEFT = "a"
local DOWN = "s"
local RIGHT = "d"

local LEFT_ABILITY = "q"
local RIGHT_ABILITY = "e"



local function pollControlEnts(func_key, a,b,c)
    for _, ent in ipairs(control_ents) do
        if ent.controller == username then
            -- if this ent is being controlled by the player:
            if ent.controllable[func_key] then
                -- and if the callback exists:
                ent.controllable[func_key](ent, a,b,c)
            end
        end
    end
end


on("keypressed", function(key, scancode)
    if scancode == LEFT_ABILITY then
        pollControlEnts("onLeftAbility")
    end
    if scancode == RIGHT_ABILITY then
        pollControlEnts("onRightAbility")
    end
end)



on("mousepressed", function(butto, x, y)
    -- TODO: This aint working!!! Maybe it's mousedown??? idk 
    if butto == 1 then
        pollControlEnts(nil, "onClick", x, y)
    end
end)


local isDown = keyboard.isScancodeDown


local DEFAULT_SPEED = 200

local SPEED_AGILITY_SCALE = 12


local max, min = math.max, math.min

local function updateEnt(ent, dt)
    local speed = ent.speed or DEFAULT_SPEED
    local agility = ent.agility or (speed * SPEED_AGILITY_SCALE)
    local delta = agility * dt

    if isDown(UP) then
        ent.vy = max(-speed, ent.vy - delta)
    end
    if isDown(DOWN) then
        ent.vy = min(speed, ent.vy + delta)
    end
    if isDown(LEFT) then
        ent.vx = max(-speed, ent.vx - delta)
    end
    if isDown(RIGHT) then
        ent.vx = min(speed, ent.vx + delta)
    end
end



on("update", function(dt)
    local sum_x = 0
    local sum_y = 0
    local len = 0
    
    for _, ent in ipairs(control_ents) do
        if ent.controller == username and ent.x and ent.vx then
            sum_x = sum_x + ent.x
            sum_y = sum_y + ent.y
            len = len + 1
            updateEnt(ent, dt)
        end
    end

    local avg_x, avg_y = 0, 0
    if len > 0 then
        avg_x = sum_x / len
        avg_y = sum_y / len
    end
    -- graphics.camera:follow(avg_x, avg_y)
end)

