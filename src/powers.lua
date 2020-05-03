local powerTypes = {
	def = 0,
	atk = 1,
	divine = 2
}

local powers = { }

-- Level 0
powers.lightSpeed = Power
	.new(powerTypes.def, 0, {
		icon = "155d0565587.png",
		x = 275,,
		y = 108
	})
	:setUseCooldown(1.5)

powers.ray = Power
	.new(powerTypes.atk, 0, {
		icon = "155d0567651.png",
		x = 265,
		y = 125
	})
	:setDamage(5)
	:setUseCooldown(1)

-- Level 10
powers.wormHole = Power
	.new(powerTypes.def, 10, {
		icon = "155d055f8d0.png",
		x = 300,
		y = 105
	})
	:setUseCooldown(1.5)

powers.doubleJump = Power
	.new(powerTypes.def, 10, {
		icon = "155d0560b19.png",
		x = 310,
		y = 110
	})
	:setUseCooldown(3)

-- Level 20
powers.helix = Power
	.new(powerTypes.def, 20, {
		icon = "155d056201e.png",
		x = 300,
		y = 105
	})
	:setUseCooldown(2.5)

powers.dome = Power
	.new(powerTypes.atk, 20, {
		icon = "155d05689b8.png",
		x = 295,
		y = 105
	})
	:setDamage(5)
	:setUseLimit(15)
	:setUseCooldown(4)

-- Level 30
powers.lightning = Power
	.new(powerTypes.atk, 30, {
		icon = "155d05699c9.png",
		x = 325,
		y = 105
	})
	:setDamage(10)
	:setUseLimit(10)
	:setUseCooldown(5)

-- Level 40
powers.superNova = Power
	.new(powerTypes.atk, 40, {
		icon = "155d055d277.png",
		x = 288,
		y = 105
	})
	:setDamage(20)
	:selfDamage(5)
	:setUseLimit(6)
	:setUseCooldown(6)

-- Level 50
powers.hulkSmash = Power
	.new(powerTypes.atk, 50, {
		icon = "155d055e49f.png",
		x = 295,
		y = 105
	})
	:setDamage(20)
	:setUseLimit(10)
	:setUseCooldown(8)

powers.deathHug = Power
	.new(powerTypes.atk, 50, {
		icon = "155d0566680.png",
		x = 295,
		y = 105
	})
	:setUseLimit(1)
	:setUseCooldown(15)

-- Level 60
powers.anomaly = Power
	.new(powerTypes.divine, 60, {
		icon = "155d05645e0.png",
		x = 270,
		y = 130
	})
	:setUseLimit(1)
	:setUseCooldown(10)

-- Level 70
powers.deathRay = Power
	.new(powerTypes.atk, 70, {
		icon = "155d05633dc.png",
		x = 270,
		y = 140
	})
	:setDamage(50)
	:selfDamage(10)
	:setUseLimit(1)
	:setUseCooldown(10)