-- Level 20
do
	local particles = { 2, 11, 2 }
	local totalParticles = #particles

	local spring = function(x, y)
		for i = 1, 10, (isLowQuality and 2 or 1) do
			displayParticle(particles[(i%totalParticles + 1)], x + cos(i)*10, y, 0, -i * .3)
		end
	end

	powers.doubleJump = Power
		.new("doubleJump", powerType.def, 20, {
			smallIcon = "172499c8f3b.png",
			icon = "172baf8852b.jpg",
			iconWidth = 44,
			iconHeight = 55
		})
		:setUseCooldown(5)
		:bindKeyboard(keyboard.up)
		:setKeySequence({ { keyboard.up, keyboard.up } })
		:setEffect(function(playerName, x, y)
			-- Move player
			movePlayer(playerName, 0, 0, true, 0, -80, false)

			-- Particles
			spring(x, y)
		end)
end