

--[[

If a player is close enough to an item, the item will
be picked up.

I.e, the entity needs `controllable` and `inventory` component to pick up
stuff.


]]



local invPlayers = group("x", "y", "controllable", "inventory")

local items = group("x", "y", "itemName")





local INTERACTION_DISTANCE = 15
-- distance from when you can pick up an item


local itemPartition = base.Partition(INTERACTION_DISTANCE + 5, INTERACTION_DISTANCE + 5)




items:onAdded(function(e)
    itemPartition:add(e)
end)


items:onRemoved(function(e)
    itemPartition:remove(e)
end)



local PICKUP_DELAY_TIME = 2 --- 2 seconds delay is reasonable

local item_to_lastheldtime = {
--[[
This data structure is used to ensure that there is a delay before an item
can be picked up.

    [item] = last_held_time
]]
}


local function canBePickedUp(dist, best_dist, item)
    local bool2 = (dist < INTERACTION_DISTANCE) and (dist < best_dist)
    if not bool2 then return end

    if item_to_lastheldtime[item] then
        local time = timer.getTime() - item_to_lastheldtime[item]
        if time < PICKUP_DELAY_TIME then
            return
        end
    end

    return true
end


on("_inventory_dropInventoryItem", function(item, x,y)
    item_to_lastheldtime[item] = timer.getTime()
    itemPartition:add(item)
end)



on("update5", function(dt)
    local picked = {}
    itemPartition:update(dt)
    for _, player in ipairs(invPlayers) do
        local best_dist = math.huge
        local pickup
        local ix, iy = player.inventory:getFreeSpace()
        if ix then
            for item in itemPartition:foreach(player.x, player.y) do
                if not item.hidden and not picked[item] then 
                    -- then the item is on the ground
                    local d = math.distance(player, item)
                    if canBePickedUp(d, best_dist, item) then
                        item_to_lastheldtime[item] = nil
                        pickup = item
                        best_dist = d
                    end
                end
            end
            if pickup then
                player.inventory:set(ix, iy, pickup)
                server.broadcast("pickUpInventoryItem", pickup)
                pickup.hidden = true
                picked[pickup] = true
            end
        end
    end

    for ent, _ in pairs(picked) do
        itemPartition:remove(ent)
    end
end)


