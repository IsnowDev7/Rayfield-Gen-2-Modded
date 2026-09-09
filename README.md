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

Set `SwipeLeftTab = true` in `CreateWindow` to lay out each tab's top-level sections and controls horizontally. The tab content can then be swiped or scrolled left and right, while each section, button, toggle, paragraph, and other control keeps its normal width. The default remains vertical scrolling when the option is omitted or set to `false`.
