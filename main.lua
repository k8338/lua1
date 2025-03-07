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
env.closemenu={}
env.interval={}

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
require("closemenu")
require("interval")

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
	data.fontsize=14
	data.Qaz=love.graphics.newFont("fonts/Qaz/Qaz-Regular.ttf",data.fontsize)
	data.QazI=love.graphics.newFont("fonts/Qaz/Qaz-Italic.ttf",data.fontsize)
	data.Isometric_Black=love.graphics.newFont("fonts/3DIsometric_Font_1_14/3DIsometric-Black.ttf",data.fontsize)
	data.Isometric_Bold=love.graphics.newFont("fonts/3DIsometric_Font_1_14/3DIsometric-Bold.ttf",data.fontsize)
	data.Isometric_Regular=love.graphics.newFont("fonts/3DIsometric_Font_1_14/3DIsometric-Regular.ttf",data.fontsize)
   data.curfont=data.Qaz
   data.curfontI = data.QazI
   data.havesave=false
	love.graphics.setFont(data.curfont)
	data.load=false
	Gamestate.registerEvents()
	Gamestate.switch(env.mainmenu)

end



function love.update(dt)
	
end

function love.draw()

end