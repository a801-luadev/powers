for playerName in next, tfm.get.room.playerList do
	eventNewPlayer(playerName)
end

tfm.exec.disableAutoShaman()
tfm.exec.disableAutoScore()
tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoTimeLeft()
tfm.exec.disableAfkDeath()
tfm.exec.disablePhysicalConsumables()

tfm.exec.setRoomMaxPlayers(module.max_players)