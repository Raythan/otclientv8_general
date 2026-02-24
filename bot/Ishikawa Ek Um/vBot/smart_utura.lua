setDefaultTab("HP")
UI.Separator()

UI.Label("Proximo Utura:")
local nextCastLabel = UI.Label("Pronto")

if not storage.recoveryCastTime then 
    storage.recoveryCastTime = 0 
end

macro(500, "Auto Utura/Gran", function()
    if isInPz() then 
        nextCastLabel:setText("Em PZ")
        return 
    end

    local tempoAtual = os.time()

    if tempoAtual < storage.recoveryCastTime then
        local falta = storage.recoveryCastTime - tempoAtual
        nextCastLabel:setText("Aguarde: " .. falta .. "s")
        return
    end

    local mp = mana()
    local lvl = level()

    if lvl >= 100 and mp >= 165 then
        say("utura gran")
        storage.recoveryCastTime = tempoAtual + 61
        nextCastLabel:setText("Castado: Gran")
        return
    end

    if lvl >= 50 and mp >= 50 then
        say("utura")
        storage.recoveryCastTime = tempoAtual + 61
        nextCastLabel:setText("Castado: Base")
        return
    end
    
    nextCastLabel:setText("Sem Mana")
end)