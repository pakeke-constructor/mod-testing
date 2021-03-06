

local newShockWave = require("_libs.shockwave")


-- Gotta make sure this is loaded:
local Set = require("other.set")


-- a Set for all shockwave objects that are being drawn
local shockwaveSet = Set()



on("update", function(dt)
    for _,sw in ipairs(shockwaveSet.objects)do
        sw:update(dt)
        if sw.isFinished then
            shockwaveSet:remove(sw)
            sw.colour = nil -- easier on GC
        end
    end
end)




on("postDraw", function()
    for _,sw in ipairs(shockwaveSet.objects) do
        sw:draw()
    end
end)




local function shockwave(x, y, start_size, end_size, thickness, time, colour)
    local sw = newShockWave(x,y,start_size, end_size, thickness, time, colour or {1,1,1,1})
    shockwaveSet:add(sw)
end



return shockwave

