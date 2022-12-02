
local QBCore = exports['qb-core']:GetCoreObject()
local Flaskeliste = {
   
    ["tomflasker"]       =  50 , 
}


RegisterNetEvent('rw:server:pantFlasker', function()
    local src = source
    local price = 0
    local Player = QBCore.Functions.GetPlayer(src)
    
    local xItem = Player.Functions.GetItemsByName(Flaskeliste)
    if xItem ~= nil then
        for k, v in pairs(Player.PlayerData.items) do
            if Player.PlayerData.items[k] ~= nil then
                if Flaskeliste[Player.PlayerData.items[k].name] ~= nil then
                    price = (Flaskeliste[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)

        Player.Functions.AddMoney("cash", price, "sold-resources")
            TriggerClientEvent('QBCore:Notify', src, "Du panta for kr"..price)
            TriggerEvent("qb-log:server:CreateLog", "pantflasker", "resources", "blue", "**"..GetPlayerName(src) .. "** fikk nok"..price.." for flaskepanting")
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Du har ingen tomflasker..")
    end

end) 