-- Level 0
do
	local beam = function(x, y, direction)
		local xSpeed = .25 * direction
		local xAcceleration = .3 * direction
		local r = 10
		for i = 1, 10, (isLowQuality and 2.5 or 1) do
			r = r * .75
			displayParticle(9, x - (-30 + i + r)*direction, y, i*xSpeed, 0, xAcceleration)
		end
	end

	powers.laserBeam = Power
		.new("laserBeam", powerType.atk, 0, {
			smallIcon = "172499c579c.png",
			icon = "172baf7a17c.jpg",
			iconWidth = 100,
			iconHeight = 54
		})
		:setDamage(5)
		:setUseCooldown(1)
		:bindKeyboard(keyboard.spacebar)
		:setEffect(function(_, x, y, isFacingRight)
			local direction = (isFacingRight and 1 or -1)
			y = y - 10

			-- Particles
			beam(x, y, direction)

			-- Collision
			timer:start(removeObject, 1000, 1, addShamanObject(6000, x + 40*direction, y, 0,
				9 * direction))

			-- Damage
			return inRectangle, x, y - 10, 120, 40, isFacingRight
		end)
end