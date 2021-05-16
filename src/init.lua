textAreaCallbacks["displayPowerMenu"] = displayPowerMenu
textAreaCallbacks["displayLeaderboard"] = displayLeaderboard

playersWithPrivileges[module.author_id] = rolePermissions.administrator

flagCodesSet = table_set(flagCodes)

loadFile(module.data_file) -- Maps, banned players, players with privilege, etc
loadFile(module.leaderboard_file)

module.max_player_xp = lvlToXp(module.max_player_level_interface)

for playerName in next, room.playerList do
	eventNewPlayer(playerName)
	tfm.exec.setPlayerScore(playerName, 0)
end

system.disableChatCommandDisplay()

tfm.exec.disableAutoShaman()
tfm.exec.disableAutoScore()
tfm.exec.disableAutoNewGame()
tfm.exec.disableAfkDeath()
tfm.exec.disablePhysicalConsumables()
tfm.exec.disableDebugCommand()
tfm.exec.disableMortCommand()

tfm.exec.setRoomPassword('') -- Disables PW if it is enabled by glitch
tfm.exec.setRoomMaxPlayers(module.max_players)

math.randomseed(time())