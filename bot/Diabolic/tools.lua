-- tools tab
setDefaultTab("Hotkeys")

--
UI.Separator()
 local scriptsPanelName = "Scriptss"
  local ui = setupUI([[
Panel

  height: 50

  Button
    id: editScript
    color: pink
    font: verdana-11px-rounded
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 50
    text: - SCRIPTS -


  ]], parent)
  ui:setId(scriptsPanelName)

  if not storage[scriptsPanelName] then
    storage[scriptsPanelName] = { 

    }
  end


rootWidget = g_ui.getRootWidget()
if rootWidget then
    ScriptWindow = UI.createWindow('ScriptsWindow', rootWidget)
    ScriptWindow:hide()
    TabBar = ScriptWindow.tmpTabBar
    TabBar:setContentWidget(ScriptWindow.tmpTabContent)
    for v = 1, 1 do


scpPanel = g_ui.createWidget("sPanel") -- Creates Panel
scpPanel:setId("panelButtons") -- sets ID

scpPanel2 = g_ui.createWidget("sPanel") -- Creates Panel
scpPanel2:setId("panelButtons") -- sets ID

scpPanel3 = g_ui.createWidget("sPanel") -- Creates Panel
scpPanel:setId("panelButtons") -- sets ID

scpPanel4 = g_ui.createWidget("sPanel") -- Creates Panel
scpPanel:setId("panelButtons") -- sets ID

scpPanel5 = g_ui.createWidget("sPanel") -- Creates Panel
scpPanel:setId("panelButtons") -- sets ID

TabBar:addTab("Script", scpPanel)
                cor= UI.Label("Scripts:\nBy:@Luiz",scpPanel)
cor:setColor("orange")


onKeyPress(function(keys) 
 if (bmpw.isOn()) and not isInPz() then
 consoleModule = modules.game_console
  if (keys == bugn and not consoleModule:isChatEnabled()) then
   ppos = pos()
   ppos.y = ppos.y - 6
   bgTile = g_map.getTile(ppos)
   if bgTile then
    use(g_map.getTile(ppos):getTopUseThing())
   end
  elseif (keys == bugs and not consoleModule:isChatEnabled()) then
   ppos = pos()
   ppos.y = ppos.y + 7
   bgTile = g_map.getTile(ppos)
   if bgTile then
    use(g_map.getTile(ppos):getTopUseThing())
   end
  elseif (keys == buge and not consoleModule:isChatEnabled()) then
   ppos = pos()
   ppos.x = ppos.x - 7
   bgTile = g_map.getTile(ppos)
   if bgTile then
    use(g_map.getTile(ppos):getTopUseThing())
   end
  elseif (keys == bugd and not consoleModule:isChatEnabled()) then
   ppos = pos()
   ppos.x = ppos.x + 7
   bgTile = g_map.getTile(ppos)
   if bgTile then
    use(g_map.getTile(ppos):getTopUseThing())
   end
  end
 end
end)
   
   


bmpw = macro(1, 'Bug Map', 'shift+a', function() --aa
 if not bugconfig or (bugconfig and bugconfig ~= 'WASD') then
  bugn = 'W'
  bugs = 'S'
  buge = 'A'
  bugd = 'D'
  bugconfig = 'WASD'
 end
end,scpPanel)




 local dropItems = { 3031, 3035 }
local maxStackedItems = 10
local dropDelay = 600

gpAntiPushDrop = macro(dropDelay , "Anti-Push", "shift+d", function ()
  antiPush()
end,scpPanel)

onPlayerPositionChange(function()
    antiPush()
end)

function antiPush()
  if gpAntiPushDrop:isOff() then
    return
  end

  local tile = g_map.getTile(pos())
  if tile and tile:getThingCount() < maxStackedItems then
    local thing = tile:getTopThing()
    if thing and not thing:isNotMoveable() then
      for i, item in pairs(dropItems) do
        if item ~= thing:getId() then
            local dropItem = findItem(item)
            if dropItem then
              g_game.move(dropItem, pos(), 2)
            end
        end
      end
    end
  end
end





TabBar:addTab("Follow", scpPanel4)
        cor= UI.Label("Follow:\nBy:@Luiz",scpPanel4)
cor:setColor("orange")
        UI.Separator(scpPanel4)




TabBar:addTab("Escada", scpPanel3)
        cor= UI.Label("Escada:\nBy:@Luiz",scpPanel3)
cor:setColor("orange")
        UI.Separator(scpPanel3)

TabBar:addTab("Treinar", scpPanel5)
        cor= UI.Label("Treino:\nBy:@Luiz",scpPanel5)
cor:setColor("orange")
        UI.Separator(scpPanel5)

        UI.Separator(scpPanel5)

if type(storage.manatrainer) ~= "table" then
  storage.manatrainer = {on=false, title="mana%", text="Treinar Mana", min=0, max=90}
end

for _, healingInfos in ipairs({storage.manatrainer}) do
  local healingmacro = macro(20, function()
    local mana = manapercent()
    if healingInfos.max <= mana and mana >= healingInfos.min then
      if TargetBot then 
        TargetBot.saySpell(healingInfos.text) -- sync spell with targetbot if available
      else
        say(healingInfos.text)
      end
    end
  end,scpPanel5)
  healingmacro.setOn(healingInfos.on)

  UI.DualScrollPanel(healingInfos, function(widget, newParams) 
    healingInfos = newParams
    healingmacro.setOn(healingInfos.on)
  end,scpPanel5)
end 
macro(20, "Dance", function()
    turn(math.random(0, 3))
end,scpPanel5)
        UI.Separator(scpPanel5)

  

local function doFormatMin(v)
 if v < 1000 then
  return '00:00'
 end
 v = v/1000
 local mins = 00
 local seconds = 00
 if v >= 60 then
  mins = string.format("%02.f", math.floor(v / 60))
 end
 seconds = string.format("%02.f", math.abs(math.floor(math.mod(v, 60))))
 return mins .. ":" .. seconds
end

local widget = setupUI([[
Panel
  size: 14 14
  anchors.bottom: parent.bottom
  anchors.left: parent.left
  margin-bottom: 305
]], modules.game_interface.getMapPanel())

local timepk = g_ui.loadUIFromString([[
Label
  color: white
  font: verdana-11px-rounded
  background-color: #00000040
  opacity: 0.87
  text-auto-resize: true 
]], widget)


addTextEdit("pkz", storage.pkz or "Tempo do PK 1 minuto = 60", function(widget, text) storage.pkz = text
end,scpPanel5)

        UI.Separator(scpPanel5)

        cor= UI.Label("- Sense Posição -",scpPanel5)
cor:setColor("#00FFFF")


local widget = setupUI([[
Panel
  height: 400
  width: 900
]], modules.game_interface.getMapPanel())

local tcLastSense = g_ui.loadUIFromString([[
Label
  color: green
  font: verdana-11px-rounded
  background-color: #00000090
  opacity: 0.87
  text-horizontal-auto-resize: true
  text: Sense  
]], widget)

tcLastSense:setPosition({y = storage.pp, x =  storage.pc})

onTextMessage(function(mode, text)
    if mode == 20 then
        local regex = "([a-z A-Z]*) is ([a-z -A-Z]*)to the ([a-z -A-Z]*)."
        local data = regexMatch(text, regex)[1]
        if data and data[2] and data[3] then
            schedule(10, function()
                tcLastSense:setText(text)
            end)
        end
    end
end,scpPanel)



addTextEdit("pp", storage.pp or "Posição da tela x", function(widget, text) storage.pp = text
end,scpPanel5)

addTextEdit("pc", storage.pc or "Posição da tela y", function(widget, text) storage.pc = text
end,scpPanel5)


senses= macro(500, "Sense Target", "shift+f", function()
if sense then 
say('sense "' .. sense )
end
end,scpPanel)



addIcon("Sense", {outfit={mount=849,feet=10,legs=10,body=178,type=75,auxType=0,addons=3,head=48}, text="Sense"},senses)


macro(1, function() if g_game.isAttacking() and g_game.getAttackingCreature():isPlayer() then sense = g_game.getAttackingCreature():getName() end end)









local doAutoLootLook = macro(5000, "Auto Loot Look",  function() end,scpPanel)
onTextMessage(function(mode, text)
    if mode == 20 and text:find("You see") and doAutoLootLook:isOn() then
        local regex = [[You see (?:an|a)([a-z A-Z]*).]]
        local data = regexMatch(text, regex)[1]
        if data and data[2] then
            say('!autoloot ' ..data[2]:trim())
        end
    end
end,scpPanel)


local showhp = macro(20000, "Monstro Vida %", function() end,scpPanel)
onCreatureHealthPercentChange(function(creature, healthPercent)
    if showhp:isOff() then  return end
    if creature:isMonster() or creature:isPlayer() and creature:getPosition() and pos() then
        if getDistanceBetween(pos(), creature:getPosition()) <= 5 then
            creature:setText(healthPercent .. "%")
        else
            creature:clearText()
  

      end
    end
end,scpPanel)


local moneyIds = {3031, 3035} -- gold coin, platinium coin
macro(1000, "Converter Dinheiro", function()
  local containers = g_game.getContainers()
  for index, container in pairs(containers) do
    if not container.lootContainer then -- ignore monster containers
      for i, item in ipairs(container:getItems()) do
        if item:getCount() == 100 then
          for m, moneyId in ipairs(moneyIds) do
            if item:getId() == moneyId then
              return g_game.use(item)            
            end
          end
        end
      end
    end
  end
end,scpPanel)


atkLowhp = macro(100, "Atacar Monstros", function() 
  local battlelist = getSpectators();
  local closest = 10
  local lowesthpc = 101
  for key, val in pairs(battlelist) do
    if val:isMonster() and not val:isPlayer() and not val:isNpc() 
and val:getName():lower() ~= 'emberwing'
and val:getName():lower() ~= 'grovebeast' 
and val:getName():lower() ~= 'skullfrost'
and val:getName():lower() ~= 'thundergiant'
and val:getName():lower() ~= 'zodom'
and val:getName():lower() ~= 'blade' then
      if getDistanceBetween(player:getPosition(), val:getPosition()) <= closest then
        closest = getDistanceBetween(player:getPosition(), val:getPosition())
        if val:getHealthPercent() < lowesthpc then
          lowesthpc = val:getHealthPercent()
        end
      end
    end
  end   for key, val in pairs(battlelist) do
    if val:isMonster() and not val:isPlayer() and not val:isNpc() 
and val:getName():lower() ~= 'emberwing'
and val:getName():lower() ~= 'grovebeast' 
and val:getName():lower() ~= 'skullfrost'
and val:getName():lower() ~= 'thundergiant'
and val:getName():lower() ~= 'zodom'
and val:getName():lower() ~= 'blade' then
      if getDistanceBetween(player:getPosition(), val:getPosition()) <= closest then
        if g_game.getAttackingCreature() ~= val and val:getHealthPercent() <= lowesthpc then
          g_game.attack(val)
          break
        end
      end
    end
  end
end,scpPanel)

    end
end

  ScriptWindow.closeButton.onClick = function(widget)
    ScriptWindow:hide()
  end  
ui.editScript.onClick = function(widget)
    ScriptWindow:show()
    ScriptWindow:raise()
    ScriptWindow:focus()
  end



followName = "autofollow"
if not storage[followName] then storage[followName] = { player = 'name'} end
local toFollowPos = {}
followTE = UI.TextEdit(storage[followName].player or "name", function(widget, newText)
    storage[followName].player = newText
end,scpPanel4)

local followChange = macro(1000, "Follow",  function()
local followw= storage[followName].player 
    if g_game.isFollowing() then
        return
    end
    for _, followcreature in ipairs(g_map.getSpectators(pos(), false)) do
        if (followcreature:getName() == followw and getDistanceBetween(pos(), followcreature:getPosition()) <= 8) then
            g_game.follow(followcreature)
        end
    end
end,scpPanel4)

local followMacro = macro(20, "Follow Ataque", function()
    local target = getCreatureByName(storage[followName].player)
    if target then
        local tpos = target:getPosition()
        toFollowPos[tpos.z] = tpos
    end
    if player:isWalking() then
        return
    end
    local p = toFollowPos[posz()]
    if not p then
        return
    end
    if autoWalk(p, 20, { ignoreNonPathable = true, precision = 1 }) then
        delay(100)
    end
end,scpPanel4)

onPlayerPositionChange(function(newPos, oldPos)
  if followChange:isOff() then return end
  if (g_game.isFollowing()) then
    tfollow = g_game.getFollowingCreature()

    if tfollow then
      if tfollow:getName() ~= storage[followName].player then
        followTE:setText(tfollow:getName())
        storage[followName].player = tfollow:getName()
      end
    end
  end
end,scpPanel4)

if not storage.doorIdss then
    storage.doorIdss = { 5129, 5102, 5111, 5120, 11246 }
end

local moveTime = 100     -- Wait time between Move, 2000 milliseconds = 2 seconds
local moveDist = 2        -- How far to Walk
local useTime = 100     -- Wait time between Use, 2000 milliseconds = 2 seconds
local useDistance = 7     -- How far to Use

local function properTable(t)
    local r = {}
    for _, entry in pairs(t) do
        table.insert(r, entry.id)
    end
    return r
end

UI.Separator(scpPanel3)
cor = UI.Label("Escada USE", scpPanel3)
cor:setColor("red")

local doorContainerr = UI.Container(function(widget, items)
    storage.doorIdss = items
    doorIds = properTable(storage.doorIdss)
end, true, scpPanel3)

doorContainerr:setHeight(35)
doorContainerr:setItems(storage.doorIdss)
doorIds = properTable(storage.doorIdss)

clickDoorr = onKeyPress(function(keys)
    for i, tile in ipairs(g_map.getTiles(posz())) do
        local item = tile:getTopUseThing()
        if item and table.find(doorIds, item:getId()) then
            local tPos = tile:getPosition()
            local distance = getDistanceBetween(pos(), tPos)
            if (distance <= useDistance) then
			if keys == (storage.atalho) then
                use(item)
                return delay(useTime)
            end
          end

            if (distance <= moveDist and distance > useDistance) then
                if findPath(pos(), tPos, moveDist, { ignoreNonPathable = true, precision = 1 }) then
                    autoWalk(tPos, moveTime, { ignoreNonPathable = true, precision = 1 })
                    return delay(waitTime)
                end
            end
        end
    end
end, scpPanel3)
UI.Separator(scpPanel3)


















if not storage.doorIds then
    storage.doorIds = { 5129, 5102, 5111, 5120, 11246 }
end

local moveTime = 100     -- Wait time between Move, 2000 milliseconds = 2 seconds
local moveDist = 2        -- How far to Walk
local useTime = 100     -- Wait time between Use, 2000 milliseconds = 2 seconds
local useDistance = 7     -- How far to Use

local function properTable(t)
    local r = {}
    for _, entry in pairs(t) do
        table.insert(r, entry.id)
    end
    return r
end

UI.Separator(scpPanel3)
cor = UI.Label("Escada", scpPanel3)
cor:setColor("red")

local doorContainer = UI.Container(function(widget, items)
    storage.doorIds = items
    doorId = properTable(storage.doorIds)
end, true, scpPanel3)

doorContainer:setHeight(35)
doorContainer:setItems(storage.doorIds)
doorId = properTable(storage.doorIds)

clickDoor = onKeyPress(function(keys)
    for i, tile in ipairs(g_map.getTiles(posz())) do
        local item = tile:getTopUseThing()
        if item and table.find(doorId, item:getId()) then
            local tPos = tile:getPosition()
            local distance = getDistanceBetween(pos(), tPos)
            if (distance <= useDistance) then
			if keys == (storage.atalho) then
            autoWalk(tile:getPosition(), 100, {ignoreNonPathable = true})
                return delay(useTime)
            end
          end

            if (distance <= moveDist and distance > useDistance) then
                if findPath(pos(), tPos, moveDist, { ignoreNonPathable = true, precision = 1 }) then
                    autoWalk(tPos, moveTime, { ignoreNonPathable = true, precision = 1 })
                    return delay(waitTime)
                end
            end
        end
    end
end, scpPanel3)
UI.Separator(scpPanel3)

cor = UI.Label("Botão de atalho:", scpPanel3)
cor:setColor("red")


addTextEdit("atalho", storage.atalho or "F9", function(widget, text) storage.atalho = text
end, scpPanel3)

UI.Separator(scpPanel3)


UI.Separator()




local comboPanelName = "listt"
  local ui = setupUI([[
Panel

  height: 35

  Button
    id: editCombo
    color: orange
    font: verdana-11px-rounded
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 35
    text: - COMBO -

  ]], parent)
  ui:setId(comboPanelName)

  if not storage[comboPanelName] then
    storage[ComboPanelName] = { 

    }
  end

rootWidget = g_ui.getRootWidget()
if rootWidget then
    CombosWindow = UI.createWidget('cmbComboWindow', rootWidget)
    CombosWindow:hide()
    TabBar2 = CombosWindow.cmbTabBar
    TabBar2:setContentWidget(CombosWindow.cmbImagem)
   for v = 1, 1 do





cmbPanel = g_ui.createWidget("cPanel") -- Creates Panel
cmbPanel:setId("panelButtons") -- sets ID

cmbPanel2 = g_ui.createWidget("cPanel") -- Creates Panel
cmbPanel2:setId("2") -- sets ID

cmbPanel3 = g_ui.createWidget("cPanel") -- Creates Panel
cmbPanel:setId("panelButtons") -- sets ID

cmbPanel4 = g_ui.createWidget("cPanel") -- Creates Panel
cmbPanel:setId("panelButtons") -- sets ID


TabBar2:addTab("Combo", cmbPanel)
        color= UI.Label("by: @Luiz",cmbPanel)
color:setColor("orange")
        UI.Separator(cmbPanel)
Comboss= macro(200, "Combo",  function()
if g_game.isAttacking() then
say(storage.ComboText)
say(storage.Combo1Text)
say(storage.Combo2Text)
say(storage.Combo3Text)
say(storage.Combo4Text)
say(storage.Combo55Text)
end

end,cmbPanel)
addTextEdit("ComboText", storage.ComboText or "magia 1", function(widget, text) 
storage.ComboText = text
end,cmbPanel)
addTextEdit("Combo1Text", storage.Combo1Text or "magia 2", function(widget, text) storage.Combo1Text = text
end,cmbPanel)
addTextEdit("Combo2Text", storage.Combo2Text or "magia 3", function(widget, text) storage.Combo2Text = text
end,cmbPanel)
addTextEdit("Combo3Text", storage.Combo3Text or "magia 4", function(widget, text) storage.Combo3Text = text
end,cmbPanel)
addTextEdit("Combo4Text", storage.Combo4Text or "magia 5", function(widget, text) storage.Combo4Text = text
end,cmbPanel)
addTextEdit("Combo55Text", storage.Combo55Text or "magia 6", function(widget, text) storage.Combo55Text = text
end,cmbPanel)


TabBar2:addTab("Combo UP", cmbPanel2)
        color= UI.Label("by: @Luiz",cmbPanel2)
color:setColor("orange")
        UI.Separator(cmbPanel2)
local distance = 2
local amountOfMonsters = 3

up= macro(200, "UP",  function()
    local specAmount = 0
    if not g_game.isAttacking() then
        return
    end
    for i,mob in ipairs(getSpectators()) do
        if (getDistanceBetween(player:getPosition(), mob:getPosition())  <= distance and mob:isMonster())  then
            specAmount = specAmount + 1
        end
    end
    if (specAmount >= amountOfMonsters) then    
        say(storage.UP5Text)
    else
say(storage.UP1Text)
say(storage.UP2Text)
say(storage.UP3Text)   
say(storage.UP4Text)
say(storage.UP6Text)
say(storage.UP7Text)
    end

end,cmbPanel2)
addTextEdit("ComboText", storage.UP1Text or "magia 1", function(widget, text) 
storage.UP1Text = text
end,cmbPanel2)
addTextEdit("Combo1Text", storage.UP2Text or "magia 2", function(widget, text) storage.UP2Text = text
end,cmbPanel2)
addTextEdit("Combo2Text", storage.UP3Text or "magia 3", function(widget, text) storage.UP3Text = text
end,cmbPanel2)
addTextEdit("Combo3Text", storage.UP4Text or "magia 4", function(widget, text) storage.UP4Text = text
end,cmbPanel2)
addTextEdit("Combo5Text", storage.UP6Text or "magia 5", function(widget, text) storage.UP6Text = text
end,cmbPanel2)
addTextEdit("Combo6Text", storage.UP7Text or "magia 6", function(widget, text) storage.UP7Text = text
end,cmbPanel2)
addTextEdit("Combo4Text", storage.UP5Text or "magia em area!", function(widget, text) storage.UP5Text = text
end,cmbPanel2)



TabBar2:addTab("Combo 2", cmbPanel3)
        color= UI.Label("by: @Luiz",cmbPanel3)
color:setColor("orange")
        UI.Separator(cmbPanel3)
macro(200, "Combo 2",  function()
if g_game.isAttacking() then
say(storage.Combo5Text)
say(storage.Combo6Text)
say(storage.Combo7Text)
say(storage.Combo8Text)
say(storage.Combo9Text)
say(storage.Combo10Text)
end

end,cmbPanel3)
addTextEdit("Combo5Text", storage.Combo5Text or "magia 1", function(widget, text) 
storage.Combo5Text = text
end,cmbPanel3)
addTextEdit("Combo6Text", storage.Combo6Text or "magia 2", function(widget, text) storage.Combo6Text = text
end,cmbPanel3)
addTextEdit("Combo7Text", storage.Combo7Text or "magia 3", function(widget, text) storage.Combo7Text = text
end,cmbPanel3)
addTextEdit("Combo8Text", storage.Combo8Text or "magia 4", function(widget, text) storage.Combo8Text = text
end,cmbPanel3)
addTextEdit("Combo9Text", storage.Combo9Text or "magia 5", function(widget, text) storage.Combo9Text = text
end,cmbPanel3)
addTextEdit("Combo10Text", storage.Combo10Text or "magia 6", function(widget, text) storage.Combo10Text = text
end,cmbPanel3)

end
end


  CombosWindow.closeButton.onClick = function(widget)
    CombosWindow:hide()
  end


  
ui.editCombo.onClick = function(widget)
    CombosWindow:show()
    CombosWindow:raise()
    CombosWindow:focus()
  end



addIcon("Combo", {outfit={mount=849,feet=10,legs=10,body=178,type=15,auxType=0,addons=3,head=48}, text="Combo"},Comboss)

addIcon("UP", {outfit={mount=849,feet=10,legs=10,body=178,type=25,auxType=0,addons=3,head=48}, text="UP"},up)

singlehotkey("shift+space", "Stop/Cave", function()
if CaveBot.isOn() or TargetBot.isOn() then
CaveBot.setOff()
TargetBot.setOff()
elseif CaveBot.isOff() or TargetBot.isOff() then
CaveBot.setOn()
TargetBot.setOn()
end
end,scpPanel)
local privateTabs = addSwitch("openPMTabs", "Abrir Pm", function(widget) widget:setOn(not widget:isOn()) storage.OpenPrivateTabs = widget:isOn() end, scpPanel, parent,scpPanel)
privateTabs:setOn(storage.OpenPrivateTabs,scpPanel)

onTalk(function(name, level, mode, text, channelId, pos)
    if mode == 4 and privateTabs:isOn() then
        local g_console = modules.game_console
        local privateTab = g_console.getTab(name)
        if privateTab == nil then
            privateTab = g_console.addTab(name, true)
            g_console.addPrivateText(g_console.applyMessagePrefixies(name, level, text), g_console.SpeakTypesSettings['private'], name, false, name)
            playSound("/sounds/Private Message.ogg")
        end
        return
    end
end,scpPanel) UI.Separator(scpPanel4) addTextEdit("summonText", storage.summonText or "Nome da magia de summon!", function(widget, text) storage.summonText = text
end,scpPanel4)

function isSummonOnScreen()
    for _, spec in ipairs(getSpectators()) do
        if not spec:isPlayer() and spec:getName() == summonName then
     return true
    end
   end
end

Summon = macro(100, "Summon", function()
      if not isSummonOnScreen() then
          say(storage.summonText)
   end
end,scpPanel4)

addIcon("Summon", {outfit={mount=849,feet=10,legs=10,body=178,type=55,auxType=0,addons=3,head=48}, text="Summon"},Summon) 




UI.Separator()
UI.Separator(scpPanel4)
macro(100, "Reta Ataque", "shift+f", function()
    local target = g_game.getAttackingCreature()
    if target then
        local playerPos = player:getPosition()
        local targetPos = target:getPosition()

        if targetPos.x == playerPos.x - 1 then
            g_game.turn(3) -- west
        elseif targetPos.x == playerPos.x + 1 then
            g_game.turn(1) -- east
        elseif targetPos.x == playerPos.x then
            if targetPos.y == playerPos.y + 1 then
                g_game.turn(2) -- south
            elseif targetPos.y == playerPos.y - 1 then
                g_game.turn(0) -- north
            end
        end
    end
end,scpPanel4)
macro(100, "Auto Jam", function()
  if not getNeck() then
      say('!jam')
  end
end,scpPanel4)


macro(200, "Auto Bless", function()
    if bless ~= true then
        bless = true
        say("!bless")
    end
end,scpPanel4)




local PainelPanelName = "listt"
  local ui = setupUI([[
Panel

  height: 30

  Button
    id: editPainel
    color: green
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 30
    text: - PAINEL -

  ]], parent)
  ui:setId(PaineltroPanelName)

  if not storage[PainelPanelName] then
    storage[PainelPanelName] = { 

    }
  end

rootWidget = g_ui.getRootWidget()
if rootWidget then
    PainelsWindow = UI.createWidget('PainelWindow', rootWidget)
    PainelsWindow:hide()
    TabBar = PainelsWindow.paTabBar
    TabBar:setContentWidget(PainelsWindow.paImagem)
   for v = 1, 1 do





hpPanel = g_ui.createWidget("hpPanel") -- Creates Panel
hpPanel:setId("panelButtons") -- sets ID

hpPanel2 = g_ui.createWidget("hpPanel") -- Creates Panel
hpPanel2:setId("2") -- sets ID

hpPanel3 = g_ui.createWidget("hpPanel") -- Creates Panel
hpPanel:setId("panelButtons") -- sets ID

hpPanel4 = g_ui.createWidget("hpPanel") -- Creates Panel
hpPanel:setId("panelButtons") -- sets ID

hpPanel5 = g_ui.createWidget("hpPanel") -- Creates Panel
hpPanel:setId("panelButtons") -- sets ID

hpPanel6 = g_ui.createWidget("hpPanel") -- Creates Panel
hpPanel:setId("panelButtons") -- sets ID

hpPanel7 = g_ui.createWidget("hpPanel") -- Creates Panel
hpPanel:setId("panelButtons") -- sets ID

TabBar:addTab("HP", hpPanel)
        color= UI.Label("by: @Luiz",hpPanel)
color:setColor("orange")
        UI.Separator(hpPanel)
color= UI.Label("Regeneração:",hpPanel)
color:setColor("red")
        UI.Separator(hpPanel)

if type(storage.heal) ~= "table" then
  storage.heal = {on=false, title="HP%", text="big regeneration", min=0, max=99}
end
if type(storage.heal2) ~= "table" then
  storage.heal2 = {on=false, title="HP%", text="regeneration", min=0, max=99}
end

-- create 2 healing widgets
for _, healingInfo in ipairs({storage.heal, storage.heal2}) do
  local healingmacro = macro(200, function()
    local hp = player:getHealthPercent()
    if healingInfo.max >= hp and hp >= healingInfo.min then
      if TargetBot then 
        TargetBot.saySpell(healingInfo.text) -- sync spell with targetbot if available
      else
        say(healingInfo.text)
      end
    end
  end,hpPanel)
  healingmacro.setOn(healingInfo.on)

  UI.DualScrollPanel(healingInfo, function(widget, newParams) 
    healingInfo = newParams
    healingmacro.setOn(healingInfo.on)
  end,hpPanel)
end

TabBar:addTab("Potion", hpPanel2)
        color= UI.Label("by: @Luiz",hpPanel2)
color:setColor("orange")
        UI.Separator(hpPanel2)
        color= UI.Label("Poções:",hpPanel2)
color:setColor("red")
        UI.Separator(hpPanel2)
Panels.HealthItem(hpPanel2)
        UI.Separator(hpPanel2)
Panels.HealthItem(hpPanel2)
        UI.Separator(hpPanel2)
Panels.ManaItem(hpPanel2)
        UI.Separator(hpPanel2)
Panels.ManaItem(hpPanel2)

TabBar:addTab("Haste", hpPanel3)
        color= UI.Label("by: @Luiz",hpPanel3)
color:setColor("orange")
        UI.Separator(hpPanel3)
        color= UI.Label("Pressa:",hpPanel3)
color:setColor("red")
Panels.Haste(hpPanel3)
        UI.Separator(hpPanel3)
Panels.AntiParalyze(hpPanel3)
        UI.Separator(hpPanel3)


TabBar:addTab("Buff", hpPanel4)
        color= UI.Label("by: @Luiz",hpPanel4)
color:setColor("orange")
        UI.Separator(hpPanel4)
        color= UI.Label("Buffs:",hpPanel4)
color:setColor("red")

buffs= macro(1000, "Buff", function()
if not hasPartyBuff() and not isInPz() then
 say(storage.buff)
schedule(1200, function() say(storage.buff2) end)
schedule(1400, function() say(storage.buff3) end)
end
end,hpPanel4)

addIcon("Buff", {outfit={mount=849,feet=10,legs=10,body=178,type=85,auxType=0,addons=3,head=48}, text="Buff"},buffs)


addTextEdit("buff", storage.buff or "buff", function(widget, text) storage.buff = text
end,hpPanel4)

        color= UI.Label("Buff 2:",hpPanel4)
color:setColor("red")


addTextEdit("buff2", storage.buff2 or "buff 2", function(widget, text) storage.buff2 = text
end,hpPanel4)


        color= UI.Label("Buff 3:",hpPanel4)
color:setColor("red")

addTextEdit("buff3", storage.buff3 or "buff 3", function(widget, text) storage.buff3 = text
end,hpPanel4)











TabBar:addTab("Fuga", hpPanel5)
        color= UI.Label("by: @Luiz",hpPanel5)
color:setColor("orange")
        UI.Separator(hpPanel5)
        color= UI.Label("Fugas:",hpPanel5)
color:setColor("red")


if type(storage.fugaa) ~= "table" then
  storage.fugaa = {on=false, title="HP%", text="fuga", min=0, max=20}
end
if type(storage.fugaa2) ~= "table" then
  storage.fugaa2 = {on=false, title="HP%", text="fuga", min=0, max=30}
end
if type(storage.fugaa3) ~= "table" then
  storage.fugaa3 = {on=false, title="HP%", text="fuga", min=0, max=40}
end
if type(storage.fugaa4) ~= "table" then
  storage.fugaa4 = {on=false, title="HP%", text="fuga", min=0, max=40}
end
if type(storage.fugaa5) ~= "table" then
  storage.fugaa5 = {on=false, title="HP%", text="fuga", min=0, max=40}
end

-- create 2 healing widgets
for _, healingInfo2 in ipairs({storage.fugaa, storage.fugaa2, storage.fugaa3, storage.fugaa4,storage.fugaa5}) do
  local healingmacro2 = macro(200, function()
    local hp2 = player:getHealthPercent()
    if healingInfo2.max >= hp2 and hp2 >= healingInfo2.min then
      if TargetBot2 then 
        TargetBot2.saySpell(healingInfo2.text) -- sync spell with targetbot if available
      else
        say(healingInfo2.text)
      end
    end
  end,hpPanel5)
  healingmacro2.setOn(healingInfo2.on)

  UI.DualScrollPanel(healingInfo2, function(widget, newParams) 
    healingInfo2 = newParams
    healingmacro2.setOn(healingInfo2.on)
  end,hpPanel5)
end




TabBar:addTab("Food", hpPanel6)
        color= UI.Label("by: @Luiz",hpPanel6)
color:setColor("orange")
        UI.Separator(hpPanel6)
        color= UI.Label("Comidas:",hpPanel6)
color:setColor("red")
Panels.Eating(hpPanel6)
        UI.Separator(hpPanel6)
Panels.Eating(hpPanel6)


TabBar:addTab("Equip", hpPanel7)
        color= UI.Label("by: @Luiz",hpPanel7)
color:setColor("orange")
        UI.Separator(hpPanel7)
        color= UI.Label("Equipar:",hpPanel7)
color:setColor("red")
Panels.AutoEquip(hpPanel7)
        UI.Separator(hpPanel7)
Panels.AutoEquip(hpPanel7)
        UI.Separator(hpPanel7)
Panels.AutoEquip(hpPanel7)
        UI.Separator(hpPanel7)
Panels.AutoEquip(hpPanel7)



end
end


  PainelsWindow.closeButton.onClick = function(widget)
    PainelsWindow:hide()
  end


  
ui.editPainel.onClick = function(widget)
    PainelsWindow:show()
    PainelsWindow:raise()
    PainelsWindow:focus()
  end
  UI.Separator()





local timespellPanelName = "listt"
  local ui = setupUI([[
Panel

  height: 30

  Button
    id: editTime
    color: red
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 30
    text: - Time Spell -

  ]], parent)
  ui:setId(timespellPanelName)

  if not storage[timespellPanelName] then
    storage[timespellPanelName] = { 

    }
  end

rootWidget = g_ui.getRootWidget()
if rootWidget then
    TimeSpellWindow = UI.createWidget('timeSpellWindow', rootWidget)
    TimeSpellWindow:hide()
    TabBar3 = TimeSpellWindow.tmsTabBar
    TabBar3:setContentWidget(TimeSpellWindow.timeSpellImagem)
   for v = 1, 1 do





tmsPanel = g_ui.createWidget("tsPanel") -- Creates Panel
tmsPanel:setId("panelButtons") -- sets ID

tmsPanel2 = g_ui.createWidget("tsPanel") -- Creates Panel
tmsPanel2:setId("2") -- sets ID

tmsPanel3 = g_ui.createWidget("tsPanel") -- Creates Panel
tmsPanel:setId("panelButtons") -- sets ID

tmsPanel4 = g_ui.createWidget("tsPanel") -- Creates Panel
tmsPanel:setId("panelButtons") -- sets ID

tmsPanel5 = g_ui.createWidget("tsPanel") -- Creates Panel
tmsPanel:setId("panelButtons") -- sets ID

tmsPanel6 = g_ui.createWidget("tsPanel") -- Creates Panel
tmsPanel:setId("panelButtons") -- sets ID


TabBar3:addTab("Time", tmsPanel)
        color= UI.Label("by: @Luiz",tmsPanel)
color:setColor("orange")
        UI.Separator(tmsPanel)
		
local height = 50
local widget = setupUI([[
Panel
  height: 2000
  width: 2000
]], modules.game_interface.getMapPanel())

local time = g_ui.loadUIFromString([[
Label
  color: green
  font: verdana-11px-rounded
  font: verdana-11px-rounded
  background-color: #00000090
  opacity: 0.87
  text-auto-resize: true
  text-align: center
]], widget)

time:setPosition({y = storage.z1Text, x = storage.yy1Text})

onTalk(function(name, level, mode, text, channelId, pos)
 if name == player:getName() and text:lower() == (storage.magia1Text) then
  storage.timee = (now + storage.ativo1Text) 
 end
end,tmsPanel)

onTalk(function(name, level, mode, text, channelId, pos)
 if name == player:getName() and text:lower() == (storage.magia1Text) then
  storage.timeee = (now + storage.tempo1Text)
 end
end,tmsPanel)
addTextEdit("nome1Text", storage.nome1Text or "Texto", function(widget, text) storage.nome1Text = text
end,tmsPanel)
addTextEdit("magia1Text", storage.magia1Text or "Nome da magia!", function(widget, text) storage.magia1Text = text
end,tmsPanel)
addTextEdit("ativo1Text", storage.ativo1Text or "tempo da magia ativa", function(widget, text) storage.ativo1Text = text
end,tmsPanel)
addTextEdit("tempo1Text", storage.tempo1Text or "tempo da magia = 1000 = 1 segundo", function(widget, text) storage.tempo1Text = text
end,tmsPanel)
addTextEdit("z1Text", storage.z1Text or "posiçao para cima / baixo", function(widget, text) storage.z1Text = text
end,tmsPanel)
addTextEdit("yy1Text", storage.yy1Text or "posiçao para os lados", function(widget, text) storage.yy1Text = text
end,tmsPanel)


time:setText(storage.nome1Text)
macro(1, function()
 if not storage.timee then return end
 if (storage.timee - now) > now then
  storage.timee = nil
 return
 end
 if storage.timee and storage.timee >= now then
time:setText(string.format(storage.nome1Text.."%.0f",(storage.timee-now)/1000).."s")
time:setColor("yellow")
return
end
 if storage.timeee and storage.timeee >= now then
time:setText(string.format(storage.nome1Text.."%.0f",(storage.timeee-now)/1000).."s")
time:setColor("red")
  else
time:setText(storage.nome1Text)
time:setColor("green")
  end
end,tmsPanel)




TabBar3:addTab("Time 2", tmsPanel2)
        color= UI.Label("by: @Luiz",tmsPanel2)
color:setColor("orange")
        UI.Separator(tmsPanel2)


local height = 50
local widget = setupUI([[
Panel
  height: 2000
  width: 2000
]], modules.game_interface.getMapPanel())

local time2 = g_ui.loadUIFromString([[
Label
  color: green
  font: verdana-11px-rounded
  font: verdana-11px-rounded
  background-color: #00000090
  opacity: 0.87
  text-auto-resize: true
  text-align: center
]], widget)

time2:setPosition({y = storage.zText, x = storage.yyText})

onTalk(function(name, level, mode, text, channelId, pos)
 if name == player:getName() and text:lower() == (storage.magiaText) then
  storage.timee2 = (now + storage.ativoText) 
 end
end,tmsPanel2)

onTalk(function(name, level, mode, text, channelId, pos)
 if name == player:getName() and text:lower() == (storage.magiaText) then
  storage.timeee2 = (now + storage.tempoText)
 end
end,tmsPanel2)
addTextEdit("nomeText", storage.nomeText or "Texto", function(widget, text) storage.nomeText = text
end,tmsPanel2)
addTextEdit("magiaText", storage.magiaText or "Nome da magia!", function(widget, text) storage.magiaText = text
end,tmsPanel2)
addTextEdit("ativoText", storage.ativoText or "tempo da magia ativa", function(widget, text) storage.ativoText = text
end,tmsPanel2)
addTextEdit("tempoText", storage.tempoText or "tempo da magia = 1000 = 1 segundo", function(widget, text) storage.tempoText = text
end,tmsPanel2)
addTextEdit("zText", storage.zText or "posiçao para cima / baixo", function(widget, text) storage.zText = text
end,tmsPanel2)
addTextEdit("yyText", storage.yyText or "posiçao para os lados", function(widget, text) storage.yyText = text
end,tmsPanel2)


time2:setText(storage.nomeText)
macro(1, function()
 if not storage.timee2 then return end
 if (storage.timee2 - now) > now then
  storage.timee2 = nil
 return
 end
 if storage.timee2 and storage.timee2 >= now then
time2:setText(string.format(storage.nomeText.."%.0f",(storage.timee2-now)/1000).."s")
time2:setColor("yellow")
return
end
 if storage.timeee2 and storage.timeee2 >= now then
time2:setText(string.format(storage.nomeText.."%.0f",(storage.timeee2-now)/1000).."s")
time2:setColor("red")
  else
time2:setText(storage.nomeText)
time2:setColor("green")
  end
end,tmsPanel2)






TabBar3:addTab("Time 3", tmsPanel3)
        color= UI.Label("by: @Luiz",tmsPanel3)
color:setColor("orange")
        UI.Separator(tmsPanel3)

local height = 50
local widget = setupUI([[
Panel
  height: 2000
  width: 2000
]], modules.game_interface.getMapPanel())

local time3 = g_ui.loadUIFromString([[
Label
  color: green
  font: verdana-11px-rounded
  font: verdana-11px-rounded
  background-color: #00000090
  opacity: 0.87
  text-auto-resize: true
  text-align: center
]], widget)

time3:setPosition({y = storage.z2Text, x = storage.yy2Text})

onTalk(function(name, level, mode, text, channelId, pos)
 if name == player:getName() and text:lower() == (storage.magia2Text) then
  storage.timee3 = (now + storage.ativo2Text) 
 end
end,tmsPanel3)

onTalk(function(name, level, mode, text, channelId, pos)
 if name == player:getName() and text:lower() == (storage.magia2Text) then
  storage.timeee3 = (now + storage.tempo2Text)
 end
end,tmsPanel3)
addTextEdit("nome2Text", storage.nome2Text or "Texto", function(widget, text) storage.nome2Text = text
end,tmsPanel3)
addTextEdit("magia2Text", storage.magia2Text or "Nome da magia!", function(widget, text) storage.magia2Text = text
end,tmsPanel3)
addTextEdit("ativo2Text", storage.ativo2Text or "tempo da magia ativa", function(widget, text) storage.ativo2Text = text
end,tmsPanel3)
addTextEdit("tempo2Text", storage.tempo2Text or "tempo da magia = 1000 = 1 segundo", function(widget, text) storage.tempo2Text = text
end,tmsPanel3)
addTextEdit("z2Text", storage.z2Text or "posiçao para cima / baixo", function(widget, text) storage.z2Text = text
end,tmsPanel3)
addTextEdit("yy2Text", storage.yy2Text or "posiçao para os lados", function(widget, text) storage.yy2Text = text
end,tmsPanel3)


time3:setText(storage.nome2Text)
macro(1, function()
 if not storage.timee3 then return end
 if (storage.timee3 - now) > now then
  storage.timee3 = nil
 return
 end
 if storage.timee3 and storage.timee3 >= now then
time3:setText(string.format(storage.nome2Text.."%.0f",(storage.timee3-now)/1000).."s")
time3:setColor("yellow")
return
end
 if storage.timeee3 and storage.timeee3 >= now then
time3:setText(string.format(storage.nome2Text.."%.0f",(storage.timeee3-now)/1000).."s")
time3:setColor("red")
  else
time3:setText(storage.nome2Text)
time3:setColor("green")
  end
end,tmsPanel3)




TabBar3:addTab("Time 4", tmsPanel4)
        color= UI.Label("by: @Luiz",tmsPanel4)
color:setColor("orange")
        UI.Separator(tmsPanel4)

local height = 50
local widget = setupUI([[
Panel
  height: 2000
  width: 2000
]], modules.game_interface.getMapPanel())

local time4 = g_ui.loadUIFromString([[
Label
  color: green
  font: verdana-11px-rounded
  font: verdana-11px-rounded
  background-color: #00000090
  opacity: 0.87
  text-auto-resize: true
  text-align: center
]], widget)

time4:setPosition({y = storage.z3Text, x = storage.yy3Text})

onTalk(function(name, level, mode, text, channelId, pos)
 if name == player:getName() and text:lower() == (storage.magia3Text) then
  storage.timee4 = (now + storage.ativo3Text) 
 end
end,tmsPanel4)

onTalk(function(name, level, mode, text, channelId, pos)
 if name == player:getName() and text:lower() == (storage.magia3Text) then
  storage.timeee4 = (now + storage.tempo3Text)
 end
end,tmsPanel4)
addTextEdit("nome3Text", storage.nome3Text or "Texto", function(widget, text) storage.nome3Text = text
end,tmsPanel4)
addTextEdit("magia3Text", storage.magia3Text or "Nome da magia!", function(widget, text) storage.magia3Text = text
end,tmsPanel4)
addTextEdit("ativo3Text", storage.ativo3Text or "tempo da magia ativa", function(widget, text) storage.ativo3Text = text
end,tmsPanel4)
addTextEdit("tempo3Text", storage.tempo3Text or "tempo da magia = 1000 = 1 segundo", function(widget, text) storage.tempo3Text = text
end,tmsPanel4)
addTextEdit("z3Text", storage.z3Text or "posiçao para cima / baixo", function(widget, text) storage.z3Text = text
end,tmsPanel4)
addTextEdit("yy3Text", storage.yy3Text or "posiçao para os lados", function(widget, text) storage.yy3Text = text
end,tmsPanel4)


time4:setText(storage.nome3Text)
macro(1, function()
 if not storage.timee4 then return end
 if (storage.timee4 - now) > now then
  storage.timee4 = nil
 return
 end
 if storage.timee4 and storage.timee4 >= now then
time4:setText(string.format(storage.nome3Text.."%.0f",(storage.timee4-now)/1000).."s")
time4:setColor("yellow")
return
end
 if storage.timeee4 and storage.timeee4 >= now then
time4:setText(string.format(storage.nome3Text.."%.0f",(storage.timeee4-now)/1000).."s")
time4:setColor("red")
  else
time4:setText(storage.nome3Text)
time4:setColor("green")
  end
end,tmsPanel4)



TabBar3:addTab("Time 5", tmsPanel5)
        color= UI.Label("by: @Luiz",tmsPanel5)
color:setColor("orange")
        UI.Separator(tmsPanel5)

local height = 50
local widget = setupUI([[
Panel
  height: 2000
  width: 2000
]], modules.game_interface.getMapPanel())

local time5 = g_ui.loadUIFromString([[
Label
  color: green
  font: verdana-11px-rounded
  font: verdana-11px-rounded
  background-color: #00000090
  opacity: 0.87
  text-auto-resize: true
  text-align: center
]], widget)

time5:setPosition({y = storage.z4Text, x = storage.yy4Text})

onTalk(function(name, level, mode, text, channelId, pos)
 if name == player:getName() and text:lower() == (storage.magia4Text) then
  storage.timee5 = (now + storage.ativo4Text) 
 end
end,tmsPanel5)

onTalk(function(name, level, mode, text, channelId, pos)
 if name == player:getName() and text:lower() == (storage.magia4Text) then
  storage.timeee5 = (now + storage.tempo4Text)
 end
end,tmsPanel5)
addTextEdit("nome4Text", storage.nome4Text or "Texto", function(widget, text) storage.nome4Text = text
end,tmsPanel5)
addTextEdit("magia4Text", storage.magia4Text or "Nome da magia!", function(widget, text) storage.magia4Text = text
end,tmsPanel5)
addTextEdit("ativo4Text", storage.ativo4Text or "tempo da magia ativa", function(widget, text) storage.ativo4Text = text
end,tmsPanel5)
addTextEdit("tempo4Text", storage.tempo4Text or "tempo da magia = 1000 = 1 segundo", function(widget, text) storage.tempo4Text = text
end,tmsPanel5)
addTextEdit("z4Text", storage.z4Text or "posiçao para cima / baixo", function(widget, text) storage.z4Text = text
end,tmsPanel5)
addTextEdit("yy4Text", storage.yy4Text or "posiçao para os lados", function(widget, text) storage.yy4Text = text
end,tmsPanel5)


time5:setText(storage.nome4Text)
macro(1, function()
 if not storage.timee5 then return end
 if (storage.timee5 - now) > now then
  storage.timee5 = nil
 return
 end
 if storage.timee5 and storage.timee5 >= now then
time5:setText(string.format(storage.nome4Text.."%.0f",(storage.timee5-now)/1000).."s")
time5:setColor("yellow")
return
end
 if storage.timeee5 and storage.timeee5 >= now then
time5:setText(string.format(storage.nome4Text.."%.0f",(storage.timeee5-now)/1000).."s")
time5:setColor("red")
  else
time5:setText(storage.nome4Text)
time5:setColor("green")
  end
end,tmsPanel5)








end
end


  TimeSpellWindow.closeButton.onClick = function(widget)
    TimeSpellWindow:hide()
  end


  
ui.editTime.onClick = function(widget)
    TimeSpellWindow:show()
    TimeSpellWindow:raise()
    TimeSpellWindow:focus()
  end
 UI.Separator()






-- tools tab
setDefaultTab("Hotkeys")

-- allows to test/edit bot lua scripts ingame, you can have multiple scripts like this, just change storage.ingame_lua
UI.Button("Hotkeys", function(newText)
  UI.MultilineEditorWindow(storage.ingame_hotkeys or "", {title="Hotkeys editor", description="Adicione suas scripts aqui!\nBy: @Luiz"}, function(text)
    storage.ingame_hotkeys = text
    reload()
  end)
end)



for _, scripts in pairs({storage.ingame_hotkeys}) do
  if type(scripts) == "string" and scripts:len() > 3 then
    local status, result = pcall(function()
      assert(load(scripts, "ingame_editor"))()
    end)
    if not status then 
      error("Ingame edior error:\n" .. result)
    end
  end
end

UI.Separator()