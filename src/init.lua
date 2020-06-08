flagCodesSet = table_set(flagCodes)

loadFile(module.map_file)
unrefreshableTimer:start(loadFile, 65000, 0, module.leaderboard_file)

module.max_player_xp = lvlToXp(module.max_player_level)

for playerName in next, tfm.get.room.playerList do
	eventNewPlayer(playerName)
	setPlayerScore(playerName, 0)
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