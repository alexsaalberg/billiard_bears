Position = require 'src.components.position'

local system = Concord.system({Physics})

function system:init(world)
	self.world = world

   --self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

   local edge = 20
   createBorder(self.world, edge, edge, love.graphics.getWidth() - edge, love.graphics.getHeight() - edge)

   self.debugDraw = false
end

function system:update(dt)
	self.world:update(dt)
end

function system:draw()
	if self.debugDraw then
		for _, body in pairs(self.world:getBodies()) do
		   for _, fixture in pairs(body:getFixtures()) do
		      local shape = fixture:getShape()

	         if shape:getType() == "circle" then
	            local cx, cy = body:getWorldPoints(shape:getPoint())
	            love.graphics.setColor(0,0,0,255)
	            love.graphics.circle("fill", cx, cy, shape:getRadius())
	         end
	         if shape:getType() == "polygon" then
	            love.graphics.setColor(0,0,0,255)
	            love.graphics.polygon("fill", body:getWorldPoints( shape:getPoints() ) ) 
	         end
	      end

	      local x, y = body:getPosition()
	      local vx, vy = body:getLinearVelocity()

	      love.graphics.setColor(0,0,255,255)
	      love.graphics.line(x, y, x+vx, y+vy)
	   end
	end
end

function system:keypressed(key)
	if key == 'p' then
		self.debugDraw = not self.debugDraw
	end
end

--[[ collision callbacks ]]
local function beginContact(a, b, coll)
   
end
 
local function endContact(a, b, coll)

end
 
local function preSolve(a, b, coll)
 
end
 
local function postSolve(a, b, coll, normalimpulse, tangentimpulse)

end

--[[ static functions ]]

function system.makeCircleBody(world, userdata, options)
	if not options then
		options = {}
	end

	options.radius = options.radius or 20
	options.shape = love.physics.newCircleShape(options.radius)

	return system.makeBody(world, userdata, options)
end

function system.makeBody(world, userdata, options)
	defaultOptions = {
		mass = 10,
		restitution = 0.9,
		radius = 20,
		x = 50,
		y = 50,
		vx = 0,
		vy = 0,
		shape = love.physics.newCircleShape(20),
	}

	if not options then
		options = {}
	end

	local mass = options.mass or defaultOptions.mass
	local restitution = options.restitution or defaultOptions.mass
	local radius = options.radius or defaultOptions.radius
	local x = options.x or defaultOptions.x
	local y = options.y or defaultOptions.y
	local vx = options.vx or defaultOptions.vx
	local vy = options.vy or defaultOptions.vy
	local shape = options.shape or defaultOptions.shape

	local body = love.physics.newBody(world, x, y, "dynamic")
	body:setLinearVelocity(vx, vy)
	body:setMass(mass)
	body:setSleepingAllowed(false)
	body:setFixedRotation(true)

	local fixture = love.physics.newFixture(body, shape)
	fixture:setRestitution(restitution)
	fixture:setUserData(userData)

	return body, shape
end

-- making screen border physics bodies
function createBorder(world, minX, minY, maxX, maxY)
   local boxWidth = 50

   --print("minX="..minX.." minY="..minY.." maxX="..maxX.." maxY="..maxY)

   local leftBox = makeBox(world, minX-boxWidth, minY, minX, maxY)
   local topBox = makeBox(world, minX, minY-boxWidth, maxX, minY)
   local rightBox = makeBox(world, maxX, minY, maxX+boxWidth, maxY)
   local bottomBox = makeBox(world, minX, maxY, maxX, maxY+boxWidth)
end

function makeBox(world, minX, minY, maxX, maxY)
   --print("minX="..minX.." minY="..minY.." maxX="..maxX.." maxY="..maxY)

   local box = {}
   local w, h = maxX-minX, maxY-minY
   box.body = love.physics.newBody(world, minX, minY, "static")
   box.body:setMass(10)
   box.body:setSleepingAllowed(false)
   box.shape = love.physics.newRectangleShape(w/2, h/2, w, h, 0)
   box.fixture = love.physics.newFixture(box.body, box.shape)
   box.fixture:setRestitution(1.0)
end

return system