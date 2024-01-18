-- Variables

local QBCore = exports['qb-core']:GetCoreObject()
local alarmTriggered = true

-- Tables

local tableOfChances = {
    ["samsungphone"]    = Config.ChanceForSamsungPhone,
    ["iphone"]          = Config.ChanceForIPhone,
    ["tablet"]          = Config.ChanceForTablet,
    ["laptop"]          = Config.ChanceForLaptop
}

-- Events

RegisterNetEvent('qb-ifruitstore:server:LoadLocationList', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        TriggerClientEvent("qb-ifruitstore:server:LoadLocationList", src, Config.Locations)
    end
end)

RegisterNetEvent('qb-ifruitstore:server:setSpotState', function(stateType, state, spot)
    if stateType == "isBusy" or stateType == "isDone" then
        local location = Config.Locations["takeables"]
        if location[spot] then
            location[spot][stateType] = state
            TriggerClientEvent('qb-ifruitstore:client:setSpotState', -1, stateType, state, spot)
        end
    end
end)

RegisterNetEvent("qb-ifruitstore:server:StartThermiteFire", function (coords, maxChildren, isGasFire)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        local ped = xPlayer.PlayerData.ped
        local coordsPed = GetEntityCoords(ped)
        local thermiteCoords = vector3(Config.Locations["thermite"].x, Config.Locations["thermite"].y, Config.Locations["thermite"].z)
        if #(coordsPed - thermiteCoords) < 10 then
            TriggerClientEvent("qb-ifruitstore:client:StartThermiteFire", -1, coords, maxChildren, isGasFire)
        end
    end
end)

-- Stop fire animation
RegisterNetEvent("qb-ifruitstore:server:StopThermiteFire")
AddEventHandler("qb-ifruitstore:server:StopThermiteFire", function ()
    TriggerClientEvent("qb-ifruitstore:client:StopThermiteFire", -1)
end)

RegisterNetEvent('qb-ifruitstore:server:SafeReward')
AddEventHandler('qb-ifruitstore:server:SafeReward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local certificateAmount = math.random(2, 5) -- Replace this with the appropriate amount

    Player.Functions.AddMoney('cash', math.random(1500, 2000), "robbery-ifruit")
    Player.Functions.AddItem("markedbills", certificateAmount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["markedbills"], "add")

    Citizen.Wait(500)

    local luck = math.random(1, 100)
    if luck <= 10 then
        Player.Functions.AddItem("goldbar", math.random(1, 2))
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["goldbar"], "add")
    end
end)


RegisterNetEvent('qb-ifruitstore:server:SetSafeStatus')
AddEventHandler('qb-ifruitstore:server:SetSafeStatus', function(stateType, state)
    if stateType == "isBusy" then
        Config.Locations["safe"].isBusy = state
    elseif stateType == "isDone" then
        Config.Locations["safe"].isDone = state
    end
    TriggerClientEvent('qb-ifruitstore:client:SetSafeStatus', -1, stateType, state)
end)

-- Add item to player's inventory if possible
RegisterNetEvent("qb-ifruitstore:server:GiveItemReward")
AddEventHandler("qb-ifruitstore:server:GiveItemReward", function(spot)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local item = Config.Locations["takeables"][spot].reward

    local chance = math.random(1, 100)
    if Config.Debug then
        TriggerClientEvent("qb-ifruitstore:client:Debugging", -1, "You have a chance of: " .. tableOfChances[item.name] .. "%")
        TriggerClientEvent("qb-ifruitstore:client:Debugging", -1, "Chance to get item = " .. chance) 
    end

    if chance <= tableOfChances[item.name] then
        local randomizedAmount = math.random(1, item.amount)
        
        if player.Functions.AddItem(item.name, randomizedAmount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], 'add', randomizedAmount)
        else
            TriggerClientEvent('QBCore:Notify', src, "Je zakken ziten vol!", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Item niet ontvangen!", 'error')
    end
end)


RegisterNetEvent("qb-ifruitstore:server:SetThermiteCharge")
AddEventHandler("qb-ifruitstore:server:SetThermiteCharge", function(method)
    TriggerClientEvent("qb-ifruitstore:client:SetThermiteCharge", -1, method)
end)

local function sendPoliceAlert(code, description, isImportant, recipientList, length, infoM, info, blipSprite, blipColour, blipScale)
    local data = {
        displayCode = code,
        description = description,
        isImportant = isImportant,
        recipientList = recipientList,
        length = length,
        infoM = infoM,
        info = info,
        blipSprite = blipSprite,
        blipColour = blipColour,
        blipScale = blipScale
    }
    local dispatchData = {
        dispatchData = data,
        caller = "Alarm",
        coords = vector3(Config.Locations["main"].x, Config.Locations["main"].y, Config.Locations["main"].z)
    }
    TriggerEvent("wf-alerts:svNotify", dispatchData)
end

RegisterServerEvent("qb-ifruitstore:server:PoliceAlertMessage1")
AddEventHandler("qb-ifruitstore:server:PoliceAlertMessage1", function()
    sendPoliceAlert("10-11A", "iFruit Overval", 1, {"police"}, "10000", "fas fa-mobile", "iFruit winkel overval gaande..", 619, 50, 1.0)
end)

RegisterServerEvent("qb-ifruitstore:server:PoliceAlertMessage2")
AddEventHandler("qb-ifruitstore:server:PoliceAlertMessage2", function()
    sendPoliceAlert("10-11B", "Knoeien met de elektriciteitskast", 0, {"police"}, "5000", "fas fa-bolt", "Iemand knoeit met de iFruit Store Power Box..", 769, 66, 0.7)
end)

RegisterServerEvent("qb-ifruitstore:server:PoliceAlertMessage3")
AddEventHandler("qb-ifruitstore:server:PoliceAlertMessage3", function()
    sendPoliceAlert("10-11C", "Stroomstoring", 0, {"police"}, "5000", "fas fa-bolt", "Bij de iFruit Store is onverwachts de stroom uitgevallen", 769, 66, 0.4)
end)

RegisterNetEvent('qb-ifruitstore:server:callCops')
AddEventHandler('qb-ifruitstore:server:callCops', function(streetLabel, coords)
    TriggerClientEvent("qb-ifruitstore:client:robberyCall", -1, streetLabel, coords)
end)


-- Register Cooldown Event
RegisterServerEvent("qb-ifruitstore:server:BeginCooldown")
AddEventHandler("qb-ifruitstore:server:BeginCooldown", function()
    local timer = Config.Cooldown
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
    end
    TriggerClientEvent("qb-ifruitstore:client:CooldownComplete", -1)
end)

-- Register Security Status
RegisterServerEvent("qb-ifruitstore:server:SetSecurityStatus")
AddEventHandler("qb-ifruitstore:server:SetSecurityStatus", function(stateType, state)
    if stateType == "isBusy" then
        Config.Locations["thermite"].isBusy = state
    elseif stateType == "isDone" then
        Config.Locations["thermite"].isDone = state
    end
    TriggerClientEvent("qb-ifruitstore:client:SetSecurityStatus", -1, stateType, state)
end)

-- Creating Usable Items
QBCore.Functions.CreateUseableItem("thermite", function(source)
    TriggerClientEvent("thermite:UseThermite", source)
end)


-- Callback For Cooldown
QBCore.Functions.CreateCallback("qb-ifruitstore:callback:Cooldown", function(source, cb)
    local timer = Config.Cooldown
    if timer > 0 then
        cb(true)
    else
        cb(false)
    end
end)
