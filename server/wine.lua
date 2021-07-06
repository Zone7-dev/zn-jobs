ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("zn-wine:uzum")
AddEventHandler("zn-wine:uzum", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.canCarryItem("uzum", 1) then
        xPlayer.addInventoryItem("uzum", 1)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Yer Yok')
    end
end)

RegisterNetEvent("zn-wine:uzumsat")
AddEventHandler("zn-wine:uzumsat", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem("uzum").count >= 20 then
        xPlayer.removeInventoryItem("uzum", 20)
        Citizen.Wait(500)
        xPlayer.addMoney(5000)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde En Az 20 Tane Üzüm Olması Gerek!')
    end
end)

RegisterNetEvent("zn-wine:sarapyap")
AddEventHandler("zn-wine:sarapyap", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.removeInventoryItem("uzum", 20) then
        Citizen.Wait(500)
        xPlayer.addInventoryItem("sarap", 10)
    end
end)

RegisterNetEvent("zn-wine:sarapsat")
AddEventHandler("zn-wine:sarapsat", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.removeInventoryItem("sarap", 10) then
        Citizen.Wait(500)
        xPlayer.addMoney(7500)
    end
end)


ESX.RegisterServerCallback("zn-wine:uzumkontrol", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem("uzum").count >= 20 then
        cb(true)
    else
        cb(false) 
    end
end)

ESX.RegisterServerCallback("zn-wine:sarapkontrol", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem("sarap").count >= 10 then
        cb(true)
    else
        cb(false) 
    end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		print('[^2zn-wine^0] - Started!')
	end
end)

