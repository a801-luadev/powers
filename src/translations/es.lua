-- Translated by Tocutoeltuco#0000
translations.es = {
	greeting = "<FC>¡Bienvenido a <B>#powers</B>!\n" ..
		"\t• Presiona <B>H</B> o escribe <B>!help</B> para saber más sobre el módulo.\n" ..
		"\t• Presiona <B>O</B> o escribe <B>!powers</B> para saber más sobre los poderes.",

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
		atk = "ATQ (%d)"
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
			"<N>Hay una variedad de poderes <font size='12'>- los cuales se desbloquean " ..
				"alcanzando niveles más altos -</font> para atacar y defenderte.\n" ..
			"Escribe <FC><B>!powers</B><N> para saber más sobre los poderes que desbloqueaste!" ..
				"\n\n" ..
			"%s\n\n" ..
			"Este módulo fue desarrollado por %s"
		,
		[2] = "<FC><p align='center'>COMANDOS GENERALES</p><N>\n\n<font size='12'>",
		[3] = "<FC><p align='center'>CONTRIBUIR<N>\n\n" ..
			"¡Nos encanta el Código Abierto <font color='#E91E63'>♥</font>! Puedes ver y " ..
				"modificar el código de este módulo en <a href='event:print_" ..
				"github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"Mantener el módulo es estrictamente voluntaio, por lo que cualquier ayuda con " ..
				"respecto al <V>código<N>, <V>corrección y reporte de bugs<N>, <V>sugerencias " ..
				"y mejoras<N>, <V>creación de mapas <N>es bienvenida y apreciada.\n" ..
			"<p align='left'>• Puedes <FC>reportar bugs <N>o <FC>sugerir <N>en " ..
				"<a href='event:print_discord.gg/quch83R'><font color='#087ECC'>" ..
				"Discord</font></a> y/o en <a href='event:print_" ..
				"github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• Puedes <FC>enviar mapas <N>en nusetro <a href='event:print_" ..
				"atelier801.com/topic?f=6&t=888677'><font color='#087ECC'>Hilo de Envíos de " ..
				"Mapas en los Foros</font></a>.\n\n" ..
			"<p align='center'>También podes <FC>donar</FC> cualquier cantidad " ..
				"<a href='event:print_a801-luadev.github.io/?redirect=powers'>" ..
				"<font color='#087ECC'>aquí</font></a> para ayudar el mantenimiento del módulo. " ..
				"Todas las donaciones obtenidas a través del link serán invertidas en " ..
				"actualizaciones y mejoras constantes del módulo.\n\n" ..
			"<a href='event:print_atelier801.com/topic?f=6&t=888676'>" ..
				"<font size='18' color='#087ECC'>Hilo en los Foros</font></a></p>"
		,
		[4] = "<FC><p align='center'>¿QUÉ HAY DE NUEVO?</p><N>\n\n" ..
			"• El módulo se volvió oficial.\n" ..
			"• El módulo ha sido completamente reescrito."
	},

	commandDescriptions = {
		help = "Abre este menú.",
		powers = "Abre un menú que muestra todos los poderes y su información.",
		profile = "Abre tu perfil o el de alguien más.",
		leaderboard = "Abre el ranking global.",

		pw = "Proteje la sala con una contraseña. El comando sin argumentos la quita.",

		mapEditQueue = "Gestiona la rotación de mapas del juego.",
		mapSaveQueue = "Guarda la rotación de mapas del juego.",
		review = "Activa el modo de revisión.",
		np = "Carga un mapa.",
		npp = "Carga el siguiente mapa cuando este termine.",

		msg = "Envia un mensaje a la sala.",
		ban = "Banea un jugador del juego.",
		unban = "Desbanea un jugador del juego.",
		permban = "Banea un jugador del juego permanentemente.",

		promote = "Promueve un jugador a un rango específico o le da permisos específicos.",
		demote = "Degrada un jugador de un rango específico o le quita permisos específicos."
	},
	commandsParameters = {
		profile = "[jugador] ",

		pw = "[contraseña] ",

		mapEditQueue = "[add|rem]<R>*</R> [@mapa ...]<R>*</R> ",
		mapSaveQueue = "[save]<R>*</R> ",
		np = "[@mapa]<R>*</R> ",
		npp = "[@mapa]<R>*</R> ",

		msg = "[mensaje]<R>*</R> ",
		ban = "[jugador]<R>*</R> [tiempo] [razón] ",
		unban = "[jugador]<R>*</R> ",

		permban = "[jugador]<R>*</R> [razón] ",
		promote = "[jugador]<R>*</R> [permiso|rango ...]<R>*</R> ",
		demote = "[jugador]<R>*</R> [permiso|rango ...]<R>*</R> "
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
	leaderboardIsLoading = "<BL>[<VI>•<BL>] El ranking aún se está cargando. Prueba de nuevo " ..
		"en unos segundos.",

	addMap = "<BV>[<FC>•<BV>] El mapa <J>@%s</J> fue añadido a la rotación de mapas local.",
	remMap = "<BV>[<FC>•<BV>] El mapa <J>@%s</J> fue quitado de la rotación de mapas local.",
	listMaps = "<BV>[<FC>•<BV>] Mapas (<J>#%s</J>): %s",

	enableParticles = "<ROSE>No olvides de ACTIVAR los efectos epeciales/partículas para poder  " ..
		"ver el juego correctamente. (En 'Menú' → 'Opciones', cerca de 'Lista de Salas')</ROSE>",

	ban = "%s <ROSE>fue baneado de #powers por %s <ROSE>por %d horas. Razón: %s",
	unban = "<ROSE>Fuiste desbaneado por %s",
	isBanned = "<ROSE>Fuiste baneado de #powers hasta %s GMT+2 (%d horas restantes).",
	permBan = "%s <ROSE>fue baneado permanentemente de #powers por %s<ROSE>. Razón: %s",
	cantPermUnban = "<BL>[<VI>•<BL>] No puedes desbanear un usuario que fue baneado permanentemente.",

	playerGetPermissions = "<BL>[<VI>•<BL>] %s <BL>ahora tiene los siguientes permisos: <B>%s</B>",
	playerLosePermissions = "<BL>[<VI>•<BL>] %s <BL>perdió los siguientes permisos: " ..
		"<B>%s</B>",
	playerGetRole = "<FC>%s <FC>fue promovido a <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>ya no es un <font color='#%x'>%s</font>.",

	enableReviewMode = "<BV>[<FC>•<BV>] El <FC>Modo de Revisión de Mapas<BV> fue activado. " ..
		"Las siguientes rondas <B>no</B> contarán estadísticas y los mapas que aparezcan están " ..
		"siendo probados para la rotación de mapas del módulo. Todos los poderes fueron " ..
		"activados y poderes divinos son más probables!",
	disableReviewMode = "<BV>[<FC>•<BV>] El <FC>Modo de Revisión de Mapas<BV> fue desactivado y " ..
		"todo volverá a la normalidad en la siguiente ronda!",

	getBadge = "<FC>%s<FC> desbloqueó una insignia de #powers!",

	setPassword = "<BL>[<VI>•<BL>] %s <BL>cambió la contraseña a %q.",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>quitó la contraseña de la sala."
}