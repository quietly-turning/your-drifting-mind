-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- FUNCTIONS
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

-- not used, currently
-- local PreprocessMapData = function(map_data)
-- 	local num_under, num_over, num_object, num_collision = 0,0,0,0
-- 	local unsupported_layers = {}
--
-- 	for i, layer in ipairs(map_data.layers) do
--
-- 		if layer.type == "tilelayer" then
-- 			if layer.name == "Under" then
-- 				num_under = num_under + 1
--
-- 			elseif layer.name == "Over" then
-- 				num_over = num_over + 1
--
-- 			elseif layer.name == "Collision" then
-- 				num_collision = num_collision + 1
-- 			else
-- 				table.insert(unsupported_layers, layer)
-- 			end
--
-- 		elseif layer.type == "objectgroup" then
-- 			num_object = num_object + 1
-- 		else
-- 			table.insert(unsupported_layers, layer)
-- 		end
-- 	end
--
-- 	return {under=num_under, over=num_over, object=num_object, collision=num_collision}
-- end

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

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- VARIABLES
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

-- map data
local map_data = LoadActor("./data/YourDriftingMind.lua")
-- local num_layers = PreprocessMapData(map_data)


local amv_af = Def.ActorFrame{}

for layer_name in ivalues({"Under", "Player", "Over"}) do
	for layer_data in ivalues(map_data.layers) do
		if layer_data.name == layer_name then

			if layer_name == "Under" or layer_name == "Over" then
				local path_to_texture = GAMESTATE:GetCurrentSong():GetSongDir() .. "data/" .. map_data.tilesets[1].image
				local verts = GetVerts(layer_data, map_data.tilesets[1], map_data.tilewidth, map_data.tileheight, map_data.width, map_data.height)

				amv_af[#amv_af+1] = Def.ActorMultiVertex{
					InitCommand=function(self)
						self:SetDrawState( {Mode="DrawMode_Quads"} )
							:LoadTexture( path_to_texture )
							:SetVertices( verts )
							:SetTextureFiltering( false )
					end
				}
			elseif layer_name == "Player" then

				local SleepDuration = 0.125
				local frames = {
					Down = {
						{ Frame=0,	Delay=SleepDuration},
						{ Frame=1,	Delay=SleepDuration},
						{ Frame=2,	Delay=SleepDuration},
						{ Frame=3,	Delay=SleepDuration}
					},
					Left = {
						{ Frame=4,	Delay=SleepDuration},
						{ Frame=5,	Delay=SleepDuration},
						{ Frame=6,	Delay=SleepDuration},
						{ Frame=7,	Delay=SleepDuration}
					},
					Right = {
						{ Frame=8,	Delay=SleepDuration},
						{ Frame=9,	Delay=SleepDuration},
						{ Frame=10,	Delay=SleepDuration},
						{ Frame=11,	Delay=SleepDuration}
					},
					Up = {
						{ Frame=12,	Delay=SleepDuration},
						{ Frame=13,	Delay=SleepDuration},
						{ Frame=14,	Delay=SleepDuration},
						{ Frame=15,	Delay=SleepDuration}
					}
				}


				amv_af[#amv_af+1] = LoadActor("./data/Reen 4x4.png")..{
					InitCommand=function(self)
						self:animate(0)
						-- align to left and v-middle
							:align(0, 0.5)

						-- initialize the position
							:xy(layer_data.objects[1].x, layer_data.objects[1].y)

						-- initialize the sprite state
						self:SetStateProperties( frames.Down )

						-- mark the MapData where the player is standing as collidable
						-- SRT.TileData.CollisionTiles[SRT.Player.pos.d * SRT.TileData.Width.Tiles + SRT.Player.pos.r + 1] = 1
					end
				}
			end
		end
	end
end

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

local main_af = Def.ActorFrame{
	InitCommand=function(self)
		-- af = self
	end,
	OnCommand=function(self)
		local screen = SCREENMAN:GetTopScreen()

		-- This won't work with ScreenEdit, so don't bother trying.
		if screen:GetName() ~= "ScreenEdit" then
			screen:PauseGame(true)

			-- hide everything but the SongForeground layer
			for k,v in pairs(screen:GetChildren()) do
				if k ~= "SongForeground" then
					v:hibernate(math.huge)
				end
			end
		end
	end,
	OffCommand=function(self)
		local screen = SCREENMAN:GetTopScreen()

		-- This won't work with ScreenEdit, so don't bother trying.
		if screen:GetName() ~= "ScreenEdit" then
			screen:PauseGame(false)
		end
	end,

	-- keep alive
	Def.Actor{ InitCommand=function(self) self:sleep(9999) end },

	amv_af,
}



return main_af