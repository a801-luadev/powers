do
	textAreaCallbacks["powerInfo"] = function(playerName, cache, callback)
		-- powerInfo_{power_name}_{interface_x}_{interface_y}
		if not callback[4] then return end

		if cache.powerInfoIdSelected == callback[2] then return end
		cache.powerInfoIdSelected = callback[2]

		updatePowerMenu(playerName, tonumber(callback[3]), tonumber(callback[4]), cache)
		displayPowerInfo(playerName, cache)
	end
end