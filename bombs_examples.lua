--Ice bomb
nssbombs:register_throwitem("ice", "Ice Bomb", {
    textures = "ice_bomb.png",
    recipe_number = 8,
    recipe_block = "default:ice",
    explosion = {
        shape = "wall",
        radius = 20,
        block = "default:ice",
        particles = true,
    },
})

--Fire bomb
nssbombs:register_throwitem("fire", "Fire Bomb", {
    textures = "fire_bomb.png",
    recipe_block = "bucket:lava_bucket",
    explosion = {
        shape = "circle",
        radius = 6,
        block = "fire:basic_flame",
        particles = true,
    },
})

--Schematic bomb
nssbombs:register_throwitem("schematic", "Schematic Bomb", {
    textures = "fire_bomb.png",
    recipe_block = "bucket:water_bucket",
    explosion = {
        shape = "schematic",
        --radius = 5,
        block = minetest.get_modpath("nssb").."/schems/piccoghiaccio.mts",
        --particles = true,
    },
})

--[[
hit_node = function(self,pos)
    for dx = -1,1 do
        for dy = 1,3 do
            for dz = -1,1 do
                local pos1 = {x = pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                local pos2 = {x = pos.x, y=pos.y+1, z=pos.z}
                local pos3 = {x = pos.x, y=pos.y+2, z=pos.z}
                if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                    minetest.set_node(pos1, {name="default:ice"})
                    minetest.set_node(pos2, {name="air"})
                    minetest.set_node(pos3, {name="air"})
                end
            end
        end
    end
end,
]]
--[[
Schematic spawning:
block=minetest.get_modpath("nssb").."/schems/".. build ..".mts"


]]
