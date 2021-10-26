-- Level 70
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

	powers.meteorSmash = Power
		.new("meteorSmash", powerType.atk, 70, {
			smallIcon = "172499d49f6.png",
			icon = "172baf7c232.jpg",
			iconWidth = 86,
			iconHeight = 80
		})
		:setDamage(20)
		:setSelfDamage(8)
		:setUseLimit(6)
		:setUseCooldown(8)
		:bindKeyboard(keyboard.down)
		:setKeySequence({ { keyboard.down, keyboard.down } })
		:setEffect(function(playerName, x, y, _, self, cache)
			-- Super jump
			movePlayer(playerName, 0, 0, true, 0, -110, true)
			-- Super smash
			timer:start(movePlayer, 500, 1, playerName, 0, 0, true, 0, 400, false)
			-- Damage
			timer:start(self.damagePlayers, 1000, 1, self, playerName, { smashDamage, inRectangle,
				x - 100, y - 60, 200, 100, true }, damagePlayersWithAction, cache, false)
			-- Particles
			timer:start(dust, 1000, 1, x, y)

			return false
		end)
end