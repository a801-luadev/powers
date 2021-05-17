-- Level 55
do
	local undoEmperor = function(cache, mouseIcon)
		removeImage(mouseIcon)

		cache.hpRate = 1
		cache.damageRate = 1
	end

	powers.emperor = Power
		.new("emperor", powerType.def, 55, {
			smallIcon = "1797826aaad.png",
			icon = "1797830027f.png",
			iconWidth = 52,
			iconHeight = 55
		}, {
			mouseIcon = "17977e1c079.png",

			hpRate = 0.75,
			damageRate = 1.25,

			seconds = 20 * 1000
		})
		:setUseLimit(1)
		:setUseCooldown(20)
		:setProbability(15)
		:bindEmote(enum_emote.angry)
		:bindKeyboard(keyboard.left, keyboard.up, keyboard.right, keyboard.down)
		:setKeySequence({
			{ keyboard.up, keyboard.left, keyboard.right, keyboard.up, keyboard.left, keyboard.up },
			{
				keyboard.down, keyboard.right, keyboard.left, keyboard.down, keyboard.right,
				keyboard.down
			}
		})
		:setEffect(function(playerName, x, y, _, self, cache)
			cache.hpRate = self.hpRate
			cache.damageRate = self.damageRate

			-- Particles
			Power.basicCircle(x, y, 13, 0, 1.8, 2.4, 7)

			local mouseIcon = addImage(self.mouseIcon, "$" .. playerName, -15, -45)
			timer:start(undoEmperor, self.seconds, 1, cache, mouseIcon)
		end)
end