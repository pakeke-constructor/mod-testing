

```lua


base.Array() -- creates an array

base.Set() -- creates a sparse set

base.Class(name) -- creates a class with a name. Class names must be unique.
-- Also, classes should always be created on BOTH clientside AND serverside.

base.Partition(bucketXWidth, bucketYWidth) -- creates a spatial partition


base.getPlayer(username) -- gets an entity being controlled by `username`









--[[
========================================================================
         CLIENT SIDE ONLY:::
========================================================================
]]
base.animate(frames, ...) -- Same as ccall("animate"), 
    -- except frames is a list of asset names, like:  
    -- { "image1", "image2", "image3" }

base.shockwave(x, y, start_size, end_size, thickness, time, colour={1,1,1,1})

base.shake(duration, dx, dy, freq) -- Shakes the screen

base.hide(ent, duration) -- hides `ent` for `duration` seconds.



base.camera -- Access to the client's camera object.
    -- Camera should be fully mutable at runtime/
    base.camera.x -- Camera's x position
    base.camera.y -- Camera's y position
    base.camera.scale -- Camera's scale.

    local x, y = base.camera:getMousePosition() 
    -- the position of the mouse in the world



base.playSound(name, vol=1, pitch=1, effect=nil, vol_var=0, pitch_var=0)
base.playMusic(name, start_time=0, vol=1)



base.particles -- particle functions
    particles.emit(particleSys_or_name, x, y, z, num_particles, color) 
    -- emits particles

    local love_psys = base.particles.newParticleSystem({"image1", "image2", ...})
    -- creates a new particleSystem (a love2d particleSystem)

    particles.define(name, love_psys)
    -- defines a particle name. This allows particles to be pooled and cloned
    -- automatically.


```
