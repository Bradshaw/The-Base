sim = {}

sim.collection = {}

function sim.update(dt)
	local i = 1
	while i<=#sim.collection do
		local v = sim.collection[i]
		if v.purge then
			table.remove(sim.collection,i)
		else
			v.update(dt)
			i = i+1
		end
	end
end

function sim.draw()
	for i,v in ipairs(sim.collection) do
		v.predraw()
	end
	for i,v in ipairs(sim.collection) do
		v.draw()
	end
end


function sim.register(entity)
	if entity.update and type(entity.update)=="function" then
		table.insert(sim.collection, entity)
	end
end