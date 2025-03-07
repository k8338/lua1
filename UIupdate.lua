function env.drawUI()
  -- data.menu_saved.x=love.graphics.getWidth()-data.menu_saved.width
  -- data.menu_saved.y=love.graphics.getHeight()-data.menu_saved.height
  -- love.graphics.draw(sprite.menu_start,data.menu_saved.quad,data.menu_saved.x,0,0,data.menu_saved.scale,data.menu_saved.scale)
  love.graphics.setFont(love.graphics.newFont(25))
  love.graphics.print("Total kills: "..data.currentkills,20,20,0,1,1)
  love.graphics.setFont(love.graphics.newFont(8))
  love.graphics.print("Survived time: "..math.floor(data.gamedtime/3600)..":"..math.floor(data.gamedtime%3600/60)..":"..math.floor(data.gamedtime%3600%60),20,love.graphics.getHeight()-22,0,1,1)
  love.graphics.setFont(love.graphics.newFont(20))
  love.graphics.printf("Current level: "..data.currentrarity.name,20,45,love.graphics.getWidth()/2-20,"left")
  love.graphics.setFont(love.graphics.newFont(14))
  if data.weapondisplay1.state=="open" then
    love.graphics.rectangle("line",data.weapondisplay1.x-200,data.weapondisplay1.y-50,200,150)
    love.graphics.print(player.mainweapon.name,data.weapondisplay1.x-200+20,data.weapondisplay1.y-50+20)
    love.graphics.setFont(data.curfontI)
    love.graphics.print(player.mainweapon.rarityname,data.weapondisplay1.x-200+20,data.weapondisplay1.y-50+10)
    love.graphics.setFont(data.curfont)
    if player.mainweapon.specialdescription~=nil then
      data.upgradedescription()
    love.graphics.printf(player.mainweapon.specialdescription,data.weapondisplay1.x-200+20,data.weapondisplay1.y-50+25+data.fontsize*2,160,"left")
    end
  end
  if data.weapondisplay2.state=="open" then
    if player.secondweapon.name then
      love.graphics.rectangle("line",data.weapondisplay2.x-200,data.weapondisplay2.y-50,200,150)
    love.graphics.print(player.secondweapon.name,data.weapondisplay2.x-200+20,data.weapondisplay2.y-50+20)
    love.graphics.setFont(data.curfontI)
    love.graphics.print(player.secondweapon.rarityname,data.weapondisplay2.x-200+20,data.weapondisplay2.y-50+10)
    love.graphics.setFont(data.curfont)
    data.upgradedescription()
    love.graphics.printf(player.secondweapon.specialdescription,data.weapondisplay2.x-200+20,data.weapondisplay2.y-50+20+data.fontsize*2,160,"left")
    
  end
  end
  love.graphics.draw(sprite.pan,data.pan.x,data.pan.y,0, data.pan.scale,data.pan.scale)
  love.graphics.circle("line",data.pickupbutton.x,data.pickupbutton.y,30)
  love.graphics.circle("line",data.switchbutton.x,data.switchbutton.y,30)
  love.graphics.rectangle("line",data.weapondisplay1.x,data.weapondisplay1.y,data.weapondisplay1.width,data.weapondisplay1.height)
  love.graphics.rectangle("line",data.weapondisplay2.x,data.weapondisplay2.y,data.weapondisplay2.width,data.weapondisplay1.height)
  love.graphics.setFont(data.curfont)
  love.graphics.print("Primary weapon: ",data.weapondisplay1.x+5,data.weapondisplay1.y+(data.weapondisplay1.height-data.fontsize)/2)
  love.graphics.draw(player.mainweapon.sprite,player.mainweapon.quad,data.weapondisplay1.x+110,data.weapondisplay1.y+6,0,0.5,0.5)
  love.graphics.setFont(data.curfontI)
  love.graphics.print("ability "..player.mainweapon.acquirestate,data.weapondisplay1.x+40+data.curfontI:getWidth("Primary weapon:   "),data.weapondisplay1.y+(data.weapondisplay1.height-data.fontsize)/2)
  love.graphics.setFont(data.curfont)
  if player.secondweapon.name  then

  love.graphics.print("Secondary weapon: ",data.weapondisplay2.x+5,data.weapondisplay2.y+(data.weapondisplay2.height-data.fontsize)/2) 
  love.graphics.draw(player.secondweapon.sprite,player.secondweapon.quad,data.weapondisplay2.x+110,data.weapondisplay2.y+6,0,0.5,0.5)
  love.graphics.setFont(data.curfontI)
  love.graphics.print("ability "..player.secondweapon.acquirestate,data.weapondisplay2.x+40+data.curfontI:getWidth("Secondary weapon:   "),data.weapondisplay2.y+(data.weapondisplay2.height-data.fontsize)/2)
  love.graphics.setFont(data.curfont)

  end
  if player.mainweapon.specialprocess==player.mainweapon.specialmaxval then
    love.graphics.circle("fill",love.graphics.getWidth()-30,data.weapondisplay1.y+(data.weapondisplay1.height-data.fontsize)/2,10)
  end
  if player.secondweapon.specialprocess==player.secondweapon.specialmaxval and player.secondweapon.name then
    love.graphics.circle("fill",love.graphics.getWidth()-30,data.weapondisplay2.y+(data.weapondisplay2.height-data.fontsize)/2,10)
  end
  if data.elembar.state=="in" then
    data.pullbutton.y= data.pullbutton.y+10
    data.elembar.y=data.elembar.y+10
  elseif data.elembar.state=="out" then
    data.pullbutton.y= data.pullbutton.y-10
    data.elembar.y=data.elembar.y-10
  end
  if data.elembar.y>=love.graphics.getHeight() or data.elembar.y<=love.graphics.getHeight()-data.elembar.sprite:getHeight() then
    data.elembar.state="none"
    data.pullbutton.state="none"
  end
  if data.elembar.y<=love.graphics.getHeight()-data.elembar.sprite:getHeight() then 
    love.graphics.draw(sprite.pullbutton,sprite.pullbutton:getWidth()/2+data.pullbutton.x,sprite.pullbutton:getHeight()/2+data.pullbutton.y,math.pi,1,1,sprite.pullbutton:getWidth()/2,sprite.pullbutton:getHeight()/2)
  elseif data.elembar.y>=love.graphics.getHeight() then
    love.graphics.draw(sprite.pullbutton,data.pullbutton.x,data.pullbutton.y,0,1,1)
  end
  love.graphics.draw(data.elembar.sprite,data.elembar.x,data.elembar.y,0,1,1)
  data.playerstats.y=data.elembar.y+5
  love.graphics.printf(data.playerstats.content,data.playerstats.x-20,data.playerstats.y,data.elembar.sprite:getWidth()+40,"left")
end

function env.drawfading()
  if data.alpha2>0 then
    
  love.graphics.setColor(1, 1, 1, data.alpha2) 
  love.graphics.newFont(14)
  love.graphics.setFont(love.graphics.newFont(14))
  love.graphics.printf(data.fading[data.fadingrand],love.graphics.getWidth()/2+50,love.graphics.getHeight()/2-90,200,"left")
  love.graphics.setColor(1, 1, 1,1) 
  data.alpha2 = data.alpha2 - 0.15 * data.dt 
  if data.alpha2<0 then
    data.alpha2=0
  end
end
end
function env.drawrarity()

if data.alpha < 1 and data.fades==2 then
  love.graphics.setColor(1, 1, 1, data.alpha) 
  love.graphics.setFont(love.graphics.newFont(38))
  love.graphics.printf(data.currentrarity.name,0,love.graphics.getHeight()*0.1,love.graphics.getWidth()-20,"center")
  love.graphics.setColor(1, 1, 1,1) 
  love.graphics.setFont(love.graphics.newFont(14))
  data.alpha = data.alpha + 0.3 * data.dt 
  
end
if data.alpha >= 1 and data.fades==2  then
  data.alpha =1
  data.fades=1
  data.ftimer=2.3
end
if data.fades==1 and data.ftimer>0 then
  love.graphics.setColor(1, 1, 1, data.alpha) 
  love.graphics.setFont(love.graphics.newFont(38))
  love.graphics.printf(data.currentrarity.name,0,love.graphics.getHeight()*0.1,love.graphics.getWidth()-20,"center")
  love.graphics.setColor(1, 1, 1,1) 
  love.graphics.setFont(love.graphics.newFont(14))

end
if data.fades==1 and data.ftimer<=0 then
  love.graphics.setColor(1, 1, 1, data.alpha) 
  love.graphics.setFont(love.graphics.newFont(38))
  love.graphics.printf(data.currentrarity.name,0,love.graphics.getHeight()*0.1,love.graphics.getWidth()-20,"center")
  love.graphics.setColor(1, 1, 1,1) 
  love.graphics.setFont(love.graphics.newFont(14))
  data.alpha = data.alpha - 0.3 * data.dt 
  
if data.alpha<=0 then
  data.fades=3
  data.alpha =0
end
end
end

return env,data

