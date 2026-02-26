setDefaultTab("Cave")
UI.Separator()

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