local displayPrettyUI
do
	local borderImage = {
		[1] = "155cbea943a.png",
		[2] = "155cbe99c72.png",
		[3] = "155cbe9bc9b.png",
		[4] = "155cbe97a3f.png"
	}

	displayPrettyUI = function(text, x, y, w, h, playerName, ignoreTextAreaHeight, _cache,
		_borderIni, _borderEnd, _borderStep)
		_cache = _cache or playerCache[playerName]
		_cache.hasOpenInterface = true
		local interfaceId = textAreaId.interface + _cache.totalInterfaceTextareas

		-- Default behavior
		if interfaceBackground[w] and interfaceBackground[w][h] then
			_cache.totalInterfaceImages = _cache.totalInterfaceImages + 1
			_cache.interfaceImages[_cache.totalInterfaceImages] = addImage(
				interfaceBackground[w][h], imageTargets.interfaceBackground, x, y, playerName)

			if ignoreTextAreaHeight then
				y = y - 6
			else
				h = h - 20
			end

			addTextArea(interfaceId + 1, text, playerName, x + 10, y + 10, w - 20, h, 1, 1, 0, true)
			_cache.totalInterfaceTextareas = _cache.totalInterfaceTextareas + 1

			return interfaceId + 1
		end

		-- Debug/development behavior, avoidable
		y = y - 3
		addTextArea(interfaceId + 1, '', playerName, x, y, w, h, 0x141312, 0x141312, 1, false)
		addTextArea(interfaceId + 2, '', playerName, x + 1, y + 1, w - 2, h - 2, 0x7C482C, 0x7C482C,
			1, false)
		addTextArea(interfaceId + 3, text, playerName, x + 4, y + 4, w - 8, h - 8, 0x152D30,
			0x141312, 1, false)
		_cache.totalInterfaceTextareas = _cache.totalInterfaceTextareas + 3

		x = x - 6
		y = y - 3
		w = w - 14
		h = h - 16

		local totalInterfaceImages = _cache.totalInterfaceImages
		local playerInterfaceImages = _cache.interfaceImages

		for b = (_borderIni or 1), (_borderEnd or 4), (_borderStep or 1) do
			playerInterfaceImages[totalInterfaceImages + b] = addImage(borderImage[b],
				imageTargets.interfaceTextAreaBackground, x + (b % 2)*w, y + (b < 3 and 0 or 1)*h,
				playerName)
		end
		_cache.totalInterfaceImages = totalInterfaceImages + 4

		-- Returns the id of the textarea with color
		return interfaceId + 3
	end
end

local removeCallbackInterface = function(playerName, _cache)
	_cache = _cache or playerCache[playerName]
	_cache.hasOpenInterface = false

	-- Images
	local playerInterfaceImages = _cache.interfaceImages
	for i = 1, _cache.totalInterfaceImages do
		removeImage(playerInterfaceImages[i])
	end
	_cache.interfaceImages = { }
	_cache.totalInterfaceImages = 0

	-- TextAreas
	local interfaceId = textAreaId.interface
	for t = 1, _cache.totalInterfaceTextareas do
		removeTextArea(interfaceId + t, playerName)
	end
	_cache.totalInterfaceTextareas = 0
end