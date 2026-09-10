-- Rayfield Gen 2 Modded - Full Updated Example
-- Uses the restored capsule UI, glow animation, and normal minimize behavior.

local Rayfield = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/IsnowDev7/Rayfield-Gen-2-Modded/main/Rayfield-Gen2-Animations.lua"
))()

local Window = Rayfield:CreateWindow({
    Name = "Rayfield Gen 2 Showcase",
    Subtitle = "Capsule UI and animation test",
    Icon = "rbxassetid://7733960981",
    Theme = "Default",
    sidebarLayout = true,
    SideBarWidth = "120",
    BlurBackground = true,
    CapsuleAnimation = true,
    TabIconAnimation = true,

    configuration = {
        autoSave = true,
        autoLoad = true,
        customFolder = "RayfieldGen2Example",
        fileName = "settings",
    },
})

-- Normal vertical-scrolling tab
local Home = Window:CreateTab({
    Name = "Home",
    Icon = "rbxassetid://7734053495",
})

Home:CreateSection({
    Name = "Welcome",
})

Home:CreateText({
    Name = "Working capsule UI",
    Text = "This example uses the restored capsule interface with its glow and press animation. Hide the window to test the capsule, then press it to restore the window.",
})

Home:CreateButton({
    Name = "Show notification",
    Icon = "rbxassetid://7733715400",

    Callback = function()
        Window:Notify({
            Title = "Rayfield is working",
            Content = "The restored capsule and minimize behavior are active.",
            Duration = 4,
        })
    end,
})

Home:CreateToggle({
    Name = "Example toggle",
    CurrentValue = true,
    Flag = "ExampleToggle",

    Callback = function(value)
        print("Example toggle:", value)
    end,
})

Home:CreateSlider({
    Name = "Example slider",
    Range = {0, 100},
    Increment = 5,
    Suffix = "%",
    CurrentValue = 50,
    Flag = "ExampleSlider",

    Callback = function(value)
        print("Example slider:", value)
    end,
})

-- Normal vertical-scrolling tab
local Controls = Window:CreateTab({
    Name = "Controls",
    Icon = "rbxassetid://7734053495",
})

Controls:CreateSection({
    Name = "Window Controls",
})

Controls:CreateButton({
    Name = "Minimize window",

    Callback = function()
        Window:ToggleMinimise()
    end,
})

Controls:CreateButton({
    Name = "Hide window",

    Callback = function()
        Window:Hide()
    end,
})

Controls:CreateButton({
    Name = "Show window",

    Callback = function()
        Window:Show()
    end,
})

Controls:CreateInput({
    Name = "Test input",
    PlaceholderText = "Type something",
    RemoveTextAfterFocusLost = false,

    Callback = function(text)
        print("Input:", text)
    end,
})

Controls:CreateDropdown({
    Name = "Example dropdown",
    Options = {
        "Default",
        "Damacus",
        "Blahite",
        "Yelue",
    },
    CurrentOption = {"Default"},
    MultipleOptions = false,

    Callback = function(selection)
        local themeName = type(selection) == "table"
            and selection[1]
            or selection

        if type(themeName) == "string" then
            Window:ChangeTheme(themeName)
        end
    end,
})

-- Normal vertical-scrolling tab
local Actions = Window:CreateTab({
    Name = "Actions",
    Icon = "rbxassetid://7734053495",
})

Actions:CreateSection({
    Name = "Action Examples",
})

Actions:CreateColorPicker({
    Name = "Accent color",
    Color = Color3.fromRGB(151, 105, 255),
    Flag = "AccentColor",

    Callback = function(color)
        print("Selected color:", color)
    end,
})

Actions:CreateKeybind({
    Name = "Toggle window",
    CurrentKeybind = "RightControl",
    HoldToInteract = false,
    Flag = "ToggleWindowKeybind",

    Callback = function()
        Window:ToggleHide()
    end,
})

-- Normal vertical-scrolling display tab
local Displays = Window:CreateTab({
    Name = "Displays",
    Icon = "rbxassetid://7734053495",
    SwipeLeftTab = true,
})

Displays:CreateSection({
    Name = "Display Components",
})

-- The display accepts an image and up to two official Rayfield components.
-- The components are stacked vertically inside the centered display card.

Displays:AddCreateDisplay({
    Name = "Display Example",
    Image = "rbxassetid://7733960981",
    Description = "Official Rayfield controls are stacked vertically underneath the image.",

    Components = {
        {
            Type = "Toggle",
            Name = "Display toggle",
            Value = false,

            Callback = function(value)
                print("Display toggle:", value)
            end,
        },

        {
            Type = "Dropdown",
            Name = "Display dropdown",
            Options = {
                "First",
                "Second",
                "Third",
            },

            Callback = function(value)
                print("Display dropdown:", value)
            end,
        },
    },
})

-- This is the only tab using SwipeLeftTab.
-- The Displays tab above remains vertical.
local SwipeTest = Window:CreateTab({
    Name = "Swipe Test",
    Icon = "rbxassetid://7734053495",
    SwipeLeftTab = true,
})

SwipeTest:CreateSection({
    Name = "Horizontal Swipe Test",
})

SwipeTest:CreateText({
    Name = "Swipe left",
    Text = "This tab alone uses SwipeLeftTab. The Displays tab stays vertical.",
})

SwipeTest:CreateButton({
    Name = "Swipe test button",

    Callback = function()
        Window:Notify({
            Title = "Swipe test",
            Content = "Swipe horizontally across this tab.",
            Duration = 3,
        })
    end,
})

-- Pet preview display transferred from Spawner_ModdedUI_PetInfo.
-- This section updates one Rayfield display frame whenever the selected pet changes.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PetAssets = ReplicatedStorage:FindFirstChild("Data") and require(ReplicatedStorage.Data.Assets)
local PetModels = ReplicatedStorage:FindFirstChild("AssetModels")
local PetCatalog = {}

if PetAssets and type(PetAssets.Directory) == "table" then
    for petId, config in pairs(PetAssets.Directory) do
        if not PetModels or PetModels:FindFirstChild(petId) then
            table.insert(PetCatalog, {
                id = petId,
                display = config.DisplayName or petId,
                rate = tonumber(config.EarningRate) or 0,
                rarity = type(config.Rarity) == "table" and config.Rarity.Name or "?",
                icon = config.Icon or "",
            })
        end
    end
end

table.sort(PetCatalog, function(a, b)
    return a.display < b.display
end)

local PetByValue = {}
local PetValues = {}
for _, pet in ipairs(PetCatalog) do
    local value = pet.display
    if PetByValue[value] then
        value = pet.display .. " [" .. pet.id .. "]"
    end
    PetValues[#PetValues + 1] = value
    PetByValue[value] = pet
end

local PreviewFrame = Window:Create("Frame", {
    Name = "PetPreview",
    Size = UDim2.new(1, -32, 0, 170),
    BackgroundTransparency = 0.12,
    BorderSizePixel = 0,
    LayoutOrder = 2,
    Parent = Displays.tabPage,
}, {BackgroundColor3 = "ElementBackground"})
Window:Create("UICorner", {
    CornerRadius = UDim.new(0, 12),
    Parent = PreviewFrame,
})

local PreviewImage = Window:Create("ImageLabel", {
    Name = "PetImage",
    Position = UDim2.fromOffset(14, 14),
    Size = UDim2.fromOffset(142, 142),
    BackgroundTransparency = 1,
    ScaleType = Enum.ScaleType.Fit,
    Parent = PreviewFrame,
})

local PreviewInfo = Window:Create("Frame", {
    Position = UDim2.fromOffset(172, 18),
    Size = UDim2.new(1, -188, 0, 130),
    BackgroundTransparency = 1,
    Parent = PreviewFrame,
})
Window:Create("UIListLayout", {
    Padding = UDim.new(0, 7),
    FillDirection = Enum.FillDirection.Vertical,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = PreviewInfo,
})

local PreviewName = Window:Create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundTransparency = 1,
    TextSize = 19,
    TextXAlignment = Enum.TextXAlignment.Left,
    Text = "No pet selected",
    Parent = PreviewInfo,
}, {TextColor3 = "ContentColor", FontFace = "TitleFont"})
local PreviewCash = Window:Create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 20),
    BackgroundTransparency = 1,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
    Text = "Cash: $0/s",
    Parent = PreviewInfo,
}, {TextColor3 = "ContentColor", FontFace = "Font"})
local PreviewRarity = Window:Create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 20),
    BackgroundTransparency = 1,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
    Text = "Rarity: ?",
    Parent = PreviewInfo,
}, {TextColor3 = "ContentColor", FontFace = "Font"})

local function updateSelectedPetInfo(entry)
    if not entry then
        PreviewImage.Image = ""
        PreviewName.Text = "No pet selected"
        PreviewCash.Text = "Cash: $0/s"
        PreviewRarity.Text = "Rarity: ?"
        return
    end

    PreviewImage.Image = entry.icon or ""
    PreviewName.Text = entry.display or entry.id or "Unknown"
    PreviewCash.Text = ("Cash: $%s/s"):format(tostring(entry.rate or 0))
    PreviewRarity.Text = ("Rarity: %s"):format(tostring(entry.rarity or "?"))
end

if #PetValues > 0 then
    Displays:CreateDropdown({
        Name = "Pet preview",
        Options = PetValues,
        CurrentOption = {PetValues[1]},
        MultipleOptions = false,
        Callback = function(value)
            local selected = type(value) == "table" and value[1] or value
            updateSelectedPetInfo(PetByValue[selected])
        end,
    })
    updateSelectedPetInfo(PetByValue[PetValues[1]])
else
    PreviewName.Text = "No pet catalog found"
end

-- The window opens normally.
-- CapsuleAnimation affects the restored capsule animation and glow.
Window:Show()

-- Optional cleanup:
-- Window:Unload()
