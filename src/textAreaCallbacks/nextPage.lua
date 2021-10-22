do
	textAreaCallbacks["nextPage"] = function(playerName, cache, callback)
		-- nextPage_{module}_{displayFunction}
		if not callback[3] then return end

		local page = callback[2] .. "Page"

		cache[page] = cache[page] + 1
		if cache[page] > module[callback[2] .. "_total_pages"] then
			cache[page] = 1
		end

		textAreaCallbacks[callback[3]](playerName, cache,
			(not cache.powerInfoIdSelected and cache.lastPrettyUI))
	end
end