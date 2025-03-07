function player:switchweapon()
  if player.secondweapon.name then
  if player.secondweapon.specialvalue~=nil then
  if player.secondweapon.acquirestate=="not acquired"then
  if player.secondweapon.special=="attack" then
    player.additionalAttack =player.additionalAttack*(1+ player.secondweapon.specialvalue/100)
  elseif player.secondweapon.special=="movement speed" then
    player.speed =player.speed*(1+ player.secondweapon.specialvalue/100)
  elseif player.secondweapon.special=="attack speed" then
    player.attacktimer =player.attacktimer/(1+ player.secondweapon.specialvalue/100)
    player.attackspeed=math.floor(1/player.attacktimer)
  elseif player.secondweapon.special=="dodge rate" then
    player.dodge =player.dodge+ player.secondweapon.specialvalue
  elseif player.secondweapon.special=="defence" then
    player.defence =player.defence*(1+ player.secondweapon.specialvalue/100)
  elseif player.secondweapon.special=="attack range" then
    player.attackrange =player.attackrange*(1+ player.secondweapon.specialvalue/100)
  elseif player.secondweapon.special=="instant kill rate" then
    player.instantkira =player.instantkira+ player.secondweapon.specialvalue
  elseif player.secondweapon.special=="life steal rate" then
    player.lifesteal =player.lifesteal+ player.secondweapon.specialvalue
  elseif player.secondweapon.special=="damage amplification" then
    player.damageamp =player.damageamp+ player.secondweapon.specialvalue
  elseif player.secondweapon.special=="max health" then
    player.health =player.health*(1+ player.secondweapon.specialvalue/100)
    player.maxhealth =player.maxhealth*(1+ player.secondweapon.specialvalue/100)
  elseif player.secondweapon.special=="critical strike chance" then
    player.critrate =player.critrate+player.secondweapon.specialvalue
  elseif player.secondweapon.special=="critical strike damage" then
    player.critdam =player.critdam+player.secondweapon.specialvalue
  elseif player.secondweapon.special=="attack's defence reduction" then
    player.defenceredu =player.defenceredu+player.secondweapon.specialvalue
  elseif player.secondweapon.special=="attack's defence reduction duration" then
    player.defenceredudur =player.defenceredudur*(1+player.secondweapon.specialvalue/100)
  end
end
end

if self.mainweapon.specialvalue~=nil then
if player.mainweapon.acquirestate=="not acquired" then
  if self.mainweapon.special=="attack" then
    player.additionalAttack=player.additionalAttack - self.mainweapon.specialvalue
  elseif player.mainweapon.special=="movement speed" then
    player.speed =player.speed/(1+ player.mainweapon.specialvalue/100)
  elseif player.mainweapon.special=="dodge rate" then
    player.dodge =player.dodge- player.mainweapon.specialvalue
  elseif player.mainweapon.special=="attack speed" then
    player.attacktimer =player.attacktimer*(1+ player.mainweapon.specialvalue/100)
    player.attackspeed=math.floor(1/player.attacktimer)
  elseif player.mainweapon.special=="defence" then
    player.defence =player.defence/(1+ player.mainweapon.specialvalue/100)
  elseif player.mainweapon.special=="attack range" then
    player.attackrange =player.attackrange/(1+ player.mainweapon.specialvalue/100)
  elseif player.mainweapon.special=="instant kill rate" then
    player.instantkira =player.instantkira- player.secondweapon.specialvalue
  elseif player.mainweapon.special=="life steal rate" then
    player.lifesteal =player.lifesteal- player.secondweapon.specialvalue
  elseif player.mainweapon.special=="damage amplification" then
    player.damageamp =player.damageamp- player.secondweapon.specialvalue
  elseif player.mainweapon.special=="max health" then
    player.health =player.health/(1+ player.secondweapon.specialvalue/100)
    player.maxhealth =player.maxhealth/(1+ player.secondweapon.specialvalue/100)
  elseif player.mainweapon.special=="critical strike chance" then
    player.critrate =player.critrate- player.secondweapon.specialvalue
  elseif player.mainweapon.special=="critical strike damage (base damage: 120%)" then
    player.critdam =player.critdam-player.secondweapon.specialvalue
  elseif player.mainweapon.special=="attack's defence reduction" then
    player.defenceredu =player.defenceredu-player.secondweapon.specialvalue
  elseif player.secondweapon.special=="attack's defence reduction duration" then
    player.defenceredudur =player.defenceredudur/(1+player.secondweapon.specialvalue/100)
  end
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
  if self.mainweapon.specialprocess==self.mainweapon.specialmaxval then
    player:switchweapon()
    player.secondweapon={}
    data.alpha2=1

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
    
  -- if weapon.scanned==0 then
  --   if env.distance(love.graphics.getWidth()/2,love.graphics.getHeight()/2,weapon.x,weapon.y) <= 1.2*love.graphics.getWidth() then
  --     data.weaponamount=data.weaponamount+1
  --     weapon.scanned=1
  --   end
  -- end
  -- if weapon.scanned==1 then
  --   if env.distance(love.graphics.getWidth()/2,love.graphics.getHeight()/2,weapon.x,weapon.y) > 1.2*love.graphics.getWidth() then
  --     data.weaponamount=data.weaponamount-1
  --     weapon.scanned=2
  --   end
  -- end
  if env.distance(love.graphics.getWidth()/2,love.graphics.getHeight()/2,weapon.x,weapon.y) <= 1.2*love.graphics.getWidth() then
    data.weaponamount=data.weaponamount+1
  end
  end
end
if data.weaponamount<=5  then
  data.weaponSpawn()
end
data.weaponamount=0
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
  id=data.weaponid,range=25,name=data.swordname[math.random(1,#data.swordname)],special=data.skillkeys[math.random(1,#data.skillkeys)],acquirestate="not acquired",length=100,arcrange=40,speed=1,visible=true,angle=math.rad(math.random(0,360)),specialprocess=0,scanned=0})
  data.weaponid=data.weaponid+1 
  data.rand=0
      if math.random(1,5000)<=4600 then 
        data.rand = data.currentrarity.id1+math.floor(math.random(1,6)/6)
      elseif math.random(1,5000)<=4950 then
        data.rand = data.currentrarity.id1+math.floor(math.random(12,18)/6)
      elseif math.random(1,5000)<=4999 then
        data.rand = data.currentrarity.id1+math.floor(math.random(24,42)/6)
      elseif math.random(1,5000)<=5000 then
        data.rand = data.currentrarity.id1+math.floor(math.random(320,2100)/math.random(30,40))
      end
        local x=string.rep(data.rarity1[#data.rarity1]..".",math.floor((data.rand+data.currentrarity.id1) / #data.rarity1) ) .. data.rarity1[(data.rand+data.currentrarity.id1-2)% #data.rarity1 +1]
        data.weapons[#data.weapons].rarityname=x
        data.weapons[#data.weapons].rarity=data.rand
        data.weapons[#data.weapons].specialmaxval=6*(data.currentrarity.id1)
        
      
      
 
  for name,value in pairs(data.skillsheet) do
  if data.weapons[#data.weapons].special==name then
    
    data.weapons[#data.weapons].specialvalue= value
    
    data.weapons[#data.weapons].specialdescription="Ability ( (".. data.weapons[#data.weapons].specialprocess.."/"..data.weapons[#data.weapons].specialmaxval..") "..data.weapons[#data.weapons].acquirestate..") : \nincrease your "..data.weapons[#data.weapons].special.." by "..data.weapons[#data.weapons].specialvalue.."%.  "
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
  player.mainweapon.specialdescription="Ability ( (".. player.mainweapon.specialprocess.."/"..player.mainweapon.specialmaxval..") "..player.mainweapon.acquirestate..") : \nincrease your "..player.mainweapon.special.." by "..player.mainweapon.specialvalue.."%.  "

end

return env,data