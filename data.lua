
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
      table.insert(env, line)
    end
  end
  
function data.valueUpdate()
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
    love.filesystem.write("env.txt", data.serializeTable(enemies))

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
    -- data.elements={"fire","metal","artificiality","shards","patina","dust","depiction"}
    data.elements={"fire","earth","electron","wind","flow","water","deception"} --打完每个元素的怪之后掉落一个即时启动的技能
    data.elements={"fire","wind","water"}
    data.n=0
    data.additionalAttack=0
  
    data.beAttackedTimer=0.5
    data.currentkills=0
    data.currentscore=0
    data.rarity1={"Common","Uncommon","Rare","Epic","Legendary","Mythic","Ancient","Divine","Celestial","Transcendent","Ethereal","Apocalyptic","Omniscient","Primordial"}
    data.currentrarity={name="Common",id1=1}

    data.skillsheet={"defence reduction","attack","defence","dodge rate","movement speed","attack speed","attack range","instant kill rate","life steal rate","damage amplification","health points","critical strike chance","critical strike damage (base damage: 120%)"}
    data.skillsheet1={}
    data.skillsheet2={"defence reduction"}
    local meta = {
      __index = function(table, key)
          if key == "attack" then
              return  weapon_value
          elseif key == "defence" then
              return 100 * 1.5 
            elseif key == "dodge rate" then
              return 100 * 1.5 
            elseif key == "movement speed" then
              return 100 * 1.5 
            elseif key == "attack speed" then
              return 100 * 1.5
            elseif key == "attack range" then
              return 100 * 1.5
            elseif key == "instant kill rate" then
              return 100 * 1.5
            elseif key == "life steal rate" then
              return 100 * 1.5
            elseif key == "damage amplification" then
              return 100 * 1.5
            elseif key == "health points" then
              return 100 * 1.5
            elseif key == "critical strike chance" then
              return 100 * 1.5
            elseif key == "critical strike damage (base damage: 120%)" then
              return 100 * 1.5
          end
      end
  }
  setmetatable(data.skillsheet1,meta)
    
    data.weapons={}

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
data.fire={sprite=love.graphics.newImage("maps/11.png"),x=data.elembar.x+data.elembar.sprite:getWidth()/7,y=data.elembar.y-5,timer=0}
data.pickupbutton={}
data.pickupbutton.sprite=nil
data.pickupbutton={timer=0,sprite=nil,x=love.graphics.getWidth()/5*3,y=love.graphics.getHeight()/2}
data.switchbutton={}
data.switchbutton.sprite=nil
data.switchbutton={timer=0,sprite=nil,x=love.graphics.getWidth()*7/8,y=love.graphics.getHeight()*4/7}
data.weaponcontainer={}
data.weapondisplay1={state="closed",x=love.graphics.getWidth()*3/5,y=love.graphics.getHeight()*1/6,height=40}
data.weapondisplay1={timer=0,state="closed",x=love.graphics.getWidth()*3/5,y=love.graphics.getHeight()*1/6,height=data.fontsize*2,width=love.graphics.getWidth()-data.weapondisplay1.x-10}
data.weapondisplay2={timer=0,state="closed",x=love.graphics.getWidth()*3/5,y=data.weapondisplay1.y+data.weapondisplay1.height,height=data.fontsize*2,width=love.graphics.getWidth()-data.weapondisplay1.x-10}
data.enemycounts=0
end
  
function data.updaterarity()
  data.currentrarity.id1=data.currentrarity.id1+1
  if data.currentrarity.id1% #data.rarity1 ==0 then
    data.currentrarity.id1=data.currentrarity.id1+1
  end
  data.currentrarity.name=string.rep(data.rarity1[#data.rarity1]..".",math.floor(data.currentrarity.id1 / #data.rarity1) ) .. data.rarity1[data.currentrarity.id1% #data.rarity1 ]

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
    player.additionalAttack=10
    player.height=20*3
    player.width=16*3
    player.x=(love.graphics.getWidth()-player.width)/2
    player.y=(love.graphics.getHeight()-player.height)/2
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
    player.speed=2
    player.isattacking= false
    player.stockedattack=0
    player.direction="down"
    player.attackphase=0
    player.X =player.trx
    player.Y=player.try
    player.theta=nil
    player.attacktimer=0
    player.elements={fire=0,wind=0,water=0}
  end
  
return data,env