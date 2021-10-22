do
	textAreaCallbacks["power"] = function(playerName, cache, callback)
		-- power_{powerInventoryId}
		if not callback[2] then return end

		textAreaCallbacks["closeInterface"](playerName, cache)

		local power = Power.__inventory[callback[2] * 1]
		if power and power.inventoryItemClicked and power:canTriggerRegular(cache, nil, true) then
			power:inventoryItemClicked(cache)
		else
			commands["ban"](nil,
				{ nil, playerName, 24, "[auto] attempt to trigger unavailable power" })
		end
	end
end