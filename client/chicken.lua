ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local sontavuk = 1
local tavukisleme = vector3(-87.9358, 6235.291, 30.090)
local paketleme = vector3(-98.6712, 6204.901, 30.025)
local tavuklokasyon = {
    vector3(-68.3925, 6248.339, 30.604),
    vector3(-64.8276, 6245.730, 30.600),
    vector3(-62.9058, 6241.909, 30.609),
    vector3(-66.0997, 6236.803, 30.601)
}
local bussy = false

Citizen.CreateThread(function()
    while true do
        local sleep = 1500
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = #(playercoords - vector3(tavuklokasyon[sontavuk].x, tavuklokasyon[sontavuk].y, tavuklokasyon[sontavuk].z))
        local dst2 = #(playercoords - vector3(tavukisleme.x, tavukisleme.y, tavukisleme.z))
        local dst3 = #(playercoords - vector3(paketleme.x, paketleme.y, paketleme.z))

        if dst < 25 then
            sleep = 2
            DrawMarker(2, tavuklokasyon[sontavuk].x, tavuklokasyon[sontavuk].y, tavuklokasyon[sontavuk].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 255, 145, 0, 150, 0, 0, 0, 1, 0, 0, 0)
            if dst < 2 then
                DrawText3Ds(tavuklokasyon[sontavuk].x, tavuklokasyon[sontavuk].y, tavuklokasyon[sontavuk].z + 0.5, '[E] Tavuk Topla')
                if IsControlJustReleased(0, 38) and not bussy then
                    bussy = true
                    sontavuk = math.random(1, #tavuklokasyon)
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "tavuk",
                        duration = 5000,
                        label = "tavuk toplanıyor...",
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
                            TriggerServerEvent("zn-chicken:tavuk")
                        end
                        bussy = false
                    end)
                end
            end
        end

        if dst2 < 2 then
            sleep = 2
            DrawText3Ds(tavukisleme.x, tavukisleme.y, 31.509 + 0.5, '[E] Tavukcu İso')
            if IsControlJustReleased(0, 38) and not bussy then
                ESX.TriggerServerCallback("zn-chicken:kontrol", function(tavuk)
                    if tavuk then
                        bussy = true
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "tavukiso",
                            duration = 75000,
                            label = "tavuklar kesiliyor...",
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
                                TriggerServerEvent("zn-chicken:kesilmistavuk")
                            end
                            bussy = false
                        end)
                    else
                        ESX.ShowNotification("Üzerinde En Az 10 Tavuk Olmalı!")
                    end
                end, "canlitavuk")
            end
        end

        if dst3 < 2 then
            sleep = 2
            DrawText3Ds(paketleme.x, paketleme.y, 31.455 + 0.5, '[E] Paket Naci')
            if IsControlJustReleased(0, 38) and not bussy then
                ESX.TriggerServerCallback("zn-chicken:kontrol", function(paket)
                    if paket then
                        bussy = true
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "paketnaci",
                            duration = 75000,
                            label = "tavuklar paketleniyor...",
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
                                TriggerServerEvent("zn-chicken:paketle")
                            end
                            bussy = false
                        end)
                    else
                        ESX.ShowNotification("Üzerinde En Az 10 Tane Kesilmiş Tavuk Olması Gerek")
                    end
                end, "kesilmistavuk")
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    
    local ped_hash = 0x0DE9A30A -- kullanmak istediğiniz pedin hashi / hash of the ped
    local ped_coords = tavukisleme.x, tavukisleme.y, tavukisleme.z, 300.0 -- pedi konumlandırmak istediğiniz konum
    RequestModel(ped_hash)
    while not HasModelLoaded(ped_hash) do
        Citizen.Wait(1)
    end
    ped_info = CreatePed(1, ped_hash, tavukisleme.x, tavukisleme.y, tavukisleme.z, 300.0, false, true)
    SetBlockingOfNonTemporaryEvents(ped_info, true) -- değiştirmeyin
    SetPedDiesWhenInjured(ped_info, false) -- pedin ölümlü veya ölümsüz olmasını ayarlamak için
    SetPedCanPlayAmbientAnims(ped_info, true) -- değiştirmeyin
    SetPedCanRagdollFromPlayerImpact(ped_info, false) --pedin yere düşmesini engellemek için
    SetEntityInvincible(ped_info, true)    -- pedin görünmez olması için
    FreezeEntityPosition(ped_info, true) -- değiştimeyin
 
end)

Citizen.CreateThread(function()
    
    local ped_hash = 0x18CE57D0 -- kullanmak istediğiniz pedin hashi / hash of the ped
    local ped_coords = paketleme.x, paketleme.y, paketleme.z, 400.0 -- pedi konumlandırmak istediğiniz konum
    RequestModel(ped_hash)
    while not HasModelLoaded(ped_hash) do
        Citizen.Wait(1)
    end
    ped_info = CreatePed(1, ped_hash, paketleme.x, paketleme.y, paketleme.z, 400.0, false, true)
    SetBlockingOfNonTemporaryEvents(ped_info, true) -- değiştirmeyin
    SetPedDiesWhenInjured(ped_info, false) -- pedin ölümlü veya ölümsüz olmasını ayarlamak için
    SetPedCanPlayAmbientAnims(ped_info, true) -- değiştirmeyin
    SetPedCanRagdollFromPlayerImpact(ped_info, false) --pedin yere düşmesini engellemek için
    SetEntityInvincible(ped_info, true)    -- pedin görünmez olması için
    FreezeEntityPosition(ped_info, true) -- değiştimeyin
 
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(-68.3925, 6248.339, 30.604)

	SetBlipSprite (blip, 268)
	SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Tavukçuluk")
	EndTextCommandSetBlipName(blip)
end)
