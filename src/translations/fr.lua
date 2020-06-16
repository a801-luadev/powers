-- Translated by Jaker#9310
translations.fr = {
	greeting = "<FC>Bienvenue dans <B>#powers</B> ! Appuyez sur <B>H</B> ou écrivez <B>!help</B> pour en apprendre plus.",

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

	unlockPower = "<FC>[<J>•<FC>] Vous avez débloqué les pouvoirs suivant(s): %s",

	levelName = {
		[000] = "Mutant",
		[010] = "Nécromancien",
		[020] = "Scientifique",
		[030] = "Titan",
		[040] = { "Sorcier", "Sorcière" },
		[050] = "Contrôleur de Réalité",
		[060] = { "Seigneur des Enchantements", "Maîtresse des Enchantements" },
		[070] = "Invocateur Chaman",
		[080] = "Le Chevalier de la Peste",
		[090] = "Le Chevalier de la Famine",
		[100] = "Le Chevalier de Guerre",
		[110] = "Le Chevalier Mort",
		[120] = "Le Vide"
	},

	newLevel = "<FC>%s<FC> a atteint le niveau <B>%d</B>!",
	level = "Niveau %d",

	helpTitles = {
		[1] = "Pouvoirs !",
		[2] = "Commandes",
		[3] = "Contribuer",
		[4] = "Quoi d'neuf ?"
	},
	helpContent = {
		[1] = "<FC><p align='center'>#POWERS!</p>\n\n" ..
			"<J>Le but dans ce module est de survivre contre les attaques ennemies.\n\n" ..
			"<N>Il y a une variété de pouvoirs <font size='12'>- qui sont obtenus en atteignant " ..
				"de plus hauts niveaux -</font> pour attaquer et défendre.\n" ..
			"Ecrivez <FC><B>!powers</B><N> pour en savoir plus à propos des pouvoirs que vous " ..
				"avez obtenu depuis !\n\n" ..
			"%s\n\n" ..
			"Ce module a été développé par %s"
		,
		[2] = "<FC><p align='center'>COMMANDES</p><N>\n\n<font size='12'>",
		[3] = "<FC><p align='center'>CONTRIBUER<N>\n\n" ..
			"Nous adorons ouvrir les sources <font color='#E91E63'>♥</font> ! Vous pouvez voir " ..
				"et modifier le code de source de ce module sur <a href='event:print_" ..
				"github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"Maintenir le module est strictement volontaire, donc n'importe quel aide à propos " ..
				"<V>du Code<N>, <V>de la réparation de bugs, des signalements<N>, <V>des " ..
				"suggestions ou des renforcements de fonctionnalités<N>, <V>de la réalisation " ..
				"de carte <N>est la bienvenue et très apprécié.\n" ..
			"<p align='left'>• Vous pouvez <FC>signaler des bugs <N>ou <FC>faire des suggestions" ..
			" <N>sur <a href='event:print_discord.gg/quch83R'><font color='#087ECC'>" ..
				"Discord</font></a> and/ou sur <a href='event:print_" ..
				"github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• Vous pouvez <FC>proposer vos cartes <N>dans notre <a href='event:print_" ..
				"atelier801.com/topic?f=5&t=918371'><font color='#087ECC'>Map Submissions " ..
				"Sujet dans le Forum</font></a>.\n\n" ..
			"<p align='center'>Vous pouvez aussi <FC>donner</FC> n'importe quel somme d'argent " ..
				"<a href='event:print_a801-luadev.github.io/?redirect=powers'>" ..
				"<font color='#087ECC'>ici</font></a> pour aider à maintenir le module. Tous les" ..
				" fonts obtenus à travers ce lien seront utilisés dans les mise à jours et " ..
				"l'amélioration.</p>"
		,
		[4] = "<FC><p align='center'>QUOI D'NEUF ?</p><N>\n\n" ..
			"• Le module est devenu officiel.\n" ..
			"• Le module a été complétement ré-écrit."
	},

	commandDescriptions = {
		help = "Ouvre ce menu.",
		powers = "Ouvre un menu avec tous les pouvoirs et leurs infos.",
		profile = "Ouvre votre profile ou celui de quelqu'un d'autre.",
		leaderboard = "Ouvre le classement global.",

		pw = "Instaure un mot de passe pour le salon. Ne pas écrire de mot de passe pour le " ..
			"désactiver.",

		mapEditQueue = "Gère la rotation de cartes du jeu.",
		mapSaveQueue = "Sauvegarde la rotation de cartes du jeu.",
		review = "Active le mode vérification.",
		np = "Charge une nouvelle carte.",
		npp = "Planifie la prochaine carte à charger.",

		msg = "Envoie un message au salon.",
		ban = "Banni un joueur du jeu.",
		unban = "Retire le bannissement un joueur du jeu.",
		permban = "Banni un joueur définitivement du jeu.",

		promote = "Embaucher un joueur en lui donnant un rôle spécifique ou en lui donnant des " ..
			"permissions spécifiques.",
		demote = "Désembaucher un joueur d'un rôle spécifique ou lui retirer des permissions " ..
			"spécifiques ."
	},
	commandsParameters = {
		profile = "[nom_d'un_joueur] ",

		pw = "[password] ",

		mapEditQueue = "[add|rem]<R>*</R> [@carte ...]<R>*</R> ",
		mapSaveQueue = "[save]<R>*</R> ",
		np = "[@carte]<R>*</R> ",
		npp = "[@carte]<R>*</R> ",

		msg = "[message]<R>*</R> ",
		ban = "[nom_d'un_joueur]<R>*</R> [temps_de_bannissement] [raison] ",
		unban = "[nom_d'un_joueur]<R>*</R> ",

		permban = "[nom_d'un_joueur]<R>*</R> [raison] ",
		promote = "[nom_d'un_joueur]<R>*</R> [nom_de_permission|nom_de_rôle...]<R>*</R> ",
		demote = "[nom_d'un_joueur]<R>*</R> [nom_de_permission|nom_de_rôle...]<R>*</R> "
	},
	["or"] = "ou",

	profileData = {
		rounds = "Manches",
		victories = "Victoires",
		kills = "Tués",
		xp = "Experience",
		badges = "Badges"
	},

	leaderboard = "Classement",
	leaderboardIsLoading = "<BL>[<VI>•<BL>] Le classement est toujours en train de cahrger. " ..
		"Ré-essayez dans quelques secondes.",

	addMap = "<BV>[<FC>•<BV>] La carte <J>@%s</J> a été ajoutée dans la liste des cartes locales.",
	remMap = "<BV>[<FC>•<BV>] The map <J>@%s</J> a été retirée de la liste des cartes locales.",
	listMaps = "<BV>[<FC>•<BV>] Cartes (<J>#%d</J>): %s",

	enableParticles = "<ROSE>DN'OUBLIEZ PAS D'ACTIVER les effets/particules spéciales pour " ..
		"voir le jeu normalement. (Dans 'Menu' → 'Options', à côté de 'Liste de salon')</ROSE>",

	ban = "%s <ROSE>has been banned from #powers by %s <ROSE>for %d hours. Reason: %s",
	unban = "<ROSE>You have been unbanned by %s",
	isBanned = "<ROSE>You are banned from #powers until GMT+2 %s (%d hours to go).",
	permBan = "%s <ROSE>has been banned permanently from #powers by %s<ROSE>. Reason: %s",
	cantPermUnban = "<BL>[<VI>•<BL>] You cannot unban a user that is banned permanently.",

	playerGetPermissions = "<BL>[<VI>•<BL>] %s <BL>has now the following permissions: <B>%s</B>",
	playerLosePermissions = "<BL>[<VI>•<BL>] %s <BL>had the following permissions removed: " ..
		"<B>%s</B>",
	playerGetRole = "<FC>%s <FC>ha été promu(e) vers <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>n'est plus <font color='#%x'>%s</font>.",

	enableReviewMode = "<BV>[<FC>•<BV>] Le <FC>Mode de vérification de cartes<BV> est activé. " ..
		"Les prochaines manches ne sauvegarderont <B>pas</B> les statistiques et les cartes qui " ..
		"apparaissent sont en test pour la rotation de cartes du module. Tous les pouvoirs sont " ..
		"activés et les pouvoirs divins peuvent arriver !",
	disableReviewMode = "<BV>[<FC>•<BV>] Le <FC>Mode de vérification de cartes<BV> a été " ..
		"désactivé donc tout redeviendra normal à la prochaine manche !",

	getBadge = "<FC>%s<FC> vient juste de débloquer un nouveau badge de #powers !",

	setPassword = "<BL>[<VI>•<BL>] %s <BL>a instauré le mot de passe %q.",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>a retiré le mot de passe du salon."
}