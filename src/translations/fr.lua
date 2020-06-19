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
			"• Vous pouvez lire à propos des pouvoirs maintenant.\n" ..
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