ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('lx_coffee:removeItem' .. Config.EventKey)
AddEventHandler('lx_coffee:removeItem' .. Config.EventKey, function(item, count)
    --print(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem(item, count)
end)

RegisterNetEvent('lx_coffee:addItem' .. Config.EventKey)
AddEventHandler('lx_coffee:addItem' .. Config.EventKey, function(item)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem(item, 1)

end)