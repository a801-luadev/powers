-- Level 120
do
	local anomaly = function(self, newItems, timer)
		if timer.times == 0 then
			canTriggerPowers = true

			removeTextArea(textAreaId.gravitationalAnomaly)

			for i = 1, self.despawnLen do
				removeObject(self.despawnObjects[i])
			end
			-- It will be reset in the next round, divine powers can only be used once.
			-- Setting it to nil will avoid creating an unnecessary table, and will call the GC.
			self.despawnObjects = nil

			local cache
			for playerName in next, players.alive do
				cache = playerCache[playerName]
				if cache.extraHealth > 0 then
					addHealth(playerName, cache)
				end
			end
		else
			self.opacity = self.opacity - self.opacityFrame

			-- Prevents clicking
			addTextArea(textAreaId.gravitationalAnomaly, '', nil, -1500, -1500, 3000, 3000, 1, 1,
				self.opacity, true)

			-- Spawns random objects
			for i = 1, newItems do
				self.despawnObjects[self.despawnLen + i] = addShamanObject(
					table_random(self.spawnableObjects), random(5, 795), random(30, 380),
					random(360), random(-7, 7), random(-5, 5))
			end
			self.despawnLen = self.despawnLen + newItems

			-- Explosion
			local expX, expY, expR = random(15, 785), random(30, 380), random(150, 500)
			explosion(expX, expY, random(-40, 40), expR)

			-- Extra life
			if random(6) == random(6) then
				local rand
				for name, cache in next, getPlayersOnFilter(nil, pythagoras, expX, expY, expR) do
					rand = random(1, self.totalPlusIds)
					cache.extraHealth = cache.extraHealth + self.availableHealthPoints[rand]
					displayParticle(self.availablePlusIds[rand], expX, expY, 0, 0, 0, 0, name)
				end
			end
		end
	end

	powers.gravitationalAnomaly = Power
		.new("gravitationalAnomaly", powerType.divine, 120, {
			smallIcon = "172499d5f79.png",
			icon = "172baf82263.jpg",
			iconWidth = 72,
			iconHeight = 80
		}, {
			spawnableObjects = {
				tfm.enum.shamanObject.littleBox,
				tfm.enum.shamanObject.box,
				tfm.enum.shamanObject.littleBoard,
				tfm.enum.shamanObject.board,
				tfm.enum.shamanObject.ball,
				tfm.enum.shamanObject.trampoline,
				tfm.enum.shamanObject.anvil,
				tfm.enum.shamanObject.cannon,
				tfm.enum.shamanObject.bomb,
				tfm.enum.shamanObject.balloon,
				tfm.enum.shamanObject.rune,
				tfm.enum.shamanObject.chicken,
				tfm.enum.shamanObject.snowBall,
				tfm.enum.shamanObject.cupidonArrow,
				tfm.enum.shamanObject.apple,
				tfm.enum.shamanObject.sheep,
				tfm.enum.shamanObject.littleBoardIce,
				tfm.enum.shamanObject.littleBoardChocolate,
				tfm.enum.shamanObject.iceCube,
				tfm.enum.shamanObject.cloud,
				tfm.enum.shamanObject.bubble,
				tfm.enum.shamanObject.tinyBoard,
				tfm.enum.shamanObject.companionCube,
				tfm.enum.shamanObject.stableRune,
				tfm.enum.shamanObject.balloonFish,
				tfm.enum.shamanObject.longBoard,
				tfm.enum.shamanObject.triangle,
				tfm.enum.shamanObject.sBoard,
				tfm.enum.shamanObject.rock,
				tfm.enum.shamanObject.pumpkinBall,
				tfm.enum.shamanObject.tombstone,
				tfm.enum.shamanObject.paperBall,
				96, -- Mouse cube
				97 -- Energy orb
			},
			availablePlusIds = {
				tfm.enum.particle.plus1,
				tfm.enum.particle.plus10,
				tfm.enum.particle.plus12,
				tfm.enum.particle.plus14,
				tfm.enum.particle.plus16
			},
			availableHealthPoints = {
				[1] = 1,
				[2] = 10,
				[3] = 12,
				[4] = 14,
				[5] = 16
			},
			totalPlusIds = 5,
			opacityFrame = 0.05
		}, {
			opacity = 1,
			despawnObjects = { },
			despawnLen = 0
		})
		:setUseCooldown(25)
		:setProbability(30)
		:bindChatMessage("^A+N+O+M+A+L+Y+$")
		:setEffect(function(self, playerName)
			canTriggerPowers = false
			timer:start(anomaly, 500, 1/self.opacityFrame, self, (isLowQuality and 1 or 3))

			if not isReviewMode then
				giveBadge(playerName, "anomaly")
			end
		end)
end