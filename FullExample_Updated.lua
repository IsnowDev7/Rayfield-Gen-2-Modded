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
    BlurBackground = true,
    CapsuleAnimation = true,
    TabIconAnimation = true,
    Resizable = true,
    ResizeMinSize = Vector2.new(480, 360),
    configuration = {
        autoSave = true,
        autoLoad = true,
        customFolder = "RayfieldGen2Example",
        fileName = "settings",
    },
})

local Home = Window:CreateTab({
    Name = "Home",
    Icon = "rbxassetid://7734053495",
})

Home:CreateSection({Name = "Welcome"})

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

local Controls = Window:CreateTab({
    Name = "Controls",
    Icon = "rbxassetid://7734053495",
})

Controls:CreateSection({Name = "Window Controls"})

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
    Options = {"Default", "Damacus", "Blahite", "Yelue"},
    CurrentOption = {"Default"},
    MultipleOptions = false,
    Callback = function(selection)
        local themeName = type(selection) == "table" and selection[1] or selection
        if type(themeName) == "string" then
            Window:ChangeTheme(themeName)
        end
    end,
})

local Actions = Window:CreateTab({
    Name = "Actions",
    Icon = "rbxassetid://7734053495",
})

Actions:CreateSection({Name = "Action Examples"})

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

local Displays = Window:CreateTab({
    Name = "Displays",
    Icon = "rbxassetid://7734053495",
    SwipeLeftTab = true,
})

Displays:CreateSection({
    Name = "Display Components",
})

-- A display accepts an image and up to two child demonstration components.
-- Supported child types: Button, Toggle, Dropdown, Paragraph, and Description.
Displays:AddCreateDisplay({
    Name = "Display Example",
    Image = "rbxassetid://7733960981",
    Description = "The section-style display keeps two interactive items underneath the image.",
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
            Options = {"First", "Second", "Third"},
            Callback = function(value)
                print("Display dropdown:", value)
            end,
        },
    },
})

-- The window opens normally.
-- CapsuleAnimation affects the restored capsule animation and glow.
Window:Show()

-- Optional cleanup:
-- Window:Unload()
