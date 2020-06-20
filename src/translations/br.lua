-- Translated by Natsmiro#0000
translations.br = {
	greeting = "<FC>Bem-vindo ao <B>#powers</B>!\n" ..
		"\t• Pressione <B>H</B> ou digite <B>!help</B> para saber mais sobre o module.\n" ..
		"\t• Pressione <B>O</B> ou digite <B>!powers</B> para saber mais sobre os poderes.",
	kill = "<R>%s<FC> matou %s",

	mentionWinner = "<FC>%s<FC> venceu a rodada!",
	noWinner = "<FC>Ninguém venceu a rodada. :(",

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
		dayOfJudgement = "Dia do Julgamento",
		waterSplash = "Bomba d'água"
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
		dayOfJudgement = "Revive todos os inimigos mortos, todos presos uns aos outros.",
		waterSplash = "Invoca algumas gotas d'água da Antártica."
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
			"• Novo poder <B>Bomba d'água</B>.\n" ..
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