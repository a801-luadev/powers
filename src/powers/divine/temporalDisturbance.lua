-- Level 130
do
	powers.temporalDisturbance = Power
		.new("temporalDisturbance", powerType.divine, 130, {
			smallIcon = "1790bf78277.png",
			icon = "1790bf78277.png",
			iconWidth = 30,
			iconHeight = 30
		}, {

		})
		:setUseCooldown(50)
		:setProbability(18)
		:bindChatMessage("^C+H+R+O+N+O+S+ +A+T+E+M+P+O+R+A+L+$")
		:setEffect(function(self)

		end)
end