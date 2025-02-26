function enemychasing(self,player)
    self.distance=math.sqrt((player.x-self.x)^2+(player.y-self.y)^2)
    if player.x-self.x >0 then
    
    self.theta=math.atan((player.y-self.y)/(player.x-self.x))
    else
        self.theta=math.atan((player.y-self.y)/(player.x-self.x))+math.pi

    end
    self.x=self.x+math.cos(self.theta)*self.random
    self.y=self.y+math.sin(self.theta)*self.random

end

enemies={{id=1}}

function enemydata(self)
    local roll = math.random(0, 20)  -- Generate a random number between 0 and 20
    if roll <= 15 then
        self.rarity = 0  -- Common
    elseif roll <=19 then
        self.rarity = 1  -- Uncommon
    elseif math.random(0,50)==0 then
        self.rarity = 4  -- Legendary
    elseif math.random(0,50) ==0 then
        self.rarity = 3  -- Epic
    else
        self.rarity = 2   -- Rare
    end
    self.initialized=nil

    self.health=data.currentrarity.id1*(10)*(1+self.rarity)
    self.quad=player.quad
    self.x=math.random(-love.graphics.getWidth()*1.5,1.5*love.graphics.getWidth())
    self.y=math.random(-love.graphics.getHeight()*1.5,1.5*love.graphics.getHeight())
    self.sprite=love.graphics.newImage("maps/8.png")
    self.width=self.sprite:getWidth()
    self.height=self.sprite:getHeight()
    self.distance=math.sqrt((player.x-self.x)^2+(player.y-self.y)^2)
    self.speed= math.random(1,6)
    self.attack = 10*(self.rarity+1)
    self.random=math.random(1,5)/10
    self.attackedtimer=0.12
    self.r=1
    self.g=1
    self.b=1
    self.element=math.random(1,3)
    self.h=(hsl_generate(self)-1)/359
    self.s=(self.attack-(player.additionalAttack)*1)/(4*(player.additionalAttack))*0.25+0.75
    self.l=(self.speed-1)/5*0.6+0.4
    self.elename=data.elements[self.element]
    if self.rarity>=2 then
        self.color={math.random(5,25) ,math.random(75,165),math.random(215,245)}
        
    end
end

function data.dropitem(self)
    player.elements[self.elename]=player.elements[self.elename]+1
    
end



function hsl_generate(self)
--     if self.element==1 then return math.random(5,25) 
-- elseif self.element==2 then return math.random(32,45) elseif self.element==3 then return math.random(55,65) elseif self.element==4 then self.s=(self.attack-(player.mainweapon.attack+player.additionalAttack)*1)/(4*(player.mainweapon.attack+player.additionalAttack))*0.4+0.6
-- return math.random(75,165) elseif self.element==5 then return math.random(175,205) elseif self.element==6 then     self.s=(self.attack-(player.mainweapon.attack+player.additionalAttack)*1)/(4*(player.mainweapon.attack+player.additionalAttack))*0.37+0.63
--     return math.random(215,245) else if math.random(0,1)==0 then
--     self.s=(self.attack-(player.mainweapon.attack+player.additionalAttack)*1)/(4*(player.mainweapon.attack+player.additionalAttack))*0.15+0.6 else     self.s=(self.attack-(player.mainweapon.attack+player.additionalAttack)*1)/(4*(player.mainweapon.attack+player.additionalAttack))*0.2+0.8
--     end return math.random(275,325) end
if self.element==1 then return math.random(5,25) elseif self.element==2 then self.s=(self.attack-(player.additionalAttack)*1)/(4*(player.additionalAttack))*0.4+0.6
    return math.random(75,165) elseif self.element==3 then self.s=(self.attack-(player.additionalAttack)*1)/(4*(player.additionalAttack))*0.37+0.63 return math.random(215,245)
end
end


function enemyspawn(self)
    enemydata(self)
end

function env.drawEnemy(enemies)
    for i,self in ipairs(enemies) do
    if self.x then
    if self.health >0 then
        love.graphics.setBlendMode("replace")

        if self.rarity>=2 then
            love.graphics.setColor(HSL(self.color[math.random(1,6)%3+1]/360,self.s,0.5))
    
        else
            love.graphics.setColor(HSL(self.h,self.s,0.5))
        end
    if self.attackedtimer<=0 then
        self.attackedtimer=0.12
    elseif self.attackedtimer <0.12  then
        love.graphics.setColor(1,0,0)
    end


    --element picked up 
    print(player.y)
    love.graphics.draw(self.sprite,self.quad,self.x+data.background.dx,self.y+data.background.dy,0,3,3)

    love.graphics.setColor(1,1,1)
    love.graphics.setBlendMode("alpha")
else

    table.remove(enemies[i])
end
    end
end
end

function env.updateAllEnemy(enemies)
    for i,entity in ipairs(enemies) do
if entity.x then
    entity.x=entity.x+data.background.dx
    entity.y=entity.y+data.background.dy
    if env.distance(player.x,player.y,entity.x,entity.y) <= 2*love.graphics.getWidth() then
        data.enemycounts=data.enemycounts+1
    end
else
    data.enemycounts=data.enemycounts+1

end
    end
    if data.enemycounts<=5 then
        enemies[#enemies+1] = {}
    end
    data.enemycounts=0
    for i,entity in ipairs(enemies) do

        if entity.initialized==nil then
            enemydata(enemies[i])
            entity.initialized =true
        end
        if entity.health>0 then
        if env.distance(entity.x,entity.y,player.x,player.y)<=500 then

        if math.random(0,2)==0 then
        local o=math.random(0,3)
        if o==0 then
            local fakeplayer={x=entity.x+50,y=entity.y-50}
            enemychasing(enemies[i],fakeplayer)


        elseif o==1 then
            local fakeplayer={x=entity.x-50,y=entity.y+50}

            enemychasing(enemies[i],fakeplayer)

        elseif o==2 then
            local fakeplayer={x=entity.x+50,y=entity.y+50}

            enemychasing(enemies[i],fakeplayer)
        else
            local fakeplayer={x=entity.x-50,y=entity.y-50}

            enemychasing(enemies[i],fakeplayer)
        end
        else
            enemychasing(enemies[i],player)
            end
         end
      
        
end
end

end

return env,data