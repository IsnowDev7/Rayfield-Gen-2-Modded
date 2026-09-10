--[[
    Anime Dice Premium - Rayfield Gen 2 Modded scaffold

    Trading logic is intentionally placeholder-only for now.
    Replace the marked callbacks when the game-side functions are provided.
]]

local Rayfield = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/IsnowDev7/Rayfield-Gen-2-Modded/main/Rayfield-Gen2-Animations.lua?v=a187f4b"
))()

local Window = Rayfield:CreateWindow({
    name = "Anime Dice Premium",
    subtitle = "Premium automation hub",
    icon = 6031075931,
    sidebarLayout = true,
    BlurBackground = true,
    CapsuleAnimation = true,
    theme = "cobalt",

    configuration = {
        autoSave = true,
        autoLoad = true,
        customFolder = "AnimeDicePremium",
        fileName = "settings",
    },
})

Window:CreateSection({ name = "Anime Dice Premium" })

local Info = Window:CreateTab({
    name = "Info",
    icon = 6031075931,
})

local Plot = Window:CreateTab({
    name = "Plot",
    icon = 6031075931,
})

local Progression = Window:CreateTab({
    name = "Progression",
    icon = 6031075931,
})

local Tower = Window:CreateTab({
    name = "Tower",
    icon = 6031075931,
})

local Trading = Window:CreateTab({
    -- Horizontal tab-content scrolling is enabled only for Trading.
    SwipeLeftTab = true,
    name = "Trading",
    icon = 6031075931,
})

---------------------------------------------------------------------
-- Placeholder tabs
---------------------------------------------------------------------

Info:CreateSection({ name = "Information" })
Info:CreateText({
    name = "Anime Dice Premium",
    text = "Information systems will be connected here. This tab is ready for documentation, status, and feature notes.",
})

Plot:CreateSection({ name = "Plot" })
Plot:CreateText({
    name = "Story progression",
    text = "Plot missions and story progression will be added here.",
})

Progression:CreateSection({ name = "Progression" })
Progression:CreateText({
    name = "Player progression",
    text = "Leveling, quests, rewards, upgrades, and progression systems will be added here.",
})

Tower:CreateSection({ name = "Tower" })
Tower:CreateText({
    name = "Tower management",
    text = "Tower selection, loadouts, waves, and farming controls will be added here.",
})

---------------------------------------------------------------------
-- Trading tab
-- All trading controls are intentionally inside display cards so each
-- card grows downward automatically as more controls are added.
---------------------------------------------------------------------

Trading:CreateSection({
    name = "Trading Center",
    icon = 6031075931,
})

local function placeholderNotice(title, message)
    Window:Notify({
        title = title,
        content = message,
        duration = 3,
    })
end

---------------------------------------------------------------------
-- Unit Trade display
---------------------------------------------------------------------

local UnitTrade = Trading:CreateText({
    name = "Unit Trade",
    text = "Select a player, select a unit, choose an amount, then place units into the trade.",
    imageParagraph = 6031075931,
})

local SelectedPlayer = "No players scanned"
local SelectedUnit = "No units scanned"
local DesiredAmount = "1"
local AutoTrade = false

UnitTrade:CreateDropdown({
    name = "Player",
    description = "Placeholder list. The server-player scan logic will be connected later.",
    options = { "No players scanned" },
    value = SelectedPlayer,
    placeholder = "Select player",
    flag = "TradingPlayer",
    callback = function(value)
        SelectedPlayer = type(value) == "table" and value[1] or value
    end,
})

UnitTrade:CreateDropdown({
    name = "Unit",
    description = "Placeholder list. The inventory-unit scan logic will be connected later.",
    options = { "No units scanned" },
    value = SelectedUnit,
    placeholder = "Select unit",
    flag = "TradingUnit",
    callback = function(value)
        SelectedUnit = type(value) == "table" and value[1] or value
    end,
})

UnitTrade:CreateInput({
    name = "Desired Amount",
    description = "Amount of the selected unit to place.",
    numeric = true,
    value = DesiredAmount,
    placeholder = "Enter amount",
    flag = "TradingAmount",
    callback = function(value)
        DesiredAmount = value
    end,
})

-- Button 1 of 6: Scan Players
UnitTrade:CreateButton({
    name = "Scan Players",
    description = "Placeholder: connect your server-player finder here.",
    callback = function()
        placeholderNotice(
            "Trading",
            "Scan Players is ready for the player-finding logic."
        )
    end,
})

-- Button 2 of 6: Scan Items
UnitTrade:CreateButton({
    name = "Scan Items",
    description = "Placeholder: connect your unit inventory scanner here.",
    callback = function()
        placeholderNotice(
            "Trading",
            "Scan Items is ready for the unit-list logic."
        )
    end,
})

-- Button 3 of 6: Place Amount
UnitTrade:CreateButton({
    name = "Place Amount",
    description = "Place the requested amount of the selected unit.",
    callback = function()
        placeholderNotice(
            "Trading",
            ("Place Amount placeholder: %s x %s for %s."):format(
                tostring(DesiredAmount),
                tostring(SelectedUnit),
                tostring(SelectedPlayer)
            )
        )
    end,
})

-- Button 4 of 6: Place All Selected
UnitTrade:CreateButton({
    name = "Place All (Selected)",
    description = "Place all copies of the selected unit.",
    callback = function()
        placeholderNotice(
            "Trading",
            ("Place All Selected placeholder: %s for %s."):format(
                tostring(SelectedUnit),
                tostring(SelectedPlayer)
            )
        )
    end,
})

-- Button 5 of 6: Place All Inventory
UnitTrade:CreateButton({
    name = "Place ALL Inventory",
    description = "Place every tradeable unit from the inventory.",
    callback = function()
        placeholderNotice(
            "Trading",
            ("Place ALL Inventory placeholder for %s."):format(
                tostring(SelectedPlayer)
            )
        )
    end,
})

-- Button 6 of 6: Send Trade Request
UnitTrade:CreateButton({
    name = "Send Trade Request",
    description = "Send the completed trade request to the selected player.",
    callback = function()
        placeholderNotice(
            "Trading",
            ("Trade request placeholder: %s -> %s."):format(
                tostring(SelectedPlayer),
                tostring(SelectedUnit)
            )
        )
    end,
})

UnitTrade:CreateToggle({
    name = "Auto Trade",
    description = "Placeholder toggle for automatically handling the trade flow.",
    flag = "AutoTrade",
    value = false,
    callback = function(value)
        AutoTrade = value
        placeholderNotice(
            "Auto Trade",
            value and "Auto Trade enabled." or "Auto Trade disabled."
        )
    end,
})

---------------------------------------------------------------------
-- Gems Trade display
---------------------------------------------------------------------

local GemsTrade = Trading:CreateText({
    name = "Gems Trade",
    text = "Gem trading controls will be connected after the unit-trade flow is complete.",
    imageParagraph = 6031075931,
})

GemsTrade:CreateInput({
    name = "Gems Amount",
    description = "Placeholder amount of gems to trade.",
    numeric = true,
    value = "0",
    placeholder = "Enter gems amount",
    flag = "TradingGemsAmount",
    callback = function(value)
        print("Gems amount placeholder:", value)
    end,
})

GemsTrade:CreateButton({
    name = "Prepare Gems Trade",
    description = "Placeholder for preparing a gem trade.",
    callback = function()
        placeholderNotice("Gems Trade", "Prepare Gems Trade is not connected yet.")
    end,
})

---------------------------------------------------------------------
-- Trait and Reroll display
---------------------------------------------------------------------

local TraitTrade = Trading:CreateText({
    name = "Trait & Reroll",
    text = "Trait selection and reroll controls will be connected here.",
    imageParagraph = 6031075931,
})

TraitTrade:CreateDropdown({
    name = "Trait",
    description = "Placeholder trait list.",
    options = { "No traits scanned" },
    value = "No traits scanned",
    placeholder = "Select trait",
    flag = "TradingTrait",
    callback = function(value)
        print("Trait placeholder:", value)
    end,
})

TraitTrade:CreateButton({
    name = "Reroll Trait",
    description = "Placeholder reroll action.",
    callback = function()
        placeholderNotice("Trait & Reroll", "Reroll Trait is not connected yet.")
    end,
})

TraitTrade:CreateButton({
    name = "Prepare Trait Trade",
    description = "Placeholder trait-trade action.",
    callback = function()
        placeholderNotice("Trait & Reroll", "Prepare Trait Trade is not connected yet.")
    end,
})

Window:Notify({
    title = "Anime Dice Premium",
    content = "Trading layout loaded. Game logic is currently placeholder-only.",
    duration = 4,
})

Window:Show()
