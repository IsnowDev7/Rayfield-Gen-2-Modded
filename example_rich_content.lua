-- Rayfield Gen 2: capsule focus + rich paragraph example

local Rayfield = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/IsnowDev7/Rayfield-Gen-2-Modded/main/Rayfield-Gen2-Animations.lua?v=latest"
))()

local Window = Rayfield:CreateWindow({
    Name = "Animation Showcase",
    Subtitle = "Rayfield Gen 2",
    Icon = "rbxassetid://7733960981",
    BlurBackground = true,
    CapsuleAnimation = true,
    IconTabAnimation = false,
    Theme = "Default",
    SidebarLayout = false,
})

local ContentTab = Window:CreateTab({
    Name = "Content",
    Icon = "rbxassetid://7734053495",
})

ContentTab:CreateSection({Name = "Remote Images"})

-- ImageParagraph creates an image-only paragraph.
ContentTab:CreateParagraph({
    ImageParagraph = "https://i.imgur.com/example.png",
})

-- Supported forms include numeric IDs, rbxassetid:// IDs, CDN PNG/JPG/JPEG URLs,
-- https://imgur.com/example, and https://i.imgur.com/example.png.
ContentTab:AddImage("https://cdn.example.com/banner.jpeg")

ContentTab:CreateParagraph({
    Name = "Rich Paragraph",
    Text = "The title and description stay above the optional content area. The paragraph grows to fit its image and embedded instances.",
    ImageParagraph = "https://cdn.example.com/banner.png",
    Content = {
        {
            ClassName = "Frame",
            Name = "InfoFrame",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            BackgroundTransparency = 0.15,
            Children = {
                {
                    ClassName = "TextLabel",
                    Name = "EmbeddedText",
                    Size = UDim2.new(1, -20, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    Text = "This TextLabel is embedded inside the paragraph content area.",
                    TextWrapped = true,
                    TextSize = 15,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                },
                {
                    ClassName = "ImageLabel",
                    Name = "EmbeddedImage",
                    Size = UDim2.new(1, -20, 0, 120),
                    BackgroundTransparency = 1,
                    ScaleType = Enum.ScaleType.Fit,
                    Image = "https://i.imgur.com/example.png",
                },
            },
        },
    },
})

local ControlsTab = Window:CreateTab({
    Name = "Controls",
    Icon = "rbxassetid://7734053495",
})

ControlsTab:CreateText({
    Name = "Capsule focus effect",
    Text = "Hold or touch the collapsed capsule. A full-screen dark overlay fades in to focus attention on the capsule. Release it and the overlay fades out while the window uses its normal blur transition.",
})

ControlsTab:CreateButton({
    Name = "Hide Window",
    Callback = function()
        Window:Hide()
    end,
})

ControlsTab:CreateButton({
    Name = "Show Window",
    Callback = function()
        Window:Show()
    end,
})

Window:Show()
