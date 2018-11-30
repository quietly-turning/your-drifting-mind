-- ------------------------------------------------------
-- Stuff related to chart selection

-- Check if we're in EditMode by getting the class of the current screen.
-- We could check the current screen's name, but it's possible for a theme
-- to rename screens as it sees fit.

local IsEditMode = function()
	local screen = SCREENMAN:GetTopScreen()
	if not screen then
		SCREENMAN:SystemMessage("IsEditMode() check failed to run because there is no Screen yet.")
		return nil
	end

	return (THEME:GetMetric(screen:GetName(), "Class") == "ScreenEdit")
end

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
				if not IsEditMode() then SCREENMAN:SetNewScreen('ScreenGameplay') end
			end
		}
	else
		return Def.Actor{}
	end
end

-- ------------------------------------------------------
local g = {
	maps = { "Winter1", "Winter2", "Winter3" },
	CurrentMap = 1,
	collision_layer = {},

	SleepDuration = 0.2,
	-- InputIsLocked = true,
	map = {
		af = nil,
		zoom = 1
	},
	Dialog = {
		Speaker = "Elli"
	},

	Events = {},
	Player = {}
}

local map_data = {}
for i,map in ipairs(g.maps) do map_data[i] = LoadActor("./map_data/" .. map .. ".lua") end

local parallax_af = LoadActor("./ParallaxBackground.lua", map_data)
local map_af = LoadActor("./MapActorFrame.lua", {g, map_data})
local phone = LoadActor("./phone/phone.lua")
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
	-- phone,
	parallax_af,
	map_af,

	Def.Quad{
		InitCommand=function(self) self:diffuse(0,0,0,1):FullScreen():Center(); g.SceneFade = self end,
		OnCommand=function(self) self:queuecommand("FadeToClear") end,
		FadeToBlackCommand=function(self)
			self:smooth(0.5):diffusealpha(1):queuecommand("ChangeMap")
		end,
		FadeToClearCommand=function(self) self:smooth(0.5):diffusealpha(0) end,
		ChangeMapCommand=function(self)
			local facing = g.Player[g.CurrentMap].dir
			local map_af = self:GetParent():GetChild("Map ActorFrame")

			-- don't draw the old map
			map_af:GetChild("Map"..g.CurrentMap):visible(false)
			-- update CurrentMap index
			g.CurrentMap = g.next_map.index

			-- maintain the direction the player was last facing when transferring maps
			g.Player[g.CurrentMap].dir = facing
			-- call InitCommand on the player Sprite for this map, passing in starting position data specified in Tiled
			g.Player[g.CurrentMap].actor:playcommand("Init", {x=g.next_map.x, y=g.next_map.y} )
			-- reset this (just in case?)
			g.next_map = nil
			-- start drawing the new map and update its position if needed
			map_af:GetChild("Map"..g.CurrentMap):visible(true):playcommand("MoveMap")

			self:queuecommand("FadeToClear")
		end
	},

	-- DialogBox, hidden unless needed
	dialog_box,
}