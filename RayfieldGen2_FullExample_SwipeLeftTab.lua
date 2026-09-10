--[[
    Rayfield Gen 2 - Complete Component Showcase
    Documentation: https://docs.sirius.menu/rayfield-gen2

    This example demonstrates:
    - Window creation, sidebar layout, profile, configuration saving
    - Themes, localization, tags, navigation, visibility, and runtime methods
    - Tabs, sidebar sections, tab sections, groups, and nested groups
    - Button, Toggle, Slider, Dropdown, Input, Keybind, ColorPicker
    - Stat, Progress, Console, Text, Divider
    - Notifications, Toasts, Popups, and Changelog-style popups

    For release builds, load the stable URL below. The preview URL is noted later.
--]]

-- Optional secure mode. Enable this before loading Rayfield in a release build.
-- getgenv().RAYFIELD_SECURE = true

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/IsnowDev7/Rayfield-Gen-2-Modded/main/Rayfield-Gen2-Animations.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

---------------------------------------------------------------------
-- Window
---------------------------------------------------------------------

local Window = Rayfield:CreateWindow({
    name = "Rayfield Gen2 Showcase",
    subtitle = "Every documented component",
    icon = 93364949241311,
    sidebarLayout = true,
    BlurBackground = true,
    CapsuleAnimation = true,
    profile = "Complete API demonstration",
    showName = "Rayfield",
    showIcon = 93364949241311,
    showIconOnly = false,
    theme = "cobalt", -- default, cobalt, ember, amethyst, frost, or rose

    -- State persistence
    configuration = {
        autoSave = true,
        autoLoad = true,
        fileName = "RayfieldGen2Showcase",
        customFolder = "RayfieldExamples",
    },

    -- Localization
    locale = "en",
    translations = {
        es = {
            ["Home"] = "Inicio",
            ["Auto Sprint"] = "Sprint automático",
            ["Save configuration"] = "Guardar configuración",
        },
        fr = {
            ["Home"] = "Accueil",
            ["Auto Sprint"] = "Sprint automatique",
            ["Save configuration"] = "Enregistrer la configuration",
        },
    },
})

---------------------------------------------------------------------
-- Window-level sections and tags
---------------------------------------------------------------------

-- Window sections group the sidebar tabs. They are visible in sidebarLayout mode.
Window:CreateSection({ name = "Showcase" })

local Home = Window:CreateTab({
    SwipeLeftTab = true,
    name = "Home",
    icon = 93364949241311,
})

local Controls = Window:CreateTab({
    SwipeLeftTab = true,
    name = "Controls",
    icon = 6031075931,
})

local Display = Window:CreateTab({
    SwipeLeftTab = true,
    name = "Display",
    icon = 6031280882,
})

Window:CreateSection({ name = "Utilities" })

local Messages = Window:CreateTab({
    SwipeLeftTab = true,
    name = "Messages",
    icon = 6031094678,
})

local Settings = Window:CreateTab({
    SwipeLeftTab = true,
    name = "Settings",
    icon = 6031280882,
})

local VersionTag = Window:CreateTag({
    text = "Gen2",
    color = Color3.fromRGB(60, 150, 255),
    order = 1,
})

Window:CreateTag({
    text = "stable",
    color = Color3.fromRGB(70, 190, 115),
    order = 2,
})

---------------------------------------------------------------------
-- Home tab: sections, groups, buttons, toggles, sliders, stats
---------------------------------------------------------------------

Home:CreateSection({
    name = "Welcome",
    icon = 93364949241311,
})

Home:CreateText({
    name = "Rayfield Gen 2",
    text = "This tab demonstrates the window structure, sections, nested groups, and common controls.",
    icon = 93364949241311,
})

local HomeGrid = Home:CreateGroup()

local HomeLeft = HomeGrid:CreateGroup({ direction = "column" })
local HomeRight = HomeGrid:CreateGroup({ direction = "column" })

HomeLeft:CreateButton({
    name = "Say hello",
    description = "Shows a notification when pressed.",
    icon = 93364949241311,
    callback = function()
        Window:Notify({
            title = "Hello",
            content = "Your Rayfield Gen 2 button works.",
            duration = 4,
        })
    end,
})

HomeLeft:CreateButton({
    name = "Show toast",
    description = "Displays a lightweight confirmation toast.",
    callback = function()
        Window:Toast({
            title = "Toast displayed",
            subtitle = "The button callback ran successfully.",
            icon = 125823673784681,
            position = "Top",
            duration = 3,
        })
    end,
})

local AutoSprint = HomeLeft:CreateToggle({
    name = "Auto Sprint",
    description = "A saved boolean value.",
    icon = 93364949241311,
    flag = "AutoSprint",
    value = true,
    callback = function(value)
        print("Auto Sprint:", value)
    end,
})

local FOV = HomeRight:CreateSlider({
    name = "Field of view",
    description = "Callbacks receive the current value and dragging state.",
    range = { 70, 120 },
    increment = 1,
    value = 90,
    suffix = "°",
    flag = "FieldOfView",
    callback = function(value, dragging)
        if workspace.CurrentCamera then
            workspace.CurrentCamera.FieldOfView = value
        end
        print("FOV:", value, "Dragging:", dragging)
    end,
})

local Coins = HomeRight:CreateStat({
    name = "Coins",
    description = "Read-only animated statistic.",
    icon = 93364949241311,
    prefix = "$",
    value = 12400,
    suffix = "",
    changeMode = "absolute",
    changeBaseline = "previous",
    numberEasing = true,
})

local HomeProgress = Home:CreateProgress({
    name = "Example progress",
    description = "A continuous read-only progress bar.",
    range = { 0, 100 },
    value = 35,
    text = "Loading showcase",
})

Home:CreateDivider({ text = "or" })

Home:CreateText({
    name = "Element handles",
    text = "Value elements expose .value and Set(value). Set(value, true) moves the UI without firing the callback.",
})

-- Demonstrate handle methods after creation.
AutoSprint:Set(false, true)
FOV:Set(95, true)
Coins:Set(Coins.value + 500)
HomeProgress:Set(65)

---------------------------------------------------------------------
-- Controls tab: dropdown, input, keybind, color picker, lock/unlock
---------------------------------------------------------------------

Controls:CreateSection({ name = "Interactive controls" })

local Modules = Controls:CreateDropdown({
    name = "Modules",
    description = "Single-select dropdown. The callback receives a string.",
    options = { "Aimbot", "ESP", "Fly", "Noclip" },
    value = "ESP",
    placeholder = "Choose a module",
    flag = "SelectedModule",
    callback = function(selected)
        print("Selected module:", selected)
    end,
})

local MultiModules = Controls:CreateDropdown({
    name = "Enabled modules",
    description = "Multi-select dropdown. The callback receives a table.",
    options = { "Aimbot", "ESP", "Fly", "Noclip" },
    multiSelect = true,
    value = { "ESP" },
    placeholder = "None enabled",
    flag = "EnabledModules",
    callback = function(selected)
        print("Enabled modules:", table.concat(selected, ", "))
    end,
})

local PlayerName = Controls:CreateInput({
    name = "Player name",
    description = "Commits on Enter or when focus leaves the field.",
    value = LocalPlayer and LocalPlayer.Name or "Player",
    placeholder = "Enter a player name",
    clearOnFocus = false,
    flag = "TargetPlayer",
    callback = function(text)
        print("Target player committed:", text)
    end,
})

local MaxPlayers = Controls:CreateInput({
    name = "Max players",
    description = "Numeric input reverts malformed text.",
    numeric = true,
    value = "16",
    placeholder = "Enter a number",
    flag = "MaxPlayers",
    callback = function(text)
        print("Max players committed:", text)
    end,
})

local SprintKey = Controls:CreateKeybind({
    name = "Sprint key",
    description = "Press the box, then press a keyboard or mouse key.",
    value = Enum.KeyCode.LeftShift,
    flag = "SprintKey",
    callback = function(key)
        print("Sprint key pressed:", key)
    end,
    onChanged = function(key)
        print("Sprint binding changed:", key)
    end,
})

local HoldKey = Controls:CreateKeybind({
    name = "Hold action",
    description = "Hold mode fires true after the threshold and false on release.",
    value = Enum.KeyCode.LeftControl,
    hold = true,
    holdThreshold = 0.2,
    flag = "HoldActionKey",
    callback = function(isHeld)
        print("Hold action state:", isHeld)
    end,
})

local Highlight = Controls:CreateColorPicker({
    name = "Highlight",
    description = "Color and alpha are saved independently.",
    color = Color3.fromRGB(96, 205, 255),
    alpha = 1,
    flag = "HighlightColor",
    callback = function(color, alpha)
        print("Highlight:", color, "Alpha:", alpha)
    end,
})

-- Demonstrate dropdown list management and element locking.
Modules:Add("Silent Aim")
Modules:Remove("Fly")
MultiModules:Refresh({ "Aimbot", "ESP", "Fly", "Noclip", "Silent Aim" })

PlayerName:Lock("Unlock this field after selecting a target")
task.delay(2, function()
    if not Window.unloaded then
        PlayerName:Unlock()
    end
end)

---------------------------------------------------------------------
-- Display tab: console, text, dividers, segmented progress
---------------------------------------------------------------------

Display:CreateSection({ name = "Read-only display elements" })

Display:CreateText({
    name = "Display elements",
    text = "Stats, progress bars, consoles, text cards, and dividers do not create saved flags.",
})

local StageProgress = Display:CreateProgress({
    name = "Setup stages",
    description = "Segmented progress uses a stage count.",
    steps = 5,
    value = 2,
})

local IndeterminateProgress = Display:CreateProgress({
    name = "Synchronizing",
    description = "An indeterminate bar sweeps until Set is called.",
    indeterminate = true,
})

task.delay(2, function()
    if not Window.unloaded then
        StageProgress:Set(4)
        IndeterminateProgress:Set(1)
    end
end)

local Console = Display:CreateConsole({
    name = "Live console",
    description = "A bounded monospaced output panel.",
    height = 150,
    follow = true,
    maxLines = 100,
    text = "[boot] Rayfield Gen2 showcase started",
})

Console:Append("[info] Display tab loaded")
Console:Append("[info] All components are ready")

local StatusText = Display:CreateText({
    name = "Status",
    text = "Waiting for an update.",
})

Display:CreateDivider({
    text = "advanced",
    spacing = 18,
})

Display:CreateDivider({
    line = false,
    spacing = 20,
})

StatusText:Set("Connected. The display elements are responding.")

-- Display cards can contain real controls. The card grows downward
-- automatically as buttons, toggles, dropdowns, and other controls are added.
local PetDisplay = Display:CreateText({
    name = "Pet Spawner",
    text = "All controls below stay inside the same display card.",
    imageParagraph = 93364949241311,
})

PetDisplay:CreateToggle({
    name = "Auto collect",
    description = "Automatically collect the selected pet.",
    flag = "PetAutoCollect",
    callback = function(value)
        print("Auto collect:", value)
    end,
})

PetDisplay:CreateDropdown({
    name = "Select pet",
    options = { "Mecha Dreadscale", "Dragon", "Cat", "Bunny" },
    value = "Mecha Dreadscale",
    flag = "SelectedPet",
    callback = function(value)
        print("Selected pet:", value)
    end,
})

PetDisplay:CreateDropdown({
    name = "Mutation",
    options = { "None", "Gold", "Rainbow", "Shiny" },
    value = "None",
    flag = "PetMutation",
})

PetDisplay:CreateButton({
    name = "Spawn selected pet",
    description = "This button remains inside the auto-resizing display.",
    callback = function()
        Window:Toast({
            title = "Pet spawned",
            subtitle = "The display resized automatically.",
            duration = 3,
        })
    end,
})

---------------------------------------------------------------------
-- Messages tab: notifications, toast, popup, changelog popup
---------------------------------------------------------------------

Messages:CreateSection({ name = "Feedback and overlays" })

Messages:CreateButton({
    name = "Notify",
    description = "Bottom-right notification card.",
    callback = function()
        Window:Notify({
            title = "Auto-saved",
            content = "Your configuration was saved successfully.",
            icon = 93364949241311,
            duration = 5,
        })
    end,
})

Messages:CreateButton({
    name = "Toast",
    description = "Top or bottom confirmation pill.",
    callback = function()
        Window:Toast({
            title = "Profile updated",
            subtitle = "The new value is active.",
            avatar = LocalPlayer and LocalPlayer.UserId or 1,
            position = "Bottom",
            duration = 4,
            minWidth = 250,
        })
    end,
})

Messages:CreateButton({
    name = "Confirmation popup",
    description = "A modal choice dialog over a dimmed backdrop.",
    callback = function()
        Window:Popup({
            title = "Reset showcase values?",
            content = "This demonstrates a confirmation popup. It does not reset any game data.",
            options = {
                { text = "Cancel", style = "neutral" },
                {
                    text = "Reset",
                    style = "danger",
                    callback = function()
                        AutoSprint:Set(false)
                        FOV:Set(90)
                        Window:Toast({ title = "Values reset", duration = 3 })
                    end,
                },
            },
        })
    end,
})

Messages:CreateButton({
    name = "Changelog popup",
    description = "A popup made from changelog boxes.",
    callback = function()
        Window:Popup({
            title = "What's new",
            subtitle = "Rayfield Gen2 showcase",
            boxes = {
                {
                    title = "Complete component coverage",
                    description = "Buttons, controls, displays, notifications, themes, saving, and localization.",
                    icon = 93364949241311,
                },
                {
                    title = "Runtime control",
                    description = "Navigate, change themes, switch locales, and save configurations from code.",
                    icon = 6031075931,
                },
            },
            options = {
                { text = "Got it", style = "primary" },
            },
        })
    end,
})

---------------------------------------------------------------------
-- Settings tab: saving, themes, localization, visibility, navigation
---------------------------------------------------------------------

Settings:CreateSection({ name = "Runtime methods" })

Settings:CreateButton({
    name = "Save configuration",
    description = "Writes the current values immediately.",
    callback = function()
        local saved = Window:Save()
        Window:Notify({
            title = saved and "Saved" or "Save unavailable",
            content = saved and "The default configuration was saved." or "The configuration could not be saved.",
            duration = 4,
        })
    end,
})

Settings:CreateButton({
    name = "Save PvP loadout",
    description = "Demonstrates named configurations.",
    callback = function()
        Window:Save("PvP Loadout")
        print("Available configurations:", table.concat(Window:ListConfigs(), ", "))
    end,
})

Settings:CreateButton({
    name = "Switch to Ember theme",
    description = "Themes can be changed live without rebuilding the window.",
    callback = function()
        Window:ChangeTheme("ember")
        VersionTag:Set({ text = "ember", color = Color3.fromRGB(235, 120, 55) })
    end,
})

Settings:CreateButton({
    name = "Apply custom theme",
    description = "A partial theme table changes only the supplied keys.",
    callback = function()
        Window:ChangeTheme({
            TabColor = Color3.fromRGB(255, 255, 255),
            AccentColor = Color3.fromRGB(96, 205, 255),
            ShadowColor = Color3.fromRGB(0, 0, 0),
            SurfaceStroke = Color3.fromRGB(80, 100, 130),
        })
    end,
})

Settings:CreateButton({
    name = "Switch to French",
    description = "Applies the translation table live.",
    callback = function()
        Window:SetLocale("fr")
    end,
})

Settings:CreateButton({
    name = "Switch back to English",
    description = "Returns to the source language.",
    callback = function()
        Window:SetLocale("en")
    end,
})

Settings:CreateButton({
    name = "Navigate to Controls",
    description = "Selects a tab by its handle or name.",
    callback = function()
        Window:Navigate(Controls)
    end,
})

Settings:CreateButton({
    name = "Toggle visibility",
    description = "Hides or reveals the complete window.",
    callback = function()
        Window:ToggleHide()
    end,
})

Settings:CreateButton({
    name = "Minimise window",
    description = "Collapses the window to its top bar.",
    callback = function()
        Window:ToggleMinimise()
    end,
})

Settings:CreateButton({
    name = "Unload interface",
    description = "Destroys the interface and invalidates the window handle.",
    callback = function()
        Window:Unload()
    end,
})

---------------------------------------------------------------------
-- Runtime API examples that are intentionally not bound to buttons
---------------------------------------------------------------------

-- Read and write values by flag.
print("AutoSprint flag:", Window:Get("AutoSprint"))
Window:Set("AutoSprint", true)
print("FieldOfView flag:", Window.Flags.FieldOfView)

-- Update a tag after creation.
VersionTag:SetText("ready")
VersionTag:SetColor(Color3.fromRGB(70, 190, 115))

-- Other available methods include:
-- Window:Show()
-- Window:Hide()
-- Window:Load()
-- Window:DeleteConfig("PvP Loadout")
-- Window:GetPath()
-- Window:SetTranslator(function(source, localeId) return nil end)
-- Window:RegisterTranslations({ de = { ["Auto Sprint"] = "Auto-Sprint" } })
-- Window:SetProfile("Another profile line")

-- The first visible tab opens automatically; this call is optional.
Window:Navigate(Home)

-- Preview build alternative (use only when you intentionally want the dev build):
-- local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/IsnowDev7/Rayfield-Gen-2-Modded/main/Rayfield-Gen2-Animations.lua-preview"))()

-- Secure-mode release note:
-- 1. Set getgenv().RAYFIELD_SECURE = true before loading Rayfield.
-- 2. Secure mode blocks raw marketplace icons unless you provide local getcustomasset files.
-- 3. Develop with secure mode off so errors remain visible.
-- 4. Use fallbackFont = Enum.Font.Gotham in CreateWindow if desired.

return {
    Window = Window,
    Home = Home,
    Controls = Controls,
    Display = Display,
    Messages = Messages,
    Settings = Settings,
    AutoSprint = AutoSprint,
    FOV = FOV,
    Modules = Modules,
    Console = Console,
}
