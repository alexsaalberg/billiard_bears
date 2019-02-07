local inspect = require 'lib/inspect'

local component = Concord.component(
   function(e, species)
   	e.species = species
	end
)
function component:toInfo()
	return e.species
end

return component