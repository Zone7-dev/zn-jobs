ESX = nil
local sezer20, allahsizvoyvoda36 = nil, 1
local jameshunt = vector3(329.46, -1580.72, 32.8)
local kaptanyilmaz = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
end) 

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(jameshunt)

	SetBlipSprite (blip, 318)
	SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, 43)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Temizlik Merkezi")
	EndTextCommandSetBlipName(blip)
end)

local copler = {
    {
        ["isim"] = "Mission Row Police Station",
        ["kordinatlar"] = {
            vector3(424.24, -984.13, 30.71),
            vector3(424.49, -978.59, 30.71),
            vector3(429.1, -973.83, 30.71),
            vector3(433.6, -975.32, 30.71),
            vector3(432.93, -985.36, 30.71),
            vector3(418.64, -974.41, 29.43),
            vector3(418.57, -982.05, 29.42),
            vector3(431.52, -978.8, 30.71),
            vector3(437.82, -985.07, 30.69)
        }
    },
    {
        ["isim"] = "Pillbox Hastanesi",
        ["kordinatlar"] = {
            vector3(281.17, -611.04, 43.25),
            vector3(282.98, -601.55, 43.14),
            vector3(293.91, -596.91, 43.28),
            vector3(287.8, -596.73, 43.18),
            vector3(293.26, -597.38, 43.27),
            vector3(286.14, -608.07, 43.32),
            vector3(278.14, -601.72, 43.03),
            vector3(273.56, -599.96, 43.12),
            vector3(273.29, -610.95, 43.0)
        }
    },
    {
        ["isim"] = "Motel",
        ["kordinatlar"] = {
            vector3(303.93, -232.95, 54.04),
            vector3(311.06, -232.02, 54.0),
            vector3(318.95, -237.31, 54.03),
            vector3(322.67, -242.65, 53.95),
            vector3(321.22, -232.47, 54.03),
            vector3(302.31, -227.76, 53.99),
            vector3(316.81, -227.71, 54.01),
            vector3(311.09, -239.58, 54.09),
            vector3(320.47, -245.34, 53.92)
        }
    }
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local PlayerPed = PlayerPedId()
        local PlayerKordinat = GetEntityCoords(PlayerPed)

        local mesafe = #(PlayerKordinat - jameshunt)
        if mesafe < 30 then 
            DrawMarker(2, jameshunt.x, jameshunt.y, jameshunt.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 155, 52, 100, false, true, 2, false, false, false, false)
            if mesafe < 0.5 then
                DrawText3Ds(jameshunt.x, jameshunt.y, jameshunt.z, "[E] Temizlik merkezine is için basvur")
                if IsControlJustPressed(0, 38) then
                    if not kaptanyilmaz then
                        kaptanyilmaz = true
                        sezer20 = math.random(1, #copler)
                        ESX.ShowNotification("Temizlik merkezine yaptığın iş başvurun kabul edildi!, Temizlemen gereken mekan: ".. copler[sezer20]["isim"] .."")
                      
                        SetNewWaypoint(copler[sezer20]["kordinatlar"][1].x, copler[sezer20]["kordinatlar"][1].y)
                        ESX.ShowNotification("Konum GPS'de işaretlendi")
                    else
                        ESX.ShowNotification("Zaten şuan bu işi yapıyorsun!", "error")
                    end
                end
            end
        end

        if kaptanyilmaz then
            local konum = copler[sezer20]["kordinatlar"][allahsizvoyvoda36]
            local copMesafe = #(PlayerKordinat - konum)
            if copMesafe < 30 then 
                DrawMarker(2, konum.x, konum.y, konum.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 155, 52, 100, false, true, 2, false, false, false, false)
                if copMesafe < 0.5 then
                    DrawText3Ds(konum.x, konum.y, konum.z, "[E] Temizle")
                    if IsControlJustPressed(0, 38) then
                        local yeniallahsizvoyvoda36 = math.random(1, #copler[sezer20]["kordinatlar"])
                        allahsizvoyvoda36 = yeniallahsizvoyvoda36
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "temizlik_isi",
                            duration = 5000,
                            label = 'Temizleniyor.. [DEL]',
                            useWhileDead = false,
                            canCancel = true,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            },
                            animation = {
                                animDict = "amb@world_human_janitor@male@idle_a",
                                anim = "idle_a",
                                flags = 33,
                            },
                            prop = {
                                model = "prop_tool_broom",
                                bone = 28422,
                                coords = { x = -0.005, y = 0.0, z = 0.0 },
                                rotation = { x = 360.0, y = 360.0, z = 0.0 },
                            }
                        }, function(cancelled)
                            if not cancelled then
                                TriggerServerEvent('fonzillo')
                                ESX.ShowNotification("Yeri temizlediğin için bir miktar para banka hesabına yatırıldı!")
                            end
                        end)
                    end
                end
            end

        end
    end
end)

RegisterCommand("tbitir", function()
	if kaptanyilmaz then
		kaptanyilmaz = false
		exports['mythic_notify']:SendAlert('error', 'Temizlik görevi iptal edildi')
	else
		exports['mythic_notify']:SendAlert('error', 'Temizlik görevine başlamadan iptal edemezsin')
	end
end, false)