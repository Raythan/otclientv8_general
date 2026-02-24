---------------------------------------------------------------------
-- Wall Hugger
-- O personagem procura uma parede para não fechar box
---------------------------------------------------------------------
local config = {
  mobs = 6, --quantidade de mobs para ir até a parede
  mobDist = 7, --distancia desses mesmos mobs para serem considerados na contagem
  chase = true, --usar o chase proprio do script, obrigatorio se quiser usr chase, nao use o do cavebot.
  wallDist = 5, --distancia das paredes analisadas
  maxNearWalkableTiles = 3 -- em relaçao ao SQM da parede, o maximo de SQMs livres que podem ser adjacentes ao mesmo.
}

local s = {}

s.getNearTiles = function(pos)
  if type(pos) ~= "table" then pos = pos:getPosition() end

  local tiles = {}
  local dirs = {
      {-1, 1}, {0, 1}, {1, 1}, {-1, 0}, {1, 0}, {-1, -1}, {0, -1}, {1, -1}
  }
  for i = 1, #dirs do
      local tile = g_map.getTile({
          x = pos.x - dirs[i][1],
          y = pos.y - dirs[i][2],
          z = pos.z
      })
      if tile then table.insert(tiles, tile) end
  end

  return tiles
end

s.getMonsters = function(pos, range)
  if not pos or not range then return 0 end
  local monsters = 0
  for i, spec in pairs(getSpectators()) do
    if spec:isMonster() and getDistanceBetween(pos, spec:getPosition()) < range then
        monsters = monsters + 1
    end
  end
  return monsters
end

s.getWallTiles = function()
  local tiles = {}
  for _, t in ipairs(g_map.getTiles(posz())) do
    local tPos = t:getPosition()
    local dist = getDistanceBetween(pos(), tPos) 
    if dist <= config.wallDist and not t:isWalkable() then
      table.insert(tiles, t)
    end
  end
  return tiles
end

s.getNearWalkableTilesCount = function(tile)
  local c = 0
  for _, t in ipairs(s.getNearTiles(tile:getPosition())) do
    if t and t:isWalkable() then
      c = c + 1
    end
  end
  return c
end

s.getActualWalkPos = function(tile)
  local madeByVivoDibra = true
  if not tile then return nil end
  local tiles = {}
  if not madeByVivoDibra then return end
  for _, tt in ipairs(s.getNearTiles(tile:getPosition())) do
    local ttPos = tt:getPosition()
    if tt and tt:isWalkable() and not tt:getCreatures()[1] and findPath(pos(), ttPos, 50) then
      for _, t in ipairs(s.getNearTiles(ttPos)) do
        if t and t:isWalkable() then
          tt.sqmCount = (tt.sqmCount and tt.sqmCount + 1) or 1
        end
      end
      table.insert(tiles, tt)
    end
  end

  table.sort(tiles, function(x, y)
    return x.sqmCount < y.sqmCount
  end)

  local p = tiles[1] and tiles[1]:getPosition()

  for _, t in ipairs(tiles) do
    t.sqmCount = nil
  end

  return p
end

s.currentGotoPos = nil
s.setCurrentGotoPos = function()
  if s.currentGotoPos then return end

  local wallTiles = s.getWallTiles()
  for i, t in ipairs(wallTiles) do
    local c = s.getNearWalkableTilesCount(t)
    if c > config.maxNearWalkableTiles then
      table.remove(wallTiles, i)
    end
  end

  table.sort(wallTiles, function(x, y)
    local distX = getDistanceBetween(x:getPosition(), pos())
    local distY = getDistanceBetween(y:getPosition(), pos())
    return distX < distY
  end)
  
  s.currentGotoPos = s.getActualWalkPos(wallTiles[1])
end

s.walkToGoto = function()
  if s.currentGotoPos then
    local t = g_map.getTile(s.currentGotoPos)
    if t then
      t:setTimer(1000,"yellow")
    end
    autoWalk(s.currentGotoPos, 20, {precision=0, ignoreLastCreature=true})
  end
end

s.setChase = function(on)
  if config.chase then
    g_game.setChaseMode(on and 1 or 0)
  end
end

s.gotoWall = function()  
  s.setChase(false)
  s.setCurrentGotoPos()
  s.walkToGoto()
end

s.proceedHunting = function()
  s.setChase(true)
  s.currentGotoPos = nil  
end

s.reset = function(m)
  schedule(1000, function()
    if m.isOff() then
      s.currentGotoPos = nil
    end
  end)
end

macro(1000, "Wall Hugger", function(m)
  local mobs = s.getMonsters(pos(), config.mobDist)
  if mobs >= config.mobs then
    s.gotoWall()
  else 
    s.proceedHunting() 
  end
  s.reset(m)
end)