do
	local merge
	merge = function(src, aux)
		for k, v in next, aux do
			if type(v) == "table" and type(src[k]) == "table" then
				merge(v, src[k])
			elseif not src[k] then
				src[k] = v
			end
		end
	end

	getText = translations[tfm.get.room.community]
	if getText then
		if getText ~= translations.en then
			merge(getText, translations.en)
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

	translations = nil
end