
function env.loadTiles()
   startX = sprite.background:getWidth()
   startY =sprite.background:getHeight()

  -- 加载视野范围内的所有块
  for x = -1, 2 do
      for y = -1, 2 do
          -- 检查是否已加载
          if not data.tiles[x] then  data.tiles[x] = {} end
          if not  data.tiles[x][y] then
            data.tiles[x][y] = { -- 生成块数据
                  x = x * startX,
                  y = y * startY,
              }
          end
      end
  end
end



function env.backGroundUpdate()
    
  
end
  function env.drawthebackground()
    
    for x, row in pairs( data.tiles) do
      for y, tile in pairs(row) do
          -- love.graphics.setColor(tile.color)
          love.graphics.draw(sprite.background,data.background.x%startX+data.tiles[x][y].x,data.background.y%startY+data.tiles[x][y].y)
        end
  end
    end

function env.upgradeupdate()
  if 6+(data.currentrarity.id1-1)*2==data.currentkills then
    data.currentrarity.id1=data.currentrarity.id1+1
    data.currentrarity.name=string.rep(data.rarity1[#data.rarity1]..".",math.floor(data.currentrarity.id1 / #data.rarity1) ) .. data.rarity1[(data.currentrarity.id1-1)% #data.rarity1+1 ]
  end
end

return env,data
