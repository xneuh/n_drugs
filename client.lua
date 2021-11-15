ESX = nil
local currentZone = nil
local notifyText = nil
local isInMarker = false
local isSpawned = false
local timeLeft = nil
local pedCoords = GetEntityCoords(GetPlayerPed(-1))
local playerPed = GetPlayerPed(-1)
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Funkcja odpowiadająca za liczenie procentów przy zbieraniu/przerabianiu narkotyków

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()

    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = (string.len(text)) / 270
    DrawRect(_x, _y + 0.015, 0.005 + factor, 0.03, 31, 31, 31, 155)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if timeLeft ~= nil then
            local coords = GetEntityCoords(playerPed)
            DrawText3D(coords.x, coords.y, coords.z + 0.1, timeLeft .. '~g~%', 0.4)
        end
    end
end)

function procent(time, cb)
    if cb ~= nil then
        Citizen.CreateThread(function()
            timeLeft = 0
            repeat
                timeLeft = timeLeft + 1
                Citizen.Wait(time)
            until timeLeft == 100
            timeLeft = nil
            cb()
        end)
    else
        timeLeft = 0
        repeat
            timeLeft = timeLeft + 1
            Citizen.Wait(time)
        until timeLeft == 100
        timeLeft = nil
    end
end

-- KONIEC




-- Event wywołujący efekt oparzenia (Zabiera hp graczowi)


RegisterNetEvent('dragi:oparzenie')
AddEventHandler('dragi:oparzenie', function()
    for i=1,4 do
    SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - 5)
    end
end)


-- KONIEC



-- Funkcja odpowiadająca za pokazywanie blipów (Zakomentuj linijke 104 aby marker się nie pokazywał)

CreateThread(function()

    while true do

        Wait(1)


        for k,v in pairs(Config.Zones) do
            if(GetDistanceBetweenCoords(GetEntityCoords(playerPed), v.x, v.y, v.z, true) < 10) then
               DrawMarker(1, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.7, 4.7, 1.1, 70, 163, 76, 50, false, false, 0, nil, nil, false)
               if(GetDistanceBetweenCoords(GetEntityCoords(playerPed), v.x, v.y, v.z, false) < 2) then
                    isInMarker = true
                    currentZone = k
                    --print(k)    
                    --print(GetEntityHealth(PlayerPedId()))
               else
                currentZone = nil
                isInMarker = false
               end
            end
        end
    end
end) 

-- KONIEC


-- Funkcja odpowiadająca za pokazywanie Helptextu po wejsciu do markera oraz triggerowanie eventu
-- który rozpoczyna zbieranie narkotyków po kliknięciu przycisku E

CreateThread(function() 

    while true do

        Wait(1)

        if currentZone ~= nil then
            DisplayHelpText(notifyText)
        end



        -- Metamfetamina

        if currentZone == 'methCollecting' then
            notifyText = "~y~Wciśnij ~INPUT_PICKUP~ aby rozpocząć gotowanie Metamfetaminy"
            if IsControlJustPressed(0, 38) then
                FreezeEntityPosition(PlayerPedId(), true)
                procent(25, function()
                    ClearPedTasksImmediately(playerPed)
                    TriggerServerEvent('ace_drugs:meth', "Collecting")
                    FreezeEntityPosition(PlayerPedId(), false)
                end)
            end
        end

        if currentZone == 'methPrzerobka' then
            notifyText = "~y~Wciśnij ~INPUT_PICKUP~ aby rozpocząć działkowanie Metamfetaminy"
            if IsControlJustPressed(0, 38) then
                FreezeEntityPosition(PlayerPedId(), true)
                procent(25, function()
                    ClearPedTasksImmediately(playerPed)
                    TriggerServerEvent('ace_drugs:meth', "Transform")
                    FreezeEntityPosition(PlayerPedId(), false)
                end)
            end
        end



        -- Mieszanie Chemikaliów 

        if currentZone == "chemikalia" then
            notifyText = "~y~Wciśnij ~INPUT_PICKUP~ aby rozpocząć mieszanie Chemikaliów"
            
            if IsControlJustPressed(0, 38) then
                FreezeEntityPosition(PlayerPedId(), true)
                procent(65, function()
                    ClearPedTasksImmediately(playerPed)
                    TriggerServerEvent('ace_drugs:chemikalia', "Mieszanie")
                    FreezeEntityPosition(PlayerPedId(), false)
                end)
            end
        end


        -- Kokaina

        if currentZone == "cokeCollecting" then
            notifyText = "~y~Wciśnij ~INPUT_PICKUP~ aby rozpocząć zbieranie Lisci Kokainy"
            if IsControlJustPressed(0, 38) then
                FreezeEntityPosition(PlayerPedId(), true)
                procent(65, function()
                    ClearPedTasksImmediately(playerPed)
                    TriggerServerEvent('ace_drugs:coke', "Collecting")
                    FreezeEntityPosition(PlayerPedId(), false)
                end)
            end
        end
        if currentZone == "cokePrzerobka" then
            notifyText = "~y~Wciśnij ~INPUT_PICKUP~ aby rozpocząć przerabianie Liści Kokainy"
            if IsControlJustPressed(0, 38) then
            FreezeEntityPosition(PlayerPedId(), true)
            procent(5, function()
                ClearPedTasksImmediately(playerPed)
                TriggerServerEvent('ace_drugs:coke', "Transform")
                FreezeEntityPosition(PlayerPedId(), false)
                end)
            end
        end
    end
end)    
