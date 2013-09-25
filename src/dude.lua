require("useful")
dude = {}

function dude.new(x, y, team)
	local self = {}
	self.size = 10
	self.isUnit = true
	local x = x or math.random(0,love.graphics.getWidth())
	local y = love.graphics.getHeight()/2 + math.random(-10,10) --y or math.random(0,love.graphics.getHeight())

	function self.getPos()
		return x, y
	end

	self.team = team or useful.tri(math.random()>0.5,"red","blu")
	local target = {purge = true}

	function self.update(dt)
		self.aquireTarget()
		self.move(dt)
		self.shoot(dt)
	end

	function self.aquireTarget()
		if true or (not target) or target.purge then
			local tries = 0
			--local maxTries = 10
			--while tries<maxTries and (not target or target.purge) do
			local minDist = math.huge
			for i,potential in ipairs(sim.collection) do
				--local potential = sim.collection[math.random(1,#sim.collection)]
				if potential.team and potential.team~=self.team and not potential.purge then
					local tx,ty = potential.getPos()
					local dist = useful.distance(x,y,tx,ty)
					if dist<minDist then
						target=potential
						minDist = dist
					end
					--return
				else
					tries = tries+1
				end
			end
		end
	end
	local vx, vy = 0, 0
	local health = 10
	function self.move(dt)
		if target and (not target.purge) and target.getPos then
			local tx, ty = target.getPos()
			local range, nx, ny = useful.distance(tx,ty,x,y)
			if range>295 then
				vx=vx+nx*40*dt*(health/10)
				vy=vy+ny*40*dt*(health/10)
			end
		end
		for i,v in ipairs(sim.collection) do
			if v.size and v~=self and v.getPos then
				local tx, ty = v.getPos()
				local range, nx, ny = useful.distance(tx,ty,x,y)
				if range<v.size then
					vx=vx-nx*100*dt*((20-range)/20)
					vy=vy-ny*100*dt*((20-range)/20)
				end
			end
		end
		local speed, sx, sy  = useful.distance(vx,vy)
		vx = vx-vx*math.abs(speed*dt*0.4)
		vy = vy-vy*math.abs(speed*dt*0.4)
		x = x+vx*dt*8
		y = y+vy*dt*8
		x = math.max(0,math.min(x, love.graphics.getWidth()))
		y = math.max(0,math.min(y, love.graphics.getHeight()))
	end


	local shoottime = 10000
	local shootdelay = 5
	function self.shoot(dt)
		shoottime = shoottime+dt
		local list = {}
		for i,v in ipairs(sim.collection) do
			local tx, ty = v.getPos()
			local range, nx, ny = useful.distance(tx,ty,x,y)
			if v.team~=self.team and (v.isUnit or v.isTurret) and range<300 then
				table.insert(list, v)
			end
		end
		local target = useful.tri(#list>0,list[math.random(1,#list)])
		---[[]
		if target and not target.purge then
			local tx, ty = target.getPos()
			local range, nx, ny = useful.distance(tx,ty,x,y)
			if range<300 then
				if shoottime>shootdelay/health then
					rocket.shoot(x,y-5,tx,ty-5,self.team,20)
					shoottime = 0
					--target.takeDamage(1)
				end
			end
		end
		--]]
	end
	function self.takeDamage(dmg)
		health = health - dmg
		if health<=0 then
			self.purge = true
			--local d = dude.new(useful.tri(self.team=="red",30,love.graphics.getWidth())-math.random(0,30),math.random(0,love.graphics.getHeight()), useful.tri(self.team=="red","red","blu"))
			--sim.register(d)
		end
	end

	function self.predraw()
		love.graphics.setColor(0,0,0,30)
		love.graphics.rectangle("fill",x-5,y-3,11,7)
		if target and target.getPos then
			local tx, ty = target.getPos()
			love.graphics.setColor(255,255,255,10)
			love.graphics.setLine(3)
			--love.graphics.line(x,y,tx,ty)
		end
	end

	function self.draw()
		if self.team=="red" then
			love.graphics.setColor(255,127,0)
		else
			love.graphics.setColor(0,127,255)
		end
		love.graphics.rectangle("fill",x-2,y-(health/10)*9,5,(health/10)*9)
		if shoottime<0.1 then
		end
	end

	return self
end