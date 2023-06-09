-- make an effort to namespace the many things we'll want to be
-- passing around our many files

local g = {}

-- ------------------------------------------------------
-- Stuff related to chart selection / screen reloading

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

local need_to_reload = LoadActor("./ChartReload")
if need_to_reload then
	return Def.Actor {
		OnCommand=function(self)
			if not g.IsEditMode() then SCREENMAN:SetNewScreen('ScreenGameplay') end
		end
	}
end

-- ----------------------------------------
-- Your Drifting Mind
-- ----------------------------------------

g.maps = { "Autumn1", "Winter1", "Winter2", "Winter3", "Winter4", "Winter5", "Blizzard" }
g.CurrentMap = 1
g.collision_layer = {}

g.TimeAtStart = GetTimeSinceStart()

g.InputIsLocked = false
g.SleepDuration = 0.2

g.map = {
	af = nil,
	zoom = 1
}
g.Dialog = {
	Speaker = "Elli"
}

g.SeenEvents = {}
g.Events = {}
g.Player = {}

g.RunTime = function() return GetTimeSinceStart() - g.TimeAtStart end

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
		if g.IsEditMode() then self:hibernate(200); return end

		-- otherwise, redirect input away from ScreenGameplay
		SCREENMAN:set_input_redirected(PLAYER_1, true)
		SCREENMAN:set_input_redirected(PLAYER_2, true)

		-- and hide everything but the SongForeground layer
		for k,v in pairs(screen:GetChildren()) do
			if k ~= "SongForeground" then
				v:visible(false)
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

	-- audio
	LoadActor("./YourDriftingMindAQ.ogg")..{
		OnCommand=function(self)
			if not IsEditMode() then self:sleep(13):queuecommand("PlayAudio") end
		end,
		PlayAudioCommand=function(self) self:play() end
	},

	-- Scenes
	phone,
	parallax_af,
	map_af,
	dialog_box,

	-- Quad used to fade to black while transitioning between maps
	-- it handles more logic than it should because of time constraints :(
	Def.Quad{
		InitCommand=function(self) self:diffuse(0,0,0,1):FullScreen():Center(); g.SceneFade = self end,
		OnCommand=function(self) self:hibernate(13):queuecommand("FadeToClear") end,
		FadeToBlackCommand=function(self)
			g.InputIsLocked = true
			self:smooth(0.5):diffusealpha(1):queuecommand("ChangeMap")
		end,
		FadeToClearCommand=function(self)
			g.InputIsLocked = false
			self:smooth(0.5):diffusealpha(0)
		end,
		ChangeMapCommand=function(self)
			local facing = g.Player[g.CurrentMap].dir
			local map_af = self:GetParent():GetChild("Map ActorFrame")
			local parallax_af = self:GetParent():GetChild("ParallaxAF")
			parallax_af:playcommand("Hide")

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
			-- get a handle to the new parallax bg if it exists
			local parallax_bg = parallax_af:GetChild("Parallax"..g.CurrentMap)
			-- make the new parallax bg visible if it exists
			if parallax_bg then parallax_bg:visible(true) end

			self:queuecommand("FadeToClear")
		end
	},

	-- final fade
	Def.Quad{
		InitCommand=function(self)
			self:diffuse(1,1,1,0):FullScreen():Center()
				:hibernate(GAMESTATE:GetCurrentSong():GetLastSecond() - 45)
				:queuecommand("FadeToWhite")
		end,
		FadeToWhiteCommand=function(self)
			self:linear( GAMESTATE:GetCurrentSong():GetLastSecond() - g.RunTime() ):diffusealpha(1)
		end,
	},
}