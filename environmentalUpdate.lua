
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




  function env.drawthebackground()
    
    for x, row in pairs( data.tiles) do
      for y, tile in pairs(row) do
          -- love.graphics.setColor(tile.color)
          love.graphics.setColor(1, 1, 1, 1)
          love.graphics.draw(sprite.background,data.background.x%startX+data.tiles[x][y].x,data.background.y%startY+data.tiles[x][y].y)
        end
  end
    end


return env,data
