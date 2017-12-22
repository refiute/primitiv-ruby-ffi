require './shape'

def normShape(shapelike)
	if shapelike.is_a?(Primitiv::Shape)
		return shapelike
	else
		return Primitiv::Shape.new shapelike
	end
end
