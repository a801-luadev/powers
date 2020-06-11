do
	keyboardCallbacks[keyboard.P] = function(playerName, cache, _, targetPlayer)
		if cache.isProfileOpen then
			textAreaCallbacks["closeInterface"](playerName, cache)
		else
			displayProfile(playerName, (targetPlayer or playerName), cache)
		end
	end
end