-- Transformice
local bindMouse    = system.bindMouse -- low usage (1x on new player)
local bindKeyboard = system.bindKeyboard -- low usage (1x on new player)

local addShamanObject  = tfm.exec.addShamanObject -- low-to-medium usage (2 powers)
local changePlayerSize = tfm.exec.changePlayerSize -- low-to-medium usage (1 power)
local displayParticle  = tfm.exec.displayParticle -- high usage
local explosion        = tfm.exec.explosion -- high usage
local freezePlayer     = tfm.exec.freezePlayer -- low usage (1 power x alive players)
local giveCheese       = tfm.exec.giveCheese -- low usage (1x map x alive players)
local killPlayer       = tfm.exec.killPlayer -- medium usage
local linkMice         = tfm.exec.linkMice -- low usage (1 power)
local movePlayer       = tfm.exec.movePlayer -- high usage
local playerVictory    = tfm.exec.playerVictory -- low usage (1x map x alive players)
local removeCheese     = tfm.exec.removeCheese -- low-to-medium usage
local removeObject     = tfm.exec.removeObject -- low-to-medium usage (2 powers)
local respawnPlayer    = tfm.exec.respawnPlayer -- low usage (1 power)
local setGameTime      = tfm.exec.setGameTime -- low usage
local setWorldGravity  = tfm.exec.setWorldGravity -- low usage

local addBonus       = tfm.exec.addBonus -- low usage (1 power on players death)
local addImage       = tfm.exec.addImage -- high usage
local addTextArea    = ui.addTextArea -- high usage
local removeImage    = tfm.exec.removeImage -- high usage
local removeTextArea = ui.removeTextArea -- high usage
local updateTextArea = ui.updateTextArea -- low-to-medium usage

local lowerSyncDelay  = tfm.exec.lowerSyncDelay -- low usage (1x on new player)
local setRoomPassword = tfm.exec.setRoomPassword -- low usage

local chatMessage    = tfm.exec.chatMessage -- high usage
local newGame        = tfm.exec.newGame -- low usage

local loadFile       = system.loadFile -- low-to-medium usage
local loadPlayerData = system.loadPlayerData -- low usage
local saveFile       = system.saveFile -- low-to-medium usage
local savePlayerData = system.savePlayerData -- high usage

local room = tfm.get.room -- high usage

-- Enums
local enum_emote        = tfm.enum.emote -- low usage

-- Mathematics
local ceil   = math.ceil -- low-to-medium usage
local cos    = math.cos -- high usage
local max    = math.max -- low-to-medium usage
local min    = math.min -- low-to-medium usage
local rad    = math.rad -- high usage
local random = math.random -- high usage
local sin    = math.sin -- high usage
local pi     = math.pi -- high usage

-- String
local byte   = string.byte -- low usage
local find   = string.find -- medium usage (on chatmessage)
local format = string.format -- medium-to-high usage
local gmatch = string.gmatch -- low-to-medium usage
local gsub   = string.gsub -- medium usage
local lower  = string.lower -- low usage
local match  = string.match -- low usage
local rep    = string.rep -- low-to-medium usage (clickable images)
local sub    = string.sub -- low-to-medium usage
local upper  = string.upper -- low usage

-- Table
local table_concat = table.concat -- high usage
local table_insert = table.insert -- low usage
local table_remove = table.remove -- low usage
local table_sort   = table.sort -- low-to-medium usage

-- Bit32
local band = bit32.band -- medium usage (including permissions)
local bor  = bit32.bor -- medium usage (including permissions)
local bnot = bit32.bnot -- low usage (remove permissions)

-- OS
local date = os.date -- low usage
local time = os.time -- high usage

-- Others
local next         = next -- high usage
local setmetatable = setmetatable -- low-to-medium usage
local tonumber     = tonumber -- low-to-medium usage
local type         = type -- medium usage (includes dump data)
local unpack       = table.unpack -- high usage (timer)