ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("zn-satis:token")
AddEventHandler("zn-satis:token", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem("mdntoken").count >= 1 then
        xPlayer.removeInventoryItem("mdntoken", 1)
        Citizen.Wait(100)
        xPlayer.addMoney(15)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Token Yok')
    end
end)

RegisterNetEvent("zn-satis:tavuk")
AddEventHandler("zn-satis:tavuk", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem("paketlenmistavuk").count >= 1 then
        xPlayer.removeInventoryItem("paketlenmistavuk", 1)
        Citizen.Wait(100)
        xPlayer.addMoney(15)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Tavuk Yok')
    end
end)

RegisterNetEvent("zn-satis:elbise")
AddEventHandler("zn-satis:elbise", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem("elbise").count >= 1 then
        xPlayer.removeInventoryItem("elbise", 1)
        Citizen.Wait(100)
        xPlayer.addMoney(30)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Elbise Yok')
    end
end)

RegisterNetEvent("zn-satis:talas")
AddEventHandler("zn-satis:talas", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem("talas").count >= 1 then
        xPlayer.removeInventoryItem("talas", 1)
        Citizen.Wait(100)
        xPlayer.addMoney(40)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Talaş Yok')
    end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		print('[^2zn-satis^0] - Started!')
	end
end)