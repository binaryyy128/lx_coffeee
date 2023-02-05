locale = Config.Locales[Config.Locale]

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu(locale['menu_title'], locale['menu_subtitle'], 10, 150)
_menuPool:Add(mainMenu)

local subMenus = {}
local ingredientMenus = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer, isNew, skin)
    ESX.PlayerData = ESX.GetPlayerData()
end)

ESX.PlayerData = ESX.GetPlayerData()

local p1 = GetPlayerPed(-1)

for k in pairs(Config.Coffees) do

    local newSubmenu = _menuPool:AddSubMenu(mainMenu, Config.Coffees[k].name, Config.Coffees[k].hint, 10, 150)
    subMenus[k] = newSubmenu
    mainMenu:AddItem(newSubmenu)

    local ingredientsMenu = _menuPool:AddSubMenu(newSubmenu, locale['translation_ingredients'], locale['msg_addIngredrients'], 10, 150)
    ingredientMenus[k] = ingredientsMenu

    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)

    local ingredientItems = {}
    local addedIngredients = {}
    local readyToBrew = false

    for j, f in pairs(Config.Coffees[k].ingredients) do

        
        ingredientItems[j] = NativeUI.CreateItem(Config.Coffees[k].ingredients[j].label .. ': ~g~'..Config.Coffees[k].ingredients[j].c, "Füge "..Config.Coffees[k].ingredients[j].label.. " hinzu.")
        
        ingredientsMenu:AddItem(ingredientItems[j])
        
        --print("debug3: " .. j)
        

    end

    --Placeholder Items
    local placeholderItem = NativeUI.CreateItem("", "Made by Lxnnard#3313 with ~r~<3")
    local placeholderItem2 = NativeUI.CreateItem("", "Made by Lxnnard#3313 with ~r~<3")
    local placeholderItem3 = NativeUI.CreateItem("", "Made by Lxnnard#3313 with ~r~<3")
    newSubmenu:AddItem(placeholderItem)
    newSubmenu:AddItem(placeholderItem2)
    newSubmenu:AddItem(placeholderItem3)

    --Run Button
    local runButton = NativeUI.CreateItem(locale['runButton']:format('~g~' .. Config.Coffees[k].name .. '~s~'), locale['runButton_hint'])
    newSubmenu:AddItem(runButton)


    runButton:SetRightBadge(BadgeStyle.Lock)

    ingredientsMenu.OnItemSelect = function(sender, __item, index)

        for l, o in pairs(ingredientItems) do
            if (ingredientItems[l] == __item and not addedIngredients[l]) then
                local inventory = ESX.GetPlayerData().inventory
                local count = 0
                for _i=1, #inventory do
                    if inventory[_i].name == Config.Coffees[k].ingredients[l].item then
                        count = inventory[_i].count
                    end
                end

                if (count >= Config.Coffees[k].ingredients[l].c) then
                    --print(Config.Coffees[k].ingredients[l].label)
                    ExecuteCommand('e uncuff')

                    ESX.Progressbar(Config.Coffees[k].ingredients[l].label .. ' ' .. locale['translation_adding'], 5000 * Config.Coffees[k].ingredients[l].c,{
                        FreezePlayer = true,
                        animation ={
                            type = false,
                            dict = false, 
                            lib = false 
                        }, 
                        onFinish = function()
                            ExecuteCommand('e c')
                            TriggerServerEvent('lx_coffee:removeItem' .. Config.EventKey, Config.Coffees[k].ingredients[l].item, Config.Coffees[k].ingredients[l].c)
                            addedIngredients[l] = true
                            ingredientItems[l]:SetRightBadge(BadgeStyle.Tick)
                            exports['okokNotify']:Alert(locale['menu_title'], locale['msg_addedIngredient']:format(Config.Coffees[k].ingredients[l].label), 1500, 'success')
                            if (pairs(addedIngredients) == pairs(Config.Coffees[k].ingredients)) then
                                readyToBrew = true
                                runButton:SetRightBadge(BadgeStyle.Star)
                            end
                    end})
                else
                    exports['okokNotify']:Alert(locale['menu_title'], locale['msg_not_enough_ingredient']:format(Config.Coffees[k].ingredients[l].label), 1500, 'error')
                end
                
            elseif (addedIngredients[l] and ingredientItems[l] == __item) then
                exports['okokNotify']:Alert(locale['menu_title'], locale['msg_ingredient_already_added']:format(Config.Coffees[k].ingredients[l].label), 1500, 'warning')
            end
        end
    end

    newSubmenu.OnItemSelect = function(sender, _aitem, index)
        if (_aitem == runButton) then
            if (readyToBrew) then
                exports['okokNotify']:Alert(locale['menu_title'], locale['msg_brewing']:format(Config.Coffees[k].name), 1500, 'success')
                readyToBrew = false
                runButton:SetRightBadge(BadgeStyle.Lock)
                addedIngredients = {}

                for _l, _o in pairs(ingredientItems) do
                    ingredientItems[_l]:SetRightBadge(BadgeStyle.None)
                end

                ESX.Progressbar(locale['runButton']:format(Config.Coffees[k].name), Config.Coffees[k].dispenseTime,{
                    FreezePlayer = true, 
                    animation ={
                        type = false,
                        dict = false, 
                        lib = false
                    }, 
                    onFinish = function()
                        TriggerServerEvent('lx_coffee:addItem' .. Config.EventKey, Config.Coffees[k].itemName)
                end})
            else
                exports['okokNotify']:Alert(locale['menu_title'], locale['msg_ingredients_missing'], 1500, 'error')
            end
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k, v in pairs(Config.Locations) do
            for j in pairs(subMenus) do
                for m in pairs(ingredientMenus) do
                    if GetDistanceBetweenCoords(Config.Locations[k].coords, GetEntityCoords(p1), true) < 1.5 and not mainMenu:Visible() and not subMenus[j]:Visible() and not ingredientMenus[m]:Visible() then
                        ESX.ShowHelpNotification("Drücke ~g~E~s~ um die Kaffeemaschiene zu benutzen")
                        if IsControlJustPressed(1, 51) then 
                            mainMenu:Visible(true)
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
    end
end)

_menuPool:RefreshIndex()