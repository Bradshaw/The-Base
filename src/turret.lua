require("useful")
turret = {}

function turret.new(x, y, team)
	local self = {}
	self.size = 10
	self.isTurret = true
	local x = x or math.random(0,love.graphics.getWidth())
	local y = y or math.random(0,love.graphics.getHeight())

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
	local vx, vy = 0, 0
	local health = 100
	function self.move(dt)
		
	end


	local shoottime = 10000
	local shootdelay = 0.6
	function self.shoot(dt)
		shoottime = shoottime+dt
		if target and not target.purge then
			local tx, ty = target.getPos()
			local range, nx, ny = useful.distance(tx,ty,x,y)
			if range<150 then
				if shoottime>shootdelay then
					ray.shoot(x,y-5,tx,ty-5,self.team,2)
					--rocket.shoot(x,y-5,tx,ty-5,self.team,20)
					shoottime = 0
					target.takeDamage(1)
				end
			end
		end
	end
	function self.takeDamage(dmg)
		health = health - dmg
		if health<=0 then
			self.purge = true
			--stopped = true
			--stopmessage = self.team.." team lost the game"
			--local d = turret.new(useful.tri(self.team=="red",30,love.graphics.getWidth())-math.random(0,30),math.random(0,love.graphics.getHeight()), useful.tri(self.team=="red","red","blu"))
			--sim.register(d)
		end
	end

	function self.predraw()
		love.graphics.setColor(0,0,0,30)
		love.graphics.rectangle("fill",x-6,y-4,13,9)
		if target and target.getPos then
			local tx, ty = target.getPos()
			love.graphics.setColor(255,255,255,10)
			--love.graphics.line(x,y-5,tx,ty-5)
		end
	end

	function self.draw()
		if self.team=="red" then
			love.graphics.setColor(255,127,0)
		else
			love.graphics.setColor(0,127,255)
		end
		love.graphics.rectangle("fill",x-3,y-(health/100)*13,7,(health/100)*13)
		if shoottime<0.1 then
		end
	end
	function self.getHealth()
		return health
	end
	return self
end