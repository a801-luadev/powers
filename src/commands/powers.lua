do
	commands["powers"] = function(playerName)
		keyboardCallbacks[keyboard.O](playerName, playerCache[playerName])
	end
end