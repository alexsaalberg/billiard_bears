Physics = require 'src.components.physics'

local system = Concord.system({Physics})

function system:draw()
	for i = 1, self.pool.size do 
		e = self.pool:get(i)
		physics = e.get(Physics)

		self:printText(physics:toInfo())
	end

	self:drawPrintedText()
end

function system:printText(text)
	local time = os.time()
	self.last_time = time

	if not self.string then
		self.string = ""
	end

	if not self.last_time == time then
		self.string = ""
	end

	self.string = self.string .. text .. "\n"
end

function system:drawPrintedText()
   love.graphics.setColor(0,0,0,255)
	love.graphics.print(text, 10, 10)
end

return system