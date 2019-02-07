middleclass = require( 'lib.middleclass' )

Manager = middleclass('Manager')

function Manager:initialize()
	self.sounds = {}
end

function Manager:newSound(sound)
	return sound:clone()
end

-- plays and returns newly created sound instance
function Manager:playNewSound(sound)
	new_sound = self:newSound(sound)

	new_sound:play()

	--self:addToSoundMap(sound, new_sound)

	return new_sound
end

function Manager:addToSoundMap(sound, new_sound)
	if not self.sounds[sound] then
		self.sounds[sound] = {}
		self.sounds[sound].count = 0
		self.sounds[sound].map = {}
	end

	sound_data = self.sounds[sound]
	sound_data.count = sound_data.count + 1
	this_id = sound_data.count
	sound_data.map[this_id] = new_sound
end

return Manager:new()