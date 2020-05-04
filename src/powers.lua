local powerTypes = {
	def = 0,
	atk = 1,
	divine = 2
}

local powers = { }

-- Level 0
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
		-- Move players
		local direction = (isFacingRight and 30 or -30)
		for playerName in next, getPlayersOnFilter(playerName, inRectangle, x, y - 60, 255, 120,
			isFacingRight) do
			movePlayer(playerName, 0, 0, true, direction)
		end

		-- Move player
		movePlayer(playerName, x + (isFacingRight and 255 or -255), y)

		-- Particles
		direction = (isFacingRight and 15 or -15)
		for i = 1, 6, (isLowQuality and 6/4 or 1) do
			displayParticle(35, x, y, direction, i*(i < 4 and -1 or 1))
		end
	end)

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
		local xSpeed = .2*direction
		local xAcceleration = .3*direction
		local r = 10
		for i = 1, 10, (isLowQuality and 10/4 or 1) do
			r = r * .75
			displayParticle(9, x - (-30 + i + r)*direction, y, i*xSpeed, 0, xAcceleration)
		end

		-- Collision
		timer.start(removeObject, 6000, 1,
			addShamanObject(6000, x + 40*direction, y, 0, 9*direction))

		-- Damage
		return inRectangle, x, y - 10, 120, 40, isFacingRight
	end)

-- Level 10
powers.wormHole = Power
	.new("wormHole", powerTypes.def, 10, {
		icon = "155d055f8d0.png",
		x = 300,
		y = 105
	})
	:setUseCooldown(1.5)
	:setBind(2)
	:setKeySequence({ 1, 2 })

powers.doubleJump = Power
	.new("doubleJump", powerTypes.def, 10, {
		icon = "155d0560b19.png",
		x = 310,
		y = 110
	})
	:setUseCooldown(3)
	:setBind(1)
	:setKeySequence({ 1, 1 })

-- Level 20
powers.helix = Power
	.new("helix", powerTypes.def, 20, {
		icon = "155d056201e.png",
		x = 300,
		y = 105
	})
	:setUseCooldown(2.5)
	:setBind(16)
	:setKeySequence()

powers.dome = Power
	.new("dome", powerTypes.atk, 20, {
		icon = "155d05689b8.png",
		x = 295,
		y = 105
	})
	:setDamage(5)
	:setUseLimit(15)
	:setUseCooldown(4)

-- Level 30
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

-- Level 40
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