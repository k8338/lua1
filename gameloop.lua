function env.gameloop:enter()



end

function env.gameloop:keypressed(key)
  if key=="ralt" then
    data.savefile()
  elseif key=="space" then
    
    Gamestate.switch(env.mainmenu)

  end
end
-- function env.gameloop:touchreleased(id, x, y)
--   if x >= data.menu_saved.x and x <= data.menu_saved.x + data.menu_saved.width and
--      y >= data.menu_saved.y and y <= data.menu_saved.y + data.menu_saved.height then
--       data.timer2=3
--       data.savefile()
--   end
-- end
function env.gameloop:update(dt)
 data.dt=dt
 data.gamedtime=data.gamedtime+dt
    data.background.X=data.background.x
    data.background.Y=data.background.y
    math.randomseed(os.time()+dt)
    data.weapondisplay2.timer=data.weapondisplay2.timer-dt
    data.weapondisplay1.timer=data.weapondisplay1.timer-dt
    data.switchbutton.timer=data.switchbutton.timer-dt
    player.attacktimer=player.attacktimer-dt
    data.pullbutton.timer=data.pullbutton.timer-dt
    data.pickupbutton.timer=data.pickupbutton.timer-dt
    data.beAttackedTimer=data.beAttackedTimer-dt
    data.ftimer=data.ftimer-dt

    env.loadTiles()
    env.checktouch()

    -- env.checkCollision(player, walls,0,"walls")
    -- env.checkCollision(player, triggeritems,0,"triggeritem")
    -- env.checkEdge()
    if not data.isColliding then
  
        -- data.movebytouch(data.background)
        -- env.backGroundUpdate()
        player:DirectionUpdate()

    end
    data.valueUpdate()
    -- data.entityUpdate()
    
    -- env.checkTrigger()
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

  if player.health<=0 then
    Gamestate.switch(env.closemenu)
  end
end

function env.gameloop:draw()
    env.drawthebackground()
    -- env.InteracAnimUpdate()
   env.drawEnemy(enemies)
  env.drawrarity()
  env.drawfading()
    player:draw()
   env.weapondraw()
    player:drawattack()
    env.drawUI()
    data.drawTouch()
    -- if data.timer2>0 then
    --   love.graphics.print("Current game saved.",data.menu_saved.x-200,data.menu_saved.y+15)
    --   data.timer2=data.timer2-data.dt
    -- end

  end

return env,data