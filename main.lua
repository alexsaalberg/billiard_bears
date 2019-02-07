Concord = require("lib.concord").init({
  useEvents = false,
})

-- Create a new Instance to work with
--local Instance = require("concord.instance")
local Position = require 'src.components.position'
local Physics = require 'src.components.physics'
local Image = require 'src.components.image'
local DrawSystem = require 'src.systems.draw'
local PhysicsSystem = require 'src.systems.physics'
local DebugSystem = require 'src.systems.debug'

Resources = {}
Resources.Graphics = {}
Resources.Audio = {}

gameInstance = Concord.instance()



--[[ love callbacks ]]
function love.load()
   -- Resources
   Resources.Graphics.Bear = love.graphics.newImage( 'resources/graphics/bear.png' )
   Resources.Graphics.Felt = love.graphics.newImage( 'resources/graphics/felt.png' )
   Resources.Audio.ball_clack = love.audio.newSource( 'resources/audio/ball_clack.ogg', 'static' )

   -- Physics
   game = {}
   game.world = love.physics.newWorld(0, 0, true)

   -- Systems
   drawSystem = DrawSystem()
   gameInstance:addSystem(drawSystem, 'draw')

   physicsSystem = PhysicsSystem(game.world)
   gameInstance:addSystem(physicsSystem, 'draw')
   gameInstance:addSystem(physicsSystem, 'update')
   gameInstance:addSystem(physicsSystem, 'keypressed')

   debugSystem = DebugSystem()
   gameInstance:addSystem(debugSystem, 'draw')

   --gameInstance:addSystem(physicsSystem, 'keypressed')

   -- Adding entities
   local background = Concord.entity()
   background:give(Position)
   background:give(Image, Resources.Graphics.Felt)
   background[Image].tile = true

   gameInstance:addEntity(background)


   local randomPosition = function()
      lume = require( 'lib.lume' )
      return lume.random(30,300), lume.random(30, 300)
   end

   for i = 1,2 do
      local ballBody, ballShape = physicsSystem.makeCircleBody(game.world)
      local entity = Concord.entity()
      entity:give(Physics, ballBody, ballShape)
      entity:give(Image, Resources.Graphics.Bear)
      entity:apply()

      entity[Physics]:setPosition(randomPosition())
      --entity[Physics]:setVelocity(100, 500)
      entity[Physics].body:applyForce(10000,1000)

      gameInstance:addEntity(entity)
      print(i)
   end

end

function love.update(dt)
   gameInstance:emit('update', dt)
end

function love.draw()
   love.graphics.setColor(255,255,255,255)
   gameInstance:emit("draw")
   --love.graphics.print("text", 30, 50)
end


--[[ input callbacks ]]
function love.mousepressed(x, y, button, istouch)

end 

function love.mousereleased(x, y, button, istouch)

end

function love.keypressed(key, scancode, isrepeat)
   gameInstance:emit('keypressed', key)

   if key == 'q' then
      love.event.quit()
   end
end