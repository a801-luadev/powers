-- Level 42
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
		.new("wormHole", powerType.def, 42, {
			smallIcon = "172499c71c4.png",
			icon = "172baf8e646.jpg",
			iconWidth = 72,
			iconHeight = 80
		})
		:setUseLimit(10)
		:setUseCooldown(1.5)
		:bindKeyboard(keyboard.up, keyboard.down)
		:setKeySequence({
			{ keyboard.up, keyboard.down },
			{ keyboard.down, keyboard.up }
		})
		:setEffect(function(playerName, x, y, isFacingRight)
			local direction = (isFacingRight and 200 or -200)

			-- Move player
			movePlayer(playerName, x + direction, y, false, 0, -50, false)

			-- Particles
			spiral(x, y, 270)
			spiral(x + direction, y, 90)
		end)
end