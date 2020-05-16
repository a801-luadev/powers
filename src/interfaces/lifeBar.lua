local displayLifeBar = function(playerName)
	addImage(interfaceImages.lifeBar, imageTargets.lifeBar, 0, 18, playerName)
end

local updateLifeBar = function(playerName, health)
	-- w = 100 -> 780 \ hp -> w = 100w = 780hp = 780hp/100 = 7.8hp
	addTextArea(textAreaId.lifeBar, '', playerName, 10, 25, 7.8 * health, 1, 0xB69EFD, 0xB69EFD,
		.75, true)
end

local removeLifeBar = function(playerName)
	removeTextArea(textAreaId.lifeBar, playerName)
end