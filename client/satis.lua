ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local satis = vector3(-265.575, -963.028, 30.203)

function SatisMenu()
    local elements = {
        {label = 'Maden Token',   value = 'token'},
        {label = 'Paketlenmiş Tavuk',       value = 'tavuk'},
        {label = 'Elbise',       value = 'elbise'},
        {label = 'Talaş',       value = 'talas'},

    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'madenmenu', {
        title    = 'Maden Menüsü',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'token' then
            TriggerServerEvent("zn-satis:token")
            menu.close()
        elseif data.current.value == 'tavuk' then
            TriggerServerEvent("zn-satis:tavuk")
            menu.close()
        elseif data.current.value == 'elbise' then
            TriggerServerEvent("zn-satis:elbise")
            menu.close()
        elseif data.current.value == 'talas' then
            TriggerServerEvent("zn-satis:talas")
            menu.close()
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        local sleep = 1500
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = #(playercoords - vector3(satis.x, satis.y, satis.z))

        if dst < 2 then
            sleep = 2
            DrawText3Ds(satis.x, satis.y, 31.609 + 0.5, '[E] Alıcı Niyazi')
                if IsControlJustReleased(0, 38) then
                    SatisMenu()
                end
            end
            Citizen.Wait(sleep)
        end
end)

Citizen.CreateThread(function()
    
    local ped_hash = 0xD770C9B4 -- kullanmak istediğiniz pedin hashi / hash of the ped
    local ped_coords = satis.x, satis.y, satis.z, 200.0 -- pedi konumlandırmak istediğiniz konum
    RequestModel(ped_hash)
    while not HasModelLoaded(ped_hash) do
        Citizen.Wait(1)
    end
    ped_info = CreatePed(1, ped_hash, satis.x, satis.y, satis.z, 200.0, false, true)
    SetBlockingOfNonTemporaryEvents(ped_info, true) -- değiştirmeyin
    SetPedDiesWhenInjured(ped_info, false) -- pedin ölümlü veya ölümsüz olmasını ayarlamak için
    SetPedCanPlayAmbientAnims(ped_info, true) -- değiştirmeyin
    SetPedCanRagdollFromPlayerImpact(ped_info, false) --pedin yere düşmesini engellemek için
    SetEntityInvincible(ped_info, true)    -- pedin görünmez olması için
    FreezeEntityPosition(ped_info, true) -- değiştimeyin
 
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(satis)

	SetBlipSprite (blip, 133)
	SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, 74)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Satış")
	EndTextCommandSetBlipName(blip)
end)
