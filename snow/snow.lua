local args = ...
local g = args[1]
local map_data = args[2][1]
local snow_index = args[3]

-- -----------------------------------
-- variables you might want to configure to your liking

-- starting values (these can be manipulated later as needed)
local num_particles = 600
-- particle size in pixels
local min_size = 12 + ((snow_index-1)*8)
local max_size = 35 + ((snow_index-1)*8)
-- particle velocity in pixels per second
local min_vx = -7
local max_vx = 7
local min_vy = 55
local max_vy = 85
-- try to keep it SFW
local path_to_texture = GAMESTATE:GetCurrentSong():GetSongDir().."snow/snowflake.png"

-- -----------------------------------
local verts = {}
local velocities = {}
local x, y, size, alpha, index
local delta_x, delta_y

local initialize_particle = function(i, reset)
	-- randomize velocity as {vx, vy}
	velocities[i] = {math.random(min_vx,max_vx), math.random(min_vy,max_vy)}

	size = math.random(min_size, max_size)
	alpha = math.random(6, 10)/10

	x = math.random(map_data.width*map_data.tilewidth*g.map.zoom + size*2)

	if reset then
		-- update only the x, y, z sub-table so that the particle is at the top of the map
		verts[i+0][1] = {x-size, -size, 0}
		verts[i+1][1] = {x, -size, 0}
		verts[i+2][1] = {x, 0, 0}
		verts[i+3][1] = {x-size, 0, 0}

	else
		-- randomize y at init so that not all particles start at a y of 0
		y = math.random(map_data.height*map_data.tileheight*g.map.zoom + size*2)

		-- insert all our particle data into the verts table
		table.insert( verts, {{x-size, y-size, 0}, {1,1,1,alpha}, {0,0} } )
		table.insert( verts, {{x, y-size, 0}, {1,1,1,alpha}, {1,0} } )
		table.insert( verts, {{x, y, 0}, {1,1,1,alpha}, {1,1} } )
		table.insert( verts, {{x-size, y, 0}, {1,1,1,alpha}, {0,1} } )
	end
end

-- initialize the verts table
for i=1, num_particles do
	initialize_particle(i, false)
end


-- the snow AMV needs to be in an ActorFrame so that we can hibernate the AF instead of the AMV directly
-- (hibernating the the AMV directly led to bizarre visual side effects in animating the snowfall via UpdateAMV)
local af = Def.ActorFrame{
	InitCommand=function(self)
		self:diffusealpha(0):visible(false)
	end,
	OnCommand=function(self)
		self:hibernate(snow_index*20):queuecommand("Appear")
	end,
	AppearCommand=function(self)
		self:visible(true):linear(1):diffusealpha(1)
	end,
}

af[#af+1] = Def.ActorMultiVertex{
	InitCommand=function(self)
		self:SetDrawState( {Mode="DrawMode_Quads"} )
			:LoadTexture( path_to_texture )
			:SetVertices( verts )
			:SetTextureFiltering( false )
	end,
	UpdateAMVCommand=function(self, params)

		local delta = params[1]

		-- each particle is a quadrilateral comprised of four vertices (with a texture applied)
		-- we want to update each of those four vertices for each of the quadrilaterals
		for i=1, num_particles*4, 4 do

			index = math.floor(i/4)+1

			-- update the 4 x coordinates belonging to this particle
			delta_x = velocities[index][1]*delta
			verts[i+0][1][1] = verts[i+0][1][1] + delta_x
			verts[i+1][1][1] = verts[i+1][1][1] + delta_x
			verts[i+2][1][1] = verts[i+2][1][1] + delta_x
			verts[i+3][1][1] = verts[i+3][1][1] + delta_x

			-- update the 4 y coordinates belonging to this particle
			delta_y = velocities[index][2]*delta
			verts[i+0][1][2] = verts[i+0][1][2] + delta_y
			verts[i+1][1][2] = verts[i+1][1][2] + delta_y
			verts[i+2][1][2] = verts[i+2][1][2] + delta_y
			verts[i+3][1][2] = verts[i+3][1][2] + delta_y

			-- if the top of this particular quadrilateral within the AMV has gone off
			-- the bottom of the screen, reset its properties to reuse it
			if (verts[i][1][2] > map_data.height*map_data.tileheight*g.map.zoom+(verts[i+2][1][2]-verts[i+0][1][2])) then
				initialize_particle(i, true)
			end
		end

		self:SetVertices(verts)
	end,
}

return af