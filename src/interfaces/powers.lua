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
		local x, y = 45, 65
		local interface = prettyUI
			.new(x, y, 520, 300, playerName, '', _cache)

		x = x + 7
		y = y + 7

		local totalPowers = #powersSortedByLevel
		local power, isLockedPower, sumX
		for p = 1, totalPowers do
			power = powersSortedByLevel[p]
			isLockedPower = (power.level > playerLevel)

			sumX = x + ((p + 1) % 2)*249

			interface:addImage(interfaceImages.rectangle, imageTargets.interfaceRectangle, sumX - 2,
				y - 2, playerName)

			interface:addImage(power.imageData.smallIcon, imageTargets.interfaceIcon, sumX, y,
				playerName)

			interface:addTextArea((isLockedPower and format(lockedPowerContent, power.level)
				or (unlockedPowerContent .. getText.powers[power.name])), playerName, sumX, y, 241,
				30, -1, 0x1B2B31, 0, true)

			if isLockedPower then
				interface:addImage(interfaceImages.locker, imageTargets.interfaceIcon, sumX + 216,
					y, playerName)
			else
				-- Clickable callback
				interface:addTextArea(format(callback, power.name, sumX - 4, y - 5), playerName,
					sumX - 5, y - 3, 249, 35, 1, 1, 0, true) -- p instead of power.name?
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
		y = y + 15

		if power.type == powerType.atk then
			interface:addImage(interfaceImages.sword, imageTargets.interfaceIcon, x, y, playerName)

			interface:addTextArea(power.damage, playerName, x + 25, y + 5, nil, nil, 1, 1, 0, true)
		elseif power.type == powerType.def then
			interface:addImage(interfaceImages.shield, imageTargets.interfaceIcon, x, y, playerName)
		elseif power.type == powerType.divine then
			interface:addImage(interfaceImages.parchment, imageTargets.interfaceIcon, x, y,
				playerName)
		end

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

	local displayPowerTriggerPossibility = function(playerName, power, interface, x, y)
		if power.triggerPossibility then
			y = y + 30

			interface:addImage(interfaceImages.explodingBomb, imageTargets.interfaceIcon, x + 2, y,
				playerName)

			interface:addTextArea(ceil(100/power.triggerPossibility) .. "%", playerName, x + 28, y,
				nil, nil, 1, 1, 0, true)
		end

		return x, y
	end

	local displayTrigger = function(playerName, power, interface, x, y)
		if power.keySequences then
			x = x - 25

			local sumX, ks
			for i = 1, power.totalKeySequences do
				sumX = x
				y = y + 25

				ks = power.keySequences[i]

				for j = ks._count, 1, -1 do
					sumX = sumX + 25

					interface:addImage(keyboardImages[ks.queue[j]], imageTargets.interfaceIcon,
						sumX, y, playerName)
				end
			end

			x = x + 25
		elseif power.triggererKey then
			y = y + 25

			interface:addImage(keyboardImages[power.triggererKey], imageTargets.interfaceIcon, x, y,
				playerName)
		elseif power.clickRange then
			y = y + 25

			interface:addImage(interfaceImages.mouseClick, imageTargets.interfaceIcon, x, y,
				playerName)

			interface:addTextArea(power.clickRange .. "px", playerName, x + 25, y + 5, nil, nil, 1,
				1, 0, true)
		elseif power.messagePattern then
			y = y + 25

			interface:addImage(interfaceImages.megaphone, imageTargets.interfaceIcon, x, y,
				playerName)

			interface:addTextArea("<I>" .. gsub(power.messagePattern, "%W+", ''), playerName,
				x + 30, y + 5, nil, nil, 1, 1, 0, true)
		end

		return x, y
	end

	local body = "<p align='center'><font size='16'>%s</font></p>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n%s"

	displayPowerInfo = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]
		local power = powers[_cache.powerInfoIdSelected]

		local x, y, width = 575, 65, 200
		local interface = prettyUI
			.new(x, y, width, 300, playerName, format(body, getText.powers[power.name],
				getText.powersDescriptions[power.name]), _cache)

		-- Icons
		x, y = displayPowerIcon(playerName, power, interface, x, y, width)

		x = x + 10
		x, y = displayPowerTypeIcon(playerName, power, interface, x, y)

		x, y = displayPowerTriggerPossibility(playerName, power, interface, x, y)

		x, y = displayPowerSelfDamage(playerName, power, interface, x, y)

		x, y = displayTrigger(playerName, power, interface, x, y)
	end
end