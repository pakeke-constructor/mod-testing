


local zoom_speed = nil

local DEFAULT_ZOOM_SPEED = 22

local MAX_ZOOM = 10
local MIN_ZOOM = 0.1


on("wheelmoved", function(_, dy)
    local speed = zoom_speed or DEFAULT_ZOOM_SPEED
    if dy > 0 then
        base.camera.scale = base.camera.scale * (1+(1/speed))
    else
        base.camera.scale = base.camera.scale * (1-(1/speed))
    end

    -- now clamp:
    base.camera.scale = math.min(math.max(base.camera.scale, MIN_ZOOM), MAX_ZOOM)
end)


local last_camx, last_camy = base.camera.x or 0, base.camera.y or 0




local DEFAULT_PAN_SPEED = 900

local MOUSE_PAN_THRESHOLD = 50 -- X pixels from the screen border to move.


local function moveCam(dt)
    local dx,dy = 0,0
    local x, y = mouse.getPosition()
    local w, h = graphics.getWidth(), graphics.getHeight()
    local speed = (DEFAULT_PAN_SPEED * dt) / base.camera.scale

    if x < MOUSE_PAN_THRESHOLD then
        dx = -speed
    elseif x > (w - MOUSE_PAN_THRESHOLD) then
        dx = speed
    end

    if y < MOUSE_PAN_THRESHOLD then
        dy = -speed
    elseif y > (h - MOUSE_PAN_THRESHOLD) then
        dy = speed
    end

    base.camera.x = base.camera.x + dx
    base.camera.y = base.camera.y + dy 
end


local IS_PAN_MODE = false


on("update", function(dt)
    if keyboard.isDown("lshift") then
        IS_PAN_MODE = true
    else
        IS_PAN_MODE = false
    end

    if IS_PAN_MODE then
        base.camera.x = last_camx
        base.camera.y = last_camy
        moveCam(dt)
    end

    last_camx = base.camera.x
    last_camy = base.camera.y
end)



local MIDDLE_MOUSE_BUTTON = 3

on("mousemoved", function(x,y, dx,dy)
    if mouse.isDown(MIDDLE_MOUSE_BUTTON) then
        local c = base.camera
        local wx1, wy1 = c:toWorldCoords(x-dx,y-dy)
        local wx2, wy2 = c:toWorldCoords(x,y)
        local wdx, wdy = wx2-wx1, wy1-wy2
        last_camx = last_camx - wdx
        last_camy = last_camy + wdy
    end
end)


