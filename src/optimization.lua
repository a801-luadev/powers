-- Transformice
local bindMouse    = system.bindMouse
local bindKeyboard = system.bindKeyboard

local addShamanObject  = tfm.exec.addShamanObject
local changePlayerSize = tfm.exec.changePlayerSize
local displayParticle  = tfm.exec.displayParticle
local explosion        = tfm.exec.explosion
local killPlayer       = tfm.exec.killPlayer
local linkMice         = tfm.exec.linkMice
local movePlayer       = tfm.exec.movePlayer
local removeObject     = tfm.exec.removeObject
local respawnPlayer    = tfm.exec.respawnPlayer
local setPlayerScore   = tfm.exec.setPlayerScore

local addTextArea    = ui.addTextArea
local removeTextArea = ui.removeTextArea
local addImage       = tfm.exec.addImage
local removeImage    = tfm.exec.removeImage

local lowerSyncDelay = tfm.exec.lowerSyncDelay

local chatMessage    = tfm.exec.chatMessage
local newGame        = tfm.exec.newGame

local saveFile       = system.saveFile
local savePlayerData = system.savePlayerData

-- Mathematics
local cos    = math.cos
local rad    = math.rad
local random = math.random
local sin    = math.sin

-- String
local byte   = string.byte
local find   = string.find
local format = string.format
local gmatch = string.gmatch
local gsub   = string.gsub
local match  = string.match
local sub    = string.sub

-- Table
local table_concat = table.concat
local table_remove = table.remove

-- Others
local next         = next
local rawset       = rawset
local setmetatable = setmetatable
local time         = os.time
local tonumber     = tonumber
local type         = type
local unpack       = table.unpack