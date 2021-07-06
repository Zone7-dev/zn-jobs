ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("zn-chicken:tavuk")
AddEventHandler("zn-chicken:tavuk", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.canCarryItem("canlitavuk", 1) then
        xPlayer.addInventoryItem("canlitavuk", 1)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Yer Yok')
    end
end)

RegisterNetEvent("zn-chicken:kesilmistavuk")
AddEventHandler("zn-chicken:kesilmistavuk", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.removeInventoryItem("canlitavuk", 10) then
        xPlayer.addInventoryItem("kesilmistavuk", 10)
    end
end)

RegisterNetEvent("zn-chicken:paketle")
AddEventHandler("zn-chicken:paketle", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.removeInventoryItem("kesilmistavuk", 10) then
        xPlayer.addInventoryItem("paketlenmistavuk", 10)
    end 
end)

ESX.RegisterServerCallback("zn-chicken:kontrol", function(source, cb, itemname)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(itemname).count

    if item >= 10 then
        cb(true)
    else
        cb(false)
    end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		print('[^2zn-chicken^0] - Started!')
	end
end)