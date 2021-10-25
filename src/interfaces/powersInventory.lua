local displayPowersInventory
do
	displayPowersInventory = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]
		textAreaCallbacks["closeInterface"](playerName, _cache)

		_cache.isInventoryOpen = true

		local x, y = 805, 35
		local interface = prettyUI
			.new(x, y, nil, nil, playerName, nil, _cache)

		local roundKills = _cache.roundKills

		local totalAvailablePowers = 0

		local src, power = Power.__inventory
		for powerId = 1, Power.__eventCount.__inventory do
			power = src[powerId]

			if power:canTriggerRegular(_cache, nil, true) then
				totalAvailablePowers = totalAvailablePowers + 1

				x = x - 35

				interface:addClickableImage(power.imageData.smallIcon, imageTargets.interfaceIcon,
					x, y, playerName, 30, 30, "power_" .. powerId, nil, nil, nil, nil, .6)
			end
		end
	end
end