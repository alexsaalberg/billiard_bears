local component = Concord.component(
   function(e, image, maskX, maskY, maskW, maskH)
   	e.image = image
   	e.mask = {x = maskX, y = maskY, w = maskW, h = maskH} -- optional
	end
)

return component