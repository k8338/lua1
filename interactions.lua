
  
  function player:drawattack()
    if player.attackphase <= 5 and     player.isattacking==true    then
    love.graphics.circle("line",player.x+player.width/2,player.y+player.height/2,player.attackrange)
    player.attackphase=player.attackphase+1
    else
      player.attackphase=0
      player.isattacking= false
  end
end
  
function player:attack()

  local x,y=0,0
  for i, entity in ipairs(enemies) do
  if env.distance(player.x,player.y,entity.x,entity.y)<player.attackrange+entity.height/2 then
    
    
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
      if math.random(0,1000)<=player.instantkira*10 then
        player.health=player.health+player.lifesteal*entity.health/100
        if player.health>player.maxhealth then
          player.health=player.maxhealth
        end
        entity.health=0
      else
        if player.defenceredu>0 then
          entity.defred[#entity.defred+1]={}
          entity.defred[#entity.defred][1]=player.defenceredudur
          entity.defred[#entity.defred][2]=(1-player.defenceredu/100)
          entity.defence=entity.defence*(1-player.defenceredu/100)
        end
        if math.random(0,100)<=player.critrate then
          entity.health = entity.health-((player.additionalAttack*(player.damageamp/100+1))*player.critdam/100-entity.defence)
          player.health=player.health+player.lifesteal/100*player.additionalAttack*(player.damageamp/100+1)*player.critdam/100-entity.defence
          if player.health>player.maxhealth then
            player.health=player.maxhealth
          end
          entity.attackedtimer =entity.attackedtimer-love.timer.getDelta()
        else
          if player.lifesteal*player.additionalAttack*(player.damageamp/100+1)/100-entity.defence>0 then
      entity.health = entity.health-(player.additionalAttack*(player.damageamp/100+1)-entity.defence)
      player.health=player.health+player.lifesteal*player.additionalAttack*(player.damageamp/100+1)/100-entity.defence
      if player.health>player.maxhealth then
        player.health=player.maxhealth
      end
      entity.attackedtimer =entity.attackedtimer-love.timer.getDelta()
          else
            entity.health = entity.health-(player.additionalAttack*(player.damageamp/100+1)-entity.defence)
            entity.attackedtimer =entity.attackedtimer-love.timer.getDelta()
          end
        end
      end
      data.dropitem(entity)
      if entity.health<=0 then
        table.remove(enemies,i)
        
      i=i-1


      if player.mainweapon.specialprocess<player.mainweapon.specialmaxval then
        player.mainweapon.specialprocess= player.mainweapon.specialprocess+1
        data.upgradedescription()
        if player.mainweapon.specialmaxval==player.mainweapon.specialprocess then
          player.abilityrequired=player.abilityrequired+1
          player.mainweapon.acquirestate="acquired"
          if player.secondweapon.name~=nil then
            player:switchweapon()
            player.secondweapon={}
            data.alpha2=1
    
          end
      end
      end
      data.currentkills=data.currentkills+1
      if player.abilityrequired==data.sum then
        data.currentrarity.id1=data.currentrarity.id1+1
        player.health=player.maxhealth
        data.upgraderarity()
        data.alpha=0
        data.fades=2
        
        data.sum=0
        for i = 3,2+ data.currentrarity.id1 do  
          data.sum = data.sum+ i
        end
    end
  end
  end
end
  
end
end
  
-- function env.InteracAnimUpdate()
--     for _,triggers in ipairs(triggeritems) do
--         if triggers.state=="closed" then
--           data.chestquad=love.graphics.newQuad(32,22,31,36,sprite.chest:getWidth(),sprite.chest:getHeight())
--           data.offset=8
--         elseif triggers.state=="opened" then
--           data.chestquad=love.graphics.newQuad(64,14,31,44,sprite.chest:getWidth(),sprite.chest:getHeight())
--           data.offset=0
--         end
--         love.graphics.draw(sprite.chest,data.chestquad,triggers.x,triggers.y+data.offset)
--       end
    
--       for _, bullet in ipairs(player.bullets) do
--         love.graphics.circle("fill", bullet.x, bullet.y, bullet.radius)
--       end
-- end

return env,data