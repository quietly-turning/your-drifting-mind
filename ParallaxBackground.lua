local map_data = ...
local song_dir = GAMESTATE:GetCurrentSong():GetSongDir()

local af = Def.ActorFrame{}

for map_index,map in ipairs(map_data) do
	for layer_index,layer in ipairs(map.layers) do
		if layer.name == "Texture" then
			local obj = layer.objects[1]

			if obj.properties.Parallax then

				af[#af+1] = Def.Sprite{
					Name="Parallax"..map_index,
					Texture=song_dir..obj.properties.Texture,
					InitCommand=function(self)
						self:customtexturerect(0,0,1,1)
							:texcoordvelocity(obj.properties.vx or 0,obj.properties.vy or 0)
							:diffusealpha(obj.properties.alpha or 1)
							:xy(obj.x, obj.y)
							:z(layer_index)
							:align(0,0)
							:zoomto( _screen.w, _screen.h )

					end
				}
			end
		end
	end
end

return af