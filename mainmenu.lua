function env.mainmenu:enter()
sprite.mainmenu=love.graphics.newImage("mainmenu/1.png")
sprite.menu_start=love.graphics.newImage("mainmenu/2.png")
sprite.menu_start_pressed=love.graphics.newImage("mainmenu/3.png")
data.menu_start={timer=0,width=sprite.menu_start:getWidth(),height=sprite.menu_start:getHeight()}
data.menu_start.x=(love.graphics.getWidth()-data.menu_start.width)/2
data.menu_start.y=(love.graphics.getHeight()-data.menu_start.height)/2
end

function env.mainmenu:update(dt)
    touches = love.touch.getTouches()
	for _, id in ipairs(touches) do
	   x, y = love.touch.getPosition(id)
		if x-data.menu_start.x<data.menu_start.width and y-data.menu_start.y<data.menu_start.height then
			Gamestate.registerEvents()
			Gamestate.switch(env.gameloop)
		end
	end
end

function env.mainmenu:keypressed(key)
    if key=="lalt" then
        Gamestate.registerEvents()
			Gamestate.switch(env.gameloop)
	elseif key=="ralt" then
		data.load="true"
    end
end

function env.mainmenu:draw()
    love.graphics.draw(sprite.mainmenu,0,0)


  		love.graphics.draw(sprite.menu_start,data.menu_start.x,data.menu_start.y)
	
end