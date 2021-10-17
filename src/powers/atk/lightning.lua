-- Level 15
do
	local particles = { 2, 11 }
	local totalParticles = #particles

	local lightning = function(x, y)
		local yPos, rand = 0

		local randMin, randMax
		if isLowQuality then
			randMin, randMax = 5, 7
		else
			randMin, randMax = 3, 5
		end

		local init = random(500)
		for i = init, init + 125, randMax do
			yPos = yPos + random(randMin, randMax)
			displayParticle(particles[i%totalParticles + 1], x + cos(i)*random(3, 6), y + yPos)
		end
	end

	powers.lightning = Power
		.new("lightning", powerType.atk, 15, {
			smallIcon = "172499d3af6.png",
			icon = "172baf86520.jpg",
			iconWidth = 21,
			iconHeight = 80
		})
		:setDamage(10)
		:setUseLimit(10)
		:setUseCooldown(5)
		:bindMouse(150)
		:setEffect(function(_, _, _, _, _, _, clickX, clickY)
			-- Particles
			lightning(clickX, clickY)

			-- Damage
			clickY = clickY + 100
			explosion(clickX, clickY, 30, 60)
			return pythagoras, clickX, clickY, 60
		end)
end