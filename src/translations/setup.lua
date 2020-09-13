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

	getText = translations[room.community]
	if getText then
		if getText ~= translations.en then
			merge(getText, translations.en, {
				["levelName"] = true
			})
		end
	else
		getText = translations.en
	end

	-- All level names are tables
	local levelName = getText.levelName
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

	translations = nil
end