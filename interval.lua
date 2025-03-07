function env.interval:enter()
    timer=0
    
   sprite.tutorial=love.graphics.newImage("menu/4.png")
   local screenWidth = love.graphics.getWidth()
        local screenHeight = love.graphics.getHeight()
        
        -- 获取图片的宽高
        local imageWidth = sprite.tutorial:getWidth()
        local imageHeight = sprite.tutorial:getHeight()
    
        -- 计算缩放比例，保持等比例缩放
        local scaleX = screenWidth / imageWidth
        local scaleY = screenHeight / imageHeight
    
        -- 选择最小的缩放比例来保证图片不会被拉伸
        local scale = math.min(scaleX, scaleY)
    
        -- 计算缩放后的图片的宽高
        local newWidth = imageWidth * scale
        local newHeight = imageHeight * scale
    
        -- 计算绘制位置（居中）
        local x = (screenWidth - newWidth) / 2
        local y = (screenHeight - newHeight) / 2
    
        -- 绘制图片，保持等比例缩放并居中
        love.graphics.draw(sprite.tutorial, x, y, 0, scale, scale)

        
    data.readFile()
    data.valueInit()
    data.weaponSpawn()
    data.playerInit()
    -- data.entityUpdate()
    if data.load==false then
  
    else
      data.readFile()
    end



    end
    
    
    function env.interval:update(dt)
    timer=timer+dt
        
       

        end
    function env.interval:touchreleased(id,x,y)
        if x >= data.menu_start.x and x <= data.menu_start.x + data.menu_start.width and
        y >= data.menu_start.y and y <= data.menu_start.y + data.menu_start.height then
         data.menu_start.state=false
      
       
        Gamestate.switch(env.gameloop)
    end
    end

    
function env.interval:keypressed(key)
    if key=="lalt" then	

        Gamestate.switch(env.gameloop)
	elseif key=="ralt" then
		data.load=true
    end
end
    function env.interval:draw()
        local screenWidth = love.graphics.getWidth()
        local screenHeight = love.graphics.getHeight()
        
        -- 获取图片的宽高
        local imageWidth = sprite.tutorial:getWidth()
        local imageHeight = sprite.tutorial:getHeight()
    
        -- 计算缩放比例，保持等比例缩放
        local scaleX = screenWidth / imageWidth
        local scaleY = screenHeight / imageHeight
    
        -- 选择最小的缩放比例来保证图片不会被拉伸
        local scale = math.min(scaleX, scaleY)
    
        -- 计算缩放后的图片的宽高
        local newWidth = imageWidth * scale
        local newHeight = imageHeight * scale
    
        -- 计算绘制位置（居中）
        local x = (screenWidth - newWidth) / 2
        local y = (screenHeight - newHeight) / 2
    
        -- 绘制图片，保持等比例缩放并居中
        love.graphics.draw(sprite.tutorial, x, y, 0, scale, scale)
        if timer>5 then
       if 		data.menu_start.state==false then
        love.graphics.draw(sprite.menu_start,data.menu_start.quad,data.menu_start.x,data.menu_start.y-20,0,2.5,2.5)
        else
          love.graphics.draw(sprite.menu_start,data.menu_start_pressed.quad,data.menu_start.x,data.menu_start.y-20,0,2.5,2.5)
      
        end
    end
    end
    