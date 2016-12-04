function nssbombs:register_throwitem(name, descr, def)

    minetest.register_craftitem("nssbombs:"..name.."_bomb", {
        description = descr,
        inventory_image = def.textures,
        on_use = function(itemstack, placer, pointed_thing)
            local velocity = def.velocity or 15
            local dir = placer:get_look_dir()
            local playerpos = placer:getpos()
            local obj = minetest.env:add_entity({x=playerpos.x+dir.x,y=playerpos.y+2+dir.y,z=playerpos.z+dir.z}, "nssbombs:"..name.."_bomb_flying")
            local vec = {x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity}
            local acc = {x=0, y=-9.8, z=0}
            obj:setvelocity(vec)
            obj:setacceleration(acc)
            itemstack:take_item()
            return itemstack
        end,
    })

    minetest.register_entity("nssbombs:"..name.."_bomb_flying",{
        textures = {def.textures},
		hp_max = 50,
		collisionbox = {-0.1,-0.1,-0.1, 0.1,0.1,0.1},
        visual_size = def.visual_size or {x=1, y=1},
        explosion = def.explosion or {},
        on_step = function(self, dtime)
            local pos = self.object:getpos()
            local node = minetest.get_node(pos)
            local name = node.name
            if name ~= "air" then
                if def.hit_node then
                    def.hit_node(self, pos)
                else
                    default_hit_node(self, self.explosion)
                end
                self.object:remove()
            end
        end,
    })

    if def.recipe_block then
        recepy = {
            {def.recipe_block, def.recipe_block, def.recipe_block},
    		{"tnt:gunpowder", "default:mese_crystal_fragment", "tnt:gunpowder"},
    		{def.recipe_block, def.recipe_block, def.recipe_block},
        }
    end

    local number = def.recipe_number or 1
    minetest.register_craft({
    	output = "nssbombs:"..name.."_bomb "..number,
    	recipe = def.recipe or recepy
    })

end

function default_hit_node(self, explosion)
    radius = explosion.radius
    shape = explosion.shape
    block = explosion.block
    particles = explosion.particles

    local p = self.object:getpos()
    local center = {x=p.x, y=p.y+radius, z=p.z}

    if particles then
        add_effects(center, radius, block)
    end

    if shape == "cube" then
        for dx = -radius,radius do
            for dy = 0,2*radius do
                for dz = -radius,radius do
                    local pos1 = {x = p.x+dx, y=p.y+dy, z=p.z+dz}
                    if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                        minetest.set_node(pos1, {name=block})
                    end
                end
            end
        end
    elseif shape == "sphere" then
        for dx = -radius,radius do
            for dy = 0,2*radius do
                for dz = -radius,radius do
                    local pos1 = {x = p.x+dx, y=p.y+dy, z=p.z+dz}
                    if math.abs(vector.length(vector.subtract(pos1,center))) <= radius then
                        if not minetest.is_protected(pos1, "") or not minetest.get_item_group(minetest.get_node(pos1).name, "unbreakable") == 1 then
                            minetest.set_node(pos1, {name=block})
                        end
                    end
                end
            end
        end
    end
end

function add_effects(pos, radius, block)
	minetest.add_particle({
		pos = pos,
		velocity = vector.new(),
		acceleration = vector.new(),
		expirationtime = 0.4,
		size = radius * 10,
		collisiondetection = false,
		vertical = false,
		texture = "tnt_boom.png",
	})
	minetest.add_particlespawner({
		amount = 32,
		time = 0.5,
		minpos = vector.subtract(pos, radius / 2),
		maxpos = vector.add(pos, radius / 2),
		minvel = {x = -10, y = -10, z = -10},
		maxvel = {x = 10, y = 10, z = 10},
		minacc = vector.new(),
		maxacc = vector.new(),
		minexptime = 1,
		maxexptime = 2.5,
		minsize = radius * 3,
		maxsize = radius * 5,
		texture = "tnt_smoke.png",
	})

    local texture2 = "tnt_smoke.png"
    local def = minetest.registered_nodes[block]
    if def and def.tiles and def.tiles[1] and type(def.tiles[1])=="string" then
        texture2 = def.tiles[1]
    end

    minetest.add_particlespawner({
        amount = 32,
		time = 0.5,
		minpos = vector.subtract(pos, radius / 2),
		maxpos = vector.add(pos, radius / 2),
		minvel = {x = -10, y = -10, z = -10},
		maxvel = {x = 10, y = 10, z = 10},
		minacc = vector.new(),
		maxacc = vector.new(),
		minexptime = 1,
		maxexptime = 2.5,
		minsize = radius * 3,
		maxsize = radius * 5,
		texture = texture2,
	})

	local texture1 = "tnt_blast.png" --fallback texture
	minetest.add_particlespawner({
		amount = 32,
		time = 0.1,
		minpos = vector.subtract(pos, radius / 2),
		maxpos = vector.add(pos, radius / 2),
		minvel = {x = -3, y = 0, z = -3},
		maxvel = {x = 3, y = 5,  z = 3},
		minacc = {x = 0, y = -10, z = 0},
		maxacc = {x = 0, y = -10, z = 0},
		minexptime = 0.8,
		maxexptime = 2.0,
		minsize = radius * 0.66,
		maxsize = radius * 2,
		texture = texture1,
		collisiondetection = true,
	})


end
