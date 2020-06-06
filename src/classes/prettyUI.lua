local prettyUI = { }
do
	prettyUI.__index = prettyUI

	local borderImage = {
		[1] = "155cbea943a.png",
		[2] = "155cbe99c72.png",
		[3] = "155cbe9bc9b.png",
		[4] = "155cbe97a3f.png"
	}
	local textareaInterface = function(self, x, y, w, h, playerName, cache, text,
		_borderIni, _borderEnd, _borderStep)
		y = y - 3
		self:addTextArea('', playerName, x, y, w, h, 0x141312, 0x141312, 1, false)
		self:addTextArea('', playerName, x + 1, y + 1, w - 2, h - 2, 0x7C482C, 0x7C482C, 1, false)
		self.contentTextAreaId = self:addTextArea(text, playerName, x + 4, y + 4, w - 8, h - 8,
			0x152D30, 0x141312, 1, false)

		x = x - 6
		y = y - 3
		w = w - 14
		h = h - 16

		for b = (_borderIni or 1), (_borderEnd or 4), (_borderStep or 1) do
			self:addImage(borderImage[b], imageTargets.interfaceTextAreaBackground, x + (b % 2)*w,
				y + (b < 3 and 0 or 1)*h, playerName)
		end
	end

	local imageInterface = function(self, x, y, w, h, playerName, cache, text,
		compensateInterfaceImageDimensions)
		self:addImage(interfaceBackground[w][h], imageTargets.interfaceBackground, x - 8, y - 10,
			playerName)

		if compensateInterfaceImageDimensions then
			x = x - 8
			y = y - 10
		end

		self.contentTextAreaId = self:addTextArea(text, playerName, x + 4, y + 4, w - 8, h - 8, 1,
			1, 0, true)
	end

	prettyUI.new = function(x, y, w, h, playerName, text, _cache, ...)
		text = text or ''
		_cache = _cache or playerCache[playerName]

		local self = setmetatable({
			id = nil,

			x = x,
			y = y,
			w = w,
			h = h,
			playerName = playerName,
			cache = _cache,

			contentTextAreaId = nil,

			interfaceImages = { },
			totalInterfaceImages = 0,

			initInterfaceId = nil,
			interfaceId = nil
		}, prettyUI)

		-- Sets new ID
		_cache.totalPrettyUIs = _cache.totalPrettyUIs + 1
		self.id = _cache.totalPrettyUIs
		_cache.prettyUIs[self.id] = self
		_cache.lastPrettyUI = self

		-- Sets interface ID
		local lastInstance = _cache.prettyUIs[self.id - 1]
		self.interfaceId = (lastInstance and lastInstance.interfaceId or textAreaId.interface)
		self.initInterfaceId = self.interfaceId + 1

		_cache.isInterfaceOpen = true

		if interfaceBackground[w] and interfaceBackground[w][h] then
			imageInterface(self, x, y, w, h, playerName, _cache, text, ...)
		else
			-- Debug/development behavior, avoidable
			textareaInterface(self, x, y, w, h, playerName, _cache, text, ...)
		end

		return self
	end

	prettyUI.remove = function(self)
		-- Resetting data is unnecessary, GC should handle the instance

		local interfaceImages = self.interfaceImages
		for i = 1, self.totalInterfaceImages do
			removeImage(interfaceImages[i])
		end

		for t = self.initInterfaceId, self.interfaceId do
			removeTextArea(t, self.playerName)
		end
	end

	local callback = "<a href='event:closeInterface'>\n\n\n\n"
	prettyUI.setCloseButton = function(self, xAxis)
		local x = self.x + self.w - (xAxis or 12)
		local y = self.y - 15

		self:addImage(interfaceImages.xButton, imageTargets.interfaceIcon, x, y, self.playerName)

		self:addTextArea(callback, self.playerName, x, y, 30, 31, 1, 1,	0, true)

		return self
	end

	prettyUI.addTextArea = function(self, ...)
		self.interfaceId = self.interfaceId + 1
		addTextArea(self.interfaceId, ...)
		return self.interfaceId
	end

	prettyUI.addImage = function(self, ...)
		self.totalInterfaceImages = self.totalInterfaceImages + 1
		local image = addImage(...)
		self.interfaceImages[self.totalInterfaceImages] = image
		return image
	end
end