do
	keyboardCallbacks[keyboard.G] = function(playerName, cache, isDown)
		if isDown then
			if not canTriggerPowers then return end
			displayPowersInventory(playerName, cache)
		else
			textAreaCallbacks["closeInterface"](playerName, cache)
		end
	end
end