


local uname_to_player = {

}

local function make_player(uname)
    local ent = entities.player()
    ent.x = math.random(-10, 10)
    ent.y = math.random(-10, 10)
    ent.z = 0
    ent.vx, ent.vy, ent.vz = 0,0,0
    ent.controller = uname
    ent.inventory = {
        width = 7; height = 5; color = {1,1,1}
    }
    uname_to_player[uname] = ent
    return ent
end



local function make_grass(x,y)
    local grass = entities.grass()
    grass.x = x
    grass.y = y
    local rand = math.random(1, 7)
    grass.image = "grass_" .. tostring(rand)
end


on("createWorld", function()
    for i=1, 30 do
        local MAG = 200
        local x, y = math.random(-MAG, MAG), math.random(-MAG, MAG)
        local e = entities.item()
        e.stackSize = math.floor(math.random(1,5))
        e.x = x
        e.y = y
    end

    for i=1, 4 do
        local MAG = 200
        local x, y = math.random(-MAG, MAG), math.random(-MAG, MAG)
        local e = entities.pickaxe()
        e.stackSize = 1
        e.x = x
        e.y = y
    end

    for i=1, 4 do
        local MAG = 200
        local x, y = math.random(-MAG, MAG), math.random(-MAG, MAG)
        local e = entities.musket()
        e.stackSize = 1
        e.x = x
        e.y = y
    end

    for i=1, 30 do
        local MAG = 250
        local x, y = math.random(-MAG, MAG), math.random(-MAG, MAG)
        local block = entities.block()
        block.x = x
        block.y = y
        block.vx = 0
        block.vy = 0
        if math.random() < 0.5 then
            block.image = "slant_block"
        else
            block.image = "slant_block2"
        end
    end

    for i=1, 160 do
        local MAG = 150
        make_grass(math.random(-MAG, MAG), math.random(-MAG, MAG))
    end

    entities.crate()
    entities.crate_button(100, 100)
    entities.crafting_table(-100, 100)
end)


server.on("spawn", function(u, e)
    local b = entities.block_item()
    b.x = e.x; b.y = e.y
    b.stackSize = 5
end)


local control_ents = group("controllable", "x", "y")
server.on("CONGLOMERATE", function(username, ent)
    for _,e in ipairs(control_ents)do
        if e.controller == username then
            e.x = ent.x
            e.y = ent.y
        end
    end
end)


on("newPlayer", function(uname)
    make_player(uname)
end)

