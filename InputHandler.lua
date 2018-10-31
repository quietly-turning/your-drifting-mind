local args = ...
local map = args[1]
local g = args[2]
local _start = { duration = 0, begin_time = 0 }

local InteractionHandler = function()

	-- if handling an event that must be interacted with
	if not SRT.InputIsLocked then

		local NextTile
		if SRT.Player.dir == "Right" then
			NextTile = SRT.Player.pos.d * SRT.TileData.Width.Tiles +  SRT.Player.pos.r + 2
		elseif SRT.Player.dir == "Left" then
			NextTile = SRT.Player.pos.d * SRT.TileData.Width.Tiles +  SRT.Player.pos.r
		elseif SRT.Player.dir == "Up" then
			NextTile = (SRT.Player.pos.d-1) * SRT.TileData.Width.Tiles +  SRT.Player.pos.r + 1
		elseif SRT.Player.dir == "Down" then
			NextTile = (SRT.Player.pos.d+1) * SRT.TileData.Width.Tiles +  SRT.Player.pos.r + 1
		end

		for i, event in ipairs(SRT.EventData) do

			local tile = ((event.Tile.d) * SRT.TileData.Width.Tiles) + event.Tile.r+1

			if tile == NextTile  and event.Trigger == "PlayerInteraction" then
				SRT.EventActors[i]:queuecommand("TurnToFacePlayer")
				event.Action()
				return false
			end
		end
		return false
	end

	-- if already handling dialog...
	if SRT.InputIsLocked and SRT.DialogIsActive then

		if not SRT.Dialog.IsTweening then
			-- update the dialog index
			SRT.Dialog.Index = SRT.Dialog.Index + 1

			-- then, clear the old text
			SRT.Dialog.Box:queuecommand("ClearText")

			-- then, ensure that there is more to load
			if SRT.Dialog.Index <= #SRT.Dialog.Words then
				-- if so, display it
				SRT.Dialog.Box:queuecommand("UpdateText")
			else
				-- otherwise, transition the screen
				SRT.Dialog.Box:queuecommand("Hide")
			end
		else
			SRT.Dialog.Box:GetChild("Text"):finishtweening()
			SRT.Dialog.IsTweening = false
		end
	end
end

local directional_movement = function(button)
	g.Player.input.Active = button
	g.Player.input[button] = true

	if not g.InputIsLocked then
		-- attempt to tween character
		g.Player.actor:playcommand("AttemptToTween", {dir=button})
	end
end

local FirstPress = {
	-- Start = function() InteractionHandler() end,

	MenuRight = function() end,
	MenuLeft = function() end,

	Up = function() directional_movement("Up") end,
	Down = function() directional_movement("Down") end,
	Left = function() directional_movement("Left") end,
	Right = function() directional_movement("Right") end,
}

local InputHandler = function(event)

	-- if any of these, don't attempt to handle input
	if not event.PlayerNumber or not event.button then return false end

	----------------------------------------------------------------------------
	-- DEVELOPER & DEBUG STUFF

	-- quick hack to get out by pressing escape
	if  (event.DeviceInput.button == "DeviceButton_escape") then
		-- return input handling back to the engine
		SCREENMAN:set_input_redirected(PLAYER_1, false)
		SCREENMAN:set_input_redirected(PLAYER_2, false)
		-- back out of ScreenGameplay
		SCREENMAN:GetTopScreen():begin_backing_out()
		return
	end

	-- get out by holding START for longer than 3 seconds
	if event.button == "Start" then
		if event.type == "InputEventType_FirstPress" then
			_start.begin_time = GetTimeSinceStart()

		elseif event.type == "InputEventType_Repeat" then
			_start.duration = GetTimeSinceStart() - _start.begin_time

		else
			_start.duration = 0
			_start.begin_time = 0
		end

		if _start.duration > 1 then
			SCREENMAN:SystemMessage("Continue holding &START; to exit.")
		end

		if _start.duration > 3 then
			-- return input handling back to the engine
			SCREENMAN:set_input_redirected(PLAYER_1, false)
			SCREENMAN:set_input_redirected(PLAYER_2, false)
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_DoNextScreen")
		end
	end

	----------------------------------------------------------------------------

	if event.type == "InputEventType_FirstPress" then

		-- if the FirstPress table has a function to react to whichever
		-- button was just pressed, then call that function
		if FirstPress[event.button] then FirstPress[event.button]() end

	elseif event.type == "InputEventType_Release" then

		-- if the button just released was the most recently active button, then no button is being held
		if event.button == g.Player.input.Active then
			-- so mark the Active field as nil
			g.Player.input.Active = nil
			-- and inform the player sprite to stop animating
			g.Player.actor:queuecommand("AnimationOff")
		end

		-- either way, this button has been released, so mark it as false
		g.Player.input[event.button] = false
	end

	return false
end

return InputHandler