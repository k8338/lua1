

function env.checkTrigger()
    for index,object in ipairs(triggeritems) do
      if triggeritems[index].inrange==true then
          if not(love.keyboard.isDown("space")) then
            data.keypressed=false
          end
          if love.keyboard.isDown("space") and data.keypressed==false and triggeritems[index].state=="closed" then
            data.keypressed = true
            data.cheststate="opened"
          elseif love.keyboard.isDown("space") and data.keypressed==false and triggeritems[index].state=="opened" then
            data.keypressed = true
            data.cheststate="closed"
          end
      end
    end
end

function env.distance(x1,y1,x2,y2)
  return math.sqrt((x1-x2)^2+(y1-y2)^2)
end

function env.checktouch()
  data.move=false
  touches = love.touch.getTouches()
  for _, id in ipairs(touches) do
     x, y = love.touch.getPosition(id)  --env.distance(x,y,data.pan.trx,data.pan.try) <= sprite.pan:getWidth()/2*data.pan.scale
    if x<love.graphics.getWidth()/2 then
     data.move=true
     data.x=x
     data.y=y
    end
    if x>=love.graphics.getWidth()/2 and y > 1/5*love.graphics.getHeight() then
      if player.attacktimer<=0 then
        player:attack()
        player.isattacking= true
        player.attacktimer=player.mainweapon.speed
      end
    end
    if data.pickupbutton.timer<=0 and env.distance(x,y,data.pickupbutton.x,data.pickupbutton.y)<=20 then --pickupbutton
      data.pickupbutton.timer=0.5
      for _,weapon in ipairs(data.weapons) do
        if  env.distance(weapon.x,weapon.y,love.graphics.getWidth()/2,love.graphics.getHeight()/2) <50 and weapon.visible==true then
           player:pickupitem(weapon.id)
        end
      end
    end
    if data.pullbutton.timer<=0 then --pullbutton
    if x-data.pullbutton.x<=sprite.pullbutton:getWidth() and x>=data.pullbutton.x and y>=data.pullbutton.y and y-data.pullbutton.y<=sprite.pullbutton:getHeight() then
      if data.elembar.y>=love.graphics.getHeight() then
        data.elembar.state="out"
        data.pullbutton.state="out"
      else 
          data.elembar.state="in"
          data.pullbutton.state="in"
      end
    end
  end
  
  if data.weapondisplay1.timer<=0 and  x-data.weapondisplay1.x<=data.weapondisplay1.width and y-data.weapondisplay1.y<=data.weapondisplay1.height  then
    if data.weapondisplay1.state=="open" then
    data.weapondisplay1.state="closed"
    data.weapondisplay1.timer=0.5
    else
      data.weapondisplay1.state="open"
    data.weapondisplay1.timer=0.5
    end
  end
  
  if data.weapondisplay2.timer<=0 and x-data.weapondisplay2.x<=data.weapondisplay2.width and y-data.weapondisplay2.y<=data.weapondisplay2.height then
    if data.weapondisplay2.state=="open" then
    data.weapondisplay2.state="closed"
    data.weapondisplay2.timer=0.5
    else
      data.weapondisplay2.state="open"
      data.weapondisplay2.timer=0.5
    end
  end

  if env.distance(x,y,data.switchbutton.x,data.switchbutton.y)<=20 then
  if data.switchbutton.timer <=0 then
    data.switchbutton.timer=0.5
    player:switchweapon()
  end
  end
end
end

  function env.checkCollision(player, objects,offset1,type)

    for index, object in ipairs(objects) do
      if  player.x -offset1 < object.x + object.width and
          player.x -offset1+ player.width > object.x and
          player.y -offset1 < object.y + object.height and
          player.y -offset1+ player.height > object.y then
          
          if type=="triggeritem" then
            objects[index].inrange=true
            return
          end
          if math.abs(player.x - object.x-object.width) <5 then
            data.background.x=data.background.x-0.05
          end
          if math.abs(player.x+player.width - object.x) <5 then
            data.background.x=data.background.x+0.05
          end
          if math.abs(player.y - object.y-object.height) <5 then
            data.background.y=data.background.y-0.05
          end
          if math.abs(player.y +player.height- object.y) <5 then
            data.background.y=data.background.y+0.05
          end
          
          if type=="walls" then
            data.isColliding=true
            return
          end
          
  
      else 
          if type=="walls" then
            data.isColliding=false
          end
          if type=="triggeritem" then
            objects[index].inrange=false
          end


          
      end
    end
  end

  
  function env.checkEdge()
    if data.edge_x==true and (player.trx==0)  then
      data.movetoedge=false
      data.edge_x=false
    elseif data.edge_y==true and (player.try==0) then
      data.movetoedge=false
      data.edge_y=false
    elseif  -data.background.y<=love.graphics.getHeight()/2 or sprite.background:getHeight()+data.background.y<=love.graphics.getHeight()  then
      data.movetoedge=true
      data.edge_y=true

    elseif -data.background.x<=love.graphics.getWidth()/2 or sprite.background:getWidth()+data.background.x<=love.graphics.getWidth() then
      data.movetoedge=true
      data.edge_x=true
    else
      data.movetoedge=false
      data.edge_x=false
      data.edge_y=false
    end
  end
  
return data, env