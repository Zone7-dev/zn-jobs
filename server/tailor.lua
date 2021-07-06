ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("zn-tailor:kumas")
AddEventHandler("zn-tailor:kumas", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.canCarryItem("kumas", 5) then
        xPlayer.addInventoryItem("kumas", 5)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde Yer Yok')
    end
end)

RegisterNetEvent("zn-tailor:dik")
AddEventHandler("zn-tailor:dik", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.removeInventoryItem("kumas", 10) then
        xPlayer.addInventoryItem("elbise", 10)
    end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		print('[^2zn-tailor^0] - Started!')
	end
end)