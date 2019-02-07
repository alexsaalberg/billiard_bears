Position = require 'src.components.position'
Image = require 'src.components.image'
Physics = require 'src.components.physics'

local system = Concord.system({Image, Physics, Mask, 'maskedPool'}, {Image, Physics, 'physicsPool'}, {Image, Position, 'staticPool'})

function system:draw()
	for i = 1, self.staticPool.size do 
		e = self.staticPool:get(i)

		local image = e:get(Image)
		local position = e:get(Position)

		if not image.tile then
			love.graphics.draw(image.image, position.x, position.y)
		else
			local imgWidth = image.image:getWidth()
			local imgHeight = image.image:getHeight()
			local tileX = math.ceil( love.graphics.getWidth() / imgWidth )
			local tileY = math.ceil( love.graphics.getHeight() / imgHeight )
			
			for x = 0, tileX do
		      for y = 0, tileY do
		         love.graphics.draw( image.image, x * imgWidth, y * imgHeight )
		      end
		   end
		end
	end

	for i = 1, self.physicsPool.size do
		e = self.physicsPool:get(i)

		local image = e:get(Image).image
		local physics = e:get(Physics)

		local body = physics.body
		local shape = physics.shape

		love.graphics.setColor(255,255,255,255)
	   if shape:getType() == "circle" then
	   	local radius = shape:getRadius()

		   local imgWidth = image:getWidth()
		   local imgHeight = image:getHeight()
		   local shapeHeight = radius * 2
		   local shapeWidth = radius * 2
		   local xScale = shapeWidth / imgWidth
		   local yScale = shapeHeight / imgHeight
		   local invXScale = imgWidth / shapeWidth
		   local invYScale = imgWidth / shapeHeight
		   love.graphics.draw(image, body:getX(), body:getY(), body:getAngle(), xScale, yScale, radius * invXScale, radius * invYScale)
		end
	end
end

return system