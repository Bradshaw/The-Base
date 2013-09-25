local state = gstate.new()


function state:init()
	redwin = 0
	bluewin = 0
end


function state:enter()
	shots = 0
	spawntime = 0
	spawnamt = 0
	q = 1
	---[[]
	sim.register(
		turret.new(
			4*love.graphics.getWidth()/5,
			love.graphics.getHeight()/2+50,
			"blu"
		)
	)
	sim.register(
		turret.new(
			love.graphics.getWidth()/5,
			love.graphics.getHeight()/2+50,
			"red"
		)
	)
	--]]

	sim.register(
		turret.new(
			4*love.graphics.getWidth()/5,
			love.graphics.getHeight()/2,
			"blu"
		)
	)
	sim.register(
		turret.new(
			love.graphics.getWidth()/5,
			love.graphics.getHeight()/2,
			"red"
		)
	)
	---[[]
	sim.register(
		turret.new(
			4*love.graphics.getWidth()/5,
			love.graphics.getHeight()/2-50,
			"blu"
		)
	)
	sim.register(
		turret.new(
			love.graphics.getWidth()/5,
			love.graphics.getHeight()/2-50,
			"red"
		)
	)
	--]]
end

function spawn(team)
	local d = dude.new(useful.tri(team=="red",30,love.graphics.getWidth())-math.random(0,30), math.random(0,love.graphics.getHeight()), team )
	--local d = dude.new()
	sim.register(d)
end

function state:focus()

end


function state:mousepressed(x, y, btn)

end


function state:mousereleased(x, y, btn)
	
end


function state:joystickpressed(joystick, button)
	
end


function state:joystickreleased(joystick, button)
	
end


function state:quit()
	
end


function state:keypressed(key, uni)
	if key=="escape" then
		love.event.push("quit")
	end
end


function state:keyreleased(key, uni)
	
end


function state:update(dt)
	presenting =  love.keyboard.isDown("p")

	local dt = dt
	if stopped then
		--dt = dt/20	
	else
		if presenting then
			dt = 1/30
		end
	end

				
	spawntime = spawntime-dt
	if spawntime<0 then
		spawnamt = q
		q = math.min(q+0.3,10)
		spawntime=spawntime+5
	end
	if not stopped and spawnamt>0 then
		spawn("red")
		spawn("blu")
		spawnamt = spawnamt-1
	end
	--[[]
	if #sim.collection>150 then
		for i,v in ipairs(sim.collection) do
			v.takeDamage(dt*10)
		end
	end
	--]]
	if stopped then
		if rhp==0 then
			bluewin = bluewin+1
		else
			redwin = redwin+1
		end
		stopped = false
		sim.collection = {}
		gstate.switch(game)
	end
	rhp = 0
	bhp = 0
	for i,v in ipairs(sim.collection) do
		if v.isTurret then
			if v.team=="red" then
				rhp = rhp + v.getHealth()
			else
				bhp = bhp + v.getHealth()
			end
		end
	end

	if rhp==0 or bhp==0 then
		stopped = true
		stopmessage = "Game Over"
	end

	sim.update(dt)
	ray.update(dt)
end


function state:draw()
	love.graphics.setBackgroundColor(127,100,127)
	sim.draw()
	ray.draw()
	if stopped then
		love.graphics.setColor(0,0,0)
		local w = love.graphics.getFont():getWidth(stopmessage)
		love.graphics.print(stopmessage,love.graphics.getWidth()/2-w/2,love.graphics.getHeight()/2)
	end

	--local rw = love.graphics.getFont():getWidth("Blu: "..bluewin)
	love.graphics.setColor(255,127,0)
	love.graphics.rectangle("fill",love.graphics.getWidth()/2-(rhp/300)*love.graphics.getWidth()/2,0,(rhp/300)*love.graphics.getWidth()/2,30)
	love.graphics.setColor(0,127,255)
	love.graphics.rectangle("fill",love.graphics.getWidth()/2,0,(bhp/300)*love.graphics.getWidth()/2,30)

	--[[]
	local bw = love.graphics.getFont():getWidth("Blu: "..bluewin)
	love.graphics.setColor(255,127,0)
	love.graphics.print("Red: "..redwin,10,love.graphics.getHeight()-20)

	love.graphics.setColor(0,127,255)
	love.graphics.print("Blu: "..bluewin,love.graphics.getWidth()-bw-10,love.graphics.getHeight()-20)
	--]]
	if presenting then
		local ss = love.graphics.newScreenshot()
		print("shot"..string.format("%04d",shots)..".png")
		ss:encode("shot"..string.format("%04d",shots)..".png")
		shots = shots+1
	end
end

return state