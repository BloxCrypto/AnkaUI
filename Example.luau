-- load the library first
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/BloxCrypto/AnkaUI/refs/heads/main/Library/Module.lua"))()

-- custom gui settings (optional, you can remove if not needed)
local stored_fonts = {}
gui_config = {
    Color = Color3.fromRGB(255, 255, 255),
    Keybind = Enum.KeyCode.Insert, -- for pc related only
    Assets = false, -- set to true if you want custom background asset
    MinHeight = 100,
    MaxHeight = 600,
    InitialHeight = 400,
    MinWidth = 300,
    MaxWidth = 800,
    InitialWidth = 500
}

for _, v in Enum.Font:GetEnumItems() do
    table.insert(stored_fonts, v.Name)
end

-- use config if available
local config = (getfenv().gui_config) or nil
local window = library:CreateWindow(config, gethui())
local window_name = library:SetWindowName("Example Name")

-- create/add tabs
local tabs = {
    main = window:CreateTab("Main"),
    settings = window:CreateTab("Settings")
}

-- create/add sections
local sections = {
    toggle_example_section = tabs.main:CreateSection("Toggle Example"),
    label_example_section = tabs.main:CreateSection("Label Example"),
    button_example_section = tabs.main:CreateSection("Button Example"),
    textbox_example_section = tabs.main:CreateSection("Textbox Example"),
    dropdown_example_section = tabs.main:CreateSection("Dropdown Example"),
    slider_example_section = tabs.main:CreateSection("Slider Example"),
    other_example_section = tabs.main:CreateSection("Other Example", "right")
}

-- toggle examples
sections.toggle_example_section:CreateToggle("On Toggle", true, function(value) print(value) end)
sections.toggle_example_section:CreateToggle("Basic Toggle", false, function(value) print(value) end)
sections.toggle_example_section:CreateToggle("Normal Toggle", false, function(value) print(value) end)
sections.toggle_example_section:CreateToggle("Dangerous Toggle", false, function(value) print(value) end, "dangerous", "scary toggle 🙀")
sections.toggle_example_section:CreateToggle("Buggy Toggle", false, function(value) print(value) end, "buggy", "barely functions")

local bindable_toggle = sections.toggle_example_section:CreateToggle("Keybind Toggle", false, function(value) print(value) end)
bindable_toggle:CreateKeybind("K", function(key) print("pressed keybind", key) end, "Hold")

local colorpicker_toggle = sections.toggle_example_section:CreateToggle("Colorpicker Toggle", false, function(value) print(value) end)
sections.toggle_example_section:CreateColorpicker("Color Picker", function(color, transparency) print(color, transparency) end, false, false, colorpicker_toggle)

-- label examples
sections.label_example_section:CreateLabel("This is a label obviously...")
sections.label_example_section:CreateLabel("This is a longer label that wraps across multiple lines", true)
local time_label = sections.label_example_section:CreateLabel("Current Time: "..os.date("%H:%M:%S"))
sections.label_example_section:CreateDivider()
sections.label_example_section:CreateLabel("The thing above me is a divider!!!")

-- button examples
sections.button_example_section:CreateButton("Click Me", function() print("clicked") end)
sections.button_example_section:CreateButton("Update Time Label", function() time_label:UpdateText("Current Time: "..os.date("%H:%M:%S")) end)
sections.button_example_section:CreateButton("This is a long button that wraps text", function() print("blah") end, true)

-- textbox examples
sections.textbox_example_section:CreateTextBox("Placeholder", "Default", false, function(value) print(value) end)

-- slider examples
sections.slider_example_section:CreateSlider("Precise Slider", 41, 67, 41, true, function(value) print(value) end)
sections.slider_example_section:CreateSlider("Not Precise Slider", 0.1, 1, 0.1, false, function(value) print(value) end)

-- dropdown examples
sections.dropdown_example_section:CreateDropdown("Choose Number", {"1","2","3","4","5"}, function(value) print(value) end, "1", false)

-- colorpicker examples
sections.other_example_section:CreateColorpicker("Color Picker Without Toggle", function(color, transparency) print(color, transparency) end)

-- notifications
window:Notify("title", "content", 5)

-- HUD / watermark
local watermark = library:Hud()
game:GetService("RunService").RenderStepped:Connect(function()
    watermark:SetText("Example Name | "..os.date("%Y-%m-%d %H:%M:%S", os.time()))
end)

-- font dropdown
sections.dropdown_example_section:CreateDropdown("Change Font", stored_fonts, function(value) window:SetFont(value) end, "", false)

-- config manager
local config_manager = loadstring(game:HttpGet("https://raw.githubusercontent.com/BloxCrypto/AnkaUI/refs/heads/main/Library/ConfigManager.lua"))()
config_manager:SetLibrary(library)
config_manager:SetWindow(window)
config_manager:SetFolder("Example Name")
config_manager:BuildConfigSection(tabs.settings)
config_manager:LoadAutoloadConfig()

-- background customization
window:SetBackground("123456789")
window:SetTileOffset(100)
window:SetTileScale(0.5)
window:SetBackgroundColor(Color3.fromRGB(40, 40, 40))
window:SetBackgroundTransparency(0.5)
