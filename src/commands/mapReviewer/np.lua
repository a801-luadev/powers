do
	-- Loads a new map for review
	commands["np"] = function(playerName, command)
		if not (command[2] and hasPermission(playerName, permissions.enableReviewMode)
			and isCurrentMapOnReviewMode) then return end

		newGame(command[2])
		logCommandUsage(playerName, command)
	end
end