function env.mainmenu:enter()
sprite.mainmenu=love.graphics.newImage("menu/1.png")
math.randomseed(os.time()+love.timer.getDelta())
sprite.menu_start=love.graphics.newImage("menu/2.png")
    data.menu_start={state=false,width=18*2.5,height=18*2.5}
	data.menu_start_pressed={state=false,width=18*2.5,height=18*2.5,quad=love.graphics.newQuad(112,144,18,18,194,194)}
    data.menu_saved={state=false,width=18*2.5,height=18*2.5}
    rand1=math.random(1,7)
    if rand1<=4 then
        data.menu_start.quad=love.graphics.newQuad(16.65,(rand1-1)*48+0.5,17,17,194,194)
    else
        data.menu_start.quad=love.graphics.newQuad(112.65,(rand1-5)*48+0.5,17,17,194,194)
    end
    rand1=math.random(8,14)
    if rand1<=11 then
        data.menu_saved.quad=love.graphics.newQuad(48.65,16+(rand1-8)*48+0.5,17,17,194,194)
    else
        data.menu_saved.quad=love.graphics.newQuad(144.65,16+(rand1-12)*48+0.5,17,17,194,194)
    end
    data.menu_start.x=(love.graphics.getWidth()-data.menu_start.width)/2
    data.menu_start.y=love.graphics.getHeight()*0.5
    data.menu_saved.x=(love.graphics.getWidth()-data.menu_saved.width)/2
    data.menu_saved.y=data.menu_start.y+60
    data.menu_saved.scale=2.5
	sprite.menu_start:setFilter("nearest", "nearest")	
    data.timer1=0
    data.isloading=false
    data.havesave=false

end


function env.mainmenu:update(dt)

    

    end
function env.mainmenu:touchpressed(id, x, y)
    if x >= data.menu_start.x and x <= data.menu_start.x + data.menu_start.width and
       y >= data.menu_start.y and y <= data.menu_start.y + data.menu_start.height then
		data.menu_start.state=true
	end
    
end

function env.mainmenu:touchreleased(id, x, y)
    if x >= data.menu_start.x and x <= data.menu_start.x + data.menu_start.width and
       y >= data.menu_start.y and y <= data.menu_start.y + data.menu_start.height then
		data.menu_start.state=false
        data.isloading=true
        data.load=false
        love.graphics.print("Game is loading...",love.graphics.getWidth()*0.3,love.graphics.getHeight()*0.4)
        Gamestate.switch(env.interval)
       end
    --     if x >= data.menu_saved.x and x <= data.menu_saved.x + data.menu_saved.width and
    --    y >= data.menu_saved.y and y <= data.menu_saved.y + data.menu_saved.height then
    --     if love.filesystem.getInfo("initvalue.txt").type==nil then
    --         data.timer1=5
    --     else
    --     data.load=true
    --     data.isloading=true
    --     love.graphics.print("Game is loading...",love.graphics.getWidth()*0.3,love.graphics.getHeight()*0.4)
    --     Gamestate.switch(env.interval)
    --     end
    -- end
end
function env.mainmenu:keypressed(key)
    if key=="lalt" then	
        data.load=true
        love.graphics.print("Game is loading...",love.graphics.getWidth()*0.3,love.graphics.getHeight()*0.4)

        Gamestate.switch(env.interval)
	elseif key=="ralt" then
		data.load=true
    end
end

function env.mainmenu:draw()
    love.graphics.draw(sprite.mainmenu,0,0)

	love.graphics.setFont(love.graphics.newFont(31.5))
love.graphics.printf("Gliding Rim:",0,60,love.graphics.getWidth(),"center")

love.graphics.setFont(love.graphics.newFont("fonts/Qaz/Qaz-Italic.ttf",65))
love.graphics.printf("Roaming",0,92,love.graphics.getWidth(),"center")
love.graphics.setFont(data.curfont)
  if 		data.menu_start.state==false then
  love.graphics.draw(sprite.menu_start,data.menu_start.quad,data.menu_start.x,data.menu_start.y,0,2.5,2.5)
  else
	love.graphics.draw(sprite.menu_start,data.menu_start_pressed.quad,data.menu_start.x,data.menu_start.y,0,2.5,2.5)

  end
--   love.graphics.draw(sprite.menu_start,data.menu_saved.quad,data.menu_saved.x,data.menu_saved.y,0,2.5,2.5)
 
-- if data.timer1>0 then
    
--   love.graphics.print("You don't have a saved file yet",love.graphics.getWidth()*0.6,love.graphics.getHeight()*0.5)
-- end
-- if data.timer1 > 0 then
--     data.timer1 = data.timer1 -love.timer.getDelta()
-- end

--   if data.isloading==true then
--     love.graphics.print("Game is loading...",love.graphics.getWidth()*0.3,love.graphics.getHeight()*0.4)
--   end

end
