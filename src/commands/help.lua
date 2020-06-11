do
	commands["help"] = function(playerName)
		keyboardCallbacks[keyboard.H](playerName, playerCache[playerName])
	end
end