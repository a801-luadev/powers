local displayPowerMenu, updatePowerMenu
do
	local content = "<p align='center'><font size='3'>\n"
	local unlockedPowerContent = content .. "<font size='14'>"
	local lockedPowerContent = unlockedPowerContent .. "<BL><B>" .. getText.level
	local callback = "<a href='event:powerInfo_%s_%s_%s'>\n\n\n\n"

	displayPowerMenu = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]
		local playerLevel = _cache.level

		-- Build interface
		local interfaceId = textAreaId.interface + _cache.totalInterfaceTextareas
		local totalInterfaceImages = _cache.totalInterfaceImages
		local playerInterfaceImages = _cache.interfaceImages

		local x, y = 100, 65
		_cache.menuContentId = displayPrettyUI('', x, y, 520, 300, playerName, _cache)

		x = x + 15
		y = y + 17

		local power, isLockedPower, sumX
		for p = 1, #powersSortedByLevel do
			power = powersSortedByLevel[p]
			isLockedPower = (power.level > playerLevel)

			sumX = x + ((p + 1) % 2)*249

			totalInterfaceImages = totalInterfaceImages + 1
			playerInterfaceImages[totalInterfaceImages] = addImage(interfaceImages.rectangle,
				imageTargets.interfaceRectangle, sumX - 2, y - 2, playerName)

			totalInterfaceImages = totalInterfaceImages + 1
			playerInterfaceImages[totalInterfaceImages] = addImage(power.imageData.smallIcon,
				imageTargets.interfaceIcon, sumX, y, playerName)

			interfaceId = interfaceId + 1
			addTextArea(interfaceId, (isLockedPower and format(lockedPowerContent, power.level)
				or (unlockedPowerContent .. getText.powers[power.name])), playerName, sumX, y, 241,
				30, -1, 0x1B2B31, 0, true)

			if isLockedPower then
				totalInterfaceImages = totalInterfaceImages + 1
				playerInterfaceImages[totalInterfaceImages] = addImage(interfaceImages.locker,
					imageTargets.interfaceIcon, sumX + 216, y, playerName)
			else
				-- Clickable callback
				interfaceId = interfaceId + 1
				addTextArea(interfaceId, format(callback, power.name, sumX - 4, y - 5),
					playerName, sumX - 5, y - 3, 249, 35, 1, 1, 0, true) -- p instead of power.name?
			end

			if p % 2 == 0 then
				y = y + 39
			end
		end

		_cache.totalInterfaceImages = totalInterfaceImages
	end

	updatePowerMenu = function(playerName, interfaceX, interfaceY, _cache)
		_cache = _cache or playerCache[playerName]

		if _cache.powerInfoImageId then
			removeImage(_cache.powerInfoImageId, playerName)
		end

		local highlightRectangleBorder = addImage(interfaceImages.highlightRectangleBorder,
			imageTargets.interfaceRectangle, interfaceX, interfaceY, playerName)

		_cache.powerInfoImageId = highlightRectangleBorder

		_cache.totalInterfaceImages = _cache.totalInterfaceImages + 1
		_cache.interfaceImages[_cache.totalInterfaceImages] = highlightRectangleBorder
	end
end