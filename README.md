# Documentation for Custom Roblox UI Library

This document explains how to use the provided UI library to build customizable GUIs in Roblox. It covers configuration, window creation, tabs, sections, and all available UI elements.

---

## 1. Configuration

You can define a global `gui_config` table to customize the initial GUI settings:

```lua
gui_config = {
    Color = Color3.fromRGB(255, 255, 255), -- Default text color
    Keybind = Enum.KeyCode.Insert,         -- Key to toggle GUI visibility
    Assets = false,                        -- Enable custom background asset
    MinHeight = 100,
    MaxHeight = 600,
    InitialHeight = 400,
    MinWidth = 300,
    MaxWidth = 800,
    InitialWidth = 500
}
```

- **Color**: Default text color for GUI elements.  
- **Keybind**: Keyboard shortcut to toggle GUI.  
- **Assets**: Enable/disable custom background images.  
- **Min/Max Height/Width**: Size constraints for the window.  
- **InitialHeight/Width**: Default size when GUI loads.  

---

## 2. Window Creation

```lua
local library = loadstring(game:HttpGet(".../Library/Module.lua"))()
local window = library:CreateWindow(gui_config, gethui())
library:SetWindowName("Example Name")
```

- `CreateWindow(config, parent)`: Creates the main GUI window.  
- `SetWindowName(name)`: Sets the title of the GUI.  

---

## 3. Tabs

Tabs organize sections inside the window:

```lua
local tabs = {
    main = window:CreateTab("Main"),
    settings = window:CreateTab("Settings")
}
```

---

## 4. Sections

Sections group UI elements inside tabs:

```lua
local sections = {
    toggle_example_section = tabs.main:CreateSection("Toggle Example"),
    label_example_section = tabs.main:CreateSection("Label Example"),
    button_example_section = tabs.main:CreateSection("Button Example"),
    textbox_example_section = tabs.main:CreateSection("Textbox Example"),
    dropdown_example_section = tabs.main:CreateSection("Dropdown Example"),
    slider_example_section = tabs.main:CreateSection("Slider Example"),
    other_example_section = tabs.main:CreateSection("Other Example", "right")
}
```

- Optional `"left"` or `"right"` argument places the section on a side of the tab.  

---

## 5. UI Elements

### Toggles
```lua
sections.toggle_example_section:CreateToggle("Basic Toggle", false, function(value)
    print(value)
end)
```
- **Arguments**: `(label, default_state, callback, type?, description?)`  
- Types: `"dangerous"`, `"buggy"`, etc.  
- Can bind keys:
```lua
local toggle = sections.toggle_example_section:CreateToggle("Keybind Toggle", false, function(v) end)
toggle:CreateKeybind("K", function(key) print("pressed", key) end, "Hold")
```

### Colorpickers
```lua
sections.toggle_example_section:CreateColorpicker("Color Picker", function(color, transparency)
    print(color, transparency)
end, false, false, toggle_reference)
```

### Labels
```lua
sections.label_example_section:CreateLabel("This is a label")
sections.label_example_section:CreateDivider()
```
- Supports wrapping text.  
- Labels can be updated dynamically:
```lua
time_label:UpdateText("Current Time: "..os.date("%H:%M:%S"))
```

### Buttons
```lua
sections.button_example_section:CreateButton("Click Me", function()
    print("clicked")
end)
```
- Supports long text buttons with wrapping.

### Textboxes
```lua
sections.textbox_example_section:CreateTextBox("Placeholder", "Default", false, function(value)
    print(value)
end)
```
- `true` for numeric-only input.

### Sliders
```lua
sections.slider_example_section:CreateSlider("Precise Slider", 0, 100, 50, true, function(value)
    print(value)
end)
```
- **Precise = true** → integer values only.  
- **Precise = false** → decimal values allowed.  

### Dropdowns
```lua
sections.dropdown_example_section:CreateDropdown("Choose Number", {"1","2","3"}, function(value)
    print(value)
end, "1", false)
```
- Supports single or multiple selections.  
- Can be used to change fonts dynamically:
```lua
window:SetFont(selected_font)
```

---

## 6. Notifications

```lua
window:Notify("Title", "Content", 5)
```
- Duration defaults to **15 seconds** if not specified.  

---

## 7. HUD / Watermark

```lua
local watermark = library:Hud()
game:GetService("RunService").RenderStepped:Connect(function()
    watermark:SetText("Example Name | "..os.date("%Y-%m-%d %H:%M:%S"))
end)
```

---

## 8. Config Manager

```lua
local config_manager = loadstring(game:HttpGet(".../Library/ConfigManager.lua"))()
config_manager:SetLibrary(library)
config_manager:SetWindow(window)
config_manager:SetFolder("Example Name")
config_manager:BuildConfigSection(tabs.settings)
config_manager:LoadAutoloadConfig()
```

- Saves and loads GUI configurations automatically.  

---

## 9. Background Customization

```lua
window:SetBackground("123456789") -- Roblox asset ID
window:SetTileOffset(100)
window:SetTileScale(0.5)
window:SetBackgroundColor(Color3.fromRGB(40,40,40))
window:SetBackgroundTransparency(0.5)
```

---

## Summary

This UI library provides a **modular system** for building Roblox GUIs with:
- Configurable windows  
- Tabs and sections  
- Toggles, sliders, dropdowns, textboxes, buttons, labels  
- Notifications and HUD  
- Config saving/loading  
- Background customization  

Would you like me to also create a **quick-start template** (minimal example) so you can copy-paste and build a GUI instantly?