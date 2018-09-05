local args = ...
local g = args[1]
local map_data = args[2]
local layer_data = args[3]

local SleepDuration = 0.125

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

	-- update this sprite's z value based on its down value
	g.Player.pos.z = map_data.height - g.Player.pos.y

	-- set the current tile to collidable
	-- g.TileData.CollisionTiles[g.Player.pos.y * g.TileData.Width.Tiles + g.Player.pos.x + 1] = 1
end

local frames = {
	Down = {
		{ Frame=0,	Delay=SleepDuration},
		{ Frame=1,	Delay=SleepDuration},
		{ Frame=2,	Delay=SleepDuration},
		{ Frame=3,	Delay=SleepDuration}
	},
	Left = {
		{ Frame=4,	Delay=SleepDuration},
		{ Frame=5,	Delay=SleepDuration},
		{ Frame=6,	Delay=SleepDuration},
		{ Frame=7,	Delay=SleepDuration}
	},
	Right = {
		{ Frame=8,	Delay=SleepDuration},
		{ Frame=9,	Delay=SleepDuration},
		{ Frame=10,	Delay=SleepDuration},
		{ Frame=11,	Delay=SleepDuration}
	},
	Up = {
		{ Frame=12,	Delay=SleepDuration},
		{ Frame=13,	Delay=SleepDuration},
		{ Frame=14,	Delay=SleepDuration},
		{ Frame=15,	Delay=SleepDuration}
	}
}

-- a sprite for the player
return LoadActor("./data/Reen 4x4.png")..{
	InitCommand=function(self)

		g.Player.actor = self

		g.Player.pos = g.Player.pos or {}
		g.Player.pos.x = layer_data.objects[1].x/map_data.tilewidth
		g.Player.pos.y = layer_data.objects[1].y/map_data.tileheight

		g.Player.dir = "Down"

		self:animate(0)
		-- align to left and v-middle
			:align(0, 0.5)

		-- initialize the position
			:xy(g.Player.pos.x*map_data.tilewidth, g.Player.pos.y*map_data.tileheight)

		-- initialize the sprite state
			:SetStateProperties( frames[g.Player.dir] )
	end,
	UpdateSpriteFramesCommand=function(self)
		self:SetStateProperties( frames[g.Player.dir] )
	end,
	AnimationOnCommand=cmd(animate,1),
	AnimationOffCommand=cmd(animate, 0; setstate, 0),
	TweenCommand=function(self)

		-- this does a good job of mitigating tween overflows resulting from button mashing
		self:stoptweening()

		if g.Player.dir and g.Player.input[ g.Player.dir ] then

			self:linear(SleepDuration)
			self:x(g.Player.pos.x * map_data.tilewidth)
			self:y(g.Player.pos.y * map_data.tileheight)

			-- SM( g.Player.pos.x .. " " .. g.Player.pos.y )
			self:z( -g.Player.pos.z )
		end
	end,

	AttemptToTweenCommand=function(self, params)

		self:playcommand("AnimationOn")

		-- Does the player sprite's current direction match the direction
		-- we were just passed from the input handler?
		if g.Player.dir ~= params.dir then

			-- if not, update it
			g.Player.dir = params.dir
			-- and update the sprite's frames appropriately
			self:playcommand("UpdateSpriteFrames")
		end



		-- collision check the impending tile
		-- if not SRT.Collisions or not WillCollide() then

			-- don't allow us to go off the map
			-- if not WillBeOffMap() then

				-- we *probably* want to update the player's map position
				-- UpdatePosition() does just that, if we should
				UpdatePosition()

				-- tween the player sprite
				self:playcommand("Tween")
			-- end
		-- end
	end
}