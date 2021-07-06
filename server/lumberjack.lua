ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("zn-lumberjack:kütükver")
AddEventHandler("zn-lumberjack:kütükver", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.canCarryItem("kütük", 1) then
        xPlayer.addInventoryItem("kütük", 1)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Yer Yok')
    end
end)

RegisterNetEvent("zn-lumberjack:odunacevir")
AddEventHandler("zn-lumberjack:odunacevir", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.removeInventoryItem("kütük", 20) then
        xPlayer.addInventoryItem("odun", 20)
    end
end)

RegisterNetEvent("zn-lumberjack:talasyap")
AddEventHandler("zn-lumberjack:talasyap", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.removeInventoryItem("odun", 20) then
        xPlayer.addInventoryItem("talas", 20)
    end
end)

ESX.RegisterServerCallback("zn-lumberjack:kontrol", function(source, cb, itemname)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getQuantity(itemname)

    if item >= 20 then
        cb(true)
    else
        cb(false) 
    end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		print('[^2zn-lumberjack^0] - Started!')
	end
end)