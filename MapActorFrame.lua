local args = ...
local g = args[1]
local map_data = args[2]

local Update = function(self, delta)
	g.map.af:playcommand("UpdateAMV", {delta})
end

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

return map_af