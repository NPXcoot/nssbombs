--Stone Wall bomb
nssbombs:register_throwitem("nssbombs:stone_wall_bomb", "Stone Wall Bomb", {
    textures = "stonewall_bomb.png",
    recipe_number = 8,
    recipe_block = "default:cobble",
    explosion = {
        shape = "wall",
        radius = 10,
        block = "default:stone",
        particles = true,
    },
})

--Cubic Ice Shell bomb
nssbombs:register_throwitem("nssbombs:ice_bomb", "Cubic Ice Shell bomb", {
    textures = "ice_bomb.png",
    recipe_number = 8,
    recipe_block = "default:ice",
    explosion = {
        shape = "cubic_shell",
        radius = 2,
        block = "default:ice",
        particles = true,
    },
})

--Fire Circle bomb
nssbombs:register_throwitem("nssbombs:fire_bomb", "Fire Bomb", {
    textures = "fire_bomb.png",
    recipe_block = "fire:flint_and_steel",
    recipe_number = 4,
    explosion = {
        shape = "circle",
        radius = 6,
        block = "fire:basic_flame",
        particles = true,
    },
})

--Lava pool
nssbombs:register_throwitem("nssbombs:lava_bomb", "Lava Bomb", {
    textures = "lava_bomb.png",
    recipe_block = "bucket:lava_bucket",
    recipe_number = 3,
    explosion = {
        shape = "pool",
        radius = 2,
        block = "default:lava_source",
        particles = false,
        sound = true,
    }
})

--Water column
nssbombs:register_throwitem("nssbombs:water_column_bomb", "Water Colun Bomb", {
    textures = "water_column_bomb.png",
    recipe_block = "bucket:water_bucket",
    recipe_number = 6,
    explosion = {
        shape = "column",
        radius = 5,
        block = "default:water_source",
        particles = false,
    }
})

--Tnt Bomb
nssbombs:register_throwitem("nssbombs:tnt_bomb", "TNT explosion bomb", {
    textures = "bomb_bomb.png",
    recipe_block = "tnt:tnt",
    recipe_number = 6,
    explosion = {
        shape = "tnt_explosion",
        radius = 5,
    }
})

--Schematic bomb (house)
nssbombs:register_throwitem("nssbombs:schematic_bomb", "Schematic Bomb", {
    textures = "schematic_bomb.png",
    recipe_number = 4,
    recipe = {
        {"default:wood", "default:wood", "default:wood"},
        {"default:brick", "default:mese_crystal_fragment", "default:brick"},
        {"default:cobble", "default:cobble", "default:cobble"}
    },
    explosion = {
        shape = "schematic",
        radius = 9,
        block = minetest.get_modpath("nssbombs").."/schems/simple_house.mts",
        particles = true,
    },
})

--Teleport Bomb
nssbombs:register_throwitem("nssbombs:teleport_bomb", "Teleport Bomb", {
    textures = "teleport_bomb.png",
    recipe_number = 10,
    recipe_block = "default:gold_ingot",
    hit_node = function(self,pos)
        local pos1 = {x = pos.x, y=pos.y+1, z=pos.z}
        local pos2 = {x = pos.x, y=pos.y+2, z=pos.z}
        if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
            minetest.set_node(pos1, {name="air"})
            minetest.set_node(pos2, {name="air"})
            self.placer:setpos(pos1)
        end
    end,
})
