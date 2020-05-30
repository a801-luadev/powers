local displayPowerMenu
do
	local content = "<p align='center'><font size='3'>\n"
	local unlockedPowerContent = content .. "<font size='14'>"
	local lockedPowerContent = unlockedPowerContent .. "<BL><B>" .. getText.level
	local callback = "<a href='event:powerInfo_%s_%s_%s'>\n\n\n\n"

	displayPowerMenu = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]
		local playerLevel = _cache.level

		-- Build interface
		local x, y = 39, 65
		displayPrettyUI('', x, y, 520, 300, playerName, false, _cache)

		x = x + 15
		y = y + 17

		local interfaceId = textAreaId.interface + _cache.totalInterfaceTextareas
		local totalInterfaceImages = _cache.totalInterfaceImages
		local playerInterfaceImages = _cache.interfaceImages

		local totalPowers = #powersSortedByLevel
		local power, isLockedPower, sumX
		for p = 1, totalPowers do
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
		_cache.totalInterfaceTextareas = interfaceId - textAreaId.interface
	end
end

local updatePowerMenu = function(playerName, interfaceX, interfaceY, _cache)
	_cache = _cache or playerCache[playerName]

	if _cache.powerInfoSelectionImageId then
		removeImage(_cache.powerInfoSelectionImageId, playerName)
	end

	local highlightRectangleBorder = addImage(interfaceImages.highlightRectangleBorder,
		imageTargets.interfaceRectangle, interfaceX, interfaceY, playerName)

	_cache.powerInfoSelectionImageId = highlightRectangleBorder

	_cache.totalInterfaceImages = _cache.totalInterfaceImages + 1
	_cache.interfaceImages[_cache.totalInterfaceImages] = highlightRectangleBorder
end

local displayPowerInfo
do
	local displayPowerIcon = function(playerName, power, x, y, interfaceId, playerInterfaceImages,
		totalInterfaceImages, interfaceWidth)
		y = y + 40

		totalInterfaceImages = totalInterfaceImages + 1
		playerInterfaceImages[totalInterfaceImages] = addImage(power.imageData.icon,
			imageTargets.interfaceIcon, x + interfaceWidth/2 - power.imageData.iconWidth/2, y,
			playerName)

		return x, y + power.imageData.iconHeight, interfaceId, totalInterfaceImages
	end

	local displayPowerTypeIcon = function(playerName, power, x, y, interfaceId,
		playerInterfaceImages, totalInterfaceImages)
		y = y + 15

		totalInterfaceImages = totalInterfaceImages + 1
		if power.type == powerType.atk then
			playerInterfaceImages[totalInterfaceImages] = addImage(interfaceImages.sword,
				imageTargets.interfaceIcon, x, y, playerName)

			interfaceId = interfaceId + 1
			addTextArea(interfaceId, power.damage, playerName, x + 25, y + 5, nil, nil, 1, 1, 0,
				true)
		elseif power.type == powerType.def then
			playerInterfaceImages[totalInterfaceImages] = addImage(interfaceImages.shield,
				imageTargets.interfaceIcon, x, y, playerName)
		elseif power.type == powerType.divine then
			playerInterfaceImages[totalInterfaceImages] = addImage(interfaceImages.parchment,
				imageTargets.interfaceIcon, x, y, playerName)
		end

		return x, y, interfaceId, totalInterfaceImages
	end

	local displayPowerSelfDamage = function(playerName, power, x, y, interfaceId,
		playerInterfaceImages, totalInterfaceImages)
		if power.selfDamage then
			y = y + 25

			totalInterfaceImages = totalInterfaceImages + 1
			playerInterfaceImages[totalInterfaceImages] = addImage(interfaceImages.heart,
				imageTargets.interfaceIcon, x, y, playerName)

			interfaceId = interfaceId + 1
			addTextArea(interfaceId, -power.selfDamage, playerName, x + 25, y + 5, nil, nil, 1, 1,
				0, true)
		end

		return x, y, interfaceId, totalInterfaceImages
	end

	local displayPowerTriggerPossibility = function(playerName, power, x, y, interfaceId,
		playerInterfaceImages, totalInterfaceImages)
		if power.triggerPossibility then
			y = y + 30

			totalInterfaceImages = totalInterfaceImages + 1
			playerInterfaceImages[totalInterfaceImages] = addImage(interfaceImages.explodingBomb,
				imageTargets.interfaceIcon, x + 2, y, playerName)

			interfaceId = interfaceId + 1
			addTextArea(interfaceId, ceil(100/power.triggerPossibility) .. "%", playerName, x + 28,
				y, nil, nil, 1, 1, 0, true)
		end

		return x, y, interfaceId, totalInterfaceImages
	end

	local displayTrigger = function(playerName, power, x, y, interfaceId, playerInterfaceImages,
		totalInterfaceImages)
		if power.keySequences then
			x = x - 25

			local sumX, ks
			for i = 1, power.totalKeySequences do
				sumX = x
				y = y + 25

				ks = power.keySequences[i]

				for j = ks._count, 1, -1 do
					sumX = sumX + 25

					totalInterfaceImages = totalInterfaceImages + 1
					playerInterfaceImages[totalInterfaceImages] = addImage(
						keyboardImages[ks.queue[j]], imageTargets.interfaceIcon, sumX, y,
						playerName)
				end
			end

			x = x + 25
		elseif power.triggererKey then
			y = y + 25

			totalInterfaceImages = totalInterfaceImages + 1
			playerInterfaceImages[totalInterfaceImages] = addImage(
				keyboardImages[power.triggererKey],	imageTargets.interfaceIcon, x, y, playerName)
		elseif power.clickRange then
			y = y + 25

			totalInterfaceImages = totalInterfaceImages + 1
			playerInterfaceImages[totalInterfaceImages] = addImage(interfaceImages.mouseClick,
				imageTargets.interfaceIcon, x, y, playerName)

			interfaceId = interfaceId + 1
			addTextArea(interfaceId, power.clickRange .. "px", playerName, x + 25, y + 5, nil, nil,
				1, 1, 0, true)
		elseif power.messagePattern then
			y = y + 25

			totalInterfaceImages = totalInterfaceImages + 1
			playerInterfaceImages[totalInterfaceImages] = addImage(interfaceImages.megaphone,
				imageTargets.interfaceIcon, x, y, playerName)

			interfaceId = interfaceId + 1
			addTextArea(interfaceId, "<I>" .. gsub(power.messagePattern, "%W+", ''), playerName,
				x + 30, y + 5, nil, nil, 1, 1, 0, true)
		end

		return x, y, interfaceId, totalInterfaceImages
	end

	local body = "<p align='center'><font size='16'>%s</font></p>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n%s"

	displayPowerInfo = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]
		local power = powers[_cache.powerInfoIdSelected]

		local x, y, width = 563, 65, 200
		displayPrettyUI(format(body, getText.powers[power.name],
			getText.powersDescriptions[power.name]), x, y, width, 300, playerName, false, _cache)

		local interfaceId = textAreaId.interface + _cache.totalInterfaceTextareas
		local playerInterfaceImages = _cache.interfaceImages
		local totalInterfaceImages = _cache.totalInterfaceImages

		-- Icons
		x, y, interfaceId, totalInterfaceImages = displayPowerIcon(playerName, power, x, y,
			interfaceId, playerInterfaceImages, totalInterfaceImages, width)

		x = x + 10
		x, y, interfaceId, totalInterfaceImages = displayPowerTypeIcon(playerName, power, x, y,
			interfaceId, playerInterfaceImages, totalInterfaceImages)

		x, y, interfaceId, totalInterfaceImages = displayPowerTriggerPossibility(playerName, power,
			x, y, interfaceId, playerInterfaceImages, totalInterfaceImages)

		x, y, interfaceId, totalInterfaceImages = displayPowerSelfDamage(playerName, power, x, y,
			interfaceId, playerInterfaceImages, totalInterfaceImages)

		x, y, interfaceId, totalInterfaceImages = displayTrigger(playerName, power, x, y,
			interfaceId, playerInterfaceImages, totalInterfaceImages)

		_cache.totalInterfaceTextareas = interfaceId - textAreaId.interface
		_cache.totalInterfaceImages = totalInterfaceImages
	end
end