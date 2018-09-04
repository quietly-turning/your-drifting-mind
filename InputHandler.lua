local args = ...
local t = args[1]
local g = args[2]

local InputHandler = function(event)

	-- if any of these, don't attempt to handle input
	if not event.PlayerNumber or not event.button then return false end

	----------------------------------------------------------------------------
	-- DEVELOPER & DEBUG STUFF

	-- quick hack to get out of the song by pressing escape
	if event.type == "InputEventType_FirstPress" and (event.DeviceInput.button == "DeviceButton_escape") then
		t:queuecommand("Off")
		return false
	end

	----------------------------------------------------------------------------

	-- truncate "PlayerNumber_P1" into "P1"
	local pn = ToEnumShortString(event.PlayerNumber)


	if event.type == "InputEventType_FirstPress" and event.GameButton == "Start" then

		-- InteractionHandler()

	elseif event.type == "InputEventType_FirstPress" and event.button == "MenuRight" then


	elseif event.type == "InputEventType_FirstPress" and event.button == "MenuLeft" then


	elseif event.type ~= "InputEventType_Release" then

		g.Player.input[event.button] = true

		-- handle player sprite movement
		if event.button == "Up" or event.button == "Down" or event.button == "Left" or event.button == "Right" then

			-- if event.type == "InputEventType_FirstPress" then
			-- 	g.Player.input.Active = event.button
			-- end

			if not g.InputIsLocked then
				-- attempt to tween character
				g.Player.actor:playcommand("AttemptToTween", {dir=event.button})

				-- attempt to tween the map
				-- t:GetChild("Visuals"):GetChild("Sprite"):playcommand("AttemptToTween")
			end
		end

	elseif event.type == "InputEventType_Release" then
		-- g.Player.input.Active = nil
		g.Player.input[event.button] = false

		-- if a player has released a directional arrow...
		if event.button == "Up" or event.button == "Down" or event.button == "Left" or event.button == "Right" then
			-- ...then attempt to redraw the character sprite in a neutral (standing) state
			g.Player.actor:queuecommand("AnimationOff")
		end
	end

	return false
end

return InputHandler