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
			interfaceId = nil,

			isCheckingDeletableContent = false,
			firstDeletableTextArea = nil,
			lastDeletableTextArea = nil,
			firstDeletableImage = nil,
			lastDeletableImage = nil,

			totalButtons = 0
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
			error()
			textareaInterface(self, x, y, w, h, playerName, _cache, text, ...)
		end

		return self
	end

	prettyUI.remove = function(self, iniImg, endImg, iniTxt, endTxt)
		-- Resetting data is unnecessary, GC should handle the instance

		for t = (endTxt or self.interfaceId), (iniTxt or self.initInterfaceId), -1 do
			removeTextArea(t, self.playerName)
		end

		local interfaceImages = self.interfaceImages
		for i = (endImg or self.totalInterfaceImages), (iniImg or 1), -1 do
			removeImage(interfaceImages[i])
		end
	end

	prettyUI.addTextArea = function(self, ...)
		self.interfaceId = self.interfaceId + 1
		addTextArea(self.interfaceId, ...)

		if self.isCheckingDeletableContent and not self.firstDeletableTextArea then
			self.firstDeletableTextArea = self.interfaceId
		end

		return self.interfaceId
	end

	prettyUI.addImage = function(self, ...)
		self.totalInterfaceImages = self.totalInterfaceImages + 1

		local image = addImage(...)
		self.interfaceImages[self.totalInterfaceImages] = image

		if self.isCheckingDeletableContent and not self.firstDeletableImage then
			self.firstDeletableImage = self.totalInterfaceImages
		end

		return image
	end

	local callback = "<textformat leftmargin='1' rightmargin='1'><a href='event:%s'>%s"
	prettyUI.rawAddClickableTextArea = function(callbackName, playerName, x, y, w, h, _self, _f,
		_id)
		(_f or _self.addTextArea)((_id or _self), format(callback, callbackName, rep('\n', h / 10)),
			playerName, x - 5, y - 5, w + 5, h + 5, 1, 1, 0, true)
	end

	prettyUI.addClickableImage = function(self, image, target, x, y, playerName, w, h, callbackName,
		callbackCondition, ...)
		self:addImage(image, target, x, y, playerName, ...)
		if callbackCondition == nil or callbackCondition then
			self.rawAddClickableTextArea(callbackName, playerName, x, y, w, h, self)
		end
		return self
	end

	prettyUI.setButton = function(self, name, xAxis, callback, ...)
		local button = self:addClickableImage(interfaceImages[name], imageTargets.interfaceIcon,
			self.x + self.w - (xAxis or 12), self.y - 15 + (self.totalButtons * 28),
			self.playerName, 30, 30, callback, nil, ...)

		self.totalButtons = self.totalButtons + 1

		return button
	end

	prettyUI.setCloseButton = function(self, xAxis)
		return self:setButton("xButton", xAxis, "closeInterface")
	end

	prettyUI.markDeletableContent = function(self, bool)
		if not bool and self.isCheckingDeletableContent then
			-- Assuming at least one of each has been used...
			self.lastDeletableTextArea = self.interfaceId
			self.lastDeletableImage = self.totalInterfaceImages
		end
		self.isCheckingDeletableContent = bool
		return self
	end

	prettyUI.deleteDeletableContent = function(self)
		if self.isCheckingDeletableContent then
			self
				:markDeletableContent(false)
				:remove(self.firstDeletableImage, self.lastDeletableImage,
					self.firstDeletableTextArea, self.lastDeletableTextArea)
			self.firstDeletableImage, self.lastDeletableImage, self.firstDeletableTextArea,
				self.lastDeletableTextArea = nil, nil, nil, nil
		end
		return self
	end
end