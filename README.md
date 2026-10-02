# Rayfield-Gen-2-Modded

This repository contains the corrected Rayfield Gen 2 modded source.

## Main files

- `Rayfieldgen2modded.txt` — corrected source.
- `Rayfieldgen2modded_fixed` — matching generated artifact.
- `Themes/` — standalone theme definitions.
- `example.txt` — rewritten, corrected feature request and usage example.

## Included fixes

The current version includes the Damascus, Blahite, and Yelue themes; guarded image and avatar resolution; `CreateHoldButton`; automatic blur lifecycle handling; tab icon rotation; a window-attached profile card; and defensive console rendering.

## SwipeLeftTab

Set `SwipeLeftTab = true` inside an individual `Window:CreateTab({...})` definition to lay out that tab's top-level sections and controls horizontally. The tab content can then be swiped or scrolled left and right, while each section, button, toggle, paragraph, and other control keeps its normal width. The default remains vertical scrolling when the option is omitted or set to `false`.

### Auto-resizing display cards

`CreateText` display cards can contain real controls. Create a display card, then call component methods on its returned handle, such as `CreateToggle`, `CreateButton`, `CreateDropdown`, `CreateInput`, or `CreateGroup`. The embedded vertical container automatically grows the card downward as controls are added.

```lua
local DisplayCard = Tab:CreateText({
    name = "Pet Spawner",
    text = "Controls stay inside this card.",
})

DisplayCard:CreateToggle({ name = "Auto collect", callback = function(value) end })
DisplayCard:CreateDropdown({ name = "Select pet", options = { "Cat", "Dog" } })
DisplayCard:CreateButton({ name = "Spawn", callback = function() end })
```

## Automatic icon and image sources

Window, tab, and element `icon` values now share one resolver. The resolver accepts:

- Numeric Roblox asset IDs, such as `4483362458` or `"rbxassetid://4483362458"`.
- Lucide names, such as `"house"`, `"settings"`, or explicit `"lucide:house"`. The Lucide mapping is loaded lazily from the Footagesus Icons library.
- Imgur image links, including `imgur.com/id`, `imgur.com/id.png`, and `i.imgur.com/id.jpeg`.
- GitHub blob links, which are converted to `raw.githubusercontent.com` URLs.
- Direct GitHub raw and CDN image URLs.

When the executor exposes `getcustomasset` or `getsynasset`, remote images are downloaded into Rayfield's asset folder, converted into local custom assets, and cached. Without those executor APIs, the original URL is retained as a fallback.

```lua
local Window = Rayfield:CreateWindow({
    Name = "Icon Example",
    Icon = "lucide:layout-dashboard",
})

local Tab = Window:CreateTab({
    Name = "Main",
    Icon = "house",
})

local ImageTab = Window:CreateTab({
    Name = "Remote Image",
    Icon = "https://i.imgur.com/kd65fBV.jpeg",
})
```
