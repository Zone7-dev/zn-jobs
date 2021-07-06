ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("fonzillo")
AddEventHandler("fonzillo", function()
	local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(Config.Para)
end)    

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		print('[^2zn-temizlikci^0] - Started!')
	end
end)