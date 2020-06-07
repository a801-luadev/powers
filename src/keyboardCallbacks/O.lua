do
	keyboardCallbacks[keyboard.O] = function(playerName, cache)
		if cache.isPowersOpen then
			textAreaCallbacks["closeInterface"](playerName, nil, cache)
		else
			displayPowerMenu(playerName, cache)
		end
	end
end