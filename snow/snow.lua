local g = ...

-- variables you might want to configure to your liking
local num_particles = 1000
-- particle size in pixels
local min_size = 10
local max_size = 22
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
local amv
local delta_x, delta_y

-- initialize the verts table
for i=1, num_particles do
	size = math.random(min_size, max_size)
	x = math.random(_screen.w + size*2)
	y = math.random(_screen.h + size*2)
	velocities[i] = {math.random(min_vx,max_vx), math.random(min_vy,max_vy)}
	alpha = math.random(6, 10)/10

	table.insert( verts, {{x-size, y-size, 0}, {1,1,1,alpha}, {0,0} } )
	table.insert( verts, {{x, y-size, 0}, {1,1,1,alpha}, {1,0} } )
	table.insert( verts, {{x, y, 0}, {1,1,1,alpha}, {1,1} } )
	table.insert( verts, {{x-size, y, 0}, {1,1,1,alpha}, {0,1} } )
end


return Def.ActorMultiVertex{
	InitCommand=function(self)
		self:SetDrawState( {Mode="DrawMode_Quads"} )
			:LoadTexture( path_to_texture )
			:SetVertices( verts )
			:SetTextureFiltering( false )
		amv = self
		g.snowfall = self
	end,
	UpdateCommand=function(self, params)
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
			if (verts[i+0][1][2] > _screen.h+(verts[i+2][1][2]-verts[i+0][1][2])) then
				-- re-randomize velocities as {vx, vy}
				velocities[index] = {math.random(min_vx,max_vx), math.random(min_vy,max_vy)}
				-- re-randomize particle size
				size = math.random(min_size, max_size)
				-- re-randomize starting x position
				x = math.random(_screen.w + size*2)
				-- reset starting y position to be just above the top of the screen
				verts[i+0][1] = {x-size, -size, 0}
				verts[i+1][1] = {x, -size, 0}
				verts[i+2][1] = {x, 0, 0}
				verts[i+3][1] = {x-size, 0, 0}
			end
		end

		self:SetVertices(verts)
	end
}

-- return af