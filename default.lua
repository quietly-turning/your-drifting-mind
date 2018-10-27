-- ------------------------------------------------------
-- Stuff related to chart selection

-- if both players are joined
if #GAMESTATE:GetHumanPlayers() > 1 then

	local all_steps = GAMESTATE:GetCurrentSong():GetStepsByStepsType( "StepsType_Dance_Single" )
	local reload_necessary = false

	for player in ivalues(GAMESTATE:GetHumanPlayers()) do
		if GAMESTATE:GetCurrentSteps(player):GetDifficulty() ~= "Difficulty_Challenge" then
			GAMESTATE:SetCurrentSteps(player, steps[2])
			reload_necessary = true
		end
	end

	if reload_necessary then
		return Def.Actor {
			OnCommand=function(self)
				if SCREENMAN:GetTopScreen():GetName() ~= "ScreenEdit" then
					SCREENMAN:SetNewScreen('ScreenGameplay')
				end
			end
		}
	else
		return Def.Actor{}
	end
end

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

local g = {}
local map_data = LoadActor("./map_data/YourDriftingMind.lua")
local amv_map = LoadActor("AMV-Map.lua", {g, map_data})


-- local start_time = GetTimeSinceStart()

local Update = function(self, delta)
	-- g.Player.actor:playcommand("Update", {delta})
	g.snowfall:playcommand("Update", {delta})
end

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

return Def.ActorFrame{
	InitCommand=function(self) end,
	OnCommand=function(self)

		local screen = SCREENMAN:GetTopScreen()

		-- This won't work with ScreenEdit, so don't bother trying.
		if screen:GetName() ~= "ScreenEdit" then

			-- hide everything but the SongForeground layer
			for k,v in pairs(screen:GetChildren()) do
				if k ~= "SongForeground" then
					v:visible(false)
				end
			end

			screen:SetUpdateFunction( Update )
			screen:AddInputCallback( LoadActor("InputHandler.lua", {self, g}) )
		end
	end,

	-- keep alive Actor
	Def.Actor{ InitCommand=function(self) self:sleep(9999) end },
	-- AMVs to draw
	amv_map,

	LoadActor("./snow.lua", g)
}