local args = ...
local g = args[1]
local map_data = args[2]
local layer_data = args[3]
local layer_index = args[4]

local SleepDuration = g.SleepDuration

g.Player = {
	file = "Elli 4x4 (doubleres).png",
	dir = "Down",
	tweening = false,

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

	NextTile = {
		Up=function() return (g.Player.pos.y-1) * map_data.width + g.Player.pos.x + 1 end,
		Down=function() return (g.Player.pos.y+1) * map_data.width + g.Player.pos.x + 1 end,
		Left=function() return g.Player.pos.y * map_data.width + g.Player.pos.x end,
		Right=function() return g.Player.pos.y * map_data.width + g.Player.pos.x + 2 end
	}
}


local WillBeOffMap = {
	Up=function() return g.Player.pos.y < 1 end,
	Down=function() return g.Player.pos.y > map_data.height-2 end,
	Left=function() return g.Player.pos.x < 1 end,
	Right=function() return g.Player.pos.x > map_data.width-2 end
}

local UpdatePosition = function()

	-- set the player sprite's current tile to "not collidable"
	-- we are about to update the player sprite's position
	-- g.TileData.CollisionTiles[g.Player.pos.y * g.TileData.Width.Tiles + g.Player.pos.x + 1] = 0

	-- Increment/Decrement the value as needed first
	if g.Player.dir == "Up" then
		g.Player.pos.y = g.Player.pos.y - 1

	elseif g.Player.dir == "Down" then
		g.Player.pos.y = g.Player.pos.y + 1

	elseif g.Player.dir == "Left" then
		g.Player.pos.x = g.Player.pos.x - 1

	elseif g.Player.dir == "Right" then
		g.Player.pos.x = g.Player.pos.x + 1
	end

	-- set the current tile to collidable
	-- g.TileData.CollisionTiles[g.Player.pos.y * g.TileData.Width.Tiles + g.Player.pos.x + 1] = 1
end


local WillCollide = function()
	local next_tile = g.Player.NextTile[g.Player.dir]()

	if next_tile then
		if g.collision_layer.data[ next_tile ] ~= 0 then
			return true
		else
			-- TouchHandler( g.Player.NextTile )
			return false
		end
	end

	return false
end


local frames = {
	Down = {
		{ Frame=1,	Delay=SleepDuration/1.5},
		{ Frame=2,	Delay=SleepDuration/1.5},
		{ Frame=3,	Delay=SleepDuration/1.5},
		{ Frame=0,	Delay=SleepDuration/1.5}
	},
	Left = {
		{ Frame=5,	Delay=SleepDuration/1.5},
		{ Frame=6,	Delay=SleepDuration/1.5},
		{ Frame=7,	Delay=SleepDuration/1.5},
		{ Frame=4,	Delay=SleepDuration/1.5}
	},
	Right = {
		{ Frame=9,	Delay=SleepDuration/1.5},
		{ Frame=10,	Delay=SleepDuration/1.5},
		{ Frame=11,	Delay=SleepDuration/1.5},
		{ Frame=8,	Delay=SleepDuration/1.5}
	},
	Up = {
		{ Frame=13,	Delay=SleepDuration/1.5},
		{ Frame=14,	Delay=SleepDuration/1.5},
		{ Frame=15,	Delay=SleepDuration/1.5},
		{ Frame=12,	Delay=SleepDuration/1.5}
	}
}

-- a sprite for the player
return LoadActor( "./" .. g.Player.file )..{
	InitCommand=function(self)

		g.Player.actor = self

		g.Player.pos = g.Player.pos or {
			x = layer_data.objects[1].x/map_data.tilewidth,
			y = layer_data.objects[1].y/map_data.tileheight,
		}

		g.Player.dir = "Down"

		self:animate(false)
		-- align to left and v-middle
			:align(0, 0.5)
		-- initialize the position
			:xy(layer_data.objects[1].x, layer_data.objects[1].y)
			:z( layer_index )
		-- initialize the sprite state
			:SetStateProperties( frames[g.Player.dir] )
			:setstate(1)
			:SetTextureFiltering(false)
			:zoom(0.9)
	end,
	UpdateSpriteFramesCommand=function(self)
		if g.Player.dir then
			self:SetStateProperties( frames[g.Player.dir] )
		end
	end,
	AnimationOnCommand=function(self)
		self:animate(true)
	end,
	AnimationOffCommand=function(self)
		self:animate(false):setstate(1)
	end,
	TweenCommand=function(self)


		-- collision check the impending tile
		if not WillCollide() and not WillBeOffMap[g.Player.dir]() then

			-- this does a good job of mitigating tween overflows resulting from button mashing
			-- self:stoptweening()
			g.Player.tweening = true

			-- we *probably* want to update the player's map position
			-- UpdatePosition() does just that, if we should
			UpdatePosition()

			-- tween the map
			SCREENMAN:GetTopScreen():GetChild("SongForeground"):GetChild("./default.lua"):GetChild("Map ActorFrame"):playcommand("TweenMap")

			self:playcommand("AnimationOn")
				:linear(SleepDuration)
				:x(g.Player.pos.x * map_data.tilewidth)
				:y(g.Player.pos.y * map_data.tileheight)

			self:queuecommand("MaybeTweenAgain")
		end
	end,
	MaybeTweenAgainCommand=function(self)
		g.Player.tweening = false

		if g.Player.dir and g.Player.input[ g.Player.dir ] then
			self:playcommand("Tween")
		else
			self:stoptweening():queuecommand("AnimationOff")
		end
	end,
	AttemptToTweenCommand=function(self, params)

		-- Does the player sprite's current direction match the direction
		-- we were just passed from the input handler?
		if g.Player.dir ~= params.dir then

			-- if not, update it
			g.Player.dir = params.dir
			-- and update the sprite's frames appropriately
			self:playcommand("UpdateSpriteFrames")
		end

		-- don't allow us to go off the map
		if g.Player.dir and g.Player.input[ g.Player.dir ] and not g.Player.tweening then

			self:playcommand("AnimationOn")

			-- tween the player sprite
			self:playcommand("Tween")
		end
	end
}