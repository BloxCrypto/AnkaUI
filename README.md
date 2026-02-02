***

# XXSCRIPT UI Library Documentation

A powerful, customizable Roblox GUI library for creating sleek, modern interfaces with toggles, sliders, dropdowns, and more.

## Quick Start

```lua
-- Load the library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/nfpw/XXSCRIPT/refs/heads/main/Library/Module.lua"))()

-- Create window with optional config
local config = {
    Color = Color3.fromRGB(255, 255, 255),
    Keybind = Enum.KeyCode.Insert,
    Assets = false,
    MinHeight = 100, MaxHeight = 600, InitialHeight = 400,
    MinWidth = 300, MaxWidth = 800, InitialWidth = 500
}
local window = library:CreateWindow(config, gethui())
local window_name = library:SetWindowName("My GUI")
```

## Configuration Options

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| `Color` | `Color3` | Primary accent color | `255,255,255` |
| `Keybind` | `Enum.KeyCode` | Toggle key (PC only) | `Insert` |
| `Assets` | `boolean` | Enable custom backgrounds | `false` |
| `MinHeight/MaxHeight` | `number` | Window height limits | `100/600` |
| `InitialHeight` | `number` | Starting height | `400` |
| `MinWidth/MaxWidth` | `number` | Window width limits | `300/800` |
| `InitialWidth` | `number` | Starting width | `500` |

## Core Structure

```
Window
├── Tab ("Main")
│   ├── Section ("Toggle Example")
│   │   ├── Toggle
│   │   ├── Keybind Toggle
│   │   └── Colorpicker Toggle
│   └── Section ("Settings", "right")
└── Tab ("Settings")
```

## API Reference

### Window Methods

| Method | Parameters | Description |
|--------|------------|-------------|
| `CreateTab(name)` | `string name` | Creates new tab |
| `SetWindowName(name)` | `string name` | Sets window title |
| `SetFont(fontName)` | `string fontName` | Changes UI font |
| `SetBackground(id)` | `string id` | Sets custom background (Assets=true) |
| `SetBackgroundColor(color)` | `Color3` | Background tint |
| `SetBackgroundTransparency(alpha)` | `number 0-1` | Background opacity |
| `SetTileOffset(offset)` | `number` | Background position offset |
| `SetTileScale(scale)` | `number 0-1` | Background tile size |
| `Notify(title, content, duration)` | `string, string, number?` | Shows notification |

### Section Methods

**CreateSection(name, side?)**
- `name`: Section title
- `side`: `"left"` or `"right"` (auto if omitted)

### Components

#### Toggle
```lua
section:CreateToggle(text, default, callback, style?, tooltip?)
```
- `text`: Display name
- `default`: `true/false`
- `callback`: `function(value)`
- `style`: `"dangerous"`, `"buggy"`
- Returns toggle object with `:CreateKeybind(key, callback)` and colorpicker methods

#### Keybind (on Toggle)
```lua
toggle:CreateKeybind(defaultKey, callback, mode?)
```
- `mode`: `"Hold"`, `"Toggle"`

#### Colorpicker
```lua
section:CreateColorpicker(text, callback, defaultOpen?, rainbow?, toggleRef?)
toggle:CreateColorpicker(text, callback, defaultOpen?, rainbow?)
```
- `callback`: `function(color, transparency)`

#### Label
```lua
section:CreateLabel(text, multiline?)
```
- Returns label object with `:UpdateText(newText)`

#### Button
```lua
section:CreateButton(text, callback, multiline?)
```

#### TextBox
```lua
section:CreateTextBox(placeholder, default, numbersOnly, callback)
```

#### Slider
```lua
section:CreateSlider(text, min, max, default, precise, callback)
```
- `precise`: `true` = integers only

#### Dropdown
```lua
section:CreateDropdown(text, options, callback, default?, multiSelect?)
```

### Utilities

#### HUD Watermark
```lua
local watermark = library:Hud()
watermark:SetText("Text here")
```

#### Config Manager (Optional)
```lua
local config_manager = loadstring(game:HttpGet("https://raw.githubusercontent.com/nfpw/XXSCRIPT/refs/heads/main/Library/ConfigManager.lua"))()
config_manager:SetLibrary(library)
config_manager:SetWindow(window)
config_manager:SetFolder("MyConfigs")
config_manager:BuildConfigSection(tab)
config_manager:LoadAutoloadConfig()
```

## Example Usage

```lua
-- Full example structure
local tabs = {
    main = window:CreateTab("Main"),
    settings = window:CreateTab("Settings")
}

local section = tabs.main:CreateSection("My Section")
section:CreateToggle("My Toggle", true, function(v) print(v) end)

-- Live updating label
local timeLabel = section:CreateLabel("Time: Loading...")
game:GetService("RunService").Heartbeat:Connect(function()
    timeLabel:UpdateText("Time: " .. os.date("%H:%M:%S"))
end)
```

## Font List
All Roblox fonts available via dropdown:
```lua
local stored_fonts = {}
for _, v in Enum.Font:GetEnumItems() do
    table.insert(stored_fonts, v.Name)
end
```

***