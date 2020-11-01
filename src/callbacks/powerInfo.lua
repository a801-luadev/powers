do
	callbacks["powerInfo"] = function(playerName, callback)
		-- powerInfo_{power_name}_{interface_x}_{interface_y}
		local cache = playerCache[playerName]
		if cache.powerInfoIdSelected == callback[2] then return end
		cache.powerInfoIdSelected = callback[2]

		updatePowerMenu(playerName, tonumber(callback[3]), tonumber(callback[4]), cache)
		displayPowerInfo(playerName, cache)
	end
end