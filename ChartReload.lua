-- if both players are joined
if #GAMESTATE:GetHumanPlayers() > 1 then

	local group_name = GAMESTATE:GetCurrentSong():GetGroupName()
	local songs_in_group = SONGMAN:GetSongsInGroup(group_name)
	local darkness, steps

	for i, song in ipairs(songs_in_group) do
		-- find the song we want
		if song:GetDisplayFullTitle() == "            here in the darkness" then
			darkness = song
			steps = darkness:GetOneSteps("StepsType_Dance_Single", "Difficulty_Beginner")
			break
		end
	end

	if darkness and steps then
		-- set song
		GAMESTATE:SetCurrentSong(darkness)
		-- set steps for both players
		for player in ivalues(GAMESTATE:GetHumanPlayers()) do
			GAMESTATE:SetCurrentSteps(player, steps)
		end

		return true
	end
end

return false