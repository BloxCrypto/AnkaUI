local config = {
	correctkey = "Lievi",
	keylink = "link",

	colors = {
		outerborder = Color3.fromRGB(0, 0, 0),
		middleborder1 = Color3.fromRGB(53, 54, 53),
		middleborder2 = Color3.fromRGB(29, 29, 29),
		innerborder = Color3.fromRGB(53, 54, 53),
		background = Color3.fromRGB(6, 6, 5),
		accent = Color3.fromRGB(255, 128, 64),
		text = Color3.fromRGB(255, 255, 255),
		textsecondary = Color3.fromRGB(200, 200, 200)
	},

	savekey = true,
	savefolder = "Anka.Hook",
	savefile = "savedkey.txt"
}

local cloneref = cloneref or function(v) return v; end
local services = setmetatable({}, {
	__index = function(self, service)
		local cache = cloneref(game["GetService"](game, service["gsub"](service, "^%l", string.upper)))
		rawset(self, service, cache); return cache
	end, 
}); local gethui = gethui or function() return services.coreGui or services.players.LocalPlayer.PlayerGui; end
local ismobile = services.userInputService.TouchEnabled

local function create(class, properties)
	local instance = Instance.new(class)
	for property, value in pairs(properties or {}) do
		if property ~= "parent" then
			instance[property] = value
		end
	end
	if properties and properties.parent then
		instance.Parent = properties.parent
	end
	return instance
end

local screengui = create("ScreenGui", {
	Name = "nfpw was here",
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	Parent = gethui()
})

local tweeninfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local fadeinfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function createframe(parent, size, position, name)
	local outer = create("Frame", {
		Name = name or "BorderedFrame",
		BorderSizePixel = 0,
		BackgroundColor3 = config.colors.outerborder,
		Size = size,
		Position = position,
		parent = parent
	})

	local border1 = create("Frame", {
		Name = "Border1",
		BorderSizePixel = 0,
		BackgroundColor3 = config.colors.middleborder1,
		Size = UDim2.new(1, -2, 1, -2),
		Position = UDim2.new(0, 1, 0, 1),
		parent = outer
	})

	local border2 = create("Frame", {
		Name = "Border2",
		BorderSizePixel = 0,
		BackgroundColor3 = config.colors.middleborder2,
		Size = UDim2.new(1, -2, 1, -2),
		Position = UDim2.new(0, 1, 0, 1),
		parent = border1
	})

	local border3 = create("Frame", {
		Name = "Border3",
		BorderSizePixel = 0,
		BackgroundColor3 = config.colors.innerborder,
		Size = UDim2.new(1, -6, 1, -6),
		Position = UDim2.new(0, 3, 0, 3),
		parent = border2
	})

	local inner = create("Frame", {
		Name = "Inner",
		BorderSizePixel = 0,
		BackgroundColor3 = config.colors.background,
		Size = UDim2.new(1, -2, 1, -2),
		Position = UDim2.new(0, 1, 0, 1),
		parent = border3
	})

	if name == "KeySystemWindow" then
		create("Frame", {
			Name = "AccentLine",
			BorderSizePixel = 0,
			BackgroundColor3 = config.colors.accent,
			Size = UDim2.new(1, 0, 0, 1),
			parent = inner
		})

		create("Frame", {
			Name = "ShadowLine",
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 0.2,
			Size = UDim2.new(1, 0, 0, 1),
			Position = UDim2.new(0, 0, 0, 1),
			parent = inner
		})
	end

	return outer, inner
end

local function createlabel(parent, text, position, size)
	return create("TextLabel", {
		BackgroundTransparency = 1,
		Position = position,
		Size = size,
		Font = Enum.Font.Code,
		Text = text,
		TextColor3 = config.colors.text,
		TextSize = ismobile and 16 or 14,
		parent = parent
	})
end

local function createtextbox(parent, placeholder, position, size)
	local outerframe, innerframe = createframe(parent, size, position, "TextBoxFrame")

	local textbox = create("TextBox", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 8, 0, 0),
		Size = UDim2.new(1, -16, 1, 0),
		Font = Enum.Font.Code,
		PlaceholderText = placeholder,
		PlaceholderColor3 = config.colors.textsecondary,
		Text = "",
		TextColor3 = config.colors.text,
		TextSize = ismobile and 16 or 14,
		ClearTextOnFocus = false,
		parent = innerframe
	})

	textbox.Focused:Connect(function()
		services.tweenService:Create(innerframe, tweeninfo, {BackgroundColor3 = config.colors.innerborder}):Play()
	end)

	textbox.FocusLost:Connect(function()
		services.tweenService:Create(innerframe, tweeninfo, {BackgroundColor3 = config.colors.background}):Play()
	end)

	return outerframe, textbox
end

local function createbutton(parent, text, position, size, callback)
	local outerframe, innerframe = createframe(parent, size, position, "ButtonFrame")

	local button = create("TextButton", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Font = Enum.Font.Code,
		Text = text,
		TextColor3 = config.colors.text,
		TextSize = ismobile and 16 or 14,
		parent = innerframe
	})

	local ispressed = false

	button.MouseButton1Down:Connect(function()
		ispressed = true
		services.tweenService:Create(innerframe, tweeninfo, {BackgroundColor3 = config.colors.middleborder2}):Play()
	end)

	button.MouseButton1Up:Connect(function()
		ispressed = false
		services.tweenService:Create(innerframe, tweeninfo, {BackgroundColor3 = config.colors.background}):Play()
	end)

	button.MouseEnter:Connect(function()
		if not ispressed then
			services.tweenService:Create(innerframe, tweeninfo, {BackgroundColor3 = config.colors.innerborder}):Play()
		end
	end)

	button.MouseLeave:Connect(function()
		if not ispressed then
			services.tweenService:Create(innerframe, tweeninfo, {BackgroundColor3 = config.colors.background}):Play()
		end
		ispressed = false
	end)

	button.MouseButton1Click:Connect(callback)

	return outerframe, button, innerframe
end

local windowsize = ismobile and UDim2.new(0, 300, 0, 240) or UDim2.new(0, 320, 0, 200)
local mainframe, maininner = createframe(
	screengui,
	windowsize,
	UDim2.new(0.5, ismobile and -150 or -160, 0.5, ismobile and -120 or -100),
	"KeySystemWindow"
)

mainframe.BackgroundTransparency = 1
for _, child in ipairs(mainframe:GetDescendants()) do
	if child:IsA("GuiObject") then
		if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
			child.TextTransparency = 1
		end
		if not child:IsA("UICorner") then
			child.BackgroundTransparency = 1
		end
	end
end

task.wait(.1)

local function fadein(obj, targettrans)
	if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
		services.tweenService:Create(obj, fadeinfo, {TextTransparency = 0}):Play()
	end
	if not obj:IsA("UICorner") then
		services.tweenService:Create(obj, fadeinfo, {BackgroundTransparency = targettrans or 0}):Play()
	end
end

fadein(mainframe, 0)
for _, child in ipairs(mainframe:GetDescendants()) do
	if child:IsA("GuiObject") then
		local trans = (child.Name == "ShadowLine") and 0.2 or 0
		fadein(child, trans)
	end
end

local dragging, draginput, dragstart, startpos

local function updateinput(input)
	local delta = input.Position - dragstart
	local newpos = UDim2.new(
		startpos.X.Scale,
		startpos.X.Offset + delta.X,
		startpos.Y.Scale,
		startpos.Y.Offset + delta.Y
	)
	services.tweenService:Create(mainframe, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {Position = newpos}):Play()
end

mainframe.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragstart = input.Position
		startpos = mainframe.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainframe.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		draginput = input
	end
end)

services.userInputService.InputChanged:Connect(function(input)
	if input == draginput and dragging then
		updateinput(input)
	end
end)

local contentframe = create("Frame", {
	BackgroundTransparency = 1,
	Size = UDim2.new(1, -20, 1, -20),
	Position = UDim2.new(0, 10, 0, 10),
	parent = maininner
})

local title = createlabel(contentframe, "Anka.Hook", UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 0, 20))
title.TextSize = ismobile and 18 or 16
title.Font = Enum.Font.Code
title.TextColor3 = config.colors.accent
title.TextXAlignment = Enum.TextXAlignment.Center

local keylabel = createlabel(contentframe, "Enter Key:", UDim2.new(0, 0, 0, ismobile and 40 or 35), UDim2.new(1, 0, 0, 20))
keylabel.TextXAlignment = Enum.TextXAlignment.Left

local keyboxframe, keybox = createtextbox(contentframe, "Key...", UDim2.new(0, 0, 0, ismobile and 65 or 60), UDim2.new(1, 0, 0, ismobile and 35 or 30))

local checkboxy = ismobile and 110 or 100
local rememberframe = create("Frame", {
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 0, 0, checkboxy),
	Size = UDim2.new(1, 0, 0, 20),
	parent = contentframe
})

local checkboxframe, checkboxinner = createframe(rememberframe, UDim2.new(0, 20, 0, 20), UDim2.new(0, 0, 0, 2), "CheckboxFrame")

local checkboxfill = create("Frame", {
	Name = "CheckboxFill",
	BorderSizePixel = 0,
	BackgroundColor3 = config.colors.accent,
	Size = UDim2.new(1, -4, 1, -4),
	Position = UDim2.new(0, 2, 0, 2),
	BackgroundTransparency = 1,
	parent = checkboxinner
})

local rememberlabel = createlabel(rememberframe, "Remember Key", UDim2.new(0, 22, 0, 0), UDim2.new(1, -22, 0, 20))
rememberlabel.TextXAlignment = Enum.TextXAlignment.Left

local rememberkey = false

local checkbutton = create("TextButton", {
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, 0),
	Text = "",
	parent = rememberframe
})

checkbutton.MouseButton1Click:Connect(function()
	rememberkey = not rememberkey
	services.tweenService:Create(checkboxfill, tweeninfo, {
		BackgroundTransparency = rememberkey and 0 or 1
	}):Play()
end)

local buttony = ismobile and 150 or 140
local buttonheight = ismobile and 40 or 35

local submitbtnframe, submitbtn, submitinner
local getkeybtnframe, getkeybtn, getkeyinner

submitbtnframe, submitbtn, submitinner = createbutton(contentframe, "Submit", UDim2.new(0, 0, 0, buttony), UDim2.new(0.48, -5, 0, buttonheight), function()
	if keybox.Text == config.correctkey then
		if rememberkey and writefile then
			pcall(function()
				if not isfolder(config.savefolder) then
					makefolder(config.savefolder)
				end
				writefile(config.savefolder .. "/" .. config.savefile, keybox.Text)
			end)
		end

		submitbtn.Text = "Success!"
		submitbtn.TextColor3 = Color3.fromRGB(100, 255, 100)

		task.wait(.5)
		for _, obj in ipairs(mainframe:GetDescendants()) do
			if obj:IsA("GuiObject") then
				if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
					services.tweenService:Create(obj, fadeinfo, {TextTransparency = 1}):Play()
				end
				if not obj:IsA("UICorner") then
					services.tweenService:Create(obj, fadeinfo, {BackgroundTransparency = 1}):Play()
				end
			end
		end

		task.wait(.3)
		screengui:Destroy()

		print("Key accepted! Loading script...")

	else
		keybox.Text = ""
		keybox.PlaceholderText = "Invalid Key!"
		submitbtn.Text = "Invalid!"
		submitbtn.TextColor3 = Color3.fromRGB(255, 100, 100)

		local originalpos = submitbtnframe.Position
		for i = 1, 3 do
			services.tweenService:Create(submitbtnframe, TweenInfo.new(0.05), {Position = originalpos + UDim2.new(0, 5, 0, 0)}):Play()
			task.wait(.05)
			services.tweenService:Create(submitbtnframe, TweenInfo.new(0.05), {Position = originalpos - UDim2.new(0, 5, 0, 0)}):Play()
			task.wait(.05)
		end
		submitbtnframe.Position = originalpos

		task.wait(1.5)
		keybox.PlaceholderText = "Key..."
		submitbtn.Text = "Submit"
		submitbtn.TextColor3 = config.colors.text
	end
end)

getkeybtnframe, getkeybtn, getkeyinner = createbutton(contentframe, "Get Key", UDim2.new(0.52, 5, 0, buttony), UDim2.new(0.48, -5, 0, buttonheight), function()
	if setclipboard then
		setclipboard(config.keylink)
		getkeybtn.Text = "Copied!"
		getkeybtn.TextColor3 = Color3.fromRGB(100, 255, 100)
		task.wait(1.5)
		getkeybtn.Text = "Get Key"
		getkeybtn.TextColor3 = config.colors.text
	end
end)

if config.savekey and readfile and isfile then
	local success, savedkey = pcall(function()
		return readfile(config.savefolder .. "/" .. config.savefile)
	end)
	
	if success and savedkey then
		keybox.Text = savedkey
		rememberkey = true
		checkboxfill.BackgroundTransparency = 0
	end
end
