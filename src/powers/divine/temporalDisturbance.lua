-- Level 130
do
	local extractAllPlayerInfo = function(self, timer)
		local players, index, tmpCache = {
			_remainingTime = unrefreshableTimer.remainingMapTime/1000 + 3
		}, 0
		for p, v in next, room.playerList do
			tmpCache = playerCache[p]
			if tmpCache then
				index = index + 1
				players[index] = {
					playerName = p,
					isDead = v.isDead,
					hasCheese = v.hasCheese,
					x = v.x,
					y = v.y,
					vx = v.vx,
					vy = v.vy,
					cache = tmpCache,
					health = tmpCache.health
				}
			end
		end

		self.extractedData[#self.extractedData + 1] = players
	end

	local updateHoldingTime = function(self, timer)
		local lastTime = timer.times + 1
		if lastTime % self.extractionInterval == 0 then
			extractAllPlayerInfo(self, timer)
		end

		if timer.times > 0 then
			self:updateTriggerImage(lastTime / self.holdingMaxTime)
		else
			self:breakProcess()
		end
	end

	local changeMapState = function(self, timer)
		local mapData = self.extractedData[timer.times + 1]

		canTriggerPowers = timer.times == 0
		local velocityMultiplier = canTriggerPowers and 1 or 0

		local tmpPlayerName
		for p = 1, #mapData do
			p = mapData[p]

			tmpPlayerName = p.playerName
			if p.isDead then
				killPlayer(tmpPlayerName)
			else
				respawnPlayer(tmpPlayerName)
				freezePlayer(tmpPlayerName, not canTriggerPowers)
				addHealth(tmpPlayerName, p.cache, p.health - p.cache.health)

				if p.hasCheese then
					giveCheese(tmpPlayerName)
				else
					removeCheese(tmpPlayerName)
				end

				movePlayer(tmpPlayerName, p.x, p.y, false, 1 + p.vx*velocityMultiplier,
					1 + p.vy*velocityMultiplier, false)
			end
		end

		setGameTime(mapData._remainingTime)
		if canTriggerPowers then
			setWorldGravity()
		end
	end

	powers.temporalDisturbance = Power
		.new("temporalDisturbance", powerType.divine, 130, {
			smallIcon = "179164a4cae.png",
			icon = "1791664ddd4.png",
			iconWidth = 110,
			iconHeight = 99
		}, {
			holdingMaxTime = 20,

			extractionInterval = 1,

			breakProcess = function(self)
				if self.updateTimer then
					timer:delete(self.updateTimer)
					self.updateTimer = nil
				end

				if self.triggerImage then
					removeTextArea(textAreaId.temporalDisturbance)
					removeImage(self.triggerImage)
					self.triggerImage = nil
				end
			end,

			updateTriggerImage = function(self, opacity)
				if self.triggerImage then
					removeImage(self.triggerImage)
				end

				self.triggerImage = addImage(self.imageData.smallIcon, imageTargets.interfaceIcon,
					770, 370, self.playerName, nil, nil, nil, opacity)
			end,

			backInTime = function(self)
				local dataLen = #self.extractedData
				if dataLen == 0 then return end
				self:breakProcess()

				canTriggerPowers = false

				-- Don't let people move
				setWorldGravity(0, 0)
				timer:start(changeMapState, 0, dataLen, self)

				if not isReviewMode then
					giveBadge(self.playerName, "chronos")
				end
			end,

			triggerImage = nil
		}, {
			playerName = false,
			updateTimer = false,

			extractedData = { }
		})
		:setUseCooldown(30)
		:setProbability(28)
		:bindChatMessage("^T+I+M+E+ L+O+R+D+$")
		:setEffect(function(self, playerName)
			self.playerName = playerName

			prettyUI.rawAddClickableTextArea("temporalDisturbance", playerName, 770, 370, 30,
				30, nil, addTextArea, textAreaId.temporalDisturbance)

			self:updateTriggerImage()

			self.updateTimer = timer:start(updateHoldingTime, 1000, self.holdingMaxTime, self)
		end)
end