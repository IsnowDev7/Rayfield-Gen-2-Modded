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
    SwipeLeftTab = true,
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
    SwipeLeftTab = true,
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
    SwipeLeftTab = true,
})

Actions:CreateSection({Name = "Action Examples"})

Actions:CreateHoldButton({
    Name = "Hold to confirm",
    HoldTime = 2,
    LineColor = Color3.fromRGB(151, 105, 255),
    Callback = function()
        Window:Notify({
            Title = "Hold complete",
            Content = "The hold callback ran successfully.",
            Duration = 3,
        })
    end,
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

-- The window opens normally. CapsuleAnimation affects the restored capsule only.
Window:Show()

-- Optional cleanup:
-- Window:Unload()
