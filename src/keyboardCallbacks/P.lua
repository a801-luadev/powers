do
	keyboardCallbacks[keyboard.P] = function(playerName, cache)
		if cache.isProfileOpen then
			textAreaCallbacks["closeInterface"](playerName, cache)
		else
			displayProfile(playerName, playerName, cache)
		end
	end
end