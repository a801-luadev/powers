do
	textAreaCallbacks["previousPage"] = function(playerName, cache, callback)
		-- previousPage_{module}_{displayFunction}
		if not callback[3] then return end

		local page = callback[2] .. "Page"

		cache[page] = cache[page] - 1
		if cache[page] <= 0 then
			cache[page] = module[callback[2] .. "_total_pages"]
		end

		textAreaCallbacks[callback[3]](playerName, cache,
			(not cache.powerInfoIdSelected and cache.lastPrettyUI))
	end
end