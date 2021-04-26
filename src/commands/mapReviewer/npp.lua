do
	-- Schedules the next map for review
	commands["npp"] = function(playerName, command)
		if not (command[2] and hasPermission(playerName, permissions.enableReviewMode)
			and isReviewMode) then return end

		nextMapToLoad = command[2]
		logCommandUsage(playerName, command)
	end
end