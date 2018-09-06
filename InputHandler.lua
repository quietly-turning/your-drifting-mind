local args = ...
local t = args[1]
local g = args[2]

local directional_movement = function(button)
	g.Player.input.Active = button
	g.Player.input[button] = true

	if not g.InputIsLocked then
		-- attempt to tween character
		g.Player.actor:playcommand("AttemptToTween", {dir=button})
	end
end

local FirstPress = {
	Start = function()
		-- InteractionHandler()
	end,

	MenuRight = function() end,
	MenuLeft = function() end,

	Up = function(button) directional_movement(button) end,
	Down = function(button) directional_movement(button) end,
	Left = function(button) directional_movement(button) end,
	Right = function(button) directional_movement(button) end
}

local InputHandler = function(event)

	-- if any of these, don't attempt to handle input
	if not event.PlayerNumber or not event.button then return false end

	----------------------------------------------------------------------------
	-- DEVELOPER & DEBUG STUFF

	-- quick hack to get out of the song by pressing escape
	if  (event.DeviceInput.button == "DeviceButton_escape") then
		SCREENMAN:GetTopScreen():begin_backing_out()
		return
	end

	----------------------------------------------------------------------------

	if event.type == "InputEventType_FirstPress" then

		if FirstPress[event.button] then
			FirstPress[event.button](event.button)
		end

	elseif event.type == "InputEventType_Release" then

		-- if the button just released was the most recently active button, mark the active field as nil
		if event.button == g.Player.input.Active then g.Player.input.Active = nil end
		-- either way, this button has been released, so mark it as false
		g.Player.input[event.button] = false
	end

	return false
end

return InputHandler