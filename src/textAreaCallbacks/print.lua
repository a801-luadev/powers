do
	local urlFormat = "<BV>[<VI>•<BV>] https://"
	textAreaCallbacks["print"] = function(playerName, _, callback)
		-- print_{url}
		chatMessage(urlFormat .. callback[2], playerName)
	end
end