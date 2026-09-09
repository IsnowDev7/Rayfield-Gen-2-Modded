-- Rayfield Gen 2 animation and section-layout example
-- The modified library is available in Rayfield-Gen2-Animations.lua.

local Rayfield = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/IsnowDev7/Rayfield-Gen-2-Modded/main/Rayfield-Gen2-Animations.lua"
))()

local Window = Rayfield:CreateWindow({
    Name = "Animation Showcase",
    Subtitle = "Sections + capsule interaction",
    Icon = "rbxassetid://7733960981",

    -- SidebarLayout enables Window:CreateSection below.
    SidebarLayout = true,
    BlurBackground = true,
    CapsuleAnimation = true,
    IconTabAnimation = false,

    Theme = "Default",
    configuration = {
        autoSave = true,
        autoLoad = true,
        customFolder = "RayfieldAnimationExample",
        fileName = "settings",
    },
})

-- Window sections are rendered in the sidebar only when SidebarLayout = true.
Window:CreateSection({
    Name = "Examples",
    Icon = "rbxassetid://7734053495",
})

local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "rbxassetid://7734053495",
})

-- Tab sections are rendered inside the tab content area in every layout.
MainTab:CreateSection({
    Name = "Animation Features",
})

MainTab:CreateText({
    Name = "What is enabled",
    Text = "This window demonstrates sidebar sections, regular tab sections, background blur, and the capsule animation.",
})

MainTab:CreateButton({
    Name = "Show notification",
    Icon = "rbxassetid://7733715400",
    Callback = function()
        Window:Notify({
            Title = "Animations enabled",
            Content = "Hide the window, then press or hold the capsule to see it widen slightly with the beat and glow effect.",
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
    Name = "Capsule Focus Test",
})

SecondTab:CreateText({
    Name = "Try switching tabs",
    Text = "Hide the window, then press or touch the capsule. It widens slightly while held and returns to its original size when released.",
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

-- Create more sidebar sections whenever you want to group tab selectors.
Window:CreateSection({
    Name = "More",
})

local DisplayTab = Window:CreateTab({
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

Window:Show()

-- Configuration notes:
-- SidebarLayout = false  -- Window:CreateSection becomes inert; tab sections still work.
-- CapsuleAnimation = false -- disables capsule beat, glow, and press-widen animation.
-- IconTabAnimation = false -- tab icons remain static.
