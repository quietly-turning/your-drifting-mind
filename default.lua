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
	maps = { "Autumn", "Autumn2" },
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

local Update = function(self, delta)
	g.map.af:playcommand("UpdateAMV", {delta})
end

local map_data = {}

for i,map in ipairs(g.maps) do map_data[i] = LoadActor("./map_data/" .. map .. ".lua") end

local map_af = Def.ActorFrame{
	Name="Map ActorFrame",

	InitCommand=function(self)
		g.map.af = self

		-- uncomment to initialize map to center the player sprite
		-- leave commented to intialize map at 0,0, or specify map starting xy() below
		self:GetChild("Map"..g.CurrentMap):playcommand("MoveMap")

		-- self:xy( 0, -map_data.height*map_data.tileheight )

		self:diffuse(0,0,0,1)
	end,
	OnCommand=function(self)
		-- self:hibernate(13)
		self:GetChild("Map1"):visible(true)
		self:smooth(1.5):diffuse(1,1,1,1)
		-- self:sleep(1):linear(5)
		-- g.MoveMap(self)

		self:queuecommand("Appear")
	end,

	-- UnlockInputCommand=function(self) g.InputIsLocked = false end,
	AppearCommand=function(self)
		local screen = SCREENMAN:GetTopScreen()
		screen:SetUpdateFunction( Update )
		screen:AddInputCallback( LoadActor("InputHandler.lua", {self, g}) )
	end,
	TweenMapCommand=function(self)
		self:stoptweening():linear(g.SleepDuration):GetChild("Map"..g.CurrentMap):playcommand("MoveMap")
	end,
}

for map_index,map in ipairs(map_data) do
	map_af[#map_af+1] = LoadActor("AMV-Map.lua" ,{g, map, map_index})..{ Name="Map"..map_index }
end

-- snowfall actors
for i=1,5 do
	map_af[#map_af+1] = LoadActor("./snow/snow.lua", {g, map_data, i})
end

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
	map_af,

	Def.Quad{
		InitCommand=function(self) self:diffuse(0,0,0,0):FullScreen():Center(); g.SceneFade = self end,
		FadeToBlackCommand=function(self)
			self:smooth(0.5):diffusealpha(1):queuecommand("ChangeMap")
		end,
		FadeToClearCommand=function(self) self:smooth(0.5):diffusealpha(0) end,
		ChangeMapCommand=function(self)
			local facing = g.Player[g.CurrentMap].dir
			local map_af = SCREENMAN:GetTopScreen():GetChild("SongForeground"):GetChild("./default.lua"):GetChild("Map ActorFrame")

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