player={}
walls={}
entities={}
weapons={}
sprite={}
triggeritems={}
data={}
json = require("dkjson")
Gamestate = require "gamestate"
data={}
env={}
player.mainweapon={}
player.secondweapon={}
env.mainmenu={}
env.gameloop={}
env.saveinterface={}

require ("data")
require	("playerupdate")
require	("environmentalUpdate")
require	("checkstate")
require	("interactions")
require	("enemyupdate")
require	("UIupdate")
require	("weaponUpdate")
require("mainmenu")
require("gameloop")

-- 击败boss就可以解锁boss对应的特殊角色
-- 多角色（开局随机获得一个稀有角色作为默认角色）
-- 所有素材的准备和各种新的地图皮肤（用来填充奖池）
-- boss添加
-- 每日签到只送抽奖卡的碎片，打关唯一获得的奖励是抽奖卡的n/m个碎片，角色和新的地图皮肤和新的boss都需要通过抽奖卡来抽，每十的整数倍个抽奖卡，41%概率是20%概率0.25个抽奖卡或60%普级角色或20%概率出现普级boss/怪，36%概率是20%概率0.5个抽奖卡或35%一个稀有角色或25%地图皮肤或20%的概率出现稀有boss，1%的概率是最高的50%第一个等级的角色或50%的概率出现超级史诗级的boss，6%的概率是20%最高的第二个等级的角色或60%20~50个抽奖卡或20%的概率出现史诗级别的怪物，16%是35%最高的第三个等级的角色或35%地图皮肤或15%1~19张抽奖卡或15%的概率添加稀有boss/怪（当然抽到新的boss也可以算一种增加了的挑战）


function HSL(h, s, l, a)
	if s<=0 then return l,l,l,a end
	h, s, l = h*6, s, l
	local c = (1-math.abs(2*l-1))*s
	local x = (1-math.abs(h%2-1))*c
	local m,r,g,b = (l-.5*c), 0,0,0
	if h < 1     then r,g,b = c,x,0
	elseif h < 2 then r,g,b = x,c,0
	elseif h < 3 then r,g,b = 0,c,x
	elseif h < 4 then r,g,b = 0,x,c
	elseif h < 5 then r,g,b = x,0,c
	else              r,g,b = c,0,x
	end return r+m, g+m, b+m, a
end

function love.load()
	data.load="false"
	Gamestate.registerEvents()
	Gamestate.switch(env.mainmenu)

end



function love.update(dt)
	
end

function love.draw()

end