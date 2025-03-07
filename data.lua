
function data.loadfile()
    for line in love.filesystem.lines("playervalue.txt") do
      table.insert(player, line)
    end
    for line in love.filesystem.lines("initvalue.txt") do
      table.insert(data, line)
    end
    for line in love.filesystem.lines("env.txt") do
      table.insert(env, line)
    end
    for line in love.filesystem.lines("enemies.txt") do
      table.insert(enemies, line)
    end
  end
  
function data.valueUpdate()
  data.playerstats.content="Your attack: "..player.additionalAttack.."  \nAttack speed: "..player.attackspeed.." \nAttack range: "..player.attackrange.."  \nDamage amplification: "..player.damageamp.."%  \nCrit Chance: "..player.critrate.."%  \nCrit Damage: "..player.critdam.."%  \nHealth: "..player.maxhealth.."  \nDefence: "..player.defence.."  \nLife steal: "..player.lifesteal.."%  \nDodge: "..player.dodge.."%  \nInstant kill: "..player.instantkira.."%  \nDefence reduction: "..player.defenceredu.."%  \nDefence reduction duration: "..player.defenceredudur.."seconds.  \nMovement speed: "..player.speed/100

  player.trx=math.abs(-player.x +love.graphics.getWidth()/2)-player.width/2
  player.try=math.abs(-player.y +love.graphics.getHeight()/2)-player.height/2

  data.backgroundtrx=data.backgroundtrX
  data.backgroundtry=data.backgroundtrY
  data.backgroundtrX=math.abs(-data.background.x +love.graphics.getWidth()/2)-sprite.background:getWidth()/2
  data.backgroundtrY=math.abs(-data.background.y +love.graphics.getHeight()/2)-sprite.background:getHeight()/2
  data.backgroundtrx=data.backgroundtrX-data.backgroundtrx
  data.backgroundtry=data.backgroundtrY-data.backgroundtry


end


function data.entityUpdate()
    walls={}
    for index, object in ipairs(mapData.layers[3].objects) do
      table.insert(walls, {
          x = data.background.x+mapData.layers[3].objects[index].x,
          y = data.background.y+mapData.layers[3].objects[index].y,
          width = mapData.layers[3].objects[index].width,
          height = mapData.layers[3].objects[index].height
      })
    end
    triggeritems={}
  
    for index, object in ipairs(mapData.layers[4].objects) do
      table.insert(triggeritems, {
          x = data.background.x+mapData.layers[4].objects[index].x,
          y = data.background.y+mapData.layers[4].objects[index].y,
          width = mapData.layers[4].objects[index].width,
          height = mapData.layers[4].objects[index].height,
          id=object.id,
          state=data.cheststate,
          inrange=false
      })
    end
    player.quad=love.graphics.newQuad(0+data.newframes*16,data.n,16,20,sprite.character:getWidth(),sprite.character:getHeight())
    entities={}
  end
function data.savefile()
    love.filesystem.write("playervalue.txt", data.serializeTable(player))
    love.filesystem.write("initvalue.txt", data.serializeTable(data))
    love.filesystem.write("env.txt", data.serializeTable(env))
    love.filesystem.write("enemies.txt", data.serializeTable(enemies))

end
function data.readFile()
    sprite.background=love.graphics.newImage("maps/1.png")
    sprite.character=love.graphics.newImage("maps/2.png")
    sprite.character:setFilter("nearest", "nearest")
    sprite.chest=love.graphics.newImage("maps/4.png")
    sprite.healthbar=love.graphics.newImage("maps/5.png")
    sprite.healthbar:setFilter("nearest", "nearest")
    sprite.pan=love.graphics.newImage("maps/6.png")
    sprite.pullbutton=love.graphics.newImage("maps/9.png")
    
    file=love.filesystem.read("maps/3.json")
    mapData =json.decode(file)
  end
function data.valueInit()
  data.swordname={"Rusted Longsword","Worn Iron Blade"}
    data.golds=10
    data.weadir="right"
    data.speed=26
  data.tiles = {} 
    data.frames=0
    data.newframes=1
    data.keypressed=1
    data.background={}
    data.background.x=-1000
    data.background.y=-1000
    data.isMoving=0
    data.isColliding=false
    data.chestquad=love.graphics.newQuad(32,22,31,36,sprite.chest:getWidth(),sprite.chest:getHeight())
    data.cheststate="closed"
    data.offset=0
    data.movetoedge=false
    data.edge_x=false
    data.edge_y=false
    data.elements={"fire","earth","electron","wind","flow","water","deception"} --打完每个元素的怪之后掉落一个即时启动的技能
    data.elements={"fire","wind","water"}
    data.n=0
    data.additionalAttack=0
    data.beAttackedTimer=0.5
    data.currentkills=0
    data.currentscore=0
    data.rarity1={"Common","Uncommon","Rare","Epic","Legendary","Mythic","Ancient","Divine","Celestial","Transcendent","Ethereal","Apocalyptic","Omniscient","Primordial"}
    data.currentrarity={id1=1}
    data.upgraderarity()
    data.rand=0
    data.skillsheet={["attack's defence reduction duration"]=25,["attack's defence reduction"]=3,
    ["attack"]=10,["defence"]=5,["dodge rate"]=1,["movement speed"]=10,["attack speed"]=5,["attack range"]=10,
    ["instant kill rate"]=0.1,["life steal rate"]=15,["damage amplification"]=5,["max health"]=15,["critical strike chance"]=7,
    ["critical strike damage"]=20}
    
    data.skillkeys =  {
      "attack's defence reduction duration",
      "attack's defence reduction",
      "attack",
      "defence",
      "dodge rate",
      "movement speed",
      "attack speed",
      "attack range",
      "instant kill rate",
      "life steal rate",
      "damage amplification",
      "max health",
      "critical strike chance",
      "critical strike damage"
  }

    data.weapons={}
    data.dt=0
    data.alpha=0
    data.fades=2
    data.ftimer=2
    data.weaponamount=0
    data.pan={x=love.graphics.getWidth()/25,y=love.graphics.getHeight()*1/3,scale=2/3*love.graphics.getHeight()/sprite.pan:getHeight()}
    data.pan.trx=data.pan.x+sprite.pan:getWidth()/2*data.pan.scale
    data.pan.try=data.pan.y+sprite.pan:getHeight()/2*data.pan.scale
    data.backgroundtrX=math.abs(-data.background.x +love.graphics.getWidth()/2)-sprite.background:getWidth()/2
    data.backgroundtrY=math.abs(-data.background.y +love.graphics.getHeight()/2)-sprite.background:getHeight()/2
    data.backgroundtrx=data.backgroundtrX
    data.backgroundtry=data.backgroundtrY
    data.move=false
    data.background.theta=nil
    data.background.X=0
    data.background.Y=0
    data.background.dx=0
    data.background.dy=0
    data.x=data.pan.trx
data.y=data.pan.try
data.weaponid=1
data.pullbutton={state="none",x=love.graphics.getWidth()/2-sprite.pullbutton:getWidth()/2,y=love.graphics.getHeight()-sprite.pullbutton:getHeight(),timer=0}
data.elembar={}
data.elembar.sprite=love.graphics.newImage("maps/10.png")
data.elembar={state="none",sprite=love.graphics.newImage("maps/10.png"),x=love.graphics.getWidth()/2-data.elembar.sprite:getWidth()/2,y=love.graphics.getHeight()}
data.playerstats={x=data.elembar.x+data.elembar.sprite:getWidth()/7,y=data.elembar.y-5,timer=0}

data.pickupbutton={}
data.pickupbutton.sprite=nil
data.pickupbutton={timer=0,sprite=nil,x=love.graphics.getWidth()/5*3,y=love.graphics.getHeight()/2}
data.switchbutton={}
data.switchbutton.sprite=nil
data.switchbutton={timer=0,sprite=nil,x=love.graphics.getWidth()*7/8,y=love.graphics.getHeight()*4/7}
data.weaponcontainer={}
data.weapondisplay1={x=love.graphics.getWidth()*3/5}
data.weapondisplay1={timer=0,state="closed",x=love.graphics.getWidth()*3/5,y=love.graphics.getHeight()*1/6,height=data.fontsize*2,width=love.graphics.getWidth()-data.weapondisplay1.x-10}
data.weapondisplay2={timer=0,state="closed",x=love.graphics.getWidth()*3/5,y=data.weapondisplay1.y+data.weapondisplay1.height,height=data.fontsize*2,width=love.graphics.getWidth()-data.weapondisplay1.x-10}
data.enemycounts=0
data.sum=3
data.alpha2=0
data.fading={"You have gained the sword’s power; now it’s time to find a new one.","You have successfully mastered the power of this sword; it now bestows its blessing upon you.","You have mastered the power of this sword; its physical form departs automatically."}
data.fadingrand=math.random(1,#data.fading)
data.gamedtime=0
data.timer2=0
end
  
function data.upgraderarity()
  data.currentrarity.name=string.rep(data.rarity1[#data.rarity1]..".",math.floor((data.currentrarity.id1-1) / #data.rarity1) ) .. data.rarity1[(data.currentrarity.id1-1)% (#data.rarity1)+1 ]

end

function data.serializeTable(tbl)
    local result = {}
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            table.insert(result, k .. " = { " .. data.serializeTable(v) .. " }")
        else
            table.insert(result, k .. " = " .. tostring(v))
        end
    end
    return table.concat(result, "\n")
end

  function data.playerInit()
    player.additionalAttack=100
    player.height=20*3
    player.width=16*3
    player.x=(love.graphics.getWidth())/2
    player.y=(love.graphics.getHeight())/2
    player.trx=math.abs(-player.x +love.graphics.getWidth()/2)-player.width/2
    player.try=math.abs(-player.y +love.graphics.getHeight()/2)-player.height/2
    player.quad=love.graphics.newQuad(0+data.newframes*16,data.n,16,20,sprite.character:getWidth(),sprite.character:getHeight())
    player.health=100
    player.healthquad=love.graphics.newQuad(48,0,48,14,336,240)
    player.healthbarquad=love.graphics.newQuad(0,0,48,14,336,240)
    player.state="alive"
    data.weaponSpawn()
    player.mainweapon.x,player.mainweapon.y=love.graphics.getWidth()/2,love.graphics.getHeight()/2
    player.secondweapon={}
    player.detectionrange=1000
    player.bullets = {}
    player.isMoving=0
    player.speed=300
    player.isattacking= false
    player.stockedattack=0
    player.direction="down"
    player.attackphase=0
    player.X =player.trx
    player.Y=player.try
    player.theta=nil
    player.defence=5
    player.attacktimer=player.mainweapon.speed
    player.elements={fire=0,wind=0,water=0}
    player.dodge=0
    player.attackrange=player.mainweapon.length
    player.instantkira=0
    player.abilityrequired=0
    player.lifesteal=0
    player.damageamp=0
    player.maxhealth=100
    player.critrate=0
    player.critdam=120
    player.defenceredu=0
    player.defenceredudur=3
    player.attackspeed=math.floor(1/player.attacktimer)
    data.playerstats.content="Your attack: "..player.additionalAttack.."  \nAttack speed: "..(player.attackspeed).." \nAttack range: "..player.attackrange.."  \nDamage amplification: "..player.damageamp.."%  \nCrit Chance: "..player.critrate.."%  \nCrit Damage: "..player.critdam.."%  \nMax health: "..player.maxhealth.."  \nDefence: "..player.defence.."  \nLife steal: "..player.lifesteal.."%  \nDodge: "..player.dodge.."%  \nInstant kill: "..player.instantkira.."%  \nDefence reduction: "..player.defenceredu.."%  \nDefence reduction duration: "..player.defenceredudur.."seconds.  \nMovement speed: "..player.speed/100
    
  end
  
return data,env