ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local sonodun = 1
local odunisleme = vector3(-554.357, 5328.062, 72.609)
local talas = vector3(-489.608, 5287.402, 79.650)
local odunlokasyon = {
    vector3(-529.481, 5372.133, 70.000),
    vector3(-537.241, 5378.509, 70.006),
    vector3(-543.874, 5388.922, 69.751),
    vector3(-549.895, 5375.443, 70.004),
    vector3(-554.301, 5370.346, 69.854),
    vector3(-538.555, 5372.296, 70.007)
}

local bussy = false
Citizen.CreateThread(function()
    while true do
        local sleep = 1500
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = #(playercoords - vector3(odunlokasyon[sonodun].x, odunlokasyon[sonodun].y, odunlokasyon[sonodun].z))
        local dst2 = #(playercoords - vector3(odunisleme.x, odunisleme.y, odunisleme.z))
        local dst3 = #(playercoords - vector3(talas.x, talas.y, talas.z))

        if dst < 25 then
            sleep = 2
            DrawMarker(2, odunlokasyon[sonodun].x, odunlokasyon[sonodun].y, odunlokasyon[sonodun].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 255, 180, 0, 150, 0, 0, 0, 1, 0, 0, 0)
            if dst < 2 then
                DrawText3Ds(odunlokasyon[sonodun].x, odunlokasyon[sonodun].y, odunlokasyon[sonodun].z + 0.5, '[E] Ağaç Kes')
                if IsControlJustReleased(0, 38) and not bussy then
                    sonodun = math.random(1, #odunlokasyon)
                    bussy = true
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "odun",
                        duration = 5000,
                        label = "odun kesiyorsun",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "amb@prop_human_bum_shopping_cart@male@idle_a",
                            anim = "idle_c",
                            flags = 49,
                        },
                    }, function(status)
                        if not status then
                            TriggerServerEvent("zn-lumberjack:kütükver")
                        end
                        bussy = false
                    end)
                end
            end
        end

        if dst2 < 2 then
            sleep = 2
            DrawText3Ds(odunisleme.x, odunisleme.y, 74.009 + 0.5, '[E] Oduncu Ahmet')
            if IsControlJustReleased(0, 38) and not bussy then
                ESX.TriggerServerCallback("zn-lumberjack:kontrol", function(item)
                    if item then
                        bussy = true
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "oduncuahmet",
                            duration = 75000,
                            label = "odunlar işleniyor...",
                            useWhileDead = false,
                            canCancel = false,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            },
                        }, function(status)
                            if not status then
                                TriggerServerEvent("zn-lumberjack:odunacevir")
                            end
                            bussy = false
                        end)
                    else
                        ESX.ShowNotification("Üzerinde En Az 20 Tane Kütük Olması Gerek!")
                    end
                end, "kütük")
            end
        end

        if dst3 < 2.0 then
            sleep = 2
            DrawText3Ds(talas.x, talas.y, 81.059 + 0.5, '[E] Talaş Osman')
            if IsControlJustReleased(0, 38) and not bussy then
                ESX.TriggerServerCallback("zn-lumberjack:kontrol", function(item)
                    if item then
                        bussy = true
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "oduncuahmet",
                            duration = 75000,
                            label = "talaşa çeviriliyor...",
                            useWhileDead = false,
                            canCancel = false,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            },
                        }, function(status)
                            if not status then
                                TriggerServerEvent("zn-lumberjack:talasyap")
                            end
                            bussy = false
                        end)
                    else
                        ESX.ShowNotification("Üzerinde En Az 20 Tane Odun Olması Gerek!")
                    end
                end, "odun")
            end
        end
        
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    
    local ped_hash = 0x94562DD7 -- kullanmak istediğiniz pedin hashi / hash of the ped
    local ped_coords = odunisleme.x, odunisleme.y, odunisleme.z, 170.0 -- pedi konumlandırmak istediğiniz konum
    RequestModel(ped_hash)
    while not HasModelLoaded(ped_hash) do
        Citizen.Wait(1)
    end
    ped_info = CreatePed(1, ped_hash, odunisleme.x, odunisleme.y, odunisleme.z, 170.0, false, true)
    SetBlockingOfNonTemporaryEvents(ped_info, true) -- değiştirmeyin
    SetPedDiesWhenInjured(ped_info, false) -- pedin ölümlü veya ölümsüz olmasını ayarlamak için
    SetPedCanPlayAmbientAnims(ped_info, true) -- değiştirmeyin
    SetPedCanRagdollFromPlayerImpact(ped_info, false) --pedin yere düşmesini engellemek için
    SetEntityInvincible(ped_info, true)    -- pedin görünmez olması için
    FreezeEntityPosition(ped_info, true) -- değiştimeyin
 
end)

Citizen.CreateThread(function()
    
    local ped_hash = 0x62018559 -- kullanmak istediğiniz pedin hashi / hash of the ped
    local ped_coords = talas.x, talas.y, talas.z, 170.0 -- pedi konumlandırmak istediğiniz konum
    RequestModel(ped_hash)
    while not HasModelLoaded(ped_hash) do
        Citizen.Wait(1)
    end
    ped_info = CreatePed(1, ped_hash, talas.x, talas.y, talas.z, 80.0, false, true)
    SetBlockingOfNonTemporaryEvents(ped_info, true) -- değiştirmeyin
    SetPedDiesWhenInjured(ped_info, false) -- pedin ölümlü veya ölümsüz olmasını ayarlamak için
    SetPedCanPlayAmbientAnims(ped_info, true) -- değiştirmeyin
    SetPedCanRagdollFromPlayerImpact(ped_info, false) --pedin yere düşmesini engellemek için
    SetEntityInvincible(ped_info, true)    -- pedin görünmez olması için
    FreezeEntityPosition(ped_info, true) -- değiştimeyin
 
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(-529.481, 5372.133, 70.000)

	SetBlipSprite (blip, 527)
	SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, 21)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Kütük Merkezi")
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(odunisleme)

	SetBlipSprite (blip, 527)
	SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, 21)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Kütük İşleme")
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(talas)

	SetBlipSprite (blip, 527)
	SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, 21)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Odun İşleme")
	EndTextCommandSetBlipName(blip)
end)