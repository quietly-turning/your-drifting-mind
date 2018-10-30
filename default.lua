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
local g = {
	SleepDuration = 0.125,
	map_zoom = 1.75,
	Dialog = {
		Speaker = "Her"
	}
}

local Update = function(self, delta)
	g.snowfall:playcommand("Update", {delta})
end

local map_data = LoadActor("./map_data/YourDriftingMind.lua")

local map = Def.ActorFrame{
	Name="Map ActorFrame",

	InitCommand=function(self)
		g.MoveMap(self)
	end,
	OnCommand=function(self)
		local screen = SCREENMAN:GetTopScreen()
		screen:SetUpdateFunction( Update )
		screen:AddInputCallback( LoadActor("InputHandler.lua", {self, g}) )

		g.Dialog.ActorFrame:queuecommand("Show")
	end,
	TweenMapCommand=function(self)
		self:stoptweening()
		self:linear(g.SleepDuration)
		g.MoveMap(self)
	end,


	LoadActor("AMV-Map.lua", {g, map_data}),
	LoadActor("./snow/snow.lua", {g, map_data})
}

local phone = LoadActor("./phone/default.lua")
local dialog_box = LoadActor("./DialogBox/dialog_box.lua", {g})

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

return Def.ActorFrame{
	InitCommand=function(self) end,
	OnCommand=function(self)

		local screen = SCREENMAN:GetTopScreen()

		-- This won't work with ScreenEdit, so don't bother trying.
		if screen:GetName() ~= "ScreenEdit" then

			-- redirect input away from ScreenGameplay
			SCREENMAN:set_input_redirected(PLAYER_1, true)
			SCREENMAN:set_input_redirected(PLAYER_2, true)

			-- hide everything but the SongForeground layer
			for k,v in pairs(screen:GetChildren()) do
				if k ~= "SongForeground" then
					v:visible(false)
				end
			end
		end
	end,
	OffCommand=function(self)
		-- return input handling back to the engine
		SCREENMAN:set_input_redirected(PLAYER_1, false)
		SCREENMAN:set_input_redirected(PLAYER_2, false)
	end,



	-- keep alive Actor
	Def.Actor{ InitCommand=function(self) self:sleep(9999) end },

	-- Scenes
	phone,
	map,

	-- DialogBox, hidden unless needed
	dialog_box,
}