ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local bussy = false
local kumastopla = vector3(717.24, -959.38, 30.4)
local kumasdik = vector3(714.03, -969.92, 29.9)

Citizen.CreateThread(function()
    while true do
        local sleep = 1500
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = #(playercoords - vector3(kumastopla.x, kumastopla.y, kumastopla.z))
        local dst2 = #(playercoords - vector3(kumasdik.x, kumasdik.y, kumasdik.z))

        if dst < 25 then
            sleep = 2
            DrawMarker(2, kumastopla.x, kumastopla.y, kumastopla.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 110, 0, 100, 0, 0, 0, 1, 0, 0, 0)
            if dst < 2 then
                DrawText3Ds(kumastopla.x, kumastopla.y, kumastopla.z + 0.5, '[E] Kumaşları Al')
                if IsControlJustReleased(0, 38) and not bussy then
                    bussy = true
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "kumas",
                        duration = 15000,
                        label = "kumaşları alıyorsun",
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
                            TriggerServerEvent("zn-tailor:kumas")
                        end
                        bussy = false
                    end)
                end
            end
        end

        if dst2 < 25 then
            sleep = 2
            DrawMarker(2, kumasdik.x, kumasdik.y, kumasdik.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 110, 0, 100, 0, 0, 0, 1, 0, 0, 0)
            if dst2 < 2 then
                DrawText3Ds(kumasdik.x, kumasdik.y, kumasdik.z + 0.5, '[E] Kumaşları Dik')
                if IsControlJustReleased(0, 38) and not bussy then
                    ESX.TriggerServerCallback("zn-chicken:kontrol", function(kumas)
                        if kumas then
                            local finished = exports["reload-skillbar"]:taskBar(math.random(1200,1800),math.random(9,15))
                            if finished ~= 100 then
                                bussy = false
                                ESX.ShowNotification("Kumaşı Dikemedin")
                            else
                                local finished2 = exports["reload-skillbar"]:taskBar(math.random(1200,1800),math.random(9,15))
                                if finished2 ~= 100 then
                                    bussy = false
                                    ESX.ShowNotification("Kumaşı Dikemedin")
                                else
                                    local finished3 = exports["reload-skillbar"]:taskBar(math.random(1200,1800),math.random(9,15))
                                    if finished3 ~= 100 then
                                        bussy = false
                                        ESX.ShowNotification("Kumaşı Dikemedin")
                                    else
                                        TriggerServerEvent("zn-tailor:dik")
                                        bussy = false
                                        ESX.ShowNotification("Kumaşı Başarıyla Diktin")
                                    end
                                end
                            end
                        else
                            ESX.ShowNotification("Üzerinde En Az 10 Kumaş Olması Gerek!")
                        end
                    end, "kumas")
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(kumastopla)

	SetBlipSprite (blip, 366)
	SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, 16)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Terzicilik")
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(kumasdik)

	SetBlipSprite (blip, 366)
	SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, 16)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Kıyafet Dikme")
	EndTextCommandSetBlipName(blip)
end)

