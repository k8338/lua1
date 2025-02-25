function player:weaponsell()
  
end

function player:DirectionUpdate()
  data.isMoving=0
  if love.keyboard.isDown("right")or love.keyboard.isDown("d") or (player.X>0) then
      
    weadir="left"
    player.direction = "right"
    data.n=41
    data.isMoving=1
  end
  if love.keyboard.isDown("left")or love.keyboard.isDown("a") or player.X<0  then
    weadir="right"
    player.direction = "left"
    data.n=22
    data.isMoving=1
  end
  if love.keyboard.isDown("up")or love.keyboard.isDown("w") or player.Y>0 or data.backgroundtry<0 then
    weadir="right"
    player.direction = "up"
    data.n=62
    data.isMoving=1
  end
  if love.keyboard.isDown("down")or love.keyboard.isDown("s") or player.Y<0 or data.backgroundtry>0 then
    weadir="left"
    player.direction = "down"
    data.n=0
    data.isMoving=1
  end
  if data.isMoving==0 then
    data.newframes=1
  end
  player.X=player.trx
  player.Y=player.try
end
  
function player:DirectionUpdate2()
  data.isMoving=0

  if love.keyboard.isDown("right") then
      
    weadir="left"
    player.direction = "right"
    data.n=41
    data.isMoving=1
    data.background.x=data.background.x-player.speed
    
  end
  if love.keyboard.isDown("left")then
    weadir="right"
    player.direction = "left"
    data.background.x=data.background.x+player.speed

    data.n=22
    data.isMoving=1
  end
  if love.keyboard.isDown("up")then
    weadir="right"
    player.direction = "up"
    data.n=62
    data.background.y=data.background.y+player.speed

    data.isMoving=1
  end
  if love.keyboard.isDown("down") then
    weadir="left"
    player.direction = "down"
    data.background.y=data.background.y-player.speed

    data.n=0
    data.isMoving=1
  end
  if data.isMoving==0 then
    data.newframes=1
  end
  player.X=player.trx
  player.Y=player.try
end

function data.attackedUpdate()
    if data.beAttackedTimer<0 then
    for a,entity in ipairs(enemies) do
      if env.distance(entity.x,entity.y,player.x,player.y)<30 then
        player.health=player.health-entity.attack
        data.beAttackedTimer=0.5

      end
    end
  end
  end
  
  function data.playerSpriteUpdate()
    print(player.health)
    if data.isMoving==1 then
      if data.frames>=3 then
        data.frames=0
      end
      data.frames = data.frames + 0.5
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
    player.healthquad=love.graphics.newQuad(48,0,48*player.health/100,14,336,240)
    love.graphics.draw(sprite.healthbar,player.healthbarquad,(love.graphics.getWidth()-230)/2, love.graphics.getHeight()-80,0,5,5)
    love.graphics.draw(sprite.healthbar,player.healthquad,(love.graphics.getWidth()-230)/2, love.graphics.getHeight()-80,0,5,5)
  else
    player.state="dead"

  end
  if player.isattacking == true then
    
  end

end

return env,data
