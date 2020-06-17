local displayLifeBar = function(playerName)
	addImage(interfaceImages.lifeBar, imageTargets.lifeBar, 0, 18, playerName)
end

local updateLifeBar = function(playerName, cache)
	-- w = 100 -> 780 \ hp -> w = 100w = 780hp = 780hp/100 = 7.8hp
	addTextArea(textAreaId.lifeBar, '', playerName, 10, 25, 7.8 * cache.health, 1, cache.levelColor,
		cache.levelColor, .75, true)
end

local removeLifeBar = function(playerName)
	removeTextArea(textAreaId.lifeBar, playerName)
end