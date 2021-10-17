do
	keyboardCallbacks[keyboard.G] = function(playerName, cache, isDown)
		if isDown then
			displayPowersInventory(playerName, cache)
		else
			textAreaCallbacks["closeInterface"](playerName, cache)
		end
	end
end