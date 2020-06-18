do
	-- Enables/disables the review mode
	commands["review"] = function(playerName)
		if not hasPermission(playerName, permissions.enableReviewMode)
			or nextMapToLoad then return end -- Can't change state when !npp is pending

		isReviewMode = not isReviewMode
		if isReviewMode then
			chatMessage(getText.enableReviewMode)
		else
			chatMessage(getText.disableReviewMode)
		end
	end
end