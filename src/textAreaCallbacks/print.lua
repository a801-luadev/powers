do
	textAreaCallbacks["print"] = function(playerName, _, callback)
		-- print_{url}
		chatMessage("<BV>[<VI>•<BV>] https://" .. tostring(callback[2]), playerName)
	end
end