local args = ...
local g = args[1]
local map_data = args[2]

local num_times = 0


local UpdatePosition = function()

	-- set the player sprite's current tile to "not collidable"
	-- we are about to update the player sprite's position
	-- g.TileData.CollisionTiles[g.Player.pos.y * g.TileData.Width.Tiles + g.Player.pos.x + 1] = 0

	-- Increment/Decrement the value as needed first
	if g.Player.dir == "Up" then
		g.Player.pos.y = g.Player.pos.y - 1

	elseif g.Player.dir == "Down" then
		g.Player.pos.y = g.Player.pos.y + 1

	elseif g.Player.dir == "Left" then
		g.Player.pos.x = g.Player.pos.x - 1

	elseif g.Player.dir == "Right" then
		g.Player.pos.x = g.Player.pos.x + 1
	end

	-- update this sprite's z value based on its down value
	g.Player.pos.z = map_data.height - g.Player.pos.y

	-- set the current tile to collidable
	-- g.TileData.CollisionTiles[g.Player.pos.y * g.TileData.Width.Tiles + g.Player.pos.x + 1] = 1
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

local af = Def.ActorFrame{}

for layer_name in ivalues({"Under", "Player", "Over"}) do
	for layer_data in ivalues(map_data.layers) do
		if layer_data.name == layer_name then

			if layer_name == "Under" or layer_name == "Over" then
				local path_to_texture = GAMESTATE:GetCurrentSong():GetSongDir() .. "data/" .. map_data.tilesets[1].image
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

				-- a sprite for the player
				af[#af+1] = LoadActor("./data/Reen 4x4.png")..{
					InitCommand=function(self)

						g.Player.actor = self

						g.Player.pos = g.Player.pos or {}
						g.Player.pos.x = layer_data.objects[1].x/map_data.tilewidth
						g.Player.pos.y = layer_data.objects[1].y/map_data.tileheight

						g.Player.dir = "Down"

						self:animate(0)
						-- align to left and v-middle
							:align(0, 0.5)

						-- initialize the position
							:xy(g.Player.pos.x*map_data.tilewidth, g.Player.pos.y*map_data.tileheight)

						-- initialize the sprite state
							:SetStateProperties( frames[g.Player.dir] )
					end,
					UpdateSpriteFramesCommand=function(self)
						self:SetStateProperties( frames[g.Player.dir] )
					end,
					AnimationOnCommand=cmd(animate,1),
					AnimationOffCommand=cmd(animate, 0; setstate, 0),
					TweenCommand=function(self)

						-- this does a good job of mitigating tween overflows resulting from button mashing
						self:stoptweening()

						if g.Player.dir and g.Player.input[ g.Player.dir ] then

							self:linear(SleepDuration)
							self:x(g.Player.pos.x * map_data.tilewidth)
							self:y(g.Player.pos.y * map_data.tileheight)

							-- SM( g.Player.pos.x .. " " .. g.Player.pos.y )
							self:z( -g.Player.pos.z )
						end
					end,

					AttemptToTweenCommand=function(self, params)

						self:playcommand("AnimationOn")

						-- Does the player sprite's current direction match the direction
						-- we were just passed from the input handler?
						if g.Player.dir ~= params.dir then

							-- if not, update it
							g.Player.dir = params.dir
							-- and update the sprite's frames appropriately
							self:playcommand("UpdateSpriteFrames")
						end



						-- collision check the impending tile
						-- if not SRT.Collisions or not WillCollide() then

							-- don't allow us to go off the map
							-- if not WillBeOffMap() then

								-- we *probably* want to update the player's map position
								-- UpdatePosition() does just that, if we should
								UpdatePosition()

								-- tween the player sprite
								self:playcommand("Tween")
							-- end
						-- end
					end
				}
			end
		end
	end
end

return af