function player:switchweapon()
  if player.secondweapon.name then
  if player.secondweapon.special then
  if player.secondweapon.special=="attack" then
    player.additionalAttack =player.additionalAttack+ player.secondweapon.specialvalue
  end
end

if self.mainweapon.specialvalue~=nil then

  if self.mainweapon.special=="attack" then
    player.additionalAttack=player.additionalAttack - self.mainweapon.specialvalue
  end

end

for a,c in pairs (player.mainweapon)do
data.weaponcontainer[a]=c
end
for a,c in pairs(player.secondweapon)do
  player.mainweapon[a]=c

end
for a,c in pairs(data.weaponcontainer)do
  player.secondweapon[a]=c

end
end
  
end


function player:pickupitem(number)
  
  for a,c in ipairs(data.weapons) do
    if c.id==number then
      number=a
  data.weapons[number].visible=false
  if next(player.secondweapon) ~=nil then
  data.weapons[#data.weapons+1]={}
  for a,c in pairs(self.secondweapon) do
    data.weapons[#data.weapons][a]=c
  end
  data.weapons[#data.weapons].visible=true
  data.weaponid=data.weaponid+1
end
  self.secondweapon = data.weapons[number]
  table.remove(data.weapons,number)
  if data.weapons[#data.weapons].name==" " then
    table.remove(data.weapons,#data.weapons)
  end
  break
end
end
end

function env.weapondraw()
  

  if weadir =="left" then
      love.graphics.draw(player.mainweapon.sprite,player.mainweapon.quad,player.x+player.width-player.mainweapon.sprite:getWidth()/2,player.y+player.height/10,math.rad(45))
    else 
      love.graphics.draw(player.mainweapon.sprite,player.mainweapon.quad,player.x+player.mainweapon.sprite:getWidth()/2,player.y+player.height/10,math.rad(45))
    end
for i,weapon in ipairs(data.weapons) do
  if weapon.visible==true then
    
  if weapon.scanned==1 then
    if env.distance(love.graphics.getWidth()/2,love.graphics.getHeight()/2,weapon.x,weapon.y) > 2*love.graphics.getWidth() then
      data.weaponamount=data.weaponamount-1
      weapon.scanned=weapon.scanned+1
    end
  end
      if weapon.scanned==0 then
    if env.distance(love.graphics.getWidth()/2,love.graphics.getHeight()/2,weapon.x,weapon.y) <= 2*love.graphics.getWidth() then
      data.weaponamount=data.weaponamount+1
      weapon.scanned=1
    end
  end
    
  end
end
if data.weaponamount<=3  then
  data.weaponSpawn()
end
  for i,weapon in ipairs(data.weapons) do
    data.weapons[i].x,data.weapons[i].y=data.weapons[i].x+data.background.dx,data.weapons[i].y+data.background.dy
    if weapon.visible ==true then
    love.graphics.draw(data.weapons[i].sprite,data.weapons[i].quad,data.weapons[i].x+data.background.dx,data.weapons[i].y+data.background.dy,data.weapons[i].angle)
    end
  end
end

function data.weaponSpawn()
  table.insert(data.weapons,{sprite=love.graphics.newImage("maps/7.png"),quad=love.graphics.newQuad(66,66,33,33,139,180),x=math.random(-love.graphics.getWidth()*1.5,1.5*love.graphics.getWidth()),
  y=math.random(-love.graphics.getHeight()*1.5,1.5*love.graphics.getHeight()),
  id=data.weaponid,range=25,special=data.skillsheet[math.random(1,#data.skillsheet)],acquirestate="ability not acquired",length=100,arcrange=60,speed=1,visible=true,angle=math.rad(math.random(0,360)),specialprocess=0,scanned=0})
  data.weaponid=data.weaponid+1 --name=data.swordname[math.random(1,#data.swordname)]
  local rand=500
  for rand=500,1,-1 do
      if math.random(1,rand^(rand*3/5))==1 or math.random(1,rand*10000)==1 or rand==1 then
        local x=string.rep(data.rarity1[#data.rarity1]..".",math.floor((rand+data.currentrarity.id1) / #data.rarity1) ) .. data.rarity1[(rand+data.currentrarity.id1-2)% #data.rarity1 +1]
        data.weapons[#data.weapons].rarity=x
        data.weapons[#data.weapons].specialmaxval=6+(data.currentrarity.id1-1)*2
        break
      end
      
  end
  for name,value in pairs(data.skillsheet1) do
  if data.weapons[#data.weapons].special==name then
    weapon_value=(rand+data.currentrarity.id1)
    data.weapons[#data.weapons].specialvalue= value
    
    data.weapons[#data.weapons].specialdescription="Special( (".. data.weapons[#data.weapons].specialprocess.."/"..data.weapons[#data.weapons].specialmaxval..") "..data.weapons[#data.weapons].acquirestate..") : \nincrease your "..data.weapons[#data.weapons].special.." by "..data.weapons[#data.weapons].specialvalue..".  "
    break
    --scientific calculation method
  end
end

  
  if data.weapons[#data.weapons].id==1 then
    for a,c in pairs(data.weapons[#data.weapons]) do
  player.mainweapon[a]=c
  player.secondweapon[a]=c
    end
  player.secondweapon.name=nil
    player.mainweapon.scanned="true"
   
    player.secondweapon.scanned="true"

  table.remove(data.weapons, #data.weapons)
  end
end

function data.upgradedescription()
  data.weapons[#data.weapons].specialdescription="Special( (".. data.weapons[#data.weapons].specialprocess.."/"..data.weapons[#data.weapons].specialmaxval..") "..data.weapons[#data.weapons].acquirestate..") : \nincrease your "..data.weapons[#data.weapons].special.." by "..data.weapons[#data.weapons].specialvalue..".  "

end

return env,data