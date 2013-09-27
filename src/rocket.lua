rocket = {}
rocket.all = {}

function rocket.shoot(x1,y1,x2,y2,team,area,dmg)
	local self = {}
	self.size = 0
	local x,y = x1,y1
	local tx,ty = x2,y2
	local range, nx, ny = useful.distance(tx,ty,x,y)
	local vx = nx*5+math.random(-2,2)
	local vy = ny*5+math.random(-2,2)
	local team = team
	--local area = area

	function self.update(dt)
		local range, nx, ny = useful.distance(tx,ty,x,y)
		if range<area/2 then
			ray.shoot(x,y,x,y,team,area,dmg)
			self.purge = true
		end
		vx=vx+nx*10*dt
		vy=vy+ny*10*dt
		vx = vx-vx*math.abs(dt*2)
		vy = vy-vy*math.abs(dt*2)
		x = x+vx*dt*30
		y = y+vy*dt*30
	end

	function self.predraw( ... )
		
	end

	function self.getPos()
		return x,y
	end

	function self.draw()
		local l, lx, ly = useful.distance(vx,vy)
		love.graphics.setColor(255,255,255)
		love.graphics.setLine(2)
		local r = math.random()
		love.graphics.line(
			x-lx*2,
			y-ly*2,
			x-lx*(2+r*2),
			y-ly*(2+r*2))


		if team=="red" then
			love.graphics.setColor(255,127,0)
		else
			love.graphics.setColor(0,127,255)
		end
		love.graphics.setLine(2)
		love.graphics.line(
			x+lx*2,
			y+ly*2,
			x-lx*2,
			y-ly*2)
		love.graphics.setLine(1)
	end

	function self.takeDamage( ... )
		-- body
	end

	sim.register(self)
end