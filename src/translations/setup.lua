do
	local merge
	merge = function(src, aux, ignoredIndexes)
		for k, v in next, aux do
			if not ignoredIndexes[k] then
				if type(v) == "table" then
					src[k] = merge((type(src[k]) == "table" and src[k] or { }), v, ignoredIndexes)
				else
					src[k] = src[k] or v
				end
			end
		end
		return src
	end

	local levelName
	getText = translations[room.community]

	if getText then
		if getText ~= translations.en then
			merge(getText, translations.en, {
				["levelName"] = true
			})

			levelName = getText.levelName
			for level, name in next, translations.en.levelName do
				if not levelName[level] then
					levelName[level] = name
				end
			end
		end
	else
		getText = translations.en
	end

	-- All level names are tables
	levelName = levelName or getText.levelName
	for k, v in next, levelName do
		if type(v) == "string" then
			levelName[k] = { v, v }
		end
	end

	-- Fix news
	local newsContent = getText.helpContent[4]
	local news, index = { newsContent[1] }, 1
	for i = #newsContent, 2, -1 do
		index = index + 1
		news[index] = newsContent[i]
	end
	getText.helpContent[4] = table_concat(news, '\n')

	-- Color system mensages
	getText.ban = format(getText.ban, systemColors.moderation, systemColors.moderation)
	getText.unban = format(getText.unban, systemColors.moderation)
	getText.isBanned = format(getText.isBanned, systemColors.moderation)
	getText.permBan = format(getText.permBan, systemColors.moderation, systemColors.moderation)

	-- Powers
	getText.powersDescriptions.soulSucker = format(getText.powersDescriptions.soulSucker,
		powers.soulSucker.healthPoints)
	getText.powersDescriptions.emperor = format(getText.powersDescriptions.emperor,
		100 - powers.emperor.hpRate*100, powers.emperor.damageRate*100 - 100,
		100 - powers.emperor.cooldownRate*100)

	translations = nil
end