do
	commands["leaderboard"] = function(playerName)
		keyboardCallbacks[keyboard.L](playerName, playerCache[playerName])
	end
end