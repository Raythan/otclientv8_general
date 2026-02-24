setDefaultTab("Main")
---------------------------------------------------------------------
-- show / hide icon 
---------------------------------------------------------------------
if storage.ShowIcons == nil then
  storage.ShowIcons = true
end

function toggleIcons()
  for i, child in ipairs(modules.game_interface.getMapPanel():getChildren()) do
    if child:getStyleName() == "BotIcon" then
      if storage.ShowIcons then
        child:show() 
      else
        child:hide()
      end
    end
  end
end

schedule(100, function()
  toggleIcons(storage.ShowIcons)
end)

addButton("", "Toggle Icons", function()
  storage.ShowIcons = not storage.ShowIcons
  toggleIcons()
end)

---------------------------------------------------------------------
--exp per hour icon
---------------------------------------------------------------------
function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

local i_exp = nil
i_exp = addIcon("expIcon", {item={id=112, count=1}, text="Enable For Exp/h"}, macro(100, function(m)
  if player.expSpeed then
    local expHour = comma_value(math.floor(player.expSpeed * 3600))
    i_exp.text:setText(expHour.." exp/h")
  else
    i_exp.text:setText("Waiting Exp...")
  end
end))

i_exp:setWidth(150)

---------------------------------------------------------------------
-- Vocation Spells Icons
---------------------------------------------------------------------
addIcon("Avaicon", {item={id=3161, count=1}, text="AVA"}, macro(200, function(m)
  for _, spec in ipairs(getSpectators(false)) do
    if spec:isPlayer() and spec ~= player then return end
  end

  if g_game.isAttacking() then
    usewith(3161, g_game.getAttackingCreature())
    delay(200)
  end
end))

addIcon("ExoriConIcon", {item={id=3239, count=1}, text="E-Con"}, macro(200, function(m)
  if g_game.isAttacking() then
    say("exori con")
    delay(200)
  end
end))

addIcon("ExoriGranConIcon", {item={id=3239, count=1}, text="Gran Con"}, macro(200, function(m)
  if g_game.isAttacking() then
    say("exori gran con")
    delay(200)
  end
end))

addIcon("ExoriIcon", {item={id=7389, count=1}, text="Exori"}, macro(200, function(m)
  for _, spec in ipairs(getSpectators(false)) do
    if spec:isPlayer() and spec ~= player then return end
  end

  if g_game.isAttacking() and getDistanceBetween(g_game.getAttackingCreature():getPosition(), pos()) == 1 then
    say("exori")
    delay(200)
  end
end))

addIcon("ExoriGranIcon", {item={id=7434, count=1}, text="Exori Gran"}, macro(200, function(m)
  for _, spec in ipairs(getSpectators(false)) do
    if spec:isPlayer() and spec ~= player then return end
  end

  if g_game.isAttacking() and getDistanceBetween(g_game.getAttackingCreature():getPosition(), pos()) == 1 then
    say("exori gran")
    delay(200)
  end
end))

addIcon("SDicon", {item={id=3155, count=1}, text="SDMAX"}, macro(200, function(m)
  if g_game.isAttacking() then
    usewith(3155, g_game.getAttackingCreature())
    delay(200)
  end
end))

---------------------------------------------------------------------
-- Ícone para CaveBot
---------------------------------------------------------------------
addIcon("CaveBotIcon", {item={id=8154, count=1}, text="Cave"}, macro(200, function(m) 
    CaveBot.setOn()
    schedule(200, function() 
        if m.isOff() then
            CaveBot.setOff()
        end
    end)
end))

---------------------------------------------------------------------
-- Ícone para TargetBot
---------------------------------------------------------------------
addIcon("TargetBotIcon", {item={id=8154, count=1}, text="Target"}, macro(200, function(m) 
    TargetBot.setOn()
    schedule(200, function() 
        if m.isOff() then
            TargetBot.setOff()
        end
    end)
end))

---------------------------------------------------------------------
-- Desliga os dois se o manual não estiver ligado
---------------------------------------------------------------------
addIcon("StopCTIcon", {item={id=8154, count=1}, text="STOP C&T"}, macro(200, function(m) 
    CaveBot.setOn()
    TargetBot.setOn()
    schedule(200, function() 
        if m.isOff() then
            CaveBot.setOff()
            TargetBot.setOff()
        end
    end)
end))






---------------------------------------------------------------------
-- ESTUDAR
---------------------------------------------------------------------
-- local spellIcons = {
    -- {
        -- iconItemId = 3067, name = "E-Frigo",        spell = "Exori Frigo",           MobDistance = 3,  PVPSafe = true,  MinMobs = 1,  MinManaPerecent = 15,  MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 8092, name = "E-Vis",          spell = "Exori Vis",             MobDistance = 3,  PVPSafe = true,  MinMobs = 1,  MinManaPerecent = 15,  MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 8084, name = "E-Tera",         spell = "Exori Tera",            MobDistance = 3,  PVPSafe = true,  MinMobs = 1,  MinManaPerecent = 15,  MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 3071, name = "E-flam",         spell = "Exori Flam",            MobDistance = 3,  PVPSafe = true,  MinMobs = 1,  MinManaPerecent = 15,  MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 6533, name = "E-San",          spell = "Exori San",             MobDistance = 3,  PVPSafe = true,  MinMobs = 1,  MinManaPerecent = 15,  MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 3239, name = "E-Con",          spell = "Exori Con",             MobDistance = 7,  PVPSafe = true,  MinMobs = 1,  MinManaPerecent = 15,  MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 7434, name = "Exori Hur",      spell = "Exori Hur",             MobDistance = 5,  PVPSafe = false, MinMobs = 1,  MinManaPerecent = 15,  MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 7389, name = "Exori",          spell = "Exori",                 MobDistance = 1,  PVPSafe = true,  MinMobs = 2,  MinManaPerecent = 15,  MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 7434, name = "Exori Gran",     spell = "Exori Gran",            MobDistance = 1,  PVPSafe = true,  MinMobs = 2,  MinManaPerecent = 15,  MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 8079, name = "M-Frigo",        spell = "Exevo Gran Mas Frigo",  MobDistance = 5,  PVPSafe = true,  MinMobs = 2,  MinManaPerecent = 15,  MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 8081, name = "M-Tera",         spell = "Exevo Gran Mas Tera",   MobDistance = 5,  PVPSafe = true,  MinMobs = 2,  MinManaPerecent = 15,  MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 8078, name = "M-Flam",         spell = "Exevo Gran Mas Flam",   MobDistance = 5,  PVPSafe = true,  MinMobs = 2,  MinManaPerecent = 15,  MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 8080, name = "M-Vis",          spell = "Exevo Gran Mas Vis",    MobDistance = 5,  PVPSafe = true,  MinMobs = 2,  MinManaPerecent = 15,  MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 7429, name = "M-San",          spell = "Exevo Mas San",         MobDistance = 3,  PVPSafe = true,  MinMobs = 2,  MinManaPerecent = 15,  MinMobHP = 100,
    -- },
-- }

-- local runeIcons = {
    -- {
        -- iconItemId = 3155, name = "SDMAX",  rune = 3155, MobDistance = 8, PVPSafe = false, MinMobs = 1, MinManaPerecent = 0, MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 3165, name = "P-MAX",  rune = 3165, MobDistance = 8, PVPSafe = false, MinMobs = 2, MinManaPerecent = 0, MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 3161, name = "AVA",    rune = 3161, MobDistance = 4, PVPSafe = true,  MinMobs = 2, MinManaPerecent = 0, MinMobHP = 100,
    -- },
    -- {
        -- iconItemId = 3191, name = "GFB",    rune = 3191, MobDistance = 4, PVPSafe = true,  MinMobs = 2, MinManaPerecent = 0, MinMobHP = 100,
    -- },
-- }

-- local PlayerStates = modules.game_bot.PlayerStates
-- local buffIcons = {
    -- {
        -- iconItemId = 3079, name = "Haste",      spell = "Utani Hur",        PVPSafe = false,  MinManaPerecent = 15,      onlyAttacking = false,  MobDistance = 5,    MinMobs = 0,    MinMobHP = 100,     condition = PlayerStates.Haste,
    -- },
    -- {
        -- iconItemId = 3079, name = "S-Haste",    spell = "Utani Gran Hur",   PVPSafe = false,  MinManaPerecent = 15,      onlyAttacking = false,  MobDistance = 5,    MinMobs = 0,    MinMobHP = 100,     condition = PlayerStates.Haste,
    -- },
    -- {
        -- iconItemId = 3079, name = "RP Haste",   spell = "Utamo Tempo San",  PVPSafe = false,  MinManaPerecent = 15,      onlyAttacking = false,  MobDistance = 5,    MinMobs = 0,    MinMobHP = 100,     condition = PlayerStates.Haste,
    -- },
    -- {
        -- iconItemId = 3079, name = "EK Haste",   spell = "Utani Tempo Hur",  PVPSafe = false,  MinManaPerecent = 15,      onlyAttacking = false,  MobDistance = 5,    MinMobs = 0,    MinMobHP = 100,     condition = PlayerStates.Haste,
    -- },
    -- {
        -- iconItemId = 3548, name = "Utamo",      spell = "Utamo Vita",       PVPSafe = false,  MinManaPerecent = 15,      onlyAttacking = false,  MobDistance = 5,    MinMobs = 1,    MinMobHP = 100,     condition = PlayerStates.ManaShield,
    -- },
    -- {
        -- iconItemId = 9212, name = "BuffRP",     spell = "Utito Tempo San",  PVPSafe = false,  MinManaPerecent = 15,      onlyAttacking = true,   MobDistance = 5,    MinMobs = 1,    MinMobHP = 100,     condition = PlayerStates.PartyBuff,
    -- },
    -- {
        -- iconItemId = 9209, name = "BuffEK",     spell = "Utito Tempo",      PVPSafe = false,  MinManaPerecent = 15,      onlyAttacking = true,   MobDistance = 5,    MinMobs = 1,    MinMobHP = 100,     condition = PlayerStates.PartyBuff,
    -- },
-- }

-- function distanceFromPlayer(coords)
    -- if not coords then return false end
    -- return getDistanceBetween(pos(), coords)
-- end

-- function getMonstersInRange(pos, range)
    -- if not pos or not range then return false end
    -- local monsters = 0
    -- for i, spec in pairs(getSpectators()) do
        -- if spec:isMonster() and
            -- (g_game.getClientVersion() < 960 or spec:getType() < 3) and
            -- getDistanceBetween(pos, spec:getPosition()) < range then
            -- monsters = monsters + 1
        -- end
    -- end
    -- return monsters
-- end

-- for _, iconData in ipairs(spellIcons) do
    -- local iconId = iconData.iconItemId
    -- local name = iconData.name
    -- local spell = iconData.spell
    -- local MobDistance = iconData.MobDistance
    -- local PVPSafe = iconData.PVPSafe
    -- local MinMobs = iconData.MinMobs or 0
    -- local minMPPercent  = iconData.MinManaPerecent
    -- local MinMobHP = iconData.MinMobHP

    -- addIcon("spellIcon"..name, {item={id=iconId, count=1}, text=name}, macro(200, function(m)
        -- local target = g_game.getAttackingCreature()
        -- if target then
            -- if manapercent() < minMPPercent then return end
            -- if target:getHealthPercent() > MinMobHP then return end
            -- if PVPSafe and not isSafe(8) then return end
            -- local targetPos = target:getPosition()
            -- if distanceFromPlayer(targetPos) > MobDistance then return end    
            -- if getMonstersInRange(pos(), 8) < MinMobs then return end
            -- say(spell)
            -- delay(500)
        -- end
    -- end))
-- end

-- for _, iconData in ipairs(runeIcons) do
    -- local iconId = iconData.iconItemId
    -- local name = iconData.name
    -- local rune = iconData.rune
    -- local MobDistance = iconData.MobDistance
    -- local PVPSafe = iconData.PVPSafe
    -- local MinMobs = iconData.MinMobs or 0
    -- local minMPPercent  = iconData.MinManaPerecent
    -- local MinMobHP = iconData.MinMobHP

    -- addIcon("runeIcon"..name, {item={id=iconId, count=1}, text=name}, macro(200, function(m)
        -- local target = g_game.getAttackingCreature()
        -- if target then
            -- if manapercent() < minMPPercent then return end
            -- if target:getHealthPercent() > MinMobHP then return end
            -- if PVPSafe and not isSafe(8) then return end
            -- local targetPos = target:getPosition()
            -- if distanceFromPlayer(targetPos) > MobDistance then return end    
            -- if getMonstersInRange(pos(), 8) < MinMobs then return end
            -- useWith(rune, target)
            -- delay(500)
        -- end
    -- end))
-- end

-- for _, iconData in ipairs(buffIcons) do
    -- local iconId = iconData.iconItemId
    -- local name = iconData.name
    -- local spell = iconData.spell
    -- local MobDistance = iconData.MobDistance
    -- local PVPSafe = iconData.PVPSafe
    -- local MinMobs = iconData.MinMobs or 0
    -- local minMPPercent  = iconData.MinManaPerecent
    -- local MinMobHP = iconData.MinMobHP
    -- local condition = iconData.condition
    -- local onlyAttacking = iconData.onlyAttacking

    -- addIcon("BuffIcon"..name, {item={id=iconId, count=1}, text=name}, macro(200, function(m)
        -- local target = g_game.getAttackingCreature()
        -- local onlyAttackingOk = not onlyAttacking or target
        -- if not onlyAttackingOk then return end
        -- if onlyAttacking then
            -- if target:getHealthPercent() > MinMobHP then return end
            -- local targetPos = target:getPosition()
            -- if distanceFromPlayer(targetPos) > MobDistance then return end    
        -- end        
        -- if manapercent() < minMPPercent then return end
        -- if PVPSafe and not isSafe(8) then return end
        -- if getMonstersInRange(pos(), 8) < MinMobs then return end
        -- if hasCondition(condition) then return end
        -- say(spell)
        -- delay(500)
    -- end))
-- end



-- local AolConfig = {
    -- AOLId = 3057,
    -- buyCommand = "!aol"
-- }

-- addIcon("AolIcon", {item={id=AolConfig.AOLId, count=1}, text="Aol"}, macro(200, function(m)
    -- local hasAol = getNeck() and getNeck():getId() == AolConfig.AOLId
    -- if hasAol then return end

    -- local aol = findItem(AolConfig.AOLId)
    -- if aol then
        -- moveToSlot(aol, SlotNeck, 1)
    -- else
        -- say(AolConfig.buyCommand)
        -- delay(1000)
    -- end
-- end))



-- local BlessConfig = {
    -- buyAtLogin = true,
    -- buyCommand = "!bless"
-- }

-- BlessConfig.hasBought = false
-- addIcon("BlessIcon", {item={id=3241, count=1}, text="Bless"}, macro(1000, function(m)
    -- if BlessConfig.buyAtLogin and not BlessConfig.hasBought then
        -- say(BlessConfig.buyCommand)
        -- BlessConfig.hasBought = true
    -- end
    -- if g_game.getClientVersion() > 1000 and player:getBlessings() == 0 then
        -- say(BlessConfig.buyCommand)
    -- end
-- end))



-- addIcon("CaveBotIcon", {item={id=9196, count=1}, text="CaveBot"}, macro(200, function(m) 
    -- CaveBot.setOn()    
    -- schedule(200, function() 
        -- if m.isOff() then
            -- CaveBot.setOff()
        -- end
    -- end)
-- end))



-- addIcon("TargetBotIcon", {item={id=12247, count=1}, text="Tgt-Bot"}, macro(200, function(m) 
    -- TargetBot.setOn()
    -- schedule(200, function() 
        -- if m.isOff() then
            -- TargetBot.setOff()
        -- end
    -- end)
-- end))



-- local targetId = nil
-- holdmacro = macro(50, function()
    -- local t = g_game.getAttackingCreature()
    -- if t and not t:isNpc() then
        -- targetId = t:getId()
    -- elseif not t then
        -- g_game.attack(getCreatureById(targetId))
    -- end
-- end) 

-- addIcon("holdAtttackIcon", {item={id=3547, count=1}, text= "HoldATK"}, holdmacro) 

-- onKeyPress(function(keys)
    -- if keys == "Escape" and targetId then
        -- targetId = nil
    -- end
-- end)



-- local equipItem = function(normalId, activeId, slot)
    -- local item = getInventoryItem(slot)
    -- if item and item:getId() == activeId then
        -- return false
    -- end
  
    -- if g_game.getClientVersion() >= 870 then
      -- g_game.equipItemId(normalId)
      -- return true
    -- end
  
    -- local itemToEquip = findItem(normalId)
    -- if itemToEquip then
        -- moveToSlot(itemToEquip, slot, itemToEquip:getCount())
        -- return true
    -- end
-- end
  
-- local m_ssa = macro(50, function()
    -- if equipItem(3081, 3081,SlotNeck) then delay(500) end
-- end)

-- local m_might = macro(50, function()
    -- if equipItem(3048, 3048, SlotFinger) then delay(500) end
-- end)

-- local m_energy = macro(50, function()
    -- if equipItem(3051, 3088, SlotFinger) then delay(500) end
-- end)

-- addIcon("SSAIcon", {item={id=3081, count=1}, text= "SSA", hotkey= "F1"}, m_ssa) 
-- addIcon("MightIcon", {item={id=3048, count=1}, text= "Might", hotkey= "F2"}, m_might) 
-- addIcon("ERingtIcon", {item={id=3051, count=1}, text= "E-Ring", hotkey= "F3"}, m_energy) 



-- local backId = getBack() and getBack():getId() or 2854
-- addIcon("KeepOpenIcon", {item={id=backId, count=1}, text= "Keep"}, macro(1500, function()
    -- for _, c in pairs(getContainers()) do
        -- if c:getContainerItem():getId() == backId then
            -- return
        -- end
    -- end
    -- if getBack() then
        -- g_game.open(getBack())
    -- end
-- end)) 



-- local m_antipush = macro(50, function()
    -- local t = g_map.getTile(pos())
    -- if t then
        -- local topT = t:getTopUseThing()
        -- if not topT:isNotMoveable() then return end
        -- g_game.move(findItem(3031), pos(), 2)
    -- end
-- end)

-- addIcon("AntiPushIcon", {item={id=3031, count=1}, text= "AntPush", hotkey= "F4"}, m_antipush) 



-- local SioConfig = {
    -- hppercent = 85, --friend
    -- spell = 'exura sio "',
    -- delay = 1000,

    -- --player
    -- minHP = 50,
    -- minMP = 50
-- }

-- local m_sio = macro(50, function()
    -- if manapercent() < SioConfig.minMP or hppercent() < SioConfig.minHP then return end
    -- for id, data in pairs(g_game.getVips()) do
        -- local friendName = data[1]
        -- local friend = getCreatureByName(friendName)
        -- if friend then
            -- local fPos = friend:getPosition()
            -- local fTile = g_map.getTile(fPos)
            -- local isReachable = fTile and fTile:canShoot()
            -- local needHeal = friend:getHealthPercent() <= SioConfig.hppercent
            -- if isReachable and needHeal then
                -- say(SioConfig.spell..friendName)
                -- delay(SioConfig.delay)
                -- break
            -- end
        -- end
    -- end
-- end)

-- addIcon("SioVipIcon", {item={id=173, count=1}, text= "Sio Vip"}, m_sio)




