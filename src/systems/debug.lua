Physics = require 'src.components.physics'

local system = Concord.system({Physics})

function system:init()
	self.world = world
end

function system:draw()
	self.string = ""

	for i = 1, self.pool.size do 
		e = self.pool:get(i)
		
		physics = e:get(Physics)

		self:printText(physics:toInfo())
	end

	self:drawPrintedText()
end

function system:printText(text)
	self.string = self.string .. text .. "\n"
end

function system:drawPrintedText()
   love.graphics.setColor(0,0,0,255)
	love.graphics.print(self.string, 10, 10)
end

return system