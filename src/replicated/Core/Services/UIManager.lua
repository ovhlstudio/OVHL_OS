--!strict
-- [src/replicated/Core/Services/UIManager.lua]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local UIManager = {}
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local activeTheme: any
local screens = {}
local EventService

function UIManager:Init()
	local Events = ReplicatedStorage:FindFirstChild("OVHL_Events")
	if Events then
		local getThemeFunc: RemoteFunction = Events:WaitForChild("GetActiveTheme", 10)
		if getThemeFunc then
			activeTheme = getThemeFunc:InvokeServer()
		end
	end
	if not activeTheme then
		warn("[UIManager] Gagal load theme dari server, pakai default.")
		activeTheme = {
			Name = "Fallback",
			Colors = {
				Background = Color3.fromRGB(25, 25, 25),
				BackgroundHUD = Color3.fromRGB(10, 10, 10),
				TextPrimary = Color3.fromRGB(250, 250, 250),
				TextSecondary = Color3.fromRGB(180, 180, 180),
				Accent = Color3.fromRGB(50, 150, 255),
				Confirm = Color3.fromRGB(76, 175, 80),
				Decline = Color3.fromRGB(244, 67, 54),
				Surface = Color3.fromRGB(45, 45, 45),
				Border = Color3.fromRGB(60, 60, 60),
				Success = Color3.fromRGB(76, 175, 80),
				Warning = Color3.fromRGB(255, 193, 7),
				Error = Color3.fromRGB(244, 67, 54),
				Primary = Color3.fromRGB(0, 120, 215),
				Secondary = Color3.fromRGB(100, 100, 100),
			},
			Fonts = {
				Header = Enum.Font.GothamBold,
				Body = Enum.Font.Gotham,
			},
			FontSizes = {
				Body = 16,
				Button = 18,
				HUD = 24,
			},
		}
	end
end

function UIManager:CreateScreen(screenName)
	if screens[screenName] then
		return screens[screenName]
	end
	local sg = Instance.new("ScreenGui")
	sg.Name = screenName
	sg.ResetOnSpawn = false
	sg.Parent = playerGui
	screens[screenName] = sg
	return sg
end

function UIManager:CreateWindow(options)
	local frame = Instance.new("Frame")
	frame.Name = options.Name
	frame.Size = options.Size
	frame.Position = options.Position
	frame.AnchorPoint = options.AnchorPoint or Vector2.new(0, 0)
	frame.BorderSizePixel = 0

	if options.Style == "HUD" then
		frame.BackgroundColor3 = activeTheme.Colors.BackgroundHUD
	else
		frame.BackgroundColor3 = activeTheme.Colors.Background
	end

	frame.BackgroundTransparency = options.Transparency or 0.2

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = frame

	frame.Parent = options.Parent
	return frame
end

function UIManager:AddTextLabel(options)
	local label = Instance.new("TextLabel")
	label.Name = options.Name
	label.Text = options.Text
	label.Size = options.Size
	label.Position = options.Position or UDim2.fromScale(0, 0)
	label.AnchorPoint = options.AnchorPoint or Vector2.new(0, 0)
	label.TextXAlignment = options.TextXAlignment or Enum.TextXAlignment.Left
	label.BackgroundTransparency = 1

	if options.Style == "HUD" then
		label.Font = activeTheme.Fonts.Header
		label.TextSize = activeTheme.FontSizes.HUD
	else
		label.Font = activeTheme.Fonts.Body
		label.TextSize = options.TextSize or activeTheme.FontSizes.Body
	end

	label.TextColor3 = options.TextColor or activeTheme.Colors.TextPrimary
	label.Parent = options.Parent
	return label
end

function UIManager:AddButton(options)
	local button = Instance.new("TextButton")
	button.Name = options.Name
	button.Text = options.Text
	button.Size = options.Size
	button.Position = options.Position
	button.AnchorPoint = options.AnchorPoint or Vector2.new(0, 0)

	if options.ColorStyle == "Confirm" then
		button.BackgroundColor3 = activeTheme.Colors.Confirm
	elseif options.ColorStyle == "Decline" then
		button.BackgroundColor3 = activeTheme.Colors.Decline
	else
		button.BackgroundColor3 = options.BackgroundColor or activeTheme.Colors.Accent
	end

	button.Font = activeTheme.Fonts.Body
	button.TextColor3 = activeTheme.Colors.TextPrimary
	button.TextSize = activeTheme.FontSizes.Button

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = button

	button.Parent = options.Parent
	return button
end

function UIManager:AddTextBox(options)
	local textBox = Instance.new("TextBox")
	textBox.Name = options.Name
	textBox.PlaceholderText = options.Placeholder or ""
	textBox.Text = options.Text or ""
	textBox.Size = options.Size
	textBox.Position = options.Position
	textBox.AnchorPoint = options.AnchorPoint or Vector2.new(0, 0)
	textBox.BackgroundColor3 = activeTheme.Colors.Surface
	textBox.TextColor3 = activeTheme.Colors.TextPrimary
	textBox.Font = activeTheme.Fonts.Body
	textBox.TextSize = options.TextSize or activeTheme.FontSizes.Body
	textBox.ClearTextOnFocus = false

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 4)
	corner.Parent = textBox

	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, 8)
	padding.PaddingRight = UDim.new(0, 8)
	padding.Parent = textBox

	textBox.Parent = options.Parent
	return textBox
end

function UIManager:AddImageLabel(options)
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = options.Name
	imageLabel.Image = options.Image
	imageLabel.Size = options.Size
	imageLabel.Position = options.Position or UDim2.fromScale(0, 0)
	imageLabel.AnchorPoint = options.AnchorPoint or Vector2.new(0, 0)
	imageLabel.BackgroundTransparency = 1
	imageLabel.Parent = options.Parent
	return imageLabel
end

function UIManager:ShowToastNotification(message, duration)
	local screen = self:CreateScreen("NotificationUI")
	local toast = self:CreateWindow({
		Parent = screen, -- ← FIX: = instead of :
		Name = "Toast",
		Size = UDim2.new(0.3, 0, 0.1, 0),
		Position = UDim2.new(0.5, 0, -0.1, 0),
		AnchorPoint = Vector2.new(0.5, 0),
		Style = "HUD",
	})

	self:AddTextLabel({
		Parent = toast, -- ← FIX: = instead of :
		Name = "ToastLabel",
		Text = message,
		Size = UDim2.fromScale(1, 1),
		TextXAlignment = Enum.TextXAlignment.Center,
		Style = "HUD",
	})

	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	local goalIn = { Position = UDim2.new(0.5, 0, 0.05, 0) }
	local goalOut = { Position = UDim2.new(0.5, 0, -0.1, 0) }

	TweenService:Create(toast, tweenInfo, goalIn):Play()
	task.wait(duration or 3)
	TweenService:Create(toast, tweenInfo, goalOut):Play()
	task.wait(0.5)
	toast:Destroy()
end

return UIManager
