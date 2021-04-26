-- Level 80
do
	local heart = function(x, y, dimension)
		local xShape, yShape
		for i = 0, 2 * pi, (isLowQuality and .5 or .35) do
			xShape = sin(i) ^ 3
			yShape = 13*cos(i) - 5*cos(2*i) - 2*cos(3*i)

			displayParticle(5, x + 16*xShape*dimension, y - yShape*dimension, -xShape * 2,
				yShape * .12)
		end
	end

	powers.soulSucker = Power
		.new("soulSucker", powerType.def, 80, {
			smallIcon = "177b280abb3.png",
			icon = "177b2763304.png",
			iconWidth = 77,
			iconHeight = 67
		}, {
			healthPoints = 5
		})
		:setSelfDamage(10)
		:setUseLimit(1)
		:setUseCooldown(25)
		:setProbability(10)
		:bindKeyboard(keyboard.left, keyboard.up, keyboard.right, keyboard.dowm)
		:setKeySequence({
			{ keyboard.right, keyboard.up, keyboard.right, keyboard.down, keyboard.left },
			{ keyboard.left, keyboard.up, keyboard.left, keyboard.down, keyboard.right }
		})
		:setEffect(function(playerName, x, y, _, _, cache)
			-- Particles
			heart(x, y, 4)

			cache.spawnHearts = true
		end)
end