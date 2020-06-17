do
	keyboardCallbacks[keyboard.L] = function(playerName, cache)
		if cache.isLeaderboardOpen then
			textAreaCallbacks["closeInterface"](playerName, cache)
		else
			displayLeaderboard(playerName, cache)
		end
	end
end