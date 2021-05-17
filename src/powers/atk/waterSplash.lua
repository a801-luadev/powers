-- Level 90
do
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
		:setEffect(function(playerName, x, y, _, self, cache)
			local dimension = 60

			-- Particles
			Power.basicCircle(x, y, 14, dimension, 1, 1.75, -5)

			-- Damage
			self:damagePlayers(playerName, { freeze, pythagoras, x, y, dimension },
				damagePlayersWithAction, cache)
			return false
		end)
end