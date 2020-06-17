local tree = {
	"optimization.lua",
	"main.lua",

	"translations/en.lua",
	"translations/br.lua",
	"translations/es.lua",
	"translations/fr.lua",
	"translations/he.lua", -- RTL is broken

	"enums/powers.lua",
	"enums/colors.lua",
	"enums/interface.lua",
	"enums/keyboard.lua",
	"enums/emotes.lua",
	"enums/flags.lua",
	"enums/permissions.lua",
	"enums/badges.lua",

	"classes/dataHandler.lua",
	"playerData.lua",

	--"api/DEBUG.lua",

	"api/math.lua",
	"api/string.lua",
	"api/table.lua",

	"api/transformice.lua",
	"api/xp.lua",
	"api/players.lua",
	"api/permissions.lua",

	"api/filter.lua",
	"interfaces/lifeBar.lua",
	"api/life.lua",

	"translations/setup.lua",

	"classes/keySequence.lua",
	"classes/timer.lua",
	"classes/power.lua",

	"powers.lua",
	"sortedPowers.lua",

	"textAreaCallbacks/callbacks.lua",
	"keyboardCallbacks/callbacks.lua",
	"commands/commands.lua",

	"enums/commandsMeta.lua",
	"api/data.lua",

	"leaderboard.lua",

	"classes/prettyUI.lua",

	"textAreaCallbacks/closeInterface.lua",

	"interfaces/help.lua",
	"interfaces/powers.lua",
	"interfaces/profile.lua",
	"interfaces/leaderboard.lua",

	"textAreaCallbacks/helpTab.lua",
	"textAreaCallbacks/powerInfo.lua",
	"textAreaCallbacks/print.lua",
	"textAreaCallbacks/leaderboardLeft.lua",
	"textAreaCallbacks/leaderboardRight.lua",

	"keyboardCallbacks/H.lua",
	"keyboardCallbacks/O.lua",
	"keyboardCallbacks/P.lua",
	"keyboardCallbacks/L.lua",

	"commands/help.lua",
	"commands/powers.lua",
	"commands/profile.lua",
	"commands/leaderboard.lua",

	"commands/roomAdmin/password.lua",

	"commands/mapReviewer/map.lua",
	"commands/mapReviewer/review.lua",
	"commands/mapReviewer/np.lua",
	"commands/mapReviewer/npp.lua",

	"commands/moderator/msg.lua",
	"commands/moderator/ban.lua",
	"commands/moderator/unban.lua",

	"commands/administrator/permban.lua",
	"commands/administrator/promote.lua",
	"commands/administrator/demote.lua",
	"commands/administrator/givebadge.lua",

	"events/eventFileLoaded.lua",
	"events/eventFileSaved.lua",

	"events/eventNewPlayer.lua",
	"events/eventPlayerDataLoaded.lua",
	"events/eventPlayerLeft.lua",

	"events/eventTextAreaCallback.lua",

	"events/eventNewGame.lua",
	"events/eventRoundEnded.lua",
	"events/eventLoop.lua",
	"events/eventPlayerDied.lua",
	"events/eventPlayerRespawn.lua",

	"events/eventKeyboard.lua",

	"events/eventMouse.lua",
	"events/eventChatMessage.lua",
	"events/eventEmotePlayed.lua",

	"events/eventChatCommand.lua",

	"roomAdmins.lua",

	"init.lua"
}

local getFile = function(path)
	local file = io.open("src/" .. path, 'r')
	local data = file:read("*a")
	file:close()
	return (string.gsub(data, "\n*$", '', 1))
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