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
local band = bit32.band
local bor  = bit32.bor
local bnot = bit32.bnot

-- OS
local date = os.date
local time = os.time

-- Others
local next         = next
local setmetatable = setmetatable
local tonumber     = tonumber
local type         = type
local unpack       = table.unpack