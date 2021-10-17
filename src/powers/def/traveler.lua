-- Level 38
do
	powers.traveler = Power
		.new("traveler", powerType.def, 38, {
			smallIcon = "17c8b4783e3.png",
			icon = "17c8eb1341c.png",
			iconWidth = 80,
			iconHeight = 80
		}, {
			inventoryItemClicked = function(self, cache)
				cache.mouseSkill = self.typeId.__mouse
			end
		})
		:setUseLimit(1)
		:setUseCooldown(20)
		:setUseOnceForNKills(5)
		:bindMouse()
		:useInventory()
		:setEffect(function(playerName, playerX, playerY, _, _, _, clickX, clickY)
			displayParticle(36, playerX, playerY)

			movePlayer(playerName, clickX, clickY)

			displayParticle(37, clickX, clickY)
		end)
end