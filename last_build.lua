--[[ optimization.lua ]]--
-- Transformice
local bindMouse    = system.bindMouse
local bindKeyboard = system.bindKeyboard

local addShamanObject  = tfm.exec.addShamanObject
local changePlayerSize = tfm.exec.changePlayerSize
local displayParticle  = tfm.exec.displayParticle
local explosion        = tfm.exec.explosion
local freezePlayer     = tfm.exec.freezePlayer
local giveCheese       = tfm.exec.giveCheese
local killPlayer       = tfm.exec.killPlayer
local linkMice         = tfm.exec.linkMice
local movePlayer       = tfm.exec.movePlayer
local playerVictory    = tfm.exec.playerVictory
local removeObject     = tfm.exec.removeObject
local respawnPlayer    = tfm.exec.respawnPlayer
local setGameTime      = tfm.exec.setGameTime
local setPlayerScore   = tfm.exec.setPlayerScore

local addImage       = tfm.exec.addImage
local addTextArea    = ui.addTextArea
local removeImage    = tfm.exec.removeImage
local removeTextArea = ui.removeTextArea
local updateTextArea = ui.updateTextArea
local setMapName     = ui.setMapName

local lowerSyncDelay  = tfm.exec.lowerSyncDelay
local setRoomPassword = tfm.exec.setRoomPassword

local chatMessage    = tfm.exec.chatMessage
local newGame        = tfm.exec.newGame

local loadFile       = system.loadFile
local loadPlayerData = system.loadPlayerData
local saveFile       = system.saveFile
local savePlayerData = system.savePlayerData

local room = tfm.get.room

-- Enums
local enum_emote        = tfm.enum.emote
local enum_particle     = tfm.enum.particle
local enum_shamanObject = tfm.enum.shamanObject

-- Mathematics
local ceil   = math.ceil
local cos    = math.cos
local max    = math.max
local min    = math.min
local rad    = math.rad
local random = math.random
local sin    = math.sin

-- String
local byte   = string.byte
local find   = string.find
local format = string.format
local gmatch = string.gmatch
local gsub   = string.gsub
local lower  = string.lower
local match  = string.match
local rep    = string.rep
local sub    = string.sub
local upper  = string.upper

-- Table
local table_concat = table.concat
local table_insert = table.insert
local table_remove = table.remove
local table_sort   = table.sort

-- Bit32
local band   = bit32.band
local bor    = bit32.bor
local bnot   = bit32.bnot

-- OS
local date = os.date
local time = os.time

-- Others
local next         = next
local setmetatable = setmetatable
local tonumber     = tonumber
local type         = type
local unpack       = table.unpack

--[[ main.lua ]]--
local module = {
	author = "Bolodefchoco#0000",
	author_id = 7903955,

	id = "pw",

	min_players = 4,
	max_players = 18,

	data_file = '7',
	leaderboard_file = '8',

	default_xp = 36,
	extra_xp_in_round_seconds = 60 * 1000,
	extra_xp_in_round = 10,
	xp_on_victory = 40,
	xp_on_kill = 15,

	max_player_level = 129,
	max_player_xp = nil,

	max_leaderboard_rows = 100
}

-- Important tables
local playerCache = { }

local powers = { }

local maps = { }

local dataFileContent = {
	[1] = nil, -- Maps
	[2] = nil, -- Privileges
	[3] = nil -- Banned
}

local leaderboard = {
	loaded = false,
	total_pages = 0,

	community = { },
	id = { },
	nickname = { },
	discriminator = { },
	rounds = { },
	victories = { },
	kills = { },
	xp = { },

	full_nickname = { },
	pretty_nickname = { },

	registers = { },
	sets = { }
}

local powersSortedByLevel = { }

local playersWithPrivileges = { }

local bannedPlayers = { }

local roomAdmins = {
	[module.author] = true
}

-- Important settings
local isOfficialRoom = byte(room.name, 2) ~= 3

local canSaveData = false
local canTriggerPowers = false
local isLowQuality = false -- Unused yet

local totalCurrentMaps, currentMap, nextMapLoadTentatives, mapHashes = 0, 0, 0
local nextMapToLoad

local hasTriggeredRoundEnd = false
local isReviewMode, isCurrentMapOnReviewMode = false, false
local minPlayersForNextRound = 1

local isSaveDataFileScheduled = false

local resetPlayersDefaultSize = false

local Power

--[[ translations/en.lua ]]--
local translations, getText = { }
translations.en = {
	-- Main messages
	greeting = "<FC>Welcome to <B>#powers</B>!\n" ..
		"\t• Press <B>H</B> or type <B>!help</B> to learn more about the module.\n" ..
		"\t• Press <B>O</B> or type <B>!powers</B> to learn more about the powers.",
	kill = "<R>%s<FC> killed %s",

	-- Victory
	mentionWinner = "<FC>%s<FC> won the round!",
	noWinner = "<FC>No one won the round. :(",

	-- Lobby
	minPlayers = "At least <B>2</B> players must be in the room for the game to start.",

	-- Powers
	powers = {
		lightSpeed = "Light Speed",
		laserBeam = "Laser Beam",
		wormHole = "Worm Hole",
		doubleJump = "Double Jump",
		helix = "Helix",
		dome = "Dome",
		lightning = "Lightning",
		superNova = "Supernova",
		meteorSmash = "Meteor Smash",
		gravitationalAnomaly = "Gravitational Anomaly",
		deathRay = "Death Ray",
		atomic = "Atomic",
		dayOfJudgement = "Day of Judgement",
		waterPump = "Water Pump"
	},
	powersDescriptions = {
		lightSpeed = "Moves your mouse in the speed of light, pushing all enemies around.",
		laserBeam = "Shoots a laser beam so strong that enemies can feel it.",
		wormHole = "Teleports your mouse ahead through a Worm Hole.",
		doubleJump = "Performs an auxiliar and high double jump.",
		helix = "Speeds up your mouse diagonally with a powerful helix.",
		dome = "Creates a protector dome that pushes all enemies around.",
		lightning = "Summons a potent lightning that electrifies the enemies.",
		superNova = "Starts a supernova that destroys all enemies around.",
		meteorSmash = "Smashes the enemies like a meteor crash.",
		gravitationalAnomaly = "Starts a gravitational anomaly.",
		deathRay = "Toasts the enemies with the powerful and mysterious death ray.",
		atomic = "Randomly changes all players' size.",
		dayOfJudgement = "Revives all dead enemies, them all linked to each other.",
		waterPump = "Summons some drops of water from Antarctica."
	},
	powerType = {
		atk = "ATTACK (%d)",
		def = "DEFENSE",
		divine = "DIVINE"
	},

	unlockPower = "<FC>[<J>•<FC>] You have unlocked the following power(s): %s",

	-- Level names
	-- @Translator notes: if it has gender variation, { "male", "female" }, else "neutral".
	levelName = {
		[000] = "Mutant",
		[010] = "Necromancer",
		[020] = "Scientist",
		[030] = "Titan",
		[040] = { "Wizard", "Wizardess" },
		[050] = "Reality Controller",
		[060] = { "Lord of Spells", "Lady of Spells" },
		[070] = "Shamanic Summoner",
		[080] = { "The Pestilence Horseman", "The Pestilence Horsewoman" },
		[090] = { "The Famine Horseman", "The Famine Horsewoman" },
		[100] = { "The War Horseman", "The War Horsewoman" },
		[110] = { "The Death Horseman", "The Death Horsewoman" },
		[120] = "The Void"
	},

	newLevel = "<FC>%s<FC> just reached level <B>%d</B>!",
	level = "Level %d",

	-- Help
	helpTitles = {
		[1] = "Powers!", -- @Translator notes: remove this line
		[2] = "Commands",
		[3] = "Contribute",
		[4] = "What's new?"
	},
	helpContent = {
		[1] = "<FC><p align='center'>#POWERS!</p>\n\n" ..
			"<J>Your goal in this module is to survive from opponents' attacks.\n\n" ..
			"<N>There are a variety of powers <font size='12'>- which are unlocked by reaching higher levels -</font> to attack and defend.\n" ..
			"Type <FC><B>!powers</B><N> to learn more about the powers you have unlocked so far!\n\n" ..
			"%s\n\n" .. -- enableParticles
			"This module has been developed by %s"
		,
		[2] = "<FC><p align='center'>GENERAL COMMANDS</p><N>\n\n<font size='12'>", -- commands
		[3] = "<FC><p align='center'>CONTRIBUTE<N>\n\n" ..
			"We love Open Source <font color='#E91E63'>♥</font>! You can view and modify the source code of this module on <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"Maintaining the module is strictly voluntary, so any help regarding <V>Code<N>, <V>bugfix and reports<N>, <V>suggestions and feature enhancements<N>, <V>map making <N>is welcome and very well appreciated.\n" ..
			"<p align='left'>• You can <FC>report bugs <N>or <FC>suggest <N>on <a href='event:print_discord.gg/quch83R'><font color='#087ECC'>Discord</font></a> and/or on <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• You can <FC>submit maps <N>in our <a href='event:print_atelier801.com/topic?f=6&t=888677'><font color='#087ECC'>Map Submissions Thread on Forums</font></a>.\n\n" ..
			"<p align='center'>You can also <FC>donate</FC> any amount <a href='event:print_a801-luadev.github.io/?redirect=powers'><font color='#087ECC'>here</font></a> to help maintaining the module. All funds obtained through the link are going to be invested in constant module updates and general improvements.\n\n" ..
			"<a href='event:print_atelier801.com/topic?f=6&t=888676'><font size='18' color='#087ECC'>Thread on Forums</font></a></p>"
		,
		[4] = "<FC><p align='center'>WHAT'S NEW?</p><N>\n\n" ..
			"• You can read about all powers now.\n" ..
			"• Module became official.\n" ..
			"• Module has been entirely rewritten."
	},

	-- Commands
	commandDescriptions = {
		help = "Opens this menu.",
		powers = "Opens a menu that lists all powers and their info.",
		profile = "Opens your or someone's profile.",
		leaderboard = "Opens the global leaderboard.",

		pw = "Protects the room with a password. Send empty to remove it.",

		mapEditQueue = "Manages the map rotation of the game.", -- @Translator notes: remove this line
		mapSaveQueue = "Saves the map rotation of the game.", -- @Translator notes: remove this line
		review = "Enables the review mode.", -- @Translator notes: remove this line
		np = "Loads a new map.", -- @Translator notes: remove this line
		npp = "Schedules the next map to be loaded.", -- @Translator notes: remove this line

		msg = "Sends a message to the room.", -- @Translator notes: remove this line
		ban = "Bans a player from the game.", -- @Translator notes: remove this line
		unban = "Unbans a player from the game.", -- @Translator notes: remove this line
		permban = "Bans permanently a player from the game.", -- @Translator notes: remove this line

		promote = "Promotes a player to a specific role or gives them specific permissions.", -- @Translator notes: remove this line
		demote = "Demotes a player from a specific role or removes specific permissions from them." -- @Translator notes: remove this line
	},
	commandsParameters = {
		profile = "[player_name] ",

		pw = "[password] ",

		mapEditQueue = "[add|rem]<R>*</R> [@map ...]<R>*</R> ", -- @Translator notes: remove this line
		mapSaveQueue = "[save]<R>*</R> ", -- @Translator notes: remove this line
		np = "[@map]<R>*</R> ", -- @Translator notes: remove this line
		npp = "[@map]<R>*</R> ", -- @Translator notes: remove this line

		msg = "[message]<R>*</R> ", -- @Translator notes: remove this line
		ban = "[player_name]<R>*</R> [ban_time] [reason] ", -- @Translator notes: remove this line
		unban = "[player_name]<R>*</R> ", -- @Translator notes: remove this line

		permban = "[player_name]<R>*</R> [reason] ", -- @Translator notes: remove this line
		promote = "[player_name]<R>*</R> [permission_name|role_name ...]<R>*</R> ", -- @Translator notes: remove this line
		demote = "[player_name]<R>*</R> [permission_name|role_name ...]<R>*</R> " -- @Translator notes: remove this line
	},
	["or"] = "or",

	-- Profile
	profileData = {
		rounds = "Rounds",
		victories = "Victories",
		kills = "Kills",
		xp = "Experience",
		badges = "Badges"
	},

	-- Leaderboard
	leaderboard = "Leaderboard",
	leaderboardIsLoading = "<BL>[<VI>•<BL>] The leaderboard is still loading. Try again in a few seconds.",

	-- Map management
	addMap = "<BV>[<FC>•<BV>] The map <J>@%s</J> was added to the local map queue.",
	remMap = "<BV>[<FC>•<BV>] The map <J>@%s</J> was removed from the local map queue.",
	listMaps = "<BV>[<FC>•<BV>] Maps (<J>#%d</J>): %s",

	-- Warning
	enableParticles = "<ROSE>Do NOT forget to ENABLE the special effects/particles in order to see the module properly. (In 'Menu' → 'Options', next to the 'Room List')</ROSE>",

	-- Ban
	ban = "%s <ROSE>has been banned from #powers by %s <ROSE>for %d hours. Reason: %s",
	unban = "<ROSE>You have been unbanned by %s",
	isBanned = "<ROSE>You are banned from #powers until GMT+2 %s (%d hours to go).", -- @Translator notes: keep GMT+2
	permBan = "%s <ROSE>has been banned permanently from #powers by %s<ROSE>. Reason: %s",
	cantPermUnban = "<BL>[<VI>•<BL>] You cannot unban a user that is banned permanently.", -- @Translator notes: remove this line
	resetData = "<BL>[<VI>•<BL>] Data of %s<BL> has been set to {%d,%d,%d,%d}", -- @Translator notes: remove this line

	-- Promotion
	playerGetPermissions = "<BL>[<VI>•<BL>] %s <BL>has now the following permissions: <B>%s</B>", -- @Translator notes: remove this line
	playerLosePermissions = "<BL>[<VI>•<BL>] %s <BL>had the following permissions removed: <B>%s</B>", -- @Translator notes: remove this line
	playerGetRole = "<FC>%s <FC>has been promoted to <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>is not <font color='#%x'>%s</font> anymore.",

	-- Review
	enableReviewMode = "<BV>[<FC>•<BV>] The <FC>Map Review Mode<BV> is enabled. Next rounds will <B>not</B> count stats and the maps that appear are in test for the map rotation of the module. All powers have been enabled and divine powers are more likely to happen!",
	disableReviewMode = "<BV>[<FC>•<BV>] The <FC>Map Review Mode<BV> has been disabled and everything will be back to normal in the next round!",

	-- Badges
	getBadge = "<FC>%s<FC> just unlocked a new #powers badge!",

	-- Password
	setPassword = "<BL>[<VI>•<BL>] %s <BL>has set the password to %q.",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>has removed the password of the room."
}

--[[ translations/br.lua ]]--
-- Translated by Natsmiro#0000
translations.br = {
	greeting = "<FC>Bem-vindo ao <B>#powers</B>!\n" ..
		"\t• Pressione <B>H</B> ou digite <B>!help</B> para saber mais sobre o module.\n" ..
		"\t• Pressione <B>O</B> ou digite <B>!powers</B> para saber mais sobre os poderes.",
	kill = "<R>%s<FC> matou %s",

	mentionWinner = "<FC>%s<FC> venceu a rodada!",
	noWinner = "<FC>Ninguém venceu a rodada. :(",

	minPlayers = "Pelo menos <B>2</B> jogadores devem estar na sala para o jogo começar.",

	powers = {
		lightSpeed = "Velocidade da Luz",
		laserBeam = "Raio Laser",
		wormHole = "Buraco de Minhoca",
		doubleJump = "Pulo Duplo",
		helix = "Hélice",
		dome = "Domo",
		lightning = "Relâmpago",
		superNova = "Supernova",
		meteorSmash = "Meteoro ",
		gravitationalAnomaly = "Anomalia Gravitacional",
		deathRay = "Raio da Morte",
		atomic = "Atômico",
		dayOfJudgement = "Dia do Julgamento"
	},
	powersDescriptions = {
		lightSpeed = "Move seu rato na velocidade da luz, empurrando todos seus inimigos em volta.",
		laserBeam = "Dispara um raio laser tão forte que os inimigos podem senti-lo.",
		wormHole = "Teletransporta seu rato para frente através de um Buraco de Minhoca.",
		doubleJump = "Executa um alto salto duplo auxiliar.",
		helix = "Acelera seu rato na diagonal com uma poderosa hélice.",
		dome = "Cria um domo protetor que empurra todos os inimigos em volta.",
		lightning = "Invoca um raio potente que eletrifica seus inimigos.",
		superNova = "Inicia uma Supernova que destrói todos os inimigos em volta.",
		meteorSmash = "Esmaga seus inimigos como uma queda de meteoro.",
		gravitationalAnomaly = "Inicia uma anomalia gravitacional.",
		deathRay = "Torra seus inimigos com um poderoso e misterioso raio da morte.",
		atomic = "Altera o tamanho dos jogadores aleatoriamente.",
		dayOfJudgement = "Revive todos os inimigos mortos, todos presos uns aos outros."
	},
	powerType = {
		atk = "ATAQUE (%d)",
		def = "DEFESA",
		divine = "DIVINO"
	},

	unlockPower = "<FC>[<J>•<FC>] Você desbloqueou o(s) seguinte(s) poder(es): %s",

	levelName = {
		[000] = "Mutante",
		[010] = "Necromante",
		[020] = "Cientista",
		[030] = "Titã",
		[040] = { "Feiticeiro", "Feiticeira" },
		[050] = { "Controlador da Realidade", "Controladora da Realidade" },
		[060] = { "Senhor dos Feitiços", "Senhora dos Feitiços" },
		[070] = { "Invocador Xamânico", "Invocadora Xamânica" },
		[080] = { "O Cavaleiro da Peste", "A Cavaleira da Peste" },
		[090] = { "O Cavaleiro da Fome", "A Cavaleira da Fome" },
		[100] = { "O Cavaleiro da Guerra", "A Cavaleira da Guerra" },
		[110] = { "O Cavaleiro da Morte", "A Cavaleira da Morte" },
		[120] = "O Vazio"
	},

	newLevel = "<FC>%s<FC> acaba de atingir o nível <B>%d</B>!",
	level = "Nível %d",

	helpTitles = {
		[2] = "Comandos",
		[3] = "Contribua",
		[4] = "Novidades"
	},
	helpContent = {
		[1] = "<FC><p align='center'>#POWERS!</p>\n\n" ..
			"<J>O seu objetivo nesse module é sobreviver aos ataques de seus oponentes.\n\n" ..
			"<N>Há uma variedade de poderes <font size='12'>- que são desbloqueados atingindo níveis mais altos -</font> para atacar e defender.\n" ..
			"Digite <FC><B>!powers</B><N> para saber mais sobre os poderes que você desbloqueou até o momento!\n\n" ..
			"%s\n\n" ..
			"Esse module foi desenvolvido por %s"
		,
		[2] = "<FC><p align='center'>COMANDOS GERAIS</p><N>\n\n<font size='12'>",
		[3] = "<FC><p align='center'>CONTRIBUA<N>\n\n" ..
			"Nós amamos Código Aberto <font color='#E91E63'>♥</font>! Você pode visualizar e modificar o código desse module em <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"Manter o module é estritamente voluntário, então qualquer ajuda a respeito do <V>Código<N>, <V>correção de bugs e reportes<N>, <V>sugestões e melhoria de funcionalidades<N>, <V>criação de mapas <N>é bem-vinda e muito apreciada.\n" ..
			"<p align='left'>• Você pode <FC>relatar bugs <N>ou <FC>fazer uma sugestão <N>no <a href='event:print_discord.gg/quch83R'><font color='#087ECC'>Discord</font></a> e/ou no <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• Você pode <FC>enviar mapas <N>no nosso <a href='event:print_atelier801.com/topic?f=6&t=888677'><font color='#087ECC'>Tópico de envio demapas no Fórum</font></a>.\n\n" ..
			"<p align='center'>Você também pode <FC>doar</FC> qualquer quantia <a href='event:print_a801-luadev.github.io/?redirect=powers'><font color='#087ECC'>aqui</font></a> para ajudar a manter o module. Todos os fundos arrecadados através desse link serão investidos em atualizações constantes no module e em melhorias gerais.\n\n" ..
			"<a href='event:print_atelier801.com/topic?f=6&t=888676'><font size='18' color='#087ECC'>Tópico no Fórum</font></a></p>"
		,
		[4] = "<FC><p align='center'>O QUE HÁ DE NOVO?</p><N>\n\n" ..
			"• Você pode ler sobre todos os poderes agora.\n" ..
			"• O Module se tornou oficial.\n" ..
			"• O Module foi totalmente reescrito."
	},

	commandDescriptions = {
		help = "Abre esse menu.",
		powers = "Abre um menu que lista todos os poderes e suas informações.",
		profile = "Abre o seu perfil ou o de alguém.",
		leaderboard = "Abre o ranking global.",

		pw = "Protege sua sala com uma senha. Deixe vazio para remover."
	},
	commandsParameters = {
		profile = "[jogador] ",

		pw = "[senha] "
	},
	["or"] = "ou",

	profileData = {
		rounds = "Rodadas",
		victories = "Vitórias",
		kills = "Mortes",
		xp = "Experiência",
		badges = "Medalhas"
	},

	leaderboard = "Ranking",
	leaderboardIsLoading = "<BL>[<VI>•<BL>] O ranking ainda está carregando. Tente novamente em alguns segundos.",

	addMap = "<BV>[<FC>•<BV>] O mapa <J>@%s</J> foi adicionado à lista local de mapas.",
	remMap = "<BV>[<FC>•<BV>] O mapa <J>@%s</J> foi removido da lisa local de mapas.",
	listMaps = "<BV>[<FC>•<BV>] Mapas (<J>#%d</J>): %s",

	enableParticles = "<ROSE>NÃO se esqueça de HABILITAR os efeitos especiais/partículas para conseguir ver o jogo adequadamente. (Em 'Menu' → 'Opções', próximo a 'Lista de Salas')</ROSE>",

	ban = "%s <ROSE>foi banido do #powers por %s <ROSE>por %d horas. Motivo: %s",
	unban = "<ROSE>Seu banimento foi revogado por %s",
	isBanned = "<ROSE>Você está banido do #powers até GMT+2 %s (%d horas restantes).",
	permBan = "%s <ROSE>foi banido permanentemente do #powers por %s<ROSE>. Motivo: %s",

	playerGetRole = "<FC>%s <FC>foi promovido para <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>não é mais <font color='#%x'>%s</font>.",

	enableReviewMode = "<BV>[<FC>•<BV>] O <FC>Modo de Review de Mapas<BV> está ativado. As próximas rodadas <B>não</B> contarão estatísticas e os mapas que aparecerem estão em teste para a rotação de mapas do module. Todos os poderes foram ativados e poderes divinos são mais propensos a acontecer!",
	disableReviewMode = "<BV>[<FC>•<BV>] O <FC>Modo de Review de Mapas<BV> foi desativado e tudo voltará ao normal na próxima rodada!",

	getBadge = "<FC>%s<FC> acaba de desbloquear uma nova medalha #powers!",

	setPassword = "<BL>[<VI>•<BL>] %s <BL>definiu a senha da sala para %q.",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>removeu a senha da sala."
}
translations.pt = translations.br

--[[ translations/es.lua ]]--
-- Translated by Tocutoeltuco#0000
translations.es = {
	greeting = "<FC>¡Bienvenido a <B>#powers</B>!\n" ..
		"\t• Presiona <B>H</B> o escribe <B>!help</B> para saber más sobre el módulo.\n" ..
		"\t• Presiona <B>O</B> o escribe <B>!powers</B> para saber más sobre los poderes.",
	kill = "<R>%s<FC> mató a %s",

	mentionWinner = "<FC>%s<FC> ganó la ronda!",
	noWinner = "<FC>Nadie ganó la ronda. :(",

	minPlayers = "Al menos <B>2</B> jugadores deben estar en la sala para que el juego comience.",

	powers = {
		lightSpeed = "Velocidad Luz",
		laserBeam = "Rayo Láser",
		wormHole = "Agujero de Gusano",
		doubleJump = "Doble Salto",
		helix = "Hélice",
		dome = "Domo",
		lightning = "Relámpago",
		superNova = "Supernova",
		meteorSmash = "Aplaste de Meteorito",
		gravitationalAnomaly = "Anomalía Gravitacional",
		deathRay = "Rayo de la Muerte",
		atomic = "Atómico",
		judgmentDay = "Día del Juicio"
	},
	powersDescriptions = {
		lightSpeed = "Mueve tu ratón a la velocidad de la luz, empujando todos los enemigos cerca.",
		laserBeam = "Dispara un rayo láser tan fuerte que los enemigos pueden sentirlo.",
		wormHole = "Teletransporta tu ratón hacia adelante a traves de un agujero de gusano.",
		doubleJump = "Hace un auxiliar y alto doble salto.",
		helix = "Acelera tu ratón diagonalmente con una potente hélice.",
		dome = "Crea un domo protector que empuja a todos los enemigos cerca.",
		lightning = "Invoca un potente relámpago que electrifica a todos los enemigos cerca.",
		superNova = "Inicia una supernova que destruye a todos los enemigos cerca.",
		meteorSmash = "Aplasta a los enemigos como un choque de meteoritos.",
		gravitationalAnomaly = "Inicia una anomalía gravitacional.",
		deathRay = "Rostiza los enemigos con el poderoso y misterioso rayo de la muerte.",
		atomic = "Cambia los tamaños de los jugadores al azar.",
		judgmentDay = "Revive todos los enemigos muertos, enlazados entre ellos."
	},
	powerType = {
		atk = "ATAQUE (%d)",
		def = "DEFENSA",
		divine = "DIVINO"
	},

	unlockPower = "<FC>[<J>•<FC>] Desbloqueste el/los siguiente(s) poder(es): %s",

	levelName = {
		[000] = "Mutante",
		[010] = "Necromancer",
		[020] = { "Científico", "Científica" },
		[030] = "Titán",
		[040] = { "Brujo", "Bruja" },
		[050] = { "Controlador de la Realidad", "Controladora de la Realidad" },
		[060] = { "Señor de los Hechizos", "Señora de los Hechizos" },
		[070] = "Chamán Invocador",
		[080] = { "El Jinete de la Pestilencia", "La Amazona de la Pestilencia" },
		[090] = { "El Jinete de la Hambruna", "La Amazona de la Hambruna" },
		[100] = { "El Jinete de la Guerra", "La Amazona de la Guerra" },
		[110] = { "El Jinete de la Muerte", "La Amazona de la Muerte" },
		[120] = "El Vacío"
	},

	newLevel = "<FC>%s<FC> alcanzó el nivel <B>%d</B>!",
	level = "Nivel %d",

	helpTitles = {
		[2] = "Comandos",
		[3] = "Contribuir",
		[4] = "¿Qué hay de nuevo?"
	},
	helpContent = {
		[1] = "<FC><p align='center'>¡#POWERS!</p>\n\n" ..
			"<J>Tu objetivo en este módulo es sobrevivir de los ataques de tus oponentes.\n\n" ..
			"<N>Hay una variedad de poderes <font size='12'>- los cuales se desbloquean alcanzando niveles más altos -</font> para atacar y defenderte.\n" ..
			"Escribe <FC><B>!powers</B><N> para saber más sobre los poderes que desbloqueaste!\n\n" ..
			"%s\n\n" ..
			"Este módulo fue desarrollado por %s"
		,
		[2] = "<FC><p align='center'>COMANDOS GENERALES</p><N>\n\n<font size='12'>",
		[3] = "<FC><p align='center'>CONTRIBUIR<N>\n\n" ..
			"¡Nos encanta el Código Abierto <font color='#E91E63'>♥</font>! Puedes ver y modificar el código de este módulo en <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"Mantener el módulo es estrictamente voluntaio, por lo que cualquier ayuda con respecto al <V>código<N>, <V>corrección y reporte de bugs<N>, <V>sugerencias y mejoras<N>, <V>creación de mapas <N>es bienvenida y apreciada.\n" ..
			"<p align='left'>• Puedes <FC>reportar bugs <N>o <FC>sugerir <N>en <a href='event:print_discord.gg/quch83R'><font color='#087ECC'>Discord</font></a> y/o en <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• Puedes <FC>enviar mapas <N>en nusetro <a href='event:print_atelier801.com/topic?f=6&t=888677'><font color='#087ECC'>Hilo de Envíos de Mapas en los Foros</font></a>.\n\n" ..
			"<p align='center'>También podes <FC>donar</FC> cualquier cantidad <a href='event:print_a801-luadev.github.io/?redirect=powers'><font color='#087ECC'>aquí</font></a> para ayudar el mantenimiento del módulo. Todas las donaciones obtenidas a través del link serán invertidas en actualizaciones y mejoras constantes del módulo.\n\n" ..
			"<a href='event:print_atelier801.com/topic?f=6&t=888676'><font size='18' color='#087ECC'>Hilo en los Foros</font></a></p>"
		,
		[4] = "<FC><p align='center'>¿QUÉ HAY DE NUEVO?</p><N>\n\n" ..
			"• Ahora puedes leer acerca de todos los poderes.\n" ..
			"• El módulo se volvió oficial.\n" ..
			"• El módulo ha sido completamente reescrito."
	},

	commandDescriptions = {
		help = "Abre este menú.",
		powers = "Abre un menú que muestra todos los poderes y su información.",
		profile = "Abre tu perfil o el de alguien más.",
		leaderboard = "Abre el ranking global.",

		pw = "Proteje la sala con una contraseña. El comando sin argumentos la quita."
	},
	commandsParameters = {
		profile = "[jugador] ",

		pw = "[contraseña] "
	},
	["or"] = "o",

	profileData = {
		rounds = "Rondas",
		victories = "Victorias",
		kills = "Muertes",
		xp = "Experiencia",
		badges = "Insignias"
	},

	leaderboard = "Ranking",
	leaderboardIsLoading = "<BL>[<VI>•<BL>] El ranking aún se está cargando. Prueba de nuevo en unos segundos.",

	addMap = "<BV>[<FC>•<BV>] El mapa <J>@%s</J> fue añadido a la rotación de mapas local.",
	remMap = "<BV>[<FC>•<BV>] El mapa <J>@%s</J> fue quitado de la rotación de mapas local.",
	listMaps = "<BV>[<FC>•<BV>] Mapas (<J>#%s</J>): %s",

	enableParticles = "<ROSE>No olvides de ACTIVAR los efectos epeciales/partículas para poder ver el juego correctamente. (En 'Menú' → 'Opciones', cerca de 'Lista de Salas')</ROSE>",

	ban = "%s <ROSE>fue baneado de #powers por %s <ROSE>por %d horas. Razón: %s",
	unban = "<ROSE>Fuiste desbaneado por %s",
	isBanned = "<ROSE>Fuiste baneado de #powers hasta %s GMT+2 (%d horas restantes).",
	permBan = "%s <ROSE>fue baneado permanentemente de #powers por %s<ROSE>. Razón: %s",

	playerGetRole = "<FC>%s <FC>fue promovido a <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>ya no es un <font color='#%x'>%s</font>.",

	enableReviewMode = "<BV>[<FC>•<BV>] El <FC>Modo de Revisión de Mapas<BV> fue activado. Las siguientes rondas <B>no</B> contarán estadísticas y los mapas que aparezcan están siendo probados para la rotación de mapas del módulo. Todos los poderes fueron activados y poderes divinos son más probables!",
	disableReviewMode = "<BV>[<FC>•<BV>] El <FC>Modo de Revisión de Mapas<BV> fue desactivado y todo volverá a la normalidad en la siguiente ronda!",

	getBadge = "<FC>%s<FC> desbloqueó una insignia de #powers!",

	setPassword = "<BL>[<VI>•<BL>] %s <BL>cambió la contraseña a %q.",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>quitó la contraseña de la sala."
}

--[[ translations/fr.lua ]]--
-- Translated by Jaker#9310
translations.fr = {
	greeting = "<FC>Bienvenue dans <B>#powers</B>!\n" ..
		"\t• Appuyez sur <B>H</B> ou écrivez <B>!help</B> pour en connaître plus à propos du module.\n" ..
		"\t• Appuyez sur <B>O</B> ou écrivez <B>!powers</B> pour en connaître plus à propos des pouvoirs.",
	kill = "<R>%s<FC> a tué %s",

	mentionWinner = "<FC>%s<FC> a gagné la manche !",
	noWinner = "<FC>Personne n'a gagné la manche. :(",

	minPlayers = "Au moins <B>2</B> joueurs doivent être dans le salon pour que le jeu démarre.",

	powers = {
		lightSpeed = "Vitesse Lumière",
		laserBeam = "Rayon Laser",
		wormHole = "Trou de vers",
		doubleJump = "Double-saut",
		helix = "Hélix",
		dome = "Dôme",
		lightning = "Eclair",
		superNova = "Supernova",
		meteorSmash = "Collision de météorite",
		gravitationalAnomaly = "Anomalie Gravitationnelle",
		deathRay = "Rayon de la mort",
		atomic = "Atomique",
		dayOfJudgement = "Jour de Jugement"
	},
	powersDescriptions = {
		lightSpeed = "Déplace votre souris en Vitesse Lumière, repoussant tous les ennemis autour.",
		laserBeam = "Tire un rayon laser qui est si puissant que les ennemis peuvent le ressentir.",
		wormHole = "Vous téléporte droit devant à travers un Trou de Vers.",
		doubleJump = "Réalise un double-saut haut et auxiliaire.",
		helix = "Rend les diagonales de votre souris plus rapide avec un puissant Hélix.",
		dome = "Crée un dôme protecteur qui repousse tous les ennemis.",
		lightning = "Invoque un puissant tonnerre qui électrifie vos ennemis.",
		superNova = "Forme une Supernova qui détruit tous les ennemis autour.",
		meteorSmash = "Frappe les ennemis comme une météorite.",
		gravitationalAnomaly = "Forme une anomalie gravitationnelle.",
		deathRay = "Grille les ennemis avec le puissant et mystérieux rayon.",
		atomic = "Change aléatoirement la taille de tous les joueurs.",
		dayOfJudgement = "Ressucite tous les ennemis, mais ils sont tous liés les uns aux autres."
	},
	powerType = {
		atk = "ATTAQUE (%d)",
		def = "DEFENSE",
		divine = "DIVIN"
	},

	unlockPower = "<FC>[<J>•<FC>] Vous avez débloqué les pouvoirs suivant(s): %s",

	levelName = {
		[000] = { "Mutant", "Mutante" },
		[010] = { "Nécromancien", "Nécromancienne" },
		[020] = "Scientifique",
		[030] = { "Titan", "Titane" },
		[040] = { "Sorcier", "Sorcière" },
		[050] = { "Contrôleur de Réalité" },
		[060] = { "Seigneur des Enchantements", "Maîtresse des Enchantements" },
		[070] = { "Invocateur Chaman", "Invocatrice Chamane" },
		[080] = { "Le Chevalier de la Peste", "La Chevalière de la Peste"},
		[090] = { "Le Chevalier de la Famine", "La Chevalière de la Famine" },
		[100] = { "Le Chevalier de Guerre", "La Chevalière de Guerre" },
		[110] = { "Le Chevalier Mort", "La Chevalière Morte" },
		[120] = "Le Vide"
	},

	newLevel = "<FC>%s<FC> a atteint le niveau <B>%d</B>!",
	level = "Niveau %d",

	helpTitles = {
		[2] = "Commandes",
		[3] = "Contribuer",
		[4] = "Quoi d'neuf ?"
	},
	helpContent = {
		[1] = "<FC><p align='center'>#POWERS!</p>\n\n" ..
			"<J>Le but dans ce module est de survivre contre les attaques ennemies.\n\n" ..
			"<N>Il y a une variété de pouvoirs <font size='12'>- qui sont obtenus en atteignant de plus hauts niveaux -</font> pour attaquer et défendre.\n" ..
			"Ecrivez <FC><B>!powers</B><N> pour en savoir plus à propos des pouvoirs que vous avez obtenu depuis !\n\n" ..
			"%s\n\n" ..
			"Ce module a été développé par %s"
		,
		[2] = "<FC><p align='center'>COMMANDES</p><N>\n\n<font size='12'>",
		[3] = "<FC><p align='center'>CONTRIBUER<N>\n\n" ..
			"Nous adorons ouvrir les sources <font color='#E91E63'>♥</font> ! Vous pouvez voir et modifier le code de source de ce module sur <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"Maintenir le module est strictement volontaire, donc n'importe quel aide à propos<V>du Code<N>, <V>de la réparation de bugs, des signalements<N>, <V>dessuggestions ou des renforcements de fonctionnalités<N>, <V>de la réalisationde carte <N>est la bienvenue et très apprécié.\n" ..
			"<p align='left'>• Vous pouvez <FC>signaler des bugs <N>ou <FC>faire des suggestions <N>sur <a href='event:print_discord.gg/quch83R'><font color='#087ECC'>Discord</font></a> and/ou sur <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• Vous pouvez <FC>proposer vos cartes <N>dans notre <a href='event:print_atelier801.com/topic?f=6&t=888677'><font color='#087ECC'>Map Submissions Sujet dans le Forum</font></a>.\n\n" ..
			"<p align='center'>Vous pouvez aussi <FC>donner</FC> n'importe quel somme d'argent <a href='event:print_a801-luadev.github.io/?redirect=powers'><font color='#087ECC'>ici</font></a> pour aider à maintenir le module. Tous les fonts obtenus à travers ce lien seront utilisés dans les mise à jours et l'amélioration.\n\n" ..
			"<a href='event:print_atelier801.com/topic?f=6&t=888676'><font size='18' color='#087ECC'>Sujet dans le Forum</font></a></p>"
		,
		[4] = "<FC><p align='center'>QUOI D'NEUF ?</p><N>\n\n" ..
			"• Vous pouvez lire à propos de tous les pouvoirs maintenant.\n" ..
			"• Le module est devenu officiel.\n" ..
			"• Le module a été complètement ré-écrit."
	},

	commandDescriptions = {
		help = "Ouvre ce menu.",
		powers = "Ouvre un menu avec tous les pouvoirs et leurs infos.",
		profile = "Ouvre votre profile ou celui de quelqu'un d'autre.",
		leaderboard = "Ouvre le classement global.",

		pw = "Instaure un mot de passe pour le salon. Ne pas écrire de mot de passe pour le désactiver."
	},
	commandsParameters = {
		profile = "[nom_d'un_joueur] ",

		pw = "[password] "
	},
	["or"] = "ou",

	profileData = {
		rounds = "Manches",
		victories = "Victoires",
		kills = "Tués",
		xp = "Expérience",
		badges = "Badges"
	},

	leaderboard = "Classement",
	leaderboardIsLoading = "<BL>[<VI>•<BL>] Le classement est toujours en train de charger. Ré-essayez dans quelques secondes.",

	addMap = "<BV>[<FC>•<BV>] La carte <J>@%s</J> a été ajoutée dans la liste des cartes locales.",
	remMap = "<BV>[<FC>•<BV>] The map <J>@%s</J> a été retirée de la liste des cartes locales.",
	listMaps = "<BV>[<FC>•<BV>] Cartes (<J>#%d</J>): %s",

	enableParticles = "<ROSE>N'OUBLIEZ PAS D'ACTIVER les effets/particules spéciales pour voir le jeu normalement. (Dans 'Menu' → 'Options', à côté de 'Liste de salon')</ROSE>",

	ban = "%s <ROSE>a été banni de #powers par %s <ROSE>pendant %d heures. Raison: %s",
	unban = "<ROSE>Votre bannissement a été supprimé par %s",
	isBanned = "<ROSE>Vous êtes banni de #powers jusqu'à GMT+2 %s (%d heures restantes).",
	permBan = "%s <ROSE>a été banni de #powers définitivement par %s<ROSE>. Raison: %s",

	playerGetRole = "<FC>%s <FC>a été promu(e) vers <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>n'est plus <font color='#%x'>%s</font>.",

	enableReviewMode = "<BV>[<FC>•<BV>] Le <FC>Mode de vérification de cartes<BV> est activé. Les prochaines manches ne sauvegarderont <B>pas</B> les statistiques et les cartes qui apparaissent sont en test pour la rotation de cartes du module. Tous les pouvoirs sont activés et les pouvoirs divins peuvent arriver !",
	disableReviewMode = "<BV>[<FC>•<BV>] Le <FC>Mode de vérification de cartes<BV> a été désactivé donc tout redeviendra normal à la prochaine manche !",

	getBadge = "<FC>%s<FC> vient juste de débloquer un nouveau badge de #powers !",

	setPassword = "<BL>[<VI>•<BL>] %s <BL>a instauré le mot de passe %q.",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>a retiré le mot de passe du salon."
}

--[[ translations/pl.lua ]]--
-- Translated by Michipol#0000
translations.pl = {
	greeting = "<FC>Witaj w <B>#powers</B>!\n" ..
		"\t• Naciśnij <B>H</B> albo wpisz <B>!help</B> aby przeczytać więcej o module.\n" ..
		"\t• Naciśnij <B>O</B> albo wpisz <B>!powers</B> aby przeczytać więcej o mocach.",
	kill = "<R>%s<FC> zabił %s",

	mentionWinner = "<FC>%s<FC> wygrywa rundę!",
	noWinner = "<FC>Nikt nie wygrywa rundy. :(",

	minPlayers = "Aby rozpocząć grę muszą być minimum <B>2</B> osoby w pokoju.",

	powers = {
		lightSpeed = "Prędkość światła",
		laserBeam = "Laserowy Promień",
		wormHole = "Tunel Czasoprzestrzenny",
		doubleJump = "Podwójny skok",
		helix = "Spirala",
		dome = "Tarcza",
		lightning = "Błyskawica",
		superNova = "Supernowa",
		meteorSmash = "Wybuch Meteorytu",
		gravitationalAnomaly = "Grawitacyjna Anomalia",
		deathRay = "Promień śmierci",
		atomic = "Atomic",
		dayOfJudgement = "Dzień sądu"
	},
	powersDescriptions = {
		lightSpeed = "Twoja mysz osiąga prędkość światła i popycha przy tym wszystkich wrogów.",
		laserBeam = "Wystrzeliwuje wiązkę laserową, która jest odczuwalna przez wszystkich przeciwników.",
		wormHole = "Teleportuje Cię do przodu używając przy tym tunelu czasoprzestrzennego.",
		doubleJump = "Wykonuje wysoki podójny skok.",
		helix = "Prędkość Twojej myszy wzrasta dzięki potęznej mocny spirali.",
		dome = "Tworzy ochronną tarczę, która odpycha przeciwników.",
		lightning = "Przywołuje potężną błyskawicę, która elektryzuje wrogów.",
		superNova = "Uruchamia supernową , która niszczy wszystkich pobliskich wrogów.",
		meteorSmash = "Wysadza wszystkich wrogów.",
		gravitationalAnomaly = "Rozpoczyna grawitacyjną anomalię.",
		deathRay = "Zalewa wrogów potężnym i tajemniczym promienim śmierci.",
		atomic = "Losowo zmienia rozmiar wszystkich graczy.",
		dayOfJudgement = "Ożywia wszystkich martwych wrogów i łączy ich ze sobą."
	},
	powerType = {
		atk = "ATAK (%d)",
		def = "OBRONA",
		divine = "BOSKI"
	},

	unlockPower = "<FC>[<J>•<FC>] Odblokowałeś nową moc: %s",

	levelName = {
		[000] = { "Mutant", "Mutantka" },
		[010] = { "Nekromanta", "Nekromantka" },
		[020] = "Naukowiec",
		[030] = "Tytan",
		[040] = { "Czarodziej", "Czarodziejka" },
		[050] = { "Władca Rzeczywistości", "Władczyni Rzeczywistości" },
		[060] = { "Władca Czarów", "Władczyni Czarów" },
		[070] = { "Szamański Przywoływacz", "Szamańska Przywoływaczka" },
		[080] = "Jeździec Zarazy",
		[090] = "Jeździec Głodu",
		[100] = "Jeździec Wojny",
		[110] = "Jeździec Śmierci",
		[120] = "Pustka"
	},

	newLevel = "<FC>%s<FC> osiągnął poziom <B>%d</B>!",
	level = "Poziom %d",

	helpTitles = {
		[2] = "Komendy",
		[3] = "Współpraca",
		[4] = "Co nowego?"
	},
	helpContent = {
		[1] = "<FC><p align='center'>#POWERS!</p>\n\n" ..
			"<J>Twoim celem w tym module jest przetrwać ataki przeciwników.\n\n" ..
			"<N>Jest tutaj wiele mocy <font size='12'>- które są odblokowywane poprzez osiągnięcie wyższych poziomów -</font> do ataku i obrony.\n" ..
			"Wpisz <FC><B>!powers</B><N> aby dowiedzieć się więcej o odblokowanych już mocach!\n\n" ..
			"%s\n\n" ..
			"Ten moduł został stworzony przez %s"
		,
		[2] = "<FC><p align='center'>KOMENDY</p><N>\n\n<font size='12'>",
		[3] = "<FC><p align='center'>WSPÓŁPRACA<N>\n\n" ..
			"Uwielbiamy Open Source <font color='#E91E63'>♥</font>! Możesz zobaczyć i zmodyfikować kod źródłowy tego modułu na <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"Utrzymanie modułu jest dobrowolne, więc jakakolwiek pomoc w <V>Kod<N>, <V>naprawa błędów i zgłoszenia<N>, <V>sugestie i ulepszenia fukcji<N>, <V>tworzenie map <N>jest mile widziana i bardzo ceniona.\n" ..
			"<p align='left'>• Możesz <FC>zgłosić błędy <N>lub <FC>sugestie <N>na <a href='event:print_discord.gg/quch83R'><font color='#087ECC'>Discord</font></a> lub na <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• Możesz <FC>zgłosić mapy <N>w naszym <a href='event:print_atelier801.com/topic?f=6&t=888677'><font color='#087ECC'>Wątku do zgłoszenia map na Forum.</font></a>.\n\n" ..
			"<p align='center'>Możesz też <FC>wpłacić</FC> dowolną kwotę <a href='event:print_a801-luadev.github.io/?redirect=powers'><font color='#087ECC'>tutaj</font></a> aby pomóc utrzymać moduł. Wszystkie fundusze zostaną przekazane na nowe aktualizacje i dalsze rozwijanie się modułu.\n\n" ..
			"<a href='event:print_atelier801.com/topic?f=6&t=888676'><font size='18' color='#087ECC'>Wątek na Forum</font></a></p>"
		,
		[4] = "<FC><p align='center'>Co nowego?</p><N>\n\n" ..
			"• Teraz możesz przeczytać opis wszystkich mocy.\n" ..
			"• Moduł ~~stał się~~ oficjalny.\n" ..
			"• Moduł został całkowicie napisany na nowo."
	},

	commandDescriptions = {
		help = "Otwiera to menu.",
		powers = "Otwiera menu z listą wszystkich mocy i informacjami na ich temat.",
		profile = "Otwiera Twój lub kogoś profil.",
		leaderboard = "Otwiera globalną tablice wyników.",

		pw = "Zabezpiecza room hasłem. Wyślij pustą komendę, aby usunąć istniejące już hasło."
	},
	commandsParameters = {
		profile = "[nick_gracza] ",

		pw = "[hasło] "
	},
	["or"] = "lub",

	profileData = {
		rounds = "Rundy",
		victories = "Zwycięstwa",
		kills = "Zabicia",
		xp = "Doświadczenie",
		badges = "Odznaki"
	},

	leaderboard = "Tabela wyników",
	leaderboardIsLoading = "<BL>[<VI>•<BL>] Tabela się wciąż ładuje. Spróbuj ponownie za kilka sekund.",

	addMap = "<BV>[<FC>•<BV>] Mapa <J>@%s</J> została dodana do kolejki.",
	remMap = "<BV>[<FC>•<BV>] Mapa <J>@%s</J> Została usunięta z kolejki.",
	listMaps = "<BV>[<FC>•<BV>] Mapy (<J>#%d</J>): %s",

	enableParticles = "<ROSE>NIE zapomnij o WŁĄCZENIU efektów cząsteczkowych aby wyświetlać moduł prawidłowo. (W \"Menu\" → \"Opcje\", obok \"Lista Room'ów\")</ROSE>",

	ban = "%s <ROSE>został zbanowany z #powers przez %s <ROSE>na %d godzin. Powód: %s",
	unban = "<ROSE>Zostałeś odbanowany przez %s",
	isBanned = "<ROSE>Zostałeś zbanowany z #powers do GMT+2 %s (%d godzin do końca).",
	permBan = "%s <ROSE>został zbanowany na stałe z #powers przez %s<ROSE>. Powód: %s",

	playerGetRole = "<FC>%s <FC>zyskuje rolę <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>traci rolę <font color='#%x'>%s</font>!",

	enableReviewMode = "<BV>[<FC>•<BV>] <FC>Tryb podglądu map<BV> jest włączony. Następne rundy <B>nie</B> będą liczone do statystyk i mapy będą tylko do testu modułu. Wszystkie moce są włączone i bardziej prawdopodobne!",
	disableReviewMode = "<BV>[<FC>•<BV>]<FC>Tryb podglądu map<BV> został wyłączony i wszystko wróci do normalnośći przy następnej rundzie!",

	getBadge = "<FC>%s<FC> odblokował nową #powers odznakę!",

	setPassword = "<BL>[<VI>•<BL>] %s <BL>ustawił nowe hasło na %q.",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>usunął haslo z pokoju."
}

--[[ translations/ro.lua ]]--
-- Translated by Railysse#0000
translations.ro = {
	greeting = "<FC>Bine ai venit la <B>#powers</B>!\n" ..
		"\t• Apasă <B>H</B> sau scrie <B>!help</B> pentru a afla mai multe despre modul.\n" ..
		"\t• Apasă <B>O</B> sau scrie <B>!powers</B> pentru a afla mai multe despre puteri.",
	kill = "<R>%s<FC> a omorât pe %s",

	mentionWinner = "<FC>%s<FC> a câștigat runda!",
	noWinner = "<FC>Nimeni nu a câștigat runda. :(",

	minPlayers = "Trebuie să fie cel puțin <B>2</B> jucători pe sală pentru ca jocul să înceapă.",

	powers = {
		lightSpeed = "Viteza Luminii",
		laserBeam = "Rază Laser",
		wormHole = "Gaură de Vierme",
		doubleJump = "Săritură dublă",
		helix = "Spirală",
		dome = "Dom",
		lightning = "Fulger",
		superNova = "Supernovă",
		meteorSmash = "Lovitură de Meteorit",
		gravitationalAnomaly = "Anomalie Gravitațională",
		deathRay = "Raza Morții",
		atomic = "Atomic",
		dayOfJudgement = "Ziua Judecății"
	},
	powersDescriptions = {
		lightSpeed = "Moves your mouse in the light speed, pushing all enemies around.",
		laserBeam = "Aruncă o rază laser așa de puternică încât inamicii o pot simți.",
		wormHole = "Îți teleportează șoricelul în față, printr-o Gaură de Vierme.",
		doubleJump = "Performs an auxiliar and high double jump.",
		helix = "Îi dă un impuls șoricelului tău pe diagonală cu o spirală puternică.",
		dome = "Creează un dom protector care împinge toți inamicii din jur.",
		lightning = "Invocă un fulger puternic care electrocutează inamicii.",
		superNova = "Pornește o supernovă care distruge toți inamici din jur..",
		meteorSmash = "Lovește inamicii cu puterea unui meteorit.",
		gravitationalAnomaly = "Pornește o anomalie gravitațională.",
		deathRay = "Prăjește inamicii cu o puternică și misterioasă rază a morții.",
		atomic = "Schimbă mărimea jucătorilor într-un mod aleator.",
		dayOfJudgement = "Reînvie toți inamicii morți și îi leagă unul de celălalt."
	},
	powerType = {
		atk = "ATAC (%d)",
		def = "APĂRARE",
		divine = "DIVIN"
	},

	unlockPower = "<FC>[<J>•<FC>] Ai deblocat următoarele puteri: %s",

	levelName = {
		[000] = { "Mutant", "Mutantă" },
		[010] = { "Necromant", "Necromantă" },
		[020] = "Om de știință",
		[030] = "Titan",
		[040] = { "Vrăjitor", "Vrăjitoare" },
		[050] = { "Controlorul realității", "Controloarea realității" },
		[060] = { "Stăpânul vrăjilor", "Stăpâna vrăjilor" },
		[070] = { "Invocator Șamanic", "Invocatoare Șamanică" },
		[080] = { "Călărețul molimei", "Călăreața molimei" },
		[090] = { "Călărețul foametei", "Călăreața foametei" },
		[100] = { "Călărețul războiului", "Călăreața războiului" },
		[110] = { "Călărețul morții", "Călăreața morții" },
		[120] = "Vidul"
	},

	newLevel = "<FC>%s<FC> tocmai a atins nivelul <B>%d</B>!",
	level = "Nivel %d",

	helpTitles = {
		[2] = "Comenzi",
		[3] = "Contribuie",
		[4] = "Ce este nou?"
	},
	helpContent = {
		[1] = "<FC><p align='center'>#POWERS!</p>\n\n" ..
			"<J>Scopul tău în acest modul este de a supraviețui atacurilor inamice.\n\n" ..
			"<N>Există o multitudine de puteri folosite ofensiv sau defensiv <font size='12'>- care sunt deblocate atingând nivele superioare -</font>.\n" ..
			"Scrie <FC><B>!powers</B><N> pentru a afla mai multe despre puterile pe care le-ai deblocat până acum!\n\n" ..
			"%s\n\n" ..
			"Acest modul a fost dezvoltat de %s"
		,
		[2] = "<FC><p align='center'>COMENZI GENERALE</p><N>\n\n<font size='12'>",
		[3] = "<FC><p align='center'>CONTRIBUIE<N>\n\n" ..
			"Iubim Open Source <font color='#E91E63'>♥</font>! Poți vedea și schimba codul sursă al acestui modul pe <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"Mentenanța modului este strict voluntară, deci orice ajutor cu privire la <V>cod<N>, <V>bugfix-uri și raportări<N>, <V>sugestii și îmbunătățiri<N>, <V>crearea hărților <N>este binevenită și apreciată.\n" ..
			"<p align='left'>• Poți <FC>raporta bug-uri <N>sau <FC>să faci sugestii <N>pe <a href='event:print_discord.gg/quch83R'><font color='#087ECC'>Discord</font></a> și/sau pe <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• Poți <FC>trimite hărți <N>în Thread-ul nostru <a href='event:print_atelier801.com/topic?f=6&t=888677'><font color='#087ECC'>Map Submissions de pe Forum</font></a>.\n\n" ..
			"<p align='center'>Poți de asemenea să <FC>donezi</FC> orice sumă la <a href='event:print_a801-luadev.github.io/?redirect=powers'><font color='#087ECC'>aici</font></a> pentru a ajuta la menținerea modulului. Toate fondurile obținute prin link vor fi investite în asigurarea de update-uri constante ale modulului și îmbunătățiri generale.\n\n" ..
			"<a href='event:print_atelier801.com/topic?f=6&t=888676'><font size='18' color='#087ECC'>Thread pe Forum</font></a></p>"
		,
		[4] = "<FC><p align='center'>Ce este nou?</p><N>\n\n" ..
			"• Acum poți citi despre toate puterile.\n" ..
			"• Modulul a devenit oficial.\n" ..
			"• Modulul a fost rescris în întregime."
	},

	commandDescriptions = {
		help = "Deschide meniul.",
		powers = "Deschide un meniu care listează toate puterile și descrierile lor.",
		profile = "Deschide profilul tău sau al altcuiva.",
		leaderboard = "Deschide clasamentul global.",

		pw = "Protejează sala cu o parolă. Trimite necompletat pentru a o scoate."
	},
	commandsParameters = {
		profile = "[player_name] ",

		pw = "[password] "
	},
	["or"] = "sau",

	profileData = {
		rounds = "Runde",
		victories = "Victorii",
		kills = "Kill-uri",
		xp = "Experiență",
		badges = "Insigne"
	},

	leaderboard = "Clasament",
	leaderboardIsLoading = "<BL>[<VI>•<BL>] Clasamentul se încarcă. Încearcă iar în câteva secunde.",

	addMap = "<BV>[<FC>•<BV>] Harta <J>@%s</J> a fost adăugată în lista locală de așteptare.",
	remMap = "<BV>[<FC>•<BV>] Harta <J>@%s</J> a fost eliminată din lista locală de așteptare.",
	listMaps = "<BV>[<FC>•<BV>] Hărți (<J>#%d</J>): %s",

	enableParticles = "<ROSE>NU uita să ACTIVEZI efectele speciale/particulele pentru a vedea modulul cum trebuie. (În 'Meniu' → 'Opțiuni', lângă 'Lista sălilor')</ROSE>",

	ban = "%s <ROSE>a fost banat de pe #powers de către %s <ROSE>pentru %d ore. Motiv: %s",
	unban = "<ROSE>Ai fost debanat de către %s",
	isBanned = "<ROSE>Ești banat de pe #powers până la GMT+2 %s (încă %d ore).",
	permBan = "%s <ROSE>a fost banat permanent de pe #powers de către %s<ROSE>. Motiv: %s",

	playerGetRole = "<FC>%s <FC>a fost promovat la <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>nu mai este <font color='#%x'>%s</font>.",

	enableReviewMode = "<BV>[<FC>•<BV>] The <FC>Modul de Revizuire Hărți<BV> este activat. Următoarele runde <B>nu</B> vor lua în considerare statisticile și hărțile care vor apărea sunt testate pentru rotația hărtilor modulului. Au fost activate toate puterile, iar puterile divine au șansă mai mare să se petreacă!",
	disableReviewMode = "<BV>[<FC>•<BV>] The <FC>Modul de Revizuire Hărți<BV> a fost dezactivat și totul va reveni la normal începând cu următoarea rundă!",

	getBadge = "<FC>%s<FC> tocmai a deblocat o nouă insignă #powers!",

	setPassword = "<BL>[<VI>•<BL>] %s <BL>a pus parola %q.",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>a scos parola de pe sală."
}

--[[ translations/tr.lua ]]--
-- Translated by Bisharch#4886
translations.tr = {
	greeting = "<FC><B>#powers</B> modülüne hoş geldiniz!\n" ..
		"\t• Modül hakkında bilgi almak için <B>H</B> tuşuna basabilir ya da sohbete <B>!help</B> yazabilirsiniz.\n" ..
		"\t• Güçler hakkında bilgi almak için <B>O</B> tuşuna basabilir ya da sohbete <B>!powers</B> yazabilirsiniz.",
	kill = "<R>%s<FC>, %s adlı fareyi öldürdü.",

	mentionWinner = "<FC>%s<FC> raundu kazandı!",
	noWinner = "<FC>Kimse raundu kazanamadı. :(",

	minPlayers = "Oyunun başlaması için odada en az <B>2</B> kişi olması gerekiyor.",

	powers = {
		lightSpeed = "Işık Hızı",
		laserBeam = "Lazer Işını",
		wormHole = "Solucan Deliği",
		doubleJump = "Çift Zıplama",
		helix = "Helix",
		dome = "Kubbe",
		lightning = "Şimşek",
		superNova = "Süpernova",
		meteorSmash = "Meteor Vuruşu",
		gravitationalAnomaly = "Yerçekimsel Bozukluk",
		deathRay = "Ölüm Işını",
		atomic = "Atomik",
		dayOfJudgement = "Mahşer Günü"
	},
	powersDescriptions = {
		lightSpeed = "Önündeki tüm düşmanları iterek fareniz ışık hızında hareket eder.",
		laserBeam = "Düşmanların iliklerinde hissedebileceği bir lazer ışını.",
		wormHole = "Fareniz solucan deliğinde ışınlanır.",
		doubleJump = "Fareniz iki kere zıplayabilir.",
		helix = "Fareniz şarmal bir yol alıp çapraz bir şekilde hızlanır.",
		dome = "Tüm düşmanları ittiren bir koruyucu kubbe yaratır.",
		lightning = "Düşmanları elektriklerndiren bir güçlü bir şimşek yaratır.",
		superNova = "Etraftaki tüm düşmanları alt eden bir süpernova yaratır.",
		meteorSmash = "Düşmanları üstüne meteor yağmış gibi vurur.",
		gravitationalAnomaly = "Yerçekimini bozar.",
		deathRay = "Tüm düşmanları kızartır.",
		atomic = "Tüm oyuncuların boyutunu rastgele olarak değiştirir.",
		dayOfJudgement = "Birbirine bağlı olan tüm ölü düşmanları diriltir."
	},
	powerType = {
		atk = "SALDIRI (%d)",
		def = "SAVUNMA",
		divine = "KUTSAL"
	},

	unlockPower = "<FC>[<J>•<FC>] Bu gücün kilidini açtınız: %s",

	levelName = {
		[000] = "Mutant",
		[010] = "Ruh Çağıran",
		[020] = "Bilimfaresi",
		[030] = "Titan",
		[040] = "Büyücü",
		[050] = "Gerçekliğin Kontrolcüsü",
		[060] = "Sihirlerin Efendisi",
		[070] = "Şamanik Sihirdar",
		[080] = "Veba Atlısı",
		[090] = "Kıtlık Atlısı",
		[100] = "Savaş Atlısı",
		[110] = "Ölüm Atlısı",
		[120] = "Boşluk"
	},

	newLevel = "<FC>%s<FC> şu seviyeye ulaştı: <B>%d</B>!",
	level = "Seviye %d",

	helpTitles = {
		[2] = "Komutlar",
		[3] = "Katkıda Bulun",
		[4] = "Haberler"
	},
	helpContent = {
		[1] = "<FC><p align='center'>#POWERS!</p>\n\n" ..
			"<J>Bu modülde amacınız rakipleriniz saldırılarına karşı hayatta kalmak.\n\n" ..
			"<N>Saldırmak ve savunma yapmak için türlü türlü güçler <font size='12'>- ki bu güçler yüksek seviyelere gelerek açılıyor -</font> elde edebilirsiniz.\n" ..
			"Kilidini açtığınız güçler hakkında bilgi almak için sohbete <FC><B>!powers</B><N> yazabilirsiniz!\n\n" ..
			"%s\n\n" ..
			"%s, bu modülün geliştiricisidir."
		,
		[2] = "<FC><p align='center'>GENEL KOMUTLAR</p><N>\n\n<font size='12'>",
		[3] = "<FC><p align='center'>KATKIDA BULUN<N>\n\n" ..
			"Açık kaynak kodlu yazılımları seviyoruz <font color='#E91E63'>♥</font>! Bu modülün kaynak kodunu görebilir ve düzenleyebilirsiniz Kaynak koda erişmek için buraya tıklayın. <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"Modülü gönüllü olarak geliştirip devam ettirebilirsiniz. Bu yüzden <V>Kodlama<N>, <V>hata gidermeleri ve raporlar<N>, <V>öneriler ve özelliklerin artırılması ya da iyileştirilmesi<N>, <V>harita yapımı <N> hakkındaki öneri ve isteklerinizi memnuniyetle karşılıyoruz.\n" ..
			"<p align='left'>• Bu linkten <FC>Hataları raporlayabilir <N>ya da <FC>yeni şeyler önerebilirsiniz <N><a href='event:print_discord.gg/quch83R'><font color='#087ECC'>Discord</font></a> ya da buradan <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• Şuradan bize <FC>haritalarınızı gönderebilirsiniz <N> <a href='event:print_atelier801.com/topic?f=6&t=888677'><font color='#087ECC'>Forumdaki Harita Gönderme konusu</font></a>.\n\n" ..
			"<p align='center'>Ayrıca istediğiniz miktarda  <FC>bağışta</FC> bulunabilirsiniz. <a href='event:print_a801-luadev.github.io/?redirect=powers'><font color='#087ECC'>Bu linkten</font></a> Bu modülün sürdürülebilmesi için yardımlarınıza açığız. Toplanınan tüm para sürekli gelecek olan güncellemeler ve modülün genel iyileştirmeleri için harcanacaktır.\n\n" ..
			"<a href='event:print_atelier801.com/topic?f=6&t=888676'><font size='18' color='#087ECC'>Forum Konusu</font></a></p>"
		,
		[4] = "<FC><p align='center'>HABERLER</p><N>\n\n" ..
			"• Artık oyundaki tüm güçler hakkında bilgi sahibi olabilirsiniz.\n" ..
			"• Modülümüz artık resmî.\n" ..
			"• Modülümüz baştan sona tekrar yazıldı."
	},

	commandDescriptions = {
		help = "Bu menüyü açar.",
		powers = "Bütün güçlerin ve güçler hakkında bilginin olduğu menüyü açar.",
		profile = "Sizin ya da bir başkasının profilini gösterir.",
		leaderboard = "Küresel lider tahtasını gösterir.",

		pw = "Odaya şifre koyar. Şifreyi kaldırmak için sonrasına bir şey yazmadan gönderin."
	},
	commandsParameters = {
		profile = "[kullanıcı_adı] ",

		pw = "[şifre] "
	},
	["or"] = "or",

	profileData = {
		rounds = "Oynanılan raunt",
		victories = "Zaferler",
		kills = "Öldürmeler",
		xp = "Tecrübe",
		badges = "Rozetler"
	},

	leaderboard = "Lider Tahtası",
	leaderboardIsLoading = "<BL>[<VI>•<BL>] Lider tahtası yükleme aşamasında. Birkaç saniye sonra tekrar deneyin",

	addMap = "<BV>[<FC>•<BV>] <J>@%s</J> kodlu harita listeye eklendi.",
	remMap = "<BV>[<FC>•<BV>] <J>@%s</J> kodlu harita listeden silindi.",
	listMaps = "<BV>[<FC>•<BV>] Haritalar (<J>#%d</J>): %s",

	enableParticles = "<ROSE>Özel efektleri/parçacıkları aktive etmeyi unutmayın. Modülü daha iyi görebilmeniz için bunu yapmanız gereklidir. (‘Menü’den → ‘Ayarlar’, ’Oda Listesi’nin yanında)</ROSE>",

	ban = "%s <ROSE>isimli kullanıcı #powers modülünden uzaklaştırılmıştır. Cezalandıran: %s <ROSE>Süre: %d saat. Sebep: %s",
	unban = "<ROSE>%s uzaklaştırma cezanızı kaldırdı.",
	isBanned = "<ROSE> #powers modülünden şu kadar süre için uzaklaştırıldınız: Fransa saati ile %s (%d saat kaldı).",
	permBan = "%s <ROSE> isimli kullanıcı #powers modülünden kalıcı olarak uzaklaştırılmıştır. Cezalandıran: %s<ROSE>. Sebep: %s",

	playerGetRole = "<FC>%s <FC>isimli kullanıcı artık <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>isimli kullanıcı artık <font color='#%x'>%s</font> değil.",

	enableReviewMode = "<BV>[<FC>•<BV>] <FC>Harita değerlendirme modu<BV> aktive edildi. Gelecek raundlar profilinize sayı <B> eklemeyecek </B> ve çıkan haritalar da harita rotasyonuna girmek için sınanacaktır. Tüm güçler aktive edildi ve kutsal güçlerin ortaya çıkma şansı artırıldı!",
	disableReviewMode = "<BV>[<FC>•<BV>] <FC>Harita değerlendirme modu<BV> kapatıldı ve gelecek raundda her şey eski haline dönecek!",

	getBadge = "<FC>%s<FC> yeni bir #powers rozeti kazandı!",

	setPassword = "<BL>[<VI>•<BL>] %s <BL> isimli kullanıcının koyduğu şifre: %q.",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>isimli kullanıcı odanın şifresini kaldırdı."
}

--[[ translations/cn.lua ]]--
-- Translated by Wrfg#0000
translations.cn = {
	greeting = "<FC>歡迎來到 <B>#powers</B>!\n" ..
		"\t• 按 <B>H鍵</B> 或輸入 <B>!help</B> 了解更多關於這小遊戲的資訊。\n" ..
		"\t• 按 <B>O鍵</B> 或輸入 <B>!powers</B> 了解更多關於能力的資訊。",

	mentionWinner = "<FC>%s<FC> 勝出了回合!",
	noWinner = "<FC>這回合沒有人勝出。 :(",

	minPlayers = "房間裡最少需要 <B>2</B> 個玩家遊戲才會開始。",

	powers = {
		lightSpeed = "光速",
		laserBeam = "雷射光束",
		wormHole = "蟲洞",
		doubleJump = "雙重跳躍",
		helix = "螺旋",
		dome = "圓頂",
		lightning = "雷電閃現",
		superNova = "超新星",
		meteorSmash = "隕石壓頂",
		gravitationalAnomaly = "重力異象",
		deathRay = "死亡射線",
		atomic = "原子",
		judgmentDay = "審判之日"
	},
	powersDescriptions = {
		lightSpeed = "你會以光速移動, 推開附近的所有敵人。",
		laserBeam = "發射出一束雷射來燃燒敵人。",
		wormHole = "通過蟲洞傳送你到目的地。",
		doubleJump = "使用出輔助而且更高的雙重跳躍。",
		helix = "一個強勁的螺旋會對角性的加速你的小鼠。",
		dome = "製造出一個保護圓頂把附近所有敵人推開。",
		lightning = "召喚出一道雷電來讓敵人觸電。",
		superNova = "超新星開始爆炸毀滅附近所有敵人。",
		meteorSmash = "跟隕石一樣的輾壓敵人。",
		gravitationalAnomaly = "使重力開始變得異常。",
		deathRay = "使用強大而且神秘的死亡光束把敵人烤焦。",
		atomic = "隨機改變所有玩家的身體大小。",
		judgmentDay = "復活所有死掉的敵人, 同時把他們都綁在一起。"
	},

	unlockPower = "<FC>[<J>•<FC>] 你解鎖了以下能力: %s",

	levelName = {
		[000] = "變異體",
		[010] = "死靈法師",
		[020] = "瘋狂科學家",
		[030] = "泰坦",
		[040] = { "巫師", "巫女" },
		[050] = "現實操弄者",
		[060] = { "法術爵士", "法術夫人" },
		[070] = "薩滿神力者",
		[080] = "瘟疫大臣",
		[090] = "饑荒之源",
		[100] = "戰爭馭手",
		[110] = "死亡神",
		[120] = "無盡虛空"
	},

	newLevel = "<FC>%s<FC> 達到等級 <B>%d</B> 了!",
	level = "等級 %d",

	helpTitles = {
		[2] = "指令",
		[3] = "貢獻",
		[4] = "新鮮事?"
	},
	helpContent = {
		[1] = "<FC><p align='center'>#POWERS!</p>\n\n" ..
			"<J>你在這遊戲的目標是從敵人的攻擊中生存下來。\n\n" ..
			"<N>那裡有不同種類的能力 <font size='12'>- 只要你到達更高等級就可以解鎖 -</font> 用來攻擊跟防守。\n" ..
			"輸入 <FC><B>!powers</B><N> 來了解更多關於你解鎖了的能力!\n\n" ..
			"%s\n\n" ..
			"這個小遊戲由 %s 研發"
		,
		[2] = "<FC><p align='center'>主要指令</p><N>\n\n<font size='12'>",
		[3] = "<FC><p align='center'>貢獻<N>\n\n" ..
			"我們熱愛開放原始碼 <font color='#E91E63'>♥</font>! 你可以查看及修改 這個遊戲的原始碼: <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"維護這個小遊戲完全是義務性質, 所以任何在<V>編程<N>, <V>漏洞回饋<N>, <V>建議及其他地方的改善<N>, <V>地圖創作<N>上的協助將會是十分歡迎而且感激。\n" ..
			"<p align='left'>• 你可以在這裡 <FC>回報漏洞<N> 或 <FC>提供建議: <N>on <a href='event:print_discord.gg/quch83R'><font color='#087ECC'>Discord</font></a> 及/或在 <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• 你可以在我們的 <a href='event:print_atelier801.com/topic?f=5&t=918371'><font color='#087ECC'>論壇帖子 <FC>提交你的地圖<N>論壇帖子</font></a>.\n\n" ..
			"<p align='center'>你也可以 <FC>捐贈</FC> 任何金額 <a href='event:print_a801-luadev.github.io/?redirect=powers'><font color='#087ECC'>here</font></a> 來協助小遊戲的維護。所有籌得的捐款將會 被用作恆常的小遊戲更新及改善。</p>"
		,
		[4] = "<FC><p align='center'>新鮮事?</p><N>\n\n" ..
			"• 小遊戲變成官方小遊戲了。\n" ..
			"• 小遊戲被重新打造。"
	},

	commandDescriptions = {
		help = "打開菜單。",
		powers = "打開列出所有能力簡介的菜單。",
		profile = "打開你或其他人的資料。",
		leaderboard = "打開伺服排行榜。",

		pw = "使用密碼鎖起房間。發送空的密碼來解除鎖定。"
	},
	commandsParameters = {
		profile = "[玩家名稱] ",

		pw = "[密碼] "
	},
	["or"] = "或",

	profileData = {
		rounds = "回合",
		victories = "勝利次數",
		kills = "殺敵次數",
		xp = "經驗",
		badges = "徽章"
	},

	leaderboard = "排行榜",
	leaderboardIsLoading = "<BL>[<VI>•<BL>] 排行榜正在加載中。請在幾秒後再嘗試。",

	addMap = "<BV>[<FC>•<BV>] 地圖 <J>@%s</J> 已被加到地圖序列中。",
	remMap = "<BV>[<FC>•<BV>] 地圖 <J>@%s</J> 已從地圖序列中移除。",
	listMaps = "<BV>[<FC>•<BV>] 地圖 (<J>#%s</J>): %s",

	enableParticles = "<ROSE>別忘記啟用特別效果/粒子模式來使遊戲外觀更好。 (在 '房間列表' 旁邊的 '菜單' → '效果')</ROSE>",

	ban = "%s <ROSE>被 %s <ROSE>從 #power 封禁 %d 小時。原因: %s",
	unban = "<ROSE>你已經被 %s 解除封禁。",
	isBanned = "<ROSE>你已經從 #power 被封禁直到 GMT+2 %s (剩餘 %d 小時)。",
	permBan = "%s <ROSE>已經從 #power 被 %s <ROSE>永久封禁。原因: %s",

	playerGetRole = "<FC>%s <FC>被晉升至 <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>不再是 <font color='#%x'>%s</font> 了。",

	enableReviewMode = "<BV>[<FC>•<BV>] <FC>地圖檢視模式<BV> 已經啟用。下一回合的數據將 <B>不會</B> 被保存而且出現的地圖是用以測試遊戲中的地圖循環。所有能力都可以使用以及有更大的機會可以使出神聖的能力!",
	disableReviewMode = "<BV>[<FC>•<BV>] <FC>地圖檢視模式<BV> 已被關閉以及一切將會在下一回合裡回復正常!",

	getBadge = "<FC>%s<FC> 剛剛解鎖了新的 #powers 徽章!",

	setPassword = "<BL>[<VI>•<BL>] %s <BL>設置了密碼 %q。",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>移除了房間密碼。"
}

--[[ translations/he.lua ]]--
-- Translated by Danielthemouse#6206
translations.he = {
	greeting = "<FC>ברוכים הבאים אל <B>#powers</B>!\n" ..
		"\t• לחצו <B>H</B> או רשמו <B>!help</B> כדי ללמוד עוד על המודול.\n" ..
		"\t• לחצו <B>O</B> או רשמו <B>!powers</B> כדי ללמוד עוד על הכוחות.",

	mentionWinner = "<FC>%s<FC> ניצחו את הסיבוב!",
	noWinner = "<FC>אף אחד לא ניצח את הסיבוב. :(",

	minPlayers = "לפחות <B>2</B> שחקנים צריכים להיות בחדר בשביל שהמשחק יתחיל.",

	powers = {
		lightSpeed = "מהירות האור",
		laserBeam = "קרן לייזר",
		wormHole = "חור תולעת",
		doubleJump = "קפיצה כפולה",
		helix = "הליקס",
		dome = "כיפה",
		lightning = "ברק",
		superNova = "סופר-נובה",
		meteorSmash = "מכת מטאור",
		gravitationalAnomaly = "אנטי-גרביטציה",
		deathRay = "קרן מוות",
		atomic = "אטומי",
		dayOfJudgement = "יום הדין"
	},
	powersDescriptions = {
		lightSpeed = "מזיז את העכבר שלכם במהירות האור, דוחף את כל האויבים שבדרך.",
		laserBeam = "יורה קרן לייזר כל כך חזקה שהאויבים יכולים להרגיש אותה.",
		wormHole = "משגר את העכבר שלכם קדימה בעזרת חור תולעת.",
		doubleJump = "מבצע קפיצה כפולה גבוהה.",
		helix = "מאיץ את העכבר שלכם באלכסון בעזרת הליקס חזק.",
		dome = "יוצר כיפת הגנה שדוחפת את כל האויבים שבסביבה.",
		lightning = "יוצר ברק רב עוצמה שמחשמל את האויבים.",
		superNova = "יוצר סופרנובה שמשמידה את כל האויבים שבסביבה.",
		meteorSmash = "מוחץ את האויבים כמו התרסקות מטאור.",
		gravitationalAnomaly = "יוצר חריגת גרוויטציה.",
		deathRay = "מחמם את האויבים עם קרן לייזר מיסטורית וחזקה.",
		atomic = "משנה באקראיות את הגודל של כל השחקנים.",
		dayOfJudgement = "מחייה את כל השחקנים המתים, אבל כשכולם קשורים אחד לשני."
	},
	powerType = {
		atk = "התקפה (%d)",
		def = "הגנה",
		divine = "אלוהי"
	},

	unlockPower = "<FC>[<J>•<FC>] פתחת את הכוח(ות) הבאים: %s",

	levelName = {
		[000] = { "מוטנט", "מוטנטית" },
		[010] = { "מתקשר עם המתים", "מתקשרת עם המתים" },
		[020] = { "מדען", "מדענית" },
		[030] = "טיטאן",
		[040] = { "מכשף", "מכשפה" },
		[050] = { "שולט במציאות", "שולטת במציאות" },
		[060] = { "לורד הכישופים", "גברת הכישופים" },
		[070] = "מזמן שאמאני",
		[080] = "פרש המגפה",
		[090] = "פרש הרעב",
		[100] = "פרש המלחמה",
		[110] = "פרש המוות",
		[120] = "הלא-כלום"
	},

	newLevel = "<FC>%s<FC> הגיעו לרמה <B>%d</B>!",
	level = "Level %d",

	helpTitles = {
		[2] = "פקודות",
		[3] = "תרמו",
		[4] = "מה חדש?"
	},
	helpContent = {
		[1] = "<FC><p align='center'>#POWERS!</p>\n\n" ..
			"<J>המטרה שלכם במשחק היא לשרוד את ההתקפות של האויב.\n\n" ..
			"<N>ישנו מגוון של כוחות <font size='12'>- אשר נפתחים על ידי עלייה לרמות גבוהות יותר -</font>לתקוף ולהגן.\n" ..
			"רשמו <FC><B>!powers</B><N> כדי ללמוד יותר על הכוחות שפתחתם עד עכשיו!\n\n" ..
			"%s\n\n" ..
			"המשחק פותח על ידי %s"
		,
		[2] = "<FC><p align='center'>פקודות כלליות</p><N>\n\n<font size='12'>",
		[3] = "<FC><p align='center'>תרמו<N>\n\n" ..
			"אנחנו אוהבים קוד פתוח <font color='#E91E63'>♥</font>! אתם יכולים לצפות ולשנות את קוד המשחק ב- <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"תחזוק המשחק הוא התנדבותי בלבד, אז כל עזרה בנוגע <V>לקוד<N>, <V>תיקוני באגים ודיווחים<N>, <V>הצעות ושיפור תכונות<N>, <V>והכנת מפות <N>מבורכת ומאוד מוערכת.\n" ..
			"<p align='left'>• אתם יכולים <FC>לדווח על באגים <N>או <FC>להציע דברים <N>ב- <a href='event:print_discord.gg/quch83R'><font color='#087ECC'>Discord</font></a> ו/או ב- <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• אתם יכולים <FC>להגיש מפות <N> <a href='event:print_atelier801.com/topic?f=6&t=888677'><font color='#087ECC'>באשכול הגשת המפות בפורומים</font></a>.\n\n" ..
			"<p align='center'>אתם יכולים גם <FC>לתרום</FC> כל כמות <a href='event:print_a801-luadev.github.io/?redirect=powers'><font color='#087ECC'>כאן</font></a> על מנת לתחזק את המשחק. כל הכספים המושגים דרך הקישור יהיו מושקעים בעדכוני משחק רציפים ושיפורים כלליים.\n\n" ..
			"<a href='event:print_atelier801.com/topic?f=6&t=888676'><font size='18' color='#087ECC'>אשכול בפורומים</font></a></p>"
		,
		[4] = "<FC><p align='center'>מה חדש?</p><N>\n\n" ..
			"• You can read about powers now.\n" ..
			"•המודול הפך לרשמי.\n" ..
			"•המודול נכתב מחדש לגמרי."
	},

	commandDescriptions = {
		help = "פותח את התפריט הזה.",
		powers = "פותח תפריט שמציג את כל הכוחות ותיאורם.",
		profile = "פותח את הפרופיל שלך או של אדם אחר.",
		leaderboard = "פותח את טבלת המובילים העולמית.",

		pw = "מגן על החדר עם סיסמה. שלחו ריק כדי להסירה."
	},
	commandsParameters = {
		profile = "[שם_השחקן] ",

		pw = "[סיסמה] "
	},
	["or"] = "או",

	profileData = {
		rounds = "סיבובים",
		victories = "נצחונות",
		kills = "הריגות",
		xp = "ניסיון",
		badges = "תגים"
	},

	leaderboard = "טבלת המובילים",
	leaderboardIsLoading = "<BL>[<VI>•<BL>] טבלת המובילים עדיין טוענת. נסה שוב בעוד כמה שניות.",

	addMap = "<BV>[<FC>•<BV>] המפה <J>@%s</J> נוספה לתור המפות המקומי.",
	remMap = "<BV>[<FC>•<BV>] המפה <J>@%s</J> הוסרה מתור המפות המקומי.",
	listMaps = "<BV>[<FC>•<BV>] המפות (<J>#%d</J>): %s",

	enableParticles = "<ROSE>אל תשכחו לסמן 'הפעל אפקטים' בהגדרות בשביל לראות את המשחק בצורה הרגילה. ('תפריט' ← 'אפשרויות', ליד 'רשימת החדרים')</ROSE>",

	ban = "%s <ROSE>הורחק מ- #powers על ידי %s <ROSE>ל- %d שעות. סיבה: %s",
	unban = "<ROSE>הורחקת על ידי %s",
	isBanned = "<ROSE>אתה מורחק מ- #powers עד GMT+2 %s (%d שעות נשארו).",
	permBan = "%s <ROSE>הורחק לצמיתות מ- #powers על ידי %s<ROSE>. סיבה: %s",

	playerGetRole = "<FC>%s <FC>קודמו לדרגת <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>הם לא <font color='#%x'>%s</font> יותר.",

	enableReviewMode = "<BV>[<FC>•<BV>] <FC>מצב סיקור המפות<BV> לא דלוק. סיבובים הבאים <B>לא</B> יחשיבו נתונים והמפות שיופיעו הן במצב בדיקה לסיבוב המפה של המודול. כל הכוחות הופעלו ויש סיכוי גדול יותר שכוחות אלוהיות יופיעו!",
	disableReviewMode = "<BV>[<FC>•<BV>] <FC>מצב סקירת המפות<BV> כובה והכול יחזור לקדמותו בסיבוב הבא!",

	getBadge = "<FC>%s<FC> פתח תג #powers חדש!",

	setPassword = "<BL>[<VI>•<BL>] %s <BL>קבע את הסיסמה ל- %q.",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>הסיר את הסיסמה של החדר."
}

--[[ enums/powers.lua ]]--
local powerType = {
	def = 0,
	atk = 1,
	divine = 2
}

--[[ enums/colors.lua ]]--
local levelColors = {
	[000] = 0xFFA500,
	[010] = 0x4187B1,
	[020] = 0x66CDAA,
	[030] = 0xFEDA7A,
	[040] = 0xDA70D6,
	[050] = 0x4F94CD,
	[060] = 0x9370DB,
	[070] = 0x48D1CC,
	[080] = 0x9ACD32,
	[090] = 0x1C1313,
	[100] = 0x7C1C29,
	[110] = 0xD7ECFF,
	[120] = 0x8B658B
}

local roleColors = {
	translator    = 0x6CC19F,
	mapReviewer   = 0x3BA4E6,
	moderator     = 0xE9E654,
	administrator = 0xB69EFD
}

--[[ enums/interface.lua ]]--
local textAreaId = {
	lifeBar = 10,
	gravitationalAnomaly = 50,
	interface = 100,
}

local interfaceImages = {
	lifeBar = "172017a8fa6.png",
	levelBar = "17262a19ccf.png",

	rectangle = "1724c8e1e61.jpg", -- Powers
	highlightRectangleBorder = "1724ca7c279.png",
	smallRectangle = "172642bf9ed.jpg", -- Profile
	leaderboardRectangle = "172778a3188.jpg",
	largeRectangle = "172aeae9445.jpg", -- Profile

	-- 30x30
	xButton = "17280a523f6.png",

	-- 70x70
	rightArrow = "1729bab289f.png",
	leftArrow = "1729bab4011.png",

	locker = "1724e77bf31.png",

	-- 25x25
	sword = "17254a44673.png",
	shield = "17254a45de6.png",
	parchment = "17254911060.png",
	heart = "17254b649d2.png",
	explodingBomb = "17254d637be.png",
	megaphone = "1725980b66c.png",

	mouseClick = "172bb22eed4.png",

	-- 25x25
	skull = "17263f4dee4.png",
	ground = "17264087ad6.png",
	crown = "1726424a9e4.png",
	star = "17272ad3c14.png"
}

local imageTargets = {
	lifeBar = "&0",
	levelBar = ":10",
	interfaceBackground = ":0",
	interfaceTextAreaBackground = "&0",
	interfaceRectangle = ":10",
	interfaceIcon = ":50"
}

local interfaceBackground = {
	-- x+8, y+10
	[120] = {
		[30] = "17256d5e4ac.png"
	},
	[183] = {
		[279] = "17256d61391.png"
	},
	[280] = {
		[330] = "1726737b74f.png"
	},
	[503] = {
		[278] = "17201a440b4.png"
	},
	[700] = {
		[330] = "1728a8497f2.png"
	}
}

--[[ enums/keyboard.lua ]]--
local keyboard = {
	left = 0,
	up = 1,
	right = 2,
	down = 3,

	H = byte 'H',
	L = byte 'L',
	O = byte 'O',
	P = byte 'P',

	spacebar = byte ' ',
	ctrl = 17,
	shift = 16
}

local keyboardImages = {
	[keyboard.left] = "17254b845dc.png",
	[keyboard.up] = "17254b98e0f.png",
	[keyboard.right] = "17254b90167.png",
	[keyboard.down] = "17254b8e9f3.png",

	[keyboard.H] = "17254b85d4e.png",
	[keyboard.L] = "17254b88c41.png",
	[keyboard.O] = "17254b874be.png",
	[keyboard.P] = "17254b918d7.png",

	[keyboard.spacebar] = "172583272f1.png",
	[keyboard.ctrl] = "17258353f90.png",
	[keyboard.shift] = "1725832346d.png"
}

local keyboardImagesWidths = {
	[keyboard.spacebar] = 124,
	[keyboard.ctrl] = 42,
	[keyboard.shift] = 29
}

--[[ enums/emotes.lua ]]--
local emoteImages = {
	[enum_emote.facepaw] = "1728baa8d88.png"
}

--[[ enums/flags.lua ]]--
local flags = {
	xx = "1651b327097.png",
	ar = "1651b32290a.png",
	bg = "1651b300203.png",
	br = "1651b3019c0.png",
	cn = "1651b3031bf.png",
	cz = "1651b304972.png",
	de = "1651b306152.png",
	ee = "1651b307973.png",
	es = "1651b309222.png",
	fi = "1651b30aa94.png",
	fr = "1651b30c284.png",
	gb = "1651b30da90.png",
	hr = "1651b30f25d.png",
	hu = "1651b310a3b.png",
	id = "1651b3121ec.png",
	il = "1651b3139ed.png",
	it = "1651b3151ac.png",
	jp = "1651b31696a.png",
	lt = "1651b31811c.png",
	lv = "1651b319906.png",
	nl = "1651b31b0dc.png",
	ph = "1651b31c891.png",
	pl = "1651b31e0cf.png",
	ro = "1651b31f950.png",
	ru = "1651b321113.png",
	tr = "1651b3240e8.png",
	vk = "1651b3258b3.png"
}

local flagCodes, flagCodesSet = {
	[01] = "xx",
	[02] = "ar",
	[03] = "bg",
	[04] = "br",
	[05] = "cn",
	[06] = "cz",
	[07] = "de",
	[08] = "ee",
	[09] = "es",
	[10] = "fi",
	[11] = "fr",
	[12] = "gb",
	[13] = "hr",
	[14] = "hu",
	[15] = "id",
	[16] = "il",
	[17] = "it",
	[18] = "jp",
	[19] = "lt",
	[20] = "lv",
	[21] = "nl",
	[22] = "ph",
	[23] = "pl",
	[24] = "ro",
	[25] = "ru",
	[26] = "tr",
	[27] = "vk"
}

--[[ enums/permissions.lua ]]--
local permissions = {
	translatorColor    = 2 ^ 00,
	mapReviewerColor   = 2 ^ 01,
	moderatorColor     = 2 ^ 02,
	administratorColor = 2 ^ 03,

	editLocalMapQueue  = 2 ^ 04,
	saveLocalMapQueue  = 2 ^ 05,
	enableReviewMode   = 2 ^ 06,

	sendRoomMessage    = 2 ^ 07,
	banUser            = 2 ^ 08,
	unbanUser          = 2 ^ 09,
	permBanUser        = 2 ^ 10,

	promoteUser        = 2 ^ 11,
	demoteUser         = 2 ^ 12,
}

local rolePermissions = {
	translator = permissions.translatorColor,

	mapReviewer = permissions.mapReviewerColor
		+ permissions.editLocalMapQueue
		+ permissions.saveLocalMapQueue
		+ permissions.enableReviewMode,

	moderator = permissions.moderatorColor
		+ permissions.editLocalMapQueue
		+ permissions.sendRoomMessage
		+ permissions.banUser
		+ permissions.unbanUser,

	administrator = 0
}

do
	for _, v in next, permissions do
		rolePermissions.administrator = rolePermissions.administrator + v
	end
end

--[[ enums/badges.lua ]]--
local badges = {
	betaTester = 2 ^ 00
}

local badgesOrder = {
	[1] = "betaTester"
}

local badgeImages = {
	betaTester = "172b0be763b.png"
}

--[[ classes/dataHandler.lua ]]--
local DataHandler = { }
do
	DataHandler.__index = DataHandler

	DataHandler.new = function(moduleID, structure)
		local structureIndexes = { }
		for k, v in next, structure do
			structureIndexes[v.index] = k
			v.type = v.type or type(v.default)
		end

		return setmetatable({
			playerData = { },
			moduleID = moduleID,
			structure = structure,
			structureIndexes = structureIndexes,
			otherPlayerData = { }
		}, DataHandler)
	end

	local extractPlayerData = function(self, dataStr)
		local i, module, j = match(dataStr, "()" .. self.moduleID .. "=(%b{})()")
		if i then
			return module, (sub(dataStr, 1, i - 1) .. sub(dataStr, j + 1))
		end
		return nil, dataStr
	end

	local replaceComma = function(str)
		return gsub(str, ',', '\0')
	end

	local getDataNameById = function(structure, index)
		for k, v in next, structure do
			if v.index == index then
				return k
			end
		end
	end

	local strToTable

	strToTable = function(str)
		local out, index = { }, 0

		str = gsub(str, "%b{}", replaceComma)

		local tbl
		for value in gmatch(str, "[^,]+") do
			value = gsub(value, "%z", ',')

			tbl = match(value, "^{(.-)}$")

			index = index + 1
			if tbl then
				out[index] = strToTable(tbl)
			else
				out[index] = tonumber(value) or value
			end
		end

		return out
	end

	local getDataValue = function(value, valueType, valueName, valueDefault)
		if valueType == "boolean" then
			if value then
				value = (value == '1')
			else
				value = valueDefault
			end
		elseif valueType == "table" then
			value = match(value or '', "^{(.-)}$")
			value = value and strToTable(value) or valueDefault
		else
			if valueType == "number" then
				value = value and tonumber(value, 16)
			elseif valueType == "string" and value then
				value = match(value, "^\"(.-)\"$")
			end
			value = value or valueDefault
		end

		return value
	end

	local handleModuleData = function(self, playerName, structure, moduleData)
		local playerData = self.playerData[playerName]
		local valueName

		local dataIndex = 1
		if #moduleData > 0 then
			moduleData = gsub(moduleData, "%b{}", replaceComma)

			for value in gmatch(moduleData, "[^,]+") do
				value = gsub(value, "%z", ',')

				valueName = getDataNameById(structure, dataIndex)
				playerData[valueName] = getDataValue(value, structure[valueName].type, valueName,
					structure[valueName].default)
				dataIndex = dataIndex + 1
			end
		end

		local higherIndex = #self.structureIndexes
		if dataIndex <= higherIndex then
			for i = dataIndex, higherIndex do
				valueName = getDataNameById(structure, i)
				playerData[valueName] = getDataValue(nil, structure[valueName].type, valueName,
					structure[valueName].default)
			end
		end
	end

	DataHandler.newPlayer = function(self, playerName, data)
		data = data or ''

		self.playerData[playerName] = { }

		local module, otherData = extractPlayerData(self, data)
		self.otherPlayerData[playerName] = otherData

		handleModuleData(self, playerName, self.structure, (module and sub(module, 2, -2) or ''))

		return self
	end

	local tblToStr
	local transformType = function(valueType, index, str, value)
		if valueType == "number" then
			index = index + 1
			str[index] = format("%x", value)
		elseif valueType == "string" then
			index = index + 1
			str[index] = '"'
			index = index + 1
			str[index] = value
			index = index + 1
			str[index] = '"'
		elseif valueType == "boolean" then
			index = index + 1
			str[index] = (value and '1' or '0')
		elseif valueType == "table" then
			index = index + 1
			str[index] = '{'
			index = index + 1
			str[index] = tblToStr(value)
			index = index + 1
			str[index] = '}'
		end
		return index
	end

	tblToStr = function(tbl)
		local str, index = { }, 0

		local valueType
		for k, v in next, tbl do
			index = transformType(type(v), index, str, v)
			index = index + 1
			str[index] = ','
		end

		if str[index] == ',' then
			str[index] = ''
		end

		return table_concat(str)
	end

	local dataToStr = function(self, playerName)
		local str, index = { self.moduleID, "={" }, 2

		local playerData = self.playerData[playerName]
		local structureIndexes = self.structureIndexes
		local structure = self.structure

		local valueName, valueType, value
		for i = 1, #structureIndexes do
			valueName = structureIndexes[i]
			index = transformType(structure[valueName].type, index, str, playerData[valueName])
			index = index + 1
			str[index] = ','
		end

		if str[index] == ',' then
			str[index] = '}'
		else
			str[index + 1] = '}'
		end

		return table_concat(str)
	end

	DataHandler.dumpPlayer = function(self, playerName)
		local otherPlayerData = self.otherPlayerData[playerName]
		if otherPlayerData == '' then
			return dataToStr(self, playerName)
		else
			return dataToStr(self, playerName) .. "," .. otherPlayerData
		end
	end

	DataHandler.get = function(self, playerName, valueName)
		return self.playerData[playerName][valueName]
	end

	DataHandler.set = function(self, playerName, valueName, newValue, sum, _forceSave)
		if _forceSave or canSaveData then
			playerName = self.playerData[playerName]
			if sum then
				playerName[valueName] = playerName[valueName] + newValue
			else
				playerName[valueName] = newValue
			end
		end
		return self
	end

	DataHandler.save = function(self, playerName, _forceSave)
		if _forceSave or canSaveData then
			savePlayerData(playerName, self:dumpPlayer(playerName))
		end

		return self
	end
end

--[[ playerData.lua ]]--
local playerData = DataHandler.new(module.id, {
	dataVersion = {
		index = 1,
		default = 0
	},
	rounds = {
		index = 2,
		default = 0
	},
	victories = {
		index = 3,
		default = 0
	},
	kills = {
		index = 4,
		default = 0
	},
	xp = {
		index = 5,
		default = module.default_xp
	},
	badges = {
		index = 6,
		default = 0
	},
	missions = {
		index = 7,
		default = { 0 }
	}
})

--[[ api/math.lua ]]--
local inRectangle = function(x, y, rx, ry, rw, rh, rightDirection)
	if rightDirection then
		rightDirection = (x >= rx and x <= (rx + rw))
	else
		rightDirection = (x >= (rx - rw) and x <= rx)
	end

	return rightDirection and (y >= ry and y <= (ry + rh))
end

local pythagoras = function(x, y, cx, cy, cr)
	x = x - cx
	x = x * x
	y = y - cy
	y = y * y
	cr = cr * cr
	return x + y < cr
end

local clamp = function(value, min, max)
	return value < min and min or value > max and max or value
end

--[[ api/string.lua ]]--
local str_split = function(str, pattern, raw, f)
	local out, counter = { }, 0

	local strPos = 1
	local i, j
	while true do
		i, j = find(str, pattern, strPos, raw)
		if not i then break end
		counter = counter + 1
		out[counter] = sub(str, strPos, i - 1)
		out[counter] = (f and f(out[counter]) or out[counter])

		strPos = j + 1
	end
	counter = counter + 1
	out[counter] = sub(str, strPos)
	out[counter] = (f and f(out[counter]) or out[counter])

	return out, counter
end

--[[ api/table.lua ]]--
local table_add
table_add = function(src, tbl, deep)
	for k, v in next, tbl do
		if deep and type(v) == "table" then
			src[k] = { }
			table_add(src[k], v, deep)
		else
			src[k] = v
		end
	end
end

local table_copy = function(list)
	local out = { }
	for k, v in next, list do
		out[k] = v
	end
	return out
end

local table_random = function(tbl)
	return tbl[random(#tbl)]
end

local table_shuffle = function(tbl)
	local rand
	for i = #tbl, 1, -1 do
		rand = random(i)
		tbl[i], tbl[rand] = tbl[rand], tbl[i]
	end
end

local table_set = function(tbl)
	local out = { }
	for i = 1, #tbl do
		out[tbl[i]] = i
	end
	return out
end

--[[ api/transformice.lua ]]--
do
	local link = linkMice
	linkMice = function(p1, p2, linked)
		if linked then
			playerCache[p1].soulMate = p2
		else
			playerCache[p1].soulMate = nil
		end

		return link(p1, p2, linked)
	end
end

local isMapCode = function(x)
	if sub(x, 1, 1) == '@' then
		x = sub(x, 2)
	end

	local str = x
	x = tonumber(x)
	return (not not x and #str > 3), x
end

local enablePowersTrigger = function()
	canTriggerPowers = true
	if currentMap == 2 then
		chatMessage(getText.enableParticles)
	end
end

local setNextMapIndex = function()
	currentMap = currentMap + 1
	if currentMap > totalCurrentMaps then
		table_shuffle(maps)
		currentMap = 1
	end
end

local nextMap = function()
	nextMapLoadTentatives = nextMapLoadTentatives + 1
	if nextMapLoadTentatives == 4 then
		nextMapLoadTentatives = 0
		nextMapToLoad = nil
		setNextMapIndex()
	end

	newGame(nextMapToLoad or maps[currentMap])
end

local strToNickname = function(str, checkDiscriminator)
	str = gsub(lower(str), "%a", upper, 1)
	if checkDiscriminator and not find(str, '#', 1, true) then
		str = str .. "#0000"
	end
	return str
end

local getNicknameAndDiscriminator = function(nickname)
	return sub(nickname, 1, -6), sub(nickname, -4)
end

local prettifyNickname
do
	local nicknameFormat = "<%s>%s<%s><font size='%d'>#%s</font>"

	prettifyNickname = function(nickname, discriminatorSize, discriminator, discriminatorColor,
		nicknameColor)
		if not discriminator then
			nickname, discriminator = getNicknameAndDiscriminator(nickname)
		end

		return format(nicknameFormat, (nicknameColor or 'V'), nickname, (discriminatorColor or 'G'),
			(discriminatorSize or 10), discriminator)
	end
end

local validateNicknameAndGetID = function(str)
	local targetPlayer = strToNickname(str, true)
	local targetPlayerId = room.playerList[targetPlayer]
	targetPlayerId = targetPlayerId and targetPlayerId.id
	if targetPlayerId == 0 then
		targetPlayerId = nil
	end

	return targetPlayerId, targetPlayer
end

local messagePlayersWithPrivilege = function(message)
	for playerName, data in next, room.playerList do
		if playersWithPrivileges[data.id] then
			chatMessage(message, playerName)
		end
	end
end

local messageRoomAdmins = function(message)
	for playerName in next, room.playerList do
		if roomAdmins[playerName] then
			chatMessage(message, playerName)
		end
	end
end

--[[ api/xp.lua ]]--
local xpToLvl = function(xp)
	if xp >= module.max_player_xp then
		return module.max_player_level, 1, 1
	end

	local last, total, level, remain, need = 35, 0, 0, 0, 0
	for i = 1, module.max_player_level do
		local nlast = last + (i - ((i < 26 and 1 or i < 66 and 35 or 55)))
		local ntotal = total + nlast

		if ntotal >= xp then
			level, remain, need = i - 1, xp - total, ntotal - xp
			return level, remain, remain + need
		else
			last, total = nlast, ntotal
		end
	end
end

local lvlToXp = function(lvl)
	local last, total = 35, 0
	for i = 1, lvl do
		last = last + (i - ((i < 26 and 1 or i < 66 and 35 or 55)))
		total = total + last
	end

	return total, last
end

--[[ api/players.lua ]]--
local players = {
	room = { },
	alive = { },
	dead = { },
	lobby = { },
	currentRound = { },
	_count = {
		room = 0,
		alive = 0,
		dead = 0,
		lobby = 0,
		currentRound = 0
	}
}

local players_insert = function(where, playerName)
	if not players[where][playerName] then
		players._count[where] = players._count[where] + 1
		players[where][playerName] = playerName
	end
end

local players_remove = function(where, playerName)
	if players[where][playerName] then
		players._count[where] = players._count[where] - 1
		players[where][playerName] = nil
	end
end

local players_remove_all = function(playerName)
	for k, v in next, players do
		if k ~= "_count" then
			players_remove(k, playerName)
		end
	end
end

local players_lobby = function(playerName)
	killPlayer(playerName)
	players_remove_all(playerName)
	players_insert("lobby", playerName)
end

local isValidPlayer = function(playerName)
	playerName = room.playerList[playerName]
	local isBanned = bannedPlayers[playerName.id]
	return playerName.id > 0 -- Is not souris
		and not isBanned -- Is not banned
		and (time() - playerName.registrationDate) >= (5 * 60 * 60 * 24 * 1000), -- Player 5+ days
		isBanned, playerName.id
end

local playerCanTriggerEvent = function(playerName, cache)
	if players.lobby[playerName] then return end
	cache = cache or playerCache[playerName]

	local time = time()
	if cache.powerCooldown > time then return end

	if canTriggerPowers and not (room.playerList[playerName].isDead
		or cache.isInterfaceOpen) then
		return time, cache
	end
end

local playerCanTriggerCallback = function(playerName, cache)
	if players.lobby[playerName] then return end
	cache = cache or playerCache[playerName]

	local time = time()
	if cache.interfaceActionCooldown > time then return end
	cache.interfaceActionCooldown = time + 1000

	return cache
end

local giveExperience = function()
	for playerName in next, players.alive do
		playerData:set(playerName, "xp", module.extra_xp_in_round, true)
	end
end

local setPlayerLevel = function(playerName, cache)
	local level, remainingXp, needingXp = xpToLvl(playerData:get(playerName, "xp"))
	cache.level = level
	cache.currentLevelXp = remainingXp
	cache.nextLevelXp = needingXp

	if level == cache.roundLevel then return end

	local levelIndex = level - level%10
	local levelColor = levelColors[levelIndex]
	if not levelColor then
		levelIndex = module.max_player_level - module.max_player_level%10
		levelColor = levelColors[levelIndex]
	end

	cache.levelIndex = levelIndex
	cache.levelColor = levelColor

	return level
end

local checkPlayerLevel = function(playerName, cache)
	if not canSaveData then return end

	local newLevel = setPlayerLevel(playerName, cache)
	if not newLevel then return end

	chatMessage(format(getText.newLevel, cache.chatNickname, newLevel))

	-- Checks unlocked powers
	local powerNames = getText.powers
	local nameByLevel = Power.__nameByLevel

	local levelNames, counter, storedNames = { }, 0
	for lvl = cache.roundLevel + 1, newLevel do -- Checks all new levels, it can be more than one.
		storedNames = nameByLevel[lvl]
		if storedNames then
			for i = 1, #storedNames do
				counter = counter + 1
				levelNames[counter] = powerNames[storedNames[i]]
			end
		end
	end

	if counter > 0 then
		chatMessage(format(getText.unlockPower, "<B>" .. table_concat(levelNames, "</B>, <B>") ..
			"</B>"), playerName)
	end
end

local warnBanMessage = function(playerName, banTime)
	chatMessage(format(getText.isBanned, date("%d/%m/%Y", banTime),
		1 + (banTime - time()) / (60 * 60 * 1000)), playerName)
end

local generateBadgesList = function(playerName, _cache)
	local playerBadgesInt = playerData:get(playerName, "badges")

	local playerBadges, counter = { }, 0
	for b = 1, #badgesOrder do
		b = badgesOrder[b]
		if band(badges[b], playerBadgesInt) > 0 then
			counter = counter + 1
			playerBadges[counter] = b
		end
	end

	(_cache or playerCache[playerName]).badges = playerBadges
end

local giveBadge = function(playerName, badge, _cache, _forceSave)
	badge = badges[badge]
	if not badge then return end

	local playerBadges = playerData:get(playerName, "badges")
	badge = bor(playerBadges, badge)
	if badge == playerBadges then return end

	playerData
		:set(playerName, "badges", badge, nil, _forceSave)
		:save(playerName, _forceSave)

	_cache = _cache or playerCache[playerName]
	generateBadgesList(playerName, _cache)

	chatMessage(format(getText.getBadge, _cache.chatNickname))
end

--[[ api/permissions.lua ]]--
local hasPermission = function(playerName, permission, _playerId, _playerPermissions)
	_playerId = _playerPermissions or _playerId or room.playerList[playerName].id
	_playerPermissions = _playerPermissions or playersWithPrivileges[_playerId]

	-- p & t > 0
	return _playerPermissions and band(permission, _playerPermissions) > 0
end

local addPermission = function(playerName, permission, _playerId)
	_playerId = _playerId or room.playerList[playerName].id

	local oldPerms = playersWithPrivileges[_playerId]
	if not oldPerms then
		playersWithPrivileges[_playerId] = 0
		oldPerms = 0
	end

	-- t | p
	local currentPerms = bor(playersWithPrivileges[_playerId], permission)
	playersWithPrivileges[_playerId] = currentPerms

	return oldPerms ~= currentPerms
end

local removePermission = function(playerName, permission, _playerId)
	_playerId = _playerId or room.playerList[playerName].id

	local oldPerms = playersWithPrivileges[_playerId]
	-- t & ~p
	local currentPerms = band(playersWithPrivileges[_playerId], bnot(permission))
	playersWithPrivileges[_playerId] = (currentPerms > 0 and currentPerms or nil)

	return oldPerms ~= currentPerms
end

--[[ api/filter.lua ]]--
local getPlayersOnFilter = function(except, filter, ...)
	local data = { }

	local player
	for playerName in next, players.alive do
		if playerName ~= except then
			player = room.playerList[playerName]
			if filter(player.x, player.y, ...) then
				data[playerName] = playerCache[playerName]
			end
		end
	end

	return data
end

--[[ interfaces/lifeBar.lua ]]--
local displayLifeBar = function(playerName)
	addImage(interfaceImages.lifeBar, imageTargets.lifeBar, 0, 18, playerName)
end

local updateLifeBar = function(playerName, cache)
	-- w = 100 -> 780 \ hp -> w = 100w = 780hp = 780hp/100 = 7.8hp
	addTextArea(textAreaId.lifeBar, '', playerName, 10, 25, 7.8 * cache.health, 1, cache.levelColor,
		cache.levelColor, .75, true)
end

local removeLifeBar = function(playerName)
	removeTextArea(textAreaId.lifeBar, playerName)
end

--[[ api/life.lua ]]--
local addHealth = function(playerName, cache, hp)
	hp = hp or 0
	if cache.extraHealth > 0 then
		hp = hp + cache.extraHealth
		cache.extraHealth = 0
	end
	cache.health = cache.health + hp
	if cache.health > 100 then
		cache.health = 100
	end

	updateLifeBar(playerName, cache)
end

local givePlayerKill = function(killerName, killedName, killerCache)
	playerData
		:set(killerName, "kills", 1, true)
		:set(killerName, "xp", module.xp_on_kill, true)

	local msg = format(getText.kill, playerCache[killerName].chatNickname, killerCache.chatNickname)
	chatMessage(msg, killerName)
	chatMessage(msg, killedName)
end

local damagePlayer = function(playerName, damage, cache, _attackerName, _time)
	cache.health = cache.health - damage

	if cache.health <= 0 then
		cache.lastDamageBy = nil
		cache.health = 0
		killPlayer(playerName)
		return true
	else
		if _attackerName then -- If player falls or something, the kill is given to the last damage
			cache.lastDamageBy = _attackerName
			cache.lastDamageTime = _time
		end
		updateLifeBar(playerName, cache)
		return false
	end
end

local damagePlayersWithAction = function(except, damage, action, filter, x, y, ...)
	local time = time() + 3000

	local hasKilled = false
	for name, cache in next, getPlayersOnFilter(except, filter, x, y, ...) do
		if (not action and true or action(name))
			and damagePlayer(name, damage, cache, except, time) then -- Has died
			hasKilled = true
			givePlayerKill(except, name, cache)
		end
	end
	if hasKilled then
		playerData:save(except)
	end
end

local damagePlayers = function(except, damage, filter, x, y, ...)
	return damagePlayersWithAction(except, damage, nil, filter, x, y, ...)
end

--[[ translations/setup.lua ]]--
do
	local merge
	merge = function(src, aux, ignoredIndexes)
		for k, v in next, aux do
			if not ignoredIndexes[k] then
				if type(v) == "table" then
					src[k] = merge((type(src[k]) == "table" and src[k] or { }), v, ignoredIndexes)
				else
					src[k] = src[k] or v
				end
			end
		end
		return src
	end

	getText = translations[room.community]
	if getText then
		if getText ~= translations.en then
			merge(getText, translations.en, {
				["levelName"] = true
			})
		end
	else
		getText = translations.en
	end

	-- All level names are tables
	local levelName = getText.levelName
	for k, v in next, levelName do
		if type(v) == "string" then
			levelName[k] = { v, v }
		end
	end

	translations = nil
end

--[[ classes/keySequence.lua ]]--
local KeySequence = { }
do
	KeySequence.__index = KeySequence

	KeySequence.new = function(queue)
		return setmetatable({
			queue = (queue or { }),
			_count = (queue and #queue or 0),
			_nextStrokeTolerance = 0
		}, KeySequence)
	end

	local checkQueue = function(self)
		local time = time()
		if self._count > 1 and time > self._nextStrokeTolerance then
			self._count = 0
			self._nextStrokeTolerance = 0
			self.queue = { }
		else
			self._nextStrokeTolerance = time + 200
		end
	end

	KeySequence.insert = function(self, key)
		checkQueue(self)
		self._count = self._count + 1
		self.queue[self._count] = key
	end

	KeySequence.release = function(self)
		self._nextStrokeTolerance = 0
		checkQueue(self)
	end

	KeySequence.invertQueue = function(self)
		local count = self._count
		local queue = self.queue

		-- O(n/2)
		for i = 1, count / 2 do
			queue[i], queue[count] = queue[count], queue[i]
			count = count - 1
		end

		return self
	end

	KeySequence.isEqual = function(self, compKs)
		local srcLen = self._count
		if srcLen < compKs._count then -- consider changing < to ~= in the future
			return false
		end
		srcLen = srcLen + 1

		local srcQueue, compQueue = self.queue, compKs.queue
		for i = 1, compKs._count do
			-- Note that compKs must be invertQueue'ed
			if compQueue[i] ~= srcQueue[srcLen - i] then
				return false
			end
		end

		self:release()

		return true
	end
end

--[[ classes/timer.lua ]]--
local timer = { }
do
	timer.start = function(self, callback, ms, times, ...)
		local t = self._timers
		t._count = t._count + 1

		local args = { ... }
		t[t._count] = {
			id = t._count,
			callback = callback,
			args = args,
			defaultMilliseconds = ms,
			milliseconds = ms,
			times = times
		}
		args[#args + 1] = t[t._count]

		return t._count
	end

	timer.delete = function(self, id)
		local ts = self._timers
		ts[id] = nil
		ts._deleted = ts._deleted + 1
	end

	timer.loop = function(self)
		local ts = self._timers
		if ts._deleted >= ts._count then return end

		local t
		for i = 1, ts._count do
			t = ts[i]
			if t then
				t.milliseconds = t.milliseconds - 500
				if t.milliseconds <= 0 then
					t.milliseconds = t.defaultMilliseconds
					t.times = t.times - 1

					t.callback(unpack(t.args))

					if t.times == 0 then
						self:delete(i)
					end
				end
			end
		end
	end

	timer.refresh = function()
		timer._timers = {
			_count = 0,
			_deleted = 0
		}
	end
	timer.refresh()
end

local unrefreshableTimer = { }
do
	unrefreshableTimer.id = 0
	unrefreshableTimer.timers = { }
	unrefreshableTimer.deleteQueue = { }
	unrefreshableTimer.countDeleteQueue = 0

	unrefreshableTimer.start = function(self, callback, ms, times, ...)
		self.id = self.id + 1

		local t = self.timers
		local args = { ... }
		t[self.id] = {
			id = self.id,
			callback = callback,
			args = args,
			defaultMilliseconds = ms,
			milliseconds = ms,
			times = times
		}
		args[#args + 1] = t[self.id]

		return self.id
	end

	unrefreshableTimer.delete = function(self, id)
		self.countDeleteQueue = self.countDeleteQueue + 1
		self.deleteQueue[self.countDeleteQueue] = id
	end

	unrefreshableTimer.loop = function(self)
		local ts = self.timers

		for i, t in next, ts do
			t.milliseconds = t.milliseconds - 500
			if t.milliseconds <= 0 then
				t.milliseconds = t.defaultMilliseconds
				t.times = t.times - 1

				t.callback(unpack(t.args))

				if t.times == 0 then
					self:delete(i)
				end
			end
		end

		local dq = self.deleteQueue
		for i = 1, self.countDeleteQueue do
			ts[dq[i]] = nil
		end
		self.countDeleteQueue = 0
	end
end

--[[ classes/power.lua ]]--
Power = { }
do
	Power.__index = Power

	-- References
	Power.__keyboard    = { }
	Power.__mouse       = { }
	Power.__chatMessage = { }
	Power.__emotePlayed = { }

	Power.__eventCount  = {
		__keyboard    = 0,
		__mouse       = 0,
		__chatMessage = 0,
		__emotePlayed = 0
	}

	Power.__nameByLevel = { }

	Power.new = function(name, type, level, imageData, extraData, resetableData)
		local self = {
			name = name,
			type = type,
			level = level,

			effect = nil,

			defaultUseLimit = (type == powerType.divine and 1 or -1),
			useLimit = nil,
			defaultUseCooldown = 1000,
			useCooldown = 1000,
			triggerPossibility = nil,

			damage = nil,
			selfDamage = nil,

			bindControl = nil,

			keysToBind = nil,
			totalKeysToBind = nil,

			triggererKey = nil,
			keySequences = nil,
			totalKeySequences = nil,

			clickRange = nil,

			messagePattern = nil,

			triggererEmote = nil,

			imageData = imageData,
			resetableData = resetableData
		}
		self.useLimit = self.defaultUseLimit

		if extraData then
			table_add(self, extraData)
		end

		local nameByLevel = Power.__nameByLevel
		if not nameByLevel[level] then
			nameByLevel[level] = { }
		end
		nameByLevel = nameByLevel[level]
		nameByLevel[#nameByLevel + 1] = name

		return setmetatable(self, Power)
	end

	Power.setEffect = function(self, f)
		self.effect = f
		return self
	end

	Power.setDamage = function(self, damage)
		self.damage = damage
		return self
	end

	Power.setSelfDamage = function(self, damage)
		self.selfDamage = damage
		return self
	end

	Power.setUseLimit = function(self, limit)
		self.useLimit = limit
		self.defaultUseLimit = limit
		return self
	end

	Power.setUseCooldown = function(self, cooldown)
		self.defaultUseCooldown = cooldown * 1000
		self.useCooldown = self.defaultUseCooldown
		return self
	end

	local bindKeys = function(self, playerName)
		local keysToBind = self.keysToBind
		for k = 1, self.totalKeysToBind do
			bindKeyboard(playerName, keysToBind[k], true, true)
		end
	end

	local bindClick = function(_, playerName)
		bindMouse(playerName, true)
	end

	local setEventType = function(self, type)
		local count = Power.__eventCount
		local power = Power[type]
		count[type] = count[type] + 1
		power[count[type]] = self
	end

	Power.bindChatMessage = function(self, message)
		self.messagePattern = message
		setEventType(self, "__chatMessage")

		return self
	end

	Power.bindKeyboard = function(self, ...)
		self.keysToBind = { ... }
		self.totalKeysToBind = #self.keysToBind
		if self.totalKeysToBind == 1 then
			self.triggererKey = self.keysToBind[1] -- No keystroke sequence if it is a single key
		end
		self.bindControl = bindKeys

		setEventType(self, "__keyboard")

		return self
	end

	Power.bindMouse = function(self, range)
		self.clickRange = range
		self.bindControl = bindClick

		setEventType(self, "__mouse")

		return self
	end

	Power.bindEmote = function(self, emoteId)
		self.triggererEmote = emoteId

		setEventType(self, "__emotePlayed")

		return self
	end

	Power.setKeySequence = function(self, keySequences)
		self.triggererKey = nil

		local totalKeySequences = #keySequences
		self.totalKeySequences = totalKeySequences

		for i = 1, totalKeySequences do
			keySequences[i] = KeySequence.new(keySequences[i]):invertQueue()
		end
		self.keySequences = keySequences

		return self
	end

	Power.setProbability = function(self, triggerPossibility)
		-- Inverse probability, less means higher chances
		self.triggerPossibility = triggerPossibility
		return self
	end

	Power.reset = function(self)
		self.useLimit = self.defaultUseLimit
		self.useCooldown = time() + self.defaultUseCooldown
		if self.resetableData then
			table_add(self, self.resetableData, true)
		end
		return self
	end

	Power.getNewPlayerData = function(self, playerLevel, currentTime)
		return (playerLevel >= self.level or isCurrentMapOnReviewMode) and {
			remainingUses = self.useLimit,
			cooldown = currentTime + self.useCooldown
		} or nil
	end

	Power.damagePlayers = function(self, playerName, args, _method)
		if self.damage then
			(_method or damagePlayers)(playerName, self.damage, unpack(args))
		end
		return self
	end

	local canTriggerRegular = function(self, cache, _time)
		local playerPowerData = cache.powers[self.name]
		if playerPowerData.remainingUses == 0 then return end -- x < 0 means infinity

		_time = _time or time()
		if playerPowerData.cooldown > _time then return end
		playerPowerData.cooldown = _time + self.useCooldown
		cache.powerCooldown = _time + 800 -- General cooldown

		playerPowerData.remainingUses = playerPowerData.remainingUses - 1

		return true
	end

	Power.triggerRegular = function(self, playerName, _cache, _time, _x, _y, _ignorePosition, ...)
		_cache = _cache or playerCache[playerName]

		if not canTriggerRegular(self, _cache, _time) then
			return false
		end

		if not (_ignorePosition or _x) then
			local playerData = room.playerList[playerName]
			_x, _y = playerData.x, playerData.y
		end

		if self.effect then
			local args = {
				self.effect(playerName, _x, _y, _cache.isFacingRight, self, _cache, ...)
			}
			if args[1] then -- return false to perform the damage inside the effect
				self:damagePlayers(playerName, args)
			end
		end

		if self.selfDamage then
			damagePlayer(playerName, self.selfDamage, _cache)
		end

		return true
	end

	Power.checkTriggerPossibility = function(self)
		if self.triggerPossibility then
			local possibility = self.triggerPossibility
			if isCurrentMapOnReviewMode then
				possibility = 5
			end
			if random(possibility) ~= random(possibility) then
				return false
			end
		end
		return true
	end

	local canTriggerDivine = function(self, _time)
		local powerData = powers[self.name]
		if powerData.useLimit == 0 then return end -- x < 0 means infinity

		_time = _time or time()
		if powerData.useCooldown > _time then return end
		powerData.useCooldown = _time + 5000 -- Wait a bit before trying again if on failure

		if not self:checkTriggerPossibility() then return end

		powerData.useCooldown = _time + self.defaultUseCooldown
		powerData.useLimit = powerData.useLimit - 1

		return true
	end

	-- It has weird arguments because of @trigger that uses the same parameters of @triggerRegular
	Power.triggerDivine = function(self, _, _, _time, _, _, _, ...)
		if not canTriggerDivine(self, _time) then
			return false
		end

		if self.effect then
			self.effect(self, ...)
		end

		return true
	end

	Power.trigger = function(self, ...)
		if self.type == powerType.divine then
			return self:triggerDivine(...)
		else
			return self:triggerRegular(...)
		end
	end
end

--[[ powers.lua ]]--
-- Level 0
do
	local beam = function(x, y, direction)
		local xSpeed = .25 * direction
		local xAcceleration = .3 * direction
		local r = 10
		for i = 1, 10, (isLowQuality and 2.5 or 1) do
			r = r * .75
			displayParticle(9, x - (-30 + i + r)*direction, y, i*xSpeed, 0, xAcceleration)
		end
	end

	powers.laserBeam = Power
		.new("laserBeam", powerType.atk, 0, {
			smallIcon = "172499c579c.png",
			icon = "172baf7a17c.jpg",
			iconWidth = 100,
			iconHeight = 54
		})
		:setDamage(5)
		:setUseCooldown(1)
		:bindKeyboard(keyboard.spacebar)
		:setEffect(function(_, x, y, isFacingRight)
			local direction = (isFacingRight and 1 or -1)
			y = y - 10

			-- Particles
			beam(x, y, direction)

			-- Collision
			timer:start(removeObject, 1000, 1, addShamanObject(6000, x + 40*direction, y, 0,
				9 * direction))

			-- Damage
			return inRectangle, x, y - 10, 120, 40, isFacingRight
		end)
end

-- Level 3
do
	local wind = function(x, y, direction)
		for i = 1, 6, (isLowQuality and 1.5 or 1) do
			displayParticle(35, x, y, direction, i * (i < 4 and -1 or 1))
		end
	end

	powers.lightSpeed = Power
		.new("lightSpeed", powerType.def, 3, {
			smallIcon = "172499c43ff.png",
			icon = "172bb04e693.jpg",
			iconWidth = 92,
			iconHeight = 70
		})
		:setUseCooldown(1.5)
		:bindKeyboard(keyboard.left, keyboard.right)
		:setKeySequence({
			{ keyboard.left, keyboard.left, keyboard.left },
			{ keyboard.right, keyboard.right, keyboard.right }
		})
		:setEffect(function(playerName, x, y, isFacingRight)
			-- Move player
			movePlayer(playerName, x + (isFacingRight and 200 or -200), y)

			-- Move players
			local direction = (isFacingRight and 30 or -30)
			for name in next, getPlayersOnFilter(playerName, inRectangle, x, y - 60, 200, 120,
				isFacingRight) do
				movePlayer(name, 0, 0, true, direction)
			end

			-- Particles
			wind(x, y, (isFacingRight and 15 or -15))
		end)
end

-- Level 15
do
	local particles = { 2, 11 }
	local totalParticles = #particles

	local lightning = function(x, y)
		local yPos, rand = 0

		local randMin, randMax
		if isLowQuality then
			randMin, randMax = 5, 7
		else
			randMin, randMax = 3, 5
		end

		local init = random(500)
		for i = init, init + 125, randMax do
			yPos = yPos + random(randMin, randMax)
			displayParticle(particles[i%totalParticles + 1], x + cos(i)*random(3, 6), y + yPos)
		end
	end

	powers.lightning = Power
		.new("lightning", powerType.atk, 15, {
			smallIcon = "172499d3af6.png",
			icon = "172baf86520.jpg",
			iconWidth = 21,
			iconHeight = 80
		})
		:setDamage(10)
		:setUseLimit(10)
		:setUseCooldown(5)
		:bindMouse(150)
		:setEffect(function(_, x, y)
			-- Particles
			lightning(x, y)

			-- Damage
			y = y + 100
			explosion(x, y, 30, 60)
			return pythagoras, x, y, 60
		end)
end

-- Level 20
do
	local particles = { 2, 11, 2 }
	local totalParticles = #particles

	local spring = function(x, y)
		for i = 1, 10, (isLowQuality and 2 or 1) do
			displayParticle(particles[(i%totalParticles + 1)], x + cos(i)*10, y, 0, -i * .3)
		end
	end

	powers.doubleJump = Power
		.new("doubleJump", powerType.def, 20, {
			smallIcon = "172499c8f3b.png",
			icon = "172baf8852b.jpg",
			iconWidth = 44,
			iconHeight = 55
		})
		:setUseCooldown(5)
		:bindKeyboard(keyboard.up)
		:setKeySequence({ { keyboard.up, keyboard.up } })
		:setEffect(function(playerName, x, y)
			-- Move player
			movePlayer(playerName, 0, 0, true, 0, -80, false)

			-- Particles
			spring(x, y)
		end)
end

-- Level 28
do
	local particles = { 2, 0, 0, 2 }
	local totalParticles = #particles

	local auxSpeedRad = rad(18)
	local spiral = function(x, y, angle, direction)
		angle = rad(angle)

		local xAcceleration = .4 * direction
		local yAcceleration = -.2

		local auxXSpeed, auxYSpeed, auxCosRad, auxSinRad = 0, 0
		for i = 1, 40, (isLowQuality and 2 or 1) do
			auxYSpeed = i * .1
			auxXSpeed = auxYSpeed * direction

			auxCosRad = angle + auxSpeedRad*i
			auxSinRad = angle - auxSpeedRad*i

			displayParticle(particles[(i%totalParticles + 1)], x + i*direction, y - i,
				auxXSpeed * cos(auxCosRad), auxYSpeed * sin(auxSinRad), xAcceleration,
				yAcceleration)
		end
	end

	powers.helix = Power
		.new("helix", powerType.def, 28, {
			smallIcon = "172499ce899.png",
			icon = "172baf8a5db.jpg",
			iconWidth = 67,
			iconHeight = 80
		})
		:setUseCooldown(2.5)
		:bindKeyboard(keyboard.shift)
		:setEffect(function(playerName, x, y, isFacingRight)
			local direction = (isFacingRight and 1 or -1)

			-- Move player
			movePlayer(playerName, 0, 0, true, 100 * direction, -115, false)

			-- Particles
			spiral(x, y, 200, direction)
		end)
end

-- Level 35
do
	local circle = function(x, y, dimension)
		local xPos, yPos
		for i = 90, 110, (isLowQuality and 1.75 or 1) do
			xPos = cos(i) * dimension
			yPos = sin(i) * dimension
			displayParticle(2, x + xPos, y + yPos)
		end

		local yTop = y - dimension
		local yBottom = y + dimension

		local xLeft = x - dimension
		local xRight = x + dimension

		dimension = dimension / 100

		local bottomRight, topLeft
		for i = 1, 5, (isLowQuality and 2 or 1) do
			bottomRight = i * dimension
			topLeft = -i * dimension
			displayParticle(11, x, yTop, 0, bottomRight)
			displayParticle(11, x, yBottom, 0, topLeft)
			displayParticle(11, xLeft, y, bottomRight)
			displayParticle(11, xRight, y, topLeft)
		end
	end

	powers.dome = Power
		.new("dome", powerType.atk, 35, {
			smallIcon = "172499d277f.png",
			icon = "172baf8c5fe.jpg",
			iconWidth = 80,
			iconHeight = 80
		})
		:setDamage(5)
		:setUseLimit(15)
		:setUseCooldown(4)
		:setProbability(3) -- For non-divine players, it only happens for emote triggerers
		:bindEmote(enum_emote.facepaw)
		:bindChatMessage("^P+R+O+T+E+C+T+O+S+$")
		:setEffect(function(_, x, y)
			local dimension = 80

			-- Particles
			circle(x, y, dimension)

			-- Damage
			explosion(x, y, -40, dimension)
			return pythagoras, x, y, dimension
		end)
end

-- Level 42
do
	local particles = { 0, 4, 11 }
	local totalParticles = #particles

	local auxSpeedRad = rad(18)
	local spiral = function(x, y, angle)
		angle = rad(angle)

		local auxSpeed, auxRad = 0
		for i = 1, 40, (isLowQuality and 2 or 1) do
			auxSpeed = i * .1

			auxRad = angle + auxSpeedRad*i

			displayParticle(particles[(i%totalParticles + 1)], x, y, auxSpeed * cos(auxRad),
				auxSpeed * sin(auxRad))
		end
	end

	powers.wormHole = Power
		.new("wormHole", powerType.def, 42, {
			smallIcon = "172499c71c4.png",
			icon = "172baf8e646.jpg",
			iconWidth = 72,
			iconHeight = 80
		})
		:setUseCooldown(1.5)
		:bindKeyboard(keyboard.up, keyboard.down)
		:setKeySequence({
			{ keyboard.up, keyboard.down },
			{ keyboard.down, keyboard.up }
		})
		:setEffect(function(playerName, x, y, isFacingRight)
			local direction = (isFacingRight and 200 or -200)

			-- Move player
			movePlayer(playerName, x + direction, y, false, 0, -50, false)

			-- Particles
			spiral(x, y, 270)
			spiral(x + direction, y, 90)
		end)
end

-- Level 50
do
	local changeSize = function(self, timer)
		if timer.times == 0 then
			for name in next, players.currentRound do
				changePlayerSize(name, 1)
			end
			resetPlayersDefaultSize = false
		else
			for name in next, players.alive do
				changePlayerSize(name, random(5, 35) / 10)
			end
		end
	end

	powers.atomic = Power
		.new("atomic", powerType.divine, 50, {
			smallIcon = "172499db327.png",
			icon = "172baf7e255.jpg",
			iconWidth = 76,
			iconHeight = 80
		}, {
			seconds = 10
		})
		:setUseCooldown(25)
		:setProbability(40)
		:bindChatMessage("^A+T+O+M+I+C+$")
		:setEffect(function(self)
			resetPlayersDefaultSize = true
			timer:start(changeSize, 500, self.seconds * 2, self)
		end)
end

-- Level 60
do
	local auxSpeedRad = rad(18)
	local doubleSpiral = function(x, y, xAngleRight, xAngleLeft, yAngle)
		xAngleRight = rad(xAngleRight)
		xAngleLeft = rad(xAngleLeft)
		yAngle = rad(yAngle)

		local auxSpeed, auxCosRadLeft, auxCosRadRight, auxSinRad = 0
		local particle

		for i = 1, 38, (isLowQuality and 4 or 2) do
			auxSpeed = i * .1

			auxCosRadRight = xAngleRight + auxSpeedRad*i
			auxCosRadLeft = xAngleLeft - auxSpeedRad*i

			auxSinRad = yAngle - auxSpeedRad*i
			auxSinRad = auxSpeed * sin(auxSinRad)

			particle = (i < 3 and 13 or i < 20 and 11 or 2)

			displayParticle(particle, x, y, auxSpeed * cos(auxCosRadRight), auxSinRad)
			displayParticle(particle, x, y, auxSpeed * cos(auxCosRadLeft), auxSinRad)
		end
	end

	powers.superNova = Power
		.new("superNova", powerType.atk, 60, {
			smallIcon = "172499d01da.png",
			icon = "172baf9065b.jpg",
			iconWidth = 92,
			iconHeight = 80
		})
		:setDamage(20)
		:setSelfDamage(8)
		:setUseLimit(6)
		:setUseCooldown(6)
		:bindKeyboard(keyboard.ctrl)
		:setEffect(function(_, x, y, isFacingRight)
			local direction = (isFacingRight and 50 or -50)
			x = x + direction
			y = y - 50

			-- Particles
			doubleSpiral(x, y, 120, 60, 120)

			-- Damage
			explosion(x, y, 50, 110)
			return pythagoras, x, y, 70
		end)
end

-- Level 70
do
	local smashDamage = function(playerName)
		local rand = random(50, 100)
		movePlayer(playerName, 0, 0, true, 0, -rand, true)
		return rand > 69
	end

	local dust = function(x, y)
		for i = 1, 10, (isLowQuality and 2 or 1) do
			displayParticle(3, x + cos(i) * 100, y + random(-30, 30))
		end
	end

	powers.meteorSmash = Power
		.new("meteorSmash", powerType.atk, 70, {
			smallIcon = "172499d49f6.png",
			icon = "172baf7c232.jpg",
			iconWidth = 86,
			iconHeight = 80
		})
		:setDamage(20)
		:setSelfDamage(8)
		:setUseLimit(10)
		:setUseCooldown(8)
		:bindKeyboard(keyboard.down)
		:setKeySequence({ { keyboard.down, keyboard.down } })
		:setEffect(function(playerName, x, y, _, self)
			-- Super jump
			movePlayer(playerName, 0, 0, true, 0, -110, true)
			-- Super smash
			timer:start(movePlayer, 500, 1, playerName, 0, 0, true, 0, 400, false)
			-- Damage
			timer:start(self.damagePlayers, 1000, 1, self, playerName, { smashDamage, inRectangle,
				x - 100, y - 60, 200, 100, true }, damagePlayersWithAction)
			-- Particles
			timer:start(dust, 1000, 1, x, y)

			return false
		end)
end

-- Level 90
do
	local circle = function(x, y, dimension)
		local xCos, ySin
		for i = 90, 110, (isLowQuality and 1.75 or 1) do
			xCos = cos(i)
			ySin = sin(i)

			displayParticle(14, x + xCos*dimension, y + ySin*dimension, xCos * -5, ySin * -5)
		end
	end

	local freeze = function(playerName)
		freezePlayer(playerName)
		timer:start(freezePlayer, 1500, 1, playerName, false)
		return true
	end

	powers.waterPump = Power
		.new("waterPump", powerType.atk, 90, {
			smallIcon = "172cec7920e.png",
			icon = "172ced1ac40.jpg",
			iconWidth = 70,
			iconHeight = 70
		})
		:setDamage(20)
		:setSelfDamage(15)
		:setUseLimit(1)
		:setUseCooldown(20)
		:bindKeyboard(0, 2, 3)
		:setKeySequence({
			{ keyboard.right, keyboard.left, keyboard.down, keyboard.right },
			{ keyboard.left, keyboard.right, keyboard.down, keyboard.left }
		})
		:setEffect(function(playerName, x, y, _, self)
			local dimension = 60

			-- Particles
			circle(x, y, dimension)

			-- Damage
			self:damagePlayers(playerName, { freeze, pythagoras, x, y, dimension },
				damagePlayersWithAction)
			return false
		end)
end

-- Level 100
do
	local ray = function(x, y, arcWidth, arcHeight, size, direction)
		arcWidth = arcWidth * direction

		local ySin = 0
		local xPos = x
		local yPos = 0
		local xSpeed = 0
		local ySpeed = 0

		local xDirection = .1 * direction

		size = size * 3
		for i = 0, size do
			displayParticle(9, xPos, y + yPos, xSpeed, -ySpeed)

			i = i + 1
			ySin = sin(i)
			xPos = x + i*arcWidth
			yPos = ySin*arcHeight
			xSpeed = i * xDirection
			ySpeed = ySin * .55

			displayParticle(2, xPos, y - yPos, xSpeed, ySpeed)
		end

		xSpeed = direction*(size/2 - 1) + direction
		for i = 1, 2 do
			displayParticle(13, x, y, xSpeed)
		end
	end

	powers.deathRay = Power
		.new("deathRay", powerType.atk, 100, {
			smallIcon = "172499d9bcf.png",
			icon = "172bb0d9761.jpg",
			iconWidth = 150,
			iconHeight = 28
		})
		:setDamage(30)
		:setSelfDamage(20)
		:setUseLimit(1)
		:setUseCooldown(20)
		:bindKeyboard(0, 1, 2, 3)
		:setKeySequence({
			{ keyboard.left, keyboard.up, keyboard.right, keyboard.down },
			{ keyboard.right, keyboard.up, keyboard.left, keyboard.down }
		})
		:setEffect(function(_, x, y, isFacingRight)
			-- Particles
			ray(x, y, 10, 8, 6, (isFacingRight and 1 or -1))

			-- Damage
			return inRectangle, x, y - 40, 250, 80, isFacingRight
		end)
end

-- Level 110
do
	powers.dayOfJudgement = Power
		.new("dayOfJudgement", powerType.divine, 110, {
			smallIcon = "172499dd0d6.png", -- 172499df39f
			icon = "172baf80263.jpg",
			iconWidth = 77,
			iconHeight = 80
		}, {
			seconds = 10,
			playerHealthPoints = 35,
			minDeadMice = 2
		})
		:setUseCooldown(45)
		:setProbability(40)
		:bindChatMessage("^R+A+I+S+E+ T+H+E+ D+E+A+D+$")
		:setEffect(function(self)
			if players._count.dead < self.minDeadMice then return end
			local deadMice = players.dead

			-- Respawns dead mice
			local firstPlayer = next(deadMice, nil)
			local player = firstPlayer
			local lastName

			while player do
				respawnPlayer(player)
				addHealth(player, playerCache[player], self.playerHealthPoints)

				lastPlayer = player
				player = next(deadMice, player)

				linkMice((player or firstPlayer), lastPlayer, true)
			end
		end)
end

-- Level 120
do
	local anomaly = function(self, newItems, timer)
		if timer.times == 0 then
			canTriggerPowers = true

			removeTextArea(textAreaId.gravitationalAnomaly)

			for i = 1, self.despawnLen do
				removeObject(self.despawnObjects[i])
			end
			-- It will be reset in the next round, divine powers can only be used once.
			-- Setting it to nil will avoid creating an unnecessary table, and will call the GC.
			self.despawnObjects = nil

			local cache
			for playerName in next, players.alive do
				cache = playerCache[playerName]
				if cache.extraHealth > 0 then
					addHealth(playerName, cache)
				end
			end
		else
			self.opacity = self.opacity - self.opacityFrame

			-- Prevents clicking
			addTextArea(textAreaId.gravitationalAnomaly, '', nil, -1500, -1500, 3000, 3000, 1, 1,
				self.opacity, true)

			-- Spawns random objects
			for i = 1, newItems do
				self.despawnObjects[self.despawnLen + i] = addShamanObject(
					table_random(self.spawnableObjects), random(5, 795), random(30, 380),
					random(360), random(-7, 7), random(-5, 5))
			end
			self.despawnLen = self.despawnLen + newItems

			-- Explosion
			local expX, expY, expR = random(15, 785), random(30, 380), random(150, 500)
			explosion(expX, expY, random(-40, 40), expR)

			-- Extra life
			if random(8) == random(8) then
				local rand
				for name, cache in next, getPlayersOnFilter(nil, pythagoras, expX, expY, expR) do
					rand = random(1, self.totalPlusIds)
					cache.extraHealth = cache.extraHealth + self.availableHealthPoints[rand]
					displayParticle(self.availablePlusIds[rand], expX, expY, 0, 0, 0, 0, name)
				end
			end
		end
	end

	powers.gravitationalAnomaly = Power
		.new("gravitationalAnomaly", powerType.divine, 120, {
			smallIcon = "172499d5f79.png",
			icon = "172baf82263.jpg",
			iconWidth = 72,
			iconHeight = 80
		}, {
			spawnableObjects = {
				enum_shamanObject.littleBox,
				enum_shamanObject.box,
				enum_shamanObject.littleBoard,
				enum_shamanObject.board,
				enum_shamanObject.ball,
				enum_shamanObject.trampoline,
				enum_shamanObject.anvil,
				enum_shamanObject.cannon,
				enum_shamanObject.bomb,
				enum_shamanObject.balloon,
				enum_shamanObject.rune,
				enum_shamanObject.chicken,
				enum_shamanObject.snowBall,
				enum_shamanObject.cupidonArrow,
				enum_shamanObject.apple,
				enum_shamanObject.sheep,
				enum_shamanObject.littleBoardIce,
				enum_shamanObject.littleBoardChocolate,
				enum_shamanObject.iceCube,
				enum_shamanObject.cloud,
				enum_shamanObject.bubble,
				enum_shamanObject.tinyBoard,
				enum_shamanObject.companionCube,
				enum_shamanObject.stableRune,
				enum_shamanObject.balloonFish,
				enum_shamanObject.longBoard,
				enum_shamanObject.triangle,
				enum_shamanObject.sBoard,
				enum_shamanObject.rock,
				enum_shamanObject.pumpkinBall,
				enum_shamanObject.tombstone,
				enum_shamanObject.paperBall,
				96, -- Mouse cube
				97 -- Energy orb
			},
			availablePlusIds = {
				enum_particle.plus1,
				enum_particle.plus10,
				enum_particle.plus12,
				enum_particle.plus14,
				enum_particle.plus16
			},
			availableHealthPoints = {
				[1] = 1,
				[2] = 10,
				[3] = 12,
				[4] = 14,
				[5] = 16
			},
			totalPlusIds = 5,
			opacityFrame = 0.05
		}, {
			opacity = 1,
			despawnObjects = { },
			despawnLen = 0
		})
		:setUseCooldown(25)
		:setProbability(60)
		:bindChatMessage("^A+N+O+M+A+L+Y+$")
		:setEffect(function(self)
			canTriggerPowers = false
			timer:start(anomaly, 500, 1/self.opacityFrame, self, (isLowQuality and 1 or 3))
		end)
end

--[[ sortedPowers.lua ]]--
-- Powers Sorted By Level
do
	local powerNameByLevel = Power.__nameByLevel

	local powerIndex = 0
	for lvl = 0, module.max_player_level do -- It's a small number, so it's fine for now.
		lvl = powerNameByLevel[lvl]
		if lvl then
			for i = 1, #lvl do
				powerIndex = powerIndex + 1
				powersSortedByLevel[powerIndex] = powers[lvl[i]]
			end
		end
	end
end

--[[ textAreaCallbacks/callbacks.lua ]]--
local textAreaCallbacks = { }

--[[ keyboardCallbacks/callbacks.lua ]]--
local keyboardCallbacks = { }

--[[ commands/commands.lua ]]--
local commands = { }

--[[ enums/commandsMeta.lua ]]--
local commandsMeta = {
	{
		name = "help",
		hotkey = "H"
	},
	{
		name = "powers",
		hotkey = "O"
	},
	{
		name = "profile",
		hotkey = "P"
	},
	{
		name = "leaderboard",
		hotkey = "L"
	},

	{
		name = "pw",
		isRoomAdmin = true
	},

	{
		name = "map",
		index = "mapEditQueue",
		permission = permissions.editLocalMapQueue
	},
	{
		name = "map",
		index = "mapSaveQueue",
		permission = permissions.saveLocalMapQueue
	},
	{
		name = "review",
		permission = permissions.enableReviewMode
	},
	{
		name = "np",
		permission = permissions.enableReviewMode
	},
	{
		name = "npp",
		permission = permissions.enableReviewMode
	},

	{
		name = "msg",
		permission = permissions.sendRoomMessage
	},
	{
		name = "ban",
		permission = permissions.banUser
	},
	{
		name = "unban",
		permission = permissions.unbanUser
	},
	{
		name = "permban",
		permission = permissions.permBanUser
	},

	{
		name = "promote",
		permission = permissions.promoteUser
	},
	{
		name = "demote",
		permission = permissions.demoteUser
	}
}

local helpCommands = { }
do
	local commandStr = "%s%s<V><B>!%s</B> %s<N>- %s" -- Two first %s are ignored
	local commandAndHotkeyStr = "<V><B>%s</B> %s <B>!%s</B> %s<N>- %s"

	local commandDescriptions = getText.commandDescriptions
	local commandsParameters = getText.commandsParameters

	for cmd = 1, #commandsMeta do
		cmd = commandsMeta[cmd]

		cmd.index = cmd.index or cmd.name

		helpCommands[cmd.index] = format((cmd.hotkey and commandAndHotkeyStr or commandStr),
			(cmd.hotkey or ''), (cmd.hotkey and getText["or"] or ''), cmd.name,
			(commandsParameters[cmd.index] or ''), commandDescriptions[cmd.index] or '?')
	end
end

--[[ api/data.lua ]]--
do
	local LAST_LOAD_TIME = time() - 62500
	local LAST_SAVE_TIME = time() - 62500

	local load = loadFile
	local save = saveFile

	loadFile = function(fileId)
		local time = time()

		local callTime = max(0, 62500 + (LAST_LOAD_TIME - time))
		unrefreshableTimer:start(load, callTime, 1, fileId)

		LAST_LOAD_TIME = time + callTime
	end

	saveFile = function(data, fileId)
		local time = time()

		local callTime = max(62500 + (LAST_SAVE_TIME - time), 0)
		unrefreshableTimer:start(save, callTime, 1, data, fileId)

		LAST_SAVE_TIME = time + callTime
	end
end

-- Commands
local generateCommandHelp = function(playerId, playerName)
	local playerPermissions = playersWithPrivileges[playerId] or 0

	local commands, totalCommands = { }, 0
	for cmd = 1, #commandsMeta do
		cmd = commandsMeta[cmd]

		if (not cmd.permission or hasPermission(nil, cmd.permission, nil, playerPermissions))
			and (not cmd.isRoomAdmin or roomAdmins[playerName]) then
			totalCommands = totalCommands + 1
			commands[totalCommands] = helpCommands[cmd.index]
		end
	end

	return table_concat(commands, '\n')
end

local buildAndSaveDataFile = function()
	-- Maps
	dataFileContent[1] = table_concat(maps, '@')

	-- Players with privileges
	local dataStr, counter = { }, 0
	for playerId, permissions in next, playersWithPrivileges do
		counter = counter + 1
		dataStr[counter] = playerId
		counter = counter + 1
		dataStr[counter] = format("%x", permissions) -- Saves space
	end
	dataFileContent[2] = table_concat(dataStr, '#')

	-- Banned players
	dataStr, counter = { }, 0
	for playerId, remainingTime in next, bannedPlayers do
		counter = counter + 1
		dataStr[counter] = playerId
		counter = counter + 1
		dataStr[counter] = format("%x", remainingTime) -- Saves space
	end
	dataFileContent[3] = table_concat(dataStr, '#')

	-- Save (add to the queue)
	if not isSaveDataFileScheduled then
		isSaveDataFileScheduled = true
		saveFile(table_concat(dataFileContent, ' '), module.data_file)
	end
end

local parseDataFile = function(data)
	--[[
		data[1] -> Maps
		data[2] -> Privileges
		data[3] -> Banned
	]]
	data = str_split(data, ' ', true)
	dataFileContent = data

	-- Loads all maps
	maps = str_split(tostring(data[1]), '@', true, tonumber)
	mapHashes = table_set(maps)
	table_shuffle(maps)
	totalCurrentMaps = #maps
	-- Init first map
	setGameTime(0)

	-- Loads all privileged players
	data[2] = data[2] or ''
	for playerId, permissions in gmatch(data[2], "(%d+)#(%x+)") do
		playersWithPrivileges[playerId * 1] = tonumber(permissions, 16)
	end

	-- Loads all banned players
	data[3] = data[3] or ''
	for playerId, remainingTime in gmatch(data[3], "(%d+)#(%x+)") do
		bannedPlayers[playerId * 1] = tonumber(remainingTime, 16)
	end

	-- Horizontal (un)ban and commands check
	local fileHasChanged = false

	local time, banTime = time()
	for playerName, data in next, room.playerList do
		banTime = bannedPlayers[data.id]
		if banTime then
			if time > banTime then
				bannedPlayers[data.id] = nil
				fileHasChanged = true
			else
				players_lobby(playerName)
				warnBanMessage(playerName, banTime)
			end
		elseif playerCache[playerName] then
			playerCache[playerName].commands = generateCommandHelp(data.id, playerName)
			keyboardCallbacks[keyboard.H](playerName, playerCache[playerName])
		end
	end

	if fileHasChanged then
		buildAndSaveDataFile()
	end
end

--[[ leaderboard.lua ]]--
local readLeaderboardData = function(data)
	local total
	data, total = str_split(gsub(data, "([Hh])ttp", "%1:ttp"), ' ', true, tonumber)

	local community, id, nickname, discriminator, rounds, victories, kills, xp

	local l_community     = leaderboard.community
	local l_id            = leaderboard.id
	local l_nickname      = leaderboard.nickname
	local l_discriminator = leaderboard.discriminator
	local l_rounds        = leaderboard.rounds
	local l_victories     = leaderboard.victories
	local l_kills         = leaderboard.kills
	local l_xp            = leaderboard.xp

	local l_registers = leaderboard.registers
	local l_sets = leaderboard.sets

	local l_full_nickname = leaderboard.full_nickname
	local l_pretty_nickname = leaderboard.pretty_nickname

	local totalRegisters = total / 8 -- 8 fields

	local player = 0
	for i = 1, total, 8 do
		community     = data[i + 0]
		id            = data[i + 1]
		nickname      = data[i + 2]
		discriminator = data[i + 3]
		rounds        = data[i + 4]
		victories     = data[i + 5]
		kills         = data[i + 6]
		xp            = data[i + 7]

		player = player + 1

		l_community    [player] = flags[(flagCodes[community] or "xx")]
		l_id           [player] = id
		l_nickname     [player] = nickname
		l_discriminator[player] = format("%04d", discriminator)
		l_rounds       [player] = rounds
		l_victories    [player] = victories
		l_kills        [player] = kills
		l_xp           [player] = xp

		l_registers[player] = {
			community     = community,
			id            = id,
			nickname      = nickname,
			discriminator = discriminator,
			rounds        = rounds,
			victories     = victories,
			kills         = kills,
			xp            = xp
		}

		l_sets[id] = player

		l_full_nickname[player] = nickname .. "#" .. l_discriminator[player]
		l_pretty_nickname[player] = prettifyNickname(nickname, 11, l_discriminator[player], "BL")
	end

	leaderboard.loaded = true
	-- Remove from this function when hits max.
	leaderboard.total_pages = ceil(totalRegisters / 17) -- 17 rows
end

local sortLeaderboard
do
	local sort = function(p1, p2)
		return p1.xp > p2.xp
	end

	sortLeaderboard = function()
		local l_community     = leaderboard.community
		local l_id            = leaderboard.id
		local l_nickname      = leaderboard.nickname
		local l_discriminator = leaderboard.discriminator
		local l_rounds        = leaderboard.rounds
		local l_victories     = leaderboard.victories
		local l_kills         = leaderboard.kills
		local l_xp            = leaderboard.xp

		local l_registers = leaderboard.registers
		local l_sets = leaderboard.sets

		local registersLen = #l_registers

		local playerData, quickPlayerData = playerData.playerData
		local player, playerPosition
		local nickname, discriminator, community

		for playerName in next, players.room do
			player = room.playerList[playerName]
			quickPlayerData = playerData[playerName]

			nickname, discriminator = getNicknameAndDiscriminator(playerName)
			community = flagCodesSet[player.community] or flagCodesSet.xx

			playerPosition = l_sets[player.id]
			if playerPosition then -- Already exists, just updates the register
				playerPosition = l_registers[playerPosition]

				-- Player may have changed their community since the last cycle
				playerPosition.community = community
				-- Player may have changed their nickname
				playerPosition.nickname = nickname
				playerPosition.discriminator = discriminator

				playerPosition.rounds = quickPlayerData.rounds
				playerPosition.victories = quickPlayerData.victories
				playerPosition.kills = quickPlayerData.kills
				playerPosition.xp = quickPlayerData.xp
			else
				registersLen = registersLen + 1
				l_registers[registersLen] = {
					community     = community,
					id            = player.id,
					nickname      = nickname,
					discriminator = discriminator,
					rounds        = quickPlayerData.rounds,
					victories     = quickPlayerData.victories,
					kills         = quickPlayerData.kills,
					xp            = quickPlayerData.xp
				}
				l_sets[player.id] = registersLen
			end
		end

		table_sort(l_registers, sort)

		-- No need to slice the table, it will soon be rewritten by eventFileLoaded.
		return l_registers, registersLen
	end
end

local writeLeaderboardData
do
	local dataFormat = "%d %d %s %d %d %d %d %d"
	writeLeaderboardData = function()
		local registers, totalRegisters = sortLeaderboard()

		local data, counter, tmpWritten, register = { }, 0, { }
		for i = 1, totalRegisters do
			register = registers[i]

			if not tmpWritten[register.nickname] then
				tmpWritten[register.nickname] = true

				counter = counter + 1
				data[counter] = format(dataFormat,
					register.community,
					register.id,
					register.nickname,
					register.discriminator,
					register.rounds,
					register.victories,
					register.kills,
					register.xp
				)
			end

			if counter == module.max_leaderboard_rows then break end
		end

		saveFile(table_concat(data, ' '), module.leaderboard_file)
	end
end

--[[ classes/prettyUI.lua ]]--
local prettyUI = { }
do
	prettyUI.__index = prettyUI

	local borderImage = {
		[1] = "155cbea943a.png",
		[2] = "155cbe99c72.png",
		[3] = "155cbe9bc9b.png",
		[4] = "155cbe97a3f.png"
	}
	local textareaInterface = function(self, x, y, w, h, playerName, cache, text,
		_borderIni, _borderEnd, _borderStep)
		y = y - 3
		self:addTextArea('', playerName, x, y, w, h, 0x141312, 0x141312, 1, false)
		self:addTextArea('', playerName, x + 1, y + 1, w - 2, h - 2, 0x7C482C, 0x7C482C, 1, false)
		self.contentTextAreaId = self:addTextArea(text, playerName, x + 4, y + 4, w - 8, h - 8,
			0x152D30, 0x141312, 1, false)

		x = x - 6
		y = y - 3
		w = w - 14
		h = h - 16

		for b = (_borderIni or 1), (_borderEnd or 4), (_borderStep or 1) do
			self:addImage(borderImage[b], imageTargets.interfaceTextAreaBackground, x + (b % 2)*w,
				y + (b < 3 and 0 or 1)*h, playerName)
		end
	end

	local imageInterface = function(self, x, y, w, h, playerName, cache, text,
		compensateInterfaceImageDimensions)
		self:addImage(interfaceBackground[w][h], imageTargets.interfaceBackground, x - 8, y - 10,
			playerName)

		if compensateInterfaceImageDimensions then
			x = x - 8
			y = y - 10
		end

		self.contentTextAreaId = self:addTextArea(text, playerName, x + 4, y + 4, w - 8, h - 8, 1,
			1, 0, true)
	end

	prettyUI.new = function(x, y, w, h, playerName, text, _cache, ...)
		text = text or ''
		_cache = _cache or playerCache[playerName]

		local self = setmetatable({
			id = nil,

			x = x,
			y = y,
			w = w,
			h = h,
			playerName = playerName,
			cache = _cache,

			contentTextAreaId = nil,

			interfaceImages = { },
			totalInterfaceImages = 0,

			initInterfaceId = nil,
			interfaceId = nil,

			isCheckingDeletableContent = false,
			firstDeletableTextArea = nil,
			lastDeletableTextArea = nil,
			firstDeletableImage = nil,
			lastDeletableImage = nil
		}, prettyUI)

		-- Sets new ID
		_cache.totalPrettyUIs = _cache.totalPrettyUIs + 1
		self.id = _cache.totalPrettyUIs
		_cache.prettyUIs[self.id] = self
		_cache.lastPrettyUI = self

		-- Sets interface ID
		local lastInstance = _cache.prettyUIs[self.id - 1]
		self.interfaceId = (lastInstance and lastInstance.interfaceId or textAreaId.interface)
		self.initInterfaceId = self.interfaceId + 1

		_cache.isInterfaceOpen = true

		if interfaceBackground[w] and interfaceBackground[w][h] then
			imageInterface(self, x, y, w, h, playerName, _cache, text, ...)
		else
			-- Debug/development behavior, avoidable
			textareaInterface(self, x, y, w, h, playerName, _cache, text, ...)
		end

		return self
	end

	prettyUI.remove = function(self, iniImg, endImg, iniTxt, endTxt)
		-- Resetting data is unnecessary, GC should handle the instance

		for t = (endTxt or self.interfaceId), (iniTxt or self.initInterfaceId), -1 do
			removeTextArea(t, self.playerName)
		end

		local interfaceImages = self.interfaceImages
		for i = (endImg or self.totalInterfaceImages), (iniImg or 1), -1 do
			removeImage(interfaceImages[i])
		end
	end

	prettyUI.addTextArea = function(self, ...)
		self.interfaceId = self.interfaceId + 1
		addTextArea(self.interfaceId, ...)

		if self.isCheckingDeletableContent and not self.firstDeletableTextArea then
			self.firstDeletableTextArea = self.interfaceId
		end

		return self.interfaceId
	end

	prettyUI.addImage = function(self, ...)
		self.totalInterfaceImages = self.totalInterfaceImages + 1

		local image = addImage(...)
		self.interfaceImages[self.totalInterfaceImages] = image

		if self.isCheckingDeletableContent and not self.firstDeletableImage then
			self.firstDeletableImage = self.totalInterfaceImages
		end

		return image
	end

	local callback = "<textformat leftmargin='1' rightmargin='1'><a href='event:%s'>%s"
	prettyUI.addClickableImage = function(self, image, target, x, y, playerName, w, h, callbackName,
		callbackCondition)
		self:addImage(image, target, x, y, playerName)
		if callbackCondition == nil or callbackCondition then
			self:addTextArea(format(callback, callbackName, rep('\n', h / 10)), playerName, x - 5,
				y - 5, w + 5, h + 5, 1, 1, 0, true)
		end
		return self
	end

	prettyUI.setCloseButton = function(self, xAxis)
		return self:addClickableImage(interfaceImages.xButton, imageTargets.interfaceIcon,
			self.x + self.w - (xAxis or 12), self.y - 15, self.playerName, 30, 30, "closeInterface")
	end

	prettyUI.markDeletableContent = function(self, bool)
		if not bool and self.isCheckingDeletableContent then
			-- Assuming at least one of each has been used...
			self.lastDeletableTextArea = self.interfaceId
			self.lastDeletableImage = self.totalInterfaceImages
		end
		self.isCheckingDeletableContent = bool
		return self
	end

	prettyUI.deleteDeletableContent = function(self)
		if self.isCheckingDeletableContent then
			self
				:markDeletableContent(false)
				:remove(self.firstDeletableImage, self.lastDeletableImage,
					self.firstDeletableTextArea, self.lastDeletableTextArea)
			self.firstDeletableImage, self.lastDeletableImage, self.firstDeletableTextArea,
				self.lastDeletableTextArea = nil, nil, nil, nil
		end
		return self
	end
end

--[[ textAreaCallbacks/closeInterface.lua ]]--
do
	textAreaCallbacks["closeInterface"] = function(playerName, cache)
		-- closeInterface
		if not cache.isInterfaceOpen then return end
		cache.isInterfaceOpen = false

		local prettyUIs = cache.prettyUIs

		cache.lastPrettyUI = nil
		for u = 1, cache.totalPrettyUIs do
			if prettyUIs[u] then
				prettyUIs[u]:remove()
			end
		end

		cache.prettyUIs = { }
		cache.totalPrettyUIs = 0

		cache.helpTabs = { }
		cache.powerInfoIdSelected = nil
		cache.powerInfoSelectionImageId = nil

		cache.isHelpOpen = false
		cache.isPowersOpen = false
		cache.isProfileOpen = false
		cache.isLeaderboardOpen = false
	end
end

--[[ interfaces/help.lua ]]--
local displayHelp, updateHelp
do
	-- Format translations
	local helpContent = getText.helpContent
	do
		-- Intro
		helpContent[1] = format(getText.helpContent[1], getText.enableParticles,
			prettifyNickname(module.author, 11, nil, nil, "font color='#8FE2D1'"))
	end

	-- Menu
	local contentFormat = "<font size='13'>"
	local tabStr = "<font size='1'>\n</font><p align='center'>%s<a href='event:helpTab_%s'>%s\n"

	local getPageContent = function(page, _cache)
		if page == 2 then
			return helpContent[2] .. (_cache.commands or '?')
		else
			return helpContent[page]
		end
	end

	displayHelp = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]
		textAreaCallbacks["closeInterface"](playerName, _cache)
		_cache.isHelpOpen = true

		local helpPage = _cache.helpPage

		local x, y, w = 100, 65, 503

		prettyUI
			.new(x, y, w, 278, playerName, contentFormat .. getPageContent(helpPage, _cache),
				_cache)
			:setCloseButton()

		x = x + w + 5
		y = y + 5

		for t = 1, #getText.helpTitles do
			_cache.helpTabs[t] = prettyUI
				.new(x, y + t*30, 120, 30, playerName, format(tabStr,
					(t == helpPage and "<J>" or ''), t,	getText.helpTitles[t]), _cache, true)
		end
	end

	updateHelp = function(playerName, nextHelpPage, _cache)
		_cache = _cache or playerCache[playerName]

		-- Remove highlight color of the last tab
		local currentHelpPage = _cache.helpPage
		updateTextArea(_cache.helpTabs[currentHelpPage].contentTextAreaId, "<N>" .. format(tabStr,
			'', currentHelpPage, getText.helpTitles[currentHelpPage]), playerName)

		-- Highlights new tab
		updateTextArea(_cache.helpTabs[nextHelpPage].contentTextAreaId, format(tabStr, "<J>",
			nextHelpPage, getText.helpTitles[nextHelpPage]), playerName)

		-- Main menu
		updateTextArea(_cache.prettyUIs[1].contentTextAreaId,
			contentFormat .. getPageContent(nextHelpPage, _cache), playerName)

		_cache.helpPage = nextHelpPage
	end
end

--[[ interfaces/powers.lua ]]--
local displayPowerMenu
do
	local content = "<p align='center'><font size='3'>\n"
	local unlockedPowerContent = content .. "<font size='14'>"
	local lockedPowerContent = content .. "<font size='12'><BL><B>" .. getText.level ..
		"</B><N><font size='10'>\n%s"
	local callback = "powerInfo_%s_%s_%s"

	displayPowerMenu = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]
		textAreaCallbacks["closeInterface"](playerName, _cache)
		_cache.isPowersOpen = true
		local playerLevel = _cache.level

		-- Build interface
		local x, y = 253, 65
		local interface = prettyUI
			.new(x, y, 503, 278, playerName, '', _cache)
			:setCloseButton(4)

		x = x + 7
		y = y + 7

		local totalPowers = #powersSortedByLevel
		local power, isLockedPower, sumX
		for p = 1, totalPowers do
			power = powersSortedByLevel[p]
			isLockedPower = (power.level > playerLevel)

			sumX = x + ((p + 1) % 2)*249

			if not isLockedPower then
				interface:addTextArea(unlockedPowerContent .. getText.powers[power.name],
					playerName, sumX, y, 241, 30, -1, 0x1B2B31, 0, true)
			else
				interface:addTextArea(format(lockedPowerContent, power.level,
					getText.powers[power.name]), playerName, sumX, y - 5, 241, 50, -1, 0x1B2B31, 0,
					true)
			end

			interface:addClickableImage(interfaceImages.rectangle, imageTargets.interfaceRectangle,
				sumX - 2, y - 2, playerName, 245, 34, format(callback, power.name, sumX - 4, y - 5))

			interface:addImage(power.imageData.smallIcon, imageTargets.interfaceIcon, sumX, y,
				playerName)

			if isLockedPower then
				interface:addImage(interfaceImages.locker, imageTargets.interfaceIcon, sumX + 216,
					y, playerName)
			end

			if p % 2 == 0 then
				y = y + 39
			end
		end
	end
end

local updatePowerMenu = function(playerName, interfaceX, interfaceY, _cache)
	_cache = _cache or playerCache[playerName]

	if _cache.powerInfoSelectionImageId then
		removeImage(_cache.powerInfoSelectionImageId, playerName)

		_cache.lastPrettyUI:remove()
	end

	_cache.powerInfoSelectionImageId = _cache.prettyUIs[1]:addImage(
		interfaceImages.highlightRectangleBorder, imageTargets.interfaceRectangle, interfaceX,
		interfaceY, playerName)
end

local displayPowerInfo
do
	local displayPowerIcon = function(playerName, power, interface, x, y, w)
		y = y + 40

		interface:addImage(power.imageData.icon, imageTargets.interfaceIcon,
			x + w/2 - power.imageData.iconWidth/2, y, playerName)

		return x, y + power.imageData.iconHeight
	end

	local displayPowerTypeIcon = function(playerName, power, interface, x, y)
		y = y + 10

		local typeImage, typeText
		if power.type == powerType.atk then
			typeImage = interfaceImages.sword
			typeText = format(getText.powerType.atk, power.damage)
		elseif power.type == powerType.def then
			typeImage = interfaceImages.shield
			typeText = getText.powerType.def
		elseif power.type == powerType.divine then
			typeImage = interfaceImages.parchment
			typeText = getText.powerType.divine
		end

		interface:addImage(typeImage, imageTargets.interfaceIcon, x, y, playerName)
		interface:addTextArea(typeText, playerName, x + 25, y + 5, nil, nil, 1, 1, 0, true)

		return x, y
	end

	local displayPowerSelfDamage = function(playerName, power, interface, x, y)
		if power.selfDamage then
			y = y + 25

			interface:addImage(interfaceImages.heart, imageTargets.interfaceIcon, x, y, playerName)

			interface:addTextArea(-power.selfDamage, playerName, x + 25, y + 5, nil, nil, 1, 1, 0,
				true)
		end

		return x, y
	end

	local getTriggerPossibilityStr = function(triggerPossibility)
		return
	end

	local displayPowerTriggerPossibility = function(playerName, power, interface, x, y, isEmotePw)
		if power.triggerPossibility and (isEmotePw or power.type == powerType.divine) then
			y = y + 30

			interface:addImage(interfaceImages.explodingBomb, imageTargets.interfaceIcon, x + 2, y,
				playerName)

			interface:addTextArea("~" .. ceil(100/power.triggerPossibility) .. "%", playerName,
				x + 28, y, nil, nil, 1, 1, 0, true)
		end

		return x, y
	end

	local displayTrigger = function(playerName, power, interface, x, y, w)
		if power.keySequences then
			x = x - 10
			w = w / 2

			local sumX, ks
			for i = 1, power.totalKeySequences do
				ks = power.keySequences[i]

				sumX = x + w - (ks._count * 25)/2
				y = y + 25

				for j = ks._count, 1, -1 do
					interface:addImage(keyboardImages[ks.queue[j]], imageTargets.interfaceIcon,
						sumX, y, playerName)

					sumX = sumX + 25
				end
			end

			x = x + 25
		end
		if power.triggererKey then
			y = y + 25

			interface:addImage(keyboardImages[power.triggererKey], imageTargets.interfaceIcon,
				x - 10 + (w - (keyboardImagesWidths[power.triggererKey] or 25))/2, y, playerName)
		end
		if power.clickRange then
			y = y + 25

			interface:addImage(interfaceImages.mouseClick, imageTargets.interfaceIcon, x + 5, y,
				playerName)

			interface:addTextArea(power.clickRange .. "px", playerName, x + 25, y + 5, nil, nil, 1,
				1, 0, true)
		end
		if power.messagePattern then
			y = y + 25

			interface:addImage(interfaceImages.megaphone, imageTargets.interfaceIcon, x, y,
				playerName)

			interface:addTextArea("<I>" .. gsub(power.messagePattern, "[^%w ]+", ''), playerName,
				x + 30, y + 2, nil, nil, 1, 1, 0, true)
		end
		if power.triggererEmote then
			y = y + 25

			if power.triggerPossibility then
				displayPowerTriggerPossibility(playerName, power, interface, x + 16, y - 28, true)
			end

			interface:addImage(emoteImages[power.triggererEmote], imageTargets.interfaceIcon, x, y,
				playerName)
		end

		return x, y
	end

	local body = "<p align='center'><font size='16'><V><B>%s</B></V></font></p>" ..
		"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n%s"

	displayPowerInfo = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]
		local power = powers[_cache.powerInfoIdSelected]

		local x, y, width = 38, 65, 183
		local interface = prettyUI
			.new(x, y, width, 279, playerName, format(body, getText.powers[power.name],
				getText.powersDescriptions[power.name]), _cache)

		-- Icons
		x, y = displayPowerIcon(playerName, power, interface, x, y, width)

		x = x + 10
		x, y = displayPowerTypeIcon(playerName, power, interface, x, y)

		x, y = displayPowerTriggerPossibility(playerName, power, interface, x, y)

		x, y = displayPowerSelfDamage(playerName, power, interface, x, y)

		x, y = displayTrigger(playerName, power, interface, x, y, width)
	end
end

--[[ interfaces/profile.lua ]]--
local displayProfile
do
	local font = "<font size='%d'>"
	local centerAndFont = "<p align='center'>" .. font
	local nicknameFormat = centerAndFont .. "<font face='consolas,courier new,soopafresh'>%s"
	local levelNameFormat = centerAndFont .. "%s"
	local xpFormat = centerAndFont .. "<B>%d</B>\n</font>%d/%dxp"
	local valueFormat = font .. "%s"
	local dataNameFormat = "<font face='courier new'>%s"
	local nicknameColorFormat = "font color='#%x'"

	local dataNames = { "victories", "kills", "rounds" }
	local dataIcons = { "crown", "skull", "ground" }
	local totalData = #dataNames

	local displayLevelBar = function(playerName, targetPlayer, targetCacheData, x, y, interface)
		y = y + 35

		interface:addImage(interfaceImages.levelBar, imageTargets.levelBar, x, y, playerName)

		-- Level Title
		interface:addTextArea(format(levelNameFormat, 14,
			getText.levelName[targetCacheData.levelIndex]
				[room.playerList[targetPlayer].gender%2 + 1]), playerName, x, y, 280, 20, 1,
			1, 0, true)

		-- Width = currentExp*240 / totalExp
		y = y + 21

		interface:addTextArea('', playerName, x + 20, y, 240, 1, 0x152D30, 0x152D30, 1, false)

		interface:addTextArea('', playerName, x + 20, y,
			min(240, targetCacheData.currentLevelXp*240 / targetCacheData.nextLevelXp), 1,
			targetCacheData.levelColor, targetCacheData.levelColor, .75, false)

		-- Level value
		y = y + 18

		interface:addTextArea(format(xpFormat, 16, targetCacheData.level,
			targetCacheData.currentLevelXp, targetCacheData.nextLevelXp), playerName, x, y, 280,
			nil, 1, 1, 0, true)

		return x + 13, y + 65
	end

	displayProfile = function(playerName, targetPlayer, _cache)
		_cache = _cache or playerCache[playerName]
		textAreaCallbacks["closeInterface"](playerName, _cache)
		_cache.isProfileOpen = true
		local targetCacheData = playerCache[targetPlayer]

		local nicknameColor
		if hasPermission(targetPlayer, permissions.administratorColor) then
			nicknameColor = format(nicknameColorFormat, roleColors.administrator)
		elseif hasPermission(targetPlayer, permissions.moderatorColor) then
			nicknameColor = format(nicknameColorFormat, roleColors.moderator)
		elseif hasPermission(targetPlayer, permissions.mapReviewerColor) then
			nicknameColor = format(nicknameColorFormat, roleColors.mapReviewer)
		elseif hasPermission(targetPlayer, permissions.translatorColor) then
			nicknameColor = format(nicknameColorFormat, roleColors.translator)
		end

		local x, y = 260, 55
		local interface = prettyUI
			.new(x, y, 280, 330, playerName, format(nicknameFormat, 20,
				prettifyNickname(targetPlayer, 13, nil, nil, nicknameColor)), _cache)
			:setCloseButton()

		-- Level bar
		x, y = displayLevelBar(playerName, targetPlayer, targetCacheData, x, y, interface)

		-- Data
		local sumX
		for i = 1, totalData do
			sumX = x + ((i - 1) % 2)*135

			interface:addTextArea(format(dataNameFormat, getText.profileData[dataNames[i]]),
				playerName, sumX - 8, y - 12, nil, nil, 1, 1, 0, true)

			interface:addImage(interfaceImages.smallRectangle, imageTargets.interfaceRectangle,
				sumX - 2, y - 2, playerName)

			interface:addImage(interfaceImages[dataIcons[i]], imageTargets.interfaceIcon, sumX,
				y + 5, playerName)

			interface:addTextArea(format(valueFormat, 14, playerData:get(targetPlayer,
				dataNames[i])), playerName, sumX + 30, y + 8, nil, nil, 1, 1, 0, true)

			if i % 2 == 0 then
				y = y + 44
			end
		end

		-- Badges
		y = y + 44

		interface:addImage(interfaceImages.largeRectangle, imageTargets.interfaceRectangle, x - 2,
			y - 2, playerName)

		interface:addTextArea(format(dataNameFormat, getText.profileData.badges), playerName, x - 8,
			y - 12, nil, nil, 1, 1, 0, true)

		local targetBadges = targetCacheData.badges
		if not targetBadges then return end

		y = y + 4
		x = x + 8

		for b = 1, #targetBadges do
			sumX = x + ((b - 1) % 8)*30
			interface:addImage(badgeImages[targetBadges[b]], imageTargets.interfaceIcon, sumX, y,
				playerName)
			if b % 8 == 0 then
				y = y + 30
			end
		end
	end
end

--[[ interfaces/leaderboard.lua ]]--
local displayLeaderboard
do
	local prettifiedNickname = "<J>#%03d     %s"
	local midFontSize = "<font size='13'>"
	local titleFormat = "<font size='32'>" .. getText.leaderboard
	local dataFormat = midFontSize .. "<font face='courier new'><p align='center'>"

	local dataNames = { "xp", "victories", "kills", "rounds" }
	local dataIcons = { "star", "crown", "skull", "ground" }
	local totalData = #dataNames

	displayLeaderboard = function(playerName, _cache, interface)
		local iniX, iniY = 50, 60

		local x = iniX + 5
		local y = iniY + 45

		if not interface then
			if not leaderboard.loaded then
				return chatMessage(getText.leaderboardIsLoading, playerName)
			end

			_cache = _cache or playerCache[playerName]
			textAreaCallbacks["closeInterface"](playerName, _cache)
			_cache.isLeaderboardOpen = true

			local w, h = 700, 330
			interface = prettyUI
				.new(iniX, iniY, w, h, playerName, titleFormat, _cache)
				:setCloseButton()

			-- Add pagination buttons
			h = iniY + (h - 50)/2
			interface:addClickableImage(interfaceImages.leftArrow, imageTargets.interfaceIcon,
				iniX - 50, h, playerName, 50, 50, "leaderboardLeft")
			interface:addClickableImage(interfaceImages.rightArrow, imageTargets.interfaceIcon,
				iniX + w, h, playerName, 50, 50, "leaderboardRight")

			iniX = x
			iniY = y

			-- Background
			interface:addImage(interfaceImages.leaderboardRectangle,
				imageTargets.interfaceRectangle, iniX, iniY + 3, playerName)

			-- Icons
			iniX = iniX + 257
			for i = 1, totalData do
				interface:addImage(interfaceImages[dataIcons[i]], imageTargets.interfaceIcon,
					iniX + i*90, iniY - 30, playerName)
			end
		end

		interface
			:deleteDeletableContent()
			:markDeletableContent(true)

		local listEnd = 17*_cache.leaderboardPage
		local listIni = listEnd - 16

		-- Generates the name list
		local l_community = leaderboard.community
		local l_full_nickname = leaderboard.full_nickname
		local l_pretty_nickname = leaderboard.pretty_nickname

		listEnd = min(listEnd, #l_community)

		interface:addImage(interfaceImages.leaderboardRectangle, imageTargets.interfaceRectangle, x,
			y + 3, playerName)

		local prettifiedNicknames, count = { }, 0
		for i = listIni, listEnd do
			-- Place flags
			count = count + 1
			interface:addImage(l_community[i], imageTargets.interfaceIcon, x + 42,
				y + 5 + (count - 1)*16, playerName)

			-- Prettify nickname
			if l_full_nickname[i] == playerName then
				prettifiedNicknames[count] = format(prettifiedNickname, i, prettifyNickname(
					leaderboard.nickname[i], 11, leaderboard.discriminator[i], "BL", "FC"))
			else
				prettifiedNicknames[count] = format(prettifiedNickname, i, l_pretty_nickname[i])
			end
		end
		prettifiedNicknames = midFontSize .. table_concat(prettifiedNicknames, '\n')

		interface:addTextArea(prettifiedNicknames, playerName, x, y, nil, nil, 1, 1, 0, true)

		-- Inserts other data
		x = x + 230
		for i = 1, totalData do
			interface:addTextArea(dataFormat .. table_concat(leaderboard[dataNames[i]], '\n',
				listIni, listEnd), playerName, x + i*90, y + 1, 80, nil, 1, 1, 0, true)
		end
	end
end

--[[ textAreaCallbacks/helpTab.lua ]]--
do
	textAreaCallbacks["helpTab"] = function(playerName, cache, callback)
		-- helpTab_{tab_id}
		callback = callback[2] * 1
		if cache.helpPage == callback then return end

		updateHelp(playerName, callback, cache)
	end
end

--[[ textAreaCallbacks/powerInfo.lua ]]--
do
	textAreaCallbacks["powerInfo"] = function(playerName, cache, callback)
		-- powerInfo_{power_name}_{interface_x}_{interface_y}
		if cache.powerInfoIdSelected == callback[2] then return end
		cache.powerInfoIdSelected = callback[2]

		updatePowerMenu(playerName, tonumber(callback[3]), tonumber(callback[4]), cache)
		displayPowerInfo(playerName, cache)
	end
end

--[[ textAreaCallbacks/print.lua ]]--
do
	local urlFormat = "<BV>[<VI>•<BV>] https://"
	textAreaCallbacks["print"] = function(playerName, _, callback)
		-- print_{url}
		chatMessage(urlFormat .. callback[2], playerName)
	end
end

--[[ textAreaCallbacks/leaderboardLeft.lua ]]--
do
	textAreaCallbacks["leaderboardLeft"] = function(playerName, cache)
		-- leaderboardLeft
		cache.leaderboardPage = cache.leaderboardPage - 1
		if cache.leaderboardPage <= 0 then
			cache.leaderboardPage = leaderboard.total_pages
		end

		displayLeaderboard(playerName, cache, cache.lastPrettyUI)
	end
end

--[[ textAreaCallbacks/leaderboardRight.lua ]]--
do
	textAreaCallbacks["leaderboardRight"] = function(playerName, cache)
		-- leaderboardRight
		cache.leaderboardPage = cache.leaderboardPage + 1
		if cache.leaderboardPage > leaderboard.total_pages then
			cache.leaderboardPage = 1
		end

		displayLeaderboard(playerName, cache, cache.lastPrettyUI)
	end
end

--[[ keyboardCallbacks/H.lua ]]--
do
	keyboardCallbacks[keyboard.H] = function(playerName, cache)
		if cache.isHelpOpen then
			textAreaCallbacks["closeInterface"](playerName, cache)
		else
			displayHelp(playerName, cache)
		end
	end
end

--[[ keyboardCallbacks/O.lua ]]--
do
	keyboardCallbacks[keyboard.O] = function(playerName, cache)
		if cache.isPowersOpen then
			textAreaCallbacks["closeInterface"](playerName, cache)
		else
			displayPowerMenu(playerName, cache)
		end
	end
end

--[[ keyboardCallbacks/P.lua ]]--
do
	keyboardCallbacks[keyboard.P] = function(playerName, cache)
		if cache.isProfileOpen then
			textAreaCallbacks["closeInterface"](playerName, cache)
		else
			displayProfile(playerName, playerName, cache)
		end
	end
end

--[[ keyboardCallbacks/L.lua ]]--
do
	keyboardCallbacks[keyboard.L] = function(playerName, cache)
		if cache.isLeaderboardOpen then
			textAreaCallbacks["closeInterface"](playerName, cache)
		else
			displayLeaderboard(playerName, cache)
		end
	end
end

--[[ commands/help.lua ]]--
do
	commands["help"] = function(playerName)
		keyboardCallbacks[keyboard.H](playerName, playerCache[playerName])
	end
end

--[[ commands/powers.lua ]]--
do
	commands["powers"] = function(playerName)
		keyboardCallbacks[keyboard.O](playerName, playerCache[playerName])
	end
end

--[[ commands/profile.lua ]]--
do
	commands["profile"] = function(playerName, command)
		command[2] = command[2] and strToNickname(command[2]) or playerName
		if playerCache[command[2]] and
			not bannedPlayers[room.playerList[command[2]].id] then
			displayProfile(playerName, command[2], cache)
		end
	end
end

--[[ commands/leaderboard.lua ]]--
do
	commands["leaderboard"] = function(playerName)
		keyboardCallbacks[keyboard.L](playerName, playerCache[playerName])
	end
end

--[[ commands/roomAdmin/password.lua ]]--
do
	commands["pw"] = function(playerName, command)
		if not roomAdmins[playerName] then return end

		command = table_concat(command, ' ', 2)
		setRoomPassword(command)

		playerName = cache.chatNickname

		if command ~= '' then
			messageRoomAdmins(format(getText.setPassword, playerName, command))
		else -- no password
			messageRoomAdmins(format(getText.removePassword, playerName))
		end
	end
end

--[[ commands/mapReviewer/map.lua ]]--
do
	local subCommand = { }
	local subCommandPermission = { }

	local hasQueueChanged = false

	-- Manages the module maps
	commands["map"] = function(playerName, command)
		if totalCurrentMaps == 0 or not command[2] and dataFileContent[1] then return end

		if subCommand[command[2]] then
			local permission = subCommandPermission[command[2]]
			if not permission or hasPermission(playerName, permission) then
				subCommand[command[2]](playerName, command)
			end
		end
	end

	local getValidMaps = function(subParameter)
		local validMaps, totalMaps, tmpMapCode, tmpIsMapCode = { }, 0
		for i = 3, #subParameter do
			tmpIsMapCode, tmpMapCode = isMapCode(subParameter[i])
			if tmpIsMapCode then
				totalMaps = totalMaps + 1
				validMaps[totalMaps] = tmpMapCode
			end
		end

		return totalMaps > 0, validMaps, totalMaps
	end

	-- Adds a new map
	subCommandPermission["add"] = permissions.editLocalMapQueue
	subCommand["add"] = function(playerName, command)
		local hasMaps, validMaps, totalMaps = getValidMaps(command)
		if not hasMaps then return end

		local map
		for i = 1, totalMaps do
			map = validMaps[i]
			if not mapHashes[map] then
				totalCurrentMaps = totalCurrentMaps + 1
				maps[totalCurrentMaps] = map
				mapHashes[map] = true
				hasQueueChanged = true
				chatMessage(format(getText.addMap, map))
			end
		end
	end

	-- Removes a map
	subCommandPermission["rem"] = permissions.editLocalMapQueue
	subCommand["rem"] = function(playerName, command)
		local hasMaps, validMaps, totalMaps = getValidMaps(command)
		if not hasMaps then return end

		local map
		for i = 1, totalMaps do
			map = validMaps[i]
			if mapHashes[map] then
				for m = 1, totalCurrentMaps do
					if maps[m] == map then
						totalCurrentMaps = totalCurrentMaps - 1
						table_remove(maps, m)
						break
					end
				end

				mapHashes[map] = nil
				hasQueueChanged = true
				chatMessage(format(getText.remMap, map))
			end
		end
	end

	-- Displays the map queue
	subCommand["ls"] = function(playerName)
		chatMessage(format(getText.listMaps, totalCurrentMaps, "@" .. table_concat(maps, ", @")),
			playerName)
	end

	-- Saves the map queue
	subCommandPermission["save"] = permissions.saveLocalMapQueue
	subCommand["save"] = function(playerName)
		if not hasQueueChanged then return end
		hasQueueChanged = false
		buildAndSaveDataFile()
		subCommand["ls"](playerName)
	end
end

--[[ commands/mapReviewer/review.lua ]]--
do
	-- Enables/disables the review mode
	commands["review"] = function(playerName)
		if not hasPermission(playerName, permissions.enableReviewMode)
			or nextMapToLoad then return end -- Can't change state when !npp is pending

		isReviewMode = not isReviewMode
		if isReviewMode then
			chatMessage(getText.enableReviewMode)
		else
			chatMessage(getText.disableReviewMode)
		end
	end
end

--[[ commands/mapReviewer/np.lua ]]--
do
	-- Loads a new map for review
	commands["np"] = function(playerName, command)
		if not (command[2] and hasPermission(playerName, permissions.enableReviewMode)
			and isCurrentMapOnReviewMode) then return end

		newGame(command[2])
	end
end

--[[ commands/mapReviewer/npp.lua ]]--
do
	-- Schedules the next map for review
	commands["npp"] = function(playerName, command)
		if not (command[2] and hasPermission(playerName, permissions.enableReviewMode)
			and isReviewMode) then return end

		nextMapToLoad = command[2]
	end
end

--[[ commands/moderator/msg.lua ]]--
do
	local msgFormat = "<FC><B>[#powers]</B> "
	local internalMessageFormat = "<BL>[<VI>•<BL>] %s <BL>[%s] → %s"

	-- Sends an official message in the chat
	commands["msg"] = function(playerName, command)
		if not hasPermission(playerName, permissions.sendRoomMessage) then return end

		chatMessage(msgFormat .. table_concat(command, ' ', 2))

		messagePlayersWithPrivilege(format(internalMessageFormat,
			playerCache[playerName].chatNickname, command[1],
			table_concat(command, ' ', 2, min(#command, 5))))
	end
end

--[[ commands/moderator/ban.lua ]]--
do
	local moderatorColor = format("font color='#%x'", roleColors.moderator)

	-- Bans a player temporarily
	commands["ban"] = function(playerName, command, isPermanent)
		-- !ban name time? reason?
		if not (command[2] and hasPermission(playerName, permissions.banUser)
			and dataFileContent[2]) then return end

		local targetPlayerId, targetPlayer = validateNicknameAndGetID(command[2])
		if not targetPlayerId then return end

		players_lobby(targetPlayer)

		local banTime = command[3]
		if not isPermanent then
			banTime = clamp(tonumber(banTime) or 24, 1, 360)
		end
		bannedPlayers[targetPlayerId] = time() + banTime * 60 * 60 * 1000 -- banTime in hours

		local prettyTargetPlayer = prettifyNickname(targetPlayer, nil, nil, nil, "ROSE")
		local prettyPlayer = prettifyNickname(playerName, nil, nil, nil, moderatorColor)
		command = table_concat(command, ' ', 4)

		if not isPermanent then
			chatMessage(format(getText.ban, prettyTargetPlayer, prettyPlayer, banTime, command))
		else
			chatMessage(format(getText.permBan, prettyTargetPlayer, prettyPlayer, command))
		end

		buildAndSaveDataFile()
	end
end

--[[ commands/moderator/unban.lua ]]--
do
	local moderatorColor = format("font color='#%x'", roleColors.moderator)

	-- Unbans a player
	commands["unban"] = function(playerName, command)
		-- !unban name
		if not (command[2] and hasPermission(playerName, permissions.unbanUser)
			and dataFileContent[2]) then return end

		local targetPlayerId, targetPlayer = validateNicknameAndGetID(command[2])
		if not targetPlayerId then return end

		local time = bannedPlayers[targetPlayerId]
		if not time then return end

		-- Can't unban permbanned users unless they have permission to
		if time == 0 and not hasPermission(playerName, permissions.permBanUser) then
			return chatMessage(getText.cantPermUnban, playerName)
		end

		bannedPlayers[targetPlayerId] = nil
		chatMessage(format(getText.unban, prettifyNickname(playerName, nil, nil, nil,
			moderatorColor)), targetPlayer)

		buildAndSaveDataFile()
	end
end

--[[ commands/administrator/permban.lua ]]--
do
	-- Bans a player permanently
	commands["permban"] = function(playerName, command)
		-- !permban name reason?
		if not (command[2] and hasPermission(playerName, permissions.permBanUser)) then return end

		table_insert(command, 3, 0)
		commands["ban"](playerName, command, true)
	end
end

--[[ commands/administrator/promote.lua ]]--
do
	local internalMessageFormat = "<BL>[<VI>•<BL>] %s <BL>[%s] → %s"

	-- Adds specific permissions to a player
	commands["promote"] = function(playerName, command)
		-- !promote name permissions
		if not (command[3] and hasPermission(playerName, permissions.promoteUser)
			and dataFileContent[2]) then return end

		local targetPlayerId, targetPlayer = validateNicknameAndGetID(command[2])
		if not targetPlayerId then return end

		local prettyTargetPlayer = playerCache[targetPlayer].chatNickname

		messagePlayersWithPrivilege(format(internalMessageFormat,
			playerCache[playerName].chatNickname, command[1], table_concat(command, ' ', 2)))

		local saveDataFile = false

		local givenPermissions, permissionsCounter = { }, 0
		local rolePerm, perm, permAdded
		for p = 3, #command do
			p = command[p]

			rolePerm = rolePermissions[p]
			perm = rolePerm or permissions[p]

			if perm then
				permAdded = addPermission(playerName, perm, targetPlayerId)
				if permAdded then
					if rolePerm then
						saveDataFile = true
						chatMessage(format(getText.playerGetRole, prettyTargetPlayer, roleColors[p],
							upper(p)))
					else
						permissionsCounter = permissionsCounter + 1
						givenPermissions[permissionsCounter] = p
					end
				end
			end
		end

		if permissionsCounter > 0 then
			saveDataFile = true
			messagePlayersWithPrivilege(format(getText.playerGetPermissions, prettyTargetPlayer,
				table_concat(givenPermissions, "</B> - <B>")))
		end

		if saveDataFile then
			buildAndSaveDataFile()
		end
	end
end

--[[ commands/administrator/demote.lua ]]--
do
	local internalMessageFormat = "<BL>[<VI>•<BL>] %s <BL>[%s] → %s"

	-- Removes specific permissions from a player
	commands["demote"] = function(playerName, command)
		-- !demote name permissions
		if not (command[3] and hasPermission(playerName, permissions.demoteUser)
			and dataFileContent[2]) then return end

		local targetPlayerId, targetPlayer = validateNicknameAndGetID(command[2])
		if not targetPlayerId then return end

		local prettyTargetPlayer = playerCache[targetPlayer].chatNickname

		messagePlayersWithPrivilege(format(internalMessageFormat,
			playerCache[playerName].chatNickname, command[1], table_concat(command, ' ', 2)))

		local saveDataFile = false

		local removedPermissions, permissionsCounter = { }, 0
		local rolePerm, perm, permRemoved
		for p = 3, #command do
			p = command[p]

			rolePerm = rolePermissions[p]
			perm = rolePerm or permissions[p]

			if perm then
				permRemoved = removePermission(playerName, perm, targetPlayerId)
				if permRemoved then
					if rolePerm then
						saveDataFile = true
						chatMessage(format(getText.playerLoseRole, prettyTargetPlayer,
							roleColors[p], upper(p)))
					else
						permissionsCounter = permissionsCounter + 1
						removedPermissions[permissionsCounter] = p
					end
				end
			end
		end

		if permissionsCounter > 0 then
			saveDataFile = true
			messagePlayersWithPrivilege(format(getText.playerLosePermissions, prettyTargetPlayer,
				table_concat(removedPermissions, "</B> - <B>")))
		end

		if saveDataFile then
			buildAndSaveDataFile()
		end
	end
end

--[[ commands/administrator/givebadge.lua ]]--
do
	-- Gives a badge to someone
	commands["givebadge"] = function(playerName, command)
		if playerName ~= module.author then return end

		local _, targetPlayer = validateNicknameAndGetID(command[2])
		local cache = playerCache[targetPlayer]
		if not cache then return end

		giveBadge(targetPlayer, command[3], cache, true)
	end
end

--[[ commands/administrator/setdata.lua ]]--
do
	-- Sets the data of a player
	commands["setdata"] = function(playerName, command)
		if playerName ~= module.author then return end

		local _, targetPlayer = validateNicknameAndGetID(command[2])
		local targetData = playerData.playerData[targetPlayer]
		if not targetData then return end

		local dataStructure = playerData.structure

		targetData.rounds = tonumber(command[3]) or dataStructure.rounds.default
		targetData.victories = tonumber(command[4]) or dataStructure.victories.default
		targetData.kills = tonumber(command[5]) or dataStructure.kills.default
		targetData.xp = tonumber(command[6]) or dataStructure.xp.default

		playerData:save(targetPlayer, true)

		messagePlayersWithPrivilege(format(getText.resetData,
			playerCache[targetPlayer].chatNickname, targetData.rounds, targetData.victories,
			targetData.kills, targetData.xp))
	end
end

--[[ events/eventFileLoaded.lua ]]--
eventFileLoaded = function(id, data)
	if id == module.data_file then
		parseDataFile(data)
	elseif id == module.leaderboard_file then
		readLeaderboardData(data)
		writeLeaderboardData()
	end
end

--[[ events/eventFileSaved.lua ]]--
eventFileSaved = function(fileId)
	if fileId == module.data_file then
		isSaveDataFileScheduled = false
	elseif fileId == module.leaderboard_file then
		loadFile(fileId)
	end
end

--[[ events/eventNewPlayer.lua ]]--
eventNewPlayer = function(playerName)
	playerCache[playerName] = {
		-- Level and XP
		level = 1,
		currentLevelXp = nil,
		nextLevelXp = nil,
		roundLevel = nil, -- Level on round start
		levelIndex = nil, -- ex: 10, 20, 30
		levelColor = nil,

		-- Round life
		health = 0,
		extraHealth = 0, -- Health points that were accumulated and will be updated together

		-- Round powers
		powers = { }, -- All individual powers' data
		powerCooldown = 0,
		keySequence = KeySequence.new(),

		-- Round misc
		isFacingRight = true,
		soulMate = nil,

		lastDamageBy = nil,
		lastDamageTime = nil,

		-- General Interface
		isInterfaceOpen = false,

		totalPrettyUIs = 0,
		prettyUIs = { },
		lastPrettyUI = nil,

		interfaceActionCooldown = 0,

		-- Help interface
		isHelpOpen = false,
		helpPage = 1,
		helpTabs = { },
		commands = nil,

		-- Powers interface
		isPowersOpen = false,
		powerInfoIdSelected = nil,
		powerInfoSelectionImageId = nil,

		-- Profile interface
		isProfileOpen = false,
		badges = nil,

		-- Leaderboard interface
		isLeaderboardOpen = false,
		leaderboardPage = 1,

		-- Misc
		chatNickname = prettifyNickname(playerName, 10, nil, "/B><G", 'B')
	}

	players_insert("lobby", playerName)

	chatMessage(getText.greeting, playerName)

	local isValid, isBanned, playerId = isValidPlayer(playerName)
	if not isValid then
		if isBanned then
			warnBanMessage(playerName, isBanned)
		end
		return
	end

	if totalCurrentMaps > 0 then -- File already loaded
		playerCache[playerName].commands = generateCommandHelp(playerId, playerName)
		keyboardCallbacks[keyboard.H](playerName, playerCache[playerName])
	end

	if isReviewMode then
		chatMessage(getText.enableReviewMode, playerName)
	end

	lowerSyncDelay(playerName)

	-- May bind duplicates
	for _, power in next, powers do
		if power.bindControl then
			power:bindControl(playerName)
		end
	end
	for _, key in next, keyboard do
		bindKeyboard(playerName, key, true, true)
	end

	loadPlayerData(playerName)

	-- Displayed once because the image is never removed
	displayLifeBar(playerName)
end

--[[ events/eventPlayerDataLoaded.lua ]]--
eventPlayerDataLoaded = function(playerName, data)
	playerData:newPlayer(playerName, data)

	local cache = playerCache[playerName]
	setPlayerLevel(playerName, cache)

	generateBadgesList(playerName, cache)

	players_remove("lobby", playerName)
	players_insert("room", playerName)
end

--[[ events/eventPlayerLeft.lua ]]--
eventPlayerLeft = function(playerName)
	players_remove_all(playerName)
	playerCache[playerName] = nil
end

--[[ events/eventTextAreaCallback.lua ]]--
eventTextAreaCallback = function(id, playerName, callback)
	local cache = playerCanTriggerCallback(playerName)
	if not cache then return end

	callback = str_split(callback, '_', true)

	local cbkTrigger = textAreaCallbacks[callback[1]]
	return cbkTrigger and cbkTrigger(playerName, cache, callback)
end

--[[ events/eventNewGame.lua ]]--
eventNewGame = function()
	-- Resets players
	players.dead = { }
	players._count.dead = 0
	players.currentRound = table_copy(players.room)
	players._count.currentRound = players._count.room
	players.alive = table_copy(players.room)
	players._count.alive = players._count.room

	nextMapLoadTentatives = 0
	hasTriggeredRoundEnd = false
	isCurrentMapOnReviewMode = isReviewMode
	minPlayersForNextRound = ((isReviewMode or players._count.currentRound <= 1) and 0 or 1)
	nextMapToLoad = nil

	if currentMap == 0 then return end

	setNextMapIndex()

	timer:start(enablePowersTrigger, 6000, 1)

	-- Resets powers
	for name, obj in next, powers do
		if obj.type == powerType.divine then
			obj:reset()
		end
	end

	-- Resets players
	for playerName in next, players.lobby do
		killPlayer(playerName)
	end

	local currentTime, cache, playerPowers = time()
	for playerName in next, players.alive do
		cache = playerCache[playerName]
		cache.health = 100
		cache.isFacingRight = not room.mirroredMap
		cache.extraHealth = 0
		cache.powerCooldown = 0
		cache.soulMate = nil
		cache.roundLevel = cache.level
		cache.lastDamageBy = nil
		cache.lastDamageTime = nil

		updateLifeBar(playerName, cache)

		playerPowers = cache.powers
		cache = cache.level

		for name, obj in next, powers do
			-- Resets individual powers settings
			playerPowers[name] = obj:getNewPlayerData(cache, currentTime)
		end
	end

	canSaveData = (isOfficialRoom and room.uniquePlayers >= module.min_players
		and not isReviewMode)
	-- Adds extra XP
	if canSaveData then
		timer:start(giveExperience, module.extra_xp_in_round_seconds, 1)
	end
end

--[[ events/eventRoundEnded.lua ]]--
eventRoundEnded = function()
	hasTriggeredRoundEnd = true
	canTriggerPowers = false

	-- Clears all current timers
	timer.refresh()

	if currentMap == 0 then return end

	-- Resets divine powers
	removeTextArea(textAreaId.gravitationalAnomaly)

	local alivePlayers = players.alive
	local winners, winnerCount, winnerName = { }, 0

	local cache
	for playerName in next, players.currentRound do
		-- Only players that played in this round
		cache = playerCache[playerName]
		if cache then
			if resetPlayersDefaultSize then
				changePlayerSize(playerName, 1)
			end

			if cache.soulMate then
				linkMice(name, cache.soulMate, false)
			end

			if alivePlayers[playerName] then
				winnerCount = winnerCount + 1
				winners[winnerCount] = cache.chatNickname
				winnerName = playerName

				-- Ties won't give XP anymore.
				playerData:set(playerName, "victories", 1, true)

				giveCheese(playerName)
				playerVictory(playerName)
			end
			playerData
				:set(playerName, "rounds", 1, true)
				:save(playerName)

			-- Checks player level
			checkPlayerLevel(playerName, cache)
		end
	end
	resetPlayersDefaultSize = false

	-- Announce winner
	if winnerCount > 0 then
		chatMessage(format(getText.mentionWinner, table_concat(winners, "<FC>, ")))

		if winnerCount == 1 then -- Only rounds with one winner give XP
			playerData
				:set(winnerName, "xp", module.xp_on_victory, true)
				:save(winnerName)
		end
	else
		chatMessage(getText.noWinner)
	end
end

--[[ events/eventLoop.lua ]]--
eventLoop = function(currentTime, remainingTime)
	unrefreshableTimer:loop()
	if remainingTime < 500 or players._count.alive <= minPlayersForNextRound then
		if not hasTriggeredRoundEnd then
			eventRoundEnded()
		end
		return nextMap()
	end
	timer:loop()
end

--[[ events/eventPlayerDied.lua ]]--
eventPlayerDied = function(playerName)
	if players.lobby[playerName] then return end

	players_remove("alive", playerName)
	players_insert("dead", playerName)
	removeLifeBar(playerName)

	if players._count.alive <= 1 then
		setGameTime(0)
	end

	local cache = playerCache[playerName]
	if cache and cache.lastDamageBy then
		if cache.lastDamageTime > time() then
			givePlayerKill(cache.lastDamageBy, playerName, cache)
			playerData:save(cache.lastDamageBy)
		else
			cache.lastDamageBy = nil
			cache.lastDamageTime = nil
		end
	end
end

--[[ events/eventPlayerRespawn.lua ]]--
eventPlayerRespawn = function(playerName)
	players_remove("dead", playerName)
	players_insert("alive", playerName)
end

--[[ events/eventKeyboard.lua ]]--
eventKeyboard = function(playerName, key, isDown, x, y)
	local cache = playerCache[playerName]

	if key == 0 then
		cache.isFacingRight = false
	elseif key == 2 then
		cache.isFacingRight = true
	elseif keyboardCallbacks[key] then
		if playerCanTriggerCallback(playerName, cache) then
			keyboardCallbacks[key](playerName, cache)
		end
		return
	end

	local time = playerCanTriggerEvent(playerName, cache)
	if not time then return end

	local playerKs = cache.keySequence
	playerKs:insert(key)

	local playerPowers = cache.powers

	local matchCombo = false
	local src = Power.__keyboard
	for power = 1, Power.__eventCount.__keyboard do
		power = src[power]
		if playerPowers[power.name] then
			-- Not internal, must be explicit
			if power.triggererKey then
				matchCombo = (key == power.triggererKey)
			else
				local powerKs = power.keySequences
				for ks = 1, power.totalKeySequences do
					if playerKs:isEqual(powerKs[ks]) then
						matchCombo = true
						break
					end
				end
			end

			if matchCombo then
				return power:trigger(playerName, cache, time, x, y)
			end
		end
	end
end

--[[ events/eventMouse.lua ]]--
eventMouse = function(playerName, x, y)
	local time, cache = playerCanTriggerEvent(playerName)
	if not time then return end

	local playerX, playerY = room.playerList[playerName]
	playerX, playerY = playerX.x, playerX.y

	local playerPowers = cache.powers

	local src = Power.__mouse
	for power = 1, Power.__eventCount.__mouse do
		power = src[power]

		-- Not internal, must be explicit
		if playerPowers[power.name] and pythagoras(playerX, playerY, x, y, power.clickRange)
			and power:trigger(playerName, cache, time, x, y) then
			return
		end
	end
end

--[[ events/eventChatMessage.lua ]]--
eventChatMessage = function(playerName, message)
	local time, cache = playerCanTriggerEvent(playerName)
	if not time then return end

	local playerPowers = cache.powers

	local src = Power.__chatMessage
	for power = 1, Power.__eventCount.__chatMessage do
		power = src[power]

		-- Not internal, must be explicit
		if playerPowers[power.name] and find(message, power.messagePattern) then
			return power:trigger(playerName, cache, time)
		end
	end
end

--[[ events/eventEmotePlayed.lua ]]--
eventEmotePlayed = function(playerName, id)
	local time, cache = playerCanTriggerEvent(playerName)
	if not time then return end

	local playerX, playerY = room.playerList[playerName]
	playerX, playerY = playerX.x, playerX.y

	local playerPowers = cache.powers

	local src = Power.__emotePlayed
	for power = 1, Power.__eventCount.__emotePlayed do
		power = src[power]

		-- Not internal, must be explicit
		if playerPowers[power.name] and id == power.triggererEmote
			and power:checkTriggerPossibility()
			and power:trigger(playerName, cache, time, playerX, playerY) then
			return
		end
	end
end

--[[ events/eventChatCommand.lua ]]--
eventChatCommand = function(playerName, command)
	command = str_split(command, ' ', true)

	local cmdTrigger = commands[lower(command[1])]
	if cmdTrigger then
		return cmdTrigger(playerName, command)
	end
end

--[[ roomAdmins.lua ]]--
if isOfficialRoom then
	local _, roomQuery = find(room.name, "^%*?.?.?%-?#powers%d+()")
	if roomQuery then
		roomQuery = sub(room.name, roomQuery)

		for playerName in gmatch(roomQuery, "%+?%a[%w_][%w_][%w_]*#%d%d%d%d") do
			roomAdmins[strToNickname(playerName)] = true
		end
	end
end

--[[ init.lua ]]--
playersWithPrivileges[module.author_id] = rolePermissions.administrator

flagCodesSet = table_set(flagCodes)

loadFile(module.data_file) -- Maps, banned players, players with privilege, etc
loadFile(module.leaderboard_file)

module.max_player_xp = lvlToXp(module.max_player_level)

for playerName in next, room.playerList do
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

setRoomPassword('') -- Disables PW if it is enabled by glitch
tfm.exec.setRoomMaxPlayers(module.max_players)

math.randomseed(time())