

--dofile(minetest.get_modpath("enemy").."/turret.lua")

-- Enemy Mod =) ------------------- 2021 -----------------------------


if minetest.setting_get("log_mods") then
	minetest.log("action", "[MOD] enemy has loaded")
end


---------------- SHOOT FUNCTION ------------------------------


local mobs_shoot_arrow = function(itemstack, player)
	for _,arrow in ipairs(arrows) do
		if player:get_inventory():get_stack("main", player:get_wield_index()+1):get_name() == arrow[1] then
			if not minetest.setting_getbool("creative_mode") then
				player:get_inventory():remove_item("main", arrow[1])
			end
			local playerpos = player:getpos()
			local obj = minetest.env:add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, arrow[2])
			local dir = player:get_look_dir()
			obj:setvelocity({x=dir.x*19, y=dir.y*19, z=dir.z*19})
			obj:setacceleration({x=dir.x*-3, y=-10, z=dir.z*-3})
			obj:setyaw(player:get_look_yaw()+math.pi)
			if obj:get_luaentity().player == "" then
				obj:get_luaentity().player = player
			end
			obj:get_luaentity().node = player:get_inventory():get_stack("main", 1):get_name()
			return true
		end
	end
	return false
end
------------------------------------------------------------------------------------------------

---------------------------- BULLETS -----------------------------------------------------------


mobs:register_arrow("enemy:enemy_bullet", {
	visual = "sprite",
	visual_size = {x=0.4, y=0.4},
	textures = {"enemy_buckball.png"},
	velocity = 20,
    --acceleration = 5,
    glow = 100,

        hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 2},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 2},
		}, nil)
	end,

	hit_node = function(self, pos, node)
    --mobs:boom(self, pos, 1)
	end

})


------------------------------------------------------------------------------------------------

---------------------------------- FLAMER ------------------------------------------------------


mobs:register_arrow("enemy:enemy_flame", {
	visual = "cube",
	visual_size = {x=0.01, y=0.01},
    texture = {"empty.png"},
	velocity = 20,
    tail = 1,
	tail_texture = "enemy_fire.png",
	tail_size = 6,
	glow = 50,
	expire = 1,
    drop = true,
        hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 5},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 5},
		}, nil)
	end,

	hit_node = function(self, pos, node)
    end
})


----------------------------------------------------------------------------------------------------



mobs:register_mob("enemy:black", {
	-- animal, monster, npc
	type = "monster",
    pathfinding = true,
    glow = 5,
	passive = false,
    reach = 2,
	damage = 7,
    attack_animals = true,
	attack_npcs = false,
	attack_players = true,
	group_attack = true,
	attack_type = "shoot",
	shoot_interval = 0.5,
	arrow = "enemy:enemy_bullet",
	shoot_offset = 1.7,
	attacks_monsters = false,

	hp_min = 10, hp_max = 50, armor = 100,
    floats = {x=0,y=0,z=0},
	collisionbox = {-0.35,-1,-0.35, 0.35,1.2,0.35},
	visual = "mesh",
	mesh = "enemy.b3d",
	drawtype = "front",
	textures = {
		{"Enemy_black.png", "enemy_gun.png"},
	},
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	sounds = {"enemy_ak",
                 max_hear_distance = 15},
    shoot_sounds = {"enemy_ak",
                 max_hear_distance = 15},
	walk_velocity = 4,
	run_velocity = 4,
	jump = true,
	stepheight = 1.6,
	drops = {
		{name = "rangedweapons:ammo",
		chance = 1, min = 50, max = 300},
	},
	water_damage = 1,
	lava_damage = 2,
	light_damage = 0,
    floats = {x=0,y=0,z=0},
	view_range = 25,
	animation = {
       speed_normal = 30,
		speed_run = 30,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 200,
		punch_end = 219,
    },
 sounds = {
		shoot_attack = "enemy_ak",
        distance = 44,
        war_cry = "enemy_shotgun_reload_full"
	}

})


----------------------------------------------------------------------------------------------------



mobs:register_mob("enemy:gunner", {
	-- animal, monster, npc
	type = "monster",
    pathfinding = true,
    glow = 5,
	passive = false,
    reach = 2,
	damage = 7,
    attack_animals = true,
	attack_npcs = false,
	attack_players = true,
	group_attack = true,
	attack_type = "shoot",
	shoot_interval = 0.5,
	arrow = "enemy:enemy_bullet",
	shoot_offset = 1.7,
	attacks_monsters = false,

	hp_min = 10, hp_max = 50, armor = 100,
    floats = {x=0,y=0,z=0},
	collisionbox = {-0.35,-1,-0.35, 0.35,1.2,0.35},
	visual = "mesh",
	mesh = "enemy.b3d",
	drawtype = "front",
	textures = {
		{"enemy_camo.png", "enemy_gun.png"},
	},
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	sounds = {"enemy_ak",
                 max_hear_distance = 15},
    shoot_sounds = {"enemy_ak",
                 max_hear_distance = 15},
	walk_velocity = 4,
	run_velocity = 4,
	jump = true,
	stepheight = 1.6,
	drops = {
		{name = "rangedweapons:ammo",
		chance = 1, min = 50, max = 300},
	},
	water_damage = 1,
	lava_damage = 2,
	light_damage = 0,
    floats = {x=0,y=0,z=0},
	view_range = 25,
	animation = {
       speed_normal = 30,
		speed_run = 30,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 200,
		punch_end = 219,
    },
 sounds = {
		shoot_attack = "enemy_ak",
        distance = 44,
        war_cry = "enemy_shotgun_reload_full"
	}

})


-----------------------------------------------------------------------



mobs:register_mob("enemy:helicopter", {
	-- animal, monster, npc
	type = "monster",
    glow = 5,
	passive = false,
    reach = 2,
	damage = 10,
    ------- FLY -------------
         fly = true,
	fly_in = {
		"air", "default:invisible_light"
	},
    -------------------------
    floats = 1,
    pathfinding = true,
    attack_animals = true,
	attack_npcs = false,
	attack_players = true,
	group_attack = true,
	attack_type = "shoot",
	shoot_interval = 0.5,
	arrow = "enemy:enemy_bullet",
	shoot_offset = 1,
	attacks_monsters = false,
	hp_min = 10, hp_max = 200, armor = 100,
	collisionbox = {-1.8, 0, -1.8, 1.8, 1.5, 1.8},
	visual = "mesh",
	mesh = "apache.b3d",
	drawtype = "front",
	textures = {
		{"enemy_helicopter.png"},
	},
	visual_size = {x=1, y=1},
	-- sounds
	makes_footstep_sound = false,
	sounds = {
    "bullet.ogg"
    },
	walk_velocity = 5,
	run_velocity = 7,
	floats = {x=0,y=0,z=0},
	jump = true,
	stepheight = 2.6,
    drops = { {name = "rangedweapons:ammo",
		chance = 1, min = 1, max = 3},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,

	view_range = 35,
	animation = {
 speed_normal = 50,
		speed_run = 60,
		stand_start = 11,
		stand_end = 20,
		walk_start = 11,
		walk_end = 20,
		run_start = 11,
		run_end = 20,
		punch_start = 11,
		punch_end = 20,
	},
    fly_mode = "rise",

sounds = {
		random = "helicopter_motor",
		shoot_attack = "enemy_ak",
        distance = 44
	}

})



-----------------------------------------------------------



mobs:register_mob("enemy:helicopter2", {
	-- animal, monster, npc
	type = "monster",
    glow = 5,
	passive = false,
    reach = 2,
	damage = 10,
    ------- FLY -------------
         fly = true,
	fly_in = {
		"air", "default:invisible_light"
	},
    -------------------------
    floats = 1,
    pathfinding = true,
    attack_animals = true,
	attack_npcs = false,
	attack_players = true,
	group_attack = true,
	attack_type = "shoot",
	shoot_interval = 1,
	arrow = "enemy:enemy_flame",
	shoot_offset = 1,
	attacks_monsters = false,
	hp_min = 10, hp_max = 200, armor = 100,
	collisionbox = {-1.8, 0, -1.8, 1.8, 1.5, 1.8},
	visual = "mesh",
	mesh = "apache.b3d",
	drawtype = "front",
	textures = {
		{"enemy_helicopter2.png"},
	},
	visual_size = {x=1, y=1},
	-- sounds
	makes_footstep_sound = false,

	walk_velocity = 5,
	run_velocity = 7,
	floats = {x=0,y=0,z=0},
	jump = true,
	stepheight = 2.6,
    drops = { {name = "rangedweapons:ammo",
		chance = 1, min = 1, max = 3},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,

	view_range = 45,
	animation = {
 speed_normal = 50,
		speed_run = 60,
		stand_start = 11,
		stand_end = 20,
		walk_start = 11,
		walk_end = 20,
		run_start = 11,
		run_end = 20,
		punch_start = 11,
		punch_end = 20,
	},
sounds = {
		random = "helicopter_motor",
		shoot_attack = "enemy_ak",
        distance = 44

	}

})



-----------------------------------------------------------



mobs:register_mob("enemy:tank", {
	-- animal, monster, npc
	type = "monster",
	passive = false,
    glow = 5,
    reach = 2,
	damage = 10,
    floats = 1,
    pathfinding = true,
    attack_animals = false,
	attack_npcs = false,
	attack_players = true,
	group_attack = true,
	attack_type = "dogshoot",
	dogshoot_switch = 1,
	dogshoot_count_max = 20, -- shoot for 10 seconds
	dogshoot_count2_max = 3, -- dogfight for 3 seconds
	shoot_interval = 1,
	arrow = "enemy:enemy_bullet",
	shoot_offset = 1,
	attacks_monsters = false,
	hp_min = 10, hp_max = 200, armor = 100,
	collisionbox = {-1, 0, -0.9, 1, 1.5, 0.9},
	visual = "mesh",
	mesh = "tank.b3d",
	drawtype = "front",
	textures = {
		{"enemy_tank.png"},
	},
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	sounds = {
    "bullet.ogg"
    },
	walk_velocity = 3,
	run_velocity = 4,
	floats = {x=0,y=0,z=0},
	jump = true,
	stepheight = 2.6,
	drops = {
		{name = "rangedweapons:ammo",
		chance = 1, min = 50, max = 3000},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,

	view_range = 65,
	-- model animation
	animation = {
	},

sounds = {
		shoot_attack = "enemy_ak",
        distance = 54,
        war_cry = "enemy_shell_insert"
	}
})



---------------------------------------------------------------





mobs:register_mob("enemy:artic", {
	-- animal, monster, npc
	type = "monster",
	passive = false,
    glow = 5,
    reach = 2,
	damage = 10,
    floats = 1,
    pathfinding = true,
    attack_animals = false,
	attack_npcs = false,
	attack_players = true,
	group_attack = true,
	attack_type = "dogshoot",
	dogshoot_switch = 1,
	dogshoot_count_max = 23, -- shoot for 10 seconds
	dogshoot_count2_max = 3, -- dogfight for 3 seconds
	shoot_interval = 1,
	arrow = "enemy:enemy_flame",
	shoot_offset = 1,
	attacks_monsters = false,
	hp_min = 10, hp_max = 200, armor = 100,
	collisionbox = {-1, 0, -0.9, 1, 1.5, 0.9},
	visual = "mesh",
	mesh = "tank.b3d",
	drawtype = "front",
	textures = {
		{"enemy_tankwhite.png"},
	},
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	sounds = {
    "bullet.ogg"
    },
	walk_velocity = 3,
	run_velocity = 4,
	floats = {x=0,y=0,z=0},
	jump = true,
	stepheight = 2.6,
	drops = {
		{name = "rangedweapons:ammo",
		chance = 1, min = 1, max = 3},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,

	view_range = 65,
	-- model animation
	animation = {
	},
    sounds = {
		shoot_attack = "enemy_ak",
        distance = 44,
        war_cry = "enemy_shell_insert"

	}
})

----------------------------------------------------------------------------------------





mobs:register_mob("enemy:dog", {
	type = "monster",
	hp_max = 35,
	passive = false,
    floats = 1,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
    visual_size = {x=1.5, y=1},
    drawtype = "front",
	mesh = "enemy_dog.x",
	textures = {
		{"enemy_dog.png"},
	},
    attack_animals = true,
	attack_npcs = true,
	attack_players = true,
	group_attack = true,
	makes_footstep_sound = true,
    attacks_monsters = false,
	sounds = {
		war_cry = "mobs_wolf_attack",
	},
	view_range = 25,
    glow = 10,
	walk_velocity = 2,
	run_velocity = 3,
	stepheight = 1.6,
	damage = 2,
	armor = 200,
	attack_type = "dogfight",
	drops = {
		{name = "mobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,

	animation = {
		speed_normal = 20,
		speed_run = 30,
		stand_start = 10,
		stand_end = 20,
		walk_start = 75,
		walk_end = 100,
		run_start = 100,
		run_end = 130,
		punch_start = 135,
		punch_end = 155,
	},

})


-----------------------------------------------------------



mobs:register_mob("enemy:enemy", {
	-- animal, monster, npc
	type = "monster",
	passive = false,
    glow = 5,
    reach = 2,
	damage = 7,
    floats = 1,
    attack_animals = true,
	attack_npcs = false,
	attack_players = true,
	group_attack = true,
	attack_type = "dogshoot",
	dogshoot_switch = 1,
	dogshoot_count_max = 12, -- shoot for 10 seconds
	dogshoot_count2_max = 3, -- dogfight for 3 seconds
	shoot_interval = 0.5,
	arrow = "enemy:enemy_bullet",
	shoot_offset = 1.7,
	attacks_monsters = false,
	hp_min = 10, hp_max = 20, armor = 100,
	collisionbox = {-0.35,-1,-0.35, 0.35,1.2,0.35},
	visual = "mesh",
	mesh = "enemy.b3d",
	drawtype = "front",
	textures = {
		{"enemy_blue.png", "enemy_gun.png"},
	},
    floats = {x=0,y=0,z=0},
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	sounds = {
    "bullet.ogg"
    },
	walk_velocity = 4,
	run_velocity = 4,
	jump = true,
	stepheight = 1.6,
	drops = {
		{name = "rangedweapons:ammo",
		chance = 1, min = 50, max = 300},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
    floats = {x=0,y=0,z=0},
	view_range = 30,
	animation = {
       speed_normal = 30,
		speed_run = 30,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 200,
		punch_end = 219,
	},

sounds = {
		shoot_attack = "enemy_ak",
        distance = 64,
        war_cry = "enemy_shotgun_reload_full"
	}

})




----------------------------------------------------------------------



mobs:register_mob("enemy:flamer", {
	-- animal, monster, npc
	type = "monster",
    pathfinding = true,
    glow = 5,
	passive = false,
    reach = 2,
	damage = 7,
    floats = 1,
    attack_animals = false,
	attack_npcs = false,
	attack_players = true,
	group_attack = true,
	attack_type = "dogshoot",
	dogshoot_switch = 1,
	dogshoot_count_max = 18, -- shoot for 10 seconds
	dogshoot_count2_max = 3, -- dogfight for 3 seconds
	shoot_interval = 0.5,
	arrow = "enemy:enemy_flame",
	shoot_offset = 1.7,
	attacks_monsters = false,
	-- health & armor
	hp_min = 10, hp_max = 20, armor = 100,
	-- textures and model
	collisionbox = {-0.35,-1,-0.35, 0.35,1.2,0.35},
	visual = "mesh",
	mesh = "enemy.b3d",
	drawtype = "front",
	textures = {
		{"enemy_mob.png", "enemy_gun.png"},
	},
	visual_size = {x=1, y=1},
	-- sounds
	makes_footstep_sound = true,
	sounds = {},
	-- speed and jump
	walk_velocity = 4,
	run_velocity = 4,
	jump = true,
	stepheight = 1.6,
	-- drops wood and chance of apples when dead
	drops = {
		{name = "rangedweapons:ammo",
		chance = 1, min = 50, max = 300},
	},
	-- damaged by
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
    floats = {x=0,y=0,z=0},
	view_range = 35,
	floats = {x=0,y=0,z=0},
	animation = {
       speed_normal = 30,
		speed_run = 30,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 200,
		punch_end = 219,
    },
    sounds = {
		shoot_attack = "enemy_ak",
        distance = 64,
        war_cry = "enemy_shotgun_reload_full"
	}
})



------------------------------------------------------------------------------------------------



--------------------- SPAWN ---------------------------
----
mobs:spawn({
	name = "enemy:tank",
	nodes = {
"default:desert_stone",
"default:desert_cobble",
"default:desert_stonebrick",
"default:desert_stone_block",
"default:sandstone",
"default:sandstonebrick",
"default:sandstone_block",
"default:desert_sandstone",
"default:desert_sand",
"default:desert_sandstone_block",
"default:silver_sandstone",
"default:silver_sandstone_brick",
"default:silver_sandstone_block",
"ethereal:mushroom_dirt",
"ethereal:bamboo_dirt",
"default:stone",
"default:sand"
},
	neighbors = {
"air",
"default:dry_shrub",
"default:marram_grass_1",
"default:marram_grass_2",
"default:marram_grass_3"
},
	max_light = 14,
	min_light = 0,
	chance = 3000,
	active_object_count = 1,
	min_height = 0,
	max_height = 100,
         --  interval = 30
            day_toggle = false

})


mobs:register_egg("enemy:tank", "tank", "default_tree.png", 1)


--------------------- SPAWN ---------------------------
----
mobs:spawn({
	name = "enemy:gunner",
	nodes = {
"default:desert_stone",
"default:desert_cobble",
"default:desert_stonebrick",
"default:desert_stone_block",
"default:sandstone",
"default:sandstonebrick",
"default:sandstone_block",
"default:desert_sandstone",
"default:desert_sand",
"default:desert_sandstone_block",
"default:silver_sandstone",
"default:silver_sandstone_brick",
"default:silver_sandstone_block",
"ethereal:mushroom_dirt",
"ethereal:bamboo_dirt",
"default:stone",
"default:sand"
	},
	neighbors = {
"air",
"default:dry_shrub",
"default:junglegrass",
"default:grass_1",
"default:grass_2",
"default:grass_3",
"default:grass_4",
"default:grass_5",
"default:dry_grass_1",
"default:dry_grass_2",
"default:dry_grass_3",
"default:dry_grass_4",
"default:dry_grass_5",
"default:fern_1",
"default:fern_2",
"default:fern_3",
"default:marram_grass_1",
"default:marram_grass_2",
"default:marram_grass_3"
},
	max_light = 14,
	min_light = 0,
	chance = 2000,
	active_object_count = 3,
	min_height = 0,
	max_height = 100,
            --interval = 30
             day_toggle = false
})


mobs:register_egg("enemy:gunner", "Gunner", "default_tree.png", 1)



--------------------- SPAWN ---------------------------
----
mobs:spawn({
	name = "enemy:helicopter",
	nodes = {
"air",
"default:cloud"
},
	neighbors = {
"air"
},
	max_light = 14,
	min_light = 0,
	chance = 600000,
	active_object_count = 1,
	min_height = 10,
	max_height = 300,

            day_toggle = false

})

mobs:register_egg("enemy:helicopter", "Heli", "default_tree.png", 1)



--------------------- SPAWN ---------------------------
----
mobs:spawn({
	name = "enemy:helicopter2",
	nodes = {
"air",
"default:cloud"
},
	neighbors = {
"air"
},
	max_light = 14,
	min_light = 0,
	chance = 700000,
	active_object_count = 1,
	min_height = 10,
	max_height = 300,

            day_toggle = false

})

mobs:register_egg("enemy:helicopter2", "Heli from Hell", "default_tree.png", 1)



--------------------- SPAWN ---------------------------

mobs:spawn({
	name = "enemy:black",
	nodes = {

"default:snow",
"default:snowblock",
"default:ice",
"default:cave_ice",
"ethereal:mushroom_dirt",
"ethereal:bamboo_dirt",
"default:dirt_with_snow",
"default:dirt_with_rainforest_litter",
"default:dirt_with_coniferous_litter",
"default:dry_dirt",
"default:dirt_with_grass",
"default:permafrost",
"default:permafrost_with_stones",
"default:permafrost_with_moss",
"default:papyrus"
},
neighbors = {
"air",
"default:dry_shrub",
"default:junglegrass",
"default:grass_1",
"default:grass_2",
"default:grass_3",
"default:grass_4",
"default:grass_5",
"default:dry_grass_1",
"default:dry_grass_2",
"default:dry_grass_3",
"default:dry_grass_4",
"default:dry_grass_5",
"default:fern_1",
"default:fern_2",
"default:fern_3",
"default:marram_grass_1",
"default:marram_grass_2",
"default:marram_grass_3"
},
	max_light = 14,
	min_light = 0,
	chance = 2000,
	active_object_count = 1,
	min_height = 0,
	max_height = 100,
            -- interval = 30

             day_toggle = false
})



mobs:register_egg("enemy:black", "Enemy", "default_tree.png", 1)


-----------------------------------------------------
mobs:spawn({
	name = "enemy:enemy",
	nodes = {

"default:snow",
"default:snowblock",
"default:ice",
"default:cave_ice",
"ethereal:mushroom_dirt",
"ethereal:bamboo_dirt",
"default:dirt_with_snow",
"default:dirt_with_rainforest_litter",
"default:dirt_with_coniferous_litter",
"default:dry_dirt",
"default:dirt_with_grass",
"default:permafrost",
"default:permafrost_with_stones",
"default:permafrost_with_moss",
"default:papyrus"
},
neighbors = {
"air",
"default:dry_shrub",
"default:junglegrass",
"default:grass_1",
"default:grass_2",
"default:grass_3",
"default:grass_4",
"default:grass_5",
"default:dry_grass_1",
"default:dry_grass_2",
"default:dry_grass_3",
"default:dry_grass_4",
"default:dry_grass_5",
"default:fern_1",
"default:fern_2",
"default:fern_3",
"default:marram_grass_1",
"default:marram_grass_2",
"default:marram_grass_3"
},
	max_light = 14,
	min_light = 0,
	chance = 2000,
	active_object_count = 1,
	min_height = 0,
	max_height = 100,
            -- interval = 30

             day_toggle = false
})



mobs:register_egg("enemy:enemy", "Enemy", "default_tree.png", 1)


--------------------- SPAWN ---------------------------

mobs:spawn({
	name = "enemy:dog",
    nodes = {

"default:snow",
"default:snowblock",
"default:ice",
"default:cave_ice",
"ethereal:mushroom_dirt",
"ethereal:bamboo_dirt",
"default:dirt_with_snow",
"default:dirt_with_rainforest_litter",
"default:dirt_with_coniferous_litter",
"default:dry_dirt",
"default:dirt_with_grass",
"default:permafrost",
"default:permafrost_with_stones",
"default:permafrost_with_moss",
"default:papyrus",
"default:dirt_with_grass"
},
neighbors = {
"air",
"default:dry_shrub",
"default:junglegrass",
"default:grass_1",
"default:grass_2",
"default:grass_3",
"default:grass_4",
"default:grass_5",
"default:dry_grass_1",
"default:dry_grass_2",
"default:dry_grass_3",
"default:dry_grass_4",
"default:dry_grass_5",
"default:fern_1",
"default:fern_2",
"default:fern_3",
"default:marram_grass_1",
"default:marram_grass_2",
"default:marram_grass_3"
},
	max_light = 14,
	min_light = 0,
	chance = 1000,
	active_object_count = 1,
	min_height = 0,
	max_height = 100,
            -- interval = 30

             day_toggle = nil

})

mobs:register_egg("enemy:dog", "N-nec", "wool_grey.png", 1)


--------------------- SPAWN ---------------------------

mobs:spawn({
	name = "enemy:flamer",
    nodes = {
"ethereal:mushroom_dirt",
"ethereal:bamboo_dirt",
"default:dirt_with_grass",
"default:dirt_with_snow",
"default:dirt_with_rainforest_litter",
"default:dirt_with_coniferous_litter",
"default:dry_dirt",
"default:dry_dirt_with_dry_grass",
"default:permafrost",
"default:permafrost_with_stones",
"default:permafrost_with_moss",
"default:papyrus"
},
neighbors = {
"air",
"default:dry_shrub",
"default:junglegrass",
"default:marram_grass_1",
"default:marram_grass_2",
"default:marram_grass_3"
},
	max_light = 14,
    min_light = 0,
	chance = 3000,
	active_object_count = 1,
	min_height = 0,
	max_height = 300,
           --  interval = 30
             day_toggle = false
})


mobs:register_egg("enemy:flamer", "Flame Runner", "default_tree.png", 1)

----------------------------------------------------------------------------------------------------------------------------


mobs:spawn({
	name = "enemy:artic",
	nodes = {
"default:permafrost",
"default:permafrost_with_stones",
"default:permafrost_with_moss",
"default:snow",
"default:snowblock",
"default:ice",
"default:stone",
"default:sand",
"default:dirt",
"default:dirt_with_snow",
},
	neighbors = {
"air",
"default:snow"
},
	max_light = 14,
	min_light = 0,
	chance = 5000,
	active_object_count = 1,
	min_height = 0,
	max_height = 30,
         --  interval = 30
             day_toggle = false
})

mobs:register_egg("enemy:artic", "artic tank", "default_tree.png", 1)


--------------------- SPAWN --------------------------
----
---mobs:spawn({
	--name = "enemy:tank",
	--nodes = {
	--	"default:stone", "castle_masonry:pavement_brick",
	--	"default:sand"
	--},
	--neighbors = "air",
	--max_light = 13,
	--min_light = 0,
	--chance = 5000,
	--active_object_count = 2,
	--min_height = 0,
	---max_height = 30
--})
