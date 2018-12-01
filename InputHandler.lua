local args = ...
local map_data = args[1]
local g = args[2]
local _start = { duration = 0, begin_time = 0 }

local FindInTable = function(needle, haystack)
	for i,v in ipairs(haystack) do
		if v == needle then return i end
	end
	return nil
end

local PlayerIsFacingDirectionToTransfer = {
	Left = function(next_tile)
		return next_tile % map_data[g.CurrentMap].width == 1
	end,
	Right = function(next_tile)
		return next_tile % map_data[g.CurrentMap].width == 0
	end,
	Up = function(next_tile)
		return next_tile <= map_data[g.CurrentMap].width
	end,
	Down = function(next_tile)
		return next_tile > (map_data[g.CurrentMap].width * map_data[g.CurrentMap].height - map_data[g.CurrentMap].width)
	end,
}

g.TouchHandler = function(next_tile)
	local event = g.Events[g.CurrentMap][next_tile]

	if event and event.type == "Touch" and event.properties then
		-- handle the event
		if event.properties.TransferPlayer and PlayerIsFacingDirectionToTransfer[g.Player[g.CurrentMap].dir](next_tile) then
			g.next_map = {
				index = FindInTable("Winter"..event.properties.TransferPlayer, g.maps),
				x = event.properties.TransferTileRight,
				y = event.properties.TransferTileDown
			}
			g.SceneFade:playcommand("FadeToBlack")
		end
	end
end

local InteractionHandler = function()

	-- if handling an event that must be interacted with
	if not g.DialogIsActive then
		g.Dialog.Index = 1
		local next_tile = g.Player[g.CurrentMap].NextTile[g.Player[g.CurrentMap].dir]()
		local event = g.Events[g.CurrentMap][next_tile]

		if event and event.properties and event.properties.text then

			g.Dialog.Words = { event.properties.text }

			if event.properties.text2 then
				local i = 2
				while event.properties["text"..i] do
					table.insert(g.Dialog.Words, event.properties["text"..i])
					i = i + 1
				end
			end

			g.Dialog.ActorFrame:playcommand("UpdateText"):playcommand("Show", {img=event.properties.img})
			g.DialogIsActive = true
		end

		return false
	end

	-- if already handling dialog...
	if not g.Dialog.IsTweening then
		-- update the dialog index
		g.Dialog.Index = g.Dialog.Index + 1

		-- then, ensure that there is more to load
		if g.Dialog.Index <= #g.Dialog.Words then
			-- otherwise, clear the old text, then display the new text
			g.Dialog.ActorFrame:queuecommand("ClearText"):queuecommand("UpdateText")
		else
			-- otherwise, clear the old text, hide the dialog_box
			g.Dialog.ActorFrame:queuecommand("ClearText"):queuecommand("Hide")
			-- and change the flag
			g.DialogIsActive = false
		end
	else
		g.Dialog.ActorFrame:finishtweening()
		g.Dialog.IsTweening = false
	end
end

local directional_movement = function(button)
	g.Player[g.CurrentMap].input.Active = button
	g.Player[g.CurrentMap].input[button] = true

	if not g.DialogIsActive then
		-- attempt to tween character
		g.Player[g.CurrentMap].actor:playcommand("AttemptToTween", {dir=button})
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


	-- this should only be used to terminate input handling early for cut scenes
	if g.InputIsLocked then return false end

	if event.type == "InputEventType_FirstPress" then

		-- if the FirstPress table has a function to react to whichever
		-- button was just pressed, then call that function
		if FirstPress[event.button] then FirstPress[event.button]() end

	elseif event.type == "InputEventType_Release" then

		-- if the button just released was the most recently active button, then no button is being held
		if event.button == g.Player[g.CurrentMap].input.Active then
			-- so mark the Active field as nil
			g.Player[g.CurrentMap].input.Active = nil
			-- and inform the player sprite to stop animating
			g.Player[g.CurrentMap].actor:queuecommand("AnimationOff")
		end

		-- either way, this button has been released, so mark it as false
		g.Player[g.CurrentMap].input[event.button] = false
	end

	return false
end

return InputHandler