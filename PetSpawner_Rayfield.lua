-- Pet Spawner using Rayfield Gen 2 Modded
-- Uses the modified Rayfield source with an auto-resizing display card.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local Rayfield = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/IsnowDev7/Rayfield-Gen-2-Modded/main/Rayfield-Gen2-Animations.lua"
))()

local Window

local function notify(title, content, duration)
    pcall(function()
        Window:Notify({
            Title = title,
            Content = content,
            Duration = duration or 3,
        })
    end)
end

local RS = ReplicatedStorage
local Assets
local Save
local AssetItems
local ItemDisplay
local AssetRoster
local SyncAssets

local function grab(path)
    local ok, module = pcall(require, path)
    return ok and module or nil
end

local dataFolder = RS:FindFirstChild("Data")
local sharedFolder = RS:FindFirstChild("Shared")
local clientFolder = RS:FindFirstChild("Client")

if dataFolder then
    Assets = grab(dataFolder:FindFirstChild("Assets"))
end

if sharedFolder then
    Save = grab(sharedFolder:FindFirstChild("Save"))

    local util = sharedFolder:FindFirstChild("Util")
    local modules = sharedFolder:FindFirstChild("Modules")

    if util then
        AssetItems = grab(util:FindFirstChild("AssetItems"))
    end

    if modules then
        ItemDisplay = grab(modules:FindFirstChild("ItemDisplay"))
    end
end

if clientFolder then
    AssetRoster = grab(clientFolder:FindFirstChild("AssetRoster"))
end

if not (Assets and Save and AssetItems and ItemDisplay) then
    warn("[PetSpawner] Could not load the required game modules.")
    return
end

local FAKE_PETS = _G.__ExeFakePets or {}
_G.__ExeFakePets = FAKE_PETS

if AssetRoster and _G.__ExePetHookVersion ~= 6 then
    _G.__ExePetHookVersion = 6

    _G.__ExePetOriginals = _G.__ExePetOriginals or {
        WearAsset = AssetRoster.WearAsset,
        DoffAsset = AssetRoster.DoffAsset,
    }

    local originals = _G.__ExePetOriginals

    AssetRoster.WearAsset = function(uid, ...)
        if FAKE_PETS[uid] then
            return true, nil, nil
        end

        return originals.WearAsset(uid, ...)
    end

    AssetRoster.DoffAsset = function(uid, ...)
        if uid == nil or FAKE_PETS[uid] then
            return true, nil
        end

        return originals.DoffAsset(uid, ...)
    end
end

if getgc then
    for _, value in ipairs(getgc(false)) do
        if type(value) == "function"
            and not (iscclosure and iscclosure(value)) then

            local ok, info = pcall(debug.getinfo, value)

            if ok and info and info.name == "syncAssetsFromSave" then
                SyncAssets = value
                break
            end
        end
    end
end

local function refreshInventory()
    if SyncAssets then
        pcall(SyncAssets)
    end
end

local PET_MODELS = RS:FindFirstChild("AssetModels")
local CATALOG = {}

for id, config in pairs(Assets.Directory or {}) do
    if not PET_MODELS or PET_MODELS:FindFirstChild(id) then
        table.insert(CATALOG, {
            id = id,
            display = config.DisplayName or id,
            rate = tonumber(config.EarningRate) or 0,
            rarity = type(config.Rarity) == "table"
                and config.Rarity.Name
                or "?",
            icon = config.Icon or "",
            baseScale = tonumber(config.BaseModelScale) or 1,
        })
    end
end

table.sort(CATALOG, function(a, b)
    if a.rate == b.rate then
        return a.display < b.display
    end

    return a.rate > b.rate
end)

local MUTATIONS = {
    "None",
    "Golden",
    "Rainbow",
    "Silver",
    "Sakura",
    "GreatBloom",
}

local SIZES = {
    "1x",
    "2x",
    "5x",
    "10x",
    "25x",
}

local currentMutation = "None"
local currentSize = 1
local spawnCounter = 0
local autoEquip = true
local spawnedTools = {}
local injectedUids = {}

local function getSizeMultiplier(value)
    return tonumber(tostring(value):match("(%d+)")) or 1
end

local function equipTool(tool)
    local character = LocalPlayer.Character
    local humanoid = character
        and character:FindFirstChildOfClass("Humanoid")

    if not (humanoid and tool and tool.Parent) then
        return false
    end

    return pcall(function()
        humanoid:EquipTool(tool)
    end)
end

local function doSpawn(entry)
    spawnCounter += 1

    local uid = ("exepet_%s_%d_%d"):format(
        entry.id:lower():gsub("[^%a%d]", "_"),
        spawnCounter,
        math.random(1000, 9999)
    )

    local mutations = {}
    local baseMutation

    if currentMutation ~= "None" then
        mutations = { currentMutation }
        baseMutation = currentMutation
    end

    local itemData = {
        HasBeenFirstPlaced = false,
        Category = entry.id,
        Scale = entry.baseScale * currentSize,
        EyeColor = "ffffff",
        ColorSeed = math.random(0, 2147483647),
        ColorIndex = 1,
        Mutations = mutations,
        BaseMutation = baseMutation,
    }

    local encodedOk, encoded = pcall(
        AssetItems.Encode,
        itemData
    )

    if not encodedOk then
        notify("Spawner", "Could not encode " .. entry.display)
        return
    end

    local applied = pcall(
        Save.ApplyLocalFieldEntry,
        "Inventory",
        uid,
        encoded
    )

    if not applied then
        notify(
            "Spawner",
            "Could not add " .. entry.display .. " to inventory."
        )
        return
    end

    injectedUids[uid] = true
    FAKE_PETS[uid] = true

    local toolOk, tool = pcall(
        ItemDisplay.CreateTool,
        itemData,
        uid,
        LocalPlayer
    )

    refreshInventory()

    if not (toolOk and typeof(tool) == "Instance") then
        notify("Spawner", "Spawn failed for " .. entry.display)
        return
    end

    table.insert(spawnedTools, tool)

    local mutationPrefix = baseMutation
        and (baseMutation .. " ")
        or ""

    if autoEquip then
        task.wait(0.15)

        if equipTool(tool) then
            notify(
                "Spawner",
                "Spawned " .. mutationPrefix .. entry.display
            )
            return
        end
    end

    notify(
        "Spawner",
        "Added " .. mutationPrefix .. entry.display .. " to inventory."
    )
end

Window = Rayfield:CreateWindow({
    Name = "Pet Spawner",
    Subtitle = "Rayfield Gen 2 Modded",
    Icon = "rbxassetid://6031075931",
    Theme = "Cobalt",
    sidebarLayout = true,
    SideBarWidth = 180,
    BlurBackground = true,
    CapsuleAnimation = true,

    configuration = {
        autoSave = true,
        autoLoad = true,
        customFolder = "PetSpawnerRayfield",
        fileName = "settings",
    },
})

local Main = Window:CreateTab({
    Name = "Spawner",
    Icon = "rbxassetid://6031075931",
})

Main:CreateSection({
    Name = "Pet Spawner",
})

local petValues = {}
local petByValue = {}

for _, entry in ipairs(CATALOG) do
    local value = entry.display

    if petByValue[value] then
        value = entry.display .. " [" .. entry.id .. "]"
    end

    petValues[#petValues + 1] = value
    petByValue[value] = entry
end

local selectedValue = petValues[1]
local selectedEntry = petByValue[selectedValue]
local PetDisplay

local function updatePetDisplay(entry)
    selectedEntry = entry

    if not PetDisplay then
        return
    end

    if PetDisplay.imageLabel then
        PetDisplay.imageLabel.Image = entry and entry.icon or ""
    end

    PetDisplay:SetTitle(entry and entry.display or "No pet selected")
    PetDisplay:Set(
        entry
            and ("Cash: $%s/s  |  Rarity: %s"):format(
                tostring(entry.rate or 0),
                tostring(entry.rarity or "?")
            )
            or "Select a pet to preview its image and information."
    )
end

-- Every related control is kept inside this display card.
-- The card automatically grows downward as controls are added.
PetDisplay = Main:CreateText({
    name = "Selected Pet",
    text = selectedEntry
        and ("Cash: $%s/s  |  Rarity: %s"):format(
            tostring(selectedEntry.rate or 0),
            tostring(selectedEntry.rarity or "?")
        )
        or "No pet selected.",
    imageParagraph = selectedEntry and selectedEntry.icon or "",
})

PetDisplay:CreateDropdown({
    name = "Select Pet",
    options = petValues,
    value = selectedValue,
    multiSelect = false,

    callback = function(value)
        selectedValue = type(value) == "table"
            and value[1]
            or value

        updatePetDisplay(petByValue[selectedValue])
    end,
})

PetDisplay:CreateDropdown({
    name = "Mutation",
    options = MUTATIONS,
    value = "None",
    multiSelect = false,

    callback = function(value)
        currentMutation = type(value) == "table"
            and value[1]
            or value
    end,
})

PetDisplay:CreateDropdown({
    name = "Size",
    options = SIZES,
    value = "1x",
    multiSelect = false,

    callback = function(value)
        currentSize = getSizeMultiplier(
            type(value) == "table"
                and value[1]
                or value
        )
    end,
})

PetDisplay:CreateToggle({
    name = "Auto Equip",
    value = true,

    callback = function(value)
        autoEquip = value
    end,
})

PetDisplay:CreateButton({
    name = "Spawn Selected",

    callback = function()
        if not selectedEntry then
            notify("Spawner", "Select a pet first.")
            return
        end

        task.spawn(doSpawn, selectedEntry)
    end,
})

PetDisplay:CreateButton({
    name = "Spawn All",

    callback = function()
        task.spawn(function()
            for _, entry in ipairs(CATALOG) do
                doSpawn(entry)
                task.wait(0.05)
            end
        end)
    end,
})

updatePetDisplay(selectedEntry)

Window:Notify({
    Title = "Pet Spawner",
    Content = ("%d pets loaded."):format(#CATALOG),
    Duration = 3,
})

Window:Show()
