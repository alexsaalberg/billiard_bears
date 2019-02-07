local inspect = require 'lib/inspect'

local component = Concord.component(
   function(e, body, shape)
   	e.body = body
   	e.shape = shape
	end
)

function component:setPosition(x, y)
	self.body:setPosition(x, y)
end

function component:setVelocity(x, y)
	self.body:setLinearVelocity(x, y)
end

function component:toInfo()
	local vx, vy = self.body:getVelocity()
	local x, y = self.body:getPosition()

	return "Physics Component"
	.."\n" .. "  Position = ("..x..", "..y..")"
	.."\n" .. "  Velocity = ("..vx..", "..vy..")"
end

return component