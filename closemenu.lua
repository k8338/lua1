function env.closemenu:enter()
    math.randomseed(os.time()+love.timer.getDelta())
    sprite.closemenu=love.graphics.newImage("menu/1.png")
    sprite.menu_restart=love.graphics.newImage("menu/2.png")
    sprite.menu_restart_pressed=love.graphics.newImage("menu/3.png")
    data.menu_restart={state=false,width=18*2.5,height=18*2.5}
    data.menu_restart_pressed={state=false,width=18*2.5,height=18*2.5,quad=love.graphics.newQuad(112,144,18,18,194,194)}
    local rand1=math.random(1,7)
    if rand1<=4 then
        data.menu_restart.quad=love.graphics.newQuad(16.65,(rand1-1)*48+0.5,17,17,194,194)
    else
        data.menu_restart.quad=love.graphics.newQuad(112.65,(rand1-5)*48+0.5,17,17,194,194)
    end
    data.menu_restart.x=(love.graphics.getWidth()-data.menu_restart.width)/2
    data.menu_restart.y=love.graphics.getHeight()*0.8
    sprite.menu_restart:setFilter("nearest", "nearest")	
	sprite.menu_restart_pressed:setFilter("nearest", "nearest")
    end
    
function env.closemenu:update(dt)

end
function env.closemenu:touchpressed(id, x, y)
    if x >= data.menu_restart.x and x <= data.menu_restart.x + data.menu_restart.width and
       y >= data.menu_restart.y and y <= data.menu_restart.y + data.menu_restart.height then
		data.menu_restart.state=true
	end
end

function env.closemenu:touchreleased(id, x, y)
	
    if x >= data.menu_restart.x and x <= data.menu_restart.x + data.menu_restart.width and
       y >= data.menu_restart.y and y <= data.menu_restart.y + data.menu_restart.height then
		data.menu_restart.state=false
        Gamestate.switch(env.mainmenu)
    end
end
    function env.closemenu:keypressed(key)
        if key=="lalt" then
                Gamestate.switch(env.mainmenu)
        elseif key=="ralt" then
            data.load="true"
        end
    end
    
    function env.closemenu:draw()
        love.graphics.draw(sprite.closemenu,0,0)
      
        love.graphics.setFont(love.graphics.newFont(40))
    love.graphics.printf("Game over",0,150,love.graphics.getWidth(),"center")
    love.graphics.setFont(data.curfont)

    if 		data.menu_restart.state==false then
        love.graphics.draw(sprite.menu_restart,data.menu_restart.quad,data.menu_restart.x,data.menu_restart.y,0,2.5,2.5)
        else
          love.graphics.draw(sprite.menu_restart_pressed,data.menu_restart_pressed.quad,data.menu_restart.x,data.menu_restart.y,0,2.5,2.5)
      
        end
    end
    