do
	textAreaCallbacks["print"] = function(playerName, _, callback)
		-- print_{url}
		chatMessage("<BV>[<VI>•<BV>] https://" .. callback[2], playerName)
	end
end