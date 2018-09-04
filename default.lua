-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
local g = {
	Player = {
		file = "Reen 4x4.png",
		dir = "Down",
		input = {
			Active = nil,
			Up = false,
			Down = false,
			Left = false,
			Right = false,
			MenuRight = false,
			MenuLeft = false,
			Start = false,
			Select = false
		},
	},

}
local map_data = LoadActor("./data/YourDriftingMind.lua")
local amv_af = LoadActor("AMV-Map.lua", {g, map_data})
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

return Def.ActorFrame{
	InitCommand=function(self) end,
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

			screen:AddInputCallback( LoadActor("InputHandler.lua", {self, g}) )
		end
	end,
	OffCommand=function(self)
		local screen = SCREENMAN:GetTopScreen()

		-- This won't work with ScreenEdit, so don't bother trying.
		if screen:GetName() ~= "ScreenEdit" then
			screen:PauseGame(false)
		end
	end,

	-- keep alive Actor
	Def.Actor{ InitCommand=function(self) self:sleep(9999) end },

	-- AMVs to draw
	amv_af,
}