-- Rayfield Gen 2 Modded: updated feature example

local Rayfield = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/IsnowDev7/Rayfield-Gen-2-Modded/main/rayfield2.txt"
))()

local Window = Rayfield:CreateWindow({
    Name = "Image and Rich Content Demo",
    Theme = "Damacus",
    ProfileWindow = true,
    ProfileDescription = "Rich image and frame example",
    Profilelink = "discord.gg/example",
    Resizable = true,
    ResizeMinSize = Vector2.new(480, 360),
    TabIconAnimation = true,
})

local ContentTab = Window:CreateTab({
    Name = "Content",
    -- Numeric IDs, rbxassetid://, CDN links, PNG/JPEG links, and Imgur links
    -- are accepted by the icon resolver.
    Icon = "https://i.imgur.com/example.png",
})

ContentTab:CreateSection({Name = "Paragraphs and Images"})

-- Existing convenience method. This creates an image-only paragraph.
ContentTab:AddImage("rbxasset://0")

-- Image sources accepted by CreateImage/AddImage and paragraph image fields:
ContentTab:AddImage("rbxassetid://123456789")
ContentTab:AddImage("https://cdn.example.com/image.png")
ContentTab:AddImage("https://cdn.example.com/image.jpg")
ContentTab:AddImage("https://cdn.example.com/image.jpeg")
ContentTab:AddImage("https://imgur.com/example")
ContentTab:AddImage("https://i.imgur.com/example.png")

-- A paragraph with a title, text, icon, and an auto-sized rich-content frame.
ContentTab:CreateText({
    Name = "Rich Paragraph",
    Icon = "https://i.imgur.com/example.png",
    Text = "The title and paragraph resize vertically with their contents.",
    Content = {
        {
            ClassName = "Frame",
            Name = "InfoFrame",
            BackgroundTransparency = 0.15,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Children = {
                {
                    ClassName = "ImageLabel",
                    Image = "https://cdn.example.com/banner.jpeg",
                    Size = UDim2.new(1, 0, 0, 160),
                    ScaleType = Enum.ScaleType.Fit,
                    BackgroundTransparency = 1,
                },
                {
                    ClassName = "TextLabel",
                    Text = "This TextLabel is inside a Frame. The frame automatically grows to fit it.",
                    Size = UDim2.new(1, -20, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    TextWrapped = true,
                    RichText = true,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                },
                {
                    ClassName = "Frame",
                    Size = UDim2.new(1, 0, 0, 44),
                    BackgroundTransparency = 0.25,
                    Children = {
                        {
                            ClassName = "TextLabel",
                            Text = "Nested frame content",
                            Size = UDim2.new(1, -12, 1, 0),
                            BackgroundTransparency = 1,
                            TextXAlignment = Enum.TextXAlignment.Center,
                            TextYAlignment = Enum.TextYAlignment.Center,
                        },
                    },
                },
            },
        },
        {
            ClassName = "TextLabel",
            Text = "A normal auto-sized TextLabel paragraph after the image frame.",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            TextWrapped = true,
            BackgroundTransparency = 1,
        },
    },
})

local HoldTab = Window:CreateTab({
    Name = "Hold Button",
    Icon = "rbxassetid://4483345998",
})

HoldTab:CreateHoldButton({
    Name = "Hold to Confirm",
    HoldTime = 2,
    LineColor = Color3.fromRGB(151, 105, 255),
    Callback = function()
        Window:Notify({
            Title = "Hold Complete",
            Content = "The hold action completed.",
            Duration = 3,
        })
    end,
})

local ThemeTab = Window:CreateTab({
    Name = "Themes",
    Icon = "https://i.imgur.com/example.png",
})

ThemeTab:CreateDropdown({
    Name = "Theme",
    Options = {"Damacus", "Blahite", "Yelue", "Default"},
    CurrentOption = {"Damacus"},
    MultipleOptions = false,
    Callback = function(Selection)
        local ThemeName = type(Selection) == "table" and Selection[1] or Selection
        if type(ThemeName) == "string" then
            Window:ChangeTheme(ThemeName)
        end
    end,
})

-- Blur is automatic in the modified library:
-- opening/showing enables it, minimize keeps it enabled, Hide disables it,
-- and Unload destroys it.

-- Example cleanup:
-- Window:Unload()
