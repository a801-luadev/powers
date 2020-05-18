local inRectangle = function(x, y, rx, ry, rw, rh, rightDirection)
	return (rightDirection
		and (x >= rx and x <= (rx + rw))
		or (x >= (rx - rw) and x <= rx)
	) and (y >= ry and y <= (ry + rh))
end

local pythagoras = function(x, y, cx, cy, cr)
	x = x - cx
	x = x * x
	y = y - cy
	y = y * y
	cr = cr * cr
	return x + y < cr
end