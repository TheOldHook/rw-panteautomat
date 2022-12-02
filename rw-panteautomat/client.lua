local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()


local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end



RegisterNetEvent('rw:client:pantFlasker')
AddEventHandler('rw:client:pantFlasker', function()
    local player = PlayerPedId()
    local hasItem = QBCore.Functions.HasItem("tomflasker")
    if hasItem then
        loadAnimDict("mini@repair")
        TaskPlayAnim(player, "mini@repair", "fixing_a_ped", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
        garbagebag = CreateObject(GetHashKey("prop_cs_street_binbag_01"), 0, 0, 0, true, true, true)-- creates object
        AttachEntityToEntity(garbagebag, player, GetPedBoneIndex(player, 0x49D9), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)-- object is attached to right hand
        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 4.0, "panting", 0.20)
        QBCore.Functions.Progressbar("pant_flasker", "Pant flasker..", 25000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            DeleteEntity(garbagebag)
            StopAnimTask(player, "mini@repair", "fixing_a_player", 1.0)
            TriggerServerEvent("rw:server:pantFlasker")
            ClearPedTasks(player)
        end, function() -- Cancel
            ClearPedTasks(player)
            exports['okokNotify']:Alert('Feil', 'Du avbrøt pantingen', 2500, 'error')
            DeleteEntity(garbagebag)
            --QBCore.Functions.Notify("Annulleret..", "error")
        end)
    else
        exports['okokNotify']:Alert('Feil', 'Du har ikke flasker', 2500, 'error')
    end
end)
        





CreateThread(function()
    while true do
        local object = (`prop_vend_water_01`)
        exports['qb-target']:AddTargetModel(object, {
            options = { {
                 icon = "fa-solid fa-hammer",
                 label = "Panteautomat",
                 action = function()
                    TriggerEvent('rw:client:pantFlasker')
                 end
            }
            },
            distance = 1.5
       })
         Wait(1000)
    end
end)

