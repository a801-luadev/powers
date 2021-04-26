-- Level 28
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
		.new("helix", powerType.def, 28, {
			smallIcon = "172499ce899.png",
			icon = "172baf8a5db.jpg",
			iconWidth = 67,
			iconHeight = 80
		})
		:setUseLimit(10)
		:setUseCooldown(2.5)
		:bindKeyboard(keyboard.shift)
		:setEffect(function(playerName, x, y, isFacingRight)
			local direction = (isFacingRight and 1 or -1)

			-- Move player
			movePlayer(playerName, 0, 0, true, 100 * direction, -115, false)

			-- Particles
			spiral(x, y, 200, direction)
		end)
end