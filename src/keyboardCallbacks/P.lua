do
	keyboardCallbacks[keyboard.P] = function(playerName, cache)
		if cache.isProfileOpen then
			textAreaCallbacks["closeInterface"](playerName, nil, cache)
		else
			displayProfile(playerName, playerName, cache)
		end
	end
end