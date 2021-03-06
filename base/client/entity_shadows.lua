

local defaultColor = {0,0,0,0.6}

on("drawEntity", function(ent)
    if ent.shadow and ent.image then
        local r,b,g,a = graphics.getColor()
        local size = ent.shadow.size
        graphics.setColor(ent.shadow.color or defaultColor)
        graphics.circle("fill", ent.x, ent.y + size, size)
        graphics.setColor(r,b,g,a)
    end
end)

