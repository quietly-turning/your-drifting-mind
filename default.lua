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
}

local Update = function(self, delta)
	g.map.af:playcommand("UpdateAMV", {delta})
end

local map_data = {}
local maps = { "./map_data/Autumn.lua", "./map_data/Autumn2.lua" }

for i,map in ipairs(maps) do map_data[i] = LoadActor(map) end

local map_af = Def.ActorFrame{
	Name="Map ActorFrame",

	InitCommand=function(self)
		g.map.af = self

		-- uncomment to initialize map to center the player sprite
		-- leave commented to intialize map at 0,0, or specify map starting xy() below
		self:GetChild("Map"..g.CurrentMap).MoveMap(self)

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
		self:stoptweening()
		self:linear(g.SleepDuration)
		-- g.MoveMap(self)
		self:GetChild("Map"..g.CurrentMap).MoveMap(self)
	end,

	-- LoadActor("AMV-Map.lua", {g, map_data}),
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

	-- DialogBox, hidden unless needed
	dialog_box,
}