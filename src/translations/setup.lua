do
table.merge = function(this,src)
	for k, v in next, src do
		if this[k] then
			if type(v) == "table" then
				this[k] = table.turnTable(this[k])
				table.merge(this[k], v)
			else
				this[k] = this[k] or v
			end
		else
			this[k] = v
		end
	end
end

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

	getText = translations[tfm.get.room.community]
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

	translations = nil
end