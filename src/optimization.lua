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

local addTextArea    = ui.addTextArea
local removeTextArea = ui.removeTextArea
local addImage       = tfm.exec.addImage
local removeImage    = tfm.exec.removeImage

local lowerSyncDelay = tfm.exec.lowerSyncDelay

local chatMessage    = tfm.exec.chatMessage
local newGame        = tfm.exec.newGame

local saveFile = system.saveFile

-- Mathematics
local cos    = math.cos
local rad    = math.rad
local random = math.random
local sin    = math.sin

-- String
local find   = string.find
local format = string.format
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