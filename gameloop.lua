function env.gameloop:enter()
    
    data.fontsize=14
  data.fontaddress1="fonts/Qaz/Qaz-Regular.ttf"
  data.fontaddress1I="fonts/Qaz/Qaz-Italic.ttf"
  data.Isometric_Black="fonts/3DIsometric_Font_1_14/3DIsometric-Black.ttf"
  data.Isometric_Bold="fonts/3DIsometric_Font_1_14/3DIsometric-Bold.ttf"
  data.Isometric_Regular="fonts/3DIsometric_Font_1_14/3DIsometric-Regular.ttf"
 data.curfont=love.graphics.newFont(data.fontaddress1,data.fontsize)
 data.curfontI = love.graphics.newFont(data.fontaddress1I,data.fontsize)

  love.graphics.setFont(data.curfont)

  if data.load=="false" then
    data.readFile()

  data.valueInit()
  data.weaponSpawn()
  data.playerInit()
  data.entityUpdate()
  else
    data.readFile()
  end
end

function env.gameloop:keypressed(key)
  if key=="ralt" then
    data.savefile()
  elseif key=="space" then
    Gamestate.switch(env.mainmenu)

  end
end

function env.gameloop:update(dt)
    data.background.X=data.background.x
    data.background.Y=data.background.y
    math.randomseed(os.time()+dt)
    player:DirectionUpdate2()
    data.weapondisplay2.timer=data.weapondisplay2.timer-dt
    data.weapondisplay1.timer=data.weapondisplay1.timer-dt
    data.switchbutton.timer=data.switchbutton.timer-dt
    player.attacktimer=player.attacktimer-dt
    data.pullbutton.timer=data.pullbutton.timer-dt
    data.pickupbutton.timer=data.pickupbutton.timer-dt
    data.beAttackedTimer=data.beAttackedTimer-dt

    env.loadTiles()
    env.checktouch()
    player:DirectionUpdate()
  
    
    env.checkCollision(player, walls,0,"walls")
    env.checkCollision(player, triggeritems,0,"triggeritem")
    env.checkEdge()
    
    if data.move==true and not data.isColliding then
  
        data.movebytouch(data.background)
        env.backGroundUpdate()
        player:DirectionUpdate()
  
  
    end
  
    
    data.valueUpdate()
    data.entityUpdate()
    
    env.checkTrigger()
    env.updateAllEnemy(enemies)
    
    data.attackedUpdate()

    for i,self in ipairs(enemies) do
      if self.attackedtimer <0.12 then
      self.attackedtimer =self.attackedtimer-dt
    end
  end
  
    if love.keyboard.isDown("lalt") then
      if player.attacktimer<=0 then
        player:attack()
        player.isattacking= true
        player.attacktimer=player.mainweapon.speed
      end
      for _,weapon in ipairs(data.weapons) do
        if env.distance(weapon.x,weapon.y,love.graphics.getWidth()/2,love.graphics.getHeight()/2) <50 and weapon.visible==true then
          player:pickupitem(weapon.id)
          break
        end
      end
  end
  if love.keyboard.isDown("ralt") then
    player:switchweapon()
  end
  data.background.dx=data.background.x-data.background.X
  data.background.dy=data.background.y-data.background.Y
  
end

function env.gameloop:draw()
    env.drawthebackground()
    env.InteracAnimUpdate()
   env.drawEnemy(enemies)
    player:draw()
   env.weapondraw()
    player:drawattack()
    env.drawUI()
    data.drawTouch()
  end

return env,data