local tree = {
	"optimization.lua",
	"main.lua",

	"translations/en.lua",

	"enums.lua",

	"classes/dataHandler.lua",
	"playerData.lua",

	"api/DEBUG.lua",

	"api/math.lua",
	"api/string.lua",
	"api/table.lua",

	"api/transformice.lua",
	"api/xp.lua",
	"api/players.lua",

	"api/filter.lua",
	"interfaces/lifeBar.lua",
	"api/life.lua",

	"translations/setup.lua",

	"classes/byteArray.lua",
	"classes/keySequence.lua",
	"classes/timer.lua",
	"classes/power.lua",

	"powers.lua",
	"sortedPowers.lua",

	"leaderboard.lua",

	"classes/prettyUI.lua",

	"textAreaCallbacks/callbacks.lua",
	"textAreaCallbacks/closeInterface.lua",

	"interfaces/help.lua",
	"interfaces/powers.lua",
	"interfaces/profile.lua",
	"interfaces/leaderboard.lua",

	"events/eventFileLoaded.lua",

	"events/eventNewPlayer.lua",
	"events/eventPlayerDataLoaded.lua",
	"events/eventPlayerLeft.lua",

	"commands/commands.lua",
	"commands/help.lua",
	"commands/powers.lua",
	"commands/profile.lua",
	"commands/leaderboard.lua",
	"commands/owner/map.lua",
	"commands/owner/msg.lua",
	"events/eventChatCommand.lua",

	"textAreaCallbacks/menuTab.lua",
	"textAreaCallbacks/powerInfo.lua",
	"textAreaCallbacks/print.lua",
	"events/eventTextAreaCallback.lua",

	"events/eventNewGame.lua",
	"events/eventRoundEnded.lua",
	"events/eventLoop.lua",
	"events/eventPlayerDied.lua",
	"events/eventPlayerRespawn.lua",

	"keyboardCallbacks/callbacks.lua",
	"keyboardCallbacks/H.lua",
	"keyboardCallbacks/O.lua",
	"keyboardCallbacks/P.lua",
	"keyboardCallbacks/L.lua",
	"events/eventKeyboard.lua",

	"events/eventMouse.lua",
	"events/eventChatMessage.lua",
	"events/eventEmotePlayed.lua",

	"init.lua"
}

local getFile = function(path)
	local file = io.open("src/" .. path, 'r')
	local data = file:read("*a")
	file:close()
	return data
end

local writeFile = function(path, data)
	local file = io.open(path, "w+")
	file:write(data)
	file:flush()
	file:close()
end

local fileData = { }

local path, file
for i = 1, #tree do
	path = tree[i]
	fileData[i] = "--[[ " .. path .. " ]]--\n" .. getFile(path)

	print("Writing '" .. path .. "'")
end
fileData = table.concat(fileData, "\n\n")

writeFile("last_build.lua", fileData)
--writeFile("builds/" .. os.date("%m-%d-%y") .. ".lua", fileData)

print("Done")