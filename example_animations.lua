-- Rayfield Gen 2 animation features example
-- The modified library is available in Rayfield-Gen2-Animations.lua.
-- For a live release, replace the URL below with your raw GitHub URL after publishing.

local Rayfield = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/IsnowDev7/Rayfield-Gen-2-Modded/main/Rayfield-Gen2-Animations.lua"
))()

local Window = Rayfield:CreateWindow({
    Name = "Animation Showcase",
    Subtitle = "Rayfield Gen 2",
    Icon = "rbxassetid://7733960981",

    -- New opt-in visual features.
    BlurBackground = true,
    CapsuleAnimation = true,
    IconTabAnimation = true,

    -- Existing options can be used normally.
    Theme = "Default",
    SidebarLayout = false,
    configuration = {
        autoSave = true,
        autoLoad = true,
        customFolder = "RayfieldAnimationExample",
        fileName = "settings",
    },
})

local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "rbxassetid://7734053495",
})

MainTab:CreateSection({
    Name = "Animation Features",
})

MainTab:CreateText({
    Name = "What is enabled",
    Text = "The window uses background blur, the capsule beat/glow animation, rotating tab icons, and the strengthened black corner glow.",
})

MainTab:CreateButton({
    Name = "Show notification",
    Icon = "rbxassetid://7733715400",
    Callback = function()
        Window:Notify({
            Title = "Animations enabled",
            Content = "Touch or hold the capsule to see the beat and glow effect.",
            Duration = 4,
        })
    end,
})

MainTab:CreateToggle({
    Name = "Example toggle",
    Value = true,
    Flag = "ExampleToggle",
    Callback = function(value)
        print("Example toggle:", value)
    end,
})

MainTab:CreateSlider({
    Name = "Example slider",
    Range = {0, 100},
    Increment = 5,
    Suffix = "%",
    Value = 50,
    Flag = "ExampleSlider",
    Callback = function(value)
        print("Example slider:", value)
    end,
})

local SecondTab = Window:CreateTab({
    Name = "Second Tab",
    Icon = "rbxassetid://7734053495",
})

SecondTab:CreateSection({
    Name = "Icon Spin Test",
})

SecondTab:CreateText({
    Name = "Try switching tabs",
    Text = "This tab icon rotates one full revolution when the window opens and whenever this tab is selected.",
})

SecondTab:CreateButton({
    Name = "Minimize window",
    Callback = function()
        Window:ToggleMinimise()
    end,
})

local SettingsTab = Window:CreateTab({
    Name = "Settings",
    Icon = "rbxassetid://7734053495",
})

SettingsTab:CreateSection({
    Name = "Window Controls",
})

SettingsTab:CreateButton({
    Name = "Close window",
    Callback = function()
        Window:Hide()
    end,
})

-- The window opens normally. Blur fades in during the opening animation.
Window:Show()

-- Configuration examples:
-- BlurBackground = false       -- disables Lighting blur
-- CapsuleAnimation = false     -- disables capsule beat/glow
-- IconTabAnimation = false     -- disables tab icon spinning
