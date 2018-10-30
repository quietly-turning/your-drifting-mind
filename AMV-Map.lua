local args = ...
local g = args[1]
local map_data = args[2]

local map_zoom = 1.75

g.Events = {}

-- returns a table of two values, right and down, both in tile units
local FindCenterOfMap = function()

	-- calculate which tile currently represents the center of what is currently
	-- displayed in the window in terms of tiles right and tiles down from top-left
	local MapCenter = {right=g.Player.pos.x,  down=g.Player.pos.y}

	-- half screen width in tile units
	local half_screen_width_in_tiles  = (_screen.w/(map_data.tilewidth*map_zoom))/2
	-- half screen height in tile units
	local half_screen_height_in_tiles = (_screen.h/(map_data.tileheight*map_zoom))/2

	-- if players are near the edge of a map, using the MapCenter, this will result
	-- in the map scrolling "too far" and the player seeing beyond the edge of the map
	-- clamp the MapCenter values here to prevent this from occuring

	-- left edge of map
	if (MapCenter.right < half_screen_width_in_tiles) then MapCenter.right = half_screen_width_in_tiles end
	-- right edge of map
	if (MapCenter.right > map_data.width - half_screen_width_in_tiles) then MapCenter.right = map_data.width - half_screen_width_in_tiles end
	-- top edge of map
	if (MapCenter.down < half_screen_height_in_tiles) then MapCenter.down = half_screen_height_in_tiles end
	-- bottom edge of map
	if (MapCenter.down > map_data.height - half_screen_height_in_tiles) then MapCenter.down = map_data.height - half_screen_height_in_tiles end

	return MapCenter
end

local GetVerts = function(layer, tileset, tilewidth, tileheight, mapwidth, mapheight)

	local rows = tileset.imageheight/tileset.tileheight

	-- vert data for a single AMV, where 1 tilelayer = 1 AMV
	local verts = {}

	-- color, to be reused
	local c = {1,1,1,1}

	for i=0,#layer.data-1 do

		local tile_id = layer.data[i+1]-1

		if (tile_id ~= -1) then
			-- position
			local p = {
				-- x, y, z
				{ (i%mapwidth)*tilewidth,			math.floor(i/mapwidth)*tileheight, 				1 },
				{ (i%mapwidth)*tilewidth+tilewidth, math.floor(i/mapwidth)*tileheight, 				1 },
				{ (i%mapwidth)*tilewidth+tilewidth, math.floor(i/mapwidth)*tileheight+tileheight,	1 },
				{ (i%mapwidth)*tilewidth, 			math.floor(i/mapwidth)*tileheight+tileheight, 	1 }
			}

			-- texture coordinates
			local t = {
				-- tx, ty
				{scale(((tile_id%tileset.columns)+0)*tilewidth, 0, tileset.imagewidth, 0, 1),	scale((math.floor(tile_id/tileset.columns)+0)*tileheight, 0, tileset.imageheight, 0, 1) },
				{scale(((tile_id%tileset.columns)+1)*tilewidth, 0, tileset.imagewidth, 0, 1),	scale((math.floor(tile_id/tileset.columns)+0)*tileheight, 0, tileset.imageheight, 0, 1) },
				{scale(((tile_id%tileset.columns)+1)*tilewidth, 0, tileset.imagewidth, 0, 1),	scale((math.floor(tile_id/tileset.columns)+1)*tileheight, 0, tileset.imageheight, 0, 1) },
				{scale(((tile_id%tileset.columns)+0)*tilewidth, 0, tileset.imagewidth, 0, 1),	scale((math.floor(tile_id/tileset.columns)+1)*tileheight, 0, tileset.imageheight, 0, 1) },
			}

			table.insert(verts, {p[1], c, t[1]})
			table.insert(verts, {p[2], c, t[2]})
			table.insert(verts, {p[3], c, t[3]})
			table.insert(verts, {p[4], c, t[4]})
		end
	end

	return verts
end

g.MoveMap = function(self)
	local MapCenter = FindCenterOfMap()
	self:x(-(MapCenter.right * map_data.tilewidth * map_zoom - _screen.w/2))
	self:y(-(MapCenter.down * map_data.tileheight * map_zoom - _screen.h/2))
end

-- -----------------------------------------------------------------------

local af = Def.ActorFrame{ Name="Visuals" }

-- zoom the map and the player (but not the snow) some amount
af.InitCommand=function(self)
	self:zoom(map_zoom)
end

local path_to_texture = GAMESTATE:GetCurrentSong():GetSongDir() .. "map_data/" .. map_data.tilesets[1].image

for layer_name in ivalues({"Under", "Player", "Over", "Events"}) do
	for layer_data in ivalues(map_data.layers) do
		if layer_data.name == layer_name then

			if layer_name == "Under" or layer_name == "Over" then

				local verts = GetVerts(layer_data, map_data.tilesets[1], map_data.tilewidth, map_data.tileheight, map_data.width, map_data.height)

				-- an AMV for this layer in the map
				af[#af+1] = Def.ActorMultiVertex{
					InitCommand=function(self)
						self:SetDrawState( {Mode="DrawMode_Quads"} )
							:LoadTexture( path_to_texture )
							:SetVertices( verts )
							:SetTextureFiltering( false )
					end
				}


			elseif layer_name == "Player" then

				af[#af+1] = LoadActor("./Player/player_sprite.lua", {g, map_data, layer_data})

			elseif layer_data == "Events" then

				for event in ivalues(layer_data) do

				end
			end
		end
	end
end

return af