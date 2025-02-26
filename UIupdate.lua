function env.drawUI()
-- data.weapondisplay1.state="open"
  love.graphics.print("total kills: "..data.currentkills,20,20,0,2,2)
  if data.weapondisplay1.state=="open" then
    love.graphics.rectangle("line",data.weapondisplay1.x-200,data.weapondisplay1.y-50,200,150)
    love.graphics.print(player.mainweapon.name,data.weapondisplay1.x-200+20,data.weapondisplay1.y-50+20)
    love.graphics.setFont(data.curfontI)
    love.graphics.print(player.mainweapon.rarity,data.weapondisplay1.x-200+20,data.weapondisplay1.y-50+10)
    love.graphics.setFont(data.curfont)
    love.graphics.printf(player.mainweapon.specialdescription,data.weapondisplay1.x-200+20,data.weapondisplay1.y-50+25+data.fontsize*2,200-3*data.fontsize)
  end
  if data.weapondisplay2.state=="open" then
    if player.secondweapon.name then
      love.graphics.rectangle("line",data.weapondisplay2.x-200,data.weapondisplay2.y-50,200,150)
    love.graphics.print(player.secondweapon.name,data.weapondisplay2.x-200+20,data.weapondisplay2.y-50+20)
    love.graphics.printf(player.secondweapon.specialdescription,data.weapondisplay2.x-200+20,data.weapondisplay2.y-50+20+data.fontsize*2,200-3*data.fontsize)
    end
  end
  -- love.graphics.draw(sprite.pan,data.pan.x,data.pan.y,0, data.pan.scale,data.pan.scale)
  love.graphics.circle("line",data.pickupbutton.x,data.pickupbutton.y,30)
  love.graphics.circle("line",data.switchbutton.x,data.switchbutton.y,30)
  love.graphics.rectangle("line",data.weapondisplay1.x,data.weapondisplay1.y,data.weapondisplay1.width,data.weapondisplay1.height)
  love.graphics.rectangle("line",data.weapondisplay2.x,data.weapondisplay2.y,data.weapondisplay2.width,data.weapondisplay1.height)
  love.graphics.print("Primary weapon: ",data.weapondisplay1.x+5,data.weapondisplay1.y+(data.weapondisplay1.height-data.fontsize)/2)
  love.graphics.draw(player.mainweapon.sprite,player.mainweapon.quad,data.weapondisplay1.x+120,data.weapondisplay1.y+(data.weapondisplay1.height-data.fontsize/2),player.mainweapon.angle,0.5,0.5)
  love.graphics.setFont(data.curfontI)
  love.graphics.print(player.mainweapon.acquirestate,data.weapondisplay1.x+40+data.curfontI:getWidth("Primary weapon:   "),data.weapondisplay1.y+(data.weapondisplay1.height-data.fontsize)/2)
  love.graphics.setFont(data.curfont)
  if player.secondweapon.name  then
    
  love.graphics.print("Secondary weapon: ",data.weapondisplay2.x+5,data.weapondisplay2.y+(data.weapondisplay2.height-data.fontsize)/2) 
  love.graphics.draw(player.secondweapon.sprite,player.secondweapon.quad,data.weapondisplay2.x+120,data.weapondisplay2.y+(data.weapondisplay2.height-data.fontsize/2),player.secondweapon.angle,0.5,0.5)
  love.graphics.setFont(data.curfontI)
  love.graphics.print(player.secondweapon.acquirestate,data.weapondisplay2.x+40+data.curfontI:getWidth("Secondary weapon:   "),data.weapondisplay2.y+(data.weapondisplay2.height-data.fontsize)/2)
  love.graphics.setFont(data.curfont)

  end
  if player.mainweapon.specialprocess==player.mainweapon.specialmaxval then
    love.graphics.circle("fill",love.graphics.getWidth()-30,data.weapondisplay1.y+(data.weapondisplay1.height-data.fontsize)/2,10)
  end
  if player.secondweapon.specialprocess==player.secondweapon.specialmaxval and player.secondweapon.name then
    love.graphics.circle("fill",love.graphics.getWidth()-30,data.weapondisplay2.y+(data.weapondisplay2.height-data.fontsize)/2,10)
  end

  if data.elembar.state=="in" then
    data.pullbutton.y= data.pullbutton.y+1
    data.elembar.y=data.elembar.y+1
  elseif data.elembar.state=="out" then
    data.pullbutton.y= data.pullbutton.y-1
    data.elembar.y=data.elembar.y-1
  end
  if data.elembar.y>=love.graphics.getHeight() or data.elembar.y<=love.graphics.getHeight()-data.elembar.sprite:getHeight() then
    data.elembar.state="none"
    data.pullbutton.state="none"
  end
  if data.elembar.y<=love.graphics.getHeight()-data.elembar.sprite:getHeight() then 
    love.graphics.draw(sprite.pullbutton,sprite.pullbutton:getWidth()/2+data.pullbutton.x,sprite.pullbutton:getHeight()/2+data.pullbutton.y,math.pi,1,1,sprite.pullbutton:getWidth()/2,sprite.pullbutton:getHeight()/2)
    love.graphics.draw(data.elembar.sprite,data.elembar.x,data.elembar.y,0,1,1)
  elseif data.elembar.y>=love.graphics.getHeight() then
    love.graphics.draw(sprite.pullbutton,data.pullbutton.x,data.pullbutton.y,0,1,1)

    love.graphics.draw(data.elembar.sprite,data.elembar.x,data.elembar.y,0,1,1)
  end
  love.graphics.draw(data.fire.sprite,data.fire.x,data.fire.y,0,1,1)
  data.fire.x=data.elembar.x+data.elembar.sprite:getWidth()/7-data.fire.sprite:getWidth()
  data.fire.y=data.elembar.y+5
end


function data.movebytouch(self)
  if data.x-data.pan.trx >0 then
  
     self.theta=math.atan((data.y-data.pan.try)/(data.x-data.pan.trx))
    else
         self.theta=math.atan((data.y-data.pan.try)/(data.x-data.pan.trx))+math.pi

    end
 

    self.x=self.x-math.cos(self.theta)*player.speed
    self.y=self.y-math.sin(self.theta)*player.speed

  end


function data.drawTouch()
  for _, id in ipairs(touches) do
  x,y=  love.touch.getPosition(id)
  love.graphics.circle("fill", x, y, 20)
end
end

return env,data

