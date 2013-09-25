ray = {}
ray.all = {}

function ray.update(dt)
	local i = 1
	while i<=#ray.all do
		local v = ray.all[i]
		if v.time>1 then
			table.remove(ray.all, i)
		else
			v.time = v.time+dt*v.speed
			i = i+1
		end
	end
end

function ray.draw( ... )
	for i,v in ipairs(ray.all) do
		love.graphics.setColor(v.r,v.g,v.b)
		love.graphics.setLine((1-v.time)*v.width)
		love.graphics.line(v.x1,v.y1,v.x2,v.y2)
		if v.area then
			love.graphics.circle("fill",v.x2,v.y2,v.area*(1-v.time))
		end
		love.graphics.setColor(255,255,255)
		love.graphics.setLine((1-v.time)*v.width-1)
		love.graphics.line(v.x1,v.y1,v.x2,v.y2)
		if v.area then
			love.graphics.circle("fill",v.x2,v.y2,v.area*(1-v.time)-1)
		end
	end
end

function ray.shoot(x1,y1,x2,y2,col,area)
	local v = {}
	v.x1=x1
	v.x2=x2
	v.y1=y1
	v.y2=y2
	if col == "red" then
		v.r=255
		v.g=127
		v.b=0
	else
		v.r=0
		v.g=127
		v.b=255
	end
	v.time = 0
	v.width=3
	v.speed=5
	--[[]]
	if area then
		v.area =area
		for i,v in ipairs(sim.collection) do
			local tx,ty = v.getPos()
			local distance,nx,ny = useful.distance(x2,y2,tx,ty)
			if distance<area then
				if col~=v.team then
					v.takeDamage(1)
				end
			end
		end
	end
	--]]
	table.insert(ray.all, v)
end