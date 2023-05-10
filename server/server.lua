local ESX = exports["es_extended"]:getSharedObject()

lib.callback.register('ars_documents:getName', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
    return name
end)

RegisterNetEvent("ars_docuements:createDocument", function(data)
    local data = data
    local source = source

    local ox_inventory = exports.ox_inventory

    ox_inventory:AddItem(source, Config.Item, 1, data)
end)


lib.versionCheck('Arius-Development/ars_documents')
