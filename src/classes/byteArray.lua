local byteArray = { }
do
	-- Reference: https://github.com/Lautenschlager-id/Transfromage/blob/master/libs/bArray.lua
	byteArray.__index = byteArray

	byteArray.__tostring = function(self)
		return table_writeBytes(self.stack)
	end

	local modulo256 = function(n)
		-- It could be n & 0xFF but, in Lua, modulo is slightly more performatic
		return n % 256
	end

	byteArray.new = function(stack)
		if type(stack) == "string" then
			stack = str_getBytes(stack)
		end

		return setmetatable({
			stack = (stack or { }), -- Array of bytes
			stackLen = (stack and #stack or 0),
			stackReadPos = 1,
			stackReadLen = 0
		}, byteArray)
	end

	byteArray.write8 = function(self, ...)
		local tbl = { ... }

		local tblLen = #tbl
		if tblLen == 0 then
			tblLen = 1

			tbl = { 0 }
		end
		self.stackLen = self.stackLen + tblLen

		local bytes = table_mapArray(tbl, modulo256)
		table_addArray(self.stack, bytes)
		return self
	end

	byteArray.write16 = function(self, short)
		-- (long >> 8), long
		return self:write8(rshift(short, 8), short)
	end

	byteArray.write24 = function(self, int)
		-- (long >> 16), (long >> 8), long
		return self:write8(rshift(int, 16), rshift(int, 8), int)
	end

	byteArray.write32 = function(self, long)
		-- (long >> 24), (long >> 16), (long >> 8), long
		return self:write8(rshift(long, 24), rshift(long, 16), rshift(long, 8),	long)
	end

	byteArray.writeUTF = function(self, utf)
		if type(utf) == "string" then
			utf = str_getBytes(utf)
		end

		local utfLen = #utf
		self:write16(utfLen)
		table_addArray(self.stack, utf)
		self.stackLen = self.stackLen + utfLen

		return self
	end

	byteArray.writeBigUTF = function(self, bigUtf)
		if type(bigUtf) == "string" then
			bigUtf = string_getBytes(bigUtf)
		end

		local bigUtfLen = #bigUtf
		self:write24(bigUtfLen)
		table_addArray(self.stack, bigUtf)
		self.stackLen = self.stackLen + bigUtfLen

		return self
	end

	byteArray.writeBool = function(self, bool)
		return self:write8(bool and 1 or 0)
	end

	byteArray.read8 = function(self, quantity)
		quantity = quantity or 1

		local stackReadPos = self.stackReadPos + quantity
		local byteStack = table_arrayRange(self.stack, self.stackReadPos, stackReadPos - 1)
		self.stackReadPos = stackReadPos

		local sLen = #byteStack
		self.stackLen = self.stackLen - sLen

		local fillVal = quantity - sLen
		if fillVal > 0 then
			for i = 1, fillVal do
				byteStack[sLen + i] = 0
			end
		end

		return (quantity == 1 and byteStack[1] or byteStack)
	end

	byteArray.read16 = function(self)
		local shortStack = self:read8(2)
		-- s[1] << 8 + s[2]
		return lshift(shortStack[1], 8) + shortStack[2]
	end

	byteArray.readSigned16 = function(self)
		local shortStack = self:read8(2)
		-- ((s[1] << 8 | s[2] << 0) ~ 0x8000) - 0x8000
		return bxor(bor(lshift(shortStack[1], 8), lshift(shortStack[2], 0)), 0x8000) - 0x8000
	end

	byteArray.read24 = function(self)
		local intStack = self:read8(3)
		-- i[1] << 16 + i[2] << 8 + i[3]
		return lshift(intStack[1], 16) + lshift(intStack[2], 8) + intStack[3]
	end

	byteArray.read32 = function(self)
		local longStack = self:read8(4)
		-- l[1] << 24 + l[2] << 16 + l[3] << 8 + l[4]
		return lshift(longStack[1], 24) + lshift(longStack[2], 16) + lshift(longStack[3], 8)
			+ longStack[4]
	end

	byteArray.readUTF = function(self)
		local byte = self:read8(self:read16())

		if type(byte) == "number" then
			return char(byte)
		end
		return table_writeBytes(byte)
	end

	byteArray.readBigUTF = function(self)
		local byte = self:read8(self:read24())

		if type(byte) == "number" then
			return char(byte)
		end
		return table_writeBytes(byte)
	end

	byteArray.readBool = function(self)
		return self:read8() == 1
	end
end