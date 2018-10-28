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
local Update = function(self, delta)
	-- g.Player.actor:playcommand("Update", {delta})
	g.snowfall:playcommand("Update", {delta})
end

local map_data = LoadActor("./map_data/YourDriftingMind.lua")

local map = Def.ActorFrame{
	Name="Map ActorFrame",

	-- InitCommand=function(self) self:diffuse(0,0,0,1) end,
	-- OnCommand=function(self)
	-- 	self:hibernate(13):queuecommand("Appear")
	-- 	self:smooth(1):diffuse(1,1,1,1)
	-- end,
	-- AppearCommand=function(self)
	OnCommand=function(self)
		local screen = SCREENMAN:GetTopScreen()
		screen:SetUpdateFunction( Update )
		screen:AddInputCallback( LoadActor("InputHandler.lua", {self, g}) )
	end,

	LoadActor("AMV-Map.lua", {g, map_data}),
	LoadActor("./snow/snow.lua", g)
}

local phone = LoadActor("./phone/default.lua")


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
		end
	end,

	-- keep alive Actor
	Def.Actor{ InitCommand=function(self) self:sleep(9999) end },

	-- Scenes
	-- phone,
	map
}