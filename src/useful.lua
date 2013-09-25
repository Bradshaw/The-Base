useful = {}

function useful.tri(cond, yes, no)
	if cond then
		return yes
	else
		return no
	end
end

function useful.sign(n)
	return useful.tri(n>=0,1,-1)
end

function useful.distance(x1,y1,x2,y2)
	local x2 = x2 or 0
	local y2 = y2 or 0
	local dx = x1-x2
	local dy = y1-y2
	local dist = math.sqrt(dx*dx + dy*dy)
	return dist, dx/dist, dy/dist
end