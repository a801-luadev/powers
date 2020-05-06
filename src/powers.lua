local powerTypes = {
	def = 0,
	atk = 1,
	divine = 2
}

local powers = { }

-- Level 0
do
	local wind = function(x, y, direction)
		for i = 1, 6, (isLowQuality and 1.5 or 1) do
			displayParticle(35, x, y, direction, i * (i < 4 and -1 or 1))
		end
	end

	powers.lightSpeed = Power
		.new("lightSpeed", powerTypes.def, 0, {
			icon = "155d0565587.png",
			x = 275,
			y = 108
		})
		:setUseCooldown(1.5)
		:setBind(0, 2)
		:setKeySequence({ 0, 0 }, { 2, 2 })
		:setEffect(function(playerName, x, y, isFacingRight)
			-- Move player
			movePlayer(playerName, x + (isFacingRight and 255 or -255), y)

			-- Move players
			local direction = (isFacingRight and 30 or -30)
			for playerName in next, getPlayersOnFilter(playerName, inRectangle, x, y - 60, 255, 120,
				isFacingRight) do
				movePlayer(playerName, 0, 0, true, direction)
			end

			-- Particles
			wind(x, y, (isFacingRight and 15 or -15))
		end)
end

do
	local beam = function(x, y, direction)
		local xSpeed = .2 * direction
		local xAcceleration = .3 * direction
		local r = 10
		for i = 1, 10, (isLowQuality and 2.5 or 1) do
			r = r * .75
			displayParticle(9, x - (-30 + i + r)*direction, y, i*xSpeed, 0, xAcceleration)
		end
	end

	powers.ray = Power
		.new("ray", powerTypes.atk, 0, {
			icon = "155d0567651.png",
			x = 265,
			y = 125
		})
		:setDamage(5)
		:setUseCooldown(1)
		:setBind(string.byte(' '))
		:setKeySequence()
		:setEffect(function(playerName, x, y, isFacingRight)
			local direction = (isFacingRight and 1 or -1)
			y = y - 10

			-- Particles
			beam(x, y, direction)

			-- Collision
			timer.start(removeObject, 6000, 1,
				addShamanObject(6000, x + 40*direction, y, 0, 9 * direction))

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
		.new("wormHole", powerTypes.def, 10, {
			icon = "155d055f8d0.png",
			x = 300,
			y = 105
		})
		:setUseCooldown(1.5)
		:setBind(2)
		:setKeySequence({ 1, 2 })
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
		.new("doubleJump", powerTypes.def, 10, {
			icon = "155d0560b19.png",
			x = 310,
			y = 110
		})
		:setUseCooldown(3)
		:setBind(1)
		:setKeySequence({ 1, 1 })
		:setEffect(function(playerName, x, y, isFacingRight)
			-- Move player
			movePlayer(playerName, 0, 0, true, 0 -50, false)

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
		.new("helix", powerTypes.def, 20, {
			icon = "155d056201e.png",
			x = 300,
			y = 105
		})
		:setUseCooldown(2.5)
		:setBind(16)
		:setKeySequence()
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
		.new("dome", powerTypes.atk, 20, {
			icon = "155d05689b8.png",
			x = 295,
			y = 105
			})
		:setDamage(5)
		:setUseLimit(15)
		:setUseCooldown(4)
		:setEffect(function(playerName, x, y, isFacingRight)
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
		local init = random(500)
		for i = init, init + 125, (isLowQuality and 10 or 5) do
			yPos = yPos + random(3, 5)
			displayParticle(particles[i%totalParticles + 1], x + cos(i)*random(3, 6), y + yPos)
		end
	end

	powers.lightning = Power
		.new("lightning", powerTypes.atk, 30, {
			icon = "155d05699c9.png",
			x = 325,
			y = 105
		})
		:setDamage(10)
		:setUseLimit(10)
		:setUseCooldown(5)
		:setBind()
		:setEffect(function(playerName, x, y, isFacingRight)
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
		.new("superNova", powerTypes.atk, 40, {
			icon = "155d055d277.png",
			x = 288,
			y = 105
		})
		:setDamage(20)
		:selfDamage(5)
		:setUseLimit(6)
		:setUseCooldown(6)
		:setBind(17)
		:setKeySequence()
		:setEffect(function(playerName, x, y, isFacingRight)
			local direction = (isFacingRight and 50 or -50)
			x = x + direction
			y = y + direction

			-- Particles
			doubleSpiral(x, y, 120, 60, 120)

			-- Damage
			explosion(x, y, 50, 110)
			return pythagoras, x, y, 70
		end)
end

-- Level 50
	powers.hulkSmash = Power
		.new("hulkSmash", powerTypes.atk, 50, {
			icon = "155d055e49f.png",
			x = 295,
			y = 105
		})
		:setDamage(20)
		:setUseLimit(10)
		:setUseCooldown(8)
		:setBind(3)
		:setKeySequence({3, 3})

	powers.deathHug = Power
		.new("deathHug", powerTypes.atk, 50, {
			icon = "155d0566680.png",
			x = 295,
			y = 105
		})
		:setUseLimit(1)
		:setUseCooldown(15)

-- Level 60
	powers.anomaly = Power
		.new("anomaly", powerTypes.divine, 60, {
			icon = "155d05645e0.png",
			x = 270,
			y = 130
		})
		:setUseLimit(1)
		:setUseCooldown(10)

-- Level 70
	powers.deathRay = Power
		.new("deathRay", powerTypes.atk, 70, {
			icon = "155d05633dc.png",
			x = 270,
			y = 140
		})
		:setDamage(50)
		:selfDamage(10)
		:setUseLimit(1)
		:setUseCooldown(10)
		:setBind(string.byte('P'))
		:setKeySequence()