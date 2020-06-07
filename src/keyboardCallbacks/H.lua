do
	keyboardCallbacks[keyboard.H] = function(playerName, cache)
		if cache.isHelpOpen then
			textAreaCallbacks["closeInterface"](playerName, nil, cache)
		else
			displayHelp(playerName, cache)
		end
	end
end