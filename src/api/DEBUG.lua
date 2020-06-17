do
	local p = print
	print = function(...)
		local args = { ... }
		for i = 1, select('#', ...) do
			args[i] = tostring(args[i])
		end

		p(table.concat(args, '\t'))
	end

	savePlayerData = function(playerName, data)
		chatMessage(playerName .. " " .. tostring(data))
	end
end