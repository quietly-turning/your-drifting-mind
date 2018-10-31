local args = ...
local map = args[1]
local g = args[2]
local _start = { duration = 0, begin_time = 0 }

local InteractionHandler = function()

	-- if handling an event that must be interacted with
	if not g.DialogIsActive then

		local NextTile = g.Player.NextTile[g.Player.dir]()

		if g.Events[NextTile] then
			g.Dialog.ActorFrame:playcommand("UpdateText", {text=g.Events[NextTile]}):playcommand("Show")
			g.DialogIsActive = true
		end

		return false
	end

	-- if already handling dialog...
	if not g.Dialog.IsTweening then
		-- update the dialog index
		-- g.Dialog.Index = SRT.Dialog.Index + 1

		-- then, clear the old text
		g.Dialog.ActorFrame:queuecommand("ClearText")

		-- hide the dialog_box
		g.Dialog.ActorFrame:queuecommand("Hide")

		-- and change the flag
		g.DialogIsActive = false

		-- then, ensure that there is more to load
		-- if g.Dialog.Index <= #g.Dialog.Words then
		-- 	-- if so, display it
		-- 	g.Dialog.Box:queuecommand("UpdateText")
		-- else
			-- otherwise,
			-- g.Dialog.ActorFrame:queuecommand("Hide")
		-- end
	else
		g.Dialog.ActorFrame:finishtweening()
		g.Dialog.IsTweening = false
	end
end

local directional_movement = function(button)
	g.Player.input.Active = button
	g.Player.input[button] = true

	if not g.DialogIsActive then
		-- attempt to tween character
		g.Player.actor:playcommand("AttemptToTween", {dir=button})
	end
end

local FirstPress = {
	Start = function() InteractionHandler() end,

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