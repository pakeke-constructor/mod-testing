
# Movement behaviour mod


PLANNING::
```lua

ent.category = "blueTeam" -- the category that the entity belongs to


--[[

There are many different ways of pathfinding.
A few examples 
]]



local MOVE_TYPES = {
    "circle", --     will circle around target entity
    "follow", -- moves directly towards target entity
    "flee", -- moves directly away from target entity
    "kite", --   trys to stay a fixed distance from target entity

    "random", -- moves in a random direction. Stops for X seconds, then repeats.
    "randomFollow" -- moves in a random direction near target entity. Stops for X seconds, then repeats.
    "none", --   no movement
}


ent.moveBehaviour = {
    type = anything from MOVE_TYPES,
    
    target = "redTeam", -- target is the closest redTeam entity.
    -- alternatively, if `ent.pathfindTarget` is set, it will ignore this value,
    -- and target that entity instead.

    activateDistance = 200,
    -- the distance required for a new target to be selected.



    -- OPTIONAL VALUES:

    -- only used with `circle` pathfind type:
    circleRadius = 50 -- circles around target with radius of 50 units

    -- only used with `kite` pathfind type:
    kiteRadius = 50 -- kites at a radius of 50 units

    -- These are only used with `random` and `randomFollow` pathfind type:
    randomWait = {min=1, max=5} 
    -- waits a random time between movement, min = 1 second, max = 5 seconds.
    randomDistance = {min=20, max=100}
    -- random distance to move, anywhere between 20 and 100 units.
}



```


