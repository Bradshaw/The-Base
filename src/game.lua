local state = gstate.new()


function state:init()
	hexim = love.graphics.newImage("images/basetile.png")
	hexim:setFilter("nearest","nearest")
	hexbat = love.graphics.newSpriteBatch(hexim,1000)
	selim = love.graphics.newImage("images/nobot.png")
	selim:setFilter("nearest","nearest")
	selx = 10
	sely = 6
	xoff = 34
	yoff = 6

	tiles = {}
	for i=1,20 do
		tiles[i]={}
		for j=1,40 do
			tiles[i][j] = {
				val = math.random(0,3),
				p = math.random(-1,1),
				off = math.random()*math.pi*2
			}
		end
	end

	time = 0

	oddxoff = 17
	redrawMap()
end


function state:enter()

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
	if key=="left" then
		if sely%2 ~= 0 then
			selx = selx-1
			sely = sely-1
		else
			--selx = selx-1
			sely = sely+1
		end
	end
	if key=="right" then
		if sely%2 ~= 0 then
			--selx = selx+1
			sely = sely-1
		else
			selx = selx+1
			sely = sely+1
		end
	end
	if key=="up" then
		sely = sely-2
	end
	if key=="down" then
		sely = sely+2
	end
	if key==" " then
		local t = tiles[selx][sely]
		t.val = (t.val+1)%4
	end
end


function state:keyreleased(key, uni)
	
end


function state:update(dt)
	time = time + dt * math.pi
end

function redrawMap( ... )
	hexbat:clear()
	for j=1,#tiles[1] do
		for i=1,#tiles do
			local val,p = tiles[i][j].val, tiles[i][j].p
			local col = math.floor((60/3)*val)
			local osc = 0
			if val==0 then
				hexbat:setColor(140,245,245)
				val=-2
				p=0
				local v = tiles[i][j]
				osc = math.floor(1.5*math.sin(time+i/2-j/2+v.off/4))
			elseif val==3 then
				hexbat:setColor(160,255,160)
			else
				hexbat:setColor(200-col,200-col,160-col)
			end
			hexbat:add((i-1)*xoff+((j-1)%2)*oddxoff,(j-1)*yoff-val+p+osc)
		end
	end
end

function state:draw()
	redrawMap()
	love.graphics.push()
	love.graphics.setColor(255,255,255)
	love.graphics.scale(2,2)
	love.graphics.translate(-20,-20)
	love.graphics.draw(hexbat)

	if tiles[selx] and tiles[selx][sely] then
		local v = tiles[selx][sely]
		love.graphics.draw(selim,(selx-1)*xoff+((sely-1)%2)*oddxoff,(sely-1)*yoff-v.val+v.p)
	end
	love.graphics.setColor(40,45,45)
	--love.graphics.print((selx-4)..' '..(sely-4),selx*xoff+(sely%2)*oddxoff,sely*yoff)
	love.graphics.pop()
	--love.graphics.print(love.timer.getFPS(),10,10)
end

return state