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

    -- Capsule visual feature.
    BlurBackground = true,
    CapsuleAnimation = true,
    IconTabAnimation = false,

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
    SwipeLeftTab = true,
    Name = "Main",
    Icon = "rbxassetid://7734053495",
})

MainTab:CreateSection({
    Name = "Animation Features",
})

MainTab:CreateText({
    Name = "What is enabled",
    Text = "The window uses background blur, capsule beat/glow animation, and horizontal left-scrolling tab content. Swipe left to reveal each section, button, toggle, and slider without shrinking the controls.",
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
    SwipeLeftTab = true,
    Name = "Second Tab",
    Icon = "rbxassetid://7734053495",
})

SecondTab:CreateSection({
    Name = "Capsule Focus Test",
})

SecondTab:CreateText({
    Name = "Try switching tabs",
    Text = "Hide the window, then press or touch the capsule. The capsule stays visible without a dark full-screen overlay.",
})

SecondTab:CreateButton({
    Name = "Minimize window",
    Callback = function()
        Window:ToggleMinimise()
    end,
})

local SettingsTab = Window:CreateTab({
    SwipeLeftTab = true,
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

local DisplayTab = Window:CreateTab({
    SwipeLeftTab = true,
    Name = "Displays",
    Icon = "rbxassetid://7734053495",
})

DisplayTab:CreateSection({
    Name = "Display Example",
})

DisplayTab:AddCreateDisplay({
    Name = "Roblox CDN Display",
    Image = "rbxassetid://7733960981",
    Description = "A section-style display with an image and two child components.",
    Components = {
        {
            Type = "Button",
            Name = "Display button",
            Callback = function()
                Window:Notify({
                    Title = "Display button",
                    Content = "The display callback ran.",
                    Duration = 3,
                })
            end,
        },
        {
            Type = "Toggle",
            Name = "Display toggle",
            Value = false,
            Callback = function(value)
                print("Display toggle:", value)
            end,
        },
    },
})

-- The window opens normally. Blur fades in during the opening animation.
Window:Show()

-- Configuration examples:
-- BlurBackground = false       -- disables Lighting blur
-- CapsuleAnimation = false     -- disables capsule beat/glow
-- IconTabAnimation = false     -- tab icons remain static


-- SwipeLeftTab is configured inside each CreateTab call above.
-- Remove it from a tab to restore that tab's normal vertical scrolling.
