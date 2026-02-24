-- load all otui files, order doesn't matter
local configName = modules.game_bot.contentsPanel.config:getCurrentOption().text

local configFiles = g_resources.listDirectoryFiles("/bot/" .. configName .. "/vBot", true, false)
for i, file in ipairs(configFiles) do
  local ext = file:split(".")
  if ext[#ext]:lower() == "ui" or ext[#ext]:lower() == "otui" then
    g_ui.importStyle(file)
  end
end

local function loadScript(name)
  return dofile("/vBot/" .. name .. ".lua")
end

-- here you can set manually order of scripts
-- libraries should be loaded first
local luaFiles = {
  "main",
  "items",
  "vlib",
  "new_cavebot_lib",
  "configs", -- do not change this and above
  "extras",
  "cavebot",
  "playerlist",
  "BotServer",
  "icons",
  "alarms",
  "Conditions",
  "Equipper",
  "pushmax",
  "combo",
  "HealBot",
  "new_healer",
  "AttackBot", -- last of major modules
  "ingame_editor",
  "Dropper",
  "Containers",
  "quiver_manager",
  "quiver_label",
  "tools",
  "antiRs",
  "depot_withdraw",
  "eat_food",
  "equip",
  "exeta",
  "analyzer",
  "spy_level",
  "supplies",
  "depositer_config",
  "npc_talk",
  "xeno_menu",
  "hold_target",
  "cavebot_control_panel",
  "smart_utura"
  -- "wall_hugger"
}

for i, file in ipairs(luaFiles) do
  loadScript(file)
end

setDefaultTab("Main")
UI.Separator()

---------------------------------------------------------------------
--Follow simples
---------------------------------------------------------------------
addLabel("Label", "Follow simples")
addTextEdit("TxtEdit", storage.fName or "name", function(widget, text)
  storage.fName = text
end)
--------------------------
local lastPos = nil
macro(200, "Follow", function()  
  local leader = getCreatureByName(storage.fName)
  local target = g_game.getAttackingCreature()
  if leader then
    if target and lastPos then
      return player:autoWalk(lastPos)
    end
    if not g_game.getFollowingCreature() then
      return g_game.follow(leader)
    end
  elseif lastPos then
    player:autoWalk(lastPos)
  end
end)

onCreaturePositionChange(function(creature, newPos, oldPos)
  local leader = getCreatureByName(storage.fName)
  if leader ~= creature or not newPos then return end
  lastPos = newPos
end)

UI.Separator()

local autopartyui = setupUI([[
Panel
  height: 38

  BotSwitch
    id: status
    anchors.top: parent.top
    anchors.left: parent.left
    text-align: center
    width: 130
    height: 18
    text: Auto Party

  Button
    id: editPlayerList
    anchors.top: prev.top
    anchors.left: prev.right
    anchors.right: parent.right
    margin-left: 3
    height: 18
    text: Setup

  Button
    id: ptLeave
    text: Leave Party
    anchors.left: parent.left
    anchors.top: prev.bottom
    width: 86
    height: 17
    margin-top: 3
    color: #ee0000
    font: verdana-11px-rounded

  BotSwitch
    id: ptShare
    text: Auto Share
    anchors.left: prev.right
    anchors.bottom: prev.bottom
    margin-left: 4
    height: 17
    width: 86
  ]], parent)

g_ui.loadUIFromString([[
AutoPartyName < Label
  background-color: alpha
  text-offset: 2 0
  focusable: true
  height: 16

  $focus:
    background-color: #00000055

  Button
    id: remove
    text: x
    anchors.right: parent.right
    margin-right: 15
    width: 15
    height: 15

AutoPartyListWindow < MainWindow
  text: Auto Party
  size: 200 315
  @onEscape: self:hide()

  Label
    id: lblLeader
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.right: parent.right
    text-align: center
    text: Leader Name

  TextEdit
    id: txtLeader
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: prev.bottom
    margin-top: 5

  Label
    id: lblParty
    anchors.left: parent.left
    anchors.top: prev.bottom
    anchors.right: parent.right
    margin-top: 5
    text-align: center
    text: Party List

  TextList
    id: lstAutoParty
    anchors.top: prev.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    margin-top: 5
    margin-bottom: 5
    padding: 1
    height: 100
    vertical-scrollbar: AutoPartyListListScrollBar

  VerticalScrollBar
    id: AutoPartyListListScrollBar
    anchors.top: lstAutoParty.top
    anchors.bottom: lstAutoParty.bottom
    anchors.right: lstAutoParty.right
    step: 14
    pixels-scroll: true

  TextEdit
    id: playerName
    anchors.left: parent.left
    anchors.top: lstAutoParty.bottom
    margin-top: 5
    width: 120

  Button
    id: addPlayer
    text: +
    font: verdana-11px-rounded
    anchors.right: parent.right
    anchors.left: prev.right
    anchors.top: prev.top
    anchors.bottom: prev.bottom
    margin-left: 3

  HorizontalSeparator
    id: separator
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.top: prev.bottom
    margin-top: 8

  CheckBox
    id: inviteMsg
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: prev.bottom
    margin-top: 6
    text: Invite/Accept on Msg:
    tooltip: If you are the leader, invite player that said this msg, else, accept party when someone say this.\n

  TextEdit
    id: inviteTxt
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: inviteMsg.bottom
    margin-top: 5
    width: 148

  HorizontalSeparator
    id: separator
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.bottom: closeButton.top
    margin-bottom: 6

  Button
    id: closeButton
    text: Close
    font: cipsoftFont
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    size: 45 21

  Button
    id: info
    text: Credits
    font: cipsoftFont
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    size: 45 21
    color: yellow
    !tooltip: tr('Original made by Lee#7225\nModified by F.Almeida#8019')
    @onClick: g_platform.openUrl("https://www.paypal.com/donate/?business=8XSU4KTS2V9PN&no_recurring=0&item_name=OTC+AND+OTS+SCRIPTS&currency_code=USD")
]])

local panelName = "autoParty"

if not storage[panelName] then
  storage[panelName] = {
    leaderName = 'Leader',
    autoPartyList = {},
    enabled = false,
    inviteTxt = 'party me',
    autoShare = false,
    onMsg = false,
  }
end

local config = storage[panelName]

rootWidget = g_ui.getRootWidget()
if rootWidget then
  tcAutoParty = autopartyui.status
  tcAutoShare = autopartyui.ptShare

  autoPartyListWindow = UI.createWindow('AutoPartyListWindow', rootWidget)
  autoPartyListWindow:hide()

  autopartyui.editPlayerList.onClick = function(widget)
    autoPartyListWindow:show()
    autoPartyListWindow:raise()
    autoPartyListWindow:focus()
  end

  autopartyui.ptLeave.onClick = function(widget)
    g_game.partyLeave()
  end

  autoPartyListWindow.closeButton.onClick = function(widget)
    autoPartyListWindow:hide()
  end

  if config.autoPartyList and #config.autoPartyList > 0 then
    for _, pName in ipairs(config.autoPartyList) do
      local label = g_ui.createWidget("AutoPartyName", autoPartyListWindow.lstAutoParty)
      label.remove.onClick = function(widget)
        table.removevalue(config.autoPartyList, label:getText())
        label:destroy()
      end
      label:setText(pName)
    end
  end
  autoPartyListWindow.addPlayer.onClick = function(widget)
    local playerName = autoPartyListWindow.playerName:getText()
    if playerName:len() > 0 and not (table.contains(config.autoPartyList, playerName, true) or config.leaderName == playerName) then
      table.insert(config.autoPartyList, playerName)
      local label = g_ui.createWidget("AutoPartyName", autoPartyListWindow.lstAutoParty)
      label.remove.onClick = function(widget)
        table.removevalue(config.autoPartyList, label:getText())
        label:destroy()
      end
      label:setText(playerName)
      autoPartyListWindow.playerName:setText('')
    end
  end

  autopartyui.status:setOn(config.enabled)
  autopartyui.status.onClick = function(widget)
    config.enabled = not config.enabled
    widget:setOn(config.enabled)
  end

  autopartyui.ptShare:setOn(config.autoShare)
  autopartyui.ptShare.onClick = function(widget)
    config.autoShare = not config.autoShare
    widget:setOn(config.autoShare)
  end

  autoPartyListWindow.inviteMsg:setChecked(config.onMsg)
  autoPartyListWindow.inviteMsg.onClick = function(widget)
    config.onMsg = not config.onMsg
    widget:setChecked(config.onMsg)
  end

  autoPartyListWindow.playerName.onKeyPress = function(self, keyCode, keyboardModifiers)
    if not (keyCode == 5) then
      return false
    end
    autoPartyListWindow.addPlayer.onClick()
    return true
  end

  autoPartyListWindow.playerName.onTextChange = function(widget, text)
    if table.contains(config.autoPartyList, text, true) then
      autoPartyListWindow.addPlayer:setColor("red")
    else
      autoPartyListWindow.addPlayer:setColor("green")
    end
  end

  autoPartyListWindow.txtLeader.onTextChange = function(widget, text)
    config.leaderName = text
  end
  autoPartyListWindow.txtLeader:setText(config.leaderName)

  autoPartyListWindow.inviteTxt.onTextChange = function(widget, text)
    config.inviteTxt = text
  end
  autoPartyListWindow.inviteTxt:setText(config.inviteTxt)
  
  -- main loop
  macro(500,function()
    if not config.enabled then return true end
    local lider = player:getName():lower() == config.leaderName:lower()
    for s, spec in pairs(getSpectators()) do
      if spec:isPlayer() and spec ~= player then
        if lider then
          if spec:getShield() == 0 then
            if table.find(config.autoPartyList,spec:getName(),true) then
              g_game.partyInvite(spec:getId())
            end
          end
        else
          if spec:getShield() == 1 then
           if spec:getName():lower() == config.leaderName:lower() then
            g_game.partyJoin(spec:getId())
           end
          end
        end
      end
    end
    if lider and config.autoShare then
      if not player:isPartySharedExperienceActive() then
        g_game.partyShareExperience(true)
      end
    end
  end)

  -- invite on msg
  onTalk(function(name, level, mode, text, channelId, pos)
    if not config.enabled then return true end
    if not config.onMsg or not string.find(text, config.inviteTxt) then return true end
    local c = getCreatureByName(name)
    if c then 
      if c:isPlayer() and c ~= player then
        if c:getShield() == 0 then
          g_game.partyInvite(c:getId())
        elseif c:getShield() == 1 then
          g_game.partyJoin(c:getId())
        end
      end
    end
  end)
end

-- UI.Separator()

-- ----------------------------------------------------------------------
-- -- AMMO & MANA TRAINER COMBINED
-- ----------------------------------------------------------------------
-- local ammoPanelName = "ammoSlotChecker"
-- if not storage[ammoPanelName] then
    -- storage[ammoPanelName] = {
        -- enabled = false,
        -- targetAmmoId = 0,
        -- slot = 10, -- SlotAmmo default
        -- mt1 = { text = "utevo lux", min = 90, max = 100 },
        -- mt2 = { text = "exura", min = 90, max = 100 }
    -- }
-- end
-- local ammoConfig = storage[ammoPanelName]

-- -- Migração de segurança
-- if not ammoConfig.mt1 then ammoConfig.mt1 = { text = "utevo lux", min = 90, max = 100 } end
-- if not ammoConfig.mt2 then ammoConfig.mt2 = { text = "exura", min = 90, max = 100 } end
-- if not ammoConfig.slot then ammoConfig.slot = 10 end -- Migração para slot

-- -- Layout ManaTrainEntry
-- g_ui.loadUIFromString([[
-- ManaTrainEntry < Panel
  -- height: 85
  -- margin-top: 5
  -- background-color: #00000033
  -- padding: 5

  -- Label
    -- id: title
    -- anchors.top: parent.top
    -- anchors.left: parent.left
    -- font: verdana-11px-rounded
    -- text-auto-resize: true
    -- color: #FFAA00

  -- TextEdit
    -- id: text
    -- anchors.top: title.bottom
    -- anchors.left: parent.left
    -- anchors.right: parent.right
    -- margin-top: 3
    -- height: 20
    -- font: verdana-11px-rounded

  -- Label
    -- id: minLabel
    -- anchors.top: text.bottom
    -- anchors.left: parent.left
    -- margin-top: 8
    -- text: Min %: 
    -- font: verdana-11px-rounded
    -- width: 60

  -- HorizontalScrollBar
    -- id: minScroll
    -- anchors.verticalCenter: minLabel.verticalCenter
    -- anchors.left: minLabel.right
    -- anchors.right: parent.right
    -- minimum: 1
    -- maximum: 100
    -- step: 1

  -- Label
    -- id: maxLabel
    -- anchors.top: minLabel.bottom
    -- anchors.left: parent.left
    -- margin-top: 8
    -- text: Max %: 
    -- font: verdana-11px-rounded
    -- width: 60

  -- HorizontalScrollBar
    -- id: maxScroll
    -- anchors.verticalCenter: maxLabel.verticalCenter
    -- anchors.left: maxLabel.right
    -- anchors.right: parent.right
    -- minimum: 1
    -- maximum: 100
    -- step: 1

-- AmmoConfigRow < Panel
  -- height: 40
  -- margin-top: 5
  -- margin-left: 5
  -- margin-right: 5
  
  -- BotItem
    -- id: itemAmmo
    -- anchors.left: parent.left
    -- anchors.verticalCenter: parent.verticalCenter
    -- size: 34 34
    
  -- Label
    -- id: lblAmmo
    -- text: Target Slot:
    -- font: verdana-11px-rounded
    -- anchors.left: itemAmmo.right
    -- anchors.verticalCenter: parent.verticalCenter
    -- margin-left: 10
    
  -- ComboBox
    -- id: slotCombo
    -- anchors.left: lblAmmo.right
    -- anchors.right: parent.right
    -- anchors.verticalCenter: parent.verticalCenter
    -- margin-left: 5

-- AmmoCheckWindow < MainWindow
  -- text: Manager & Trainer
  -- size: 300 380
  -- @onEscape: self:hide()

  -- Panel
    -- id: content
    -- anchors.fill: parent
    -- anchors.bottom: closeButton.top
    -- margin-bottom: 5
    -- layout:
      -- type: verticalBox
      -- fit-children: true

  -- Button
    -- id: closeButton
    -- text: Close
    -- font: cipsoftFont
    -- anchors.bottom: parent.bottom
    -- anchors.right: parent.right
    -- width: 60
-- ]])

-- local ammoUi = setupUI([[
-- Panel
  -- height: 20
  -- margin-top: 2

  -- BotSwitch
    -- id: switch
    -- anchors.top: parent.top
    -- anchors.left: parent.left
    -- text-align: center
    -- width: 130
    -- height: 18
    -- text: Check Ammo & Train

  -- Button
    -- id: setupBtn
    -- anchors.top: prev.top
    -- anchors.left: prev.right
    -- anchors.right: parent.right
    -- margin-left: 3
    -- height: 18
    -- text: Setup
-- ]], parent)

-- local rootWidget = g_ui.getRootWidget()
-- if rootWidget then
    -- local ammoWindow = UI.createWindow('AmmoCheckWindow', rootWidget)
    -- ammoWindow:hide()

    -- local content = ammoWindow.content

    -- -------------------------------------------------
    -- -- 1. AMMO SECTION
    -- -------------------------------------------------
    -- local ammoHeader = UI.createWidget('AmmoConfigRow', content)
    
    -- local itemAmmo = ammoHeader.itemAmmo
    -- local slotCombo = ammoHeader.slotCombo
    
    -- -- Configuração do Item
    -- itemAmmo:setItemId(ammoConfig.targetAmmoId or 0)
    -- itemAmmo:onItemChange(function(widget)
        -- ammoConfig.targetAmmoId = widget:getItemId()
    -- end)

    -- -- Configuração do ComboBox
    -- slotCombo:addOption("Ammo Slot", 10)
    -- slotCombo:addOption("Left Hand", 6)
    -- slotCombo:addOption("Right Hand", 5)
    -- slotCombo:addOption("Ring Slot", 9)
    -- slotCombo:addOption("Necklace", 2)
    
    -- -- Selecionar valor atual
    -- slotCombo:setCurrentOptionByData(ammoConfig.slot, 10)

    -- slotCombo.onOptionChange = function(widget)
        -- ammoConfig.slot = widget:getCurrentOption().data
    -- end

    -- local lblWarn = UI.createWidget('Label', content)
    -- lblWarn:setText("Move p/ BP se diferente.\nEquipa se vazio.")
    -- lblWarn:setColor("#ffaa00")
    -- lblWarn:setFont("verdana-11px-rounded")
    -- lblWarn:setTextAlign(AlignCenter)
    -- lblWarn:setMarginTop(5)
    -- lblWarn:setHeight(30) -- Espaço para duas linhas

    -- UI.createWidget('HorizontalSeparator', content)

    -- -------------------------------------------------
    -- -- 2. MANA TRAIN SECTIONS
    -- -------------------------------------------------
    -- local function addManaTrainSetup(parent, key, title)
        -- local widget = UI.createWidget('ManaTrainEntry', parent)
        -- widget.title:setText(title)
        
        -- local configData = ammoConfig[key] or {}
        -- local currentMin = configData.min or 0
        -- local currentMax = configData.max or 0
        
        -- widget.text:setText(configData.text or "")
        
        -- widget.minLabel:setText("Min: " .. currentMin .. "%")
        -- widget.minScroll:setValue(currentMin)
        
        -- widget.maxLabel:setText("Max: " .. currentMax .. "%")
        -- widget.maxScroll:setValue(currentMax)

        -- widget.text.onTextChange = function(w, text)
            -- if not ammoConfig[key] then ammoConfig[key] = {} end
            -- ammoConfig[key].text = text
        -- end
        -- widget.minScroll.onValueChange = function(scroll, val)
            -- if not ammoConfig[key] then ammoConfig[key] = {} end
            -- ammoConfig[key].min = val
            -- widget.minLabel:setText("Min: " .. val .. "%")
        -- end
        -- widget.maxScroll.onValueChange = function(scroll, val)
            -- if not ammoConfig[key] then ammoConfig[key] = {} end
            -- ammoConfig[key].max = val
            -- widget.maxLabel:setText("Max: " .. val .. "%")
        -- end
    -- end

    -- addManaTrainSetup(content, "mt1", "Mana Train #1")
    -- addManaTrainSetup(content, "mt2", "Mana Train #2")

    -- -------------------------------------------------
    -- -- CONTROLES DA JANELA
    -- -------------------------------------------------
    -- ammoUi.setupBtn.onClick = function()
        -- ammoWindow:show()
        -- ammoWindow:raise()
        -- ammoWindow:focus()
    -- end

    -- ammoWindow.closeButton.onClick = function()
        -- ammoWindow:hide()
    -- end

    -- ammoUi.switch:setOn(ammoConfig.enabled)
    -- ammoUi.switch.onClick = function(widget)
        -- ammoConfig.enabled = not ammoConfig.enabled
        -- widget:setOn(ammoConfig.enabled)
    -- end
-- end

-- -- Macro Unificado
-- macro(500, function()
    -- if not ammoConfig.enabled then return end
    
    -- local player = g_game.getLocalPlayer()
    -- if not player then return end

    -- ----------------------------------------------------------------
    -- -- 1. Lógica do Slot Manager (Swap/Equip)
    -- ----------------------------------------------------------------
    -- local targetId = ammoConfig.targetAmmoId
    -- local slotId = ammoConfig.slot or 10 -- Padrão Ammo se nulo
    
    -- if targetId > 100 then -- Só executa se houver um item configurado
        -- local itemInSlot = player:getInventoryItem(slotId)
        
        -- -- A: Se tem item no slot e é diferente do alvo -> Move para BP
        -- if itemInSlot and itemInSlot:getId() ~= targetId then
            -- g_game.move(itemInSlot, {x=65535, y=SlotBack, z=0}, itemInSlot:getCount())
        
        -- -- B: Se o slot está vazio (ou acabamos de mover), tenta equipar o certo
        -- elseif not itemInSlot or itemInSlot:getId() ~= targetId then
            -- local itemToEquip = findItem(targetId)
            -- if itemToEquip then
                -- g_game.move(itemToEquip, {x=65535, y=slotId, z=0}, itemToEquip:getCount())
            -- end
        -- end
    -- end

    -- ----------------------------------------------------------------
    -- -- 2. Lógica do Mana Train
    -- ----------------------------------------------------------------
    -- local manaPct = math.min(100, math.floor(100 * (player:getMana() / player:getMaxMana())))
    -- local trains = {ammoConfig.mt1, ammoConfig.mt2}

    -- for _, t in ipairs(trains) do
        -- if t and t.text and t.text ~= "" then
            -- if manaPct >= (t.min or 0) and manaPct <= (t.max or 100) then
                -- say(t.text)
            -- end
        -- end
    -- end
-- end)

----------------------------------------------------------------------
-- MANA TRAIN 03 (STANDALONE)
----------------------------------------------------------------------
UI.Label("Mana Train_03")
if type(storage.manaTrain_03) ~= "table" then
  storage.manaTrain_03 = {on=false, title="MP%", text="utamo vita", min=90, max=100}
end

local mt3Macro = macro(1000, function()
  local mana = math.min(100, math.floor(100 * (player:getMana() / player:getMaxMana())))
  local conf = storage.manaTrain_03
  if conf.max >= mana and mana >= conf.min then
    say(conf.text)
  end
end)
mt3Macro.setOn(storage.manaTrain_03.on)

UI.DualScrollPanel(storage.manaTrain_03, function(widget, newParams) 
  storage.manaTrain_03 = newParams
  mt3Macro.setOn(storage.manaTrain_03.on)
end)

macro(1000, "Stack items", function()
  local containers = g_game.getContainers()
  local toStack = {}
  for index, container in pairs(containers) do
    if not container.lootContainer then -- ignore monster containers
      for i, item in ipairs(container:getItems()) do
        if item:isStackable() and item:getCount() < 100 then
          local stackWith = toStack[item:getId()]
          if stackWith then
            g_game.move(item, stackWith[1], math.min(stackWith[2], item:getCount()))
            return
          end
          toStack[item:getId()] = {container:getSlotPosition(i - 1), 100 - item:getCount()}
        end
      end
    end
  end
end)

local idz = {3031, 3035, 3043, 14112, 10386, 10384, 3428, 3725} -- adicionar ID dos itens
macro(400, "Coletar", function()
local z = posz()
for _, tile in ipairs(g_map.getTiles(z)) do
    if z ~= posz() then return end
        if getDistanceBetween(pos(), tile:getPosition()) <= 1 then -- distï¿½ncia que quer coletar
            if table.find(idz, tile:getTopLookThing():getId()) then
                g_game.move(tile:getTopLookThing(), {x = 65535, y=SlotBack, z=0}, tile:getTopLookThing():getCount())
            end
        end
    end
end)

macro(10000, "Close Channels", function()
  modules.game_console.removeTab("Trade")
  modules.game_console.removeTab("QUESTS")
  modules.game_console.removeTab("Loot")
  modules.game_console.removeTab("Death Channel")
end)


macro(200, "Empurrar Itens", function()
  push(0, -1)  -- Empurra o item ao norte para 1 sqm ao norte
  push(0, 1)   -- Empurra o item ao sul para 1 sqm ao sul
  push(-1, 0)  -- Empurra o item a oeste para 1 sqm a oeste
  push(1, 0)   -- Empurra o item a leste para 1 sqm a leste
end)

function push(x, y)
  local playerPos = player:getPosition()
  local targetPos = {x = playerPos.x + x, y = playerPos.y + y, z = playerPos.z}
  local pushPos = {x = targetPos.x + x, y = targetPos.y + y, z = targetPos.z}

  local tile = g_map.getTile(targetPos)
  local thing = tile and tile:getTopThing()
  
  if thing and thing:isItem() then
    g_game.move(thing, pushPos, thing:getCount())
  end
end

macro(11000, "Say bless with delay", function()
  if storage.autoBlessMessage:len() > 0 then sayChannel(channel, storage.autoBlessMessage) end
end)

UI.TextEdit(storage.autoBlessMessage or "!bless", function(widget, text)    
  storage.autoBlessMessage = text
end)

macro(400, "Cavebot Check", function()
    if player:getHealth() == 0 and CaveBot.isOn() then
		CaveBot.setOff()
		print("Cavebot desligado: Personagem morreu.")
    end
    
	if storage.caveBot.backOffline and isInPz() and CaveBot.isOn() then
		CaveBot.setOff()
		storage.caveBot.backOffline = false
		print("Cavebot desligado: botão offline pressionado.")
	end
	
    if isInPz() and stamina() < 18 * 60 and CaveBot.isOn() then  -- stamina() retorna a stamina em minutos
		CaveBot.setOff()
		print("Cavebot desligado: Stamina abaixo de 18:00 e personagem em PZ.")
    end
end)

-- UI.Separator()

-- macro(1000, "Vocation Summon - V13+", function()
    -- if isInPz() then return end
    -- if modules.game_cooldown.isGroupCooldownIconActive(3) then return end
    -- local voc_data = { [1] = "eq", [2] = "sac", [3] = "ven", [4] = "dru", }
    -- local spell_end = voc_data[player:getVocation()]
    -- if spell_end then
        -- local spell = "utevo gran res " .. spell_end
        -- if canCast(spell) then
            -- cast(spell, 900000)
        -- end
    -- end
-- end)

macro(200, "Open Next BP Cheia", function()
    -- Transformamos a lista em uma tabela usando { }
    local containerIds = {9605, 2854, 3253, 2853, 5949, 5950, 2869, 2861, 8860, 8861, 2872, 2864, 9605, 9601, 10326, 10324, 10325, 7342, 7343, 2871, 2863, 2865, 2857, 2870, 2862, 10202, 5801, 10327, 9604, 3244, 9602, 9603, 5926, 5927, 2868, 2860, 2867, 2859, 10346, 2866, 2858}
    
    local containers = g_game.getContainers()
    
    for _, container in pairs(containers) do
        local containerItem = container:getContainerItem()
        
        -- Verifica se o container existe e se o ID dele está na nossa lista
        if containerItem and table.find(containerIds, containerItem:getId()) then
            
            -- Verifica se está cheio (qtde de itens >= capacidade)
            if #container:getItems() >= container:getCapacity() then
                
                -- Procura por uma nova backpack dentro desta que está cheia
                for _, item in ipairs(container:getItems()) do
                    if table.find(containerIds, item:getId()) then
                        -- Abre a nova backpack no lugar da antiga
                        g_game.open(item, container)
                        delay(500) -- Pequeno delay para evitar spam
                        return -- Encerra a execução para não tentar abrir várias ao mesmo tempo
                    end
                end
            end
        end
    end
end)


sprh = macro(100, "Esconde Sprite Magias", function() end)
onAddThing(function(tile, thing)
    if sprh.isOff() then return end
    if thing:isEffect() then
        thing:hide()
    end
end)

--[[Esconder Magias Laranjas da tela]]--
TH = macro(100, "Esconde Mensagens Laranjas", function() end)
onStaticText(function(thing, text)
    if TH.isOff() then return end
    if not text:find('says:') then
        g_map.cleanTexts()
   end
end)

local lockerIds = {3499, 3497, 3498, 3500}

-- Função auxiliar para verificar valor na tabela
local function isInArray(array, value)
    for _, v in ipairs(array) do
        if v == value then return true end
    end
    return false
end

macro(3000, "Keep Locker Open", function()
    -- 1. Verifica se já existe um container "Locker" aberto
    local containers = g_game.getContainers()
    for index, container in pairs(containers) do
        -- Verifica o nome do container (converte para minúsculo para evitar erro)
        if container:getName():lower() == "locker" then
            return -- Já está aberto, não faz nada
        end
    end

    -- 2. Se não estiver aberto, procura ao redor
    local player = g_game.getLocalPlayer()
    local pos = player:getPosition()
    
    for x = -1, 1 do
        for y = -1, 1 do
            local checkPos = {x = pos.x + x, y = pos.y + y, z = pos.z}
            local tile = g_map.getTile(checkPos)
            
            if tile then
                local items = tile:getItems()
                for i, item in ipairs(items) do
                    if isInArray(lockerIds, item:getId()) then
                        g_game.use(item) -- Abre o locker
                        return -- Encerra o ciclo para não tentar abrir 2 vezes
                    end
                end
            end
        end
    end
end)



UI.Separator()
UI.Label("Auto Energy Ring")

-- Configuração
if type(storage.eringConfig) ~= "table" then
    storage.eringConfig = {
        on = false,
        title = "HP%",
        min = 40,
        max = 85
    }
end

-- Esta linha garante que a caixa de texto seja removida caso tenha ficado salva anteriormente
storage.eringConfig.text = nil 

local eringMacro = macro(100, function()
    local conf = storage.eringConfig
    local hp = hppercent()
    local fingerItem = getInventoryItem(SlotFinger)
    
    local eringId = 3051        -- ID Energy Ring na bag
    local eringActiveId = 3088  -- ID Energy Ring equipado
    
    -- 1. Lógica de EQUIPAR (HP <= Min)
    if hp <= conf.min then
        if not fingerItem or (fingerItem:getId() ~= eringId and fingerItem:getId() ~= eringActiveId) then
            if g_game.getClientVersion() >= 870 then
                g_game.equipItemId(eringId)
            else
                local ring = findItem(eringId)
                if ring then
                    moveToSlot(ring, SlotFinger, 1)
                end
            end
        end
        return 
    end

    -- 2. Lógica de REMOVER (HP > Max)
    if hp > conf.max then
        if fingerItem and (fingerItem:getId() == eringId or fingerItem:getId() == eringActiveId) then
            -- Move para a Backpack (SlotBack = 3)
            g_game.move(fingerItem, {x=65535, y=SlotBack, z=0}, fingerItem:getCount())
        end
    end
end)

-- Vincula o botão On/Off
eringMacro.setOn(storage.eringConfig.on)

-- Cria o Painel (Sem o campo de texto, pois removemos o 'text' da config)
UI.DualScrollPanel(storage.eringConfig, function(widget, newParams)
    storage.eringConfig = newParams
    storage.eringConfig.text = nil -- Garante que continue sem texto ao salvar
    eringMacro.setOn(storage.eringConfig.on)
end)