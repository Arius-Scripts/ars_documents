local function openNui(data)
    SendNUIMessage({
        action = data.mode,
        metadata = data
    })
    SetNuiFocus(true, true)
end

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("giveItem", function(data)
    lib.callback('ars_documents:getName', false, function(name)
        local metadata = {}
        metadata.mode = "view"
        metadata.title = data.title

        metadata.name = data.name
        metadata.surname = data.surname
        metadata.date = data.date

        metadata.object = data.object

        metadata.guidelines = data.guidelines
        metadata.sign = name
        metadata.src = data.image

        print(json.encode(metadata, { indent = true }))

        TriggerServerEvent("ars_docuements:createDocument", metadata)
        SetNuiFocus(false, false)
    end)
end)


exports('openDocument', function(data)
    openNui(data)
end)


local points = {}
local printers = {}

for i = 1, #Config.Printers, 1 do
    local cfg = Config.Printers[i]

    points[i] = lib.points.new({
        coords = cfg.coords.xyz,
        distance = 20,
        onEnter = function()
            local propHash = joaat(cfg.prop)
            local model = lib.requestModel(propHash)

            if not model then return end

            local printer = CreateObject(model, cfg.coords)

            SetModelAsNoLongerNeeded(model)
            FreezeEntityPosition(printer, true)
            SetEntityAsMissionEntity(printer, 1, 1)

            table.insert(printers, printer)

            local options = {}

            for j = 1, #cfg.items, 1 do
                table.insert(options,
                    {
                        name = "printer" .. j .. i .. cfg.job,
                        label = cfg.items[j].label,
                        icon = 'fa-solid fa-print',
                        groups = cfg.job,
                        onSelect = function(entity)
                            local data = {}
                            data.mode = "create"
                            data.title = cfg.items[j].title
                            openNui(data)
                        end
                    }
                )
            end

            exports.ox_target:addLocalEntity(printer, options)
        end,

        onExit = function()
            for k, v in pairs(printers) do
                DeleteObject(v)
            end
        end,
        nearby = function(self)

        end

    })
end


AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for k, v in pairs(printers) do
        DeleteObject(v)
    end
end)


-- RegisterCommand("create", function()
--     local data = {}

--     data.mode = "create"
--     data.title = "104 PER STO DOWN"

--     data.name = "Ali"
--     data.surname = "Echabi"
--     data.date = "2000-12-12"

--     data.object = "fkjhsfhdjksh fjkh fjkshd jfkjh afjkh afk hakhf ka kah ffafkhaf fkhfakh sa hsaf kh akh hfsak"
--     data.sign = "Arius Development"


--     openNui(data)
-- end)
