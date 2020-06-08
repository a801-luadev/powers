local byteArray = { }
do
	-- Reference: https://github.com/Lautenschlager-id/Transfromage/blob/master/libs/bArray.lua

	--[[
		Transformice encodes Data Files in US-ASCII, which means bytes above 128 will get glitched
		during the IO convertions.

		The class has been changed in order to handle this issue.
	]]

	byteArray.__index = byteArray

	byteArray.__tostring = function(self)
		return table_writeBytes(self.stack)
	end

	local modulo128 = function(n)
		-- It could be n & 127 but, in Lua, modulo is slightly more performatic
		return n % 128
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

		local bytes = table_mapArray(tbl, modulo128)
		table_addArray(self.stack, bytes)
		return self
	end

	byteArray.write16 = function(self, short)
		return self:write8(
			rshift(short, 14) % 4, -- (short >> 14) & 3
			rshift(short, 7), -- short >> 7
			short
		)
	end

	byteArray.write24 = function(self, int)
		return self:write8(
			rshift(int, 21) % 8, -- (int >> 21) & 7
			rshift(int, 14), -- int >> 14
			rshift(int, 7), -- int >> 7
			int
		)
	end

	byteArray.write32 = function(self, long)
		return self:write8(
			rshift(long, 28) % 16, -- (long >> 28) & 15
			rshift(long, 21), -- long >> 21
			rshift(long, 14), -- long >> 14
			rshift(long, 7), -- long >> 7
			long
		)
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
		local shortStack = self:read8(3)
		-- s[1] << 14 + s[2] << 7 + s[3]
		return lshift(shortStack[1], 14) + lshift(shortStack[2], 7) + shortStack[3]
	end

	byteArray.read24 = function(self)
		local intStack = self:read8(4)
		-- i[1] << 21 + i[2] << 14 + i[3] << 7 + i[4]
		return lshift(intStack[1], 21) + lshift(intStack[2], 14) + lshift(intStack[3], 7)
			+ intStack[4]
	end

	byteArray.read32 = function(self)
		local longStack = self:read8(5)
		-- l[1] << 28 + l[2] << 21 + l[3] << 14 + l[4] << 7 + l[5]
		return lshift(longStack[1], 28) + lshift(longStack[2], 21) + lshift(longStack[3], 14)
			+ lshift(longStack[4], 7) + longStack[5]
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