do
	commands["i"] = function(playerName)
		keyboardCallbacks[keyboard.G](playerName, playerCache[playerName], true)
	end
end