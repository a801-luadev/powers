-- Level 0
do
	local wind = function(x, y, direction)
		for i = 1, 6, (isLowQuality and 1.5 or 1) do
			displayParticle(35, x, y, direction, i * (i < 4 and -1 or 1))
		end
	end

	powers.lightSpeed = Power
		.new("lightSpeed", powerType.def, 0, {
			icon = "155d0565587.png",
			x = 275,
			y = 108
		})
		:setUseCooldown(1.5)
		:setBind(0, 2)
		:setKeySequence({ { 0, 0, 0 }, { 2, 2, 2 } })
		:setEffect(function(playerName, x, y, isFacingRight)
			-- Move player
			movePlayer(playerName, x + (isFacingRight and 200 or -200), y)

			-- Move players
			local direction = (isFacingRight and 30 or -30)
			for name in next, getPlayersOnFilter(playerName, inRectangle, x, y - 60, 200, 120,
				isFacingRight) do
				movePlayer(name, 0, 0, true, direction)
			end

			-- Particles
			wind(x, y, (isFacingRight and 15 or -15))
		end)
end

do
	local beam = function(x, y, direction)
		local xSpeed = .25 * direction
		local xAcceleration = .3 * direction
		local r = 10
		for i = 1, 10, (isLowQuality and 2.5 or 1) do
			r = r * .75
			displayParticle(9, x - (-30 + i + r)*direction, y, i*xSpeed, 0, xAcceleration)
		end
	end

	powers.ray = Power
		.new("ray", powerType.atk, 0, {
			icon = "155d0567651.png",
			x = 265,
			y = 125
		})
		:setDamage(5)
		:setUseCooldown(1)
		:setBind(string.byte(' '))
		:setEffect(function(_, x, y, isFacingRight)
			local direction = (isFacingRight and 1 or -1)
			y = y - 10

			-- Particles
			beam(x, y, direction)

			-- Collision
			timer.start(removeObject, 1000, 1, addShamanObject(6000, x + 40*direction, y, 0,
				9 * direction))

			-- Damage
			return inRectangle, x, y - 10, 120, 40, isFacingRight
		end)
end

-- Level 10
do
	local particles = { 0, 4, 11 }
	local totalParticles = #particles

	local auxSpeedRad = rad(18)
	local spiral = function(x, y, angle)
		angle = rad(angle)

		local auxSpeed, auxRad = 0
		for i = 1, 40, (isLowQuality and 2 or 1) do
			auxSpeed = i * .1

			auxRad = angle + auxSpeedRad*i

			displayParticle(particles[(i%totalParticles + 1)], x, y, auxSpeed * cos(auxRad),
				auxSpeed * sin(auxRad))
		end
	end

	powers.wormHole = Power
		.new("wormHole", powerType.def, 10, {
			icon = "155d055f8d0.png",
			x = 300,
			y = 105
		})
		:setUseCooldown(1.5)
		:setBind(1, 3)
		:setKeySequence({ { 1, 3 }, { 3, 1 } })
		:setEffect(function(playerName, x, y, isFacingRight)
			local direction = (isFacingRight and 200 or -200)

			-- Move player
			movePlayer(playerName, x + direction, y, false, 0, -50, false)

			-- Particles
			spiral(x, y, 270)
			spiral(x + direction, y, 90)
		end)
end

do
	local particles = { 2, 11, 2 }
	local totalParticles = #particles

	local spring = function(x, y)
		for i = 1, 10, (isLowQuality and 2 or 1) do
			displayParticle(particles[(i%totalParticles + 1)], x + cos(i)*10, y, 0, -i * .3)
		end
	end

	powers.doubleJump = Power
		.new("doubleJump", powerType.def, 10, {
			icon = "155d0560b19.png",
			x = 310,
			y = 110
		})
		:setUseCooldown(5)
		:setBind(1)
		:setKeySequence({ { 1, 1 } })
		:setEffect(function(playerName, x, y)
			-- Move player
			movePlayer(playerName, 0, 0, true, 0, -50, false)

			-- Particles
			spring(x, y)
		end)
end

-- Level 20
do
	local particles = { 2, 0, 0, 2 }
	local totalParticles = #particles

	local auxSpeedRad = rad(18)
	local spiral = function(x, y, angle, direction)
		angle = rad(angle)

		local xAcceleration = .4 * direction
		local yAcceleration = -.2

		local auxXSpeed, auxYSpeed, auxCosRad, auxSinRad = 0, 0
		for i = 1, 40, (isLowQuality and 2 or 1) do
			auxYSpeed = i * .1
			auxXSpeed = auxYSpeed * direction

			auxCosRad = angle + auxSpeedRad*i
			auxSinRad = angle - auxSpeedRad*i

			displayParticle(particles[(i%totalParticles + 1)], x + i*direction, y - i,
				auxXSpeed * cos(auxCosRad), auxYSpeed * sin(auxSinRad), xAcceleration,
				yAcceleration)
		end
	end

	powers.helix = Power
		.new("helix", powerType.def, 20, {
			icon = "155d056201e.png",
			x = 300,
			y = 105
		})
		:setUseCooldown(2.5)
		:setBind(16) -- Shift
		:setEffect(function(playerName, x, y, isFacingRight)
			local direction = (isFacingRight and 1 or -1)

			-- Move player
			movePlayer(playerName, 0, 0, true, 100 * direction, -115, false)

			-- Particles
			spiral(x, y, 200, direction)
		end)
end

do
	local circle = function(x, y, dimension)
		local xPos, yPos
		for i = 90, 110, (isLowQuality and 1.75 or 1) do
			xPos = cos(i) * dimension
			yPos = sin(i) * dimension
			displayParticle(2, x + xPos, y + yPos)
		end

		local yTop = y - dimension
		local yBottom = y + dimension

		local xLeft = x - dimension
		local xRight = x + dimension

		dimension = dimension / 100

		local bottomRight, topLeft
		for i = 1, 5, (isLowQuality and 2 or 1) do
			bottomRight = i * dimension
			topLeft = -i * dimension
			displayParticle(11, x, yTop, 0, bottomRight)
			displayParticle(11, x, yBottom, 0, topLeft)
			displayParticle(11, xLeft, y, bottomRight)
			displayParticle(11, xRight, y, topLeft)
		end
	end

	powers.dome = Power
		.new("dome", powerType.atk, 20, {
			icon = "155d05689b8.png",
			x = 295,
			y = 105
			})
		:setDamage(5)
		:setUseLimit(15)
		:setUseCooldown(4)
		:setBind("^PRO+TE+CTO+S$")
		:setEffect(function(_, x, y)
			local dimension = 80

			-- Particles
			circle(x, y, dimension)

			-- Damage
			explosion(x, y, -40, dimension)
			return pythagoras, x, y, dimension
		end)
end

-- Level 30
do
	local particles = { 2, 11 }
	local totalParticles = #particles

	local lightning = function(x, y)
		local yPos, rand = 0

		local randMin, randMax
		if isLowQuality then
			randMin, randMax = 5, 7
		else
			randMin, randMax = 3, 5
		end

		local init = random(500)
		for i = init, init + 125, randMax do
			yPos = yPos + random(randMin, randMax)
			displayParticle(particles[i%totalParticles + 1], x + cos(i)*random(3, 6), y + yPos)
		end
	end

	powers.lightning = Power
		.new("lightning", powerType.atk, 30, {
			icon = "155d05699c9.png",
			x = 325,
			y = 105
		})
		:setDamage(10)
		:setUseLimit(10)
		:setUseCooldown(5)
		:setClickRange(150)
		:setEffect(function(_, x, y)
			-- Particles
			lightning(x, y)

			-- Damage
			y = y + 100
			explosion(x, y, 30, 60)
			return pythagoras, x, y, 60
		end)
end

-- Level 40
do
	local auxSpeedRad = rad(18)
	local doubleSpiral = function(x, y, xAngleRight, xAngleLeft, yAngle)
		xAngleRight = rad(xAngleRight)
		xAngleLeft = rad(xAngleLeft)
		yAngle = rad(yAngle)

		local auxSpeed, auxCosRadLeft, auxCosRadRight, auxSinRad = 0
		local particle

		for i = 1, 38, (isLowQuality and 4 or 2) do
			auxSpeed = i * .1

			auxCosRadRight = xAngleRight + auxSpeedRad*i
			auxCosRadLeft = xAngleLeft - auxSpeedRad*i

			auxSinRad = yAngle - auxSpeedRad*i
			auxSinRad = auxSpeed * sin(auxSinRad)

			particle = (i < 3 and 13 or i < 20 and 11 or 2)

			displayParticle(particle, x, y, auxSpeed * cos(auxCosRadRight), auxSinRad)
			displayParticle(particle, x, y, auxSpeed * cos(auxCosRadLeft), auxSinRad)
		end
	end

	powers.superNova = Power
		.new("superNova", powerType.atk, 40, {
			icon = "155d055d277.png",
			x = 288,
			y = 105
		})
		:setDamage(20)
		:setSelfDamage(5)
		:setUseLimit(6)
		:setUseCooldown(6)
		:setBind(17) -- Control
		:setEffect(function(_, x, y, isFacingRight)
			local direction = (isFacingRight and 50 or -50)
			x = x + direction
			y = y - 50

			-- Particles
			doubleSpiral(x, y, 120, 60, 120)

			-- Damage
			explosion(x, y, 50, 110)
			return pythagoras, x, y, 70
		end)
end

-- Level 50
do
	local smashDamage = function(playerName)
		local rand = random(50, 100)
		movePlayer(playerName, 0, 0, true, 0, -rand, true)
		return rand > 69
	end

	local dust = function(x, y)
		for i = 1, 10, (isLowQuality and 2 or 1) do
			displayParticle(3, x + cos(i) * 100, y + random(-30, 30))
		end
	end

	powers.hulkSmash = Power
		.new("hulkSmash", powerType.atk, 50, {
			icon = "155d055e49f.png",
			x = 295,
			y = 105
		})
		:setDamage(20)
		:setSelfDamage(5)
		:setUseLimit(10)
		:setUseCooldown(8)
		:setBind(3)
		:setKeySequence({ { 3, 3 } })
		:setEffect(function(playerName, x, y, _, self)
			-- Super jump
			movePlayer(playerName, 0, 0, true, 0, -110, true)
			-- Super smash
			timer.start(movePlayer, 500, 1, playerName, 0, 0, true, 0, 400, false)
			-- Damage
			timer.start(self.damagePlayers, 1000, 1, self, playerName, { smashDamage, inRectangle,
				x - 100, y - 60, 200, 100, true }, damagePlayersWithAction)
			-- Particles
			timer.start(dust, 1000, 1, x, y)

			return false
		end)
end

-- Level 60
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
			if random(8) == random(8) then
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
		.new("gravitationalAnomaly", powerType.divine, 60, {
			icon = "155d05645e0.png",
			x = 270,
			y = 130
		}, {
			spawnableObjects = {
				enum_shamanObject.littleBox,
				enum_shamanObject.box,
				enum_shamanObject.littleBoard,
				enum_shamanObject.board,
				enum_shamanObject.ball,
				enum_shamanObject.trampoline,
				enum_shamanObject.anvil,
				enum_shamanObject.cannon,
				enum_shamanObject.bomb,
				enum_shamanObject.balloon,
				enum_shamanObject.rune,
				enum_shamanObject.chicken,
				enum_shamanObject.snowBall,
				enum_shamanObject.cupidonArrow,
				enum_shamanObject.apple,
				enum_shamanObject.sheep,
				enum_shamanObject.littleBoardIce,
				enum_shamanObject.littleBoardChocolate,
				enum_shamanObject.iceCube,
				enum_shamanObject.cloud,
				enum_shamanObject.bubble,
				enum_shamanObject.tinyBoard,
				enum_shamanObject.companionCube,
				enum_shamanObject.stableRune,
				enum_shamanObject.balloonFish,
				enum_shamanObject.longBoard,
				enum_shamanObject.triangle,
				enum_shamanObject.sBoard,
				enum_shamanObject.rock,
				enum_shamanObject.pumpkinBall,
				enum_shamanObject.tombstone,
				enum_shamanObject.paperBall,
				96, -- Mouse cube
				97 -- Energy orb
			},
			availablePlusIds = {
				enum_particle.plus1,
				enum_particle.plus10,
				enum_particle.plus12,
				enum_particle.plus14,
				enum_particle.plus16
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
		:setProbability(60)
		:setEffect(function(self)
			canTriggerPowers = false
			timer.start(anomaly, 500, 1/self.opacityFrame, self, (isLowQuality and 1 or 3))
		end)
end

-- Level 70
do
	local ray = function(x, y, width, height, direction)
		width = width * direction

		local ySin = 0
		local xPos = x
		local yPos = 0
		local xSpeed = 0
		local ySpeed = 0

		local xDirection = .1 * direction

		for i = 0, 12 do
			displayParticle(9, xPos, y + yPos, xSpeed, -ySpeed)

			i = i + 1
			ySin = sin(i)
			xPos = x + i*width
			yPos = ySin*height
			xSpeed = i * xDirection
			ySpeed = ySin * .55

			displayParticle(2, xPos, y - yPos, xSpeed, ySpeed)
		end

		xSpeed = width/2 + direction
		for i = 1, 2 do
			displayParticle(13, x, y, xSpeed)
		end
	end

	powers.deathRay = Power
		.new("deathRay", powerType.atk, 70, {
			icon = "155d05633dc.png",
			x = 270,
			y = 140
		})
		:setDamage(30)
		:setSelfDamage(15)
		:setUseLimit(1)
		:setUseCooldown(10)
		:setBind(string.byte('P'))
		--:setKeySequence()
		:setEffect(function(_, x, y, isFacingRight)
			-- Particles
			ray(x, y, 10, 8, (isFacingRight and 1 or -1))

			-- Damage
			return inRectangle, x, y - 40, 170, 80, isFacingRight
		end)
end

-- Level 80
do
	local beanstalk = function(self, timer)
		if timer.times == 0 then
			for name in next, players.room do
				changePlayerSize(name, 1)
			end
			resetPlayersDefaultSize = false
		else
			for name in next, players.alive do
				changePlayerSize(name, random(5, 35) / 10)
			end
		end
	end

	powers.beanstalk = Power
		.new("beanstalk", powerType.divine, 80, {
			icon = '',
			x = 0,
			y = 0
		}, {
			seconds = 10
		})
		:setUseCooldown(25)
		:setProbability(50)
		:setEffect(function(self)
			resetPlayersDefaultSize = true
			timer.start(beanstalk, 500, self.seconds * 2, self)
		end)
end

-- Level 100
do
	powers.raiseOfTheDead = Power
		.new("raiseOfTheDead", powerType.divine, 100, {
			icon = '',
			x = 0,
			y = 0
		}, {
			seconds = 10,
			playerHealthPoints = 35,
			minDeadMice = 2
		})
		:setUseCooldown(45)
		:setProbability(100)
		:setEffect(function(self)
			if players._count.dead < self.minDeadMice then return end
			local deadMice = players.dead

			-- Respawns dead mice
			local firstPlayer = next(deadMice, nil)
			local player = firstPlayer
			local lastName

			while player do
				respawnPlayer(player)
				addHealth(player, playerCache[player], self.playerHealthPoints)

				lastPlayer = player
				player = next(deadMice, player)

				linkMice((player or firstPlayer), lastPlayer, true)
			end
		end)
end