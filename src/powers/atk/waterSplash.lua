-- Level 90
do
	local circle = function(x, y, dimension)
		local xCos, ySin
		for i = 90, 110, (isLowQuality and 1.75 or 1) do
			xCos = cos(i)
			ySin = sin(i)

			displayParticle(14, x + xCos*dimension, y + ySin*dimension, xCos * -5, ySin * -5)
		end
	end

	local freeze = function(playerName)
		freezePlayer(playerName)
		timer:start(freezePlayer, 1500, 1, playerName, false)
		return true
	end

	powers.waterSplash = Power
		.new("waterSplash", powerType.atk, 90, {
			smallIcon = "172cec7920e.png",
			icon = "172ced1ac40.jpg",
			iconWidth = 70,
			iconHeight = 70
		})
		:setDamage(20)
		:setSelfDamage(15)
		:setUseLimit(1)
		:setUseCooldown(20)
		:bindKeyboard(keyboard.left, keyboard.right, keyboard.down)
		:setKeySequence({
			{ keyboard.right, keyboard.left, keyboard.down, keyboard.right },
			{ keyboard.left, keyboard.right, keyboard.down, keyboard.left }
		})
		:setEffect(function(playerName, x, y, _, self)
			local dimension = 60

			-- Particles
			circle(x, y, dimension)

			-- Damage
			self:damagePlayers(playerName, { freeze, pythagoras, x, y, dimension },
				damagePlayersWithAction)
			return false
		end)
end