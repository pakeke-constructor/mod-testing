
local entityHelper = require("other.entity_helper")

local base = {
    gravity = require("other.gravity");
    
    Class = require("other.class");
    Set = require("other.set");
    Array = require("other.array");
    Partition = require("other.partition.partition");
    
    getPlayer = require("other.get_player");

    entityHelper = entityHelper;

    inspect = require("_libs.inspect")
}


export("base", base)


