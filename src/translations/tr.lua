-- Translated by Bisharch#4886
translations.tr = {
	greeting = "<FC><B>#powers</B> modülüne hoş geldiniz!\n" ..
		"\t• Modül hakkında bilgi almak için <B>H</B> tuşuna basabilir ya da sohbete <B>!help</B> yazabilirsiniz.\n" ..
		"\t• Güçler hakkında bilgi almak için <B>O</B> tuşuna basabilir ya da sohbete <B>!powers</B> yazabilirsiniz.",
	kill = "<R>%s<FC>, %s adlı fareyi öldürdü.",

	mentionWinner = "<FC>%s<FC> raundu kazandı!",
	noWinner = "<FC>Kimse raundu kazanamadı. :(",

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
		[4] = { "<FC><p align='center'>HABERLER</p><N>\n" ..
			"• Modülümüz baştan sona tekrar yazıldı.",
			"• Modülümüz artık resmî.",
			"• Artık oyundaki tüm güçler hakkında bilgi sahibi olabilirsiniz.",
		}
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