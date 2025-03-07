function player:weaponsell()
  
end

function player:DirectionUpdate()
  data.isMoving=0
  if (data.move==true and player.direction == "right") then
      
    weadir="left"
    data.n=41
    player.quad=love.graphics.newQuad(0+data.newframes*16,data.n,16,20,sprite.character:getWidth(),sprite.character:getHeight())

    data.isMoving=1
  end
  if (     data.move==true and    player.direction == "left")then
    weadir="right"
    data.n=22
    player.quad=love.graphics.newQuad(0+data.newframes*16,data.n,16,20,sprite.character:getWidth(),sprite.character:getHeight())

    data.isMoving=1
  end
  if (     data.move==true and  player.direction == "down")then
    weadir="right"
    data.n=62
    player.quad=love.graphics.newQuad(0+data.newframes*16,data.n,16,20,sprite.character:getWidth(),sprite.character:getHeight())

    data.isMoving=1
  end
  if  (     data.move==true and player.direction == "up") then
    weadir="left"
    data.n=0
    player.quad=love.graphics.newQuad(0+data.newframes*16,data.n,16,20,sprite.character:getWidth(),sprite.character:getHeight())

    data.isMoving=1
  end
  if data.isMoving==0 then
    data.newframes=1
  end
  player.X=player.trx
  player.Y=player.try
  data.move=false
end
  
function data.attackedUpdate()
    if data.beAttackedTimer<0 then
    for a,entity in ipairs(enemies) do
      if env.distance(entity.x,entity.y,player.x,player.y)<player.width/2 then
        if math.random(0,100)>player.dodge then
        player.health=player.health-(entity.attack-player.defence)
        data.beAttackedTimer=0.5
        end
      end
    end
  end
  end
  
  function data.playerSpriteUpdate()
    if data.isMoving==1 then
      if data.frames>=3 then
        data.frames=0
      end
      data.frames = data.frames + player.speed*data.dt*0.02
    data.newframes=math.floor(data.frames)
    end

  end

function player:draw()
  data.playerSpriteUpdate()
  player:drawattack()

  if player.state=="alive" then
    love.graphics.draw(sprite.character,player.quad,(love.graphics.getWidth()-player.width)/2,(love.graphics.getHeight()-player.height)/2,0,3,3)
 
  end

  if player.health>0 then
    player.healthquad=love.graphics.newQuad(48,0,48*player.health/player.maxhealth,14,336,240)
    love.graphics.draw(sprite.healthbar,player.healthbarquad,(love.graphics.getWidth()-230)/2, love.graphics.getHeight()-80,0,5,5)
    love.graphics.draw(sprite.healthbar,player.healthquad,(love.graphics.getWidth()-230)/2, love.graphics.getHeight()-80,0,5,5)
  else
    player.state="dead"

  end
  if player.isattacking == true then
    
  end

end

return env,data
