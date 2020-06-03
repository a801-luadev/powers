--< DEBUG <--system.loadFile(module.map_file)
eventFileLoaded(module.map_file, '6602343@6576101@6562101@6516460@6703747@6703751@6402787@6422045@3969874@4021639@3952121@6720637@6720600@6721110@6422055@6375156@6370960@6729762@6379260@6302281@6302178@6730125@6730148@6731380@6733122@6733411@6755053@5971883@6773401@6792905@6833553@6835357@6835351@6798088@6834984@6849838@6045163@4015685@6174131@6394667@6397861@5234134')
system.loadFile(module.leaderboard_file) --< DEBUG <--unrefreshableTimer.start(system.loadFile, 65000, 0, module.leaderboard_file)

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