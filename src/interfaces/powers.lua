local displayPowerMenu
do
	local content = "<p align='center'><font size='3'>\n"
	local unlockedPowerContent = content .. "<font size='14'>"
	local lockedPowerContent = unlockedPowerContent .. "<BL><B>" .. getText.level
	local callback = "powerInfo_%s_%s_%s"

	displayPowerMenu = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]
		textAreaCallbacks["closeInterface"](playerName, _cache)
		_cache.isPowersOpen = true
		local playerLevel = _cache.level

		-- Build interface
		local x, y = 253, 65
		local interface = prettyUI
			.new(x, y, 503, 278, playerName, '', _cache)
			:setCloseButton(4)

		x = x + 7
		y = y + 7

		local totalPowers = #powersSortedByLevel
		local power, isLockedPower, sumX
		for p = 1, totalPowers do
			power = powersSortedByLevel[p]
			isLockedPower = (power.level > playerLevel)

			sumX = x + ((p + 1) % 2)*249

			interface:addTextArea((isLockedPower and format(lockedPowerContent, power.level)
				or (unlockedPowerContent .. getText.powers[power.name])), playerName, sumX, y, 241,
				30, -1, 0x1B2B31, 0, true)

			interface:addClickableImage(interfaceImages.rectangle, imageTargets.interfaceRectangle,
				sumX - 2, y - 2, playerName, 245, 34, format(callback, power.name, sumX - 4, y - 5),
				not isLockedPower)

			interface:addImage(power.imageData.smallIcon, imageTargets.interfaceIcon, sumX, y,
				playerName)

			if isLockedPower then
				interface:addImage(interfaceImages.locker, imageTargets.interfaceIcon, sumX + 216,
					y, playerName)
			end

			if p % 2 == 0 then
				y = y + 39
			end
		end
	end
end

local updatePowerMenu = function(playerName, interfaceX, interfaceY, _cache)
	_cache = _cache or playerCache[playerName]

	if _cache.powerInfoSelectionImageId then
		removeImage(_cache.powerInfoSelectionImageId, playerName)

		_cache.lastPrettyUI:remove()
	end

	_cache.powerInfoSelectionImageId = _cache.prettyUIs[1]:addImage(
		interfaceImages.highlightRectangleBorder, imageTargets.interfaceRectangle, interfaceX,
		interfaceY, playerName)
end

local displayPowerInfo
do
	local displayPowerIcon = function(playerName, power, interface, x, y, w)
		y = y + 40

		interface:addImage(power.imageData.icon, imageTargets.interfaceIcon,
			x + w/2 - power.imageData.iconWidth/2, y, playerName)

		return x, y + power.imageData.iconHeight
	end

	local displayPowerTypeIcon = function(playerName, power, interface, x, y)
		y = y + 10

		local typeImage, typeText
		if power.type == powerType.atk then
			typeImage = interfaceImages.sword
			typeText = format(getText.powerType.atk, power.damage)
		elseif power.type == powerType.def then
			typeImage = interfaceImages.shield
			typeText = getText.powerType.def
		elseif power.type == powerType.divine then
			typeImage = interfaceImages.parchment
			typeText = getText.powerType.divine
		end

		interface:addImage(typeImage, imageTargets.interfaceIcon, x, y, playerName)
		interface:addTextArea(typeText, playerName, x + 25, y + 5, nil, nil, 1, 1, 0, true)

		return x, y
	end

	local displayPowerSelfDamage = function(playerName, power, interface, x, y)
		if power.selfDamage then
			y = y + 25

			interface:addImage(interfaceImages.heart, imageTargets.interfaceIcon, x, y, playerName)

			interface:addTextArea(-power.selfDamage, playerName, x + 25, y + 5, nil, nil, 1, 1, 0,
				true)
		end

		return x, y
	end

	local getTriggerPossibilityStr = function(triggerPossibility)
		return
	end

	local displayPowerTriggerPossibility = function(playerName, power, interface, x, y, isEmotePw)
		if power.triggerPossibility and (isEmotePw or power.type == powerType.divine) then
			y = y + 30

			interface:addImage(interfaceImages.explodingBomb, imageTargets.interfaceIcon, x + 2, y,
				playerName)

			interface:addTextArea("~" .. ceil(100/power.triggerPossibility) .. "%", playerName,
				x + 28, y, nil, nil, 1, 1, 0, true)
		end

		return x, y
	end

	local displayTrigger = function(playerName, power, interface, x, y, w)
		if power.keySequences then
			x = x - 10
			w = w / 2

			local sumX, ks
			for i = 1, power.totalKeySequences do
				ks = power.keySequences[i]

				sumX = x + w - (ks._count * 25)/2
				y = y + 25

				for j = ks._count, 1, -1 do
					interface:addImage(keyboardImages[ks.queue[j]], imageTargets.interfaceIcon,
						sumX, y, playerName)

					sumX = sumX + 25
				end
			end

			x = x + 25
		end
		if power.triggererKey then
			y = y + 25

			interface:addImage(keyboardImages[power.triggererKey], imageTargets.interfaceIcon,
				x - 10 + (w - (keyboardImagesWidths[power.triggererKey] or 25))/2, y, playerName)
		end
		if power.clickRange then
			y = y + 25

			interface:addImage(interfaceImages.mouseClick, imageTargets.interfaceIcon, x + 5, y,
				playerName)

			interface:addTextArea(power.clickRange .. "px", playerName, x + 25, y + 5, nil, nil, 1,
				1, 0, true)
		end
		if power.messagePattern then
			y = y + 25

			interface:addImage(interfaceImages.megaphone, imageTargets.interfaceIcon, x, y,
				playerName)

			interface:addTextArea("<I>" .. gsub(power.messagePattern, "[^%w ]+", ''), playerName,
				x + 30, y + 2, nil, nil, 1, 1, 0, true)
		end
		if power.triggererEmote then
			y = y + 25

			if power.triggerPossibility then
				displayPowerTriggerPossibility(playerName, power, interface, x + 16, y - 28, true)
			end

			interface:addImage(emoteImages[power.triggererEmote], imageTargets.interfaceIcon, x, y,
				playerName)
		end

		return x, y
	end

	local body = "<p align='center'><font size='16'><V><B>%s</B></V></font></p>" ..
		"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n%s"

	displayPowerInfo = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]
		local power = powers[_cache.powerInfoIdSelected]

		local x, y, width = 38, 65, 183
		local interface = prettyUI
			.new(x, y, width, 279, playerName, format(body, getText.powers[power.name],
				getText.powersDescriptions[power.name]), _cache)

		-- Icons
		x, y = displayPowerIcon(playerName, power, interface, x, y, width)

		x = x + 10
		x, y = displayPowerTypeIcon(playerName, power, interface, x, y)

		x, y = displayPowerTriggerPossibility(playerName, power, interface, x, y)

		x, y = displayPowerSelfDamage(playerName, power, interface, x, y)

		x, y = displayTrigger(playerName, power, interface, x, y, width)
	end
end