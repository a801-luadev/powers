local tree = {
	"optimization.lua",
	"main.lua",

	"translations/en.lua",
	"translations/br.lua",
	"translations/es.lua",
	"translations/fr.lua",
	"translations/pl.lua",
	"translations/ro.lua",
	"translations/tr.lua",
	"translations/cn.lua",
	"translations/id.lua",
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
	"api/log.lua",
	"api/xp.lua",
	"api/players.lua",
	"api/permissions.lua",

	"api/filter.lua",
	"interfaces/lifeBar.lua",
	"api/life.lua",

	"translations/setup.lua",

	"textAreaCallbacks/callbacks.lua",
	"keyboardCallbacks/callbacks.lua",
	"commands/commands.lua",

	"classes/keySequence.lua",
	"classes/timer.lua",
	"classes/power.lua",

	"classes/prettyUI.lua",
	"textAreaCallbacks/closeInterface.lua",

	"powers/atk/laserBeam.lua", -- lv 0
	"powers/def/lightSpeed.lua", -- lv 3
	"powers/atk/lightning.lua", -- lv 15
	"powers/def/doubleJump.lua", -- lv 20
	"powers/def/helix.lua", -- lv 28
	"powers/atk/dome.lua", -- lv 35
	"powers/def/wormHole.lua", -- lv 42
	"powers/divine/atomic.lua", -- lv 50
	"powers/atk/superNova.lua", -- lv 60
	"powers/atk/meteorSmash.lua", -- lv 70
	"powers/def/soulSucker.lua", -- lv 80
	"powers/atk/waterSplash.lua", -- lv 90
	"powers/atk/deathRay.lua", -- lv 100
	"powers/divine/dayOfJudgement.lua", -- lv 110
	"powers/divine/anomaly.lua", -- lv 120
	"powers/divine/temporalDisturbance.lua", -- lv 130

	"sortedPowers.lua",

	"enums/commandsMeta.lua",
	"api/data.lua",

	"leaderboard.lua",

	"interfaces/help.lua",
	"interfaces/powers.lua",
	"interfaces/profile.lua",
	"interfaces/leaderboard.lua",

	"textAreaCallbacks/helpTab.lua",
	"textAreaCallbacks/powerInfo.lua",
	"textAreaCallbacks/print.lua",
	"textAreaCallbacks/leaderboardLeft.lua",
	"textAreaCallbacks/leaderboardRight.lua",

	"textAreaCallbacks/temporalDisturbance.lua",

	"keyboardCallbacks/H.lua",
	"keyboardCallbacks/O.lua",
	"keyboardCallbacks/P.lua",
	"keyboardCallbacks/L.lua",

	"commands/help.lua",
	"commands/powers.lua",
	"commands/profile.lua",
	"commands/leaderboard.lua",
	"commands/modes.lua",
	"commands/perms.lua",
	"commands/round.lua",

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

	"commands/owner/givebadge.lua",
	"commands/owner/setdata.lua",

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

	"events/eventPlayerBonusGrabbed.lua",

	"roomSettings.lua",

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
writeFile("builds/" .. os.date("%m-%d-%y") .. ".lua", fileData)

print("Done")