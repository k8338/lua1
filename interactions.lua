
  
  function player:drawattack()
    if player.attackphase <= 5 and     player.isattacking==true    then
    love.graphics.circle("line",player.x+player.width/2,player.y+player.height/2,player.mainweapon.length)
    player.attackphase=player.attackphase+1
    else
      player.attackphase=0
      player.isattacking= false
  end
end
  
function player:attack()

  local x,y=0,0
  for i, entity in ipairs(enemies) do
  if env.distance(player.x,player.y,entity.x,entity.y) <player.mainweapon.length then
    
    
    if player.direction =="down" then
       x =0+player.trx
       y=1 +player.try
    elseif player.direction =="up" then
       x=0+player.trx
       y=-1+player.try
    elseif player.direction =="right" then
       x=1+player.trx
       y=0+player.try
    elseif player.direction =="left" then
       x=-1+player.trx
       y=0+player.try
    end
    if math.deg(math.atan(math.abs(((player.try-entity.y)/(player.trx-entity.x) - (player.y-y)/(player.x-x)) / (1 + (player.y-y)/(player.x-x) * (player.y-entity.y)/(player.x-entity.x))))) < player.mainweapon.arcrange then
      entity.health = entity.health-player.additionalAttack
      entity.attackedtimer =entity.attackedtimer-love.timer.getDelta()

      data.dropitem(entity)
      if entity.health<=0 then
        table.remove(enemies,i)
        if player.mainweapon.specialprocess<player.mainweapon.specialmaxval then
          player.mainweapon.specialprocess= player.mainweapon.specialprocess+1
          if player.mainweapon.specialmaxval==player.mainweapon.specialprocess then
            player.mainweapon.acquirestate="true"
        end
        end
        data.currentkills=data.currentkills+1
        
        if data.currentkills==(6+(data.currentrarity.id1-1)*2)*3*(data.currentrarity.id1) then
          data.updaterarity()
      end
      env.upgradeupdate()
  end
  end
end
  
end
end
  
function env.InteracAnimUpdate()
    for _,triggers in ipairs(triggeritems) do
        if triggers.state=="closed" then
          data.chestquad=love.graphics.newQuad(32,22,31,36,sprite.chest:getWidth(),sprite.chest:getHeight())
          data.offset=8
        elseif triggers.state=="opened" then
          data.chestquad=love.graphics.newQuad(64,14,31,44,sprite.chest:getWidth(),sprite.chest:getHeight())
          data.offset=0
        end
        love.graphics.draw(sprite.chest,data.chestquad,triggers.x,triggers.y+data.offset)
      end
    
      for _, bullet in ipairs(player.bullets) do
        love.graphics.circle("fill", bullet.x, bullet.y, bullet.radius)
      end
end

return env,data