for playerName in next, tfm.get.room.playerList do
	eventNewPlayer(playerName)
	tfm.exec.setPlayerScore(playerName, 0)
end

system.disableChatCommandDisplay()

tfm.exec.disableAutoShaman()
tfm.exec.disableAutoScore()
tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoTimeLeft()
tfm.exec.disableAfkDeath()
tfm.exec.disablePhysicalConsumables()
tfm.exec.disableDebugCommand()

tfm.exec.setRoomMaxPlayers(module.max_players)