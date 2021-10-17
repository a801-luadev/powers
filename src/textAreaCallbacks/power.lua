do
	textAreaCallbacks["power"] = function(playerName, cache, callback)
		-- power_{powerInventoryId}
		textAreaCallbacks["closeInterface"](playerName, cache)

		Power.__inventory[callback[2] * 1]:inventoryItemClicked(cache)
	end
end