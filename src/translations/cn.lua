-- Translated by Wrfg#0000
translations.cn = {
	greeting = "<FC>歡迎來到 <B>#powers</B>!\n" ..
		"\t• 按 <B>H鍵</B> 或輸入 <B>!help</B> 了解更多關於這小遊戲的資訊。\n" ..
		"\t• 按 <B>O鍵</B> 或輸入 <B>!powers</B> 了解更多關於能力的資訊。",
	kill = "<R>%s<FC> 殺死了 %s",

	mentionWinner = "<FC>%s<FC> 勝出了回合!",
	noWinner = "<FC>這回合沒有人勝出。 :(",

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
	powerType = {
		atk = "攻擊 (%d)",
		def = "防禦",
		divine = "神聖"
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
		[110] = { "死亡神", "死亡女神" },
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
		[4] = { "<FC><p align='center'>新鮮事?</p><N>\n",
			"• 小遊戲被重新打造。",
			"• 小遊戲變成官方小遊戲了。",
			"• 現在你可以查看所有能力了。",
		}
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