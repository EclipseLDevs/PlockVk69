if getgenv().Nousigi then 
	if game.CoreGui:FindFirstChild("Nousigi Hub GUI") then
		for i, v in ipairs(game.CoreGui:GetChildren()) do
			if string.find(v.Name,  "Nousigi Hub") then
				v:Destroy()
			end
		end
	end
end
getgenv().Nousigi = true

local DisableAnimation = game.Players.LocalPlayer.PlayerGui:FindFirstChild('TouchGui')
local T1UIColor = {
	["Border Color"] = Color3.fromRGB(60, 0, 100),
	["Click Effect Color"] = Color3.fromRGB(200, 200, 200),
	["Setting Icon Color"] = Color3.fromRGB(200, 200, 200),
	["Logo Image"] = "rbxassetid://133779423735605",
	["Search Icon Color"] = Color3.fromRGB(200, 200, 200),
	["Search Icon Highlight Color"] = Color3.fromRGB(60, 0, 100),
	["GUI Text Color"] = Color3.fromRGB(220, 220, 220),
	["Text Color"] = Color3.fromRGB(220, 220, 220),
	["Placeholder Text Color"] = Color3.fromRGB(110, 110, 110),
	["Title Text Color"] = Color3.fromRGB(190, 130, 255),
	["Background Main Color"] = Color3.fromRGB(0, 0, 0),
	["Background 1 Color"] = Color3.fromRGB(0, 0, 0),
	["Background 1 Transparency"] = 0,
	["Background 2 Color"] = Color3.fromRGB(0, 0, 0),
	["Background 3 Color"] = Color3.fromRGB(0, 0, 0),
	["Background Image"] = "",
	["Page Selected Color"] = Color3.fromRGB(70, 0, 120),
	["Section Text Color"] = Color3.fromRGB(200, 200, 200),
	["Section Underline Color"] = Color3.fromRGB(60, 0, 100),
	["Toggle Border Color"] = Color3.fromRGB(60, 0, 100),
	["Toggle Checked Color"] = Color3.fromRGB(180, 100, 255),
	["Toggle Desc Color"] = Color3.fromRGB(150, 150, 150),
	["Button Color"] = Color3.fromRGB(60, 0, 100),
	["Label Color"] = Color3.fromRGB(0, 0, 0),
	["Dropdown Icon Color"] = Color3.fromRGB(200, 200, 200),
	["Dropdown Selected Color"] = Color3.fromRGB(70, 0, 120),
	["Dropdown Selected Check Color"] = Color3.fromRGB(40, 0, 80),
	["Textbox Highlight Color"] = Color3.fromRGB(60, 0, 100),
	["Box Highlight Color"] = Color3.fromRGB(60, 0, 100),
	["Slider Line Color"] = Color3.fromRGB(60, 0, 100),
	["Slider Highlight Color"] = Color3.fromRGB(40, 0, 80),
	["Tween Animation 1 Speed"] = DisableAnimation and 0 or 0.25,
	["Tween Animation 2 Speed"] = DisableAnimation and 0 or 0.5,
	["Tween Animation 3 Speed"] = DisableAnimation and 0 or 0.1,
	["Text Stroke Transparency"] = 0.5
}

getgenv().UIColor = T1UIColor
getgenv().AllControls = {}
getgenv().UIToggled = true

getgenv().FixLagEnabled = false
task.spawn(function()
	while true do
		task.wait(10)
		if not getgenv().FixLagEnabled then continue end
		pcall(function()
			local lighting = game:GetService("Lighting")
			lighting.GlobalShadows = false
			lighting.FogEnd = 9e9
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("ParticleEmitter") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
					v.Enabled = false
				end
			end
		end)
	end
end)
task.spawn(function()
	game:GetService("RunService").RenderStepped:Connect(function()
		if not getgenv().FixLagEnabled then return end
		pcall(function()
			settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		end)
	end)
end)


local currcolor = {}
local Library = {};
local Library_Function = {}
local TweenService = game:GetService('TweenService')
local uis = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function makeDraggable(topBarObject, object)
	local dragging = nil
	local dragInput = nil
	local dragStart = nil
	local startPosition = nil
	topBarObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPosition = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	topBarObject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	uis.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			if not djtmemay and cac then
				TweenService:Create(object, TweenInfo.new(DisableAnimation and 0 or 0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
					Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
				}):Play()
			elseif not djtmemay and not cac then
				object.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
			end
		end
	end)
end

Library_Function.Gui = Instance.new('ScreenGui')
Library_Function.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.Gui.Name = 'Nousigi Hub GUI'
Library_Function.Gui.Enabled = false

getgenv().ReadyForGuiLoaded = false
task.spawn(function()
	repeat
		task.wait()
	until getgenv().ReadyForGuiLoaded
	if getgenv().UIToggled then
		Library_Function.Gui.Enabled = true
	end
end)


Library_Function.NotiGui = Instance.new('ScreenGui')
Library_Function.NotiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.NotiGui.Name = 'Nousigi Hub Notification'

Library_Function.HideGui = Instance.new('ScreenGui')
Library_Function.HideGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.HideGui.Name = 'Nousigi Hub Btn'


local btnHide = Instance.new('ImageButton', Library_Function.HideGui)
btnHide.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
btnHide.BackgroundTransparency = 0
btnHide.AnchorPoint = Vector2.new(0, 1)
btnHide.Size = UDim2.new(0, 60, 0, 60)
btnHide.Position = UDim2.new(0, 15, 1, -15)
btnHide.Image = "rbxassetid://117697087203604"
btnHide.ScaleType = Enum.ScaleType.Fit
btnHide.ImageColor3 = Color3.fromRGB(255, 255, 255)
btnHide.ClipsDescendants = true

local UICornerBtnHide = Instance.new("UICorner")
UICornerBtnHide.Parent = btnHide
UICornerBtnHide.CornerRadius = UDim.new(1, 0)

local btnStroke = Instance.new("UIStroke")
btnStroke.Parent = btnHide
btnStroke.Color = Color3.fromRGB(60, 0, 100)
btnStroke.Thickness = 2

local btnHideFrame = Instance.new('Frame', btnHide)
btnHideFrame.AnchorPoint = Vector2.new(0, 1)
btnHideFrame.Size = UDim2.new(0, 0, 0, 0)
btnHideFrame.Position = UDim2.new(0, 0, 1, 0)
btnHideFrame.Name = "dut dit"
btnHideFrame.BackgroundTransparency = 1

local imgHide = Instance.new('ImageLabel', btnHide)
imgHide.AnchorPoint = Vector2.new(0.5, 0.5)
imgHide.Image = ""
imgHide.BackgroundTransparency = 1
imgHide.Size = UDim2.new(0, 0, 0, 0)
imgHide.Position = UDim2.new(0.5, 0, 0.5, 0)

Library.ToggleUI = function()
	getgenv().UIToggled = not getgenv().UIToggled
	if game.CoreGui:FindFirstChild("Nousigi Hub GUI") then
		for a, b in ipairs(game.CoreGui:GetChildren()) do
			if b.Name == "Nousigi Hub GUI" then
				b.Enabled = getgenv().UIToggled
			end
		end
	end
end

Library.DestroyUI = function()
	if game.CoreGui:FindFirstChild("Nousigi Hub GUI") then
		for i, v in ipairs(game.CoreGui:GetChildren()) do
			if string.find(v.Name, "Nousigi Hub") then
				v:Destroy()
			end
		end
	end
end

Library.DestroyUI = function()
	if game.CoreGui:FindFirstChild("Nousigi Hub GUI") then
		for i, v in ipairs(game.CoreGui:GetChildren()) do
			if string.find(v.Name,  "Nousigi Hub") then
				v:Destroy()
			end
		end
	end
end

if true then
	local button = btnHide
	local UIS = game:GetService("UserInputService")
	
	local dragging = false
	local dragInput, dragStart, startPos
	local holdTime = 0.1
	local holdStarted = 0
	
	local function update(input)
		local delta = input.Position - dragStart
		button.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
	
	local function onInputBegan(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			holdStarted = tick()
			dragStart = input.Position
			startPos = button.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					holdStarted = 0
				end
			end)
		end
	end
	
	local function onInputEnded(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			holdStarted = 0
		end
	end
	
	local function onInputChanged(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end
	
	button.InputBegan:Connect(onInputBegan)
	button.InputEnded:Connect(onInputEnded)
	button.InputChanged:Connect(onInputChanged)
	
	RunService.RenderStepped:Connect(function()
		if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
			dragging = true
		end
	
		if dragging and dragInput then
			update(dragInput)
		end
	end)
		
end

btnHide.MouseButton1Click:Connect(function() 
	Library.ToggleUI()
end)

local NotiContainer = Instance.new("Frame")
local NotiList = Instance.new("UIListLayout")

NotiContainer.Name = "NotiContainer"
NotiContainer.Parent = Library_Function.NotiGui
NotiContainer.AnchorPoint = Vector2.new(1, 1)
NotiContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
NotiContainer.BackgroundTransparency = 1.000
NotiContainer.Position = UDim2.new(1, -5, 1, -5)
NotiContainer.Size = UDim2.new(0, 350, 1, -10)

NotiList.Name = "NotiList"
NotiList.Parent = NotiContainer
NotiList.SortOrder = Enum.SortOrder.LayoutOrder
NotiList.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotiList.Padding = UDim.new(0, 5)


Library_Function.Gui.Parent = game:GetService('CoreGui')
Library_Function.NotiGui.Parent = game:GetService('CoreGui')
Library_Function.HideGui.Parent = game:GetService('CoreGui')

function Library_Function.Getcolor(color)
	return {
		math.floor(color.r * 255),
		math.floor(color.g * 255),
		math.floor(color.b * 255)
	}
end

local libCreateNoti = function(Setting)
	getgenv().TitleNameNoti = Setting.Title or ""; 
	local Description = Setting.Description or Setting.Desc or Setting.Content or ""; 
	local Duration = Setting.Duration or Setting.Timeshow or Setting.Delay or 10;

	local NotiFrame = Instance.new("Frame")
	local Noticontainer = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Topnoti = Instance.new("Frame")
	local Ruafimg = Instance.new("ImageLabel")
	local RuafimgCorner = Instance.new("UICorner")
	local TextLabelNoti = Instance.new("TextLabel")
	local CloseContainer = Instance.new("Frame")
	local CloseImage = Instance.new("ImageLabel")
	local TextButton = Instance.new("TextButton")
	local TextLabelNoti2 = Instance.new("TextLabel")

	NotiFrame.Name = "NotiFrame"
	NotiFrame.Parent = NotiContainer
	NotiFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	NotiFrame.BackgroundTransparency = 1.000
	NotiFrame.ClipsDescendants = true
	NotiFrame.Position = UDim2.new(0, 0, 0, 0)
	NotiFrame.Size = UDim2.new(1, 0, 0, 0)
	NotiFrame.AutomaticSize = Enum.AutomaticSize.Y

	Noticontainer.Name = "Noticontainer"
	Noticontainer.Parent = NotiFrame
	Noticontainer.Position = UDim2.new(1, 0, 0, 0)
	Noticontainer.Size = UDim2.new(1, 0, 1, 6)
	Noticontainer.AutomaticSize = Enum.AutomaticSize.Y
	Noticontainer.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = Noticontainer

	Topnoti.Name = "Topnoti"
	Topnoti.Parent = Noticontainer
	Topnoti.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	Topnoti.BackgroundTransparency = 1.000
	Topnoti.Position = UDim2.new(0, 0, 0, 5)
	Topnoti.Size = UDim2.new(1, 0, 0, 25)

	Ruafimg.Name = "Ruafimg"
	Ruafimg.Parent = Topnoti
	Ruafimg.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	Ruafimg.BackgroundTransparency = 1.000
	Ruafimg.Position = UDim2.new(0, 5, 0, getgenv().T1 and 5 or 0)
	Ruafimg.Size = UDim2.new(0, getgenv().T1 and 30 or 25, 0, getgenv().T1 and 15 or 25)
	Ruafimg.Image = getgenv().UIColor["Logo Image"]

	RuafimgCorner.CornerRadius = UDim.new(1, 0)
	RuafimgCorner.Name = "RuafimgCorner"
	RuafimgCorner.Parent = Ruafimg
	
	local colorR = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[1])
	local colorG = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[2])
	local colorB = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[3])
	local color = colorR .. ',' .. colorG .. ',' .. colorB
    TextLabelNoti.Text = tostring(getgenv().TitleNameNoti or "")
    
	TextLabelNoti.Name = "TextLabelNoti"
	TextLabelNoti.Parent = Topnoti
	TextLabelNoti.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextLabelNoti.BackgroundTransparency = 1.000
	TextLabelNoti.Position = UDim2.new(0, getgenv().T1 and 40 or 35, 0, 0)
	TextLabelNoti.Size = UDim2.new(1, getgenv().T1 and -40 or -35, 1, 0)
	TextLabelNoti.Font = Enum.Font.GothamBold
	TextLabelNoti.TextSize = 14.000
	TextLabelNoti.TextWrapped = true
	TextLabelNoti.TextXAlignment = Enum.TextXAlignment.Left
	TextLabelNoti.RichText = true
	TextLabelNoti.TextColor3 = getgenv().UIColor["GUI Text Color"]

	CloseContainer.Name = "CloseContainer"
	CloseContainer.Parent = Topnoti
	CloseContainer.AnchorPoint = Vector2.new(1, 0.5)
	CloseContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	CloseContainer.BackgroundTransparency = 1.000
	CloseContainer.Position = UDim2.new(1, -4, 0.5, 0)
	CloseContainer.Size = UDim2.new(0, 22, 0, 22)

	CloseImage.Name = "CloseImage"
	CloseImage.Parent = CloseContainer
	CloseImage.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	CloseImage.BackgroundTransparency = 1.000
	CloseImage.Size = UDim2.new(1, 0, 1, 0)
	CloseImage.Image = "rbxassetid://3926305904"
	CloseImage.ImageRectOffset = Vector2.new(284, 4)
	CloseImage.ImageRectSize = Vector2.new(24, 24)
	CloseImage.ImageColor3 = getgenv().UIColor["Search Icon Color"]

	TextButton.Parent = CloseContainer
	TextButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextButton.BackgroundTransparency = 1.000
	TextButton.Size = UDim2.new(1, 0, 1, 0)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.Text = ""
	TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.TextSize = 14.000

	if Description then
		TextLabelNoti2.Name = 'TextColor'
		TextLabelNoti2.Parent = Noticontainer
		TextLabelNoti2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TextLabelNoti2.BackgroundTransparency = 1.000
		TextLabelNoti2.Position = UDim2.new(0, 10, 0, 35)
		TextLabelNoti2.Size = UDim2.new(1, -15, 0, 0)
		TextLabelNoti2.Font = Enum.Font.GothamBold
		TextLabelNoti2.Text = Description
		TextLabelNoti2.TextSize = 14.000
		TextLabelNoti2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabelNoti2.RichText = true
		TextLabelNoti2.TextColor3 = getgenv().UIColor["Text Color"]
		TextLabelNoti2.AutomaticSize = Enum.AutomaticSize.Y
		TextLabelNoti2.TextWrapped = true
	end

	local function remove()
		TweenService:Create(Noticontainer, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			Position = UDim2.new(1, 0, 0, 0)
		}):Play()
		task.wait(0.25)
		NotiFrame:Destroy()
	end

	TweenService:Create(Noticontainer, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
		Position = UDim2.new(0, 0, 0, 0)
	}):Play()

	TextButton.MouseEnter:Connect(function()
		TweenService:Create(CloseImage, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]
		}):Play()
	end)

	TextButton.MouseLeave:Connect(function()
		TweenService:Create(CloseImage, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			ImageColor3 = getgenv().UIColor["Search Icon Color"]
		}):Play()
	end)

	TextButton.MouseButton1Click:Connect(function()
		task.wait(0.25)
		remove()
	end)

	task.spawn(function()
		task.wait(Duration)
		remove()
	end)

end

function Library:Notify(Setting, bypass)
	if not getgenv().Config or bypass then
		local s, e = pcall(function()
			libCreateNoti(Setting)
		end)
		if e then
			print(e)
		end
	end
end

function Library:CreateWindow(Setting)
    local TitleNameMain = Setting.Title or "Banana Cat Hub"
    getgenv().MainDesc = Setting.Desc or Setting.Subtitle or ""
    
    if Setting.Image then
        getgenv().UIColor["Logo Image"] = Setting.Image
    end
    
	local djtmemay = false
	cac = false

	local Main = Instance.new("Frame")
	local maingui = Instance.new("ImageLabel")
	local MainCorner = Instance.new("UICorner")
	local TopMain = Instance.new("Frame")
	local Ruafimg = Instance.new("ImageLabel")
	local TextLabelMain = Instance.new("TextLabel")
	local PageControl = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local ControlList = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local ControlTitle = Instance.new("TextLabel")
	local MainPage = Instance.new("Frame")
	local UIPage = Instance.new("UIPageLayout")
	local Concacontainer = Instance.new("Frame")
	local Concacmain = Instance.new("Frame")
	local MainContainer

	Main.Name = "Main"
	Main.Parent = Library_Function.Gui
	Main.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
	Main.BackgroundTransparency = 1.000
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.Size = UDim2.new(0, 629, 0, 359)

	makeDraggable(Main, Main)

	maingui.Name = "maingui"
	maingui.Parent = Main
	maingui.AnchorPoint = Vector2.new(0.5, 0.5)
	maingui.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	maingui.BackgroundTransparency = 1.000
	maingui.Position = UDim2.new(0.5, 0, 0.5, 0)
	maingui.Selectable = true
	maingui.Size = UDim2.new(1, 30, 1, 30)
	maingui.Image = "rbxassetid://8068653048"
	maingui.ScaleType = Enum.ScaleType.Slice
	maingui.SliceCenter = Rect.new(15, 15, 175, 175)
	maingui.SliceScale = 1.300
	maingui.ImageColor3 = getgenv().UIColor["Border Color"]
	maingui.ImageTransparency = 1

	maingui.ImageColor3 = getgenv().UIColor['Title Text Color']

	MainContainer = Instance.new("ImageLabel")
	MainContainer.Name = "MainContainer"
	MainContainer.Parent = Main
	MainContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MainContainer.Size = UDim2.new(1, 0, 1, 0)

	local uistr = Instance.new("UIStroke", MainContainer);
	uistr.Thickness = 1;
	uistr.Color = Color3.fromRGB(60, 0, 100);


	getgenv().ReadyForGuiLoaded = true
	
	MainCorner.CornerRadius = UDim.new(0, 5)
	MainCorner.Name = "MainCorner"
	MainCorner.Parent = MainContainer

	Concacontainer.Name = "Concacontainer"
	Concacontainer.Parent = MainContainer
	Concacontainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Concacontainer.BackgroundTransparency = 1.000
	Concacontainer.ClipsDescendants = true
	Concacontainer.Position = UDim2.new(0, 0, 0, 30)
	Concacontainer.Size = UDim2.new(1, 0, 1, -30)
	
	Concacmain.Name = "Concacmain"
	Concacmain.Parent = Concacontainer
	Concacmain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Concacmain.BackgroundTransparency = 1.000
	Concacmain.Selectable = true
	Concacmain.Size = UDim2.new(1, 0, 1, 0)
	
	TopMain.Name = "TopMain"
	TopMain.Parent = MainContainer
	TopMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TopMain.BackgroundTransparency = 1.000
	TopMain.Size = UDim2.new(1, 0, 0, 25)
	
	local TopStroke = Instance.new("Frame", TopMain)
	TopStroke.Name = "TopStroke"
	TopStroke.BackgroundColor3 = Color3.fromRGB(60, 0, 100)
	TopStroke.BackgroundTransparency = 0.6
	TopStroke.BorderSizePixel = 0
	TopStroke.Position = UDim2.new(0, 0, 1, -1)
	TopStroke.Size = UDim2.new(1, 0, 0, 1)
	
	Ruafimg.Name = "Ruafimg"
	Ruafimg.Parent = TopMain
	Ruafimg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Ruafimg.BackgroundTransparency = 1.000
	Ruafimg.Position = UDim2.new(0, 5, 0, 0)
	Ruafimg.Size = UDim2.new(0, 25, 0, 25)
	Ruafimg.Image = getgenv().UIColor["Logo Image"]

	TextLabelMain.Name = "TextLabelMain"
	TextLabelMain.Parent = TopMain
	TextLabelMain.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextLabelMain.BackgroundTransparency = 1.000
	TextLabelMain.Position = UDim2.new(0, 35, 0, 0)
	TextLabelMain.Size = UDim2.new(1, -35, 1, 0)
	TextLabelMain.Font = Enum.Font.GothamBold
	TextLabelMain.RichText = true
	TextLabelMain.TextSize = 16.000
	TextLabelMain.TextWrapped = true
	TextLabelMain.TextXAlignment = Enum.TextXAlignment.Left
	TextLabelMain.TextColor3 = getgenv().UIColor["GUI Text Color"]

	local colorR = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[1])
	local colorG = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[2])
	local colorB = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[3])
	local color = colorR .. ',' .. colorG .. ',' .. colorB
    TextLabelMain.Text = tostring(TitleNameMain or "TRon Void Hub - Blox Fruit")
	TextLabelMain.TextColor3 = Color3.fromRGB(190, 50, 255)
	TextLabelMain.TextStrokeTransparency = 0.3
	TextLabelMain.TextStrokeColor3 = Color3.fromRGB(140, 0, 255)

	PageControl.Name = "Background1"
	PageControl.Parent = Concacmain
	PageControl.Position = UDim2.new(0, 5, 0, 0)
	PageControl.Size = UDim2.new(0, 180, 0, 325)
	PageControl.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	PageControl.BackgroundTransparency = 0

	local pageControlStroke = Instance.new("UIStroke", PageControl)
	pageControlStroke.Color = Color3.fromRGB(60, 0, 100)
	pageControlStroke.Thickness = 1


	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = PageControl

	ControlList.Name = "ControlList"
	ControlList.Parent = PageControl
	ControlList.Active = true
	ControlList.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	ControlList.BackgroundTransparency = 1.000
	ControlList.BorderColor3 = Color3.fromRGB(27, 42, 53)
	ControlList.BorderSizePixel = 0
	ControlList.Position = UDim2.new(0, 0, 0, 30)
	ControlList.Size = UDim2.new(1, -5, 1, -30)
	ControlList.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	ControlList.CanvasSize = UDim2.new(0, 0, 0, 0)
	ControlList.ScrollBarThickness = 5
	ControlList.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"

	UIListLayout.Parent = ControlList
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	ControlTitle.Name = "GUITextColor"
	ControlTitle.Parent = PageControl
	ControlTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	ControlTitle.BackgroundTransparency = 1.000
	ControlTitle.Position = UDim2.new(0, 5, 0, 0)
	ControlTitle.Size = UDim2.new(1, 0, 0, 25)
	ControlTitle.Font = Enum.Font.GothamBold
	ControlTitle.Text = TitleNameMain
	ControlTitle.TextSize = 14.000
	ControlTitle.TextXAlignment = Enum.TextXAlignment.Left
	ControlTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]

	local PageSearch = Instance.new("Frame")
	local PageSearchCorner = Instance.new("UICorner")
	local SearchFrame = Instance.new("Frame")
	local SearchIcon = Instance.new("ImageLabel")
	local SearchBox = Instance.new("TextBox")

	PageSearch.Name = "PageSearch"
	PageSearch.Parent = PageControl
	PageSearch.AnchorPoint = Vector2.new(1, 0)
	PageSearch.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	PageSearch.Position = UDim2.new(1, -5, 0, 5)
	PageSearch.Size = UDim2.new(0, 170, 0, 25)
	PageSearch.ClipsDescendants = true

	PageSearchCorner.Parent = PageSearch
	PageSearchCorner.CornerRadius = UDim.new(0, 4)

	SearchFrame.Name = "SearchFrame"
	SearchFrame.Parent = PageSearch
	SearchFrame.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	SearchFrame.BackgroundTransparency = 1
	SearchFrame.Size = UDim2.new(0, 25, 1, 0)

	SearchIcon.Name = "SearchIcon"
	SearchIcon.Parent = SearchFrame
	SearchIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	SearchIcon.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	SearchIcon.BackgroundTransparency = 1
	SearchIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
	SearchIcon.Size = UDim2.new(0, 16, 0, 16)
	SearchIcon.Image = "rbxassetid://8154282545"
	SearchIcon.ImageColor3 = Color3.fromRGB(240, 240, 230)

    SearchBox.Name = "SearchBox"
    SearchBox.Parent = PageSearch
    SearchBox.Active = true
    SearchBox.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
    SearchBox.BackgroundTransparency = 1
    SearchBox.CursorPosition = -1
    SearchBox.Position = UDim2.new(0, 30, 0, 0)
    SearchBox.Size = UDim2.new(1, -30, 1, 0)
    SearchBox.Font = Enum.Font.GothamBold
    SearchBox.PlaceholderColor3 = Color3.fromRGB(170, 170, 160)
    SearchBox.PlaceholderText = "Search section or Function..."
    SearchBox.Text = ""
    SearchBox.TextColor3 = Color3.fromRGB(235, 235, 230)
    SearchBox.TextSize = 14
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left

	MainPage.Name = "MainPage"
	MainPage.Parent = Concacmain
	MainPage.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	MainPage.BackgroundTransparency = 1.000
	MainPage.ClipsDescendants = true
	MainPage.Position = UDim2.new(0, 190, 0, 0)
	MainPage.Size = UDim2.new(1, -195, 1, 0)

	UIPage.Name = "UIPage"
	UIPage.Parent = MainPage
	UIPage.FillDirection = Enum.FillDirection.Vertical
	UIPage.SortOrder = Enum.SortOrder.LayoutOrder
	UIPage.EasingDirection = Enum.EasingDirection.InOut
	UIPage.EasingStyle = Enum.EasingStyle.Quart
	UIPage.Padding = UDim.new(0, 10)
	UIPage.TweenTime = getgenv().UIColor["Tween Animation 1 Speed"]

	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ControlList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
	end)

	local Shadow = Instance.new("ImageLabel", Main)
	Shadow.Name = "Shadow"
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	Shadow.BackgroundTransparency = 1
	Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadow.Size = UDim2.new(1, 40, 1, 40)
	Shadow.ZIndex = 0
	Shadow.Image = "rbxassetid://5028857084"
	Shadow.ImageTransparency = 0.35
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(24, 24, 276, 276)

    local sectionInfo = {}
    
    if not GlobalSearch then
        GlobalSearch = function(searchText)
            searchText = string.lower(searchText)
            
            if searchText == "" then
                for _, control in pairs(getgenv().AllControls) do
                    control.TabButton.Visible = true
                    control.Section.Visible = true
                    control.Element.Visible = true
                end
                for _, tab in pairs(ControlList:GetChildren()) do
                    if not tab:IsA('UIListLayout') then
                        tab.Visible = true
                    end
                end
                return
            end
            
            for _, control in pairs(getgenv().AllControls) do
                control.Section.Visible = false
                control.Element.Visible = false
            end
            
            for _, tab in pairs(ControlList:GetChildren()) do
                if not tab:IsA('UIListLayout') then
                    tab.Visible = false
                end
            end
            
            local sectionsWithElements = {}
            local elementsInSection = {}
            
            for _, control in pairs(getgenv().AllControls) do
                local elementName = string.lower(control.Name or "")
                local sectionName = string.lower(control.SectionName or "")
                
                local elementFound = string.find(elementName, searchText, 1, true) ~= nil
                local sectionFound = string.find(sectionName, searchText, 1, true) ~= nil
                
                if not elementsInSection[control.Section] then
                    elementsInSection[control.Section] = {}
                end
                table.insert(elementsInSection[control.Section], {
                    control = control,
                    elementFound = elementFound,
                    sectionFound = sectionFound
                })
                
                if elementFound then
                    sectionsWithElements[control.Section] = true
                end
            end
            
            local foundTabs = {}
            
            for section, elements in pairs(elementsInSection) do
                local shouldShowSection = false
                local hasElementMatch = false
                
                for _, elementInfo in ipairs(elements) do
                    if elementInfo.sectionFound then
                        shouldShowSection = true
                    end
                    if elementInfo.elementFound then
                        hasElementMatch = true
                    end
                end
                
                for _, elementInfo in ipairs(elements) do
                    local control = elementInfo.control
                    
                    if elementInfo.elementFound then
                        control.Element.Visible = true
                        
                        if elementInfo.sectionFound or hasElementMatch then
                            control.Section.Visible = true
                        end
                        
                        foundTabs[control.TabName] = true
                        control.TabButton.Visible = true
                    elseif elementInfo.sectionFound and not hasElementMatch then
                        control.Section.Visible = true
                        control.Element.Visible = false
                        
                        foundTabs[control.TabName] = true
                        control.TabButton.Visible = true
                    end
                end
            end
            
            for tabName, _ in pairs(foundTabs) do
                for _, tab in pairs(ControlList:GetChildren()) do
                    if not tab:IsA('UIListLayout') and string.find(tab.Name, tabName, 1, true) then
                        tab.Visible = true
                    end
                end
            end
            
            if not next(foundTabs) then
            end
        end
    end
    
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        GlobalSearch(SearchBox.Text)
    end)

	local Main_Function = {}

	local LayoutOrderBut = -1
	local LayoutOrder = -1
	local PageCounter = 1

	function Main_Function:AddTab(PageName)

		local Page_Name = tostring(PageName)
		local Page_Title = Page_Name

		LayoutOrder = LayoutOrder + 1
		LayoutOrderBut = LayoutOrderBut + 1

		local PageName = Instance.new("Frame")
		local Frame = Instance.new("Frame")
		local TabNameCorner = Instance.new("UICorner")
		local Line = Instance.new("Frame")
		local InLine = Instance.new("Frame")
		local LineCorner = Instance.new("UICorner")
		local TabTitleContainer = Instance.new("Frame")
		local TabTitle = Instance.new("TextLabel")
		local PageButton = Instance.new("TextButton")


		PageName.Name = Page_Name .. "_Control"
		PageName.Parent = ControlList
		PageName.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageName.BackgroundTransparency = 1.000
		PageName.Size = UDim2.new(1, -10, 0, 25)
		PageName.LayoutOrder = LayoutOrderBut

		Frame.Parent = PageName
		Frame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		Frame.BackgroundTransparency = 1.000
		Frame.Position = UDim2.new(0, 5, 0, 0)
		Frame.Size = UDim2.new(1, -5, 1, 0)

		TabNameCorner.CornerRadius = UDim.new(0, 4)
		TabNameCorner.Name = "TabNameCorner"
		TabNameCorner.Parent = Frame

		Line.Name = "Line"
		Line.Parent = Frame
		Line.AnchorPoint = Vector2.new(0, 0.5)
		Line.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		Line.BackgroundTransparency = 1.000
		Line.Position = UDim2.new(0, 0, 0.5, 0)
		Line.Size = UDim2.new(0, 14, 1, 0)

		InLine.Name = "PageInLine"
		InLine.Parent = Line
		InLine.AnchorPoint = Vector2.new(0.5, 0.5)
		InLine.BorderSizePixel = 0
		InLine.Position = UDim2.new(0.5, 0, 0.5, 0)
		InLine.Size = UDim2.new(1, -10, 1, -10)
		InLine.BackgroundColor3 = getgenv().UIColor["Page Selected Color"]
		InLine.BackgroundTransparency = 1.000

		LineCorner.Name = "LineCorner"
		LineCorner.Parent = InLine

		TabTitleContainer.Name = "TabTitleContainer"
		TabTitleContainer.Parent = Frame
		TabTitleContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TabTitleContainer.BackgroundTransparency = 1.000
		TabTitleContainer.Position = UDim2.new(0, 15, 0, 0)
		TabTitleContainer.Size = UDim2.new(1, -15, 1, 0)

		TabTitle.Name = "GUITextColor"
		TabTitle.Parent = TabTitleContainer
		TabTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TabTitle.BackgroundTransparency = 1.000
		TabTitle.Size = UDim2.new(1, 0, 1, 0)
		TabTitle.Font = Enum.Font.GothamBold
		TabTitle.Text = Page_Name
		TabTitle.TextColor3 = Color3.fromRGB(230, 230, 230)
		TabTitle.TextSize = 14.000
		TabTitle.TextXAlignment = Enum.TextXAlignment.Left
		TabTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]

		PageButton.Name = "PageButton"
		PageButton.Parent = PageName
		PageButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageButton.BackgroundTransparency = 1.000
		PageButton.Size = UDim2.new(1, 0, 1, 0)
		PageButton.Font = Enum.Font.SourceSans
		PageButton.Text = ""
		PageButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		PageButton.TextSize = 14.000


		local PageContainer = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local PageTitle = Instance.new("TextLabel")
		local PageList = Instance.new("ScrollingFrame")
		local Pagelistlayout = Instance.new("UIListLayout")

		local CurrentPage = PageCounter
		PageCounter = PageCounter + 1
		PageContainer.Name = "Page" .. CurrentPage
		PageContainer.Parent = MainPage
		PageContainer.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
		PageContainer.Position = UDim2.new(0, 0, 0, 0)
		PageContainer.Size = UDim2.new(1, 0, 1, 0)
		PageContainer.LayoutOrder = LayoutOrder
		PageContainer.BackgroundTransparency = 0

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = PageContainer

		PageTitle.Name = "GUITextColor"
		PageTitle.Parent = PageContainer
		PageTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageTitle.BackgroundTransparency = 1.000
		PageTitle.Position = UDim2.new(0, 5, 0, 0)
		PageTitle.Size = UDim2.new(1, 0, 0, 25)
		PageTitle.Font = Enum.Font.GothamBold
		PageTitle.Text = Page_Title
		PageTitle.TextSize = 16.000
		PageTitle.TextXAlignment = Enum.TextXAlignment.Left
		PageTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]

		PageList.Name = "PageList"
		PageList.Parent = PageContainer
		PageList.Active = true
		PageList.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageList.BackgroundTransparency = 1.000
		PageList.BorderColor3 = Color3.fromRGB(27, 42, 53)
		PageList.BorderSizePixel = 0
		PageList.Position = UDim2.new(0, 5, 0, 30)
		PageList.Size = UDim2.new(1, -10, 1, -30)
		PageList.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		PageList.ScrollBarThickness = 5
		PageList.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		PageList.ScrollingEnabled = true
		PageList.VerticalScrollBarInset = Enum.ScrollBarInset.Always

		Pagelistlayout.Name = "Pagelistlayout"
		Pagelistlayout.Parent = PageList
		Pagelistlayout.SortOrder = Enum.SortOrder.LayoutOrder
		Pagelistlayout.Padding = UDim.new(0, 5)
		Pagelistlayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			PageList.CanvasSize = UDim2.new(0, 0, 0, Pagelistlayout.AbsoluteContentSize.Y)
		end)

		local PageSearch = Instance.new("Frame")
		local PageSearchCorner = Instance.new("UICorner")
		local SearchFrame = Instance.new("Frame")
		local SearchIcon = Instance.new("ImageLabel")
		local SearchButton = Instance.new("TextButton")
		local SearchBox = Instance.new("TextBox")

		PageSearch.Name = "Page Search"
		PageSearch.Parent = PageContainer
		PageSearch.AnchorPoint = Vector2.new(1, 0)
		PageSearch.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
		PageSearch.Position = UDim2.new(1, -5, 0, 5)
		PageSearch.Size = UDim2.new(0, 20, 0, 20)
		PageSearch.ClipsDescendants = true

		PageSearchCorner.CornerRadius = UDim.new(0, 2)
		PageSearchCorner.Name = "PageSearchCorner"
		PageSearchCorner.Parent = PageSearch

		SearchFrame.Name = "SearchFrame"
		SearchFrame.Parent = PageSearch
		SearchFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchFrame.BackgroundTransparency = 1.000
		SearchFrame.Size = UDim2.new(0, 20, 0, 20)

		SearchIcon.Name = "SearchIcon"
		SearchIcon.Parent = SearchFrame
		SearchIcon.AnchorPoint = Vector2.new(0.5, 0.5)
		SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchIcon.BackgroundTransparency = 1.000
		SearchIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
		SearchIcon.Size = UDim2.new(0, 16, 0, 16)
		SearchIcon.Image = "rbxassetid://8154282545"
		SearchIcon.ImageColor3 = getgenv().UIColor["Search Icon Color"]

		SearchButton.Name = "Search Button"
		SearchButton.Parent = SearchFrame
		SearchButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchButton.BackgroundTransparency = 1.000
		SearchButton.Size = UDim2.new(1, 0, 1, 0)
		SearchButton.Font = Enum.Font.SourceSans
		SearchButton.Text = ""
		SearchButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		SearchButton.TextSize = 14.000

		SearchBox.Name = "Search Box"
		SearchBox.Parent = PageSearch
		SearchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchBox.BackgroundTransparency = 1.000
		SearchBox.Position = UDim2.new(0, 30, 0, 0)
		SearchBox.Size = UDim2.new(1, -30, 1, 0)
		SearchBox.Font = Enum.Font.GothamBold
		SearchBox.Text = ""
		SearchBox.TextSize = 14.000
		SearchBox.TextXAlignment = Enum.TextXAlignment.Left
		SearchBox.PlaceholderText = "Search Section name"
		SearchBox.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
		SearchBox.TextColor3 = getgenv().UIColor["Text Color"]
		
		local Openned = false 

		SearchButton.MouseEnter:Connect(function()
			TweenService:Create(SearchIcon, TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]), {
				ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]
			}):Play()
		end)

		SearchButton.MouseLeave:Connect(function()
			TweenService:Create(SearchIcon, TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]), {
				ImageColor3 = getgenv().UIColor["Search Icon Color"]
			}):Play()
		end)

		SearchButton.MouseButton1Click:Connect(function()
			Openned = not Openned
			local size = Openned and UDim2.new(0, 175, 0, 20) or  UDim2.new(0, 20, 0, 20)
			game.TweenService:Create(PageSearch, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
				Size = size
			}):Play()
		end)

		local function hideOtherFrame()
			for i, v in next, PageList:GetChildren() do 
				if not v:IsA('UIListLayout') then 
					v.Visible = false
				end
			end
		end
		
		local function showFrameName()
			for i, v in pairs(PageList:GetChildren()) do
				if not v:IsA('UIListLayout') then 
					if string.find(string.lower(v.Name), string.lower(SearchBox.Text)) then 
						v.Visible = true
					end
				end
			end
		end
		
		SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
			hideOtherFrame()
			showFrameName()
		end)

		for i, v in pairs(ControlList:GetChildren()) do
			if not (v:IsA('UIListLayout')) then
				if i == 2 then 
					v.Frame.Line.PageInLine.BackgroundTransparency = 0
				end
			end
		end

		PageButton.MouseButton1Click:Connect(function()
			if tostring(UIPage.CurrentPage) == PageContainer.Name then 
				return
			end

			for i, v in pairs(MainPage:GetChildren()) do
				if not (v:IsA('UIPageLayout')) and not (v:IsA('UICorner')) then
					v.Visible = false
				end
			end

			PageContainer.Visible = true 
			UIPage:JumpTo(PageContainer)

			for i, v in next, ControlList:GetChildren() do
				if not (v:IsA('UIListLayout')) then
					if v.Name == Page_Name .. "_Control" then 
						TweenService:Create(v.Frame.Line.PageInLine, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							BackgroundTransparency = 0
						}):Play()
					else
						TweenService:Create(v.Frame.Line.PageInLine, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							BackgroundTransparency = 1
						}):Play()
					end
				end
			end
		end)

		local pageFunction = {}

		function pageFunction:AddSection(Section_Name, Toggleable, SectionGap, SectionColor)
			local Toggleable = Toggleable or false
			local Section = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Topsec = Instance.new("Frame")
			local Sectiontitle = Instance.new("TextLabel")
			local Linesec = Instance.new("Frame")
			local UIGradient = Instance.new("UIGradient")
			local SectionList = Instance.new("UIListLayout")
			
			Section.Name = Section_Name .. "_Dot"
			Section.Parent = PageList
			Section.Size = UDim2.new(1, -5, 0, 35)
			Section.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			Section.BackgroundTransparency = 0
			Section.ClipsDescendants = false

			local sectionStroke = Instance.new("UIStroke", Section)
			sectionStroke.Color = Color3.fromRGB(90, 0, 160)
			sectionStroke.Thickness = 1


			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Section

			Topsec.Name = "Topsec"
			Topsec.Parent = Section
			Topsec.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			Topsec.BackgroundTransparency = 1.000
			Topsec.Size = UDim2.new(1, 0, 0, 30)

			Sectiontitle.Name = "Sectiontitle"
			Sectiontitle.Parent = Topsec
			Sectiontitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			Sectiontitle.BackgroundTransparency = 1.000
			Sectiontitle.Size = UDim2.new(1, 0, 1, 0)
			Sectiontitle.Font = Enum.Font.GothamBold
			Sectiontitle.Text = Section_Name
			Sectiontitle.TextSize = 14.000
			Sectiontitle.TextColor3 = getgenv().UIColor["Section Text Color"]

			Linesec.Name = "Linesec"
			Linesec.Parent = Topsec
			Linesec.AnchorPoint = Vector2.new(0.5, 1)
			Linesec.BorderSizePixel = 0
			Linesec.Position = UDim2.new(0.5, 0, 1, -2)
			Linesec.Size = UDim2.new(1, -10, 0, 2)
			Linesec.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]

			local LineShadow = Instance.new("ImageLabel", Linesec)
			LineShadow.Name = "LineShadow"
			LineShadow.AnchorPoint = Vector2.new(0.5, 0.5)
			LineShadow.BackgroundColor3 = Color3.fromRGB(163,162,165)
			LineShadow.BackgroundTransparency = 1
			LineShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
			LineShadow.Size = UDim2.new(1, 8, 1, 8)
			LineShadow.ZIndex = 0
			LineShadow.Image = "rbxassetid://5028857084"
			LineShadow.ImageTransparency = 0.6
			LineShadow.ScaleType = Enum.ScaleType.Slice
			LineShadow.SliceCenter = Rect.new(24, 24, 276, 276)

			UIGradient.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(0.51, 0.02),
				NumberSequenceKeypoint.new(1, 1)
			}
			UIGradient.Parent = Linesec

			SectionList.Name = "SectionList"
			SectionList.Parent = Section
			SectionList.SortOrder = Enum.SortOrder.LayoutOrder
			SectionList.Padding = UDim.new(0, 5)

			local SizeSectionY
			local sectionIsVisible = false
			if Toggleable then
				local VisibilitySectionFrame = Instance.new("Frame")
				local VisibilitySectionFrameCorner = Instance.new("UICorner")
				local visibility = Instance.new("ImageButton")
				local visibility_off = Instance.new("ImageButton")
				local VisibilityButton = Instance.new("TextButton")
				VisibilityButton.Name = "VisibilityButton"
				VisibilityButton.Parent = Topsec
				VisibilityButton.AnchorPoint = Vector2.new(1, 0.5)
				VisibilityButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				VisibilityButton.BackgroundTransparency = 1.000
				VisibilityButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				VisibilityButton.BorderSizePixel = 0
				VisibilityButton.Font = Enum.Font.SourceSans
				VisibilityButton.Text = ""
				VisibilityButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				VisibilityButton.TextSize = 14.000
				VisibilityButton.ZIndex = 2
				VisibilityButton.Position = UDim2.new(1, -5, 0.5, 0)
				VisibilityButton.Size = UDim2.new(0, 20, 0, 20)
				VisibilitySectionFrame.Name = "VisibilitySectionFrame"
				VisibilitySectionFrame.Parent = Topsec
				VisibilitySectionFrame.AnchorPoint = Vector2.new(1, 0.5)
				VisibilitySectionFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				VisibilitySectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				VisibilitySectionFrame.BorderSizePixel = 0
				VisibilitySectionFrame.Position = UDim2.new(1, -5, 0.5, 0)
				VisibilitySectionFrame.Size = UDim2.new(0, 20, 0, 20)
				VisibilitySectionFrameCorner.CornerRadius = UDim.new(0, 4)
				VisibilitySectionFrameCorner.Name = "VisibilitySectionFrameCorner"
				VisibilitySectionFrameCorner.Parent = VisibilitySectionFrame
				visibility.Name = "visibility"
				visibility.Parent = VisibilitySectionFrame
				visibility.AnchorPoint = Vector2.new(0.5, 0.5)
				visibility.BackgroundTransparency = 1.000
				visibility.LayoutOrder = 4
				visibility.Position = UDim2.new(0.5, 0, 0.5, 0)
				visibility.Size = UDim2.new(1, -4, 1, -4)
				visibility.ZIndex = 2
				visibility.Image = "rbxassetid://3926307971"
				visibility.ImageRectOffset = Vector2.new(84, 44)
				visibility.ImageRectSize = Vector2.new(36, 36)
				visibility.ImageTransparency = 1
				visibility_off.Name = "visibility_off"
				visibility_off.Parent = VisibilitySectionFrame
				visibility_off.AnchorPoint = Vector2.new(0.5, 0.5)
				visibility_off.BackgroundTransparency = 1.000
				visibility_off.LayoutOrder = 4
				visibility_off.Position = UDim2.new(0.5, 0, 0.5, 0)
				visibility_off.Size = UDim2.new(1, -4, 1, -4)
				visibility_off.ZIndex = 2
				visibility_off.Image = "rbxassetid://3926307971"
				visibility_off.ImageRectOffset = Vector2.new(564, 44)
				visibility_off.ImageRectSize = Vector2.new(36, 36)
				visibility_off.ImageTransparency = 0
				VisibilityButton.MouseButton1Down:Connect(function()
					sectionIsVisible = not sectionIsVisible
					TweenService:Create(visibility, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"] / 2), {
						ImageTransparency = sectionIsVisible and 0 or 1
					}):Play()
					task.wait(getgenv().UIColor["Tween Animation 1 Speed"] / 4)
					TweenService:Create(visibility_off, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"] / 2), {
						ImageTransparency = sectionIsVisible and 1 or 0
					}):Play()
					TweenService:Create(Section, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Size =  UDim2.new(1, -5, 0, (sectionIsVisible and SizeSectionY or 30))
					}):Play()
				end)
			end
			if SectionGap then
				local SectionGap = Instance.new("Frame")
				SectionGap.Name = "SectionGap"
				SectionGap.Parent = PageList
				SectionGap.Size = UDim2.new(1, -5, 0, 30)
				SectionGap.ClipsDescendants = true
				SectionGap.Transparency = 1
			end

			SectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				SizeSectionY = SectionList.AbsoluteContentSize.Y + 35
				if not Toggleable then
					Section.Size = UDim2.new(1, -5, 0, SizeSectionY)
				elseif sectionIsVisible then
					Section.Size = UDim2.new(1, -5, 0, SizeSectionY)
				end
			end)
			local sectionFunction = {}
			function sectionFunction:AddToggle(idk,Setting)
				local Title = tostring(Setting.Text or Setting.Title) or ""
				local Desc = Setting.Desc or Setting.Description
				local Default = Setting.Default
				if Default == nil then
					Default = false
				end
				local Callback = Setting.Callback
				local ToggleFrame = Instance.new("Frame")
				local TogFrame1 = Instance.new("Frame")
				local checkbox = Instance.new("ImageLabel")
				local check = Instance.new("Frame")
				local ToggleDesc = Instance.new("TextLabel")
				local ToggleTitle = Instance.new("TextLabel")
				local ToggleBg = Instance.new("Frame")
				local ToggleCorner = Instance.new("UICorner")
				local ToggleButton = Instance.new("TextButton")
				local ToggleList = Instance.new("UIListLayout")
				ToggleFrame.Name = "ToggleFrame"
				ToggleFrame.Parent = Section
				ToggleFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ToggleFrame.BackgroundTransparency = 1.000
				ToggleFrame.Position = UDim2.new(0, 0, 0.300000012, 0)
				ToggleFrame.Size = UDim2.new(1, 0 , 0, 0)
				ToggleFrame.AutomaticSize = Enum.AutomaticSize.Y
				TogFrame1.Name = "TogFrame1"
				TogFrame1.Parent = ToggleFrame
				TogFrame1.AnchorPoint = Vector2.new(0.5, 0.5)
				TogFrame1.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				TogFrame1.BackgroundTransparency = 1.000
				TogFrame1.Position = UDim2.new(0.5, 0, 0.5, 0)
				TogFrame1.Size = UDim2.new(1, -10, 0, 0)
				TogFrame1.AutomaticSize = Enum.AutomaticSize.Y
				checkbox.Name = "checkbox"
				checkbox.Parent = TogFrame1
				checkbox.AnchorPoint = Vector2.new(1, 0.5)
				checkbox.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				checkbox.BackgroundTransparency = 1.000
				checkbox.Position = UDim2.new(1, -5, 0.5, 3)
				checkbox.Size = UDim2.new(0, 25, 0, 25)
				checkbox.Image = "rbxassetid://4552505888"
				checkbox.ImageColor3 = getgenv().UIColor["Toggle Border Color"]
				check.Name = "check"
				check.Parent = checkbox
				check.AnchorPoint = Vector2.new(0.5, 0.5)
				check.BackgroundColor3 = Color3.fromRGB(130, 0, 200)
				check.Position = UDim2.new(0.5, 0, 0.5, 0)
				local cac = 5
				if Desc then
					cac = 0
					ToggleDesc.Name = "ToggleDesc"
					ToggleDesc.Parent = TogFrame1
					ToggleDesc.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
					ToggleDesc.BackgroundTransparency = 1.000
					ToggleDesc.Position = UDim2.new(0, 15, 0, 20)
					ToggleDesc.Size = UDim2.new(1, -50, 0, 0)
					ToggleDesc.Font = Enum.Font.GothamBlack
					ToggleDesc.Text = Desc
					ToggleDesc.TextSize = 13.000
					ToggleDesc.TextWrapped = true
					ToggleDesc.TextXAlignment = Enum.TextXAlignment.Left
					ToggleDesc.RichText = true
					ToggleDesc.AutomaticSize = Enum.AutomaticSize.Y
					ToggleDesc.TextColor3 = getgenv().UIColor["Toggle Desc Color"]
				else
					ToggleDesc.Text = ''
				end
				ToggleTitle.Name = "TextColor"
				ToggleTitle.Parent = TogFrame1
				ToggleTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ToggleTitle.BackgroundTransparency = 1.000
				ToggleTitle.Position = UDim2.new(0, 10, 0, cac)
				ToggleTitle.Size = UDim2.new(1, -10, 0, 20)
				ToggleTitle.Font = Enum.Font.GothamBlack
				ToggleTitle.Text = Title
				ToggleTitle.TextSize = 14.000
				ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
				ToggleTitle.TextYAlignment = Enum.TextYAlignment.Center
				ToggleTitle.RichText = true
				ToggleTitle.AutomaticSize = Enum.AutomaticSize.Y
				ToggleTitle.TextColor3 = getgenv().UIColor["Text Color"]
				ToggleBg.Name = "Background1"
				ToggleBg.Parent = TogFrame1
				ToggleBg.Size = UDim2.new(1, 0, 1, 6)
				ToggleBg.ZIndex = 0
				ToggleBg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				ToggleBg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				ToggleCorner.CornerRadius = UDim.new(0, 4)
				ToggleCorner.Name = "ToggleCorner"
				ToggleCorner.Parent = ToggleBg
				ToggleButton.Name = "ToggleButton"
				ToggleButton.Parent = TogFrame1
				ToggleButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ToggleButton.BackgroundTransparency = 1.000
				ToggleButton.AnchorPoint = Vector2.new(1, 0.5)
				ToggleButton.Size = UDim2.new(0, 25, 0, 25)
				ToggleButton.Position = UDim2.new(1, -5, 0.5, 3)
				ToggleButton.Font = Enum.Font.SourceSans
				ToggleButton.Text = ""
				ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				ToggleButton.TextSize = 14.000
				ToggleList.Name = "ToggleList"
				ToggleList.Parent = ToggleFrame
				ToggleList.HorizontalAlignment = Enum.HorizontalAlignment.Center
				ToggleList.SortOrder = Enum.SortOrder.LayoutOrder
				ToggleList.VerticalAlignment = Enum.VerticalAlignment.Center
				ToggleList.Padding = UDim.new(0, 5)
				local function ChangeStage(val)
					local csize = val and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0, 0, 0, 0)
					local pos = val and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 0.5, 0)
					local apos = val and Vector2.new(0.5, 0.5) or Vector2.new(0.5, 0.5)
					game.TweenService:Create(check, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Size = csize,
						Position = pos,
						AnchorPoint = apos
					}):Play()
				end
				ChangeStage(Default)
				local function ButtonClick()
					Default = not Default
				    ChangeStage(Default)
				    if Callback then
				        pcall(Callback, Default)
				    end
				end
				ToggleButton.MouseButton1Down:Connect(function()
					ButtonClick()
				end)
				local toggleFunction = {}
				function toggleFunction.SetStage(value)
					if value ~= Default then
						ButtonClick()
					end
				end
				local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = ToggleFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
				return toggleFunction
			end
        function sectionFunction:AddButton(Setting, Callback)
        	local Title = Setting.Title or Setting.Text or ""
        	local Callback = Setting.Callback or Setting.Func or function() end
            local Button = Instance.new("Frame")
            local RowBG_1 = Instance.new("Frame")
            local UICorner_1 = Instance.new("UICorner")
            local RowHover_1 = Instance.new("Frame")
            local UICorner_2 = Instance.new("UICorner")
            local TextColor_1 = Instance.new("TextLabel")
            local ClickArea_1 = Instance.new("Frame")
            local UICorner_3 = Instance.new("UICorner")
            local UIGradient_1 = Instance.new("UIGradient")
            local ImageLabel_1 = Instance.new("ImageLabel")
            local Frame_1 = Instance.new("Frame")
            local UICorner_4 = Instance.new("UICorner")
            local UIScale_1 = Instance.new("UIScale")
            local Button_1 = Instance.new("TextButton")
            
            Button.Name = "Button"
            Button.Parent = Section
            Button.BackgroundColor3 = Color3.fromRGB(163,162,165)
            Button.BackgroundTransparency = 1
            Button.Size = UDim2.new(1, 0,0, 40)
             
            RowBG_1.Name = "RowBG"
            RowBG_1.Parent = Button
            RowBG_1.AnchorPoint = Vector2.new(0.5, 0.5)
            RowBG_1.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
            RowBG_1.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
            RowBG_1.Position = UDim2.new(0.5, 0,0.5, 0)
            RowBG_1.Size = UDim2.new(1, -10,1, 0)
             
            UICorner_1.Parent = RowBG_1
            UICorner_1.CornerRadius = UDim.new(0,10)
             
            RowHover_1.Name = "RowHover"
            RowHover_1.Parent = RowBG_1
            RowHover_1.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
            RowHover_1.BackgroundTransparency = 1
            RowHover_1.Size = UDim2.new(1, 0,1, 0)
            RowHover_1.ZIndex = 2
             
            UICorner_2.Parent = RowHover_1
            UICorner_2.CornerRadius = UDim.new(0,10)
             
            TextColor_1.Name = "TextColor"
            TextColor_1.Parent = RowBG_1
             TextColor_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
             TextColor_1.BackgroundTransparency = 1
             TextColor_1.Position = UDim2.new(0, 12,0, 0)
             TextColor_1.Size = UDim2.new(1, -110,1, 0)
             TextColor_1.Font = Enum.Font.GothamBold
             TextColor_1.Text = Title
             TextColor_1.TextColor3 = getgenv().UIColor["GUI Text Color"]
             TextColor_1.TextSize = 14
             TextColor_1.TextStrokeTransparency = 0.8500000238418579
             TextColor_1.TextXAlignment = Enum.TextXAlignment.Left
             
             ClickArea_1.Name = "ClickArea"
             ClickArea_1.Parent = RowBG_1
             ClickArea_1.AnchorPoint = Vector2.new(1, 0.5)
             ClickArea_1.BackgroundColor3 = Color3.fromRGB(60, 0, 100)
             ClickArea_1.Position = UDim2.new(1, -8,0.5, 0)
             ClickArea_1.Size = UDim2.new(0, 94,0, 30)
             ClickArea_1.ClipsDescendants = true
             
             UICorner_3.Parent = ClickArea_1
             UICorner_3.CornerRadius = UDim.new(0,12)
             
             UIGradient_1.Parent = ClickArea_1
             UIGradient_1.Color = ColorSequence.new{
                 ColorSequenceKeypoint.new(0, Color3.fromRGB(110, 20, 180)), 
                 ColorSequenceKeypoint.new(0.4, Color3.fromRGB(90, 0, 160)), 
                 ColorSequenceKeypoint.new(0.6, Color3.fromRGB(235, 186, 17)), 
                 ColorSequenceKeypoint.new(1, Color3.fromRGB(215, 166, 7))
             }
             UIGradient_1.Rotation = 90
             
             ImageLabel_1.Parent = ClickArea_1
             ImageLabel_1.AnchorPoint = Vector2.new(0.5, 0.5)
             ImageLabel_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
             ImageLabel_1.BackgroundTransparency = 1
             ImageLabel_1.Position = UDim2.new(0.5, 0,0.5, 0)
             ImageLabel_1.Size = UDim2.new(1, 14,1, 14)
             ImageLabel_1.ZIndex = 0
             ImageLabel_1.Image = "rbxassetid://5028857084"
             ImageLabel_1.ImageTransparency = 0.7
             ImageLabel_1.ScaleType = Enum.ScaleType.Slice
             ImageLabel_1.SliceCenter = Rect.new(24, 24, 276, 276)
             
             Frame_1.Parent = ClickArea_1
             Frame_1.AnchorPoint = Vector2.new(0.5, 0)
             Frame_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
             Frame_1.BackgroundTransparency = 0.8
             Frame_1.Position = UDim2.new(0.5, 0,0, 2)
             Frame_1.Size = UDim2.new(1, -6,0, 10)
             Frame_1.ZIndex = 2
             
             UICorner_4.Parent = Frame_1
             UICorner_4.CornerRadius = UDim.new(0,10)
             
             UIScale_1.Parent = ClickArea_1
             
             Button_1.Name = "Button"
             Button_1.Parent = ClickArea_1
             Button_1.Active = true
             Button_1.AutoButtonColor = false
             Button_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
             Button_1.BackgroundTransparency = 1
             Button_1.Size = UDim2.new(1, 0,1, 0)
             Button_1.Font = Enum.Font.GothamBold
             Button_1.Text = "Click"
             Button_1.TextColor3 = Color3.fromRGB(240, 240, 240)
             Button_1.TextSize = 13

             UIScale_1.Scale = 1
             
             local scaleHover = TweenService:Create(UIScale_1, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { Scale = 1.05 })
             local scaleNormal = TweenService:Create(UIScale_1, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { Scale = 1 })
             
             Button_1.MouseEnter:Connect(function()
             	scaleHover:Play()
             end)
             
             Button_1.MouseLeave:Connect(function()
             	scaleNormal:Play()
             end)
             
                Button_1.MouseButton1Down:Connect(function()
                    
                    local w = ClickArea_1.AbsoluteSize.X
                    local h = ClickArea_1.AbsoluteSize.Y
                    
                    local ripple = Instance.new("Frame")
                    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
                    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
                    ripple.Size = UDim2.new(0, 0, 0, 0)
                    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ripple.BackgroundTransparency = 0.6
                    ripple.ZIndex = 20
                    ripple.Parent = ClickArea_1
                    
                    local rippleCorner = Instance.new("UICorner")
                    rippleCorner.CornerRadius = UICorner_3.CornerRadius
                    rippleCorner.Parent = ripple
                    
                    local rippleTween = TweenService:Create(
                        ripple,
                        TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {
                            Size = UDim2.new(1, 0, 1, 0),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0.5, 0, 0.5, 0)
                        }
                    )
                    
                    rippleTween:Play()
                    rippleTween.Completed:Connect(function()
                        ripple:Destroy()
                    end)
                    
                    Callback()
                end)
                local f = {}
                function f:SetTitle(vl)
                    TextColor_1.Text = vl
                end
                local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = Button,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
                return f
            end
        
			function sectionFunction:AddLabel(text)
				local Title = text
                local LabelFrame = Instance.new("Frame")
                local LabelBG = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local TextColor = Instance.new("TextLabel")
                
                LabelFrame.Name = "LabelFrame"
                LabelFrame.Parent = Section
                LabelFrame.AutomaticSize = Enum.AutomaticSize.Y
                LabelFrame.BackgroundColor3 = Color3.fromRGB(163,162,165)
                LabelFrame.BackgroundTransparency = 1
                LabelFrame.Size = UDim2.new(1, 0,0, 0)
                
                LabelBG.Name = "LabelBG"
                LabelBG.Parent = LabelFrame
                LabelBG.AnchorPoint = Vector2.new(0.5, 0)
                LabelBG.AutomaticSize = Enum.AutomaticSize.Y
                LabelBG.BackgroundColor3 = Color3.fromRGB(38,38,46)
                LabelBG.BackgroundTransparency = 0.25
                LabelBG.Position = UDim2.new(0.5, 0,0, 0)
                LabelBG.Size = UDim2.new(1, -10,0, -10)
                
                UICorner.Parent = LabelBG
                UICorner.CornerRadius = UDim.new(0,6)
                
                
                TextColor.Name = "TextColor"
                TextColor.Parent = LabelBG
                TextColor.AutomaticSize = Enum.AutomaticSize.Y
                TextColor.BackgroundColor3 = Color3.fromRGB(163,162,165)
                TextColor.BackgroundTransparency = 1
                TextColor.Position = UDim2.new(0, 12,0, 6)
                TextColor.Size = UDim2.new(1, -24,1, -12)
                TextColor.Font = Enum.Font.GothamMedium
                TextColor.Text = Title
                TextColor.TextColor3 = Color3.fromRGB(240,240,230)
                TextColor.TextSize = 14
                TextColor.TextStrokeTransparency = 0.8500000238418579
                TextColor.TextWrapped = true
                TextColor.TextXAlignment = Enum.TextXAlignment.Left
				local labelFunction = {}
				function labelFunction:SetText(text)
					TextColor.Text = text
				end
				function labelFunction.SetColor(color)
					TextColor.TextColor3 = color
				end
				local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = LabelFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
				return labelFunction
			end
            function sectionFunction:AddDropdownSection(Setting)
                local Title = tostring(Setting.Text or Setting.Title or "")
                local Search = Setting.Search or false
              
                local DropdownFrame = Instance.new("Frame")
                local Dropdownbg = Instance.new("Frame")
                local Dropdowncorner = Instance.new("UICorner")
                local Topdrop = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local ImgDrop = Instance.new("ImageLabel")
                local DropdownButton = Instance.new("TextButton")
                local Dropdownlisttt = Instance.new("Frame")
                local DropdownScroll = Instance.new("ScrollingFrame")
                local ScrollContainer = Instance.new("Frame")
                local ScrollContainerList = Instance.new("UIListLayout")
                
                DropdownFrame.Name = Title .. "DropdownSectionFrame"
                DropdownFrame.Parent = Section
                DropdownFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                DropdownFrame.BackgroundTransparency = 1.000
                DropdownFrame.Position = UDim2.new(0, 0, 0.473684222, 0)
                DropdownFrame.Size = UDim2.new(1, 0, 0, 25)
                
                Dropdownbg.Name = "Background1"
                Dropdownbg.Parent = DropdownFrame
                Dropdownbg.AnchorPoint = Vector2.new(0.5, 0.5)
                Dropdownbg.Position = UDim2.new(0.5, 0, 0.5, 0)
                Dropdownbg.Size = UDim2.new(1, -10, 1, 0)
                Dropdownbg.ClipsDescendants = true
                Dropdownbg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                Dropdownbg.BackgroundTransparency = 0
                
                Dropdowncorner.CornerRadius = UDim.new(0, 4)
                Dropdowncorner.Name = "Dropdowncorner"
                Dropdowncorner.Parent = Dropdownbg
                
                Topdrop.Name = "Background2"
                Topdrop.Parent = Dropdownbg
                Topdrop.Size = UDim2.new(1, 0, 0, 25)
                Topdrop.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                Topdrop.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = Topdrop
                
                local Dropdowntitle
                if Search then
                    Dropdowntitle = Instance.new("TextBox")
                    Dropdowntitle.PlaceholderText = Title
                    Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
                else
                    Dropdowntitle = Instance.new("TextLabel")
                    Dropdowntitle.Text = Title
                end
                
                Dropdowntitle.Name = "TextColorPlaceholder"
                Dropdowntitle.Parent = Topdrop
                Dropdowntitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                Dropdowntitle.BackgroundTransparency = 1.000
                Dropdowntitle.Position = UDim2.new(0, 10, 0, 0)
                Dropdowntitle.Size = UDim2.new(1, -40, 1, 0)
                Dropdowntitle.Font = Enum.Font.GothamBlack
                Dropdowntitle.TextSize = 14.000
                Dropdowntitle.TextXAlignment = Enum.TextXAlignment.Left
                Dropdowntitle.ClipsDescendants = true
                Dropdowntitle.TextColor3 = getgenv().UIColor["Text Color"]
                
                ImgDrop.Name = "ImgDrop"
                ImgDrop.Parent = Topdrop
                ImgDrop.AnchorPoint = Vector2.new(1, 0.5)
                ImgDrop.BackgroundTransparency = 1.000
                ImgDrop.BorderColor3 = Color3.fromRGB(27, 42, 53)
                ImgDrop.Position = UDim2.new(1, -6, 0.5, 0)
                ImgDrop.Size = UDim2.new(0, 15, 0, 15)
                ImgDrop.Image = "rbxassetid://6954383209"
                ImgDrop.ImageColor3 = getgenv().UIColor["Dropdown Icon Color"]
                
                DropdownButton.Name = "DropdownButton"
                DropdownButton.Parent = Topdrop
                DropdownButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                DropdownButton.BackgroundTransparency = 1.000
                DropdownButton.Size = Search and UDim2.new(0, 30, 0, 30) or UDim2.new(1, 0, 1 , 0)
                DropdownButton.Position = Search and UDim2.new(1, -35, 0, 0) or UDim2.new(0 , 0 , 0 , 0)
                DropdownButton.Font = Enum.Font.GothamBold
                DropdownButton.Text = ""
                DropdownButton.TextColor3 = Color3.fromRGB(230, 230, 230)
                DropdownButton.TextSize = 14.000
                
                Dropdownlisttt.Name = "Dropdownlisttt"
                Dropdownlisttt.Parent = Dropdownbg
                Dropdownlisttt.BackgroundTransparency = 1.000
                Dropdownlisttt.BorderSizePixel = 0
                Dropdownlisttt.Position = UDim2.new(0, 0, 0, 25)
                Dropdownlisttt.Size = UDim2.new(1, 0, 0, 0)
                Dropdownlisttt.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                
                DropdownScroll.Name = "DropdownScroll"
                DropdownScroll.Parent = Dropdownlisttt
                DropdownScroll.Active = true
                DropdownScroll.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                DropdownScroll.BackgroundTransparency = 1.000
                DropdownScroll.BorderSizePixel = 0
                DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
                DropdownScroll.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
                DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropdownScroll.ScrollBarThickness = 5
                DropdownScroll.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
                DropdownScroll.ScrollingEnabled = true
                DropdownScroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always
                
                ScrollContainer.Name = "ScrollContainer"
                ScrollContainer.Parent = DropdownScroll
                ScrollContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                ScrollContainer.BackgroundTransparency = 1.000
                ScrollContainer.Position = UDim2.new(0, 5, 0, 5)
                ScrollContainer.Size = UDim2.new(1, -15, 1, -5)
                
                ScrollContainerList.Name = "ScrollContainerList"
                ScrollContainerList.Parent = ScrollContainer
                ScrollContainerList.SortOrder = Enum.SortOrder.LayoutOrder
                ScrollContainerList.Padding = UDim.new(0, 5)
                
                local InternalSection = Instance.new("Frame")
                InternalSection.Name = "InternalSection"
                InternalSection.Parent = ScrollContainer
                InternalSection.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                InternalSection.BackgroundTransparency = 1.000
                InternalSection.Size = UDim2.new(1, 0, 0, 0)
                InternalSection.AutomaticSize = Enum.AutomaticSize.Y
                
                local InternalList = Instance.new("UIListLayout")
                InternalList.Name = "InternalList"
                InternalList.Parent = InternalSection
                InternalList.SortOrder = Enum.SortOrder.LayoutOrder
                InternalList.Padding = UDim.new(0, 5)
                
                local isOpen = false
                
                DropdownButton.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    
                    local listsize = isOpen and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 0)
                    local mainsize = isOpen and UDim2.new(1, 0, 0, 230) or UDim2.new(1, 0, 0, 25)
                    local DropCRotation = isOpen and 90 or 0
                    
                    TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                        Size = listsize
                    }):Play()
                    TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                        Size = mainsize
                    }):Play()
                    TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                        Rotation = DropCRotation
                    }):Play()
                end)
                
                ScrollContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 10 + ScrollContainerList.AbsoluteContentSize.Y + 5)
                end)
                
                InternalList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    local contentHeight = math.min(InternalList.AbsoluteContentSize.Y + 10, 300)
                    local listsize = isOpen and UDim2.new(1, 0, 0, contentHeight) or UDim2.new(1, 0, 0, 0)
                    local mainsize = isOpen and UDim2.new(1, 0, 0, contentHeight + 25) or UDim2.new(1, 0, 0, 25)
                    
                    if isOpen then
                        TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            Size = listsize
                        }):Play()
                        TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            Size = mainsize
                        }):Play()
                    end
                end)
                
                local dropdownSectionFunction = {}
                
                function dropdownSectionFunction:AddSlider(Setting)
                    local TitleText = tostring(Setting.Text or Setting.Title) or ""
                    local minValue = tonumber(Setting.Min) or 0
                    local maxValue = tonumber(Setting.Max) or 100
                    local Precise = Setting.Precise or false
                    local DefaultValue = tonumber(Setting.Default) or 0
                    local Callback = Setting.Callback
                    local Rounding = Setting.Rouding or Setting.Rounding
                    
                    local SliderFrame = Instance.new("Frame")
                    local SliderCorner = Instance.new("UICorner")
                    local SliderBG = Instance.new("Frame")
                    local SliderBGCorner = Instance.new("UICorner")
                    local SliderTitle = Instance.new("TextLabel")
                    local SliderBar = Instance.new("Frame")
                    local SliderButton = Instance.new("TextButton")
                    local SliderBarCorner = Instance.new("UICorner")
                    local Bar = Instance.new("Frame")
                    local BarCorner = Instance.new("UICorner")
                    local Sliderboxframe = Instance.new("Frame")
                    local Sliderbox = Instance.new("UICorner")
                    local Sliderbox_2 = Instance.new("TextBox")
                    
                    SliderFrame.Name = TitleText
                    SliderFrame.Parent = InternalSection
                    SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    SliderFrame.BackgroundTransparency = 1.000
                    SliderFrame.Size = UDim2.new(1, 0, 0, 50)
                    
                    SliderCorner.CornerRadius = UDim.new(0, 4)
                    SliderCorner.Name = "SliderCorner"
                    SliderCorner.Parent = SliderFrame
                    
                    SliderBG.Name = "Background1"
                    SliderBG.Parent = SliderFrame
                    SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
                    SliderBG.Size = UDim2.new(1, -5, 1, 0)
                    SliderBG.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    SliderBG.BackgroundTransparency = 0.25
                    
                    SliderBGCorner.CornerRadius = UDim.new(0, 4)
                    SliderBGCorner.Name = "SliderBGCorner"
                    SliderBGCorner.Parent = SliderBG
                    
                    SliderTitle.Name = "TextColor"
                    SliderTitle.Parent = SliderBG
                    SliderTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    SliderTitle.BackgroundTransparency = 1.000
                    SliderTitle.Position = UDim2.new(0, 10, 0, 0)
                    SliderTitle.Size = UDim2.new(0.65, -10, 0, 25)
                    SliderTitle.Font = Enum.Font.GothamBlack
                    SliderTitle.Text = TitleText
                    SliderTitle.TextSize = 14.000
                    SliderTitle.RichText = true
                    SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
                    SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
                    
                    SliderBar.Name = "SliderBar"
                    SliderBar.Parent = SliderFrame
                    SliderBar.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderBar.Position = UDim2.new(0.5, 0, 0.5, 14)
                    SliderBar.Size = UDim2.new(0.9, 0, 0, 6)
                    SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                    
                    SliderButton.Name = "SliderButton"
                    SliderButton.Parent = SliderBar
                    SliderButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    SliderButton.BackgroundTransparency = 1.000
                    SliderButton.Size = UDim2.new(1, 0, 1, 0)
                    SliderButton.Font = Enum.Font.GothamBold
                    SliderButton.Text = ""
                    SliderButton.TextColor3 = Color3.fromRGB(230, 230, 230)
                    SliderButton.TextSize = 14.000
                    
                    SliderBarCorner.CornerRadius = UDim.new(1, 0)
                    SliderBarCorner.Name = "SliderBarCorner"
                    SliderBarCorner.Parent = SliderBar
                    
                    Bar.Name = "Bar"
                    Bar.BorderSizePixel = 0
                    Bar.Parent = SliderBar
                    Bar.Size = UDim2.new(0, 0, 1, 0)
                    Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
                    
                    BarCorner.CornerRadius = UDim.new(1, 0)
                    BarCorner.Name = "BarCorner"
                    BarCorner.Parent = Bar
                    
                    Sliderboxframe.Name = "Background2"
                    Sliderboxframe.Parent = SliderFrame
                    Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
                    Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
                    Sliderboxframe.Size = UDim2.new(0.25, 0, 0, 25)
                    Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                    
                    Sliderbox.CornerRadius = UDim.new(0, 4)
                    Sliderbox.Name = "Sliderbox"
                    Sliderbox.Parent = Sliderboxframe
                    
                    Sliderbox_2.Name = "TextColor"
                    Sliderbox_2.Parent = Sliderboxframe
                    Sliderbox_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    Sliderbox_2.BackgroundTransparency = 1.000
                    Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
                    Sliderbox_2.Font = Enum.Font.GothamBold
                    Sliderbox_2.Text = ""
                    Sliderbox_2.TextSize = 14.000
                    Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
                    
                    SliderButton.MouseEnter:Connect(function()
                        TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"]
                        }):Play()
                    end)
                    
                    SliderButton.MouseLeave:Connect(function()
                        TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
                        }):Play()
                    end)
                    
                    local callBackAndSetText = function(val)
                        Sliderbox_2.Text = tostring(val)
                        Callback(tonumber(val))
                    end
                    if DefaultValue then
                        if DefaultValue <= minValue then
                            DefaultValue = minValue
                        elseif DefaultValue >= maxValue then
                            DefaultValue = maxValue
                        end
                        Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 0, 6)
                        Sliderbox_2.Text = tostring(DefaultValue)
                    end
                    
                    
                    local dragging = false
                    local dragInput
                    local holdTime = 0
                    local holdStarted = 0
                    
                    local function onInputBegan(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            holdStarted = tick()
                            
                            input.Changed:Connect(function()
                                if input.UserInputState == Enum.UserInputState.End then
                                    dragging = false
                                    holdStarted = 0
                                end
                            end)
                        end
                    end
                    
                    local function onInputEnded(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            dragging = false
                            holdStarted = 0
                        end
                    end
                    
                    local function onInputChanged(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                            dragInput = input
                        end
                    end
                    
                    SliderButton.InputBegan:Connect(onInputBegan)
                    SliderButton.InputEnded:Connect(onInputEnded)
                    SliderButton.InputChanged:Connect(onInputChanged)
                    
                    RunService.RenderStepped:Connect(function()
                        if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
                            dragging = true
                        end
                        
                        if dragging and dragInput then
                            local barWidth = math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X)
                            local percentage = barWidth / SliderBar.AbsoluteSize.X
                            local value = minValue + (maxValue - minValue) * percentage
                            
                            if Rounding then
                                value = tonumber(string.format("%.".. Rounding .."f", value))
                            elseif not Precise then
                                value = math.floor(value)
                            end
                            
                            value = math.clamp(value, minValue, maxValue)
                            
                            pcall(function()
                                callBackAndSetText(value)
                            end)
                            Bar.Size = UDim2.new(percentage, 0, 1, 0)
                        end
                    end)
                    
                    local function GetSliderValue(Value)
                        Value = tonumber(Value) or minValue
                        Value = math.clamp(Value, minValue, maxValue)
                        
                        if Rounding then
                            Value = tonumber(string.format("%.".. Rounding .."f", Value))
                        elseif not Precise then
                            Value = math.floor(Value)
                        end
                        
                        local percentage = (Value - minValue) / (maxValue - minValue)
                        Bar.Size = UDim2.new(percentage, 0, 1, 0)
                        callBackAndSetText(Value)
                    end
                    
                    Sliderbox_2.FocusLost:Connect(function()
                        GetSliderValue(Sliderbox_2.Text)
                    end)
                    
                    local slider_function = {}
                    function slider_function.SetValue(Value)
                        GetSliderValue(Value)
                    end
                    
                    function slider_function.GetValue()
                        return tonumber(Sliderbox_2.Text) or minValue
                    end
                    
                    return slider_function
                end
                
                function dropdownSectionFunction:SetOpen(state)
                    if state ~= isOpen then
                        DropdownButton.MouseButton1Click:Fire()
                    end
                end
                
                function dropdownSectionFunction:GetOpen()
                    return isOpen
                end
                
                function dropdownSectionFunction:SetTitle(newTitle)
                    if Search then
                        Dropdowntitle.PlaceholderText = newTitle
                    else
                        Dropdowntitle.Text = newTitle
                    end
                end
                
                local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = DropdownFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
                return dropdownSectionFunction
            end
            
			function sectionFunction:AddDropdown(idk, Setting)
				local Title = tostring(Setting.Text or Setting.Title) or ""
				local List = Setting.Values
				local Search = Setting.Search or false
				local Selected = Setting.Selected or Setting.Multi or false
				local Slider = Setting.Slider or false
				local SliderRelease = Setting.SliderRelease or false
				local Default = (function ()
                    if Setting.Default then
                        if type(Setting.Default) == "number" then
                            return List[Setting.Default]
                        elseif type(Setting.Default) == "string" then
                            return Setting.Default
                        end
                    end
                    return nil
                end)()
				local Callback = Setting.Callback
				local pairs = Setting.SortPairs or pairs
				local DropdownFrame = Instance.new("Frame")
				local Dropdownbg = Instance.new("Frame")
				local Dropdowncorner = Instance.new("UICorner")
				local Topdrop = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local ImgDrop = Instance.new("ImageLabel")
				local DropdownButton = Instance.new("TextButton")
				local Dropdownlisttt = Instance.new("Frame")
				local DropdownScroll = Instance.new("ScrollingFrame")
				local ScrollContainer = Instance.new("Frame")
				local ScrollContainerList = Instance.new("UIListLayout")
				local dropdownLeave = false
				local Dropdowntitle;
				if Search then
					Dropdowntitle = Instance.new("TextBox")
				else
					Dropdowntitle = Instance.new("TextLabel")
				end
				DropdownFrame.Name = Title .. "DropdownFrame"
				DropdownFrame.Parent = Section
				DropdownFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownFrame.BackgroundTransparency = 1.000
				DropdownFrame.Position = UDim2.new(0, 0, 0.473684222, 0)
				DropdownFrame.Size = UDim2.new(1, 0, 0, 25)
				Dropdownbg.Name = "Background1"
				Dropdownbg.Parent = DropdownFrame
				Dropdownbg.AnchorPoint = Vector2.new(0.5, 0.5)
				Dropdownbg.Position = UDim2.new(0.5, 0, 0.5, 0)
				Dropdownbg.Size = UDim2.new(1, -10, 1, 0)
				Dropdownbg.ClipsDescendants = true
				Dropdownbg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				Dropdownbg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				Dropdowncorner.CornerRadius = UDim.new(0, 4)
				Dropdowncorner.Name = "Dropdowncorner"
				Dropdowncorner.Parent = Dropdownbg
				Topdrop.Name = "Background2"
				Topdrop.Parent = Dropdownbg
				Topdrop.Size = UDim2.new(1, 0, 0, 25)
				Topdrop.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				Topdrop.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Topdrop
				Dropdowntitle.Name = "TextColorPlaceholder"
				Dropdowntitle.Parent = Topdrop
				Dropdowntitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Dropdowntitle.BackgroundTransparency = 1.000
				Dropdowntitle.Position = UDim2.new(0, 10, 0, 0)
				Dropdowntitle.Size = UDim2.new(1, -40, 1, 0)
				Dropdowntitle.Font = Enum.Font.GothamBlack
				Dropdowntitle.Text = ''
				Dropdowntitle.TextSize = 14.000
				Dropdowntitle.TextXAlignment = Enum.TextXAlignment.Left
				Dropdowntitle.ClipsDescendants = true
				local Sel = Instance.new("StringValue", Dropdowntitle)
				Sel.Value = ""
				if Default and table.find(List, Default) then
					Sel.Value = Default
				end
				if not Selected then
					if Search then
						Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
						Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "");
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "");
					end
				else
					if Search then
						Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
						Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "");
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "");
					end
				end
				Dropdowntitle.TextColor3 = getgenv().UIColor["Text Color"]
				ImgDrop.Name = "ImgDrop"
				ImgDrop.Parent = Topdrop
				ImgDrop.AnchorPoint = Vector2.new(1, 0.5)
				ImgDrop.BackgroundTransparency = 1.000
				ImgDrop.BorderColor3 = Color3.fromRGB(27, 42, 53)
				ImgDrop.Position = UDim2.new(1, -6, 0.5, 0)
				ImgDrop.Size = UDim2.new(0, 15, 0, 15)
				ImgDrop.Image = "rbxassetid://6954383209"
				ImgDrop.ImageColor3 = getgenv().UIColor["Dropdown Icon Color"]
				DropdownButton.Name = "DropdownButton"
				DropdownButton.Parent = Topdrop
				DropdownButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownButton.BackgroundTransparency = 1.000
				DropdownButton.Size = Search and UDim2.new(0, 30, 0, 30) or UDim2.new(1, 0, 1 , 0)
				DropdownButton.Position = Search and UDim2.new(1, -35, 0, 0) or UDim2.new(0 , 0 , 0 , 0)
				DropdownButton.Font = Enum.Font.GothamBold
				DropdownButton.Text = ""
				DropdownButton.TextColor3 = Color3.fromRGB(230, 230, 230)
				DropdownButton.TextSize = 14.000
				Dropdownlisttt.Name = "Dropdownlisttt"
				Dropdownlisttt.Parent = Dropdownbg
				Dropdownlisttt.BackgroundTransparency = 1.000
				Dropdownlisttt.BorderSizePixel = 0
				Dropdownlisttt.Position = UDim2.new(0, 0, 0, 25)
				Dropdownlisttt.Size = UDim2.new(1, 0, 0, 25)
				Dropdownlisttt.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownScroll.Name = "DropdownScroll"
				DropdownScroll.Parent = Dropdownlisttt
				DropdownScroll.Active = true
				DropdownScroll.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownScroll.BackgroundTransparency = 1.000
				DropdownScroll.BorderSizePixel = 0
				DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
				DropdownScroll.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
				DropdownScroll.ScrollBarThickness = 5
				DropdownScroll.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				DropdownScroll.ScrollingEnabled = true
				DropdownScroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always
				ScrollContainer.Name = "ScrollContainer"
				ScrollContainer.Parent = DropdownScroll
				ScrollContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ScrollContainer.BackgroundTransparency = 1.000
				ScrollContainer.Position = UDim2.new(0, 5, 0, 5)
				ScrollContainer.Size = UDim2.new(1, -15, 1, -5)
				ScrollContainerList.Name = "ScrollContainerList"
				ScrollContainerList.Parent = ScrollContainer
				ScrollContainerList.SortOrder = Enum.SortOrder.LayoutOrder
				ScrollContainerList.Padding = UDim.new(0, 5)
				ScrollContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 10 + ScrollContainerList.AbsoluteContentSize.Y + 5)
				end)
				local isbusy = false
				local found = {}
				local searchtable = {}
				local function edit()
					for i in pairs(found) do
						found[i] = nil
					end
					for h, l in pairs(ScrollContainer:GetChildren()) do
						if not l:IsA("UIListLayout") and not l:IsA("UIPadding") and not l:IsA('UIGridLayout') then
							l.Visible = false
						end
					end
					Dropdowntitle.Text = string.lower(Dropdowntitle.Text)
				end
				local function SearchDropdown()
					local Results = {}
					for i, v in pairs(searchtable) do
						if string.find(v, Dropdowntitle.Text) then
							table.insert(found, v)
						end
					end
					for a, b in pairs(ScrollContainer:GetChildren()) do
						for c, d in pairs(found) do
							if d == b.Name then
								b.Visible = true
							end
						end
					end
				end
				local function clear_object_in_list()
					for i, v in next, ScrollContainer:GetChildren() do
						if v:IsA('Frame') then
							v:Destroy()
						end
					end
				end
				local ListNew
                local OrderedList = {}
                if Selected then
                    ListNew = {}
                    for _, value in ipairs(List) do
                        ListNew[value] = (value == Default)
                        table.insert(OrderedList, value)
                    end
                else
                    ListNew = List
                end
				local function refreshlist(SortPairs)
					pairs = SortPairs or pairs
					clear_object_in_list()
					searchtable = {}
					for i, v in pairs(ListNew) do
						if Selected then
							table.insert(searchtable, string.lower(i))
						elseif Slider then
							table.insert(searchtable, string.lower(v['Title']))
						else
							table.insert(searchtable, string.lower(v))
						end
					end
					if Selected then
                        for _, i in ipairs(OrderedList) do
                            local v = ListNew[i]
							local SampleItem = Instance.new("Frame")
							local SampleItemCorner = Instance.new("UICorner")
							local SampleItemBG = Instance.new("Frame")
							local SampleItemBGCorner = Instance.new("UICorner")
							local SampleItemTitle = Instance.new("TextLabel")
							local SampleItemCheck = Instance.new("ImageButton")
							local SampleItemButton = Instance.new("TextButton")
							SampleItem.Name = string.lower(i)
							SampleItem.Parent = ScrollContainer
							SampleItem.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
							SampleItem.BackgroundTransparency = 1.000
							SampleItem.BorderColor3 = Color3.fromRGB(27, 42, 53)
							SampleItem.LayoutOrder = 1
							SampleItem.Position = UDim2.new(0, 0, 0.208333328, 0)
							SampleItem.Size = UDim2.new(1, 0, 0, 25)
							SampleItemCorner.CornerRadius = UDim.new(0, 4)
							SampleItemCorner.Name = "SampleItemCorner"
							SampleItemCorner.Parent = SampleItem
							SampleItemBG.Name = "SampleItemBG"
							SampleItemBG.Parent = SampleItem
							SampleItemBG.AnchorPoint = Vector2.new(0.5, 0.5)
							SampleItemBG.BackgroundColor3 = v and UIColor["Dropdown Selected Check Color"] or Color3.fromRGB(255, 255, 255)
							SampleItemBG.BackgroundTransparency = v and .5 or 1
							SampleItemBG.BorderColor3 = Color3.fromRGB(27, 42, 53)
							SampleItemBG.Position = UDim2.new(0.5, 0, 0.5, 0)
							SampleItemBG.Size = UDim2.new(1, 0, 1, 0)
							SampleItemBGCorner.CornerRadius = UDim.new(0, 4)
							SampleItemBGCorner.Name = "SampleItemBGCorner"
							SampleItemBGCorner.Parent = SampleItemBG
							SampleItemTitle.Name = "SampleItemTitle"
							SampleItemTitle.Parent = SampleItemBG
							SampleItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							SampleItemTitle.BackgroundTransparency = 1.000
							SampleItemTitle.BorderColor3 = Color3.fromRGB(27, 42, 53)
							SampleItemTitle.Position = UDim2.new(0, 10, 0, 0)
							SampleItemTitle.Size = UDim2.new(1, -40, 0, 25)
							SampleItemTitle.Font = Enum.Font.GothamBlack
							SampleItemTitle.Text = tostring(i)
							SampleItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
							SampleItemTitle.TextSize = 14.000
							SampleItemTitle.TextStrokeTransparency = 0.500
							SampleItemTitle.TextXAlignment = Enum.TextXAlignment.Left
							SampleItemCheck.Name = "SampleItemCheck"
							SampleItemCheck.Parent = SampleItemBG
							SampleItemCheck.AnchorPoint = Vector2.new(1, 0.5)
							SampleItemCheck.BackgroundTransparency = 1.000
							SampleItemCheck.Position = UDim2.new(1, 0, 0.5, 0)
							SampleItemCheck.Size = UDim2.new(0, 25, 0, 25)
							SampleItemCheck.ZIndex = 2
							SampleItemCheck.Image = "rbxassetid://3926305904"
							SampleItemCheck.ImageColor3 = UIColor["Dropdown Selected Check Color"]
							SampleItemCheck.ImageRectOffset = Vector2.new(312, 4)
							SampleItemCheck.ImageRectSize = Vector2.new(24, 24)
							SampleItemCheck.ImageTransparency = v and 0 or 1
							SampleItemButton.Name = "SampleItemButton"
							SampleItemButton.Parent = SampleItem
							SampleItemButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							SampleItemButton.BackgroundTransparency = 1.000
							SampleItemButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
							SampleItemButton.BorderSizePixel = 0
							SampleItemButton.Size = UDim2.new(1, 0, 1, 0)
							SampleItemButton.Font = Enum.Font.SourceSans
							SampleItemButton.TextColor3 = getgenv().UIColor["Text Color"]
							SampleItemButton.TextSize = 14.000
							SampleItemButton.TextTransparency = 1.000
							SampleItemButton.MouseEnter:Connect(function()
								if v then
									return
								end
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundTransparency = .7
								}
										):Play()
							end)
							SampleItemButton.MouseLeave:Connect(function()
								if v then
									return
								end
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundTransparency = 1
								}
										):Play()
							end)
							SampleItemButton.MouseButton1Click:Connect(function()
								v = not v
								TweenService:Create(
											SampleItemCheck,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									ImageTransparency = v and 0 or 1
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundColor3 = v and UIColor["Dropdown Selected Check Color"] or Color3.fromRGB(255, 255, 255)
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundTransparency = v and .5 or 1
								}
										):Play()
								if Callback then
									Callback(i, v)
									ListNew[i] = v
								end
								if Search then
									Dropdowntitle.PlaceholderText = Title .. ': '
								else
									Dropdowntitle.Text = Title .. ': '
								end
							end)
						end
					elseif Slider then
						for i, v in pairs(ListNew) do
							local TitleText = tostring(v.Title) or ""
							local minValue = tonumber(v.Min) or 0
							local maxValue = tonumber(v.Max) or 100
							local Precise = v.Precise or false
							local DefaultValue = tonumber(v.Default) or minValue
							local SizeChia = 365;
							local SliderFrame = Instance.new("Frame")
							local SliderCorner = Instance.new("UICorner")
							local SliderBG = Instance.new("Frame")
							local SliderBGCorner = Instance.new("UICorner")
							local SliderTitle = Instance.new("TextLabel")
							local SliderBar = Instance.new("Frame")
							local SliderButton = Instance.new("TextButton")
							local SliderBarCorner = Instance.new("UICorner")
							local Bar = Instance.new("Frame")
							local BarCorner = Instance.new("UICorner")
							local Sliderboxframe = Instance.new("Frame")
							local Sliderbox = Instance.new("UICorner")
							local Sliderbox_2 = Instance.new("TextBox")
							SliderFrame.Name = string.lower(v['Title'])
							SliderFrame.Parent = ScrollContainer
							SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
							SliderFrame.BackgroundTransparency = 1.000
							SliderFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
							SliderFrame.Size = UDim2.new(1, 0, 0, 50)
							SliderCorner.CornerRadius = UDim.new(0, 4)
							SliderCorner.Name = "SliderCorner"
							SliderCorner.Parent = SliderFrame
							SliderBG.Name = "Background1"
							SliderBG.Parent = SliderFrame
							SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
							SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
							SliderBG.Size = UDim2.new(1, -10, 1, 0)
							SliderBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
							SliderBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							SliderBGCorner.CornerRadius = UDim.new(0, 4)
							SliderBGCorner.Name = "SliderBGCorner"
							SliderBGCorner.Parent = SliderBG
							SliderTitle.Name = "TextColor"
							SliderTitle.Parent = SliderBG
							SliderTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							SliderTitle.BackgroundTransparency = 1.000
							SliderTitle.Position = UDim2.new(0, 10, 0, 0)
							SliderTitle.Size = UDim2.new(1, -10, 0, 25)
							SliderTitle.Font = Enum.Font.GothamBlack
							SliderTitle.Text = TitleText
							SliderTitle.TextSize = 14.000
							SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
							SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
							SliderBar.Name = "SliderBar"
							SliderBar.Parent = SliderFrame
							SliderBar.AnchorPoint = Vector2.new(.5, 0.5)
							SliderBar.Position = UDim2.new(.5, 0, 0.5, 14)
							SliderBar.Size = UDim2.new(1, -20, 0, 6)
							SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							SliderButton.Name = "SliderButton "
							SliderButton.Parent = SliderBar
							SliderButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							SliderButton.BackgroundTransparency = 1.000
							SliderButton.Size = UDim2.new(1, 0, 1, 0)
							SliderButton.Font = Enum.Font.GothamBold
							SliderButton.Text = ""
							SliderButton.TextColor3 = Color3.fromRGB(230, 230, 230)
							SliderButton.TextSize = 14.000
							SliderBarCorner.CornerRadius = UDim.new(1, 0)
							SliderBarCorner.Name = "SliderBarCorner"
							SliderBarCorner.Parent = SliderBar
							Bar.Name = "Bar"
							Bar.BorderSizePixel = 0
							Bar.Parent = SliderBar
							Bar.Size = UDim2.new(0, 0, 1, 0)
							Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
							BarCorner.CornerRadius = UDim.new(1, 0)
							BarCorner.Name = "BarCorner"
							BarCorner.Parent = Bar
							Sliderboxframe.Name = "Background2"
							Sliderboxframe.Parent = SliderFrame
							Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
							Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
							Sliderboxframe.Size = UDim2.new(0, 150, 0, 25)
							Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							Sliderbox.CornerRadius = UDim.new(0, 4)
							Sliderbox.Name = "Sliderbox"
							Sliderbox.Parent = Sliderboxframe
							Sliderbox_2.Name = "TextColor"
							Sliderbox_2.Parent = Sliderboxframe
							Sliderbox_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							Sliderbox_2.BackgroundTransparency = 1.000
							Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
							Sliderbox_2.Font = Enum.Font.GothamBold
							Sliderbox_2.Text = ""
							Sliderbox_2.TextSize = 14.000
							Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
							SliderButton.MouseEnter:Connect(function()
								TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
									BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"]
								}):Play()
							end)
							SliderButton.MouseLeave:Connect(function()
								TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
									BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
								}):Play()
							end)
							local callBackAndSetText = function(val)
								Sliderbox_2.Text = val
								ListNew[i].Default = val
								Callback(i, v)
							end
							if DefaultValue then
								if DefaultValue <= minValue then
									DefaultValue = minValue
								elseif DefaultValue >= maxValue then
									DefaultValue = maxValue
								end
								Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 0, 6)
								callBackAndSetText(DefaultValue)
							end
							if SliderRelease then
								local dragging = false
								local dragInput
								local holdTime = 0
								local holdStarted = 0

								local function onInputBegan(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										holdStarted = tick()
										
										input.Changed:Connect(function()
											if input.UserInputState == Enum.UserInputState.End then
												dragging = false
												holdStarted = 0
											end
										end)
									end
								end
										
								local function onInputEnded(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										dragging = false
										holdStarted = 0
									end
								end

								local function onInputChanged(input)
									if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
										dragInput = input
									end
								end
										
								SliderButton.InputBegan:Connect(onInputBegan)
								SliderButton.InputEnded:Connect(onInputEnded)
								SliderButton.InputChanged:Connect(onInputChanged)
										
								RunService.RenderStepped:Connect(function()
									if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
										dragging = true
									end
									if dragging and dragInput then
										local value = Precise and  tonumber(string.format("%.1f", (((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))) or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))
										pcall(function()
											callBackAndSetText(value)
										end)
										Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
									end
								end)
							else
								local dragging = false
								local dragInput
								local holdTime = 0
								local holdStarted = 0

								local function onInputBegan(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										holdStarted = tick()
										
										input.Changed:Connect(function()
											if input.UserInputState == Enum.UserInputState.End then
												dragging = false
												holdStarted = 0
											end
										end)
									end
								end
										
								local function onInputEnded(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										dragging = false
										holdStarted = 0
									end
								end

								local function onInputChanged(input)
									if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
										dragInput = input
									end
								end
										
								SliderButton.InputBegan:Connect(onInputBegan)
								SliderButton.InputEnded:Connect(onInputEnded)
								SliderButton.InputChanged:Connect(onInputChanged)
										
								RunService.RenderStepped:Connect(function()
									if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
										dragging = true
									end
									if dragging and dragInput then
										local value = Precise and  tonumber(string.format("%.1f", (((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))) or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))
										pcall(function()
											callBackAndSetText(value)
										end)
										Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
									end
								end)
							end
							local function GetSliderValue(Value)
								if tonumber(Value) <= minValue then
									Bar.Size = UDim2.new(0, (0 * SizeChia), 0, 6)
									callBackAndSetText(minValue)
								elseif tonumber(Value) >= maxValue then
									Bar.Size = UDim2.new(0, (maxValue  /  maxValue * SizeChia), 0, 6)
									callBackAndSetText(maxValue)
								else
									Bar.Size = UDim2.new(1 - ((maxValue - Value) / (maxValue - minValue)), 0, 0, 6)
									callBackAndSetText(Value)
								end
							end
							Sliderbox_2.FocusLost:Connect(function()
								GetSliderValue(Sliderbox_2.Text)
							end)
						end
					else
						for i, v in pairs (ListNew) do
							if typeof(v) == "string" then
								local SampleItem = Instance.new("Frame")
								local SampleItemCorner = Instance.new("UICorner")
								local SampleItemBG = Instance.new("Frame")
								local SampleItemBGCorner = Instance.new("UICorner")
								local SampleItemTitle = Instance.new("TextLabel")
								local SampleItemCheck = Instance.new("ImageButton")
								local SampleItemButton = Instance.new("TextButton")
								SampleItem.Name = string.lower(v)
								SampleItem.Parent = ScrollContainer
								SampleItem.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
								SampleItem.BackgroundTransparency = 1.000
								SampleItem.BorderColor3 = Color3.fromRGB(27, 42, 53)
								SampleItem.LayoutOrder = 1
								SampleItem.Position = UDim2.new(0, 0, 0.208333328, 0)
								SampleItem.Size = UDim2.new(1, 0, 0, 25)
								SampleItemCorner.CornerRadius = UDim.new(0, 4)
								SampleItemCorner.Name = "SampleItemCorner"
								SampleItemCorner.Parent = SampleItem
								SampleItemBG.Name = "SampleItemBG"
								SampleItemBG.Parent = SampleItem
								SampleItemBG.AnchorPoint = Vector2.new(0.5, 0.5)
								SampleItemBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemBG.BackgroundTransparency = 1
								SampleItemBG.BorderColor3 = Color3.fromRGB(27, 42, 53)
								SampleItemBG.Position = UDim2.new(0.5, 0, 0.5, 0)
								SampleItemBG.Size = UDim2.new(1, 0, 1, 0)
								SampleItemBGCorner.CornerRadius = UDim.new(0, 4)
								SampleItemBGCorner.Name = "SampleItemBGCorner"
								SampleItemBGCorner.Parent = SampleItemBG
								SampleItemTitle.Name = "SampleItemTitle"
								SampleItemTitle.Parent = SampleItemBG
								SampleItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemTitle.BackgroundTransparency = 1.000
								SampleItemTitle.BorderColor3 = Color3.fromRGB(27, 42, 53)
								SampleItemTitle.Position = UDim2.new(0, 10, 0, 0)
								SampleItemTitle.Size = UDim2.new(1, -40, 0, 25)
								SampleItemTitle.Font = Enum.Font.GothamBlack
								SampleItemTitle.Text = v
								SampleItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemTitle.TextSize = 14.000
								SampleItemTitle.TextStrokeTransparency = 0.500
								SampleItemTitle.TextXAlignment = Enum.TextXAlignment.Left
								SampleItemCheck.Name = "SampleItemCheck"
								SampleItemCheck.Parent = SampleItemBG
								SampleItemCheck.AnchorPoint = Vector2.new(1, 0.5)
								SampleItemCheck.BackgroundTransparency = 1.000
								SampleItemCheck.Position = UDim2.new(1, 0, 0.5, 0)
								SampleItemCheck.Size = UDim2.new(0, 25, 0, 25)
								SampleItemCheck.ZIndex = 2
								SampleItemCheck.Image = "rbxassetid://3926305904"
								SampleItemCheck.ImageColor3 = UIColor["Dropdown Selected Check Color"]
								SampleItemCheck.ImageRectOffset = Vector2.new(312, 4)
								SampleItemCheck.ImageRectSize = Vector2.new(24, 24)
								SampleItemCheck.ImageTransparency = 1
								SampleItemButton.Name = "SampleItemButton"
								SampleItemButton.Parent = SampleItem
								SampleItemButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemButton.BackgroundTransparency = 1.000
								SampleItemButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
								SampleItemButton.BorderSizePixel = 0
								SampleItemButton.Size = UDim2.new(1, 0, 1, 0)
								SampleItemButton.Font = Enum.Font.SourceSans
								SampleItemButton.TextColor3 = getgenv().UIColor["Text Color"]
								SampleItemButton.TextSize = 14.000
								SampleItemButton.TextTransparency = 1.000
								SampleItemButton.MouseEnter:Connect(function()
									if Sel.Value == v then
										return
									end
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									}
											):Play()
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundTransparency = .7
									}
											):Play()
								end)
								SampleItemButton.MouseLeave:Connect(function()
									if Sel.Value == v then
										return
									end
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									}
											):Play()
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundTransparency = 1
									}
											):Play()
								end)
								SampleItemButton.MouseButton1Click:Connect(function()
									if Search then
										Dropdowntitle.PlaceholderText = Title .. ': ' .. v or ""
										Sel.Value = v
									else
										Dropdowntitle.Text = Title .. ': ' .. v or ""
										Sel.Value = v
									end
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundColor3 = UIColor["Dropdown Selected Check Color"]
									}
											):Play()
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundTransparency = .5
									}
											):Play()
									if Callback then
										Callback(v)
									end
									if Search then
										Dropdowntitle.Text = ""
									end
									refreshlist()
								end)
								if Sel.Value == v then
									SampleItemBG.BackgroundTransparency = .5;
									SampleItemBG.BackgroundColor3 = UIColor["Dropdown Selected Check Color"]
									SampleItem.LayoutOrder = 0
								end
							end
						end
					end
				end
				if Search then
					Dropdowntitle.Changed:Connect(function()
						edit()
						SearchDropdown()
					end)
				end
				if typeof(Default) ~= 'table' then
					if Search then
						Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "")
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "")
					end
				elseif Slider then
					Dropdowntitle.Text = ''
					Dropdowntitle.PlaceholderText = Title .. ': '
				elseif Selected then
					if Search then
						Dropdowntitle.PlaceholderText = Title .. ': '
					else
						Dropdowntitle.Text = Title .. ': '
					end
				end
				DropdownButton.MouseButton1Click:Connect(function()
					refreshlist()
					isbusy = not isbusy
					local listsize = isbusy and UDim2.new(1, 0, 0, 170) or UDim2.new(1, 0, 0, 0)
					local mainsize = isbusy and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 25)
					local DropCRotation = isbusy and 90 or 0
					TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = listsize
					}):Play()
					TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = mainsize
					}):Play()
					TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Rotation = DropCRotation
					}):Play()
				end)
				local dropdownFunction = {
					rf = refreshlist
				}
				function dropdownFunction:ClearText(v)
					if not Selected then
						if Search then
							Dropdowntitle.PlaceholderText = Title .. ': ' .. (v or "")
						else
							Dropdowntitle.Text = Title .. ': ' .. (v or "")
						end
					else
						Dropdowntitle.Text = Title .. ': ' .. (v or "")
					end
				end
				function dropdownFunction:GetNewList(List)
					Sel.Value = ""
					isbusy = false
					local listsize = isbusy and UDim2.new(1, 0, 0, 170) or UDim2.new(1, 0, 0, 0)
					local mainsize = isbusy and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 25)
					local DropCRotation = isbusy and 90 or 0
					TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = listsize
					}):Play()
					TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = mainsize
					}):Play()
					TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Rotation = DropCRotation
					}):Play()
					ListNew = {}
					ListNew = List
					refreshlist()
					if Search then
						Dropdowntitle.PlaceholderText = Title .. ': '
					else
						Dropdowntitle.Text = Title .. ': '
					end
				end
                function dropdownFunction:SetValue(value)
                    if not Selected then
                        if table.find(ListNew, value) then
                            Sel.Value = value
                            if Search then
                                Dropdowntitle.PlaceholderText = Title .. ': ' .. value
                            else
                                Dropdowntitle.Text = Title .. ': ' .. value
                            end
                            if Callback then
                                Callback(value)
                            end
                            refreshlist()
                        end
                    else
                        if ListNew[value] ~= nil then
                            ListNew[value] = true
                            if Search then
                                Dropdowntitle.PlaceholderText = Title .. ': '
                            else
                                Dropdowntitle.Text = Title .. ': '
                            end
                            if Callback then
                                Callback(value, true)
                            end
                            refreshlist()
                        end
                    end
                end
                
                function dropdownFunction:GetValue()
                    if not Selected then
                        return Sel.Value
                    else
                        local result = {}
                        for key, val in pairs(ListNew) do
                            if val == true then
                                table.insert(result, key)
                            end
                        end
                        return result
                    end
                end
				local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = DropdownFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName,
                    SetValue = dropdownFunction.SetValue,
                    GetValue = dropdownFunction.GetValue
                }
                table.insert(getgenv().AllControls, controlData)
                
                return dropdownFunction
			end

function sectionFunction:AddKeyBind(Setting, Callback)
    local TitleText = tostring(Setting.Title or Setting.Text) or ""
    local Default = Setting.Default or Setting.Key or "F"
    local Mode = Setting.Mode or "Toggle"
    local Callback = Setting.Callback or Callback or function() end
    
    local function GetKeyString(key)
        local keyStr = tostring(key)
        keyStr = keyStr:gsub("Enum.UserInputType.", "")
        keyStr = keyStr:gsub("Enum.KeyCode.", "")
        return keyStr
    end
    
    local CurrentKey = GetKeyString(Default)
    local CurrentMode = Mode
    local Picking = false
    local ToggleState = false
    local HoldActive = false
    
    local BindFrame = Instance.new("Frame")
    local BindCorner = Instance.new("UICorner")
    local BindBG = Instance.new("Frame")
    local ButtonCorner = Instance.new("UICorner")
    local BindButtonTitle = Instance.new("TextLabel")
    local BindCor = Instance.new("Frame")
    local ButtonCorner_2 = Instance.new("UICorner")
    local Bindkey = Instance.new("TextButton")
    
    BindFrame.Name = TitleText .. "bguvl"
    BindFrame.Parent = Section
    BindFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    BindFrame.BackgroundTransparency = 1.000
    BindFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
    BindFrame.Size = UDim2.new(1, 0, 0, 35)
    
    BindCorner.CornerRadius = UDim.new(0, 4)
    BindCorner.Name = "BindCorner"
    BindCorner.Parent = BindFrame
    
    BindBG.Name = "Background1"
    BindBG.Parent = BindFrame
    BindBG.AnchorPoint = Vector2.new(0.5, 0.5)
    BindBG.Position = UDim2.new(0.5, 0, 0.5, 0)
    BindBG.Size = UDim2.new(1, -10, 1, 0)
    BindBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
    BindBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
    
    ButtonCorner.CornerRadius = UDim.new(0, 4)
    ButtonCorner.Name = "ButtonCorner"
    ButtonCorner.Parent = BindBG
    
    BindButtonTitle.Name = "TextColor"
    BindButtonTitle.Parent = BindBG
    BindButtonTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    BindButtonTitle.BackgroundTransparency = 1.000
    BindButtonTitle.Position = UDim2.new(0, 10, 0, 0)
    BindButtonTitle.Size = UDim2.new(1, -10, 1, 0)
    BindButtonTitle.Font = Enum.Font.GothamBlack
    BindButtonTitle.Text = TitleText
    BindButtonTitle.TextSize = 14.000
    BindButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
    BindButtonTitle.TextColor3 = getgenv().UIColor["Text Color"]
    
    BindCor.Name = "Background2"
    BindCor.Parent = BindBG
    BindCor.AnchorPoint = Vector2.new(1, 0.5)
    BindCor.Position = UDim2.new(1, -5, 0.5, 0)
    BindCor.Size = UDim2.new(0, 150, 0, 25)
    BindCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
    
    ButtonCorner_2.CornerRadius = UDim.new(0, 4)
    ButtonCorner_2.Name = "ButtonCorner"
    ButtonCorner_2.Parent = BindCor
    
    Bindkey.Name = "Bindkey"
    Bindkey.Parent = BindCor
    Bindkey.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    Bindkey.BackgroundTransparency = 1.000
    Bindkey.Size = UDim2.new(1, 0, 1, 0)
    Bindkey.Font = Enum.Font.GothamBold
    Bindkey.Text = CurrentKey
    Bindkey.TextSize = 14.000
    Bindkey.TextColor3 = getgenv().UIColor["Text Color"]
    
    Bindkey.MouseButton1Click:Connect(function()
        if Picking then return end
        
        Picking = true
        Bindkey.Text = "..."
        
        task.wait(0.2)
        
        local Connection
        Connection = uis.InputBegan:Connect(function(input)
            if Picking then
                local Key
                
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    Key = input.KeyCode.Name
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Key = "MouseLeft"
                elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                    Key = "MouseRight"
                end
                
                if Key then
                    Picking = false
                    CurrentKey = Key
                    Bindkey.Text = Key
                    Connection:Disconnect()
                end
            end
        end)
    end)
    
    uis.InputBegan:Connect(function(input, gpe)
        if gpe or Picking then return end
        if uis:GetFocusedTextBox() then return end
        
        local pressedKey
        if input.UserInputType == Enum.UserInputType.Keyboard then
            pressedKey = input.KeyCode.Name
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            pressedKey = "MouseLeft"
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            pressedKey = "MouseRight"
        end
        
        if pressedKey == CurrentKey then
            if CurrentMode == "Toggle" then
                ToggleState = not ToggleState
                pcall(Callback, ToggleState)
            elseif CurrentMode == "Hold" then
                HoldActive = true
                pcall(Callback, true)
            end
        end
    end)
    
    uis.InputEnded:Connect(function(input)
        if Picking then return end
        if uis:GetFocusedTextBox() then return end
        
        local releasedKey
        if input.UserInputType == Enum.UserInputType.Keyboard then
            releasedKey = input.KeyCode.Name
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            releasedKey = "MouseLeft"
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            releasedKey = "MouseRight"
        end
        
        if releasedKey == CurrentKey and CurrentMode == "Hold" and HoldActive then
            HoldActive = false
            pcall(Callback, false)
        end
    end)
    
    local controlData = {
        Name = TitleText,
        Section = Section,
        Element = BindFrame,
        SectionName = Section_Name,
        TabName = Page_Name,
        TabButton = PageName
    }
    table.insert(getgenv().AllControls, controlData)
    
    local keybindFunction = {}
    
    function keybindFunction:Set(newKey)
        CurrentKey = GetKeyString(newKey)
        Bindkey.Text = CurrentKey
    end
    
    function keybindFunction:Get()
        return CurrentKey
    end
    
    function keybindFunction:SetMode(mode)
        if mode == "Hold" or mode == "Toggle" then
            CurrentMode = mode
            ToggleState = false
            HoldActive = false
        end
    end
    
    function keybindFunction:GetMode()
        return CurrentMode
    end
    
    function keybindFunction:GetState()
        if CurrentMode == "Toggle" then
            return ToggleState
        elseif CurrentMode == "Hold" then
            return HoldActive
        end
        return false
    end
    
    return keybindFunction
end
			function sectionFunction:AddInput(idk, Setting)
				local TitleText = tostring(Setting.Text or Setting.Title) or ""
				local Placeholder = tostring(Setting.Placeholder) or ""
				local Default = Setting.Default or false
				local Number_Only = Setting.Numeric or false
				local Callback = Setting.Callback
				local BoxFrame = Instance.new("Frame")
				local BoxCorner = Instance.new("UICorner")
				local BoxBG = Instance.new("Frame")
				local ButtonCorner = Instance.new("UICorner")
				local Boxtitle = Instance.new("TextLabel")
				local BoxCor = Instance.new("Frame")
				local ButtonCorner_2 = Instance.new("UICorner")
				local Boxxx = Instance.new("TextBox")
				local Lineeeee = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				BoxFrame.Name = "BoxFrame"
				BoxFrame.Parent = Section
				BoxFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				BoxFrame.BackgroundTransparency = 1.000
				BoxFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
				BoxFrame.Size = UDim2.new(1, 0, 0, 60)
				BoxCorner.CornerRadius = UDim.new(0, 4)
				BoxCorner.Name = "BoxCorner"
				BoxCorner.Parent = BoxFrame
				BoxBG.Name = "Background1"
				BoxBG.Parent = BoxFrame
				BoxBG.AnchorPoint = Vector2.new(0.5, 0.5)
				BoxBG.Position = UDim2.new(0.5, 0, 0.5, 0)
				BoxBG.Size = UDim2.new(1, -10, 1, 0)
				BoxBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				BoxBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				ButtonCorner.CornerRadius = UDim.new(0, 4)
				ButtonCorner.Name = "ButtonCorner"
				ButtonCorner.Parent = BoxBG
				Boxtitle.Name = "TextColor"
				Boxtitle.Parent = BoxBG
				Boxtitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Boxtitle.BackgroundTransparency = 1.000
				Boxtitle.Position = UDim2.new(0, 10, 0, 0)
				Boxtitle.Size = UDim2.new(1, -10, 0.5, 0)
				Boxtitle.Font = Enum.Font.GothamBlack
				Boxtitle.Text = TitleText
				Boxtitle.TextSize = 14.000
				Boxtitle.TextXAlignment = Enum.TextXAlignment.Left
				Boxtitle.TextColor3 = getgenv().UIColor["Text Color"]
				BoxCor.Name = "Background2"
				BoxCor.Parent = BoxBG
				BoxCor.AnchorPoint = Vector2.new(1, 0.5)
				BoxCor.ClipsDescendants = true
				BoxCor.Position = UDim2.new(1, -5, 0, 40)
				BoxCor.Size = UDim2.new(1, -10, 0, 25)
				BoxCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				ButtonCorner_2.CornerRadius = UDim.new(0, 4)
				ButtonCorner_2.Name = "ButtonCorner"
				ButtonCorner_2.Parent = BoxCor
				Boxxx.Name = "TextColorPlaceholder"
				Boxxx.Parent = BoxCor
				Boxxx.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Boxxx.BackgroundTransparency = 1.000
				Boxxx.Position = UDim2.new(0, 5, 0, 0)
				Boxxx.Size = UDim2.new(1, -5, 1, 0)
				Boxxx.Font = Enum.Font.GothamBold
				Boxxx.PlaceholderText = Placeholder
				Boxxx.Text = ""
				Boxxx.TextSize = 14.000
				Boxxx.TextXAlignment = Enum.TextXAlignment.Left
				Boxxx.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
				Boxxx.TextColor3 = getgenv().UIColor["Text Color"]
				Lineeeee.Name = "TextNSBoxLineeeee"
				Lineeeee.Parent = BoxCor
				Lineeeee.BackgroundTransparency = 1.000
				Lineeeee.Position = UDim2.new(0, 0, 1, -2)
				Lineeeee.Size = UDim2.new(1, 0, 0, 6)
				Lineeeee.BackgroundColor3 = getgenv().UIColor["Box Highlight Color"]
				UICorner.CornerRadius = UDim.new(1, 0)
				UICorner.Parent = Lineeeee
				Boxxx.Focused:Connect(function()
					TweenService:Create(Lineeeee, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundTransparency = 0
					}):Play()
				end)
				if Number_Only then
					Boxxx:GetPropertyChangedSignal("Text"):Connect(function()
						if tonumber(Boxxx.Text) then
						else
							Boxxx.PlaceholderText = Placeholder
							Boxxx.Text = ''
						end
					end)
				end
				Boxxx.FocusLost:Connect(function()
					TweenService:Create(Lineeeee, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundTransparency = 1
					}):Play()
					if Boxxx.Text ~= '' then
						Callback(Boxxx.Text)
					end
				end)
				local textbox_function = {}
				if Default then
					Boxxx.Text = Default
				end
				function textbox_function.SetValue(Value)
					Boxxx.Text = Value
					Callback(Value)
				end
				local controlData = {
                    Name = TitleText,
                    Section = Section,
                    Element = BoxFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
				return textbox_function;
			end
			function sectionFunction:AddSlider(Setting)
				local TitleText = tostring(Setting.Text or Setting.Title) or ""
				local minValue = tonumber(Setting.Min) or 0
				local maxValue = tonumber(Setting.Max) or 100
				local Precise = Setting.Precise or false
				local DefaultValue = tonumber(Setting.Default) or 0
				local Callback = Setting.Callback
				local SizeChia = 400;
				local SliderFrame = Instance.new("Frame")
				local SliderCorner = Instance.new("UICorner")
				local SliderBG = Instance.new("Frame")
				local SliderBGCorner = Instance.new("UICorner")
				local SliderTitle = Instance.new("TextLabel")
				local SliderBar = Instance.new("Frame")
				local SliderButton = Instance.new("TextButton")
				local SliderBarCorner = Instance.new("UICorner")
				local Bar = Instance.new("Frame")
				local BarCorner = Instance.new("UICorner")
				local Sliderboxframe = Instance.new("Frame")
				local Sliderbox = Instance.new("UICorner")
				local Sliderbox_2 = Instance.new("TextBox")
				SliderFrame.Name = TitleText .. 'buda'
				SliderFrame.Parent = Section
				SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				SliderFrame.BackgroundTransparency = 1.000
				SliderFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
				SliderFrame.Size = UDim2.new(1, 0, 0, 50)
				SliderCorner.CornerRadius = UDim.new(0, 4)
				SliderCorner.Name = "SliderCorner"
				SliderCorner.Parent = SliderFrame
				SliderBG.Name = "Background1"
				SliderBG.Parent = SliderFrame
				SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
				SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
				SliderBG.Size = UDim2.new(1, -10, 1, 0)
				SliderBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				SliderBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				SliderBGCorner.CornerRadius = UDim.new(0, 4)
				SliderBGCorner.Name = "SliderBGCorner"
				SliderBGCorner.Parent = SliderBG
				SliderTitle.Name = "TextColor"
				SliderTitle.Parent = SliderBG
				SliderTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				SliderTitle.BackgroundTransparency = 1.000
				SliderTitle.Position = UDim2.new(0, 10, 0, 0)
				SliderTitle.Size = UDim2.new(1, -10, 0, 25)
				SliderTitle.Font = Enum.Font.GothamBlack
				SliderTitle.Text = TitleText
				SliderTitle.TextSize = 14.000
				SliderTitle.RichText = true
				SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
				SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
				SliderBar.Name = "SliderBar"
				SliderBar.Parent = SliderFrame
				SliderBar.AnchorPoint = Vector2.new(.5, 0.5)
				SliderBar.Position = UDim2.new(.5, 0, 0.5, 14)
				SliderBar.Size = UDim2.new(0, 400, 0, 6)
				SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				SliderButton.Name = "SliderButton "
				SliderButton.Parent = SliderBar
				SliderButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				SliderButton.BackgroundTransparency = 1.000
				SliderButton.Size = UDim2.new(1, 0, 1, 0)
				SliderButton.Font = Enum.Font.GothamBold
				SliderButton.Text = ""
				SliderButton.TextColor3 = Color3.fromRGB(230, 230, 230)
				SliderButton.TextSize = 14.000
				SliderBarCorner.CornerRadius = UDim.new(1, 0)
				SliderBarCorner.Name = "SliderBarCorner"
				SliderBarCorner.Parent = SliderBar
				Bar.Name = "Bar"
				Bar.BorderSizePixel = 0
				Bar.Parent = SliderBar
				Bar.Size = UDim2.new(0, 0, 1, 0)
				Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
				BarCorner.CornerRadius = UDim.new(1, 0)
				BarCorner.Name = "BarCorner"
				BarCorner.Parent = Bar
				Sliderboxframe.Name = "Background2"
				Sliderboxframe.Parent = SliderFrame
				Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
				Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
				Sliderboxframe.Size = UDim2.new(0, 150, 0, 25)
				Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				Sliderbox.CornerRadius = UDim.new(0, 4)
				Sliderbox.Name = "Sliderbox"
				Sliderbox.Parent = Sliderboxframe
				Sliderbox_2.Name = "TextColor"
				Sliderbox_2.Parent = Sliderboxframe
				Sliderbox_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Sliderbox_2.BackgroundTransparency = 1.000
				Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
				Sliderbox_2.Font = Enum.Font.GothamBold
				Sliderbox_2.Text = ""
				Sliderbox_2.TextSize = 14.000
				Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
				SliderButton.MouseEnter:Connect(function()
					TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"]
					}):Play()
				end)
				SliderButton.MouseLeave:Connect(function()
					TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
					}):Play()
				end)
				local callBackAndSetText = function(val)
					Sliderbox_2.Text = val
					Callback(tonumber(val))
				end
				if DefaultValue then
					if DefaultValue <= minValue then
						DefaultValue = minValue
					elseif DefaultValue >= maxValue then
						DefaultValue = maxValue
					end
					Sliderbox_2.Text = tostring(DefaultValue)
					Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 0, 6)
				end
				local dragging = false
				local dragInput
				local holdTime = 0
				local holdStarted = 0

				local function onInputBegan(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						holdStarted = tick()
						
						input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								dragging = false
								holdStarted = 0
							end
						end)
					end
				end
						
				local function onInputEnded(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
						holdStarted = 0
					end
				end

				local function onInputChanged(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
						dragInput = input
					end
				end
						
				SliderButton.InputBegan:Connect(onInputBegan)
				SliderButton.InputEnded:Connect(onInputEnded)
				SliderButton.InputChanged:Connect(onInputChanged)
						
				RunService.RenderStepped:Connect(function()
					if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
						dragging = true
					end
					if dragging and dragInput then
						local value = Setting.Rouding and  tonumber(string.format("%.".. Setting.Rouding or 1 .."f", (((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))) or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))
						pcall(function()
							callBackAndSetText(value)
						end)
						Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
					end
				end)
				local function GetSliderValue(Value)
					if tonumber(Value) <= minValue then
						Bar.Size = UDim2.new(0, (0 * SizeChia), 0, 6)
						callBackAndSetText(minValue)
					elseif tonumber(Value) >= maxValue then
						Bar.Size = UDim2.new(0, (maxValue  /  maxValue * SizeChia), 0, 6)
						callBackAndSetText(maxValue)
					else
						Bar.Size = UDim2.new(1 - ((maxValue - Value) / (maxValue - minValue)), 0, 0, 6)
						callBackAndSetText(Value)
					end
				end
				Sliderbox_2.FocusLost:Connect(function()
					GetSliderValue(Sliderbox_2.Text)
				end)
				local slider_function = {}
				function slider_function.SetValue(Value)
					GetSliderValue(Value)
				end
				local controlData = {
                    Name = TitleText,
                    Section = Section,
                    Element = SliderFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
				return slider_function
			end
			return sectionFunction
		end

        local _curSec = nil
        local function ensureSec()
            if not _curSec then
                _curSec = pageFunction:AddSection("")
            end
            return _curSec
        end

        local pagefunc = {}

        function pagefunc:AddSection(name)
            if type(name) == "table" then name = name[1] or "" end
            name = tostring(name or "")
            _curSec = pageFunction:AddSection(name)
            return _curSec
        end

        function pagefunc:AddToggle(setting)
            local sec = ensureSec()
            local id = tostring(setting.Name or setting.Title or "toggle")
            return sec:AddToggle(id, {
                Text     = setting.Name or setting.Title or "",
                Desc     = setting.Description or setting.Desc,
                Default  = setting.Default or setting.Value or false,
                Callback = setting.Callback,
            })
        end

        function pagefunc:AddButton(setting, cb)
            local sec = ensureSec()
            return sec:AddButton({
                Title    = setting.Name or setting.Title or "",
                Desc     = setting.Description or setting.Desc,
                Callback = setting.Callback or cb or function() end,
            })
        end

        function pagefunc:AddSlider(setting)
            local sec = ensureSec()
            local vt = setting.Value
            local minv = (type(vt) == "table" and vt.Min) or setting.Min or 0
            local maxv = (type(vt) == "table" and vt.Max) or setting.Max or 100
            local defv = (type(vt) == "table" and vt.Default) or setting.Default or minv
            return sec:AddSlider({
                Text     = setting.Name or setting.Title or "",
                Default  = defv,
                Min      = minv,
                Max      = maxv,
                Callback = setting.Callback,
            })
        end

        function pagefunc:AddInput(setting, cb)
            local sec = ensureSec()
            pcall(function()
                sec:AddInput(tostring(setting.Name or setting.Title or "input"), {
                    Name     = setting.Name or setting.Title or "",
                    Callback = setting.Callback or cb or function() end,
                })
            end)
        end

        function pagefunc:AddDropdown(setting)
            local sec = ensureSec()
            local id = tostring(setting.Name or setting.Title or "dropdown")
            local dd = sec:AddDropdown(id, {
                Text     = setting.Name or setting.Title or "",
                Values   = setting.Options or setting.Values or setting.List or {},
                Default  = setting.Default,
                Callback = setting.Callback,
            })
            if dd then
                function dd:Refresh(newList, _)
                    pcall(function()
                        if newList and #newList > 0 then
                            self:SetValue(newList[1])
                        end
                    end)
                end
            end
            return dd
        end

        function pagefunc:AddParagraph(setting)
            local prevSec = _curSec
            local sec = pageFunction:AddSection(setting.Title or "")
            local lbl = nil
            pcall(function() lbl = sec:AddLabel(setting.Desc or "") end)
            _curSec = prevSec
            local obj = {}
            function obj:SetDesc(text)
                pcall(function()
                    if lbl and lbl.SetText then lbl:SetText(tostring(text)) end
                end)
            end
            return obj
        end

        function pagefunc:AddTextBox(setting, cb)
            local sec = ensureSec()
            pcall(function()
                sec:AddInput(tostring(setting.Name or setting.Title or "input"), {
                    Name     = setting.Name or setting.Title or "",
                    Callback = setting.Callback or cb or function() end,
                })
            end)
        end

        function pagefunc:AddDiscordInvite(setting)
            local prevSec = _curSec
            local sec = pageFunction:AddSection(setting.Name or "Discord")
            pcall(function()
                sec:AddButton({
                    Title    = "Join Discord",
                    Callback = function()
                        pcall(function() setclipboard(setting.Invite or "") end)
                    end,
                })
            end)
            _curSec = prevSec
        end

        return pagefunc
        end

	return Main_Function
end

pcall(function()
	local Lighting = game:GetService("Lighting")
	local atmo = Lighting:FindFirstChildOfClass("Atmosphere")
	if atmo then atmo.Density = 0; atmo.Glare = 0; atmo.Haze = 0 end
	for _, eff in pairs(Lighting:GetChildren()) do
		if eff:IsA("BloomEffect") or eff:IsA("SunRaysEffect") or eff:IsA("DepthOfFieldEffect") then
			eff.Enabled = false
		end
	end
	pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
	end
end)

local HttpService = game:GetService("HttpService")
local FolderName = "TR6.1"
local ABFileName = "AbacaxiSettings.json"
local ABFullPath = FolderName .. "/" .. ABFileName

if makefolder and not isfolder(FolderName) then makefolder(FolderName) end

_G.SaveData = _G.SaveData or {}

function SaveSettings()
	if not writefile then return false end
	local ok = pcall(function()
		local json = HttpService:JSONEncode(_G.SaveData)
		writefile(ABFullPath, json)
	end)
	return ok
end

function LoadSettings()
	if not (isfile and isfile(ABFullPath)) then return false end
	local ok, result = pcall(function()
		return HttpService:JSONDecode(readfile(ABFullPath))
	end)
	if ok and result then _G.SaveData = result; return true end
	return false
end

function GetSetting(name, default)
	return _G.SaveData[name] ~= nil and _G.SaveData[name] or default
end

LoadSettings()

local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

local plr = Players.LocalPlayer
local ply = Players
local replicated = ReplicatedStorage
local Lv = plr.Data.Level.Value
local TW = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Enemies = workspace.Enemies
local vim1 = game:GetService("VirtualInputManager")
local vim2 = game:GetService("VirtualUser")

local Boss = {}
local BringConnections = {}
local MaterialList = {}
local NPCList = {}

local shouldTween = false
local SoulGuitar = false
local KenTest = true
local debug_mode = false
local Sec = 0.1
local ClickState = 0
local Num_self = 25

local PosMon = nil
local MonFarm = nil
local _B = false
local MousePos = nil
local HealthM = 0
local SelectIsland = "Cake"
local SelectMaterial = nil

repeat
	local loading = plr.PlayerGui:FindFirstChild("Main")
	loading = loading and loading:FindFirstChild("Loading")
	task.wait()
until game:IsLoaded() and not (loading and loading.Visible)

local placeId = game.PlaceId
local World1, World2, World3 = false, false, false
if placeId == 2753915549 or placeId == 85211729168715 then
	World1 = true
elseif placeId == 4442272183 or placeId == 79091703265657 then
	World2 = true
elseif placeId == 7449423635 or placeId == 100117331123089 then
	World3 = true
end

local Sea = World1 or World2 or World3

Marines = function()
	replicated.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
end

Pirates = function()
	replicated.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
end

if World1 then
	Boss = {"The Gorilla King","Bobby","The Saw","Yeti","Mob Leader","Vice Admiral","Saber Expert","Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God","Cyborg","Ice Admiral","Greybeard"}
	MaterialList = {"Leather + Scrap Metal","Angel Wings","Magma Ore","Fish Tail"}
elseif World2 then
	Boss = {"Diamond","Jeremy","Fajita","Don Swan","Smoke Admiral","Awakened Ice Admiral","Tide Keeper","Darkbeard","Cursed Captain","Order"}
	MaterialList = {"Leather + Scrap Metal","Radioactive Material","Ectoplasm","Mystic Droplet","Magma Ore","Vampire Fang"}
elseif World3 then
	Boss = {"Stone","Hydra Leader","Kilo Admiral","Captain Elephant","Beautiful Pirate","Cake Queen","Longma","Soul Reaper"}
	MaterialList = {"Scrap Metal","Demonic Wisp","Conjured Cocoa","Dragon Scale","Gunpowder","Fish Tail","Mini Tusk"}
end

local X = {"Cookie Crafter","Head Baker","Baking Staff","Cake Guard"}
local P = {"Reborn Skeleton","Posessed Mummy","Demonic Soul","Living Zombie"}

pcall(function()
	local O = workspace:FindFirstChild("Rocks")
	if O then O:Destroy() end
end)

pcall(function()
	local I = game:GetService("Lighting")
	I.Ambient = Color3.new(0.695, 0.695, 0.695)
	I.ColorShift_Bottom = Color3.new(0.695, 0.695, 0.695)
	I.ColorShift_Top = Color3.new(0.695, 0.695, 0.695)
	I.Brightness = 2
	I.FogEnd = 1e10
	local K = workspace._WorldOrigin["Foam;"]
	if K then K:Destroy() end
end)

pcall(function()
	hookfunction(require((game:GetService("ReplicatedStorage")).Effect.Container.Death), function() end)
	hookfunction((require((game:GetService("ReplicatedStorage")):WaitForChild("GuideModule"))).ChangeDisplayedNPC, function() end)
	hookfunction(error, function() end)
	hookfunction(warn, function() end)
end)

EquipWeapon = function(I)
	if not I then return end
	if plr.Backpack:FindFirstChild(I) then
		plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(I))
	end
end

weaponSc = function(I)
	for _, K in pairs(plr.Backpack:GetChildren()) do
		if K:IsA("Tool") and K.ToolTip == I then
			EquipWeapon(K.Name)
		end
	end
end

function AutoHaki()
	if not plr.Character:FindFirstChild("HasBuso") then
		pcall(function() replicated.Remotes.CommF_:InvokeServer("Buso") end)
	end
end

Useskills = function(I, e)
	if I == "Melee" then
		weaponSc("Melee")
		if e == "Z" then vim1:SendKeyEvent(true, "Z", false, game); vim1:SendKeyEvent(false, "Z", false, game)
		elseif e == "X" then vim1:SendKeyEvent(true, "X", false, game); vim1:SendKeyEvent(false, "X", false, game)
		elseif e == "C" then vim1:SendKeyEvent(true, "C", false, game); vim1:SendKeyEvent(false, "C", false, game) end
	elseif I == "Sword" then
		weaponSc("Sword")
		if e == "Z" then vim1:SendKeyEvent(true, "Z", false, game); vim1:SendKeyEvent(false, "Z", false, game)
		elseif e == "X" then vim1:SendKeyEvent(true, "X", false, game); vim1:SendKeyEvent(false, "X", false, game) end
	elseif I == "Blox Fruit" then
		weaponSc("Blox Fruit")
		if e == "Z" then vim1:SendKeyEvent(true, "Z", false, game); vim1:SendKeyEvent(false, "Z", false, game)
		elseif e == "X" then vim1:SendKeyEvent(true, "X", false, game); vim1:SendKeyEvent(false, "X", false, game)
		elseif e == "C" then vim1:SendKeyEvent(true, "C", false, game); vim1:SendKeyEvent(false, "C", false, game)
		elseif e == "V" then vim1:SendKeyEvent(true, "V", false, game); vim1:SendKeyEvent(false, "V", false, game) end
	elseif I == "Gun" then
		weaponSc("Gun")
		if e == "Z" then vim1:SendKeyEvent(true, "Z", false, game); vim1:SendKeyEvent(false, "Z", false, game)
		elseif e == "X" then vim1:SendKeyEvent(true, "X", false, game); vim1:SendKeyEvent(false, "X", false, game) end
	end
end

statsSetings = function(I, e)
	if I == "Melee" then
		if plr.Data.Points.Value ~= 0 then replicated.Remotes.CommF_:InvokeServer("AddPoint", "Melee", e) end
	elseif I == "Defense" then
		if plr.Data.Points.Value ~= 0 then replicated.Remotes.CommF_:InvokeServer("AddPoint", "Defense", e) end
	elseif I == "Sword" then
		if plr.Data.Points.Value ~= 0 then replicated.Remotes.CommF_:InvokeServer("AddPoint", "Sword", e) end
	elseif I == "Gun" then
		if plr.Data.Points.Value ~= 0 then replicated.Remotes.CommF_:InvokeServer("AddPoint", "Gun", e) end
	elseif I == "Devil" then
		if plr.Data.Points.Value ~= 0 then replicated.Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", e) end
	end
end

pcall(function()
	local J = getrawmetatable(game)
	local i = J.__namecall
	setreadonly(J, false)
	J.__namecall = newcclosure(function(...)
		local I = getnamecallmethod()
		local e = {...}
		if tostring(I) == "FireServer" then
			if tostring(e[1]) == "RemoteEvent" then
				if tostring(e[2]) ~= "true" and tostring(e[2]) ~= "false" then
					if _G.FarmMastery_G and not SoulGuitar or _G.FarmMastery_Dev or _G.Prehis_Skills or _G.SeaBeast1 or _G.FishBoat then
						e[2] = MousePos
						return i(unpack(e))
					end
				end
			end
		end
		return i(...)
	end)
end)

GetConnectionEnemies = function(I)
	local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	local bestMob, bestDist = nil, math.huge
	local function checkMob(K)
		if not K:IsA("Model") then return end
		local match = (typeof(I) == "table") and table.find(I, K.Name) or (K.Name == I)
		if not match then return end
		local hum = K:FindFirstChild("Humanoid")
		local root = K:FindFirstChild("HumanoidRootPart")
		if not hum or not root or hum.Health <= 0 then return end
		local d = hrp and (root.Position - hrp.Position).Magnitude or 0
		if d < bestDist then bestDist = d; bestMob = K end
	end
	for _, K in pairs(workspace.Enemies:GetChildren()) do checkMob(K) end
	for _, K in pairs(replicated:GetChildren()) do checkMob(K) end
	return bestMob
end

GetBP = function(I)
	return plr.Backpack:FindFirstChild(I) or plr.Character:FindFirstChild(I)
end

GetIn = function(I)
	for _, K in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
		if type(K) == "table" then
			if K.Name == I or plr.Character:FindFirstChild(I) or plr.Backpack:FindFirstChild(I) then
				return true
			end
		end
	end
	return false
end

GetM = function(I)
	for _, K in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
		if type(K) == "table" and K.Type == "Material" and K.Name == I then
			return K.Count
		end
	end
	return 0
end

GetWP = function(I)
	for _, K in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
		if type(K) == "table" and K.Type == "Sword" then
			if K.Name == I or plr.Character:FindFirstChild(I) or plr.Backpack:FindFirstChild(I) then
				return true
			end
		end
	end
	return false
end

UpdStFruit = function()
	for _, e in next, plr.Backpack:GetChildren() do
		StoreFruit = e:FindFirstChild("EatRemote", true)
		if StoreFruit then
			replicated.Remotes.CommF_:InvokeServer("StoreFruit", StoreFruit.Parent:GetAttribute("OriginalName"), plr.Backpack:FindFirstChild(e.Name))
		end
	end
end

collectFruits = function(I)
	if I then
		local ch = plr.Character
		for _, K in pairs(workspace:GetChildren()) do
			if string.find(K.Name, "Fruit") then
				K.Handle.CFrame = ch.HumanoidRootPart.CFrame
			end
		end
	end
end

DropFruits = function()
	for _, e in next, plr.Backpack:GetChildren() do
		if string.find(e.Name, "Fruit") then
			EquipWeapon(e.Name); task.wait(.1)
			if plr.PlayerGui.Main.Dialogue.Visible == true then plr.PlayerGui.Main.Dialogue.Visible = false end
			EquipWeapon(e.Name)
			pcall(function() (plr.Character:FindFirstChild(e.Name)).EatRemote:InvokeServer("Drop") end)
		end
	end
	for _, e in pairs(plr.Character:GetChildren()) do
		if string.find(e.Name, "Fruit") then
			EquipWeapon(e.Name); task.wait(.1)
			if plr.PlayerGui.Main.Dialogue.Visible == true then plr.PlayerGui.Main.Dialogue.Visible = false end
			EquipWeapon(e.Name)
			pcall(function() (plr.Character:FindFirstChild(e.Name)).EatRemote:InvokeServer("Drop") end)
		end
	end
end

LowCpu = function()
	local e = game
	local K = e.Workspace
	local n = e.Lighting
	local d = K.Terrain
	d.WaterWaveSize = 0; d.WaterWaveSpeed = 0; d.WaterReflectance = 0; d.WaterTransparency = 0
	n.GlobalShadows = false; n.FogEnd = 9000000000.0; n.Brightness = 1
	pcall(function() settings().Rendering.QualityLevel = "Level01" end)
	for _, K in pairs(e:GetDescendants()) do
		pcall(function()
			if K:IsA("Part") or K:IsA("Union") or K:IsA("CornerWedgePart") or K:IsA("TrussPart") then
				K.Material = "Plastic"; K.Reflectance = 0
			elseif K:IsA("Decal") or K:IsA("Texture") then
				K.Transparency = 1
			elseif K:IsA("ParticleEmitter") or K:IsA("Trail") then
				K.Lifetime = NumberRange.new(0)
			elseif K:IsA("Fire") or K:IsA("SpotLight") or K:IsA("Smoke") or K:IsA("Sparkles") then
				K.Enabled = false
			end
		end)
	end
end

getInfinity_Ability = function(I, e)
	if not plr.Character:FindFirstChild("HumanoidRootPart") then return end
	if I == "Soru" and e then
		for _, K in next, getgc() do
			if plr.Character.Soru then
				if typeof(K) == "function" and (getfenv(K)).script == plr.Character.Soru then
					for _, K2 in next, getupvalues(K) do
						if typeof(K2) == "table" then
							repeat task.wait(Sec); K2.LastUse = 0 until not e or plr.Character.Humanoid.Health <= 0
						end
					end
				end
			end
		end
	elseif I == "Energy" and e then
		plr.Character.Energy.Changed:connect(function()
			if e then plr.Character.Energy.Value = plr.Character.Energy.Value end
		end)
	elseif I == "Observation" and e then
		local I2 = plr.VisionRadius
		I2.Value = math.huge
	end
end

Hop = function()
	pcall(function()
		for I = math.random(1, math.random(40, 75)), 100, 1 do
			local e = replicated.__ServerBrowser:InvokeServer(I)
			for _, sv in next, e do
				if tonumber(sv.Count) < 12 then
					TeleportService:TeleportToPlaceInstance(game.PlaceId, _)
				end
			end
		end
	end)
end

shouldRequestEntrance = function(pos, dist)
	pcall(function()
		if (pos - plr.Character.HumanoidRootPart.Position).Magnitude >= (dist or 1000) then
			replicated.Remotes.CommF_:InvokeServer("requestEntrance", pos)
		end
	end)
end

local C = Instance.new("Part", workspace)
C.Size = Vector3.new(1,1,1); C.Name = "TRonVoidFarmPart"; C.Anchored = true
C.CanCollide = false; C.CanTouch = false; C.Transparency = 1
local existC = workspace:FindFirstChild(C.Name)
if existC and existC ~= C then existC:Destroy() end

getgenv().TweenSpeedFar = 350
getgenv().TweenSpeedNear = 700

task.spawn(function()
	local I = plr
	repeat task.wait() until I.Character and I.Character.PrimaryPart
	C.CFrame = I.Character.PrimaryPart.CFrame
	while task.wait() do
		pcall(function()
			if shouldTween then
				if C and C.Parent == workspace then
					local e = I.Character and I.Character.PrimaryPart
					if e and (e.Position - C.Position).Magnitude <= 200 then
						e.CFrame = C.CFrame
					else
						C.CFrame = e.CFrame
					end
				end
				local e = I.Character
				if e then
					for _, v in pairs(e:GetChildren()) do
						if v:IsA("BasePart") then v.CanCollide = false end
					end
				end
			else
				local e = I.Character
				if e then
					for _, v in pairs(e:GetChildren()) do
						if v:IsA("BasePart") then v.CanCollide = true end
					end
				end
			end
		end)
	end
end)

task.spawn(function()
	while task.wait() do
		pcall(function()
			if shouldTween then
				getgenv().OnFarm = true
			else
				getgenv().OnFarm = false
			end
		end)
	end
end)

local _currentTweenTarget = nil
local _currentTween       = nil
local _tpHB               = nil

local function _ensureTPHB()
	if _tpHB then return end
	_tpHB = game:GetService("RunService").Heartbeat:Connect(function()
		if not shouldTween then return end
		pcall(function()
			local ch = plr.Character; if not ch then return end
			local hrp = ch:FindFirstChild("HumanoidRootPart"); if not hrp then return end
			if C and C.Parent then
				local gap = (hrp.Position - C.Position).Magnitude
				if gap <= 200 then hrp.CFrame = C.CFrame else C.CFrame = hrp.CFrame end
			end
			for _, v in pairs(ch:GetChildren()) do
				if v:IsA("BasePart") then v.CanCollide = false end
			end
		end)
	end)
end

_tp = function(I)
	local e = plr.Character
	if not e or not e:FindFirstChild("HumanoidRootPart") then return end
	local HRP = e.HumanoidRootPart
	shouldTween = true; getgenv().OnFarm = false
	if HRP.Anchored then HRP.Anchored = false; task.wait() end
	local dist = (I.Position - HRP.Position).Magnitude
	local speed = dist <= 15 and (getgenv().TweenSpeedNear or 700) or (getgenv().TweenSpeedFar or 350)
	local info = TweenInfo.new(dist / speed, Enum.EasingStyle.Linear)
	local tween = game:GetService("TweenService"):Create(C, info, {CFrame = I})
	if e.Humanoid.Sit == true then
		C.CFrame = CFrame.new(C.Position.X, I.Y, C.Position.Z)
	end
	tween:Play()
	task.spawn(function()
		while tween.PlaybackState == Enum.PlaybackState.Playing do
			if not shouldTween then tween:Cancel(); break end
			task.wait(.1)
		end
		getgenv().OnFarm = true
	end)
end

function TweenPlayer(pos)
	local e = plr.Character
	if not e or not e:FindFirstChild("HumanoidRootPart") then return end
	local HRP = e.HumanoidRootPart
	local dist = (pos.Position - HRP.Position).Magnitude
	if dist < 5 then return end
	_ensureTPHB()
	shouldTween = true; _G.StopTween = false
	HRP.Anchored = false
	_currentTweenTarget = pos
	local tweenSpeed = getgenv().TweenSpeedFar or 350
	local info = TweenInfo.new(math.max(0.05, dist / tweenSpeed), Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	C.CFrame = HRP.CFrame
	local tween = game:GetService("TweenService"):Create(C, info, {CFrame = pos})
	_currentTween = tween
	tween:Play()
	task.spawn(function()
		while tween.PlaybackState == Enum.PlaybackState.Playing do
			if _G.StopTween then tween:Cancel(); break end
			task.wait(0.05)
		end
		_currentTween = nil; _currentTweenTarget = nil
		pcall(function()
			if e and e.Parent and HRP then
				HRP.Anchored = false
				local hum = e:FindFirstChildOfClass("Humanoid")
				if hum then
					if hum.WalkSpeed <= 0 then hum.WalkSpeed = 16 end
					if hum.JumpPower <= 0 then hum.JumpPower = 50 end
				end
			end
		end)
	end)
end

notween = function(I)
	plr.Character.HumanoidRootPart.CFrame = I
end

_G.BypassTeleportActive = false
function StopTween(State)
	if not State then
		if _G.BypassTeleportActive then return end
		_G.StopTween = true; shouldTween = false
		pcall(function() TweenPlayer(plr.Character.HumanoidRootPart.CFrame) end)
		pcall(function()
			if plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
				plr.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
			end
		end)
		_G.StopTween = false
	end
end

local BossList = {"Darkbeard","Greybeard","Saber Expert","Don Swan","Wyspr","Rip_indra","Rip Indra","Island Empress","Cake Queen","Order","Cursed Captain"}
local _BringTweenInfo = TweenInfo.new(0.45, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local TweenService = game:GetService("TweenService")

local function IsRaidMob(mob)
	local n = mob.Name:lower()
	if n:find("raid") or n:find("microchip") or n:find("island") then return true end
	if mob:GetAttribute("IsRaid") or mob:GetAttribute("RaidMob") or mob:GetAttribute("IsBoss") then return true end
	local hum = mob:FindFirstChild("Humanoid")
	if hum and hum.WalkSpeed == 0 then return true end
	return false
end

_G.BringRange = _G.BringRange or 235
_G.MobM = _G.MobM or 10
_G.MaxBringMobs = _G.MaxBringMobs or 3
_G.MobHeight = _G.MobHeight or 20

BringEnemy = function()
	if not _B then return end
	local char = plr.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	pcall(function() sethiddenproperty(plr, "SimulationRadius", math.huge) end)
	local targetPos = (PosMon and typeof(PosMon)=="Vector3" and PosMon)
		or (PosMon and typeof(PosMon)=="CFrame" and PosMon.Position)
		or hrp.Position
	local count = 0
	for _, mob in ipairs(workspace.Enemies:GetChildren()) do
		if count >= (_G.MobM or 10) then break end
		local hum = mob:FindFirstChild("Humanoid")
		local root = mob:FindFirstChild("HumanoidRootPart")
		if not hum or not root or hum.Health <= 0 then continue end
		if IsRaidMob(mob) then continue end
		local isBoss = false
		for _, b in ipairs(BossList) do if mob.Name == b then isBoss = true; break end end
		if isBoss then continue end
		local dist = (root.Position - targetPos).Magnitude
		if dist > (_G.BringRange or 235) then continue end
		count = count + 1
		pcall(function()
			hum.WalkSpeed = 0
			root.CanCollide = false
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
		end)
		local destCF = CFrame.new(targetPos.X, root.Position.Y, targetPos.Z)
		local tween = TweenService:Create(root, _BringTweenInfo, {CFrame = destCF})
		tween:Play()
	end
end

local env = game.ReplicatedStorage
local rs = game:GetService("ReplicatedStorage")
local modules = rs:WaitForChild("Modules")
local net = modules:WaitForChild("Net")
local enemyFolder = workspace:WaitForChild("Enemies")
local AttackModule = {}
local RegisterAttack = net:WaitForChild("RE/RegisterAttack")
local RegisterHit = net:WaitForChild("RE/RegisterHit")

function AttackModule:AttackEnemy(EnemyHead, Table)
	if EnemyHead then
		RegisterAttack:FireServer(0)
		RegisterAttack:FireServer(1)
		RegisterAttack:FireServer(2)
		RegisterAttack:FireServer(3)
		RegisterHit:FireServer(EnemyHead, Table or {})
	end
end

function AttackModule:AttackNearest()
	local mon = {nil, {}}
	for _, Enemy in enemyFolder:GetChildren() do
		if not mon[1] and Enemy:FindFirstChild("HumanoidRootPart", true) and plr:DistanceFromCharacter(Enemy.HumanoidRootPart.Position) < 60 then
			mon[1] = Enemy:FindFirstChild("HumanoidRootPart")
		elseif Enemy:FindFirstChild("HumanoidRootPart", true) and plr:DistanceFromCharacter(Enemy.HumanoidRootPart.Position) < 60 then
			table.insert(mon[2], {[1] = Enemy, [2] = Enemy:FindFirstChild("HumanoidRootPart")})
		end
	end
	self:AttackEnemy(unpack(mon))
end

function AttackModule:BladeHits()
	self:AttackNearest()
end

function Attack()
	task.wait(0.1)
	AttackModule:BladeHits()
end

G = {}
G.Alive = function(I)
	if not I then return end
	local e = I:FindFirstChild("Humanoid")
	return e and e.Health > 0
end

G.Kill = function(I, e)
	if not (I and e) then return end
	local hrp = I:FindFirstChild("HumanoidRootPart")
	local hum = I:FindFirstChild("Humanoid")
	if not hrp or not hum or hum.Health <= 0 then return end
	local char = plr.Character
	if not char then return end
	local myHRP = char:FindFirstChild("HumanoidRootPart")
	if not myHRP then return end
	PosMon = hrp.Position
	MonFarm = I.Name
	_B = true
	BringEnemy()
	EquipWeapon(_G.SelectWeapon or "")
	pcall(function() sethiddenproperty(plr, "SimulationRadius", math.huge) end)
	pcall(function() hum.WalkSpeed = 0; hrp.CanCollide = false end)
	local dist = (hrp.Position - myHRP.Position).Magnitude
	if dist > (_G.MobHeight or 20) + 5 then
		local targetCF = hrp.CFrame * CFrame.new(0, _G.MobHeight or 20, 0)
		_tp(targetCF)
	end
	local head = I:FindFirstChild("Head") or hrp
	pcall(function() AttackModule:AttackEnemy(head, {}) end)
end

G.Kill2 = function(I, e)
	if not (I and e) then return end
	local hrp = I:FindFirstChild("HumanoidRootPart")
	local hum = I:FindFirstChild("Humanoid")
	if not hrp or not hum or hum.Health <= 0 then return end
	PosMon = hrp.Position; MonFarm = I.Name; _B = true
	BringEnemy()
	EquipWeapon(_G.SelectWeapon or "")
	local tool = plr.Character and plr.Character:FindFirstChildOfClass("Tool")
	if tool then
		local offset = tool.ToolTip == "Blox Fruit"
			and CFrame.new(0, 10, 0) * CFrame.Angles(0, math.rad(90), 0)
			or CFrame.new(0, 20, 8) * CFrame.Angles(0, math.rad(180), 0)
		TweenPlayer(hrp.CFrame * offset)
	end
end

G.Mas = function(I, e)
	if not (I and e) then return end
	local hrp = I:FindFirstChild("HumanoidRootPart")
	local hum = I:FindFirstChild("Humanoid")
	if not hrp or not hum or hum.Health <= 0 then return end
	PosMon = hrp.Position; MonFarm = I.Name; _B = true
	BringEnemy()
	if hum.Health <= HealthM then
		_tp(hrp.CFrame * CFrame.new(0, 20, 0))
		if _G.FruitSkills then
			weaponSc("Blox Fruit")
			if _G.FruitSkills.Z then Useskills("Blox Fruit","Z") end
			if _G.FruitSkills.X then Useskills("Blox Fruit","X") end
			if _G.FruitSkills.C then Useskills("Blox Fruit","C") end
			if _G.FruitSkills.V then Useskills("Blox Fruit","V") end
			if _G.FruitSkills.F then vim1:SendKeyEvent(true,"F",false,game); vim1:SendKeyEvent(false,"F",false,game) end
		end
	else
		weaponSc("Melee")
		_tp(hrp.CFrame * CFrame.new(0, 30, 0))
	end
end

G.Masgun = function(I, e)
	if not (I and e) then return end
	local hrp = I:FindFirstChild("HumanoidRootPart")
	local hum = I:FindFirstChild("Humanoid")
	if not hrp or not hum or hum.Health <= 0 then return end
	PosMon = hrp.Position; MonFarm = I.Name; _B = true
	BringEnemy()
	if hum.Health <= HealthM then
		_tp(hrp.CFrame * CFrame.new(0, 35, 8))
		Useskills("Gun","Z"); Useskills("Gun","X")
	else
		weaponSc("Melee")
		_tp(hrp.CFrame * CFrame.new(0, 30, 0))
	end
end

task.spawn(function()
	game:GetService("RunService").Heartbeat:Connect(function()
		pcall(function()
			if setscriptable then setscriptable(plr, "SimulationRadius", true) end
			if sethiddenproperty then sethiddenproperty(plr, "SimulationRadius", math.huge) end
		end)
	end)
end)

task.spawn(function()
	while task.wait(2) do
		pcall(function()
			local char = plr.Character
			if not char then return end
			local hrp = char:FindFirstChild("HumanoidRootPart")
			local hum = char:FindFirstChildOfClass("Humanoid")
			if not hrp or not hum then return end
			if hrp.Anchored then hrp.Anchored = false end
			if hum.WalkSpeed <= 0 then hum.WalkSpeed = 16 end
		end)
	end
end)

_G.FruitSkills = {Z=false, X=false, C=false, V=false, F=false}

_G.SelectWeapon = _G.SelectWeapon or nil

local function GetNearestMobFromList(list)
	local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if not root then return nil end
	local nearest, dist2 = nil, math.huge
	for _, mob in pairs(workspace.Enemies:GetChildren()) do
		if table.find(list, mob.Name)
		and mob:FindFirstChild("HumanoidRootPart")
		and mob:FindFirstChild("Humanoid")
		and mob.Humanoid.Health > 0 then
			local d = (mob.HumanoidRootPart.Position - root.Position).Magnitude
			if d < dist2 then dist2 = d; nearest = mob end
		end
	end
	return nearest
end

local function HasAliveMob(list)
	for _, mob in pairs(workspace.Enemies:GetChildren()) do
		if table.find(list, mob.Name) and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
			return true
		end
	end
	return false
end

local function GetConnectionEnemies_Sea(name)
	return GetConnectionEnemies(name)
end

local Location = {}
for _, e in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
	table.insert(Location, e.Name)
end

local Location_Portal
if World1 then
	Location_Portal = {"Sky","UnderWater"}
elseif World2 then
	Location_Portal = {"SwanRoom","Cursed Ship"}
elseif World3 then
	Location_Portal = {"Castle On The Sea","Mansion Cafe","Hydra Teleport","Canvendish Room","Temple of Time"}
end

for _, e in pairs(replicated.NPCs:GetChildren()) do
	table.insert(NPCList, e.Name)
end

_G.Settings = {
	Main = {["Select Weapon"]="Melee",["Auto Farm"]=false},
	Farm = {["Auto Farm Chest Tween"]=false,["Auto Farm Chest Instant"]=false},
	Multi = {["Auto Fully Volcanic"]=false,["Auto Reset After Complete"]=false,["Auto Collect Egg"]=false,["Auto Collect Bone"]=false},
	Setting = {["Bring Mob"]=true,["Farm Distance"]=35,["Fast Attack"]=true,["Fast Attack New"]=false,["Player Tween Speed"]=350},
	SeaEvent = {["Selected Boat"]="Guardian",["Boat Tween Speed"]=300},
	Esp = {["ESP Player"]=false,["ESP Chest"]=false,["ESP DevilFruit"]=false,["ESP Island"]=false},
	DragonDojo = {["Auto Farm Blaze Ember"]=false},
	SeaStack = {},
	Race = {},
	Raid = {},
	FarmHop = {}
}

;(getgenv()).Load = function()
	if readfile and writefile and isfile and isfolder then
		if not isfolder("TR6.1") then makefolder("TR6.1") end
		if not isfolder("TR6.1/Blox Fruits/") then makefolder("TR6.1/Blox Fruits/") end
		local path = "TR6.1/Blox Fruits/" .. plr.Name .. ".json"
		if not isfile(path) then
			writefile(path, (game:GetService("HttpService")):JSONEncode(_G.Settings))
		else
			local ok, Decode = pcall(function()
				return (game:GetService("HttpService")):JSONDecode(readfile(path))
			end)
			if ok and Decode then
				for i, v in pairs(Decode) do _G.Settings[i] = v end
			end
		end
	end
end

;(getgenv()).SaveSetting = function()
	if readfile and writefile and isfile and isfolder then
		local path = "TR6.1/Blox Fruits/" .. plr.Name .. ".json"
		if not isfile(path) then
			(getgenv()).Load()
		else
			local Array = {}
			for i, v in pairs(_G.Settings) do Array[i] = v end
			writefile(path, (game:GetService("HttpService")):JSONEncode(Array))
		end
	end
end

pcall(function() (getgenv()).Load() end)

Number = math.random(1, 1000000)

local Pos = CFrame.new(0, _G.Settings.Setting["Farm Distance"] or 35, 0)
task.spawn(function()
	local angle = 0
	while task.wait(0.05) do
		Pos = CFrame.new(0, _G.Settings.Setting["Farm Distance"] or 35, 0)
	end
end)

local UIS2 = game:GetService("UserInputService")
local _movementKeys = {
	Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D,
	Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Left, Enum.KeyCode.Right,
	Enum.KeyCode.Space
}
UIS2.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	for _, key in ipairs(_movementKeys) do
		if input.KeyCode == key then
			shouldTween = false; _G.StopTween = false
			break
		end
	end
end)
UIS2.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.UserInputType == Enum.UserInputType.Touch then
		shouldTween = false; _G.StopTween = false
	end
end)
_G.FastAttackActive = false;
local _faRemote, _faIdRemote;
task.spawn(function()
	for _, v in next, ({game.ReplicatedStorage.Util, game.ReplicatedStorage.Common, game.ReplicatedStorage.Remotes,
		game.ReplicatedStorage.Assets, game.ReplicatedStorage.FX}) do
		pcall(function()
			for _, n in next, v:GetChildren() do
				if n:IsA("RemoteEvent") and n:GetAttribute("Id") then
					_faRemote, _faIdRemote = n, n:GetAttribute("Id");
				end;
			end;
			v.ChildAdded:Connect(function(n)
				if n:IsA("RemoteEvent") and n:GetAttribute("Id") then
					_faRemote, _faIdRemote = n, n:GetAttribute("Id");
				end;
			end);
		end);
	end;
end);
task.spawn(function()
	repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer.Character;
	while task.wait(0.05) do
		pcall(function()
			local farmActive = _G.Settings.Main["Auto Farm"]
				or _G.Settings.Main["Auto Farm Mon"]
				or _G.Settings.Main["Auto Farm Fast"]
				or _G.Settings.Main["Auto Farm All Boss"]
				or _G.Settings.Main["Auto Farm Boss"]
				or _G.Settings.Main["Auto Farm Fruit Mastery"]
				or _G.Settings.Main["Auto Farm Sword Mastery"]
				or _G.Settings.Main["Auto Farm Gun Mastery"]
				or _G.Settings.Farm["Auto Farm Bone"]
				or _G.Settings.Farm["Auto Farm Ectoplasm"]
				or _G.Settings.Farm["Auto Farm Katakuri"]
				or _G.Settings.Farm["Auto Farm Material"]
				or _G.EclipseStartFarm
				or _G.EclipseAutoTyrant;
			local fastAttackOn = _G.Settings.Setting["Fast Attack New"];
			if not (fastAttackOn or farmActive) then return; end;
			local char = game.Players.LocalPlayer.Character;
			local root = char and char:FindFirstChild("HumanoidRootPart");
			if not char or not root then return; end;
			local hum = char:FindFirstChildOfClass("Humanoid");
			if not hum or hum.Health <= 0 then return; end;
			local parts = {};
			for _, x in ipairs({workspace.Enemies, workspace.Characters}) do
				for _, v in ipairs(x and x:GetChildren() or {}) do
					local hrp = v:FindFirstChild("HumanoidRootPart");
					local vmhum = v:FindFirstChild("Humanoid");
					if v ~= char and hrp and vmhum and vmhum.Health > 0 and (hrp.Position - root.Position).Magnitude <= 60 then
						for _, _v in ipairs(v:GetChildren()) do
							if _v:IsA("BasePart") and (hrp.Position - root.Position).Magnitude <= 60 then
								parts[#parts + 1] = {v, _v};
							end;
						end;
					end;
				end;
			end;
			local tool = char:FindFirstChildOfClass("Tool");
			if #parts > 0 and tool and
				(tool:GetAttribute("WeaponType") == "Melee" or tool:GetAttribute("WeaponType") == "Sword") then
				pcall(function()
					require(game.ReplicatedStorage.Modules.Net):RemoteEvent("RegisterHit", true);
					game.ReplicatedStorage.Modules.Net["RE/RegisterAttack"]:FireServer();
					local head = parts[1][1]:FindFirstChild("Head");
					if not head then return; end;
					game.ReplicatedStorage.Modules.Net["RE/RegisterHit"]:FireServer(head, parts, {}, tostring(
						game.Players.LocalPlayer.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15));
					if _faRemote and _faIdRemote then
						cloneref(_faRemote):FireServer(string.gsub("RE/RegisterHit", ".", function(c)
							return string.char(
								bit32.bxor(string.byte(c), math.floor(workspace:GetServerTimeNow() / 10 % 10) + 1));
						end), bit32.bxor(_faIdRemote + 909090, game.ReplicatedStorage.Modules.Net.seed:InvokeServer() * 2), head, parts);
					end;
				end);
			end;
		end);
	end;
end);


pcall(function()
	local UIS = game:GetService("UserInputService");
	local _movementKeys = {
		Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D,
		Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Left, Enum.KeyCode.Right,
		Enum.KeyCode.Space
	};
	UIS.InputBegan:Connect(function(input, gpe)
		if gpe then return; end;
		for _, key in ipairs(_movementKeys) do
			if input.KeyCode == key then
				if not _G.EclipseStartFarm and not _G.SailBoats and not _G.EclipseAutoTyrant then
					shouldTween = false;
					_G.StopTween = false;
				end;
				break;
			end;
		end;
	end);
	UIS.InputBegan:Connect(function(input, gpe)
		if gpe then return; end;
		if input.UserInputType == Enum.UserInputType.Touch then
			if not _G.EclipseStartFarm and not _G.SailBoats and not _G.EclipseAutoTyrant then
				shouldTween = false;
				_G.StopTween = false;
			end;
		end;
	end);
	UIS.InputChanged:Connect(function(input, gpe)
		if gpe then return; end;
		if input.KeyCode == Enum.KeyCode.Thumbstick1 then
			local mag = Vector2.new(input.Position.X, input.Position.Y).Magnitude;
			if mag > 0.15 then
				if not _G.EclipseStartFarm and not _G.SailBoats and not _G.EclipseAutoTyrant then
					shouldTween = false;
					_G.StopTween = false;
				end;
			end;
		end;
	end);
end);

local Window = Library:CreateWindow({
    Title = "TRon Void Hub - Blox Fruit",
    SubTitle = "",
    SaveFolder = "TRonVoidHub.json",
    Image = "rbxassetid://133779423735605"
})

local InfoTab          = Window:AddTab("Tab | Discord")
local SettingsTab      = Window:AddTab("Tab | Settings")
local ServerTab        = Window:AddTab("Tab | Status And Server")
local ShopTab          = Window:AddTab("Tab | Shop")
local MainTab          = Window:AddTab("Tab | Main Farm")
local MultiFarmTab     = Window:AddTab("Tab | Multi Farm")
local FarmingHopTab    = Window:AddTab("Tab | Farming and Hop")
local FarmTab          = Window:AddTab("Tab | Farm Others")
local MaestryTab       = Window:AddTab("Tab | Mastery")
local OthersTab        = Window:AddTab("Tab | Others")
local EventTab         = Window:AddTab("Tab | Sea Event")
local RaceTab          = Window:AddTab("Tab | Race")
local DojoTab          = Window:AddTab("Tab | Dojo & Dragon")
local EspTab           = Window:AddTab("Tab | Esp & Stats")
local LocalPlayerTab   = Window:AddTab("Tab | Local Player")
local TeleportTab      = Window:AddTab("Tab | Teleport")
local GetTab           = Window:AddTab("Tab | Get Items")
local FruitTab         = Window:AddTab("Tab | Raid & Fruit")
local HoldAndSkillTab  = Window:AddTab("Tab | Hold And Skill")

task.delay(2, function()
    pcall(function()
        Library:Notify({
            Title = "TRon Void Hub",
            Content = "Script loaded! Welcome, " .. game.Players.LocalPlayer.Name,
            Icon = "rocket",
            Duration = 6
        })
    end)
end)

InfoTab:AddSection(" TRon Void Hub ");
InfoTab:AddParagraph({
	Title = "TRon Void Hub",
	Desc = "Version: R6.1 | Game: Blox Fruits\nMade for the TRon Void Community\nAll features are free to use."
});
InfoTab:AddParagraph({
	Title = " Discord Server",
	Desc = "Join our community for updates, support and more!\nLink: discord.gg/f4K5sDwKkn"
});
InfoTab:AddButton({
	Title = "Join TRon Void Community Discord",
	Desc = "Click to open the Discord invite link",
	Callback = function()
		setclipboard("https://discord.gg/f4K5sDwKkn");
		Library:Notify({Title = "TRon Void Hub", Content = "Discord link copied to clipboard!\ndiscord.gg/f4K5sDwKkn", Icon = "bell", Duration = 5});
	end
});
InfoTab:AddParagraph({
	Title = " Credits",
	Desc = "Owner: 4GIOT4\n\nTRon Void Hub R6.1 - Blox Fruits"
});
local function FHNotify(title, text, duration)
	pcall(function()
		Library:Notify({
			Title = title,
			Content = text,
			Icon = "bell",
			Duration = duration or 4
		});
	end);
end;

local Hop = function()
	FHNotify("Farm Hop", " Hoping Server...", 5);
	pcall(function()
		local TeleportService = game:GetService("TeleportService");
		local replicated = game:GetService("ReplicatedStorage");
		for i = math.random(1, math.random(40, 75)), 100, 1 do
			local e = replicated.__ServerBrowser:InvokeServer(i);
			for id, sv in next, e do
				if tonumber(sv.Count) < 12 then
					TeleportService:TeleportToPlaceInstance(game.PlaceId, id);
				end;
			end;
		end;
	end);
end;

local function SaveFH()
	pcall(function() (getgenv()).SaveSetting(); end);
end;

FarmingHopTab:AddSection(" Sea 1 Farms");

local _FHAutoSaw = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Saw Sword"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Saw Sword [Sea 1]",
	Desc = "Auto kill The Saw boss para Saw Sword",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Saw Sword"] or false,
	Callback = function(state)
		_FHAutoSaw = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Saw Sword"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.3) do
		pcall(function()
			if _FHAutoSaw then
				local mob = GetConnectionEnemies("The Saw");
				if mob then
					FHNotify("Saw Sword", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHAutoSaw);
					until not _FHAutoSaw or not mob.Parent or mob.Humanoid.Health <= 0;
					if not _FHAutoSaw then return end;
					FHNotify("Saw Sword", " Boss killed!", 3);
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906);
				end;
			end;
		end);
	end;
end);

local _FHAutoSaber = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Saber Sword"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Saber Sword [Sea 1]",
	Desc = "Auto complete Saber Expert quest chain - Sea 1",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Saber Sword"] or false,
	Callback = function(state)
		_FHAutoSaber = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Saber Sword"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.3) do
		pcall(function()
			local replicated = game:GetService("ReplicatedStorage");
			if _FHAutoSaber and World1 then
				local mob = GetConnectionEnemies("Saber Expert");
				if mob and G.Alive and G.Alive(mob) then
					FHNotify("Saber Sword", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHAutoSaber);
					until mob.Humanoid.Health <= 0 or not _FHAutoSaber;
					if mob.Humanoid.Health <= 0 then
						replicated.Remotes.CommF_:InvokeServer("ProQuestProgress","PlaceRelic");
						FHNotify("Saber Sword", " Quest step done!", 3);
					end;
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1401.85046, 29.9773273, 8.81916237);
				end;
			end;
		end);
	end;
end);

local _FHAutoUsoap = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Usoap Hat"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Usoap's Hat [Sea 1]",
	Desc = "Auto kill players perto para Usoap Hat",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Usoap Hat"] or false,
	Callback = function(state)
		_FHAutoUsoap = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Usoap Hat"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.3) do
		pcall(function()
			local plr = game.Players.LocalPlayer;
			if _FHAutoUsoap then
				local Root = plr.Character.HumanoidRootPart;
				for _, e in pairs(workspace.Characters:GetChildren()) do
					if e.Name ~= plr.Name and e:FindFirstChild("Humanoid") and e:FindFirstChild("HumanoidRootPart") then
						if e.Humanoid.Health > 0 and (Root.Position - e.HumanoidRootPart.Position).Magnitude <= 230 then
							repeat task.wait(0.1);
								EquipWeapon(_G.Settings.Main["Selected Weapon"]);
								plr.Character.HumanoidRootPart.CFrame = e.HumanoidRootPart.CFrame * CFrame.new(1,1,2);
							until not _FHAutoUsoap or e.Humanoid.Health <= 0 or not e.Parent;
						end;
					end;
				end;
			end;
		end);
	end;
end);

local _FHobsFarm = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Observation"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Farm Observation [All Seas]",
	Desc = "Auto farm Observation Haki (Ken) - Sea 1, 2 e 3",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Observation"] or false,
	Callback = function(state)
		_FHobsFarm = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Observation"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if _FHobsFarm then
				game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken",true);
				if game.Players.LocalPlayer:GetAttribute("KenDodgesLeft") == 0 then
					KenTest = false;
				elseif game.Players.LocalPlayer:GetAttribute("KenDodgesLeft") > 0 then
					KenTest = true;
				end;
			end;
		end);
	end;
end);
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			local plr = game.Players.LocalPlayer;
			if _FHobsFarm then
				local mobName = World1 and "Galley Captain" or World2 and "Lava Pirate" or "Venomous Assailant";
				local defaultPos = World1 and CFrame.new(5533.29785,88.1079102,4852.3916) or World2 and CFrame.new(-5478.39209,15.9775667,-5246.9126) or CFrame.new(4530.3540039063,656.75695800781,-131.60952758789);
				local mob = workspace.Enemies:FindFirstChild(mobName);
				if mob then
					repeat task.wait(0.1);
						plr.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * (KenTest and CFrame.new(3,0,0) or CFrame.new(0,50,0));
					until not _FHobsFarm or not mob.Parent;
				else
					plr.Character.HumanoidRootPart.CFrame = defaultPos;
				end;
			end;
		end);
	end;
end);

local _FHBones = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Bones"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Random Bone [All Seas]",
	Desc = "Auto buy Bones aleatoriamente para invocar bosses",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Bones"] or false,
	Callback = function(state)
		_FHBones = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Bones"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _FHBones then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1);
			end;
		end);
	end;
end);

local _FHBisento = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Bisento"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Bisento V2 [Sea 1]",
	Desc = "Auto kill Greybeard para Bisento - Sea 1",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Bisento"] or false,
	Callback = function(state)
		_FHBisento = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Bisento"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.3) do
		if _FHBisento then
			pcall(function()
				local replicated = game:GetService("ReplicatedStorage");
				replicated.Remotes.CommF_:InvokeServer("LoadItem","Bisento");
				local mob = GetConnectionEnemies("Greybeard");
				if mob then
					FHNotify("Bisento V2", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHBisento);
					until not _FHBisento or not mob.Parent or mob.Humanoid.Health <= 0;
					if mob and mob.Humanoid.Health <= 0 then
						FHNotify("Bisento V2", " Greybeard killed!", 3);
					end;
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5023.3833007812, 28.652032852173, 4332.3818359375);
				end;
			end);
		end;
	end;
end);


FarmingHopTab:AddSection(" Sea 2 Farms");

local _FHDarkbeard = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Darkbeard"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Darkbeard [Sea 2 + Hop]",
	Desc = "Auto kill Darkbeard - hops server se nao encontrado",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Darkbeard"] or false,
	Callback = function(state)
		_FHDarkbeard = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Darkbeard"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _FHDarkbeard and World2 then
				local mob = GetConnectionEnemies("Darkbeard");
				if mob then
					FHNotify("Darkbeard", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHDarkbeard);
					until not _FHDarkbeard or not mob.Parent or mob.Humanoid.Health <= 0;
					if not _FHDarkbeard then return end;
					FHNotify("Darkbeard", " Boss killed!", 3);
				else
					FHNotify("Darkbeard", " Hoping Server...", 4);
					TweenPlayer(CFrame.new(3798.4575195313, 13.826690673828, -3399.806640625));
					task.wait(1);
					if not GetConnectionEnemies("Darkbeard") then Hop(); end;
				end;
			end;
		end);
	end;
end);

local _FHWarden = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Warden"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Warden Sword [Sea 2]",
	Desc = "Auto kill Chief Warden para Warden Sword",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Warden"] or false,
	Callback = function(state)
		_FHWarden = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Warden"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.3) do
		pcall(function()
			if _FHWarden then
				local mob = GetConnectionEnemies("Chief Warden");
				if mob then
					FHNotify("Warden Sword", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHWarden);
					until not _FHWarden or not mob.Parent or mob.Humanoid.Health <= 0;
					if not _FHWarden then return end;
					FHNotify("Warden Sword", " Boss killed!", 3);
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5206.92578, .997753382, 814.976746);
				end;
			end;
		end);
	end;
end);

FarmingHopTab:AddSection(" Sea 3 Farms");

local _FHEliteQuest = false;
FarmingHopTab:AddToggle({
	Title = "Auto Elite Quest [Sea 3]",
	Desc = "Vai ate Diablo/Urban/Deandre, mata o boss elite, hops se nao achar",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Elite Quest"] or false,
	Callback = function(state)
		_FHEliteQuest = state;
		_G.FarmEliteHunt = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then
			_G.Settings.FarmHop["Auto Elite Quest"] = state;
			(getgenv()).SaveSetting();
		end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.FarmEliteHunt then
				if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
					local qt = game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text;
					if string.find(qt, "Diablo") or string.find(qt, "Urban") or string.find(qt, "Deandre") then
						for _, e in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
							if string.find(e.Name,"Diablo") or string.find(e.Name,"Urban") or string.find(e.Name,"Deandre") then
								if e:FindFirstChild("HumanoidRootPart") then
									TweenPlayer(e.HumanoidRootPart.CFrame);
								end;
							end;
						end;
						for _, e in pairs(workspace.Enemies:GetChildren()) do
							if (string.find(e.Name,"Diablo") or string.find(e.Name,"Urban") or string.find(e.Name,"Deandre")) and G.Alive(e) then
								repeat
									task.wait(0.1);
									G.Kill(e, _G.FarmEliteHunt);
									TweenPlayer(e.HumanoidRootPart.CFrame * Pos);
								until not _G.FarmEliteHunt or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible or not e.Parent or e.Humanoid.Health <= 0;
							end;
						end;
					end;
				else
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("EliteHunter");
				end;
				if game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice")
				   or game.Players.LocalPlayer.Backpack:FindFirstChild("Sweet Chalice")
				   or game.Players.LocalPlayer.Backpack:FindFirstChild("Fist of Darkness") then
					_G.FarmEliteHunt = false;
					_FHEliteQuest = false;
					FHNotify("Elite Quest", " Got rare item! Stopping.", 5);
				end;
			end;
		end);
	end;
end);

local _FHCitizenQuest = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Citizen Quest"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Citizen Quest / Ken V2 [Sea 3]",
	Desc = "Auto Citizen Quest para desbloquear Ken V2",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Citizen Quest"] or false,
	Callback = function(state)
		_FHCitizenQuest = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Citizen Quest"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			local plr = game.Players.LocalPlayer;
			local replicated = game:GetService("ReplicatedStorage");
			if _FHCitizenQuest and World3 then
				replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen");
				task.wait(0.1);
				replicated.Remotes.CommF_:InvokeServer("StartQuest","CitizenQuest",1);
				local mob = GetConnectionEnemies("Forest Pirate") or GetConnectionEnemies("Captain Elephant");
				if mob then
					repeat task.wait(0.1); G.Kill(mob, _FHCitizenQuest);
					until not _FHCitizenQuest or not mob.Parent or mob.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false;
				end;
			end;
		end);
	end;
end);

local _FHRipIndra = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Rip Indra"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Rip Indra [Sea 3 + Hop]",
	Desc = "Auto kill Rip Indra - hops server se nao encontrado",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Rip Indra"] or false,
	Callback = function(state)
		_FHRipIndra = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Rip Indra"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _FHRipIndra and World3 then
				local mob = GetConnectionEnemies("Rip_Indra");
				if mob then
					FHNotify("Rip Indra", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHRipIndra);
					until not _FHRipIndra or not mob.Parent or mob.Humanoid.Health <= 0;
					if not _FHRipIndra then return end;
					FHNotify("Rip Indra", " Boss killed!", 3);
				else
					TweenPlayer(CFrame.new(-12386.9, 364.3, -7590.2));
					task.wait(1);
					if not GetConnectionEnemies("Rip_Indra") then
						FHNotify("Rip Indra", " Hoping Server...", 4);
						Hop();
					end;
				end;
			end;
		end);
	end;
end);

local _FHMarineCoat = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Marine Coat"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Marine Coat [Sea 1 + Hop]",
	Desc = "Auto farm Marine Coat - hops se Vice Admiral nao encontrado",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Marine Coat"] or false,
	Callback = function(state)
		_FHMarineCoat = state;
		_G.MarinesCoat = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Marine Coat"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _FHMarineCoat then
				local mob = GetConnectionEnemies("Vice Admiral") or GetConnectionEnemies("Fleet Admiral");
				if mob then
					FHNotify("Marine Coat", " Vice Admiral Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHMarineCoat);
					until not _FHMarineCoat or not mob.Parent or mob.Humanoid.Health <= 0;
					if not _FHMarineCoat then return end;
					FHNotify("Marine Coat", " Boss killed! Restarting...", 3);
				else
					TweenPlayer(CFrame.new(-5039.58643, 27.3500385, 4324.68018));
					task.wait(1);
					if not GetConnectionEnemies("Vice Admiral") then
						FHNotify("Marine Coat", " Hoping Server...", 4);
						Hop();
					end;
				end;
			end;
		end);
	end;
end);

local _FHSwanCoat = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Swan Coat"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Swan Coat [Sea 2 + Hop]",
	Desc = "Auto kill Don Swan para Swan Coat - Sea 2 Swan Room",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Swan Coat"] or false,
	Callback = function(state)
		_FHSwanCoat = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Swan Coat"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _FHSwanCoat then
				local mob = GetConnectionEnemies("Don Swan");
				if mob then
					FHNotify("Swan Coat", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHSwanCoat);
					until not _FHSwanCoat or not mob.Parent or mob.Humanoid.Health <= 0;
					if not _FHSwanCoat then return end;
					FHNotify("Swan Coat", " Boss killed!", 3);
				else
					pcall(function() (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(2285, 15, 905)); end);
					task.wait(1);
					if not GetConnectionEnemies("Don Swan") then
						FHNotify("Swan Coat", " Hoping Server...", 4);
						Hop();
					end;
				end;
			end;
		end);
	end;
end);

local _FHGodChalice = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto God Chalice"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto God Chalice [Sea 3 + Hop]",
	Desc = "Auto farm God Chalice - hops quando boss nao encontrado",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto God Chalice"] or false,
	Callback = function(state)
		_FHGodChalice = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto God Chalice"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _FHGodChalice then
				local mob = GetConnectionEnemies("Order") or GetConnectionEnemies("Cake Queen");
				if mob then
					FHNotify("God Chalice", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHGodChalice);
					until not _FHGodChalice or not mob.Parent or mob.Humanoid.Health <= 0;
					if not _FHGodChalice then return end;
					FHNotify("God Chalice", " Boss killed!", 3);
				else
					FHNotify("God Chalice", " Hoping Server...", 4);
					task.wait(1);
					Hop();
				end;
			end;
		end);
	end;
end);

local _FHSkullGuitarMat = false;
FarmingHopTab:AddSection(" Material Farm");
FarmingHopTab:AddToggle({
	Title = "Auto Farm Material Skull Guitar",
	Desc = "Detecta e farma: 250 Ectoplasma (Haunted Ship Sea 2), 500 Bones (Haunted Castle Sea 2), 1 Dark Fragment (Darkbeard Sea 2). Ordem: Darkbeard > Ectoplasma > Ossos.",
	Value = false,
	Callback = function(state)
		_FHSkullGuitarMat = state;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Skull Guitar Mat"] = state; (getgenv()).SaveSetting(); end;
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if not _FHSkullGuitarMat or not World2 then return; end;
			local plr = game.Players.LocalPlayer;
			local hasEcto  = CheckItemCount and CheckItemCount("Ectoplasm", 250);
			local hasBones = CheckItemCount and CheckItemCount("Bone", 500);
			local hasFrag  = CheckItemCount and CheckItemCount("Dark Fragment", 1);
			if not hasFrag then
				local mob = GetConnectionEnemies("Darkbeard");
				if mob then
					FHNotify("Skull Guitar", "Matando Darkbeard...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHSkullGuitarMat);
					until not _FHSkullGuitarMat or not mob.Parent or mob.Humanoid.Health <= 0;
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3798.4575195313, 13.826690673828, -3399.806640625);
				end;
			elseif not hasEcto then
				local mob = workspace.Enemies:FindFirstChild("Zombie") or workspace.Enemies:FindFirstChild("Demonic Soul") or workspace.Enemies:FindFirstChild("Cursed Skeleton");
				if mob then
					repeat task.wait(0.1); G.Kill(mob, _FHSkullGuitarMat);
					until not _FHSkullGuitarMat or not mob.Parent or mob.Humanoid.Health <= 0;
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3898, 22, -4100);
				end;
			elseif not hasBones then
				local mob = workspace.Enemies:FindFirstChild("Possessed Mummy") or workspace.Enemies:FindFirstChild("Reaper") or workspace.Enemies:FindFirstChild("Cursed Skeleton");
				if mob then
					repeat task.wait(0.1); G.Kill(mob, _FHSkullGuitarMat);
					until not _FHSkullGuitarMat or not mob.Parent or mob.Humanoid.Health <= 0;
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5000, 22, -3200);
				end;
			else
				_FHSkullGuitarMat = false;
				FHNotify("Skull Guitar", "Todos os materiais coletados!", 6);
			end;
		end);
	end;
end);



local MMon = {}
local MPos = CFrame.new(0,0,0)
local CFrameQuest, CFrameMon, NameQuest, LevelQuest
local Mon, Qdata, Qname, PosQ, PosM, PosB, PosQBoss, bMon
local SelectWeaponG = nil

MaterialMon = function()
	local e = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if not e then return end
	if World1 then
		if SelectMaterial == "Angel Wings" then
			MMon = {"Shanda","Royal Squad","Royal Soldier","Wysper","Thunder God"}
			MPos = CFrame.new(-4698,845,-1912)
			shouldRequestEntrance(Vector3.new(-4607.82,872.54,-1667.55),10000)
		elseif SelectMaterial == "Leather + Scrap Metal" then
			MMon = {"Brute","Pirate"}; MPos = CFrame.new(-1145,15,4350)
		elseif SelectMaterial == "Magma Ore" then
			MMon = {"Military Soldier","Military Spy","Magma Admiral"}; MPos = CFrame.new(-5815,84,8820)
		elseif SelectMaterial == "Fish Tail" then
			MMon = {"Fishman Warrior","Fishman Commando","Fishman Lord"}; MPos = CFrame.new(61123,19,1569)
			shouldRequestEntrance(Vector3.new(61163.85,5.34,1819.78),17000)
		end
	elseif World2 then
		if SelectMaterial == "Leather + Scrap Metal" then
			MMon = {"Marine Captain"}; MPos = CFrame.new(-2010.50,73.001,-3326.62)
		elseif SelectMaterial == "Magma Ore" then
			MMon = {"Magma Ninja","Lava Pirate"}; MPos = CFrame.new(-5428,78,-5959)
		elseif SelectMaterial == "Ectoplasm" then
			MMon = {"Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer"}
			MPos = CFrame.new(911.35,125.95,33159.53)
			shouldRequestEntrance(Vector3.new(923.21,126.97,32852.83),1000)
		elseif SelectMaterial == "Mystic Droplet" then
			MMon = {"Water Fighter"}; MPos = CFrame.new(-3385,239,-10542)
		elseif SelectMaterial == "Radioactive Material" then
			MMon = {"Factory Staff"}; MPos = CFrame.new(295,73,-56)
		elseif SelectMaterial == "Vampire Fang" then
			MMon = {"Vampire"}; MPos = CFrame.new(-6033,7,-1317)
		end
	elseif World3 then
		if SelectMaterial == "Scrap Metal" then
			MMon = {"Jungle Pirate","Forest Pirate"}; MPos = CFrame.new(-11975.78,331.77,-10620.03)
		elseif SelectMaterial == "Fish Tail" then
			MMon = {"Fishman Raider","Fishman Captain"}; MPos = CFrame.new(-10993,332,-8940)
		elseif SelectMaterial == "Conjured Cocoa" then
			MMon = {"Chocolate Bar Battler","Cocoa Warrior"}; MPos = CFrame.new(620.63,78.93,-12581.36)
		elseif SelectMaterial == "Dragon Scale" then
			MMon = {"Dragon Crew Archer","Dragon Crew Warrior"}; MPos = CFrame.new(6594,383,139)
		elseif SelectMaterial == "Gunpowder" then
			MMon = {"Pistol Billionaire"}; MPos = CFrame.new(-84.85,85.62,6132.008)
		elseif SelectMaterial == "Mini Tusk" then
			MMon = {"Mythological Pirate"}; MPos = CFrame.new(-13545,470,-6917)
		elseif SelectMaterial == "Demonic Wisp" then
			MMon = {"Demonic Soul"}; MPos = CFrame.new(-9495.68,453.58,5977.34)
		end
	end
end

ShopSection = ShopTab:AddSection("Shop");
AutoBuyLegendarySwordToggle = ShopTab:AddToggle({
	Title = "Auto Buy Legendary Sword",
	Value = _G.Settings.Shop["Auto Buy Legendary Sword"],
	Callback = function(state)
		_G.Settings.Shop["Auto Buy Legendary Sword"] = state;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.Shop["Auto Buy Legendary Sword"] then
			pcall(function()
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1");
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2");
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3");
			end);
		end;
	end;
end);
AutoBuyHakiColorToggle = ShopTab:AddToggle({
	Title = "Auto Buy Haki Color",
	Value = _G.Settings.Shop["Auto Buy Haki Color"],
	Callback = function(state)
		_G.Settings.Shop["Auto Buy Haki Color"] = state;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.Shop["Auto Buy Haki Color"] then
			(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ColorsDealer", "2");
		end;
	end;
end);
AbilitiesShopSection = ShopTab:AddSection("Abilities");
BuyGeppoButton = ShopTab:AddButton({
	Title = "Buy Geppo",
	Desc = "$10,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyHaki", "Geppo");
	end
});
BuyBusoHaki = ShopTab:AddButton({
	Title = "Buy Buso Haki",
	Desc = "$25,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyHaki", "Buso");
	end
});
BuySoruButton = ShopTab:AddButton({
	Title = "Buy Soru",
	Desc = "$25,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyHaki", "Soru");
	end
});
BuyObservationHakiButton = ShopTab:AddButton({
	Title = "Buy Observation Haki",
	Desc = "$750,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("KenTalk", "Buy");
	end
});
ShopTab:AddSection(" Buy Fight Styles - Tween to NPC");

local FightStyleNPCs = {
	["Black Leg"]      = {npc="Black Leg Teacher",   pos=CFrame.new(-988, 13, 3996),           buy="BuyBlackLeg"},
	["Electro"]        = {npc="Mad Scientist",        pos=CFrame.new(61050, 19, 1537),          buy="BuyElectro",   portal=Vector3.new(61163.8,11.7,1819.8)},
	["Fishman Karate"] = {npc="Fishman Karate Teacher",pos=CFrame.new(61584.35, 18.85, 988.89), buy="BuyFishmanKarate"},
	["Superhuman"]     = {npc="Martial Arts Master",  pos=CFrame.new(1378.05, 247.43, -5189.37),buy="BuySuperhuman"},
	["Death Step"]     = {npc="Phoeyu, the Reformed", pos=CFrame.new(6360.04, 296.67, -6763.93),buy="BuyDeathStep"},
	["Sharkman Karate"]= {npc="Sharkman Karate Teacher",pos=CFrame.new(-2602.40, 239.22, -10314.75),buy="BuySharkmanKarate"},
	["Electric Claw"]  = {npc="Previous Hero",        pos=CFrame.new(-10369.83,331.69,-10126.49),buy="BuyElectricClaw"},
	["Dragon Talon"]   = {npc="UzothDragon",          pos=CFrame.new(5662.03,1211.32,858.60),   buy="BuyDragonTalon"},
	["God Human"]      = {npc="Ancient Monk",          pos=CFrame.new(-13775.56,334.66,-9877.67),buy="BuyGodhuman"},
	["Sanguine Art"]   = {npc="Shafi",                pos=CFrame.new(-16514.86,23.18,-190.84),  buy="BuySanguineArt"},
	["Water Kung Fu"]  = {npc="Water Kung Fu Teacher", pos=CFrame.new(-4960.04, 35.08, -4662.67),buy="BuyFishmanKarate", submerged=true},
};

local FightStyleOrder = {
	"Black Leg","Electro","Fishman Karate","Superhuman","Death Step",
	"Sharkman Karate","Electric Claw","Dragon Talon","God Human","Sanguine Art","Water Kung Fu"
};

local SelectedFightStyle = FightStyleOrder[1];
ShopTab:AddDropdown({
	Title = "Select Fight Style",
	Values = FightStyleOrder,
	Value = FightStyleOrder[1],
	Callback = function(v) SelectedFightStyle = v; end
});

local function BuyFightStyleFull(styleName)
	local data = FightStyleNPCs[styleName];
	if not data then
		Library:Notify({Title = "TRon Void Hub", Content = "Estilo nao encontrado: " .. tostring(styleName), Icon = "alert-triangle", Duration = 4});
		return;
	end;
	local plr = game.Players.LocalPlayer;
	local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
	if not hrp then return; end;
	if data.portal then
		pcall(function()
			(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", data.portal);
		end);
		task.wait(2);
		hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
		if not hrp then return; end;
	end;
	if data.submerged then
		local SubWorkerCF = CFrame.new(-16417.6, 74.26, 1811.3);
		TweenPlayer(SubWorkerCF);
		local tw = 0;
		repeat task.wait(0.2); tw=tw+0.2; until (hrp.Position - SubWorkerCF.Position).Magnitude < 18 or tw > 15;
		task.wait(0.5);
		pcall(function()
			(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("NPC", "Submarine Worker");
		end);
		task.wait(0.5);
		pcall(function()
			game:GetService("ReplicatedStorage").Modules.Net["RF/SubmarineWorkerSpeak"]:InvokeServer("TravelToSubmergedIsland");
		end);
		tw = 0;
		repeat task.wait(0.3); tw=tw+0.3; until hrp.Position.Y < -200 or tw > 18;
		task.wait(1);
		hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
		if not hrp then return; end;
	end;
	TweenPlayer(data.pos);
	local t = 0;
	repeat task.wait(0.2); t=t+0.2; until (hrp.Position - data.pos.Position).Magnitude < 15 or t > 20;
	task.wait(0.5);
	pcall(function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("NPC", data.npc);
	end);
	task.wait(0.6);
	pcall(function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(data.buy);
	end);
	task.wait(0.3);
	pcall(function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(data.buy, true);
	end);
	Library:Notify({Title = "TRon Void Hub", Content = "Compra enviada: " .. styleName, Icon = "check", Duration = 4});
end;

ShopTab:AddButton({
	Title = " Go Buy Selected Fight Style",
	Desc = "Tween ate o NPC, faz dialogo e compra o estilo selecionado",
	Callback = function()
		task.spawn(function() pcall(BuyFightStyleFull, SelectedFightStyle); end);
	end
});

local _autoBuyAllActive = false;
ShopTab:AddToggle({
	Title = "Auto Buy All Fight Styles",
	Desc = "Vai em cada NPC em ordem e compra todos os estilos",
	Value = false,
	Callback = function(state)
		_autoBuyAllActive = state;
		if state then
			task.spawn(function()
				for _, styleName in ipairs(FightStyleOrder) do
					if not _autoBuyAllActive then break; end;
					pcall(BuyFightStyleFull, styleName);
					task.wait(1.5);
				end;
				_autoBuyAllActive = false;
			end);
		end;
	end
});
SwordShopSection = ShopTab:AddSection("Sword");
BuyCutlassButton = ShopTab:AddButton({
	Title = "Buy Cutlass",
	Desc = "$1,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Cutlass");
	end
});
BuyKatanaButton = ShopTab:AddButton({
	Title = "Buy Katana",
	Desc = "$1,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Katana");
	end
});
BuyIronMaceButton = ShopTab:AddButton({
	Title = "Buy Iron Mace",
	Desc = "$25,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace");
	end
});
BuyDualKatanaButton = ShopTab:AddButton({
	Title = "Buy Dual Katana",
	Desc = "$12,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Dual Katana");
	end
});
BuyTripleKatanaButton = ShopTab:AddButton({
	Title = "Buy Triple Katana",
	Desc = "$60,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana");
	end
});
BuyPipeButton = ShopTab:AddButton({
	Title = "Buy Pipe",
	Desc = "$100,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Pipe");
	end
});
BuyDualHeadedBladeButton = ShopTab:AddButton({
	Title = "Buy Dual Headed Blade",
	Desc = "$400,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade");
	end
});
BuyBisentoButton = ShopTab:AddButton({
	Title = "Buy Bisento",
	Desc = "$1,200,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Bisento");
	end
});
BuySoulCaneButton = ShopTab:AddButton({
	Title = "Buy Soul Cane",
	Desc = "$1,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane");
	end
});
GunShopSection = ShopTab:AddSection("Gun");
BuySlingshotButton = ShopTab:AddButton({
	Title = "Buy Slingshot",
	Desc = "$5,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Slingshot");
	end
});
BuyMusketButton = ShopTab:AddButton({
	Title = "Buy Musket",
	Desc = "$8,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Musket");
	end
});
BuyFintlockButton = ShopTab:AddButton({
	Title = "Buy Flintlock",
	Desc = "$10,500",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Flintlock");
	end
});
BuyRefinedFintlockButton = ShopTab:AddButton({
	Title = "Buy Refined Fintlock",
	Desc = "$60,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Refined Fintlock");
	end
});
BuyCanonButton = ShopTab:AddButton({
	Title = "Buy Cannon",
	Desc = "$100,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Cannon");
	end
});
BuyKabuchaButton = ShopTab:AddButton({
	Title = "Buy Kabucha",
	Desc = "B$1,500",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "1");
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "2");
	end
});
StatsShopSection = ShopTab:AddSection("Stats");
ResetStatsShopButton = ShopTab:AddButton({
	Title = "Reset Stats",
	Desc = "B$2,500",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1");
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2");
	end
});
RandomRaceShopButton = ShopTab:AddButton({
	Title = "Random Race",
	Desc = "B$3,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "1");
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2");
	end
});
AccessoriesShopSection = ShopTab:AddSection("Accessories");
BuyBlackCapeButton = ShopTab:AddButton({
	Title = "Buy Black Cape",
	Desc = "$50,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Black Cape");
	end
});
BuySwordsmanHatButton = ShopTab:AddButton({
	Title = "Buy Swordsman Hat",
	Desc = "$150,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Swordsman Hat");
	end
});
BuyTomoeRingButton = ShopTab:AddButton({
	Title = "Buy Tomoe Ring",
	Desc = "$500,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Tomoe Ring");
	end
});

local IslandList = {};
if World1 then
	IslandList = {
		"WindMill",
		"Marine",
		"Middle Town",
		"Jungle",
		"Pirate Village",
		"Desert",
		"Snow Island",
		"MarineFord",
		"Colosseum",
		"Sky Island 1",
		"Sky Island 2",
		"Sky Island 3",
		"Prison",
		"Magma Village",
		"Under Water Island",
		"Fountain City",
		"Shank Room",
		"Mob Island"
	};
elseif World2 then
	IslandList = {
		"The Cafe",
		"Frist Spot",
		"Dark Area",
		"Flamingo Mansion",
		"Flamingo Room",
		"Green Zone",
		"Factory",
		"Colossuim",
		"Zombie Island",
		"Two Snow Mountain",
		"Punk Hazard",
		"Cursed Ship",
		"Ice Castle",
		"Forgotten Island",
		"Ussop Island",
		"Mini Sky Island"
	};
elseif World3 then
	IslandList = {
		"Mansion",
		"Port Town",
		"Great Tree",
		"Castle On The Sea",
		"MiniSky",
		"Hydra Island",
		"Floating Turtle",
		"Haunted Castle",
		"Ice Cream Island",
		"Peanut Island",
		"Cake Island",
		"Cocoa Island",
		"Candy Island",
		"Tiki Outpost",
		"Dragon Dojo"
	};
end;
local EclipseIslandList = {};
pcall(function()
	for _, loc in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
		table.insert(EclipseIslandList, loc.Name);
	end;
end);
local PortalIslands = {
	["Sky Island 2"]         = Vector3.new(-4607.82275, 872.54248, -1667.55688),
	["Sky Island 3"]         = Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047),
	["Under Water Island"]   = Vector3.new(61163.8515625, 11.6796875, 1819.7841796875),
	["Castle On The Sea"]    = Vector3.new(-5083.26025390625, 314.6056823730469, -3175.673095703125),
	["Mansion"]              = Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375),
	["Hydra Island"]         = Vector3.new(5643.4526367188, 1013.0858154297, -340.51025390625),
};
local function _vWalkToQuest()
	pcall(function()
		if CFrameQuest then
			TweenPlayer(CFrameQuest)
			task.wait(0.5)
			replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
			task.wait(0.1)
			replicated.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
		end
	end)
end

MainTab:AddSection("Auto Farm")
local _selectWeaponDropdown
_selectWeaponDropdown = MainTab:AddDropdown({
	Title="Select Weapon",
	Options={"Melee","Sword","Blox Fruit","Gun"},
	CurrentOption={"Melee"},
	Callback=function(sel)
		_G.SelectWeapon = sel[1] or sel
	end
})

MainTab:AddDropdown({
	Title="Select Boss",
	Options=Boss,
	CurrentOption={Boss[1] or ""},
	Callback=function(sel)
		_G.FindBoss = sel[1] or sel
	end
})

MainTab:AddToggle({
	Title="Auto Farm Level",
	Desc="Farm mobs por quest automaticamente",
	Value=false,
	Callback=function(state)
		_G.Level = state
	end
})

task.spawn(function()
	while task.wait(0.1) do
		pcall(function()
			if not _G.Level then return end
			if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then return end
			local qv = plr.PlayerGui.Main.Quest.Visible
			if not qv then
				_vWalkToQuest()
			else
				local mob = GetConnectionEnemies(MonFarm)
				if mob then
					repeat task.wait()
						G.Kill(mob,_G.Level)
					until not _G.Level or not mob.Parent or mob.Humanoid.Health <= 0
				else
					if CFrameMon then _tp(CFrameMon) end
				end
			end
		end)
	end
end)

MainTab:AddToggle({
	Title="Auto Farm Boss",
	Desc="Farm o boss selecionado",
	Value=false,
	Callback=function(state)
		_G.AutoFarmBoss = state
	end
})

task.spawn(function()
	while task.wait(0.1) do
		pcall(function()
			if not _G.AutoFarmBoss or not _G.FindBoss then return end
			local mob = GetConnectionEnemies(_G.FindBoss)
			if mob then
				repeat task.wait()
					G.Kill(mob,_G.AutoFarmBoss)
				until not _G.AutoFarmBoss or not mob.Parent or mob.Humanoid.Health <= 0
			else
				if PosB then _tp(PosB) end
			end
		end)
	end
end)

MainTab:AddToggle({
	Title="Kill Mobs Nearest",
	Desc="Mata o mob mais proximo automaticamente",
	Value=GetSetting("AutoFarmNear_Save",false),
	Callback=function(I)
		_G.AutoFarmNear = I
		_G.SaveData["AutoFarmNear_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait() do
		pcall(function()
			if not _G.AutoFarmNear then return end
			local char = plr.Character or plr.CharacterAdded:Wait()
			local Root2 = char:FindFirstChild("HumanoidRootPart")
			if not Root2 then return end
			local ClosestEnemy, ShortestDistance = nil, math.huge
			if workspace:FindFirstChild("Enemies") then
				for _, e in pairs(workspace.Enemies:GetChildren()) do
					if e:FindFirstChild("Humanoid") and e:FindFirstChild("HumanoidRootPart") and e.Humanoid.Health > 0 then
						local dist = (Root2.Position - e.HumanoidRootPart.Position).Magnitude
						if dist < ShortestDistance then ShortestDistance = dist; ClosestEnemy = e end
					end
				end
			end
			if ClosestEnemy then
				repeat task.wait()
					G.Kill(ClosestEnemy,_G.AutoFarmNear)
				until not _G.AutoFarmNear or not ClosestEnemy.Parent
					or (ClosestEnemy:FindFirstChild("Humanoid") and ClosestEnemy.Humanoid.Health <= 0)
					or not Root2.Parent
			end
		end)
	end
end)

if World2 then
MainTab:AddToggle({
	Title="Auto Factory Raid",
	Value=GetSetting("AutoFactory_Save",false),
	Callback=function(Value)
		_G.AutoFactory = Value
		_G.SaveData["AutoFactory_Save"] = Value
		SaveSettings()
	end
})

task.spawn(function()
	local FactoryPos = CFrame.new(448.46756,199.356781,-441.389252)
	while task.wait(0.5) do
		pcall(function()
			if not _G.AutoFactory then return end
			local Core = GetConnectionEnemies("Core")
			if Core and Core:FindFirstChild("Humanoid") and Core.Humanoid.Health > 0 then
				repeat task.wait()
					if not _G.AutoFactory then break end
					if not Core or not Core.Parent then break end
					if Core.Humanoid.Health <= 0 then break end
					if _G.SelectWeapon then EquipWeapon(_G.SelectWeapon) end
					_tp(FactoryPos)
				until Core.Humanoid.Health <= 0 or not _G.AutoFactory
			else
				_tp(FactoryPos)
			end
		end)
	end
end)
end

if World3 then
MainTab:AddToggle({
	Title="Auto Pirate Raid",
	Value=GetSetting("AutoRaidCastle_Save",false),
	Callback=function(I)
		_G.AutoRaidCastle = I
		_G.SaveData["AutoRaidCastle_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		if _G.AutoRaidCastle then
			pcall(function()
				local TargetCFrame = CFrame.new(-5496.17432,313.768921,-2841.53027)
				local CheckCFrame = CFrame.new(-5539.3115234375,313.80053710938,-2972.3723144531)
				if (CheckCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 500 then
					for _, e in pairs(workspace.Enemies:GetChildren()) do
						if e:FindFirstChild("HumanoidRootPart") and e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
							if (e.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 2000 then
								repeat task.wait()
									G.Kill(e,_G.AutoRaidCastle)
								until not _G.AutoRaidCastle or not e.Parent or e.Humanoid.Health <= 0
							end
						end
					end
				else
					_tp(TargetCFrame)
				end
			end)
		end
	end
end)
end

MainTab:AddSection("Collect")
MainTab:AddToggle({
	Title="Auto Collect Chest",
	Value=GetSetting("AutoFarmChest_Save",false),
	Callback=function(I)
		_G.AutoFarmChest = I
		_G.SaveData["AutoFarmChest_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		if _G.AutoFarmChest then
			pcall(function()
				local plrChar = plr.Character or plr.CharacterAdded:Wait()
				local d = plrChar:GetPivot().Position
				local Chests = CollectionService:GetTagged("_ChestTagged")
				local minDist, nearestChest = math.huge, nil
				for _, chest in pairs(Chests) do
					local dist = (chest:GetPivot().Position - d).Magnitude
					if not chest:GetAttribute("IsDisabled") and dist < minDist then
						minDist = dist; nearestChest = chest
					end
				end
				if nearestChest then _tp(nearestChest:GetPivot()) end
			end)
		end
	end
end)

MainTab:AddToggle({
	Title="Auto Collect Berry",
	Value=GetSetting("AutoBerry_Save",false),
	Callback=function(I)
		_G.AutoBerry = I
		_G.SaveData["AutoBerry_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		if _G.AutoBerry then
			local n = CollectionService:GetTagged("BerryBush")
			for i = 1, #n do
				local e = n[i]
				for _, K in pairs(e:GetAttributes()) do
					_tp(e.Parent:GetPivot())
					for j = 1, #n do
						local e2 = n[j]
						for _, e3 in pairs(e2:GetChildren()) do
							pcall(function()
								_tp(e3.WorldPivot)
								fireproximityprompt(e3.ProximityPrompt, math.huge)
							end)
						end
					end
				end
			end
		end
	end
end)

MainTab:AddSection("Materials")
local MatDropdown = MainTab:AddDropdown({
	Title="Select Material",
	Options=MaterialList,
	CurrentOption={},
	Callback=function(sel)
		SelectMaterial = sel[1] or sel
		_G.SaveData["SelectMaterial_Save"] = SelectMaterial
		SaveSettings()
	end
})

MainTab:AddToggle({
	Title="Auto Farm Material",
	Value=GetSetting("AutoMaterial_Save",false),
	Callback=function(I)
		getgenv().AutoMaterial = I
		_G.SaveData["AutoMaterial_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait() do
		if getgenv().AutoMaterial then
			pcall(function()
				if SelectMaterial then
					MaterialMon(SelectMaterial)
					_tp(MPos)
				end
				for _, K in ipairs(MMon or {}) do
					for _, n in pairs(workspace.Enemies:GetChildren()) do
						if n:FindFirstChild("Humanoid") and n:FindFirstChild("HumanoidRootPart") and n.Humanoid.Health > 0 then
							if n.Name == K then
								repeat task.wait()
									G.Kill(n,getgenv().AutoMaterial)
								until not getgenv().AutoMaterial or not n.Parent or n.Humanoid.Health <= 0
							end
						end
					end
				end
			end)
		end
	end
end)

if World3 then
MainTab:AddSection("Bones")
MainTab:AddToggle({
	Title="Auto Random Bone",
	Value=false,
	Callback=function(v)
		_G.Auto_Random_Bone = v
	end
})

task.spawn(function()
	while task.wait(0.5) do
		if _G.Auto_Random_Bone then
			replicated.Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
		end
	end
end)

MainTab:AddToggle({
	Title="Auto Soul Reaper",
	Value=false,
	Callback=function(v)
		_G.AutoHytHallow = v
	end
})

task.spawn(function()
	while task.wait(0.5) do
		if _G.AutoHytHallow then
			pcall(function()
				local mob = GetConnectionEnemies("Soul Reaper")
				if mob then
					repeat task.wait()
						G.Kill(mob,_G.AutoHytHallow)
					until mob.Humanoid.Health <= 0 or not _G.AutoHytHallow
				else
					if not GetBP("Hallow Essence") then
						repeat task.wait(0.1)
							replicated.Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
						until not _G.AutoHytHallow or GetBP("Hallow Essence")
					else
						local pos = CFrame.new(-8932.32,146.83,6062.55)
						repeat task.wait(0.1)
							_tp(pos)
						until not _G.AutoHytHallow
						EquipWeapon("Hallow Essence")
					end
				end
			end)
		end
	end
end)
end


-- ===================== FARM OTHERS TAB =====================
FactoryRaidSection = FarmTab:AddSection("Factory Raid");
_G.Settings.Farm["Auto Factory Raid"] = _G.Settings.Farm["Auto Factory Raid"] or false;
AutoFactoryRaidToggle = FarmTab:AddToggle({
	Title = "Auto Factory Raid",
	Desc = "Entra na factory pelo portal do Dom Flamingo (Sea 2), vai ao topo e farma os inimigos.",
	Value = _G.Settings.Farm["Auto Factory Raid"],
	Callback = function(state)
		_G.Settings.Farm["Auto Factory Raid"] = state;
		(getgenv()).SaveSetting();
	end
});

local _FACTORY_PORTAL_POS = Vector3.new(1073.47, 14.52, 1560.72);
local _FACTORY_TOP_CF     = CFrame.new(1002.53, 500, 1522.34);
local _FACTORY_MOB_CF     = CFrame.new(1002.53, 490, 1520.0);

task.spawn(function()
	while task.wait(0.5) do
		if not _G.Settings.Farm["Auto Factory Raid"] then continue; end;
		pcall(function()
			local plr = game.Players.LocalPlayer;
			local char = plr.Character;
			if not char then return; end;
			local hrp = char:FindFirstChild("HumanoidRootPart");
			local hum = char:FindFirstChildOfClass("Humanoid");
			if not hrp or not hum then return; end;
			local insideFactory = hrp.Position.Y > 300;
			if not insideFactory then
				pcall(function()
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(
						"requestEntrance", _FACTORY_PORTAL_POS
					);
				end);
				task.wait(2);
				TweenPlayer(_FACTORY_TOP_CF);
				local t = 0;
				repeat task.wait(0.2); t=t+0.2;
				until hrp.Position.Y > 400 or t > 15;
				return;
			end;
			local foundEnemy = false;
			for _, mob in pairs(workspace.Enemies:GetChildren()) do
				local mobHRP = mob:FindFirstChild("HumanoidRootPart");
				local mobHum = mob:FindFirstChild("Humanoid");
				if mobHRP and mobHum and mobHum.Health > 0 then
					if mobHRP.Position.Y > 300 then
						foundEnemy = true;
						EquipWeapon(_G.Settings.Main["Selected Weapon"]);
						AutoHaki();
						TweenPlayer(mobHRP.CFrame * Pos);
						mobHum.WalkSpeed = 0;
						Attack();
						break;
					end;
				end;
			end;
			if not foundEnemy then
				TweenPlayer(_FACTORY_MOB_CF);
				task.wait(1);
			end;
		end);
	end;
end);

PirateRaidSection = FarmTab:AddSection("Pirate Raid");
AutoPirateRaidToggle = FarmTab:AddToggle({
	Title = "Auto Pirate Raid",
	Desc = "Function Sea 3 Only",
	Value = _G.Settings.Farm["Auto Pirate Raid"],
	Callback = function(state)
		_G.Settings.Farm["Auto Pirate Raid"] = state;
		StopTween(_G.Settings.Farm["Auto Pirate Raid"]);
		(getgenv()).SaveSetting();
	end
});
function getPirateRaidEnemies()
	local PirateRaidPos = CFrame.new(-5515.08301, 343.112762, -3013.25171, 0.0679906458, 0.0000000121971047, -0.997685969, -0.0000000640159001, 1, 0.00000000786281706, 0.997685969, 0.000000063333168, 0.0679906458);
	for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
		if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
			local enemyPos = v.HumanoidRootPart.Position;
			if (PirateRaidPos.Position - enemyPos).Magnitude <= 2000 then
				if v then
					return v;
				else
					return false;
				end;
			end;
		end;
	end;
end;
task.spawn(function()
	while task.wait() do
		if _G.Settings.Farm["Auto Pirate Raid"] then
			pcall(function()
				for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
						if v.Name then
							if getPirateRaidEnemies() then
								if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (v:FindFirstChild("HumanoidRootPart")).Position).Magnitude <= 2000 then
									repeat
										task.wait(0.15);
										Attack();
										AutoHaki();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										TweenPlayer(v.HumanoidRootPart.CFrame * Pos);
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid.JumpPower = 0;
										v.Humanoid.WalkSpeed = 0;
										PosMon = v.HumanoidRootPart.CFrame;
										MonFarm = v.Name;
									until not _G.Settings.Main["Auto Pirate Raid"] or (not v.Parent) or v.Humanoid.Health <= 0 or (not game.Workspace.Enemies:FindFirstChild(v.Name));
								end;
							else
								TweenPlayer(CFrame.new(-5515.08301, 343.112762, -3013.25171, 0.0679906458, 0.0000000121971047, -0.997685969, -0.0000000640159001, 1, 0.00000000786281706, 0.997685969, 0.000000063333168, 0.0679906458));
							end;
						end;
					end;
				end;
			end);
		end;
	end;
end);

AutoFarmChestTweenToggle = FarmTab:AddToggle({
	Title = "Auto Farm Chest Tween",
	Desc = "Tween preciso para cada bau. Confirma coleta via Beli antes de ir pro proximo.",
	Value = _G.Settings.Farm["Auto Farm Chest Tween"],
	Callback = function(state)
		_G.Settings.Farm["Auto Farm Chest Tween"] = state;
		_chestTweenActive = state;
		if not state then StopTween(false); end;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	local plr = game.Players.LocalPlayer;
	repeat task.wait() until plr.Data and plr.Data:FindFirstChild("Beli");
	plr.Data.Beli:GetPropertyChangedSignal("Value"):Connect(function()
		_chestTweenLastBeli = plr.Data.Beli.Value;
	end);
end);
task.spawn(function()
	while true do
		task.wait(0);
		if not _chestTweenActive then task.wait(0.2); continue; end;
		pcall(function()
			local plr = game.Players.LocalPlayer;
			local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
			if not hrp then return; end;
			if _isSpecialChestItem() then
				_chestTweenActive = false;
				_G.Settings.Farm["Auto Farm Chest Tween"] = false;
				Library:Notify({Title = "TRon Void Hub", Content = "Item especial encontrado! Auto Chest parado.", Icon = "bell", Duration = 6});
				return;
			end;
			local chests = {};
			for _, v in pairs(workspace.ChestModels:GetChildren()) do
				if v.Name:find("Chest") and v:FindFirstChild("RootPart") then
					local dist = (v.RootPart.Position - hrp.Position).Magnitude;
					table.insert(chests, {model = v, dist = dist});
				end;
			end;
			if #chests == 0 then task.wait(0.5); return; end;
			table.sort(chests, function(a, b) return a.dist < b.dist; end);
			for _, entry in ipairs(chests) do
				if not _chestTweenActive then break; end;
				local v = entry.model;
				if not v or not v.Parent or not v:FindFirstChild("RootPart") then continue; end;
				if _isSpecialChestItem() then
					_chestTweenActive = false;
					_G.Settings.Farm["Auto Farm Chest Tween"] = false;
					Library:Notify({Title = "TRon Void Hub", Content = "Item especial encontrado!", Icon = "bell", Duration = 6});
					break;
				end;
				local targetCF = v.RootPart.CFrame;
				local beliBefore = _chestTweenLastBeli;
				TweenPlayer(targetCF);
				local tw = 0;
				repeat
					task.wait(0.1); tw = tw + 0.1;
					hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
					if not hrp then break; end;
				until not _chestTweenActive or not v.Parent
					or _chestTweenLastBeli > beliBefore
					or (hrp and (hrp.Position - targetCF.Position).Magnitude < 5)
					or tw > 8;
				if v.Parent and _chestTweenLastBeli <= beliBefore then
					if hrp then hrp.CFrame = targetCF; end;
					task.wait(0.3);
				end;
				_G.ChestHopCount = _G.ChestHopCount + 1;
			end;
			if _G.ChestHopActive and _G.ChestHopCount >= _G.ChestHopLimit then
				_G.ChestHopCount = 0;
				Library:Notify({Title = "TRon Void Hub", Content = "Chest Hop: limite atingido, trocando server...", Icon = "bell", Duration = 4});
				task.wait(2);
				local module = (loadstring(game:HttpGet("https://raw.githubusercontent.com/raw-scriptpastebin/FE/main/Server_Hop_Settings")))();
				module:Teleport(game.PlaceId);
			end;
		end);
	end;
end);

local _chestBypassActive = false;
AutoFarmChestInstantToggle = FarmTab:AddToggle({
	Title = "Auto Farm Chest Bypass",
	Desc = "Teleporte instantaneo e preciso em cada bau. Aguarda confirmacao de coleta antes do proximo.",
	Value = _G.Settings.Farm["Auto Farm Chest Instant"],
	Callback = function(state)
		_G.Settings.Farm["Auto Farm Chest Instant"] = state;
		_chestBypassActive = state;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while true do
		task.wait(0);
		if not _chestBypassActive then task.wait(0.2); continue; end;
		pcall(function()
			local plr = game.Players.LocalPlayer;
			local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
			if not hrp then return; end;
			if _isSpecialChestItem() then
				_chestBypassActive = false;
				_G.Settings.Farm["Auto Farm Chest Instant"] = false;
				Library:Notify({Title = "TRon Void Hub", Content = "Item especial encontrado! Chest Bypass parado.", Icon = "bell", Duration = 6});
				return;
			end;
			local chests = {};
			for _, v in pairs(workspace.ChestModels:GetChildren()) do
				if v and v.Parent and v.Name:find("Chest") and v:FindFirstChild("RootPart") then
					local dist = (v.RootPart.Position - hrp.Position).Magnitude;
					table.insert(chests, {model = v, dist = dist});
				end;
			end;
			if #chests == 0 then return; end;
			table.sort(chests, function(a, b) return a.dist < b.dist; end);
			local beli_ref = _chestTweenLastBeli;
			for _, entry in ipairs(chests) do
				if not _chestBypassActive then break; end;
				local v = entry.model;
				if not v or not v.Parent or not v:FindFirstChild("RootPart") then continue; end;
				if _isSpecialChestItem() then
					_chestBypassActive = false;
					_G.Settings.Farm["Auto Farm Chest Instant"] = false;
					break;
				end;
				local chestCF = v.RootPart.CFrame;
				local beliBefore = _chestTweenLastBeli;
				hrp.CFrame = chestCF;
				task.wait(0.03);
				local _VIM = game:GetService("VirtualInputManager");
				for _di = 1, 5 do
					pcall(function()
						_VIM:SendKeyEvent(true,  "Q", false, game);
						task.wait(0.02);
						_VIM:SendKeyEvent(false, "Q", false, game);
					end);
					task.wait(0.03);
				end;
				local timeout = 0;
				repeat
					task.wait(0.04); timeout = timeout + 0.04;
				until not _chestBypassActive or not v.Parent or _chestTweenLastBeli > beliBefore or timeout >= 1;
				if v.Parent and _chestTweenLastBeli <= beliBefore then
					hrp.CFrame = chestCF;
					task.wait(0.1);
				end;
				_G.ChestHopCount = _G.ChestHopCount + 1;
			end;
		end);
		if _chestBypassActive then
			local t = 0;
			while _chestBypassActive and t < 7 do task.wait(0.1); t = t + 0.1; end;
		end;
		if _G.ChestHopActive and _G.ChestHopCount >= _G.ChestHopLimit then
			_G.ChestHopCount = 0;
			Library:Notify({Title = "TRon Void Hub", Content = "Chest Hop: trocando server...", Icon = "bell", Duration = 4});
			task.wait(2);
			local module = (loadstring(game:HttpGet("https://raw.githubusercontent.com/raw-scriptpastebin/FE/main/Server_Hop_Settings")))();
			module:Teleport(game.PlaceId);
		end;
	end;
end);

	Title = "Chest Hop",
	Desc = "Troca de servidor apos pegar X baus (define quantidade abaixo)",
	Value = false,
	Callback = function(state)
		_G.ChestHopActive = state;
		_G.ChestHopCount = 0;
	end
});
local _chestHopLimitOptions = {20,25,30,35,40,45,50};
FarmTab:AddDropdown({
	Title = "Chest Hop Limit",
	Desc = "Quantos baus pegar antes de trocar de servidor",
	Values = {"20","25","30","35","40","45","50"},
	Value = "20",
	Callback = function(v)
		_G.ChestHopLimit = tonumber(v) or 20;
	end
});
FarmTab:AddParagraph({
	Title = "Baus Coletados",
	Desc = "0"
});
task.spawn(function()
	local para = nil;
	for _, v in pairs(Tabs.OthersTab._elements or {}) do
		if type(v) == "table" and v.Title == "Baus Coletados" then para = v; break; end;
	end;
	while true do
		task.wait(1);
		if para and para.SetDesc then
			pcall(function() para:SetDesc(tostring(_G.ChestHopCount or 0) .. " / " .. tostring(_G.ChestHopLimit or 20)); end);
		end;
	end;
end);
AutoStopItemsToggle = FarmTab:AddToggle({
	Title = "Auto Stop Items",
	Desc = "Stop When Get God's Chalice or FoD",
	Value = _G.Settings.Farm["Auto Stop Items"],
	Callback = function(state)
		_G.Settings.Farm["Auto Stop Items"] = state;
		StopTween(_G.Settings.Farm["Auto Stop Items"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Settings.Farm["Auto Stop Items"] then
				if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("God's Chalice") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("God's Chalice") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Fist of Darkness") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Fist of Darkness") then
					AutoFarmChestInstantToggle:SetValue(false);
					AutoFarmChestTweenToggle:SetValue(false);
					TweenPlayer((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame);
				end;
			end;
		end);
	end;
end);
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if _G.Settings.Farm["Auto Farm Chest Tween"] then
				for i, v in pairs((game:GetService("Workspace")).ChestModels:GetChildren()) do
					if v.Name:find("Chest") then
						repeat
							task.wait(0.1);
							TweenPlayer(v.RootPart.CFrame);
						until _G.Settings.Farm["Auto Farm Chest Tween"] == false or (not v.Parent);
						TweenPlayer((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame);
					end;
				end;
			end;
		end);
	end;
end);
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if _G.Settings.Farm["Auto Farm Chest Instant"] then
				for i, v in pairs((game:GetService("Workspace")).ChestModels:GetChildren()) do
					if v.Name:find("Chest") then
						repeat
							task.wait(0.1);
							if v.Name == "DiamondChest" then
								InstantTp(v.RootPart.CFrame);
							elseif v.Name == "GoldChest" then
								InstantTp(v.RootPart.CFrame);
							elseif v.Name == "SilverChest" then
								InstantTp(v.RootPart.CFrame);
							end;
						until not _G.Settings.Farm["Auto Farm Chest Instant"] or (not v.Parent);
					end;
				end;
			end;
		end);
	end;
end);
CakePrinceSection = FarmTab:AddSection("Cake Prince");

CakePrinceStatusParagraph = FarmTab:AddParagraph({
	Title = "Cake Prince Status",
	Desc = "N/A"
});
task.spawn(function()
	while task.wait(5) do
		pcall(function()
			if World3 then
				if string.len((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88 then
					CakePrinceStatusParagraph:SetDesc(string.sub((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 41) .. " Remaining");
				elseif string.len((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87 then
					CakePrinceStatusParagraph:SetDesc(string.sub((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 40) .. " Remaining");
				elseif string.len((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86 then
					CakePrinceStatusParagraph:SetDesc(string.sub((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 39) .. " Remaining");
				else
					CakePrinceStatusParagraph:SetDesc("Cake Prince Status: Spawned!");
				end;
			else
				CakePrinceStatusParagraph:SetDesc("Sea 3 only");
			end;
		end);
	end;
end);
AutoKatakuriToggle = FarmTab:AddToggle({
	Title = "Auto Katakuri",
	Desc = "Auto Farm + Kill Cake Prince [ Sea 3 Only ]",
	Value = _G.Settings.Farm["Auto Farm Katakuri"],
	Callback = function(state)
		_G.Settings.Farm["Auto Farm Katakuri"] = state;
		StopTween(_G.Settings.Farm["Auto Farm Katakuri"]);
		(getgenv()).SaveSetting();
	end
});
AutoSpawnCakePrinceToggle = FarmTab:AddToggle({
	Title = "Auto Spawn Cake Prince",
	Desc = "Function Sea 3 Only",
	Value = _G.Settings.Farm["Auto Spawn Cake Prince"],
	Callback = function(state)
		_G.Settings.Farm["Auto Spawn Cake Prince"] = state;
		StopTween(_G.Settings.Farm["Auto Spawn Cake Prince"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.Farm["Auto Spawn Cake Prince"] and World3 then
			task.wait(2);
			(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CakePrinceSpawner", true);
		end;
	end;
end);
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.Farm["Auto Farm Katakuri"] and World3 then
			pcall(function()
				if game.ReplicatedStorage:FindFirstChild("Cake Prince") or (game:GetService("Workspace")).Enemies:FindFirstChild("Cake Prince") then
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Cake Prince") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Cake Prince" then
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat
										task.wait(0.15);
										AutoHaki();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										v.Humanoid.WalkSpeed = 0;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										TweenPlayer(v.HumanoidRootPart.CFrame * Pos);
										RemoveAnimation(v);
										Attack();
									until not _G.Settings.Farm["Auto Farm Katakuri"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					elseif (game:GetService("Workspace")).Map.CakeLoaf.BigMirror.Other.Transparency == 0 and ((CFrame.new((-1990.672607421875), 4532.99951171875, (-14973.6748046875))).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 2000 then
						TweenPlayer(CFrame.new(-2151.82153, 149.315704, -12404.9053));
					end;
				elseif (game:GetService("Workspace")).Enemies:FindFirstChild("Cookie Crafter") or (game:GetService("Workspace")).Enemies:FindFirstChild("Cake Guard") or (game:GetService("Workspace")).Enemies:FindFirstChild("Baking Staff") or (game:GetService("Workspace")).Enemies:FindFirstChild("Head Baker") then
					for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
						if v.Name == "Cookie Crafter" or v.Name == "Cake Guard" or v.Name == "Baking Staff" or v.Name == "Head Baker" then
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								repeat
									task.wait(0.15);
									AutoHaki();
									EquipWeapon(_G.Settings.Main["Selected Weapon"]);
									v.Humanoid.WalkSpeed = 0;
									v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
									PosMon = v.HumanoidRootPart.CFrame;
									MonFarm = v.Name;
									TweenPlayer(v.HumanoidRootPart.CFrame * Pos);
									Attack();
								until not _G.Settings.Farm["Auto Farm Katakuri"] or (not v.Parent) or v.Humanoid.Health <= 0 or (game:GetService("Workspace")).Map.CakeLoaf.BigMirror.Other.Transparency == 0 or (game:GetService("ReplicatedStorage")):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or (game:GetService("Workspace")).Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]");
							end;
						end;
					end;
				else
					UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
					TweenPlayer(CFrame.new(-2091.911865234375, 70.00884246826172, -12142.8359375));
				end;
			end);
		end;
	end;
end);
AutoKillCakePrinceToggle = FarmTab:AddToggle({
	Title = "Auto Kill Cake Prince",
	Desc = "Function Sea 3 Only",
	Value = _G.Settings.Farm["Auto Kill Cake Prince"],
	Callback = function(state)
		_G.Settings.Farm["Auto Kill Cake Prince"] = state;
		StopTween(_G.Settings.Farm["Auto Kill Cake Prince"]);
		(getgenv()).SaveSetting();
	end
});
AutoKillDoughKingToggle = FarmTab:AddToggle({
	Title = "Auto Kill Dough King",
	Desc = "Function Sea 3 Only",
	Value = _G.Settings.Farm["Auto Kill Dough King"],
	Callback = function(state)
		_G.Settings.Farm["Auto Kill Dough King"] = state;
		StopTween(_G.Settings.Farm["Auto Kill Dough King"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.Farm["Auto Kill Cake Prince"] and World3 then
			pcall(function()
				if (game:GetService("Workspace")).Enemies:FindFirstChild("Cake Prince") then
					for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
						if v.Name == "Cake Prince" then
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								repeat
									task.wait(0.15);
									AutoHaki();
									EquipWeapon(_G.Settings.Main["Selected Weapon"]);
									v.Humanoid.WalkSpeed = 0;
									v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
									TweenPlayer(v.HumanoidRootPart.CFrame * Pos);
									RemoveAnimation(v);
									Attack();
									if v.Humanoid:FindFirstChild("Animator") then
										v.Humanoid.Animator:Destroy();
									end;
								until not _G.Settings.Farm["Auto Kill Cake Prince"] or (not v.Parent) or v.Humanoid.Health <= 0;
							end;
						end;
					end;
				else
					UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
				end;
			end);
		end;
	end;
end);
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.Farm["Auto Kill Dough King"] and World3 then
			pcall(function()
				if (game:GetService("Workspace")).Enemies:FindFirstChild("Dough King") then
					for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
						if v.Name == "Dough King" then
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								repeat
									task.wait(0.15);
									AutoHaki();
									EquipWeapon(_G.Settings.Main["Selected Weapon"]);
									v.Humanoid.WalkSpeed = 0;
									v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
									TweenPlayer(v.HumanoidRootPart.CFrame * Pos);
									RemoveAnimation(v);
									Attack();
									if v.Humanoid:FindFirstChild("Animator") then
										v.Humanoid.Animator:Destroy();
									end;
								until not _G.Settings.Farm["Auto Kill Dough King"] or (not v.Parent) or v.Humanoid.Health <= 0;
							end;
						end;
					end;
				end;
			end);
		end;
	end;
end);
MaterialsSection = MainTab:AddSection("Materials");


-- ===================== MASTERY TAB =====================
MaestryTab:AddSection("Farm Mastery")
local MasteryIslands = {"Cake","Bone"}
MaestryTab:AddDropdown({
	Title="Select Method",
	Options=MasteryIslands,
	CurrentOption={"Cake"},
	Callback=function(I) SelectIsland = I[1] or I end
})

MaestryTab:AddToggle({
	Title="Auto Farm Mastery Fruit",
	Value=GetSetting("FarmMastery_Dev",false),
	Callback=function(I)
		_G.FarmMastery_Dev = I
		_G.SaveData["FarmMastery_Dev"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.1) do
		if _G.FarmMastery_Dev then
			pcall(function()
				local list = (SelectIsland == "Cake" and X or P)
				local mob = GetNearestMobFromList(list)
				if mob then
					HealthM = mob.Humanoid.MaxHealth * 0.7
					repeat task.wait()
						if not mob.Parent or not mob:FindFirstChild("Humanoid") or mob.Humanoid.Health <= 0 or not mob:FindFirstChild("HumanoidRootPart") then
							mob = GetNearestMobFromList(list)
							if not mob then break end
						end
						MousePos = mob.HumanoidRootPart.Position
						G.Mas(mob,_G.FarmMastery_Dev)
						if not HasAliveMob(list) then break end
					until not _G.FarmMastery_Dev
				else
					if SelectIsland == "Cake" then _tp(CFrame.new(-1943.6765,251.5095,-12337.8808))
					else _tp(CFrame.new(-9495.6806,453.5862,5977.3486)) end
				end
			end)
		end
	end
end)

MaestryTab:AddToggle({
	Title="Auto Farm Mastery Gun",
	Value=false,
	Callback=function(I)
		_G.FarmMastery_G = I
	end
})

task.spawn(function()
	while task.wait(0.1) do
		if _G.FarmMastery_G then
			pcall(function()
				local list = (SelectIsland == "Cake" and X or P)
				local mob = GetNearestMobFromList(list)
				if mob then
					HealthM = mob.Humanoid.MaxHealth * 0.7
					repeat task.wait()
						if not mob.Parent or not mob:FindFirstChild("Humanoid") or mob.Humanoid.Health <= 0 then
							mob = GetNearestMobFromList(list)
							if not mob then break end
						end
						MousePos = mob.HumanoidRootPart.Position
						G.Masgun(mob,_G.FarmMastery_G)
						local Net2 = replicated:FindFirstChild("Modules") and replicated.Modules:FindFirstChild("Net")
						local shoot = Net2 and Net2:FindFirstChild("RE/ShootGunEvent")
						local tool = plr.Character:FindFirstChildOfClass("Tool")
						if tool and tool.Name == "Skull Guitar" then
							SoulGuitar = true
							tool.RemoteEvent:FireServer("TAP",MousePos)
						elseif tool and shoot then
							SoulGuitar = false
							shoot:FireServer(MousePos,{mob.HumanoidRootPart})
						end
						if not HasAliveMob(list) then break end
					until not _G.FarmMastery_G
					SoulGuitar = false
				else
					if SelectIsland == "Cake" then _tp(CFrame.new(-1943.6765,251.5095,-12337.8808))
					else _tp(CFrame.new(-9495.6806,453.5862,5977.3486)) end
				end
			end)
		end
	end
end)

MaestryTab:AddSection("Fruit Skills for Mastery")
MaestryTab:AddToggle({Title="Fruit Skill Z",Value=false,Callback=function(v) _G.FruitSkills.Z = v end})
MaestryTab:AddToggle({Title="Fruit Skill X",Value=false,Callback=function(v) _G.FruitSkills.X = v end})
MaestryTab:AddToggle({Title="Fruit Skill C",Value=false,Callback=function(v) _G.FruitSkills.C = v end})
MaestryTab:AddToggle({Title="Fruit Skill V",Value=false,Callback=function(v) _G.FruitSkills.V = v end})
MaestryTab:AddToggle({Title="Fruit Skill F",Value=false,Callback=function(v) _G.FruitSkills.F = v end})

-- ===================== OTHERS TAB =====================
OthersTab:AddSection("Observation Haki")
OthersTab:AddToggle({
	Title="Auto Observation V1",
	Value=true,
	Callback=function(I)
		_G.AutoKen = I
		if I then
			task.spawn(function()
				while _G.AutoKen do
					task.wait(0.2)
					pcall(function()
						local char = plr.Character
						if char and not CollectionService:HasTag(char,"Ken") then
							replicated.Remotes.CommE:FireServer("Ken",true)
						end
					end)
				end
			end)
		end
	end
})

if World3 then
OthersTab:AddToggle({
	Title="Auto Observation V2",
	Value=GetSetting("AutoKenV2_Save",false),
	Callback=function(I)
		_G.AutoKenVTWO = I
		_G.SaveData["AutoKenV2_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		if _G.AutoKenVTWO then
			pcall(function()
				local I = CFrame.new(-12444.78515625,332.40396118164,-7673.1806640625)
				local n = CFrame.new(-13277.568359375,370.34185791016,-7821.1572265625)
				local d = CFrame.new(-13493.12890625,318.89553833008,-8373.7919921875)
				if plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Defeat 50 Forest Pirates") then
					local I2 = GetConnectionEnemies("Forest Pirate")
					if I2 then
						repeat task.wait(); G.Kill(I2,_G.AutoKenVTWO)
						until not _G.AutoKenVTWO or I2.Humanoid.Health <= 0 or not plr.PlayerGui.Main.Quest.Visible
					else _tp(n) end
				elseif plr.PlayerGui.Main.Quest.Visible == true then
					local I2 = GetConnectionEnemies("Captain Elephant")
					if I2 then
						repeat task.wait(); G.Kill(I2,_G.AutoKenVTWO)
						until not _G.AutoKenVTWO or I2.Humanoid.Health <= 0
					else _tp(d) end
				else
					replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")
					task.wait(0.1)
					replicated.Remotes.CommF_:InvokeServer("StartQuest","CitizenQuest",1)
				end
			end)
		end
	end
end)

OthersTab:AddToggle({
	Title="Auto Citizen Quest",
	Value=false,
	Callback=function(I) _G.CitizenQuest = I end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.CitizenQuest then
				local lv = plr.Data.Level.Value
				if lv >= 1800 and not replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") then
					if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Forest Pirate") and plr.PlayerGui.Main.Quest.Visible then
						local I = GetConnectionEnemies("Forest Pirate")
						if I then
							repeat task.wait(); G.Kill(I,_G.CitizenQuest)
							until not _G.CitizenQuest or not I.Parent or I.Humanoid.Health <= 0
						else _tp(CFrame.new(-13206.452148438,425.89199829102,-7964.5537109375)) end
					else
						_tp(CFrame.new(-12443.8671875,332.40396118164,-7675.4892578125))
						task.wait(1.5)
						replicated.Remotes.CommF_:InvokeServer("StartQuest","CitizenQuest",1)
					end
				end
			end
		end)
	end
end)

OthersTab:AddSection("Cursed Swords")
local elitesPara = OthersTab:AddParagraph({Title="Elite Progress",Desc=""})
task.spawn(function()
	while task.wait(1) do
		pcall(function()
			local prog = replicated.Remotes.CommF_:InvokeServer("EliteHunter","Progress")
			elitesPara:SetDesc("Elite Progress: "..tostring(prog))
		end)
	end
end)

OthersTab:AddToggle({
	Title="Auto Elite Quest",
	Value=GetSetting("AutoEliteQuest_Save",false),
	Callback=function(I)
		_G.FarmEliteHunt = I
		_G.SaveData["AutoEliteQuest_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.FarmEliteHunt then
				if plr.PlayerGui.Main.Quest.Visible then
					if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Diablo") or string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Urban") or string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Deandre") then
						for _, e in pairs(workspace.Enemies:GetChildren()) do
							if (string.find(e.Name,"Diablo") or string.find(e.Name,"Urban") or string.find(e.Name,"Deandre")) and G.Alive(e) then
								repeat task.wait(); G.Kill(e,_G.FarmEliteHunt)
								until not _G.FarmEliteHunt or not e.Parent or e.Humanoid.Health <= 0
							end
						end
					end
				else
					replicated.Remotes.CommF_:InvokeServer("EliteHunter")
				end
			end
		end)
	end
end)

OthersTab:AddToggle({
	Title="Stop when got God Chalice",
	Value=GetSetting("StopChalice_Save",true),
	Callback=function(I)
		_G.StopWhenChalice = I
		_G.SaveData["StopChalice_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.2) do
		if _G.StopWhenChalice and _G.FarmEliteHunt then
			pcall(function()
				if GetBP("God's Chalice") or GetBP("Sweet Chalice") or GetBP("Fist of Darkness") then
					_G.FarmEliteHunt = false
				end
			end)
		end
	end
end)

OthersTab:AddToggle({
	Title="Auto Tushita Sword",
	Value=false,
	Callback=function(I) _G.Auto_Tushita = I end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.Auto_Tushita then
				if workspace.Map.Turtle:FindFirstChild("TushitaGate") then
					if not GetBP("Holy Torch") then
						_tp(CFrame.new(5148.03613,162.352493,910.548218))
					else
						EquipWeapon("Holy Torch"); task.wait(1)
						local positions = {
							CFrame.new(-10752,417,-9366), CFrame.new(-11672,334,-9474),
							CFrame.new(-12132,521,-10655), CFrame.new(-13336,486,-6985), CFrame.new(-13489,332,-7925)
						}
						for _, cf in ipairs(positions) do
							repeat task.wait(); _tp(cf)
							until not _G.Auto_Tushita or (cf.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10
							task.wait(0.7)
						end
					end
				else
					local I = GetConnectionEnemies("Longma")
					if I then
						repeat task.wait(); G.Kill(I,_G.Auto_Tushita)
						until I.Humanoid.Health <= 0 or not _G.Auto_Tushita
					else
						if replicated:FindFirstChild("Longma") then
							_tp(replicated:FindFirstChild("Longma").HumanoidRootPart.CFrame * CFrame.new(0,40,0))
						end
					end
				end
			end
		end)
	end
end)

OthersTab:AddToggle({
	Title="Auto Yama Sword",
	Value=GetSetting("AutoYama_Save",false),
	Callback=function(I)
		_G.Auto_Yama = I
		_G.SaveData["AutoYama_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.Auto_Yama then
				local prog = replicated.Remotes.CommF_:InvokeServer("EliteHunter","Progress")
				if prog < 30 then
					_G.FarmEliteHunt = true
				else
					_G.FarmEliteHunt = false
					if (workspace.Map.Waterfall.SealedKatana.Handle.Position - plr.Character.HumanoidRootPart.Position).Magnitude >= 20 then
						_tp(workspace.Map.Waterfall.SealedKatana.Handle.CFrame)
						local I = GetConnectionEnemies("Ghost")
						if I then
							repeat task.wait(); G.Kill(I,_G.Auto_Yama)
							until I.Humanoid.Health <= 0 or not I.Parent or not _G.Auto_Yama
							fireclickdetector(workspace.Map.Waterfall.SealedKatana.Handle.ClickDetector)
						end
					end
				end
			end
		end)
	end
end)
end

if World2 or World3 then
OthersTab:AddSection("Buso/Aura Colors")
OthersTab:AddToggle({
	Title="Teleport Barista Haki",
	Value=GetSetting("TpBarista_Save",false),
	Callback=function(I)
		_G.Tp_MasterA = I
		_G.SaveData["TpBarista_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait() do
		if _G.Tp_MasterA then
			pcall(function()
				for _, e in pairs(replicated.NPCs:GetChildren()) do
					if e.Name == "Barista Cousin" then _tp(e.HumanoidRootPart.CFrame) end
				end
			end)
		end
	end
end)

OthersTab:AddButton({Title="Buy Buso Colors",Callback=function()
	replicated.Remotes.CommF_:InvokeServer("ColorsDealer","2")
end})
end

if World3 then
OthersTab:AddToggle({
	Title="Auto Rainbow Haki",
	Value=GetSetting("AutoRainbowHaki_Save",false),
	Callback=function(I)
		_G.Auto_Rainbow_Haki = I
		_G.SaveData["AutoRainbowHaki_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.Auto_Rainbow_Haki then
				replicated.Remotes.CommF_:InvokeServer("UnlockHaki","Buy")
				replicated.Remotes.CommF_:InvokeServer("UnlockHaki","Check")
			end
		end)
	end
end)

OthersTab:AddToggle({
	Title="Auto Kill Rip Indra",
	Value=GetSetting("AutoRipIndra_Save",false),
	Callback=function(I)
		_G.AutoRipIngay = I
		_G.SaveData["AutoRipIndra_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.AutoRipIngay then
				local I = GetConnectionEnemies("rip_indra")
				if not GetWP("Dark Dagger") or not GetIn("Valkyrie") and I then
					repeat task.wait(); G.Kill(I,_G.AutoRipIngay)
					until not _G.AutoRipIngay or not I.Parent or I.Humanoid.Health <= 0
				end
			end
		end)
	end
end)
end

EventTab:AddSection(" Sea Event - Setting Sail");

ChooseBoatDropdown = EventTab:AddDropdown({
	Title = "Choose Boat",
	Desc = "Tipo de barco para comprar e usar",
	Values = {"Guardian","PirateGrandBrigade","MarineGrandBrigade","PirateBrigade","MarineBrigade","PirateSloop","MarineSloop","Beast Hunter"},
	Value = _G.Settings.SeaEvent["Selected Boat"] or "Guardian",
	Callback = function(option)
		_G.Settings.SeaEvent["Selected Boat"] = option;
		_G.SelectedBoat = option;
		(getgenv()).SaveSetting();
	end
});

ChooseZoneDropdown = EventTab:AddDropdown({
	Title = "Choose Zone (Sea 3)",
	Desc = "Nivel de perigo para navegar (Sea 3 apenas)",
	Values = {"Lv 1","Lv 2","Lv 3","Lv 4","Lv 5","Lv 6","Lv Infinite"},
	Value = "Lv 1",
	Callback = function(option)
		_G.DangerSc = option;
	end
});

local BoatSpeedSlider = EventTab:AddSlider({
	Title = "Boat Speed",
	Desc = "Velocidade do barco (padrao: 300)",
	Min = 10,
	Max = 350,
	Default = 300,
	Callback = function(v)
		_G.SetSpeedBoat = v;
		_G.Settings.SeaEvent["Boat Tween Speed"] = v;
	end
});

EventTab:AddToggle({
	Title = "Activate Boat Speed",
	Desc = "Aplica velocidade customizada no barco em tempo real",
	Value = false,
	Callback = function(v)
		_G.SpeedBoat = v;
	end
});
task.spawn(function()
	while task.wait(0.1) do
		if not _G.SpeedBoat then continue; end;
		pcall(function()
			local char = game.Players.LocalPlayer.Character;
			if not char then return; end;
			local hum = char:FindFirstChildOfClass("Humanoid");
			if not hum or not hum.Sit then return; end;
			local spd = _G.SetSpeedBoat or 300;
			for _, boat in pairs(workspace.Boats:GetChildren()) do
				local seat = boat:FindFirstChildWhichIsA("VehicleSeat");
				if seat then
					seat.MaxSpeed = spd;
					seat.Torque   = 30;
					seat.TurnSpeed = 10;
				end;
			end;
		end);
	end;
end);

local _BOAT_DEALER_CF = CFrame.new(-16927.451, 9.086, 433.864);
local _DANGER_ZONES = {
	["Lv 1"]        = CFrame.new(-21998.375, 30.0006084, -682.309143),
	["Lv 2"]        = CFrame.new(-26779.5215, 30.0005474, -822.858032),
	["Lv 3"]        = CFrame.new(-31171.957, 30.0001011, -2256.93774),
	["Lv 4"]        = CFrame.new(-34054.6875, 30.2187767, -2560.12012),
	["Lv 5"]        = CFrame.new(-38887.5547, 30.0004578, -2162.99023),
	["Lv 6"]        = CFrame.new(-44541.7617, 30.0003204, -1244.8584),
	["Lv Infinite"] = CFrame.new(-148073.36, 9.0, 7721.05),
};

_G.SailBoat = false;
_G.SailBoats = false;

local _SAIL_WAYPOINT_A = CFrame.new(-37813.6953, -0.3221744, 6105.16895, -0.252362996, 4.13621581E-9, 0.967632651, 2.87320709E-8, 1, 3.21888249E-9, -0.967632651, 2.86144175E-8, -0.252362996);
local _SAIL_WAYPOINT_B = CFrame.new(-42250.2227, -0.3221744, 9247.07715, -0.45916447, 6.39043236E-8, 0.888351262, -3.36711423E-8, 1, -8.93395651E-8, -0.888351262, -7.09333605E-8, -0.45916447);

local function _TweenBoatTo(targetCF)
	pcall(function()
		local plr = game.Players.LocalPlayer;
		local char = plr.Character;
		if not char then return; end;
		local hum = char:FindFirstChildOfClass("Humanoid");
		if not hum then return; end;
		local selectedBoat = _G.Settings.SeaEvent["Selected Boat"] or "Guardian";
		local boat = nil;
		for _, b in pairs(workspace.Boats:GetChildren()) do
			if b.Name == selectedBoat then
				local own = b:FindFirstChild("OwnerName") or b:FindFirstChild("Owner");
				if own and own.Value == plr.Name then boat = b; break; end;
			end;
		end;
		if not boat then return; end;
		local seat = boat:FindFirstChildWhichIsA("VehicleSeat");
		if not seat then return; end;
		local dist = (targetCF.Position - seat.Position).Magnitude;
		local spd = _G.SetSpeedBoat or _G.Settings.SeaEvent["Boat Tween Speed"] or 300;
		local tweenInfo = TweenInfo.new(dist / spd, Enum.EasingStyle.Linear);
		local tw = TweenService:Create(seat, tweenInfo, {CFrame = targetCF});
		tw:Play();
		local elapsed = 0;
		while tw.PlaybackState == Enum.PlaybackState.Playing do
			elapsed = elapsed + 0.05;
			if not _G.SailBoat or elapsed > (dist / spd) + 5 then tw:Cancel(); break; end;
			task.wait(0.05);
		end;
	end);
end;

local function _hasSeaEnemy()
	return (CheckShark() and _G.Settings.SeaEvent["Auto Farm Shark"])
		or (CheckTerrorShark() and _G.Settings.SeaEvent["Auto Farm Terrorshark"])
		or (CheckFishCrew() and _G.Settings.SeaEvent["Auto Farm Fish Crew Member"])
		or (CheckPiranha() and _G.Settings.SeaEvent["Auto Farm Piranha"])
		or (CheckSeaBeast() and _G.Settings.SeaEvent["Auto Farm Seabeasts"])
		or (CheckEnemiesBoat() and _G.Settings.SeaEvent["Auto Farm Pirate Brigade"])
		or (CheckPirateGrandBrigade() and _G.Settings.SeaEvent["Auto Farm Pirate Grand Brigade"])
		or (CheckHauntedCrew() and _G.Settings.SeaEvent["Auto Farm Ghost Ship"])
		or (CheckLeviathan() and _G.Settings.SeaEvent["Auto Farm Seabeasts"]);
end;

local _TIKI_CF         = CFrame.new(-16815.0, 9.0, 471.5);
local _BOAT_NPC_CF     = CFrame.new(-16927.451, 9.086, 433.864);
local _SEA_ZONE_CF = {
	["Lv 1"]        = CFrame.new(-21998.375, 0, -682.309143),
	["Lv 2"]        = CFrame.new(-26779.5215, 0, -822.858032),
	["Lv 3"]        = CFrame.new(-31171.957, 0, -2256.93774),
	["Lv 4"]        = CFrame.new(-34054.6875, 0, -2560.12012),
	["Lv 5"]        = CFrame.new(-38887.5547, 0, -2162.99023),
	["Lv 6"]        = CFrame.new(-44541.7617, 0, -1244.8584),
	["Lv Infinite"] = CFrame.new(-148073.36, 0, 7721.05),
};

_G.GrindSea = _G.GrindSea or false;

GrindSeaToggle = EventTab:AddToggle({
	Title = "Grind Sea",
	Desc = "Goes to Tiki, buys boat, mounts it, sails to selected sea and farms sea NPCs.",
	Value = false,
	Callback = function(state)
		_G.GrindSea = state;
		(getgenv()).SaveSetting();
	end
});

local function _findMyBoat(plr, boatName)
	for _, b in pairs(workspace.Boats:GetChildren()) do
		if b.Name == boatName then
			local own = b:FindFirstChild("OwnerName") or b:FindFirstChild("Owner");
			if own and own.Value == plr.Name then
				return b;
			end;
		end;
	end;
	return nil;
end;

local function _grindTweenTo(hrp, targetCF, speed)
	local dist = (hrp.Position - targetCF.Position).Magnitude;
	if dist < 10 then return true; end;
	local dur = math.max(0.5, dist / (speed or 350));
	local tw = TweenService:Create(hrp, TweenInfo.new(dur, Enum.EasingStyle.Linear), {CFrame = targetCF});
	tw:Play();
	local elapsed = 0;
	while tw.PlaybackState == Enum.PlaybackState.Playing do
		if not _G.GrindSea then tw:Cancel(); return false; end;
		task.wait(0.1); elapsed = elapsed + 0.1;
		if elapsed > dur + 4 then break; end;
	end;
	return _G.GrindSea;
end;

task.spawn(function()
	while true do
		task.wait(0.5);
		if not _G.GrindSea then continue; end;

		local ok, err = pcall(function()
			local plr = game.Players.LocalPlayer;
			local char = plr.Character;
			if not char then return; end;
			local hrp = char:FindFirstChild("HumanoidRootPart");
			local hum = char:FindFirstChildOfClass("Humanoid");
			if not hrp or not hum then return; end;

			local selectedBoat = _G.Settings.SeaEvent["Selected Boat"] or "Guardian";

			local distTiki = (hrp.Position - _TIKI_CF.Position).Magnitude;
			if distTiki > 150 then
				if not _grindTweenTo(hrp, _TIKI_CF, 350) then return; end;
				task.wait(0.5);
			end;
			if not _G.GrindSea then return; end;

			local myBoat = _findMyBoat(plr, selectedBoat);
			if not myBoat then
				if not _grindTweenTo(hrp, _BOAT_NPC_CF, 350) then return; end;
				task.wait(0.4);
				if not _G.GrindSea then return; end;

				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", selectedBoat);
				task.wait(0.5);

				local waited = 0;
				repeat
					task.wait(0.3); waited = waited + 0.3;
					myBoat = _findMyBoat(plr, selectedBoat);
				until myBoat or waited > 12 or not _G.GrindSea;

				if not myBoat or not _G.GrindSea then return; end;

				pcall(function()
					hrp.Anchored = false;
					hum.WalkSpeed = 16;
					hum.JumpPower = 50;
				end);
				task.wait(0.3);
			end;

			if not myBoat or not _G.GrindSea then return; end;

			local seat = myBoat:FindFirstChildWhichIsA("VehicleSeat");
			if not seat then return; end;

			if not hum.Sit then
				local awayFromNPC = _BOAT_NPC_CF * CFrame.new(0, 0, 20);
				local distAway = (hrp.Position - awayFromNPC.Position).Magnitude;
				if distAway > 15 then
					if not _grindTweenTo(hrp, awayFromNPC, 350) then return; end;
					task.wait(0.3);
				end;
				if not _G.GrindSea then return; end;

				hrp.CFrame = seat.CFrame * CFrame.new(0, 2, 0);
				task.wait(0.2);

				pcall(function()
					seat:Sit(hum);
				end);

				local sitWait = 0;
				repeat
					task.wait(0.2); sitWait = sitWait + 0.2;
					if not hum.Sit then
						hrp.CFrame = seat.CFrame * CFrame.new(0, 1.5, 0);
						pcall(function() seat:Sit(hum); end);
					end;
				until hum.Sit or sitWait > 4 or not _G.GrindSea;

				if not hum.Sit or not _G.GrindSea then return; end;
				task.wait(0.3);
			end;

			for _, d in pairs(workspace.Boats:GetDescendants()) do
				if d:IsA("BasePart") then d.CanCollide = false; end;
			end;

			local zoneCF = _SEA_ZONE_CF[_G.DangerSc or "Lv 1"] or _SEA_ZONE_CF["Lv 1"];
			local distZone = (seat.Position - zoneCF.Position).Magnitude;
			if distZone > 200 and not _hasSeaEnemy() then
				local spd = _G.SetSpeedBoat or _G.Settings.SeaEvent["Boat Tween Speed"] or 300;
				local dur = math.max(1, distZone / spd);
				local tw = TweenService:Create(seat, TweenInfo.new(dur, Enum.EasingStyle.Linear), {CFrame = zoneCF});
				tw:Play();
				local t = 0;
				while tw.PlaybackState == Enum.PlaybackState.Playing do
					if not _G.GrindSea or _hasSeaEnemy() then tw:Cancel(); break; end;
					task.wait(0.1); t = t + 0.1;
					if t > dur + 6 then break; end;
				end;
			end;
		end);

		if not ok then
			warn("GrindSea error:", err);
		end;
	end;
end);
EventTab:AddButton({
	Title = "Bring Boat",
	Desc = "Teleporta o barco selecionado ate a sua posicao atual.",
	Callback = function()
		pcall(function()
			local selectedBoat = _G.Settings.SeaEvent["Selected Boat"] or "Guardian";
			local boat = workspace.Boats:FindFirstChild(selectedBoat);
			local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
			if boat and hrp then
				boat:SetPrimaryPartCFrame(hrp.CFrame * CFrame.new(0,0,-15));
			end;
		end);
	end
});

task.spawn(function()
	while task.wait(0.1) do
		pcall(function()
			for _, boat in pairs(workspace.Boats:GetChildren()) do
				for _, part in pairs(boat:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false;
					end;
				end;
			end;
		end);
	end;
end);

SeaEventEnemiesSection = EventTab:AddSection("Enemies Sea");
AutoFarmSharkToggle = EventTab:AddToggle({
	Title = "Auto Farm Shark",
	Value = _G.Settings.SeaEvent["Auto Farm Shark"],
	Callback = function(state)
		_G.Settings.SeaEvent["Auto Farm Shark"] = state;
		StopTween(_G.Settings.SeaEvent["Auto Farm Shark"]);
		(getgenv()).SaveSetting();
	end
});
AutoFarmPiranhaToggle = EventTab:AddToggle({
	Title = "Auto Farm Piranha",
	Value = _G.Settings.SeaEvent["Auto Farm Piranha"],
	Callback = function(state)
		_G.Settings.SeaEvent["Auto Farm Piranha"] = state;
		StopTween(_G.Settings.SeaEvent["Auto Farm Piranha"]);
		(getgenv()).SaveSetting();
	end
});
AutoFarmFishCrewMemberToggle = EventTab:AddToggle({
	Title = "Auto Farm Fish Crew Member",
	Value = _G.Settings.SeaEvent["Auto Farm Fish Crew Member"],
	Callback = function(state)
		_G.Settings.SeaEvent["Auto Farm Fish Crew Member"] = state;
		StopTween(_G.Settings.SeaEvent["Auto Farm Fish Crew Member"]);
		(getgenv()).SaveSetting();
	end
});
SeaEventBoatSection = EventTab:AddSection("Enemies Sea (Boat)");
AutoFarmGhostShipToggle = EventTab:AddToggle({
	Title = "Auto Farm Ghost Ship",
	Value = _G.Settings.SeaEvent["Auto Farm Ghost Ship"],
	Callback = function(state)
		_G.Settings.SeaEvent["Auto Farm Ghost Ship"] = state;
		StopTween(_G.Settings.SeaEvent["Auto Farm Ghost Ship"]);
		(getgenv()).SaveSetting();
	end
});
AutoFarmPirateBrigadeToggle = EventTab:AddToggle({
	Title = "Auto Farm Pirate Brigade",
	Value = _G.Settings.SeaEvent["Auto Farm Pirate Brigade"],
	Callback = function(state)
		_G.Settings.SeaEvent["Auto Farm Pirate Brigade"] = state;
		StopTween(_G.Settings.SeaEvent["Auto Farm Pirate Brigade"]);
		(getgenv()).SaveSetting();
	end
});
AutoFarmPirateGrandBrigadeToggle = EventTab:AddToggle({
	Title = "Auto Farm Pirate Grand Brigade",
	Value = _G.Settings.SeaEvent["Auto Farm Pirate Grand Brigade"],
	Callback = function(state)
		_G.Settings.SeaEvent["Auto Farm Pirate Grand Brigade"] = state;
		StopTween(_G.Settings.SeaEvent["Auto Farm Pirate Grand Brigade"]);
		(getgenv()).SaveSetting();
	end
});
SeaEventBossSection = EventTab:AddSection("Enemies Sea (Boss)");
AutoFarmTerrorsharkToggle = EventTab:AddToggle({
	Title = "Auto Farm Terrorshark",
	Value = _G.Settings.SeaEvent["Auto Farm Terrorshark"],
	Callback = function(state)
		_G.Settings.SeaEvent["Auto Farm Terrorshark"] = state;
		StopTween(_G.Settings.SeaEvent["Auto Farm Terrorshark"]);
		(getgenv()).SaveSetting();
	end
});
AutoFarmSeabeastsToggle = EventTab:AddToggle({
	Title = "Auto Farm Seabeasts",
	Value = _G.Settings.SeaEvent["Auto Farm Seabeasts"],
	Callback = function(state)
		_G.Settings.SeaEvent["Auto Farm Seabeasts"] = state;
		StopTween(_G.Settings.SeaEvent["Auto Farm Seabeasts"]);
		(getgenv()).SaveSetting();
	end
});


SeaStackSection = GetTab:AddSection("Islands");
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
				MirageStatusSeaStackParagraph:SetDesc("Mirage Island Spawning");
			else
				MirageStatusSeaStackParagraph:SetDesc("Mirage Island Not Spawn");
			end;
			if game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
				KitsuneStatusSeaStackParagraph:SetDesc("Kitsune Island Spawning");
			else
				KitsuneStatusSeaStackParagraph:SetDesc("Kitsune Island Not Spawn");
			end;
			if game.Workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
				FrozenStatusSeaStackParagraph:SetDesc("Frozen Dimension Spawning");
			else
				FrozenStatusSeaStackParagraph:SetDesc("Frozen Dimension Not Spawn");
			end;
			if game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
				PrehistoricStatusSeaStackParagraph:SetDesc("Prehistoric Island Spawning");
			else
				PrehistoricStatusSeaStackParagraph:SetDesc("Prehistoric Island Not Spawn");
			end;
		end;
	end);
end);
PrehistoricStatusSeaStackParagraph = GetTab:AddParagraph({
	Title = "Prehistoric Island Status",
	Desc = "N/A"
});

GetTab:AddToggle({
	Title = "Auto Find Prehistoric Island",
	Desc = "Navega automaticamente ate o Mar 6+ para encontrar a ilha",
	Value = false,
	Callback = function(state)
		_G.Prehis_Find = state;
	end
});

task.spawn(function()
	while task.wait(0.15) do
		if not _G.Prehis_Find then task.wait(0.3); continue; end;
		pcall(function()
			local plr = game.Players.LocalPlayer;
			local char = plr.Character; if not char then return; end;
			local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return; end;
			local hum  = char:FindFirstChildOfClass("Humanoid"); if not hum then return; end;
			if not workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island", true) then
				local myBoat = nil;
				for _, b in ipairs(workspace.Boats:GetChildren()) do
					if b:FindFirstChild("VehicleSeat") and (hrp.Position - b.VehicleSeat.Position).Magnitude < 2500 then myBoat = b; break; end;
				end;
				if not myBoat then
					local dp = CFrame.new(-16927.451, 9.086, 433.864);
					TweenPlayer(dp);
					if (dp.Position - hrp.Position).Magnitude <= 12 then
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", _G.VolcanicSelectedBoat or "Guardian");
						task.wait(1);
					end;
				else
					if not hum.Sit then
						TweenPlayer(myBoat.VehicleSeat.CFrame * CFrame.new(0,1,0));
					else
						local seat = myBoat.VehicleSeat;
						local target = Vector3.new(-148073.359, 9.0, 7721.051);
						local dir  = (target - seat.Position).Unit;
						local dist = (target - seat.Position).Magnitude;
						if dist > 100 then seat.CFrame = CFrame.new(seat.Position + dir * math.min(dist, 500)); end;
						if workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") or not _G.Prehis_Find then hum.Sit = false; end;
					end;
				end;
			else
				local island = workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island");
				if (island.CFrame.Position - hrp.Position).Magnitude >= 2000 then
					if hum.Sit then
						local att = 0;
						repeat att=att+1; hum.Jump=true; task.wait(0.35); char=plr.Character; hum=char and char:FindFirstChildOfClass("Humanoid");
						until (not hum or not hum.Sit) or att >= 8;
					end;
					TweenPlayer(island.CFrame);
				end;
				if workspace.Map:FindFirstChild("PrehistoricIsland") then
					local prompt = workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt");
					local pp = prompt and (prompt:FindFirstChildOfClass("ProximityPrompt") or prompt:FindFirstChild("ProximityPrompt"));
					if prompt and pp then
						TweenPlayer(prompt.CFrame);
						if (hrp.Position - prompt.CFrame.Position).Magnitude <= 150 then
							fireproximityprompt(pp, math.huge);
							game:GetService("VirtualInputManager"):SendKeyEvent(true,"E",false,game); task.wait(1.5);
							game:GetService("VirtualInputManager"):SendKeyEvent(false,"E",false,game);
						end;
					end;
				end;
			end;
		end);
	end;
end);

GetTab:AddToggle({
	Title = "Auto Prehistoric Event (M3Ow)",
	Desc = "Remove lava + Mata Golens + Fecha Buracos ate o evento acabar",
	Value = false,
	Callback = function(state)
		_G.PrehistoricEvent = state;
		_G.Prehis_Skills    = state;
		if state then
			task.spawn(function()
				while _G.Prehis_Skills do
					local ch = game.Players.LocalPlayer.Character;
					if ch then for _, v in pairs(ch:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false; end; end; end;
					game:GetService("RunService").Stepped:Wait();
				end;
			end);
		end;
	end
});

task.spawn(function()
	while task.wait(1.5) do
		if not _G.Prehis_Skills then task.wait(1); continue; end;
		pcall(function()
			local MapIsland = workspace.Map:FindFirstChild("PrehistoricIsland"); if not MapIsland then return; end;
			local core = MapIsland:FindFirstChild("Core");
			if core and core:FindFirstChild("InteriorLava") then core.InteriorLava:Destroy(); end;
			for _, obj in ipairs(MapIsland:GetDescendants()) do
				pcall(function()
					if (obj:IsA("Part") or obj:IsA("MeshPart")) and (obj.Name=="Lava" or obj.Name=="LavaPart" or obj.Name:lower():find("magma")) then obj:Destroy(); end;
					if obj.Name=="TouchInterest" and obj.Parent and not obj.Parent.Name:find("TrialTeleport") then obj.Parent:Destroy(); end;
				end);
			end;
		end);
	end;
end);

local function _hasTool(name)
	if game.Players.LocalPlayer.Backpack:FindFirstChild(name) then return true; end;
	local ch = game.Players.LocalPlayer.Character; return ch and ch:FindFirstChild(name) ~= nil;
end;
local function _equipTool(name)
	local ch = game.Players.LocalPlayer.Character; if not ch then return; end;
	local hum = ch:FindFirstChildOfClass("Humanoid"); if not hum then return; end;
	local t = game.Players.LocalPlayer.Backpack:FindFirstChild(name); if t then hum:EquipTool(t); task.wait(0.05); end;
end;

task.spawn(function()
	while task.wait(0.1) do
		if not _G.Prehis_Skills then task.wait(0.5); continue; end;
		pcall(function()
			local plr = game.Players.LocalPlayer;
			local char = plr.Character; if not char then return; end;
			local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return; end;
			local VIM  = game:GetService("VirtualInputManager");
			local function sk(k) pcall(function() VIM:SendKeyEvent(true,k,false,game); task.wait(0.03); VIM:SendKeyEvent(false,k,false,game); end); end;

			for _, name in ipairs({"Lava Golem","Aura Golem","Stone Golem","Rock Golem"}) do
				local enemy = workspace.Enemies:FindFirstChild(name);
				if enemy and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
					pcall(function() enemy.Humanoid.WalkSpeed=0; enemy.HumanoidRootPart.CanCollide=false; enemy.HumanoidRootPart.Size=Vector3.new(50,50,50); end);
					pcall(function() sethiddenproperty(plr,"SimulationRadius",math.huge); end);
					hrp.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0,30,0);
					hrp.Velocity = Vector3.zero;
					AutoHaki(); EquipWeapon(_G.Settings.Main["Selected Weapon"]);
					if G and G.Kill then G.Kill(enemy, _G.Prehis_Skills); end;
					local head = enemy:FindFirstChild("Head") or enemy:FindFirstChild("HumanoidRootPart");
					pcall(function() AttackModule:AttackEnemy(head, {}); end);
					Attack(); sk("Z"); sk("X"); sk("C");
					if _hasTool("Skull Guitar") then _equipTool("Skull Guitar"); sk("Z"); sk("X"); end;
					if _hasTool("Dragon Storm") then _equipTool("Dragon Storm"); sk("Z"); sk("X"); end;
					return;
				end;
			end;

			local core = workspace.Map:FindFirstChild("PrehistoricIsland") and workspace.Map.PrehistoricIsland:FindFirstChild("Core");
			if core and core:FindFirstChild("VolcanoRocks") then
				for _, rock in ipairs(core.VolcanoRocks:GetChildren()) do
					if not rock:FindFirstChild("VFXLayer") then continue; end;
					local layer = rock.VFXLayer;
					local at0 = layer:FindFirstChild("At0");
					local glow = at0 and at0:FindFirstChild("Glow");
					if not (glow and glow.Enabled) then continue; end;
					if (hrp.Position - layer.Position).Magnitude > 10 then
						hrp.CFrame = layer.CFrame * CFrame.new(0,5,0);
						hrp.Velocity = Vector3.zero;
					else
						AutoHaki(); EquipWeapon(_G.Settings.Main["Selected Weapon"]); Attack();
						pcall(function() AttackModule:AttackEnemy(layer, {}); end);
						sk("Z"); sk("X"); sk("C"); sk("V"); sk("F");
						if _hasTool("Skull Guitar") then _equipTool("Skull Guitar"); sk("Z"); sk("X"); end;
						if _hasTool("Dragon Storm") then _equipTool("Dragon Storm"); sk("Z"); sk("X"); end;
					end;
					break;
				end;
			end;
		end);
	end;
end);

GetTab:AddToggle({
	Title = "Auto Kill Lava Golem",
	Value = _G.Settings.SeaStack["Auto Kill Lava Golem"],
	Callback = function(state)
		_G.Settings.SeaStack["Auto Kill Lava Golem"] = state;
		StopTween(_G.Settings.SeaStack["Auto Kill Lava Golem"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.15) do
		if not (_G.Settings.SeaStack["Auto Kill Lava Golem"] and World3) then task.wait(0.3); continue; end;
		pcall(function()
			for _, name in ipairs({"Lava Golem","Aura Golem","Stone Golem","Rock Golem"}) do
				local v = workspace.Enemies:FindFirstChild(name);
				if v and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
					local plr = game.Players.LocalPlayer;
					local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
					if hrp then
						pcall(function() v.Humanoid.WalkSpeed=0; v.HumanoidRootPart.CanCollide=false; end);
						hrp.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,30,0);
						AutoHaki(); EquipWeapon(_G.Settings.Main["Selected Weapon"]);
						PosMon=v.HumanoidRootPart.Position; MonFarm=v.Name; _B=true; BringEnemy();
						Attack();
						pcall(function() AttackModule:AttackEnemy(v:FindFirstChild("Head") or v:FindFirstChild("HumanoidRootPart"), {}); end);
					end;
					break;
				end;
			end;
		end);
	end;
end);


FrozenStatusSeaStackParagraph = GetTab:AddParagraph({
	Title = "Frozen Status",
	Desc = "N/A"
});
AutoSummonFrozenDimensionToggle = GetTab:AddToggle({
	Title = "Summon Frozen Dimension",
	Value = _G.Settings.SeaStack["Summon Frozen Dimension"],
	Callback = function(state)
		_G.Settings.SeaStack["Summon Frozen Dimension"] = state;
		StopTween(_G.Settings.SeaStack["Summon Frozen Dimension"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if _G.Settings.SeaStack["Summon Frozen Dimension"] and World3 then
				if not (game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"]) then
					local BuyBoatCFrame = CFrame.new(-16927.451171875, 9.0863618850708, 433.8642883300781);
					if (BuyBoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then
						BTP(BuyBoatCFrame);
					else
						BuyBoat = TweenPlayer(BuyBoatCFrame);
					end;
					if ((CFrame.new((-16927.451171875), 9.0863618850708, 433.8642883300781)).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
						if BuyBoat then
							BuyBoat:Stop();
						end;
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyBoat", _G.Settings.SeaEvent["Selected Boat"]);
						task.wait(1);
					end;
				elseif (game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"]) then
					repeat
						task.wait(0.1);
						if (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Sit == false then
							if TweenBoatFrozen then
								TweenBoatFrozen:Stop();
							end;
							local stoppos = TweenPlayer(((game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"])).VehicleSeat.CFrame * CFrame.new(0, 1, 0));
						elseif (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Sit == true then
							TweenBoatFrozen = TweenBoat(CFrame.new(-148073.359, 8.99999523, 7721.05078, -0.0825930536, -0.00000154416148, 0.996583343, -0.000018696026, 1, -0.000000000000391858095, -0.996583343, -0.0000186321486, -0.0825930536));
						end;
					until not _G.Settings.SeaStack["Summon Frozen Dimension"] or game.Workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension");
					if TweenBoatFrozen then
						TweenBoatFrozen:Stop();
					end;
				end;
			end;
		end);
	end;
end);
TweenToFrozenDimensionToggle = GetTab:AddToggle({
	Title = "Tween To Frozen Dimension",
	Value = _G.Settings.SeaStack["Tween To Frozen Dimension"],
	Callback = function(state)
		_G.Settings.SeaStack["Tween To Frozen Dimension"] = state;
		StopTween(_G.Settings.SeaStack["Tween To Frozen Dimension"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.SeaStack["Tween To Frozen Dimension"] then
			pcall(function()
				repeat
					task.wait(0.1);
					TweenPlayer(((game:GetService("Workspace"))._WorldOrigin.Locations:FindFirstChild("Frozen Dimension")).CFrame);
				until not _G.Settings.SeaStack["Tween To Frozen Dimension"];
			end);
		end;
	end;
end);
BribeLeviathanStatusParagraph = GetTab:AddParagraph({
	Title = "Leviathan Status",
	Desc = "0"
});
BribeLeviathanButton = GetTab:AddButton({
	Title = "Bribe Leviathan",
	Callback = function()
		local Status = (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("InfoLeviathan", "2");
		BribeLeviathanStatusParagraph:SetDesc(Status);
	end
});

GetTab:AddToggle({
	Title = "Auto Active Leviathan",
	Desc = "Quando encontrar a ilha do Leviathan, vai ate o NPC e ativa ele automaticamente.",
	Value = false,
	Callback = function(state)
		_G.AutoActivateLeviathan = state;
	end
});
task.spawn(function()
	while task.wait(0.5) do
		if not _G.AutoActivateLeviathan then continue end
		pcall(function()
			local char = game.Players.LocalPlayer.Character;
			if not char then return end
			local hrp = char:FindFirstChild("HumanoidRootPart");
			if not hrp then return end
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("Model") and (v.Name:lower():find("leviathan") or v.Name:lower():find("bribe")) then
					local npcRoot = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChildWhichIsA("BasePart");
					if npcRoot then
						local dist = (hrp.Position - npcRoot.Position).Magnitude;
						if dist > 20 then
							TweenPlayer(npcRoot.CFrame);
						else
							pcall(function()
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ActivateLeviathan");
							end)
							pcall(function()
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "1");
							end)
						end
					end
				end
			end
		end)
	end
end);

GetTab:AddToggle({
	Title = "Auto Kill Leviathan",
	Desc = "Detecta as caudas do Leviathan vivas e vai ate elas spammando todas as skills (Z X C V F).",
	Value = false,
	Callback = function(state)
		_G.AutoKillLeviathan = state;
	end
});
task.spawn(function()
	while task.wait(0.1) do
		if not _G.AutoKillLeviathan then continue end
		pcall(function()
			local char = game.Players.LocalPlayer.Character;
			if not char then return end
			local hrp = char:FindFirstChild("HumanoidRootPart");
			local hum = char:FindFirstChildOfClass("Humanoid");
			if not hrp or not hum then return end
			local closestTail = nil;
			local closestDist = math.huge;
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("Model") and v.Name:lower():find("tail") then
					local tailHum = v:FindFirstChildOfClass("Humanoid");
					if tailHum and tailHum.Health > 0 then
						local tailRoot = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChildWhichIsA("BasePart");
						if tailRoot then
							local dist = (hrp.Position - tailRoot.Position).Magnitude;
							if dist < closestDist then
								closestDist = dist;
								closestTail = tailRoot;
							end
						end
					end
				end
			end
			if closestTail then
				if closestDist > 30 then
					TweenPlayer(closestTail.CFrame * CFrame.new(0, 5, -10));
				else
					local VirtualUser = game:GetService("VirtualUser");
					hrp.CFrame = CFrame.lookAt(hrp.Position, closestTail.Position);
					local skillKeys = {"Z","X","C","V","F"};
					for _, key in pairs(skillKeys) do
						pcall(function()
							VirtualUser:CaptureController();
							VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame);
							task.wait(0.05);
						end)
						pcall(function()
							game:GetService("UserInputService");
							local inputObject = InputObject.new();
						end)
						pcall(function()
							game:GetService("VirtualInputManager"):SendKeyEvent(true, key, false, game);
							task.wait(0.08);
							game:GetService("VirtualInputManager"):SendKeyEvent(false, key, false, game);
						end)
					end
				end
			end
		end)
	end
end);

GetTab:AddToggle({
	Title = "Auto Get Heart Leviathan",
	Desc = "Quando Leviathan morrer, pega barco Beast Hunter, centraliza no local e atira no coracao.",
	Value = false,
	Callback = function(state)
		_G.AutoGetHeartLeviathan = state;
	end
});
task.spawn(function()
	while task.wait(0.5) do
		if not _G.AutoGetHeartLeviathan then continue end
		pcall(function()
			local char = game.Players.LocalPlayer.Character;
			if not char then return end
			local hrp = char:FindFirstChild("HumanoidRootPart");
			local hum = char:FindFirstChildOfClass("Humanoid");
			if not hrp or not hum then return end
			local beastHunter = nil;
			for _, b in pairs(workspace.Boats:GetChildren()) do
				if b.Name == "Beast Hunter" then
					local own = b:FindFirstChild("OwnerName") or b:FindFirstChild("Owner");
					if own and own.Value == game.Players.LocalPlayer.Name then
						beastHunter = b; break;
					end
				end
			end
			if not beastHunter then
				TweenPlayer(_BOAT_DEALER_CF);
				local tw = 0;
				repeat task.wait(0.2); tw = tw + 0.2;
				until (hrp.Position - _BOAT_DEALER_CF.Position).Magnitude < 20 or tw > 15;
				task.wait(0.3);
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "Beast Hunter");
				task.wait(2);
				for _, b in pairs(workspace.Boats:GetChildren()) do
					if b.Name == "Beast Hunter" then
						local own = b:FindFirstChild("OwnerName") or b:FindFirstChild("Owner");
						if own and own.Value == game.Players.LocalPlayer.Name then
							beastHunter = b; break;
						end
					end
				end
			end
			if not beastHunter then return end
			local leviathanHeart = nil;
			for _, v in pairs(workspace:GetDescendants()) do
				if v.Name:lower():find("heart") and v:IsA("BasePart") then
					leviathanHeart = v; break;
				end
			end
			if not leviathanHeart then return end
			if not hum.Sit then
				local seat = beastHunter:FindFirstChildWhichIsA("VehicleSeat");
				if seat then
					hrp.CFrame = seat.CFrame * CFrame.new(0, 1.5, 0);
					task.wait(0.8);
				end
				return;
			end
			local heartPos = leviathanHeart.Position;
			local targetCF = CFrame.new(heartPos.X, heartPos.Y - 10, heartPos.Z);
			local boatSeat = beastHunter:FindFirstChildWhichIsA("VehicleSeat");
			if boatSeat then
				local boatPos = boatSeat.Position;
				local distToHeart = (boatPos - heartPos).Magnitude;
				if distToHeart > 50 then
					TweenBoat(targetCF);
				else
					if distToHeart <= 15 then
						for _, v in pairs(workspace:GetDescendants()) do
							if v:IsA("Seat") and v.Name:lower():find("cannon") then
								hrp.CFrame = v.CFrame * CFrame.new(0, 1, 0);
								task.wait(0.5);
								pcall(function()
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("FireCannon", leviathanHeart.Position);
								end)
								task.wait(1);
								local stillExists = false;
								for _, p in pairs(workspace:GetDescendants()) do
									if p.Name:lower():find("heart") and p:IsA("BasePart") then
										stillExists = true; break;
									end
								end
								if not stillExists then
									_G.AutoGetHeartLeviathan = false;
								end
								break;
							end
						end
					end
				end
			end
		end)
	end
end);

local _leviathanIslandList = {"Cachoeira Hydra", "Tiki Outpost"};
local _leviathanIslandCFrames = {
	["Cachoeira Hydra"] = CFrame.new(-44541.7617, 30.0003204, -1244.8584),
	["Tiki Outpost"] = CFrame.new(-16927.451, 9.086, 433.864),
};
GetTab:AddDropdown({
	Title = "Auto Drive Boat - Ilha Destino",
	Desc = "Selecione a ilha de destino para o Auto Drive Boat",
	Values = _leviathanIslandList,
	Value = "Tiki Outpost",
	Callback = function(opt)
		_G.AutoDriveBoatIsland = opt;
	end
});
GetTab:AddToggle({
	Title = "Auto Drive Boat",
	Desc = "Monta no barco Beast Hunter mais proximo e vai via Tween para a ilha selecionada.",
	Value = false,
	Callback = function(state)
		_G.AutoDriveBoat = state;
	end
});
task.spawn(function()
	while task.wait(0.5) do
		if not _G.AutoDriveBoat then continue end
		pcall(function()
			local char = game.Players.LocalPlayer.Character;
			if not char then return end
			local hrp = char:FindFirstChild("HumanoidRootPart");
			local hum = char:FindFirstChildOfClass("Humanoid");
			if not hrp or not hum then return end
			local closestBoat = nil;
			local closestDist = math.huge;
			for _, b in pairs(workspace.Boats:GetChildren()) do
				if b.Name == "Beast Hunter" then
					local seat = b:FindFirstChildWhichIsA("VehicleSeat");
					if seat then
						local dist = (hrp.Position - seat.Position).Magnitude;
						if dist < closestDist then
							closestDist = dist;
							closestBoat = b;
						end
					end
				end
			end
			if not closestBoat then return end
			if not hum.Sit then
				local seat = closestBoat:FindFirstChildWhichIsA("VehicleSeat");
				if seat then
					hrp.CFrame = seat.CFrame * CFrame.new(0, 1.5, 0);
					task.wait(0.8);
				end
				return;
			end
			local islandName = _G.AutoDriveBoatIsland or "Tiki Outpost";
			local islandCF = _leviathanIslandCFrames[islandName];
			if islandCF then
				local dist = (hrp.Position - islandCF.Position).Magnitude;
				if dist > 200 then
					TweenBoat(islandCF);
				else
					_G.AutoDriveBoat = false;
				end
			end
		end)
	end
end);
KitsuneStatusSeaStackParagraph = GetTab:AddParagraph({
	Title = "Kitsune Status",
	Desc = "N/A"
});
AutoSummonKitsuneIslandToggle = GetTab:AddToggle({
	Title = "Summon Kitsune Island",
	Value = _G.Settings.SeaStack["Summon Kitsune Island"],
	Callback = function(state)
		_G.Settings.SeaStack["Summon Kitsune Island"] = state;
		StopTween(_G.Settings.SeaStack["Summon Kitsune Island"]);
		(getgenv()).SaveSetting();
	end
});
TweenToKitsuneIslandToggle = GetTab:AddToggle({
	Title = "Tween To Kitsune Island",
	Value = _G.Settings.SeaStack["Tween To Kitsune Island"],
	Callback = function(state)
		_G.Settings.SeaStack["Tween To Kitsune Island"] = state;
		StopTween(_G.Settings.SeaStack["Tween To Kitsune Island"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.SeaStack["Tween To Kitsune Island"] and World3 then
			if (game:GetService("Workspace")).Map:FindFirstChild("KitsuneIsland") then
				TweenPlayer(game.Workspace.Map.KitsuneIsland.ShrineActive.NeonShrinePart.CFrame * CFrame.new(0, 0, 10));
			end;
		end;
	end;
end);
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if _G.Settings.SeaStack["Summon Kitsune Island"] and World3 then
				if not (game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"]) then
					local BuyBoatCFrame = CFrame.new(-16927.451171875, 9.0863618850708, 433.8642883300781);
					if (BuyBoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then
						BTP(BuyBoatCFrame);
					else
						BuyBoatKitsune = TweenPlayer(BuyBoatCFrame);
					end;
					if ((CFrame.new((-16927.451171875), 9.0863618850708, 433.8642883300781)).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
						if BuyBoatKitsune then
							BuyBoatKitsune:Stop();
						end;
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyBoat", _G.Settings.SeaEvent["Selected Boat"]);
						task.wait(1);
					end;
				elseif (game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"]) then
					repeat
						task.wait(0.1);
						if (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Sit == false then
							if TweenBoatKitsune then
								TweenBoatKitsune:Stop();
							end;
							local stoppos = TweenPlayer(((game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"])).VehicleSeat.CFrame * CFrame.new(0, 1, 0));
						elseif (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Sit == true then
							TweenBoatKitsune = TweenBoat(CFrame.new(-44541.7617, 30.0003204, -1244.8584, -0.0844199061, -0.00553312758, 0.9964149, -0.0654025897, 0.997858942, 0.000000000202319411, -0.99428153, -0.0651681125, -0.0846010372));
						end;
					until not _G.Settings.SeaStack["Summon Kitsune Island"] or game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island");
					if TweenBoatKitsune then
						TweenBoatKitsune:Stop();
					end;
				end;
			end;
		end);
	end;
end);
AutoCollectAzureEmberToggle = GetTab:AddToggle({
	Title = "Auto Collect Azure Ember",
	Value = _G.Settings.SeaStack["Auto Collect Azure Ember"],
	Callback = function(state)
		_G.Settings.SeaStack["Auto Collect Azure Ember"] = state;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.SeaStack["Auto Collect Azure Ember"] and World3 then
			pcall(function()
				if (game:GetService("Workspace")):FindFirstChild("AttachedAzureEmber") then
					TweenPlayer((((game:GetService("Workspace")):WaitForChild("EmberTemplate")):FindFirstChild("Part")).CFrame);
				end;
			end);
		end;
	end;
end);
SetAzureEmberSlider = GetTab:AddSlider({
	Title = "Set Azure Ember",
	Step = 1,
	Value = {
		Min = 1,
		Max = 25,
		Default = _G.Settings.SeaStack["Set Azure Ember"]
	},
	Callback = function(value)
		_G.Settings.SeaStack["Set Azure Ember"] = value;
		(getgenv()).SaveSetting();
	end
});
AutoTradeAzureEmberToggle = GetTab:AddToggle({
	Title = "Auto Trade Azure Ember",
	Value = _G.Settings.SeaStack["Auto Trade Azure Ember"],
	Callback = function(state)
		_G.Settings.SeaStack["Auto Trade Azure Ember"] = state;
		(getgenv()).SaveSetting();
	end
});
function GetCountMaterials(MaterialName)
	local Inventory = (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("getInventory");
	for i, v in pairs(Inventory) do
		if v.Name == MaterialName then
			return v.Count;
		end;
	end;
end;
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.SeaStack["Auto Trade Azure Ember"] and World3 then
			pcall(function()
				local AzureAvilable = GetCountMaterials("Azure Ember");
				if AzureAvilable >= _G.Settings.SeaStack["Set Azure Ember"] then
					((game:GetService("ReplicatedStorage")).Modules.Net:FindFirstChild("RF/KitsuneStatuePray")):InvokeServer();
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("KitsuneStatuePray");
				end;
			end);
		end;
	end;
end);
MirageStatusSeaStackParagraph = GetTab:AddParagraph({
	Title = "Mirage Status",
	Desc = "N/A"
});
TweenToMirageIslandToggle = GetTab:AddToggle({
	Title = "Tween To Mirage Island",
	Value = _G.Settings.SeaStack["Tween To Mirage Island"],
	Callback = function(state)
		_G.Settings.SeaStack["Tween To Mirage Island"] = state;
		StopTween(_G.Settings.SeaStack["Tween To Mirage Island"]);
		(getgenv()).SaveSetting();
	end
});

_G.FindMirage = _G.FindMirage or false;
_G.AutoBlueGear = _G.AutoBlueGear or false;

GetTab:AddSection("MIRAGE ISLAND");

GetTab:AddToggle({
	Title = "Auto Find Mirage Island",
	Desc = "Compra barco na Tiki, vai ao mar Lv 4, patrulha ate Mirage spawnar. Se barco quebrar, reseta e recomeca.",
	Value = _G.Settings.SeaStack["Auto Find Mirage"] or false,
	Callback = function(state)
		_G.FindMirage = state;
		if _G.Settings and _G.Settings.SeaStack then _G.Settings.SeaStack["Auto Find Mirage"] = state; (getgenv()).SaveSetting(); end;
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if not _G.FindMirage then return; end;
			local plr = game.Players.LocalPlayer;
			local char = plr.Character;
			if not char then return; end;
			local hrp = char:FindFirstChild("HumanoidRootPart");
			local hum = char:FindFirstChildOfClass("Humanoid");
			if not hrp or not hum then return; end;
			local mirage = workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island");
			if mirage then
				TweenPlayer(mirage.CFrame);
				return;
			end;
			local selectedBoat = _G.Settings.SeaEvent["Selected Boat"] or "Guardian";
			local boat = nil;
			for _, b in pairs(workspace.Boats:GetChildren()) do
				if b.Name == selectedBoat then
					local owner = b:FindFirstChild("OwnerName") or b:FindFirstChild("Owner");
					if not owner or owner.Value == plr.Name then boat = b; break; end;
				end;
			end;
			if not boat then
				local _TIKI_NPC_CF = CFrame.new(-16927.451, 9.086, 433.864);
				TweenPlayer(_TIKI_NPC_CF);
				task.wait(2);
				if (hrp.Position - _TIKI_NPC_CF.Position).Magnitude < 30 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", selectedBoat);
					task.wait(1.5);
				end;
				return;
			end;
			if not hum.Sit then
				local seat = boat:FindFirstChildWhichIsA("VehicleSeat");
				if seat then hrp.CFrame = seat.CFrame * CFrame.new(0,1.5,0); end;
				return;
			end;
			local _MIRAGE_PATROL_CF = CFrame.new(-34054.6875, 30.22, -2560.12);
			local _MIRAGE_PATROL_CF2 = CFrame.new(-38887.5547, 30.0, -2162.99);
			local patrolTarget = (hrp.Position - _MIRAGE_PATROL_CF.Position).Magnitude < 500 and _MIRAGE_PATROL_CF2 or _MIRAGE_PATROL_CF;
			TweenBoat(patrolTarget);
		end);
	end;
end);

GetTab:AddToggle({
	Title = "Auto Blue Gear",
	Desc = "Vai ao ponto mais alto da Mirage, olha fixamente para a lua. Quando a lua brilhar a noite, teleporta para a engrenagem.",
	Value = _G.Settings.SeaStack["Auto Blue Gear"] or false,
	Callback = function(state)
		_G.AutoBlueGear = state;
		if _G.Settings and _G.Settings.SeaStack then _G.Settings.SeaStack["Auto Blue Gear"] = state; (getgenv()).SaveSetting(); end;
	end
});
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if not _G.AutoBlueGear then continue; end;
			local mystic = workspace.Map:FindFirstChild("MysticIsland");
			if not mystic then continue; end;
			local highPoint = GetHighestPoint and GetHighestPoint();
			if not highPoint then continue; end;
			local plr = game.Players.LocalPlayer;
			local char = plr.Character;
			if not char then continue; end;
			local hrp = char:FindFirstChild("HumanoidRootPart");
			if not hrp then continue; end;
			TweenPlayer(highPoint.CFrame * CFrame.new(0, 211.88, 0));
			local moonDir = game.Lighting:GetMoonDirection();
			local lookAtPos = hrp.Position + moonDir * 100;
			workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.p, lookAtPos);
			local nightTime = game.Lighting.ClockTime >= 18 or game.Lighting.ClockTime <= 6;
			if nightTime then
				for _, v in pairs(mystic:GetDescendants()) do
					if v:IsA("MeshPart") and v.Material == Enum.Material.Neon and v.BrickColor == BrickColor.new("Bright blue") then
						hrp.CFrame = v.CFrame;
						task.wait(0.2);
						pcall(function()
							Library:Notify({Title = "TRon Void Hub", Content = "Quest completa!", Icon = "bell", Duration = 6});
						end);
						_G.AutoBlueGear = false;
						if _G.Settings and _G.Settings.SeaStack then _G.Settings.SeaStack["Auto Blue Gear"] = false; (getgenv()).SaveSetting(); end;
						return;
					end;
				end;
				for _, v in pairs(mystic:GetDescendants()) do
					if v:IsA("MeshPart") and v.Material == Enum.Material.Neon then
						hrp.CFrame = v.CFrame;
						task.wait(0.2);
						pcall(function()
							Library:Notify({Title = "TRon Void Hub", Content = "Quest completa!", Icon = "bell", Duration = 6});
						end);
						_G.AutoBlueGear = false;
						if _G.Settings and _G.Settings.SeaStack then _G.Settings.SeaStack["Auto Blue Gear"] = false; (getgenv()).SaveSetting(); end;
						return;
					end;
				end;
			end;
		end;
	end);
end);

function GetHighestPoint()
	for i, v in pairs((game:GetService("Workspace")).Map.MysticIsland:GetDescendants()) do
		if v:IsA("MeshPart") then
			if v.MeshId == "rbxassetid://83190276951914" then
				return v;
			end;
		end;
	end;
end;
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if _G.Settings.Race["Tween To Highest Mirage"] then
				if (game:GetService("Workspace")).Map:FindFirstChild("MysticIsland") then
					TweenPlayer((GetHighestPoint()).CFrame * CFrame.new(0, 211.88, 0));
				end;
			end;
		end;
	end);
end);
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if _G.Settings.Race["Tween To Mirage Island"] then
				if (game:GetService("Workspace")).Map:FindFirstChild("MysticIsland") then
					TweenPlayer((GetHighestPoint()).CFrame * CFrame.new(0, 211.88, 0));
				end;
			end;
		end;
	end);
end);
SeaBeastSeaStackSection = GetTab:AddSection("Sea Beasts");
AutoAttackSeaBeastsToggle = GetTab:AddToggle({
	Title = "Auto Attack Seabeasts",
	Value = _G.Settings.SeaStack["Auto Attack Seabeasts"],
	Callback = function(state)
		_G.Settings.SeaStack["Auto Attack Seabeasts"] = state;
		StopTween(_G.Settings.SeaStack["Auto Attack Seabeasts"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	pcall(function()
		while task.wait() do
			if _G.Settings.SeaStack["Auto Attack Seabeasts"] and (World2 or World3) then
				if (game:GetService("Workspace")):FindFirstChild("SeaBeasts") then
					for i, v in pairs((game:GetService("Workspace")).SeaBeasts:GetChildren()) do
						if CheckSeaBeast() then
							repeat
								task.wait(0.15);
								CFrameSeaBeast = v.HumanoidRootPart.CFrame * CFrame.new(0, 200, 0);
								if (CFrameSeaBeast.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position).Magnitude <= 400 then
									_G.SeaSkill = true;
								else
									_G.SeaSkill = false;
								end;
								AutoHaki();
								Skillaimbot = true;
								AimBotSkillPosition = v.HumanoidRootPart.CFrame.Position;
								if SBAttacking then
									TweenPlayer(CFrameSeaBeast * CFrame.new(math.random(100, 300), 100, math.random(100, 300)));
								else
									TweenPlayer(CFrameSeaBeast * CFrame.new(0, 100, 0));
								end;
							until not _G.Settings.SeaEvent["Auto Attack Seabeasts"] or CheckSeaBeast() == false or (not v:FindFirstChild("Humanoid")) or (not v:FindFirstChild("HumanoidRootPart")) or v.Humanoid.Health < 0 or (not v.Parent);
							Skillaimbot = false;
							_G.SeaSkill = false;
						else
							Skillaimbot = false;
							_G.SeaSkill = false;
						end;
					end;
				end;
			end;
		end;
	end);
end);
SettingSeaSection = EventTab:AddSection("Setting Sea");
LightningToggle = EventTab:AddToggle({
	Title = "Lightning",
	Value = _G.Settings.SettingSea.Lightning,
	Callback = function(state)
		_G.Settings.SettingSea.Lightning = state;
	end
});
local RunService = game:GetService("RunService");
RunService.Heartbeat:Connect(function()
	local Lighting = game:GetService("Lighting");
	if _G.Settings.SettingSea.Lightning then
		Lighting.ClockTime = 12;
	end;
end);
IncreaseSpeedBoatToggle = EventTab:AddToggle({
	Title = "Increase Speed Boat",
	Value = _G.Settings.SettingSea["Increase Speed Boat"],
	Callback = function(state)
		_G.Settings.SettingSea["Increase Speed Boat"] = state;
	end
});
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			local vehicleSeats = {};
			for i, v in pairs(game.Workspace.Boats:GetDescendants()) do
				if v:IsA("VehicleSeat") then
					table.insert(vehicleSeats, v);
				end;
			end;
			if _G.Settings.SettingSea["Increase Boat Speed"] then
				for _, v in pairs(vehicleSeats) do
					v.MaxSpeed = 350;
				end;
			else
				for _, v in pairs(vehicleSeats) do
					v.MaxSpeed = 150;
				end;
			end;
		end);
	end;
end);
NoClipRockToggle = EventTab:AddToggle({
	Title = "No Clip Rock",
	Value = _G.Settings.SettingSea["No Clip Rock"],
	Callback = function(state)
		_G.Settings.SettingSea["No Clip Rock"] = state;
	end
});
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			for i, boat in pairs((game:GetService("Workspace")).Boats:GetChildren()) do
				for _, v in pairs((game:GetService("Workspace")).Boats[boat.Name]:GetDescendants()) do
					if v:IsA("BasePart") then
						if _G.Settings.SettingSea["No Clip Rock"] or _G.GrindSea then
							v.CanCollide = false;
						else
							v.CanCollide = true;
						end;
					end;
				end;
			end;
		end);
	end;
end);
SettingSeaSection = EventTab:AddSection("Tools");
UseDevilFruitSkillToggle = EventTab:AddToggle({
	Title = "Use Devil Fruit Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Use Devil Fruit Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
UseMeleeSkillToggle = EventTab:AddToggle({
	Title = "Use Melee Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Use Melee Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
UseSwordSkillToggle = EventTab:AddToggle({
	Title = "Use Sword Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Use Sword Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
UseGunSkillToggle = EventTab:AddToggle({
	Title = "Use Gun Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Use Gun Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
DevilFruitSkillSection = EventTab:AddSection("Devil Fruit Skill");
DevilFruitZSkillToggle = EventTab:AddToggle({
	Title = "Devil Fruit Z Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Devil Fruit Z Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
DevilFruitXSkillToggle = EventTab:AddToggle({
	Title = "Devil Fruit X Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Devil Fruit X Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
DevilFruitCSkillToggle = EventTab:AddToggle({
	Title = "Devil Fruit C Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Devil Fruit C Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
DevilFruitVSkillToggle = EventTab:AddToggle({
	Title = "Devil Fruit V Skill",
	Value = _G.Settings.SettingSea["Devil Fruit V Skill"],
	Callback = function(state)
		_G.Settings.SettingSea["Devil Fruit V Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
DevilFruitFSkillToggle = EventTab:AddToggle({
	Title = "Devil Fruit F Skill",
	Value = _G.Settings.SettingSea["Devil Fruit F Skill"],
	Callback = function(state)
		_G.Settings.SettingSea["Devil Fruit F Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
MeleeSkillSection = EventTab:AddSection("Melee Skill");
MeleeZSkillToggle = EventTab:AddToggle({
	Title = "Melee Z Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Melee Z Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
MeleeXSkillToggle = EventTab:AddToggle({
	Title = "Melee X Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Melee X Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
MeleeCSkillToggle = EventTab:AddToggle({
	Title = "Melee C Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Melee C Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
MeleeVSkillToggle = EventTab:AddToggle({
	Title = "Melee V Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Melee V Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
DoneSkillGun = false;
DoneSkillSword = false;
DoneSkillFruit = false;
DoneSkillMelee = false;
task.spawn(function()
	while task.wait() do
		pcall(function()
			if _G.SeaSkill then
				if _G.Settings.SettingSea["Use Devil Fruit Skill"] and DoneSkillFruit == false then
					for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA("Tool") then
							if v.ToolTip == "Blox Fruit" then
								game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
							end;
						end;
					end;
					if _G.Settings.SettingSea["Devil Fruit Z Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
						task.wait(0.1);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
					end;
					if _G.Settings.SettingSea["Devil Fruit X Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
						task.wait(0.1);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
					end;
					if _G.Settings.SettingSea["Devil Fruit C Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "C", false, game);
						task.wait(0.1);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "C", false, game);
					end;
					if _G.Settings.SettingSea["Devil Fruit V Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "V", false, game);
						task.wait(0.1);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "V", false, game);
					end;
					if _G.Settings.SettingSea["Devil Fruit F Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "F", false, game);
						task.wait(0.1);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "F", false, game);
					end;
					DoneSkillFruit = true;
				end;
				if _G.Settings.SettingSea["Use Melee Skill"] and DoneSkillMelee == false then
					for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA("Tool") then
							if v.ToolTip == "Melee" then
								game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
							end;
						end;
					end;
					if _G.Settings.SettingSea["Melee Z Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
						task.wait(0);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
					end;
					if _G.Settings.SettingSea["Melee X Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
						task.wait(0);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
					end;
					if _G.Settings.SettingSea["Melee C Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "C", false, game);
						task.wait(0);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "C", false, game);
					end;
					if _G.Settings.SettingSea["Melee V Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "V", false, game);
						task.wait(0);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "V", false, game);
					end;
					DoneSkillMelee = true;
				end;
				if _G.Settings.SettingSea["Use Sword Skill"] and DoneSkillSword == false then
					for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA("Tool") then
							if v.ToolTip == "Sword" then
								game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
							end;
						end;
					end;
					(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
					task.wait(0);
					(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
					(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
					task.wait(0);
					(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
					DoneSkillSword = true;
				end;
				if _G.Settings.SettingSea["Use Gun Skill"] and DoneSkillGun == false then
					for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA("Tool") then
							if v.ToolTip == "Gun" then
								game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
							end;
						end;
					end;
					(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
					task.wait(0.1);
					(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
					(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
					task.wait(0.1);
					(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
					DoneSkillGun = true;
				end;
				DoneSkillGun = false;
				DoneSkillSword = false;
				DoneSkillFruit = false;
				DoneSkillMelee = false;
			end;
		end);
	end;
end);
function CheckSeaBeast()
	if (game:GetService("Workspace")):FindFirstChild("SeaBeasts") then
		for i, v in pairs((game:GetService("Workspace")).SeaBeasts:GetChildren()) do
			if v:FindFirstChild("Humanoid") or v:FindFirstChild("HumanoidRootPart") or v.Humanoid.Health < 0 then
				return true;
			end;
		end;
	end;
	return false;
end;
local gg = getrawmetatable(game);
local old = gg.__namecall;
setreadonly(gg, false);
gg.__namecall = newcclosure(function(...)
	local method = getnamecallmethod();
	local args = {
		...
	};
	if tostring(method) == "FireServer" then
		if tostring(args[1]) == "RemoteEvent" then
			if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
				if Skillaimbot then
					args[2] = AimBotSkillPosition;
					return old(unpack(args));
				end;
			end;
		end;
	end;
	return old(...);
end);
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if UseSkill then
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
					if v.Name == MonFarm and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health <= v.Humanoid.MaxHealth * _G.Settings.Setting["Mastery Health"] / 100 then
						if _G.Settings.Setting["Fruit Mastery Skill Z"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
						end;
						if _G.Settings.Setting["Fruit Mastery Skill X"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
						end;
						if _G.Settings.Setting["Fruit Mastery Skill C"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "C", false, game);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "C", false, game);
						end;
						if _G.Settings.Setting["Fruit Mastery Skill V"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "V", false, game);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "V", false, game);
						end;
						if _G.Settings.Setting["Fruit Mastery Skill F"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "F", false, game);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "F", false, game);
						end;
					end;
				end;
			end;
		end);
	end;
end);
task.spawn(function()
	while task.wait() do
		pcall(function()
			if UseGunSkill then
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
					if v.Name == MonFarm and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health <= v.Humanoid.MaxHealth * _G.Settings.Setting["Mastery Health"] / 100 then
						if _G.Settings.Setting["Gun Mastery Skill Z"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
							task.wait(0.5);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
						end;
						if _G.Settings.Setting["Gun Mastery Skill X"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
							task.wait(0.5);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
						end;
					end;
				end;
			end;
		end);
	end;
end);
LocalPlayerTab:AddSection(" PvP Tools");

local _DUNGEON_PLACE_ID = 73902483975735;
local _IS_DUNGEON = game.PlaceId == _DUNGEON_PLACE_ID;

getgenv().DungeonConfig = getgenv().DungeonConfig or {
	AutoFuse        = false,
	AutoSpin        = false,
	AutoEnter       = false,
	AutoComplete    = false,
	AutoSkipHub     = false,
	SelectBuffs     = false,
	SelectedBuffs   = {},
	AutoFully       = false,
};

if not _IS_DUNGEON then
	MultiFarmTab:AddSection("Dungeon World");


LocalPlayerSection = LocalPlayerTab:AddSection("Local Player");
AutoActiveRaceV3Toggle = LocalPlayerTab:AddToggle({
	Title = "Active Race V3",
	Value = _G.Settings.LocalPlayer["Active Race V3"],
	Callback = function(state)
		_G.Settings.LocalPlayer["Active Race V3"] = state;
		(getgenv()).SaveSetting();
	end
});
AutoActiveRaceV4Toggle = LocalPlayerTab:AddToggle({
	Title = "Active Race V4",
	Value = _G.Settings.LocalPlayer["Active Race V4"],
	Callback = function(state)
		_G.Settings.LocalPlayer["Active Race V4"] = state;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.LocalPlayer["Active Race V4"] then
			if tonumber(((game:GetService("Players")).LocalPlayer.Character:WaitForChild("RaceEnergy")).Value) == 1 then
				if (game:GetService("Players")).LocalPlayer.Character.RaceTransformed.Value == false then
					(game:GetService("VirtualInputManager")):SendKeyEvent(true, "Y", false, game);
					task.wait(0.1);
					(game:GetService("VirtualInputManager")):SendKeyEvent(false, "Y", false, game);
				end;
			end;
		end;
	end;
end);
task.spawn(function()
	pcall(function()
		while task.wait(1) do
			if _G.Settings.LocalPlayer["Active Race V3"] then
				(game:GetService("ReplicatedStorage")).Remotes.CommE:FireServer("ActivateAbility");
			end;
		end;
	end);
end);
WalkOnWaterToggle = LocalPlayerTab:AddToggle({
	Title = "Walk On Water",
	Value = _G.Settings.LocalPlayer["Walk On Water"],
	Callback = function(state)
		_G.Settings.LocalPlayer["Walk On Water"] = state;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if _G.Settings.LocalPlayer["Walk On Water"] then
				(game:GetService("Workspace")).Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000);
			else
				(game:GetService("Workspace")).Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000);
			end;
		end);
	end;
end);
NoClipPlayerToggle = LocalPlayerTab:AddToggle({
	Title = "No Clip",
	Value = _G.Settings.LocalPlayer["No Clip"],
	Callback = function(state)
		_G.Settings.LocalPlayer["No Clip"] = state;
		(getgenv()).SaveSetting();
	end
});


SettingSeaSection = EventTab:AddSection("Setting Sea");
LightningToggle = EventTab:AddToggle({
	Title = "Lightning",
	Value = _G.Settings.SettingSea.Lightning,
	Callback = function(state)
		_G.Settings.SettingSea.Lightning = state;
	end
});
local RunService = game:GetService("RunService");
RunService.Heartbeat:Connect(function()
	local Lighting = game:GetService("Lighting");
	if _G.Settings.SettingSea.Lightning then
		Lighting.ClockTime = 12;
	end;
end);
IncreaseSpeedBoatToggle = EventTab:AddToggle({
	Title = "Increase Speed Boat",
	Value = _G.Settings.SettingSea["Increase Speed Boat"],
	Callback = function(state)
		_G.Settings.SettingSea["Increase Speed Boat"] = state;
	end
});
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			local vehicleSeats = {};
			for i, v in pairs(game.Workspace.Boats:GetDescendants()) do
				if v:IsA("VehicleSeat") then
					table.insert(vehicleSeats, v);
				end;
			end;
			if _G.Settings.SettingSea["Increase Boat Speed"] then
				for _, v in pairs(vehicleSeats) do
					v.MaxSpeed = 350;
				end;
			else
				for _, v in pairs(vehicleSeats) do
					v.MaxSpeed = 150;
				end;
			end;
		end);
	end;
end);
NoClipRockToggle = EventTab:AddToggle({
	Title = "No Clip Rock",
	Value = _G.Settings.SettingSea["No Clip Rock"],
	Callback = function(state)
		_G.Settings.SettingSea["No Clip Rock"] = state;
	end
});
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			for i, boat in pairs((game:GetService("Workspace")).Boats:GetChildren()) do
				for _, v in pairs((game:GetService("Workspace")).Boats[boat.Name]:GetDescendants()) do
					if v:IsA("BasePart") then
						if _G.Settings.SettingSea["No Clip Rock"] or _G.GrindSea then
							v.CanCollide = false;
						else
							v.CanCollide = true;
						end;
					end;
				end;
			end;
		end);
	end;
end);
SettingSeaSection = EventTab:AddSection("Tools");
UseDevilFruitSkillToggle = EventTab:AddToggle({
	Title = "Use Devil Fruit Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Use Devil Fruit Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
UseMeleeSkillToggle = EventTab:AddToggle({
	Title = "Use Melee Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Use Melee Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
UseSwordSkillToggle = EventTab:AddToggle({
	Title = "Use Sword Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Use Sword Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
UseGunSkillToggle = EventTab:AddToggle({
	Title = "Use Gun Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Use Gun Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
DevilFruitSkillSection = EventTab:AddSection("Devil Fruit Skill");
DevilFruitZSkillToggle = EventTab:AddToggle({
	Title = "Devil Fruit Z Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Devil Fruit Z Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
DevilFruitXSkillToggle = EventTab:AddToggle({
	Title = "Devil Fruit X Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Devil Fruit X Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
DevilFruitCSkillToggle = EventTab:AddToggle({
	Title = "Devil Fruit C Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Devil Fruit C Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
DevilFruitVSkillToggle = EventTab:AddToggle({
	Title = "Devil Fruit V Skill",
	Value = _G.Settings.SettingSea["Devil Fruit V Skill"],
	Callback = function(state)
		_G.Settings.SettingSea["Devil Fruit V Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
DevilFruitFSkillToggle = EventTab:AddToggle({
	Title = "Devil Fruit F Skill",
	Value = _G.Settings.SettingSea["Devil Fruit F Skill"],
	Callback = function(state)
		_G.Settings.SettingSea["Devil Fruit F Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
MeleeSkillSection = EventTab:AddSection("Melee Skill");
MeleeZSkillToggle = EventTab:AddToggle({
	Title = "Melee Z Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Melee Z Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
MeleeXSkillToggle = EventTab:AddToggle({
	Title = "Melee X Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Melee X Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
MeleeCSkillToggle = EventTab:AddToggle({
	Title = "Melee C Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Melee C Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
MeleeVSkillToggle = EventTab:AddToggle({
	Title = "Melee V Skill",
	Value = true,
	Callback = function(state)
		_G.Settings.SettingSea["Melee V Skill"] = state;
		(getgenv()).SaveSetting();
	end
});
DoneSkillGun = false;
DoneSkillSword = false;
DoneSkillFruit = false;
DoneSkillMelee = false;
task.spawn(function()
	while task.wait() do
		pcall(function()
			if _G.SeaSkill then
				if _G.Settings.SettingSea["Use Devil Fruit Skill"] and DoneSkillFruit == false then
					for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA("Tool") then
							if v.ToolTip == "Blox Fruit" then
								game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
							end;
						end;
					end;
					if _G.Settings.SettingSea["Devil Fruit Z Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
						task.wait(0.1);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
					end;
					if _G.Settings.SettingSea["Devil Fruit X Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
						task.wait(0.1);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
					end;
					if _G.Settings.SettingSea["Devil Fruit C Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "C", false, game);
						task.wait(0.1);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "C", false, game);
					end;
					if _G.Settings.SettingSea["Devil Fruit V Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "V", false, game);
						task.wait(0.1);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "V", false, game);
					end;
					if _G.Settings.SettingSea["Devil Fruit F Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "F", false, game);
						task.wait(0.1);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "F", false, game);
					end;
					DoneSkillFruit = true;
				end;
				if _G.Settings.SettingSea["Use Melee Skill"] and DoneSkillMelee == false then
					for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA("Tool") then
							if v.ToolTip == "Melee" then
								game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
							end;
						end;
					end;
					if _G.Settings.SettingSea["Melee Z Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
						task.wait(0);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
					end;
					if _G.Settings.SettingSea["Melee X Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
						task.wait(0);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
					end;
					if _G.Settings.SettingSea["Melee C Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "C", false, game);
						task.wait(0);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "C", false, game);
					end;
					if _G.Settings.SettingSea["Melee V Skill"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "V", false, game);
						task.wait(0);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "V", false, game);
					end;
					DoneSkillMelee = true;
				end;
				if _G.Settings.SettingSea["Use Sword Skill"] and DoneSkillSword == false then
					for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA("Tool") then
							if v.ToolTip == "Sword" then
								game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
							end;
						end;
					end;
					(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
					task.wait(0);
					(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
					(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
					task.wait(0);
					(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
					DoneSkillSword = true;
				end;
				if _G.Settings.SettingSea["Use Gun Skill"] and DoneSkillGun == false then
					for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA("Tool") then
							if v.ToolTip == "Gun" then
								game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
							end;
						end;
					end;
					(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
					task.wait(0.1);
					(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
					(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
					task.wait(0.1);
					(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
					DoneSkillGun = true;
				end;
				DoneSkillGun = false;
				DoneSkillSword = false;
				DoneSkillFruit = false;
				DoneSkillMelee = false;
			end;
		end);
	end;
end);
function CheckSeaBeast()
	if (game:GetService("Workspace")):FindFirstChild("SeaBeasts") then
		for i, v in pairs((game:GetService("Workspace")).SeaBeasts:GetChildren()) do
			if v:FindFirstChild("Humanoid") or v:FindFirstChild("HumanoidRootPart") or v.Humanoid.Health < 0 then
				return true;
			end;
		end;
	end;
	return false;
end;
local gg = getrawmetatable(game);
local old = gg.__namecall;
setreadonly(gg, false);
gg.__namecall = newcclosure(function(...)
	local method = getnamecallmethod();
	local args = {
		...
	};
	if tostring(method) == "FireServer" then
		if tostring(args[1]) == "RemoteEvent" then
			if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
				if Skillaimbot then
					args[2] = AimBotSkillPosition;
					return old(unpack(args));
				end;
			end;
		end;
	end;
	return old(...);
end);
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if UseSkill then
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
					if v.Name == MonFarm and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health <= v.Humanoid.MaxHealth * _G.Settings.Setting["Mastery Health"] / 100 then
						if _G.Settings.Setting["Fruit Mastery Skill Z"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
						end;
						if _G.Settings.Setting["Fruit Mastery Skill X"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
						end;
						if _G.Settings.Setting["Fruit Mastery Skill C"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "C", false, game);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "C", false, game);
						end;
						if _G.Settings.Setting["Fruit Mastery Skill V"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "V", false, game);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "V", false, game);
						end;
						if _G.Settings.Setting["Fruit Mastery Skill F"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "F", false, game);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "F", false, game);
						end;
					end;
				end;
			end;
		end);
	end;
end);
task.spawn(function()
	while task.wait() do
		pcall(function()
			if UseGunSkill then
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
					if v.Name == MonFarm and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health <= v.Humanoid.MaxHealth * _G.Settings.Setting["Mastery Health"] / 100 then
						if _G.Settings.Setting["Gun Mastery Skill Z"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
							task.wait(0.5);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
						end;
						if _G.Settings.Setting["Gun Mastery Skill X"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
							task.wait(0.5);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
						end;
					end;
				end;
			end;
		end);
	end;
end);
LocalPlayerSection = LocalPlayerTab:AddSection("Local Player");


RaceTabSection = RaceTab:AddSection("Race");
local PlaceV4List = {
	"Top Of GreatTree",
	"Timple Of Time",
	"Lever Pull",
	"Acient One"
};
SelectedPlaceDropdown = RaceTab:AddDropdown({
	Title = "Selected Place",
	Values = PlaceV4List,
	Value = _G.Settings.Race["Selected Place"],
	Callback = function(value)
		_G.Settings.Race["Selected Place"] = value;
		(getgenv()).SaveSetting();
	end
});
TeleportToPlaceToggle = RaceTab:AddToggle({
	Title = "Teleport To Place",
	Value = _G.Settings.Race["Teleport To Place"],
	Callback = function(state)
		_G.Settings.Race["Teleport To Place"] = state;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.Race["Teleport To Place"] then
			pcall(function()
				if _G.Settings.Race["Selected Place"] == "Top Of GreatTree" then
					TweenPlayer(CFrame.new(2947.556884765625, 2281.630615234375, -7213.54931640625));
				elseif _G.Settings.Race["Selected Place"] == "Timple Of Time" then
					(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875);
				elseif _G.Settings.Race["Selected Place"] == "Lever Pull" then
					local LeverPullPos = CFrame.new(28575.181640625, 14936.6279296875, 72.31636810302734);
					if (LeverPullPos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1000 then
						(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875);
					else
						TweenPlayer(LeverPullPos);
					end;
				elseif _G.Settings.Race["Selected Place"] == "Acient One" then
					TweenPlayer(CFrame.new(28981.552734375, 14888.4267578125, -120.245849609375));
				end;
			end);
		end;
	end;
end);
AutoBuyGearToggle = RaceTab:AddToggle({
	Title = "Auto Buy Gear",
	Value = _G.Settings.Race["Auto Buy Gear"],
	Callback = function(state)
		_G.Settings.Race["Auto Buy Gear"] = state;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if _G.Settings.Race["Auto Buy Gear"] then
				local args = {
					[1] = true
				};
				local args = {
					[1] = "UpgradeRace",
					[2] = "Buy"
				};
				(((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer(unpack(args));
			end;
		end;
	end);
end);
TweenToMirageIslandToggle = RaceTab:AddToggle({
	Title = "Tween To Mirage Island",
	Desc = "Tween to highest point",
	Value = _G.Settings.Race["Tween To Highest Mirage"],
	Callback = function(state)
		_G.Settings.Race["Tween To Highest Mirage"] = state;
		(getgenv()).SaveSetting();
	end
});
LookMoonAbilityToggle = RaceTab:AddToggle({
	Title = "Look Moon & use Ability",
	Value = _G.Settings.Race["Look Moon Ability"],
	Callback = function(state)
		_G.Settings.Race["Look Moon Ability"] = state;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if _G.Settings.Race["Look Moon Ability"] then
				task.wait(0.1);
				local moonDir = game.Lighting:GetMoonDirection();
				local lookAtPos = game.Workspace.CurrentCamera.CFrame.p + moonDir * 100;
				game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.p, lookAtPos);
			end;
		end);
	end;
end);
AutoTrainToggle = RaceTab:AddToggle({
	Title = "Auto Train",
	Value = _G.Settings.Race["Auto Train"],
	Callback = function(state)
		_G.Settings.Race["Auto Train"] = state;
		StopTween(_G.Settings.Race["Auto Train"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if _G.Settings.Race["Auto Train"] then
				if game.Players.LocalPlayer.Character.RaceTransformed.Value == true then
					StartFarmTrain = false;
					TweenPlayer(CFrame.new(216.211181640625, 126.9352035522461, -12599.0732421875));
				end;
			end;
		end;
	end);
end);
task.spawn(function()
	while task.wait(0.2) do
		if StartFarmTrain and World3 then
			pcall(function()
				if (game:GetService("Workspace")).Enemies:FindFirstChild("Cocoa Warrior") or (game:GetService("Workspace")).Enemies:FindFirstChild("Chocolate Bar Battler") or (game:GetService("Workspace")).Enemies:FindFirstChild("Sweet Thief") or (game:GetService("Workspace")).Enemies:FindFirstChild("Candy Rebel") then
					for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
						if v.Name == "Cocoa Warrior" or v.Name == "Chocolate Bar Battler" or v.Name == "Sweet Thief" or v.Name == "Candy Rebel" then
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								repeat
									task.wait(0.15);
									AutoHaki();
									EquipWeapon(_G.Settings.Main["Selected Weapon"]);
									v.Humanoid.WalkSpeed = 0;
									PosMon = v.HumanoidRootPart.CFrame;
									MonFarm = v.Name;
									TweenPlayer(v.HumanoidRootPart.CFrame * Pos);
									Attack();
								until not StartFarmTrain or (not v.Parent) or v.Humanoid.Health <= 0;
							end;
						end;
					end;
				else
					TweenPlayer(CFrame.new(216.211181640625, 126.9352035522461, -12599.0732421875));
				end;
			end);
		end;
	end;
end);
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if _G.Settings.Race["Auto Train"] then
				if game.Players.LocalPlayer.Character.RaceTransformed.Value == false then
					StartFarmTrain = true;
				end;
			end;
		end;
	end);
end);
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if _G.Settings.Race["Auto Train"] then
				if tonumber(((game:GetService("Players")).LocalPlayer.Character:WaitForChild("RaceEnergy")).Value) == 1 then
					if (game:GetService("Players")).LocalPlayer.Character.RaceTransformed.Value == false then
						(game:GetService("VirtualInputManager")):SendKeyEvent(true, "Y", false, game);
						task.wait(0.1);
						(game:GetService("VirtualInputManager")):SendKeyEvent(false, "Y", false, game);
					end;
				end;
			end;
		end);
	end;
end);
TeleportToRaceDoorButton = RaceTab:AddButton({
	Title = "Teleport To Race Door",
	Callback = function()
		(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875);
		task.wait(0.1);
		(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875);
		task.wait(0.1);
		(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875);
		task.wait(0.1);
		(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875);
		task.wait(0.5);
		if (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Human" then
			TweenPlayer(CFrame.new(29221.822265625, 14890.9755859375, -205.99114990234375));
		elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Skypiea" then
			TweenPlayer(CFrame.new(28960.158203125, 14919.6240234375, 235.03948974609375));
		elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Fishman" then
			TweenPlayer(CFrame.new(28231.17578125, 14890.9755859375, -211.64173889160156));
		elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Cyborg" then
			TweenPlayer(CFrame.new(28502.681640625, 14895.9755859375, -423.7279357910156));
		elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Ghoul" then
			TweenPlayer(CFrame.new(28674.244140625, 14890.6767578125, 445.4310607910156));
		elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Mink" then
			TweenPlayer(CFrame.new(29012.341796875, 14890.9755859375, -380.1492614746094));
		end;
	end
});
BuyAcientQuestButton = RaceTab:AddButton({
	Title = "Buy Acient Quest",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("UpgradeRace", "Buy");
	end
});
LocalPlayerTab:AddSection(" PvP Tools");

local _DUNGEON_PLACE_ID = 73902483975735;
local _IS_DUNGEON = game.PlaceId == _DUNGEON_PLACE_ID;

getgenv().DungeonConfig = getgenv().DungeonConfig or {
	AutoFuse        = false,
	AutoSpin        = false,
	AutoEnter       = false,
	AutoComplete    = false,
	AutoSkipHub     = false,
	SelectBuffs     = false,
	SelectedBuffs   = {},
	AutoFully       = false,
};

if not _IS_DUNGEON then
	MultiFarmTab:AddSection("Dungeon World");
	MultiFarmTab:AddParagraph({
		Title = "⚠ You are not in Dungeon World",
		Desc = "Please go to Dungeon World to use these features.\nDungeon Place ID: " .. tostring(_DUNGEON_PLACE_ID)
	});
else

	local _KNOWN_BUFFS = {
		"ATK UP","DEF UP","SPD UP","HP UP","CDR",
		"CRIT UP","DOUBLE HIT","LIFESTEAL","SHIELD",
		"REFLECT","REGEN","DASH UP","RANGE UP",
	};

	local function _InDungeonLobby()
		return workspace:FindFirstChild("DungeonLobby") ~= nil
			or workspace:FindFirstChild("Lobby") ~= nil;
	end;

	local function _InDungeonMatch()
		return workspace:FindFirstChild("DungeonFloor") ~= nil
			or workspace:FindFirstChild("FloorEnemies") ~= nil
			or workspace:FindFirstChild("DungeonArea") ~= nil;
	end;

	local function _FindRingNPC()
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("Model") then
				local name = v.Name:lower();
				if name:find("ring") and (name:find("npc") or name:find("dealer") or name:find("fus") or name:find("merge") or name:find("spin")) then
					return v;
				end;
			end;
		end;
		for _, v in pairs(workspace:FindFirstChild("NPCs") and workspace.NPCs:GetChildren() or {}) do
			if v.Name:lower():find("ring") then return v; end;
		end;
		return nil;
	end;

	local function _FindDungeonPortal()
		for _, v in pairs(workspace:GetDescendants()) do
			local name = v.Name:lower();
			if (name:find("portal") or name:find("dungeon") or name:find("enter") or name:find("gate")) and v:IsA("BasePart") then
				return v;
			end;
		end;
		return nil;
	end;

	local function _GetFloorEnemies()
		local enemies = {};
		local folder = workspace:FindFirstChild("FloorEnemies") or workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("DungeonEnemies");
		if folder then
			for _, v in pairs(folder:GetChildren()) do
				if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
					table.insert(enemies, v);
				end;
			end;
		end;
		return enemies;
	end;

	local function _GetKitsuneShrines()
		local shrines = {};
		for _, v in pairs(workspace:GetDescendants()) do
			local name = v.Name:lower();
			if name:find("shrine") or name:find("kitsune") or name:find("trap") then
				if v:IsA("BasePart") or v:IsA("Model") then
					table.insert(shrines, v);
				end;
			end;
		end;
		return shrines;
	end;

	local function _GetGasLeaks()
		local leaks = {};
		for _, v in pairs(workspace:GetDescendants()) do
			local name = v.Name:lower();
			if name:find("gas") or name:find("leak") or name:find("vent") or name:find("pipe") then
				if v:IsA("BasePart") or v:IsA("Model") then
					table.insert(leaks, v);
				end;
			end;
		end;
		return leaks;
	end;

	local function _AttackTarget(target)
		pcall(function()
			if not target then return; end;
			local hrp = target:IsA("Model") and (target:FindFirstChild("HumanoidRootPart") or target.PrimaryPart) or target;
			if not hrp then return; end;
			local char = game.Players.LocalPlayer.Character;
			if not char then return; end;
			EquipWeapon(_G.Settings.Main["Selected Weapon"] or _G.SelectWeapon);
			TweenPlayer(hrp.CFrame * CFrame.new(0, 20, 0));
			task.wait(0.1);
			getgenv().UseConfiguredSkills(hrp.Position);
		end);
	end;

	local function _SpamSkillsAt(pos)
		pcall(function()
			local char = game.Players.LocalPlayer.Character;
			if not char then return; end;
			TweenPlayer(CFrame.new(pos.X, pos.Y + 15, pos.Z));
			task.wait(0.15);
			local vim = game:GetService("VirtualInputManager");
			for _, key in pairs({"Z","X","C","V","F"}) do
				pcall(function()
					vim:SendKeyEvent(true, key, false, game);
					task.wait(0.06);
					vim:SendKeyEvent(false, key, false, game);
					task.wait(0.04);
				end);
			end;
		end);
	end;

	local function _SelectBuff(buffName)
		pcall(function()
			local plrGui = game.Players.LocalPlayer.PlayerGui;
			for _, gui in pairs(plrGui:GetDescendants()) do
				if (gui:IsA("TextButton") or gui:IsA("ImageButton")) then
					if gui.Text and gui.Text:lower():find(buffName:lower()) then
						gui:Activate();
						return;
					end;
				end;
			end;
		end);
	end;

	local function _PressSkipHub()
		pcall(function()
			local plrGui = game.Players.LocalPlayer.PlayerGui;
			for _, gui in pairs(plrGui:GetDescendants()) do
				if (gui:IsA("TextButton") or gui:IsA("ImageButton")) then
					local t = (gui.Text or ""):lower();
					if t:find("skip") or t:find("lobby") or t:find("return") or t:find("continue") or t:find("next") then
						gui:Activate();
						return;
					end;
				end;
			end;
		end);
	end;

	MultiFarmTab:AddSection("Rings");
	MultiFarmTab:AddToggle({
		Title = "Dungeon Auto Fuse Rings [BETA]",
		Desc = "Vai até o NPC de anéis no lobby e funde os anéis automaticamente.",
		Value = getgenv().DungeonConfig.AutoFuse,
		Callback = function(state)
			getgenv().DungeonConfig.AutoFuse = state;
		end
	});
	task.spawn(function()
		while true do
			task.wait(1);
			if not getgenv().DungeonConfig.AutoFuse then continue; end;
			pcall(function()
				local npc = _FindRingNPC();
				if not npc then return; end;
				local hrp_npc = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart;
				if not hrp_npc then return; end;
				TweenPlayer(hrp_npc.CFrame * CFrame.new(0, 0, 5));
				task.wait(0.8);
				local rep = game:GetService("ReplicatedStorage");
				local remote = rep:FindFirstChild("CommF_", true) or rep.Remotes and rep.Remotes:FindFirstChild("CommF_");
				if remote then
					pcall(function() remote:InvokeServer("FuseRing"); end);
					pcall(function() remote:InvokeServer("MergeRing"); end);
					pcall(function() remote:InvokeServer("CombineRing"); end);
				end;
				for _, pp in pairs(npc:GetDescendants()) do
					if pp:IsA("ProximityPrompt") then
						pcall(function() fireproximityprompt(pp); end);
					end;
				end;
			end);
		end;
	end);

	MultiFarmTab:AddToggle({
		Title = "Dungeon Auto Spin Rings [BETA]",
		Desc = "Gira anéis automaticamente no NPC do lobby.",
		Value = getgenv().DungeonConfig.AutoSpin,
		Callback = function(state)
			getgenv().DungeonConfig.AutoSpin = state;
		end
	});
	task.spawn(function()
		while true do
			task.wait(1);
			if not getgenv().DungeonConfig.AutoSpin then continue; end;
			pcall(function()
				local npc = _FindRingNPC();
				if not npc then return; end;
				local hrp_npc = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart;
				if not hrp_npc then return; end;
				TweenPlayer(hrp_npc.CFrame * CFrame.new(0, 0, 5));
				task.wait(0.8);
				local rep = game:GetService("ReplicatedStorage");
				local remote = rep:FindFirstChild("CommF_", true) or rep.Remotes and rep.Remotes:FindFirstChild("CommF_");
				if remote then
					pcall(function() remote:InvokeServer("SpinRing"); end);
					pcall(function() remote:InvokeServer("RollRing"); end);
					pcall(function() remote:InvokeServer("RerollRing"); end);
				end;
				for _, pp in pairs(npc:GetDescendants()) do
					if pp:IsA("ProximityPrompt") then
						local name = pp.ActionText and pp.ActionText:lower() or "";
						if name:find("spin") or name:find("roll") or name:find("reroll") then
							pcall(function() fireproximityprompt(pp); end);
						end;
					end;
				end;
			end);
		end;
	end);

	MultiFarmTab:AddSection("Dungeon");
	MultiFarmTab:AddToggle({
		Title = "Auto Enter Dungeon",
		Desc = "Teleporta para o chao amarelo na entrada da Dungeon e fica tentando iniciar a partida.",
		Value = getgenv().DungeonConfig.AutoEnter,
		Callback = function(state)
			getgenv().DungeonConfig.AutoEnter = state;
		end
	});
	local _DUNGEON_ENTRY_FLOOR_CF = CFrame.new(-2.5, 0.5, -35.5);
	task.spawn(function()
		while true do
			task.wait(0.5);
			if not getgenv().DungeonConfig.AutoEnter then continue; end;
			pcall(function()
				if _InDungeonMatch() then return; end;
				local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
				if not hrp then return; end;
				local yellowFloor = nil;
				for _, v in pairs(workspace:GetDescendants()) do
					if v:IsA("BasePart") then
						local col = v.Color;
						if col.R > 0.7 and col.G > 0.6 and col.B < 0.3 then
							local name = v.Name:lower();
							if name:find("floor") or name:find("enter") or name:find("lobby") or name:find("start") or name:find("ground") then
								yellowFloor = v;
								break;
							end;
						end;
					end;
				end;
				if yellowFloor then
					local targetCF = CFrame.new(yellowFloor.Position.X, yellowFloor.Position.Y + 3, yellowFloor.Position.Z);
					hrp.CFrame = targetCF;
				else
					local portal = _FindDungeonPortal();
					if portal then
						hrp.CFrame = portal.CFrame * CFrame.new(0, 3, 5);
					end;
				end;
				task.wait(0.2);
				for _, pp in pairs(workspace:GetDescendants()) do
					if pp:IsA("ProximityPrompt") then
						local n = (pp.ActionText or pp.Name):lower();
						if n:find("enter") or n:find("start") or n:find("join") or n:find("dungeon") or n:find("portal") then
							pcall(function() fireproximityprompt(pp); end);
						end;
					end;
				end;
				local rep = game:GetService("ReplicatedStorage");
				local remote = rep:FindFirstChild("CommF_", true) or (rep.Remotes and rep.Remotes:FindFirstChild("CommF_"));
				if remote then
					pcall(function() remote:InvokeServer("EnterDungeon"); end);
					pcall(function() remote:InvokeServer("JoinDungeon"); end);
					pcall(function() remote:InvokeServer("StartDungeon"); end);
				end;
			end);
		end;
	end);

	MultiFarmTab:AddToggle({
		Title = "Auto Complete Dungeon",
		Desc = "Ataca todos os NPCs proximos de cada Floor, destroi Shrines do Kitsune (Floor 10), destroi vazamentos de gas (Floor 15) e avanca automaticamente.",
		Value = getgenv().DungeonConfig.AutoComplete,
		Callback = function(state)
			getgenv().DungeonConfig.AutoComplete = state;
		end
	});
	task.spawn(function()
		while true do
			task.wait(0.15);
			if not getgenv().DungeonConfig.AutoComplete then continue; end;
			pcall(function()
				if not _InDungeonMatch() then return; end;
				local floorNum = 0;
				for _, v in pairs(workspace:GetDescendants()) do
					local name = v.Name:lower();
					if name:find("floor") then
						local n = tonumber(name:match("%d+"));
						if n and n > floorNum then floorNum = n; end;
					end;
				end;

				if floorNum == 10 then
					local shrines = _GetKitsuneShrines();
					if #shrines > 0 then
						for _, shrine in pairs(shrines) do
							if not getgenv().DungeonConfig.AutoComplete then break; end;
							local pos = shrine:IsA("Model") and shrine:GetPivot().Position or shrine.Position;
							local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
							if hrp then hrp.CFrame = CFrame.new(pos.X, pos.Y + 8, pos.Z); end;
							task.wait(0.05);
							_SpamSkillsAt(pos);
							task.wait(0.1);
						end;
						return;
					end;
				end;

				if floorNum == 15 then
					local leaks = _GetGasLeaks();
					if #leaks > 0 then
						for _, leak in pairs(leaks) do
							if not getgenv().DungeonConfig.AutoComplete then break; end;
							local pos = leak:IsA("Model") and leak:GetPivot().Position or leak.Position;
							local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
							if hrp then hrp.CFrame = CFrame.new(pos.X, pos.Y + 8, pos.Z); end;
							task.wait(0.05);
							_SpamSkillsAt(pos);
							task.wait(0.1);
						end;
						return;
					end;
				end;

				local enemies = _GetFloorEnemies();
				if #enemies > 0 then
					local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
					local nearest, nearestDist = enemies[1], math.huge;
					if hrp then
						for _, enemy in pairs(enemies) do
							if enemy:FindFirstChild("HumanoidRootPart") then
								local d = (enemy.HumanoidRootPart.Position - hrp.Position).Magnitude;
								if d < nearestDist then
									nearestDist = d;
									nearest = enemy;
								end;
							end;
						end;
					end;
					if nearest and nearest:FindFirstChild("Humanoid") and nearest.Humanoid.Health > 0 then
						pcall(function() nearest.Humanoid.WalkSpeed = 0; end);
						_AttackTarget(nearest);
					end;
				else
					local rep = game:GetService("ReplicatedStorage");
					local remote = rep:FindFirstChild("CommF_", true) or (rep.Remotes and rep.Remotes:FindFirstChild("CommF_"));
					if remote then
						pcall(function() remote:InvokeServer("NextFloor"); end);
						pcall(function() remote:InvokeServer("AdvanceFloor"); end);
						pcall(function() remote:InvokeServer("CompleteFloor"); end);
					end;
					for _, v in pairs(workspace:GetDescendants()) do
						if v:IsA("ProximityPrompt") then
							local n = (v.ActionText or v.Name):lower();
							if n:find("next") or n:find("advance") or n:find("continue") or n:find("pass") or n:find("floor") then
								pcall(function() fireproximityprompt(v); end);
							end;
						end;
					end;
				end;
			end);
		end;
	end);

	MultiFarmTab:AddSection("Buffs");
	MultiFarmTab:AddToggle({
		Title = "Dungeon Select Buffs [BETA]",
		Desc = "Ativa a seleção automática de buffs quando aparecer a tela de cartas na dungeon.",
		Value = getgenv().DungeonConfig.SelectBuffs,
		Callback = function(state)
			getgenv().DungeonConfig.SelectBuffs = state;
		end
	});
	MultiFarmTab:AddDropdown({
		Title = "Dungeon Buffs to Select [BETA]",
		Desc = "Escolha quais buffs devem ser selecionados automaticamente (multi-seleção)",
		Values = _KNOWN_BUFFS,
		Value = getgenv().DungeonConfig.SelectedBuffs[1] or _KNOWN_BUFFS[1],
		Callback = function(option)
			local found = false;
			for i, v in pairs(getgenv().DungeonConfig.SelectedBuffs) do
				if v == option then found = true; table.remove(getgenv().DungeonConfig.SelectedBuffs, i); break; end;
			end;
			if not found then table.insert(getgenv().DungeonConfig.SelectedBuffs, option); end;
		end
	});
	task.spawn(function()
		while true do
			task.wait(0.5);
			if not getgenv().DungeonConfig.SelectBuffs then continue; end;
			if #getgenv().DungeonConfig.SelectedBuffs == 0 then continue; end;
			pcall(function()
				local plrGui = game.Players.LocalPlayer.PlayerGui;
				for _, gui in pairs(plrGui:GetDescendants()) do
					if (gui:IsA("TextButton") or gui:IsA("ImageButton")) and gui.Visible then
						local t = (gui.Text or ""):lower();
						for _, buffName in pairs(getgenv().DungeonConfig.SelectedBuffs) do
							if t:find(buffName:lower()) then
								gui:Activate();
								task.wait(0.3);
								break;
							end;
						end;
					end;
				end;
			end);
		end;
	end);

	MultiFarmTab:AddSection("Post-Dungeon");
	MultiFarmTab:AddToggle({
		Title = "Dungeon Auto Skip Hub [BETA]",
		Desc = "Quando a dungeon terminar, aperta automaticamente para voltar ao lobby.",
		Value = getgenv().DungeonConfig.AutoSkipHub,
		Callback = function(state)
			getgenv().DungeonConfig.AutoSkipHub = state;
		end
	});
	task.spawn(function()
		while true do
			task.wait(1);
			if not getgenv().DungeonConfig.AutoSkipHub then continue; end;
			pcall(function()
				_PressSkipHub();
			end);
		end;
	end);

end;

local PvPTargetList = {};
local SelectedPvPTarget = nil;

local function RefreshPvPTargets()
	PvPTargetList = {};
	for _, p in pairs(game:GetService("Players"):GetPlayers()) do
		if p ~= game.Players.LocalPlayer then
			table.insert(PvPTargetList, p.Name);
		end;
	end;
	return PvPTargetList;
end;
RefreshPvPTargets();

local PvPPlayerDropdown = LocalPlayerTab:AddDropdown({
	Title = "Select Player",
	Desc = "Seleciona o jogador alvo para PvP",
	Values = PvPTargetList,
	Value = PvPTargetList[1] or "No Players",
	Callback = function(v)
		SelectedPvPTarget = v;
	end
});

LocalPlayerTab:AddButton({
	Title = " Refresh Player List",
	Desc = "Atualiza a lista de jogadores no servidor",
	Callback = function()
		RefreshPvPTargets();
		pcall(function()
			PvPPlayerDropdown:SetValues(PvPTargetList);
		end);
		pcall(function()
			PvPPlayerDropdown:Refresh(PvPTargetList);
		end);
		pcall(function()
			PvPPlayerDropdown:Set(PvPTargetList[1] or "");
		end);
	end
});

LocalPlayerTab:AddButton({
	Title = " TP to Selected Player",
	Desc = "Teleporta para a posicao do jogador selecionado",
	Callback = function()
		pcall(function()
			if SelectedPvPTarget then
				local target = game:GetService("Players"):FindFirstChild(SelectedPvPTarget);
				if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
					TweenPlayer(target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 5));
				end;
			end;
		end);
	end
});

local _PvPAutoTP = false;
LocalPlayerTab:AddToggle({
	Title = "Auto Follow / TP to Player",
	Desc = "Segue e fica em cima do jogador selecionado constantemente",
	Value = false,
	Callback = function(v)
		_PvPAutoTP = v;
	end
});
task.spawn(function()
	while task.wait(0.1) do
		if _PvPAutoTP and SelectedPvPTarget then
			pcall(function()
				local target = game:GetService("Players"):FindFirstChild(SelectedPvPTarget);
				if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
					TweenPlayer(target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 3));
				end;
			end);
		end;
	end;
end);

LocalPlayerTab:AddToggle({
	Title = "Auto Activate PvP",
	Desc = "Mantem PvP ativado automaticamente",
	Value = false,
	Callback = function(v)
		if v then
			task.spawn(function()
				while v do
					pcall(function()
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ActivatePvp", true);
					end);
					task.wait(5);
				end;
			end);
		end;
	end
});

local _PvPAutoKill = false;
LocalPlayerTab:AddToggle({
	Title = "Auto Kill Selected Player",
	Desc = "Mata automaticamente o jogador selecionado",
	Value = false,
	Callback = function(v)
		_PvPAutoKill = v;
	end
});
task.spawn(function()
	while task.wait(0.1) do
		if _PvPAutoKill and SelectedPvPTarget then
			pcall(function()
				local target = game:GetService("Players"):FindFirstChild(SelectedPvPTarget);
				if target and target.Character and target.Character:FindFirstChild("Humanoid")
				   and target.Character.Humanoid.Health > 0 then
					Attack();
					EquipWeapon(_G.Settings.Main["Selected Weapon"]);
					AutoHaki();
					TweenPlayer(target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 2));
				end;
			end);
		end;
	end;
end);

local _PvPSpamSkills = false;
LocalPlayerTab:AddToggle({
	Title = " Auto Spam Skills (All)",
	Desc = "Spama todas as skills de todas as categorias automaticamente em PvP",
	Value = false,
	Callback = function(v)
		_PvPSpamSkills = v;
	end
});
task.spawn(function()
	local VIM = game:GetService("VirtualInputManager");
	local VU  = game:GetService("VirtualUser");
	local skillKeys = {"Z","X","C","V","F"};
	local categories = {"Melee","Sword","Blox Fruit","Gun"};
	while true do
		task.wait(0.05);
		if _PvPSpamSkills then
			pcall(function()
				local char = game.Players.LocalPlayer.Character;
				if not char then return; end;
				if SelectedPvPTarget then
					local target = game:GetService("Players"):FindFirstChild(SelectedPvPTarget);
					if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
						workspace.CurrentCamera.CFrame = CFrame.lookAt(
							workspace.CurrentCamera.CFrame.Position,
							target.Character.HumanoidRootPart.Position
						);
					end;
				end;
				for _, toolType in ipairs(categories) do
					local tool = nil;
					for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA("Tool") and v.ToolTip == toolType then tool = v; break; end;
					end;
					if tool then
						char.Humanoid:EquipTool(tool);
						task.wait(0.05);
						for _, sk in ipairs(skillKeys) do
							VIM:SendKeyEvent(true, sk, false, game);
							task.wait(0.02);
							VIM:SendKeyEvent(false, sk, false, game);
						end;
						VU:CaptureController();
						VU:ClickButton1(Vector2.new(851, 158));
						task.wait(0.05);
					end;
				end;
				Attack();
			end);
		end;
	end;
end);

LocalPlayerTab:AddSection("Aimbot");

_G.AimLockSkill   = false;
_G.AimLockNPC     = false;
_G.AimLockPlayer  = false;
_G.SilentAimSkill = false;
_G.SilentAimNPC   = false;
_G.SilentAimPlayer = false;

local function _getNearestNPC()
	local hrp = game.Players.LocalPlayer.Character and
			game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
	if not hrp then return nil; end;
	local closest, dist = nil, math.huge;
	for _, v in pairs(workspace.Enemies:GetChildren()) do
		if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid")
				and v.Humanoid.Health > 0 then
			local d = (v.HumanoidRootPart.Position - hrp.Position).Magnitude;
			if d < dist then dist = d; closest = v; end;
		end;
	end;
	return closest;
end;

local function _lookAt(targetPos)
	pcall(function()
		workspace.CurrentCamera.CFrame = CFrame.lookAt(
			workspace.CurrentCamera.CFrame.Position, targetPos
		);
	end);
end;

LocalPlayerTab:AddToggle({
	Title = "AimLock Skill",
	Desc = "Mantem a camera travada no alvo selecionado ao usar skills. Nao move o jogador.",
	Value = false,
	Callback = function(v)
		_G.AimLockSkill = v;
	end
});

LocalPlayerTab:AddToggle({
	Title = "AimLock NPC",
	Desc = "Trava camera no NPC mais proximo automaticamente",
	Value = false,
	Callback = function(v)
		_G.AimLockNPC = v;
	end
});

LocalPlayerTab:AddToggle({
	Title = "AimLock Player",
	Desc = "Trava camera no player selecionado automaticamente",
	Value = false,
	Callback = function(v)
		_G.AimLockPlayer = v;
	end
});

task.spawn(function()
	while task.wait(0.03) do
		pcall(function()
			if _G.AimLockSkill and SelectedPvPTarget then
				local t = game:GetService("Players"):FindFirstChild(SelectedPvPTarget);
				if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
					_lookAt(t.Character.HumanoidRootPart.Position);
				end;
			end;
			if _G.AimLockNPC then
				local npc = _getNearestNPC();
				if npc then _lookAt(npc.HumanoidRootPart.Position); end;
			end;
			if _G.AimLockPlayer and SelectedPvPTarget then
				local t = game:GetService("Players"):FindFirstChild(SelectedPvPTarget);
				if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
					_lookAt(t.Character.HumanoidRootPart.Position);
				end;
			end;
		end);
	end;
end);

LocalPlayerTab:AddToggle({
	Title = "Silent Aim Skill",
	Desc = "Redireciona os projecteis/hits da skill para o alvo sem precisar olhar pra ele",
	Value = false,
	Callback = function(v)
		_G.SilentAimSkill = v;
	end
});

LocalPlayerTab:AddToggle({
	Title = "Silent Aim NPC",
	Desc = "Redireciona hits para o NPC mais proximo sem olhar para ele",
	Value = false,
	Callback = function(v)
		_G.SilentAimNPC = v;
	end
});

LocalPlayerTab:AddToggle({
	Title = "Silent Aim Player",
	Desc = "Redireciona hits para o player selecionado sem olhar para ele",
	Value = false,
	Callback = function(v)
		_G.SilentAimPlayer = v;
	end
});

task.spawn(function()
	while task.wait(0.03) do
		pcall(function()
			local target = nil;
			if _G.SilentAimSkill and SelectedPvPTarget then
				local tp = game:GetService("Players"):FindFirstChild(SelectedPvPTarget);
				if tp and tp.Character and tp.Character:FindFirstChild("HumanoidRootPart") then
					target = tp.Character.HumanoidRootPart;
				end;
			end;
			if _G.SilentAimNPC then
				local npc = _getNearestNPC();
				if npc then target = npc.HumanoidRootPart; end;
			end;
			if _G.SilentAimPlayer and SelectedPvPTarget then
				local tp = game:GetService("Players"):FindFirstChild(SelectedPvPTarget);
				if tp and tp.Character and tp.Character:FindFirstChild("HumanoidRootPart") then
					target = tp.Character.HumanoidRootPart;
				end;
			end;
			if target then
				for _, part in pairs(workspace:GetDescendants()) do
					if part:IsA("BasePart") and part.Name:lower():find("hitbox") then
						local creator = part:FindFirstChild("creator") or part:FindFirstChild("Creator");
						if creator and creator.Value == game.Players.LocalPlayer then
							part.CFrame = target.CFrame;
						end;
					end;
				end;
				workspace.CurrentCamera.CFrame = CFrame.lookAt(
					workspace.CurrentCamera.CFrame.Position,
					target.Position
				);
			end;
		end);
	end;
end);

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			local char = game.Players.LocalPlayer.Character;
			if not char then return; end;
			local hum = char:FindFirstChildOfClass("Humanoid");
			if hum and not _G.EclipseLevel and not _G.EclipseFarm_Bone
					and not _G.EclipseFarm_Cake and not _G.EclipseAutoTyrant then
				if hum.WalkSpeed < 16 then hum.WalkSpeed = 16; end;
			end;
		end);
	end;
end);

AutoTrialToggle = RaceTab:AddToggle({
	Title = "Auto Trial",
	Value = _G.Settings.Race["Auto Trial"],
	Callback = function(value)
		_G.Settings.Race["Auto Trial"] = value;
		StopTween(_G.Settings.Race["Auto Trial"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if _G.Settings.Race["Auto Trial"] then
				if (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Human" then
					for i, v in pairs(game.Workspace.Enemies:GetDescendants()) do
						if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
							pcall(function()
								repeat
									task.wait(0.1);
									v.Humanoid.Health = 0;
								until not _G.Settings.Race["Auto Trial"] or (not v.Parent) or v.Humanoid.Health <= 0;
							end);
						end;
					end;
				elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Skypiea" then
					for i, v in pairs((game:GetService("Workspace")).Map.SkyTrial.Model:GetDescendants()) do
						if v.Name == "snowisland_Cylinder.081" then
							TweenPlayer(v.CFrame * CFrame.new(0, 0, 0));
						end;
					end;
				elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Fishman" then
					for i, v in pairs((game:GetService("Workspace")).SeaBeasts.SeaBeast1:GetDescendants()) do
						if v.Name == "HumanoidRootPart" then
							repeat
								task.wait(0.1);
								TweenPlayer(v.CFrame * CFrame.new(0, 200, 0));
								useAllSkill();
							until not _G.Settings.Race["Auto Trial"] or (not v.Parent) or v.Humanoid.Health <= 0 or (not v:FindFirstChild("HumanoidRootPart"));
						end;
					end;
				elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Cyborg" then
					TweenPlayer(CFrame.new(28654, 14898.7832, -30, 1, 0, 0, 0, 1, 0, 0, 0, 1));
				elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Ghoul" then
					for i, v in pairs(game.Workspace.Enemies:GetDescendants()) do
						if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
							pcall(function()
								repeat
									task.wait(0.1);
									v.Humanoid.Health = 0;
								until not _G.Settings.Race["Auto Trial"] or (not v.Parent) or v.Humanoid.Health <= 0;
							end);
						end;
					end;
				elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Mink" then
					for i, v in pairs((game:GetService("Workspace")):GetDescendants()) do
						if v.Name == "StartPoint" then
							TweenPlayer(v.CFrame * CFrame.new(0, 10, 0));
						end;
					end;
				end;
			end;
		end;
	end);
end);
AutoKillPlayerAfterTrialToggle = RaceTab:AddToggle({
	Title = "Auto Kill Player After Trial",
	Value = _G.Settings.Race["Auto Kill Player After Trial"],
	Callback = function(value)
		_G.Settings.Race["Auto Kill Player After Trial"] = value;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.Race["Auto Kill Player After Trial"] then
			if (game:GetService("Players")).LocalPlayer.PlayerGui.Main.TopHUDList.Timer.Visible == true then
				for i, v in pairs((game:GetService("Players")):GetPlayers()) do
					if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
						if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
							if v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
								repeat
									task.wait(0.15);
									EquipWeapon(_G.Settings.Main["Selected Weapon"]);
									AutoHaki();
									TweenPlayer(v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 40));
									Attack();
								until not _G.Settings.Race["Auto Kill Player After Trial"] or (not v.Character) or v.Character.Humanoid.Health <= 0;
							end;
						end;
					end;
				end;
			end;
		end;
	end;
end);
TeleportSection = TeleportTab:AddSection("Teleport");
TeleportToFirstSeaButton = TeleportTab:AddButton({
	Title = "Teleport To First Sea",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("TravelMain");
	end
});
TeleportToSecondSeaButton = TeleportTab:AddButton({
	Title = "Teleport To Second Sea",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("TravelDressrosa");
	end
});
TeleportToThirdSeaButton = TeleportTab:AddButton({
	Title = "Teleport To Third Sea",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("TravelZou");
	end
});
TeleportIslandSection = TeleportTab:AddSection("Island");
ShopSection = ShopTab:AddSection("Shop");
AutoBuyLegendarySwordToggle = ShopTab:AddToggle({
	Title = "Auto Buy Legendary Sword",
	Value = _G.Settings.Shop["Auto Buy Legendary Sword"],
	Callback = function(state)
		_G.Settings.Shop["Auto Buy Legendary Sword"] = state;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.Shop["Auto Buy Legendary Sword"] then
			pcall(function()
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1");
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2");
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3");
			end);
		end;
	end;
end);
AutoBuyHakiColorToggle = ShopTab:AddToggle({
	Title = "Auto Buy Haki Color",
	Value = _G.Settings.Shop["Auto Buy Haki Color"],
	Callback = function(state)
		_G.Settings.Shop["Auto Buy Haki Color"] = state;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.Shop["Auto Buy Haki Color"] then
			(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ColorsDealer", "2");
		end;
	end;
end);
AbilitiesShopSection = ShopTab:AddSection("Abilities");
BuyGeppoButton = ShopTab:AddButton({
	Title = "Buy Geppo",
	Desc = "$10,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyHaki", "Geppo");
	end
});
BuyBusoHaki = ShopTab:AddButton({
	Title = "Buy Buso Haki",
	Desc = "$25,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyHaki", "Buso");
	end
});
BuySoruButton = ShopTab:AddButton({
	Title = "Buy Soru",
	Desc = "$25,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyHaki", "Soru");
	end
});
BuyObservationHakiButton = ShopTab:AddButton({
	Title = "Buy Observation Haki",
	Desc = "$750,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("KenTalk", "Buy");
	end
});
ShopTab:AddSection(" Buy Fight Styles - Tween to NPC");

local FightStyleNPCs = {
	["Black Leg"]      = {npc="Black Leg Teacher",   pos=CFrame.new(-988, 13, 3996),           buy="BuyBlackLeg"},
	["Electro"]        = {npc="Mad Scientist",        pos=CFrame.new(61050, 19, 1537),          buy="BuyElectro",   portal=Vector3.new(61163.8,11.7,1819.8)},
	["Fishman Karate"] = {npc="Fishman Karate Teacher",pos=CFrame.new(61584.35, 18.85, 988.89), buy="BuyFishmanKarate"},
	["Superhuman"]     = {npc="Martial Arts Master",  pos=CFrame.new(1378.05, 247.43, -5189.37),buy="BuySuperhuman"},
	["Death Step"]     = {npc="Phoeyu, the Reformed", pos=CFrame.new(6360.04, 296.67, -6763.93),buy="BuyDeathStep"},
	["Sharkman Karate"]= {npc="Sharkman Karate Teacher",pos=CFrame.new(-2602.40, 239.22, -10314.75),buy="BuySharkmanKarate"},
	["Electric Claw"]  = {npc="Previous Hero",        pos=CFrame.new(-10369.83,331.69,-10126.49),buy="BuyElectricClaw"},
	["Dragon Talon"]   = {npc="UzothDragon",          pos=CFrame.new(5662.03,1211.32,858.60),   buy="BuyDragonTalon"},
	["God Human"]      = {npc="Ancient Monk",          pos=CFrame.new(-13775.56,334.66,-9877.67),buy="BuyGodhuman"},
	["Sanguine Art"]   = {npc="Shafi",                pos=CFrame.new(-16514.86,23.18,-190.84),  buy="BuySanguineArt"},
	["Water Kung Fu"]  = {npc="Water Kung Fu Teacher", pos=CFrame.new(-4960.04, 35.08, -4662.67),buy="BuyFishmanKarate", submerged=true},
};

local FightStyleOrder = {
	"Black Leg","Electro","Fishman Karate","Superhuman","Death Step",
	"Sharkman Karate","Electric Claw","Dragon Talon","God Human","Sanguine Art","Water Kung Fu"
};

local SelectedFightStyle = FightStyleOrder[1];
ShopTab:AddDropdown({
	Title = "Select Fight Style",
	Values = FightStyleOrder,
	Value = FightStyleOrder[1],
	Callback = function(v) SelectedFightStyle = v; end
});

local function BuyFightStyleFull(styleName)
	local data = FightStyleNPCs[styleName];
	if not data then
		Library:Notify({Title = "TRon Void Hub", Content = "Estilo nao encontrado: " .. tostring(styleName), Icon = "alert-triangle", Duration = 4});
		return;
	end;
	local plr = game.Players.LocalPlayer;
	local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
	if not hrp then return; end;
	if data.portal then
		pcall(function()
			(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", data.portal);
		end);
		task.wait(2);
		hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
		if not hrp then return; end;
	end;
	if data.submerged then
		local SubWorkerCF = CFrame.new(-16417.6, 74.26, 1811.3);
		TweenPlayer(SubWorkerCF);
		local tw = 0;
		repeat task.wait(0.2); tw=tw+0.2; until (hrp.Position - SubWorkerCF.Position).Magnitude < 18 or tw > 15;
		task.wait(0.5);
		pcall(function()
			(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("NPC", "Submarine Worker");
		end);
		task.wait(0.5);
		pcall(function()
			game:GetService("ReplicatedStorage").Modules.Net["RF/SubmarineWorkerSpeak"]:InvokeServer("TravelToSubmergedIsland");
		end);
		tw = 0;
		repeat task.wait(0.3); tw=tw+0.3; until hrp.Position.Y < -200 or tw > 18;
		task.wait(1);
		hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
		if not hrp then return; end;
	end;
	TweenPlayer(data.pos);
	local t = 0;
	repeat task.wait(0.2); t=t+0.2; until (hrp.Position - data.pos.Position).Magnitude < 15 or t > 20;
	task.wait(0.5);
	pcall(function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("NPC", data.npc);
	end);
	task.wait(0.6);
	pcall(function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(data.buy);
	end);
	task.wait(0.3);
	pcall(function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(data.buy, true);
	end);
	Library:Notify({Title = "TRon Void Hub", Content = "Compra enviada: " .. styleName, Icon = "check", Duration = 4});
end;

ShopTab:AddButton({
	Title = " Go Buy Selected Fight Style",
	Desc = "Tween ate o NPC, faz dialogo e compra o estilo selecionado",
	Callback = function()
		task.spawn(function() pcall(BuyFightStyleFull, SelectedFightStyle); end);
	end
});

local _autoBuyAllActive = false;
ShopTab:AddToggle({
	Title = "Auto Buy All Fight Styles",
	Desc = "Vai em cada NPC em ordem e compra todos os estilos",
	Value = false,
	Callback = function(state)
		_autoBuyAllActive = state;
		if state then
			task.spawn(function()
				for _, styleName in ipairs(FightStyleOrder) do
					if not _autoBuyAllActive then break; end;
					pcall(BuyFightStyleFull, styleName);
					task.wait(1.5);
				end;
				_autoBuyAllActive = false;
			end);
		end;
	end
});
SwordShopSection = ShopTab:AddSection("Sword");
BuyCutlassButton = ShopTab:AddButton({
	Title = "Buy Cutlass",
	Desc = "$1,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Cutlass");
	end
});
BuyKatanaButton = ShopTab:AddButton({
	Title = "Buy Katana",
	Desc = "$1,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Katana");
	end
});
BuyIronMaceButton = ShopTab:AddButton({
	Title = "Buy Iron Mace",
	Desc = "$25,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace");
	end
});
BuyDualKatanaButton = ShopTab:AddButton({
	Title = "Buy Dual Katana",
	Desc = "$12,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Dual Katana");
	end
});
BuyTripleKatanaButton = ShopTab:AddButton({
	Title = "Buy Triple Katana",
	Desc = "$60,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana");
	end
});
BuyPipeButton = ShopTab:AddButton({
	Title = "Buy Pipe",
	Desc = "$100,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Pipe");
	end
});
BuyDualHeadedBladeButton = ShopTab:AddButton({
	Title = "Buy Dual Headed Blade",
	Desc = "$400,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade");
	end
});
BuyBisentoButton = ShopTab:AddButton({
	Title = "Buy Bisento",
	Desc = "$1,200,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Bisento");
	end
});
BuySoulCaneButton = ShopTab:AddButton({
	Title = "Buy Soul Cane",
	Desc = "$1,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane");
	end
});
GunShopSection = ShopTab:AddSection("Gun");
BuySlingshotButton = ShopTab:AddButton({
	Title = "Buy Slingshot",
	Desc = "$5,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Slingshot");
	end
});
BuyMusketButton = ShopTab:AddButton({
	Title = "Buy Musket",
	Desc = "$8,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Musket");
	end
});
BuyFintlockButton = ShopTab:AddButton({
	Title = "Buy Flintlock",
	Desc = "$10,500",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Flintlock");
	end
});
BuyRefinedFintlockButton = ShopTab:AddButton({
	Title = "Buy Refined Fintlock",
	Desc = "$60,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Refined Fintlock");
	end
});
BuyCanonButton = ShopTab:AddButton({
	Title = "Buy Cannon",
	Desc = "$100,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Cannon");
	end
});
BuyKabuchaButton = ShopTab:AddButton({
	Title = "Buy Kabucha",
	Desc = "B$1,500",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "1");
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "2");
	end
});
StatsShopSection = ShopTab:AddSection("Stats");
ResetStatsShopButton = ShopTab:AddButton({
	Title = "Reset Stats",
	Desc = "B$2,500",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1");
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2");
	end
});
RandomRaceShopButton = ShopTab:AddButton({
	Title = "Random Race",
	Desc = "B$3,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "1");
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2");
	end
});
AccessoriesShopSection = ShopTab:AddSection("Accessories");
BuyBlackCapeButton = ShopTab:AddButton({
	Title = "Buy Black Cape",
	Desc = "$50,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Black Cape");
	end
});
BuySwordsmanHatButton = ShopTab:AddButton({
	Title = "Buy Swordsman Hat",
	Desc = "$150,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Swordsman Hat");
	end
});
BuyTomoeRingButton = ShopTab:AddButton({
	Title = "Buy Tomoe Ring",
	Desc = "$500,000",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Tomoe Ring");
	end
});

local IslandList = {};
if World1 then
	IslandList = {
		"WindMill",
		"Marine",
		"Middle Town",
		"Jungle",
		"Pirate Village",
		"Desert",
		"Snow Island",
		"MarineFord",
		"Colosseum",
		"Sky Island 1",
		"Sky Island 2",
		"Sky Island 3",
		"Prison",
		"Magma Village",
		"Under Water Island",
		"Fountain City",
		"Shank Room",
		"Mob Island"
	};
elseif World2 then
	IslandList = {
		"The Cafe",
		"Frist Spot",
		"Dark Area",
		"Flamingo Mansion",
		"Flamingo Room",
		"Green Zone",
		"Factory",
		"Colossuim",
		"Zombie Island",
		"Two Snow Mountain",
		"Punk Hazard",
		"Cursed Ship",
		"Ice Castle",
		"Forgotten Island",
		"Ussop Island",
		"Mini Sky Island"
	};
elseif World3 then
	IslandList = {
		"Mansion",
		"Port Town",
		"Great Tree",
		"Castle On The Sea",
		"MiniSky",
		"Hydra Island",
		"Floating Turtle",
		"Haunted Castle",
		"Ice Cream Island",
		"Peanut Island",
		"Cake Island",
		"Cocoa Island",
		"Candy Island",
		"Tiki Outpost",
		"Dragon Dojo"
	};
end;
local EclipseIslandList = {};
pcall(function()
	for _, loc in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
		table.insert(EclipseIslandList, loc.Name);
	end;
end);
local PortalIslands = {
	["Sky Island 2"]         = Vector3.new(-4607.82275, 872.54248, -1667.55688),
	["Sky Island 3"]         = Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047),
	["Under Water Island"]   = Vector3.new(61163.8515625, 11.6796875, 1819.7841796875),
	["Castle On The Sea"]    = Vector3.new(-5083.26025390625, 314.6056823730469, -3175.673095703125),
	["Mansion"]              = Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375),
	["Hydra Island"]         = Vector3.new(5643.4526367188, 1013.0858154297, -340.51025390625),
};
SelectedTeleportIslandDropdown = TeleportTab:AddDropdown({
	Title = "Choose Island",
	Desc = "Lista dinamica do Eclipse - le o mapa real",
	Values = EclipseIslandList,
	Value = EclipseIslandList[1] or "",
	Callback = function(option)
		_G.SelectIsland = option;
	end
});

AutoTeleportToIslandToggle = TeleportTab:AddToggle({
	Title = "Tween To Island",
	Desc = "Move suavemente ate a ilha selecionada e para ao chegar. Player pode se mover normalmente.",
	Value = false,
	Callback = function(state)
		_G.TweenToIslandActive = state;
		if not state then StopTween(false); return; end;
		task.spawn(function()
			if not _G.SelectIsland or _G.SelectIsland == "" then return; end;
			local plr = game.Players.LocalPlayer;
			local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
			if not hrp then return; end;
			if PortalIslands and PortalIslands[_G.SelectIsland] then
				pcall(function()
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(
						"requestEntrance", PortalIslands[_G.SelectIsland]
					);
				end);
				task.wait(1.5);
			else
				local target = workspace._WorldOrigin.Locations:FindFirstChild(_G.SelectIsland);
				if target then
					local destCF = target.CFrame * CFrame.new(0, 5, 0);
					TweenPlayer(destCF);
					local t = 0;
					repeat
						task.wait(0.1); t = t + 0.1;
						hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
						if not hrp then break; end;
					until not _G.TweenToIslandActive
						or (hrp.Position - destCF.p).Magnitude < 20
						or t > 60;
					StopTween(false);
					_G.TweenToIslandActive = false;
					if AutoTeleportToIslandToggle then
						pcall(function() AutoTeleportToIslandToggle:SetValue(false); end);
					end;
				end;
			end;
		end);
	end
});

_G.BypassTeleportActive = false;
TeleportTab:AddToggle({
	Title = "Bypass Teleport to Island",
	Desc = "Teleporta via bypass (com reset) para a ilha selecionada. Repete ate chegar. Player pode pular/mover.",
	Value = false,
	Callback = function(state)
		_G.BypassTeleportActive = state;
		if not state then return; end;
		task.spawn(function()
			while _G.BypassTeleportActive do
				pcall(function()
					if not _G.SelectIsland or _G.SelectIsland == "" then return; end;
					local plr = game.Players.LocalPlayer;
					local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
					if not hrp then return; end;
					if PortalIslands and PortalIslands[_G.SelectIsland] then
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(
							"requestEntrance", PortalIslands[_G.SelectIsland]
						);
						task.wait(1.5);
					else
						local target = workspace._WorldOrigin.Locations:FindFirstChild(_G.SelectIsland);
						if target then
							local destCF = target.CFrame * CFrame.new(0, 5, 0);
							hrp.CFrame = destCF;
							task.wait(0.3);
							hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
							if hrp and (hrp.Position - destCF.p).Magnitude < 20 then
								_G.BypassTeleportActive = false;
								Library:Notify({Title = "TRon Void Hub", Content = "Chegou em: " .. _G.SelectIsland, Icon = "map-pin", Duration = 4});
							end;
						end;
					end;
				end);
				task.wait(0.5);
			end;
		end);
	end
});

_G.TweenIsland = false;
AutoTweenToIslandToggle = TeleportTab:AddToggle({
	Title = "Tween To Island",
	Desc = "Move suavemente ate a ilha selecionada",
	Value = false,
	Callback = function(state)
		_G.TweenIsland = state;
		if not state then StopTween(false); end;
		if state then
			task.spawn(function()
				repeat
					pcall(function()
						if not _G.SelectIsland then return; end;
						local plr = game.Players.LocalPlayer;
						local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
						if not hrp then return; end;
						if PortalIslands[_G.SelectIsland] then
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(
								"requestEntrance", PortalIslands[_G.SelectIsland]
							);
							task.wait(1);
						else
							local target = workspace._WorldOrigin.Locations:FindFirstChild(_G.SelectIsland);
							if target then
								local destPos = target.CFrame * CFrame.new(0, 5, 0);
								local dist = (hrp.Position - destPos.p).Magnitude;
								if dist > 15 then
									TweenPlayer(destPos);
									local t = 0;
									repeat
										task.wait(0.1);
										t = t + 0.1;
										hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
										if not hrp then break; end;
									until not _G.TweenIsland
										or (hrp.Position - destPos.p).Magnitude < 20
										or t > 15;
								end;
							end;
						end;
					end);
					task.wait(0.3);
				until not _G.TweenIsland;
			end);
		end;
	end
});

TeleportNpcSection = TeleportTab:AddSection("Npc");
local EclipseNPCList = {};
pcall(function()
	local replNPCs = (game:GetService("ReplicatedStorage")):FindFirstChild("NPCs");
	if replNPCs then
		for _, npc in pairs(replNPCs:GetChildren()) do
			table.insert(EclipseNPCList, npc.Name);
		end;
	end;
end);
local SelectedNpcName = EclipseNPCList[1] or "";
SelectedNpcTeleport = TeleportTab:AddDropdown({
	Title = "Choose Npc",
	Desc = "Lista dinamica do Eclipse - NPCs reais do servidor",
	Values = EclipseNPCList,
	Value = EclipseNPCList[1] or "",
	Callback = function(option)
		SelectedNpcName = option;
		_G.SelectNPC = option;
	end
});

TeleportToNpcToggle = TeleportTab:AddToggle({
	Title = "Teleport To Npc",
	Desc = "Teleporte instantaneo direto para o NPC",
	Value = false,
	Callback = function(state)
		_G.TeleportNPC = state;
		if not state then StopTween(false); end;
		if state then
			task.spawn(function()
				repeat
					pcall(function()
						local replNPCs = (game:GetService("ReplicatedStorage")):FindFirstChild("NPCs");
						if replNPCs then
							for _, npcModel in pairs(replNPCs:GetChildren()) do
								if npcModel.Name == SelectedNpcName then
									local hrp = npcModel:FindFirstChild("HumanoidRootPart");
									if hrp then
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
											hrp.CFrame * CFrame.new(0, 3, 4);
									end;
								end;
							end;
						end;
					end);
					task.wait(0.5);
				until not _G.TeleportNPC;
			end);
		end;
	end
});

_G.TweenNPC = false;
TweenToNpcToggle = TeleportTab:AddToggle({
	Title = "Tween To Npc",
	Desc = "Move suavemente ate o NPC selecionado",
	Value = false,
	Callback = function(state)
		_G.TweenNPC = state;
		if not state then StopTween(false); end;
		if state then
			task.spawn(function()
				repeat
					pcall(function()
						local plr = game.Players.LocalPlayer;
						local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
						if not hrp then return; end;
						local replNPCs = (game:GetService("ReplicatedStorage")):FindFirstChild("NPCs");
						if replNPCs then
							for _, npcModel in pairs(replNPCs:GetChildren()) do
								if npcModel.Name == SelectedNpcName then
									local npcHrp = npcModel:FindFirstChild("HumanoidRootPart");
									if npcHrp then
										local dest = npcHrp.CFrame * CFrame.new(0, 3, 4);
										local dist = (hrp.Position - dest.p).Magnitude;
										if dist > 10 then
											TweenPlayer(dest);
											local t = 0;
											repeat
												task.wait(0.1);
												t = t + 0.1;
												hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
												if not hrp then break; end;
											until not _G.TweenNPC
												or (hrp.Position - dest.p).Magnitude < 12
												or t > 12;
										end;
									end;
								end;
							end;
						end;
					end);
					task.wait(0.3);
				until not _G.TweenNPC;
			end);
		end;
	end
});
EspSection = EspTab:AddSection("Esp");
EspPlayerToggle = EspTab:AddToggle({
	Title = "Esp Player",
	Desc = "Highlight Player",
	Value = _G.Settings.Esp["ESP Player"],
	Callback = function(state)
		_G.Settings.Esp["ESP Player"] = state;
	end
});
EspChestToggle = EspTab:AddToggle({
	Title = "Esp Chest",
	Desc = "Highlight Chest",
	Value = _G.Settings.Esp["ESP Chest"],
	Callback = function(state)
		_G.Settings.Esp["ESP Chest"] = state;
	end
});
EspDevilFruitToggle = EspTab:AddToggle({
	Title = "Esp DevilFruit",
	Desc = "Highlight DevilFruit",
	Value = _G.Settings.Esp["ESP DevilFruit"],
	Callback = function(state)
		_G.Settings.Esp["ESP DevilFruit"] = state;
	end
});
EspRealFruitToggle = EspTab:AddToggle({
	Title = "Esp RealFruit",
	Desc = "Highlight RealFruit",
	Value = _G.Settings.Esp["ESP RealFruit"],
	Callback = function(state)
		_G.Settings.Esp["ESP RealFruit"] = state;
	end
});
EspFlowerToggle = EspTab:AddToggle({
	Title = "Esp Flower",
	Desc = "Highlight Flower",
	Value = _G.Settings.Esp["ESP Flower"],
	Callback = function(state)
		_G.Settings.Esp["ESP Flower"] = state;
	end
});
EspIslandToggle = EspTab:AddToggle({
	Title = "Esp Island",
	Desc = "Highlight Island",
	Value = _G.Settings.Esp["ESP Island"],
	Callback = function(state)
		_G.Settings.Esp["ESP Island"] = state;
	end
});
EspNpcToggle = EspTab:AddToggle({
	Title = "Esp Npc",
	Desc = "Highlight Npc",
	Value = _G.Settings.Esp["ESP Npc"],
	Callback = function(state)
		_G.Settings.Esp["ESP Npc"] = state;
	end
});
EspSeaBeastToggle = EspTab:AddToggle({
	Title = "Esp Sea Beast",
	Desc = "Highlight SeaBeast",
	Value = _G.Settings.Esp["ESP Sea Beast"],
	Callback = function(state)
		_G.Settings.Esp["ESP Sea Beast"] = state;
	end
});
EspMonsterToggle = EspTab:AddToggle({
	Title = "Esp Mob",
	Desc = "Highlight Monster",
	Value = _G.Settings.Esp["ESP Monster"],
	Callback = function(state)
		_G.Settings.Esp["ESP Monster"] = state;
	end
});
EspMirageIslandToggle = EspTab:AddToggle({
	Title = "Esp Mirage Island",
	Desc = "Highlight Mirage Island",
	Value = _G.Settings.Esp["ESP Mirage"],
	Callback = function(state)
		_G.Settings.Esp["ESP Mirage"] = state;
	end
});
EspKitsuneIslandToggle = EspTab:AddToggle({
	Title = "Esp Kitsune Island",
	Desc = "Highlight Kitsune Island",
	Value = _G.Settings.Esp["ESP Kitsune"],
	Callback = function(state)
		_G.Settings.Esp["ESP Kitsune"] = state;
	end
});
EspFrozenDimensionToggle = EspTab:AddToggle({
	Title = "Esp Frozen Dimension",
	Desc = "Highlight Frozen Dimension",
	Value = _G.Settings.Esp["ESP Frozen"],
	Callback = function(state)
		_G.Settings.Esp["ESP Frozen"] = state;
	end
});
EspPrehistoricIslandToggle = EspTab:AddToggle({
	Title = "Esp Prehistoric Island",
	Desc = "Highlight Prehistoric Island",
	Value = _G.Settings.Esp["ESP Prehistoric"],
	Callback = function(state)
		_G.Settings.Esp["ESP Prehistoric"] = state;
	end
});
EspGearToggle = EspTab:AddToggle({
	Title = "Esp Gear",
	Desc = "Highlight Gear",
	Value = _G.Settings.Esp["ESP Gear"],
	Callback = function(state)
		_G.Settings.Esp["ESP Gear"] = state;
	end
});

DojoTab:AddSection(" Dojo Quest - Belt Trainer");

DojoTab:AddParagraph({
	Title = "Auto Dojo Trainer",
	Desc = "Completa as quests de faixa automaticamente (White -> Black)"
});

local _G_Dojoo = false;
local debugDojo = false;

local function printBeltName(I)
	if type(I) == "table" and I.Quest and I.Quest.BeltName then
		return I.Quest.BeltName;
	end;
end;

DojoTab:AddToggle({
	Title = "Auto Dojo Trainer",
	Desc = "Pega e completa quests de faixa: White, Yellow, Green, Purple, Red, Black",
	Value = false,
	Callback = function(I)
		_G_Dojoo = I;
		_G.Dojoo = I;
	end
});

task.spawn(function()
	while task.wait(0.2) do
		if _G_Dojoo then
			pcall(function()
				local I = {{[1] = {NPC="Dojo Trainer", Command="RequestQuest"}}};
				local e = (game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest")):InvokeServer(unpack(I[1]));
				local K = printBeltName(e);
				if debugDojo == false and (not e and not K) then
					TweenPlayer(CFrame.new(5865.0234375, 1208.3154296875, 871.15185546875));
					debugDojo = true;
				elseif debugDojo == true and ((CFrame.new(5865.0234375,1208.3154296875,871.15185546875)).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
					if K == "White" then
						local mob = GetConnectionEnemies("Skull Slayer");
						if mob then
							repeat task.wait(); G.Kill(mob, _G_Dojoo); until not e or not _G_Dojoo or not G.Alive(mob);
						else
							TweenPlayer(CFrame.new(-16759.58984375, 71.283767700195, 1595.3399658203));
						end;
					elseif K == "Yellow" or K == "Green" or K == "Red" then
						repeat task.wait();
							_G.SeaBeast1=true; _G.SailBoats=true;
						until not _G_Dojoo or not e;
						_G.SeaBeast1=false; _G.SailBoats=false;
					elseif K == "Purple" then
						repeat task.wait(); _G.FarmEliteHunt=true; until not _G_Dojoo or not e;
						_G.FarmEliteHunt=false;
					elseif K == "Black" then
						repeat task.wait();
							if workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
								_G.Prehis_Find=true; _G.Prehis_Skills=false;
							else
								_G.Prehis_Find=true;
							end;
						until not _G_Dojoo or not e;
						_G.Prehis_Find=false; _G.Prehis_Skills=false;
					elseif K == "Orange" or K == "Blue" then
						return nil;
					end;
				end;
				if not e then
					debugDojo = false;
					local J = {{[1] = {NPC="Dojo Trainer", Command="ClaimQuest"}}};
					(game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest")):InvokeServer(unpack(J[1]));
				end;
			end);
		end;
	end;
end);

DragonDojoSection = DojoTab:AddSection("Dragon Dojo");
AutoFarmBlazeEmberToggle = DojoTab:AddToggle({
	Title = "Auto Farm Blaze Ember",
	Desc = "Auto Compleate Quest + Collect Blaze Ember [ Sea 3 Only ]",
	Value = _G.Settings.DragonDojo["Auto Farm Blaze Ember"],
	Callback = function(state)
		_G.Settings.DragonDojo["Auto Farm Blaze Ember"] = state;
		StopTween(_G.Settings.DragonDojo["Auto Farm Blaze Ember"]);
		(getgenv()).SaveSetting();
	end
});
function getBlazeEmberQuest()
	local ResQuest = ((((game:GetService("ReplicatedStorage")):WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RF/DragonHunter")):InvokeServer({
		Context = "Check"
	});
	if ResQuest then
		for key, value in pairs(ResQuest) do
			if key == "Text" then
				return value;
			end;
		end;
	end;
end;
function getRequestQuest()
	local Req = ((((game:GetService("ReplicatedStorage")):WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RF/DragonHunter")):InvokeServer({
		Context = "RequestQuest"
	});
	return Req;
end;
function getIsOnQuest()
	local ResQuest = ((((game:GetService("ReplicatedStorage")):WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RF/DragonHunter")):InvokeServer({
		Context = "Check"
	});
	if ResQuest then
		for key, value in pairs(ResQuest) do
			if key == "Text" then
				if string.find(value, "Venomous Assailant") or string.find(value, "Hydra Enforcer") or string.find(value, "Destroy 10 trees") then
					return true;
				end;
			end;
		end;
	end;
	return false;
end;
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.DragonDojo["Auto Farm Blaze Ember"] then
			pcall(function()
				if not _G.OnBlzeQuest and (not getIsOnQuest()) then
					local DragonHunterPos = CFrame.new(5864.86377, 1209.55066, 812.775024, 0.879059196, 0.00000000381980803, 0.476712614, -0.0000000131110456, 1, 0.0000000161639893, -0.476712614, -0.0000000204593036, 0.879059196);
					TweenPlayer(DragonHunterPos);
					((((game:GetService("ReplicatedStorage")):WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RF/DragonHunter")):InvokeServer({
						Context = "RequestQuest"
					});
				end;
				SaveBlazeEmberQuest();
				_G.OnBlzeQuest = true;
			end);
		end;
	end;
end);
function SaveBlazeEmberQuest()
	if string.find(getBlazeEmberQuest(), "Venomous Assailant") then
		_G.BlazeEmberQuest = "Venomous Assailant";
	elseif string.find(getBlazeEmberQuest(), "Hydra Enforcer") then
		_G.BlazeEmberQuest = "Hydra Enforcer";
	elseif string.find(getBlazeEmberQuest(), "Destroy 10 trees") then
		_G.BlazeEmberQuest = "Destroy 10 trees";
	end;
end;
_G.OnBlzeQuest = false;
task.spawn(function()
	while task.wait(0.2) do
		if isQuestCompleated() then
			_G.OnBlzeQuest = false;
		end;
	end;
end);
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.DragonDojo["Auto Farm Blaze Ember"] then
			pcall(function()
				if _G.BlazeEmberQuest == "Venomous Assailant" and _G.OnBlzeQuest then
					autoKillVenemousAssailant();
				elseif _G.BlazeEmberQuest == "Hydra Enforcer" and _G.OnBlzeQuest then
					autoKillHydraEnforcer();
				elseif _G.BlazeEmberQuest == "Destroy 10 trees" and _G.OnBlzeQuest then
					autoDestroyHydraTrees();
				end;
			end);
		end;
	end;
end);
function isQuestCompleated()
	for i, v in pairs((game:GetService("Players")).LocalPlayer.PlayerGui.Notifications:GetChildren()) do
		for _, Notif in pairs(v:GetChildren()) do
			if string.find(Notif.Text, "Task completed!") or string.find(Notif.Text, "Head back to the Dojo") then
				return true;
			end;
		end;
	end;
	return false;
end;
function CollectBlazeEmber()
	InstantTp((((game:GetService("Workspace")):WaitForChild("EmberTemplate")):FindFirstChild("Part")).CFrame);
end;
function autoKillVenemousAssailant()
	if not (game:GetService("Workspace")).Enemies:FindFirstChild("Venomous Assailant") then
		TweenPlayer(CFrame.new(4789.29639, 1078.59082, 962.764099, -0.381989956, 0.0000000198627319, 0.924166501, 0.0000000126859874, 1, -0.0000000162490341, -0.924166501, 0.00000000551699708, -0.381989956));
	else
		for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
			if v.Name == "Venomous Assailant" then
				if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
					repeat
						task.wait(0.15);
						AutoHaki();
						EquipWeapon(_G.Settings.Main["Selected Weapon"]);
						v.Humanoid.WalkSpeed = 0;
						v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
						PosMon = v.HumanoidRootPart.CFrame;
						MonFarm = v.Name;
						TweenPlayer(v.HumanoidRootPart.CFrame * Pos);
						Attack();
					until not v.Parent or v.Humanoid.Health <= 0 or (not _G.Settings.DragonDojo["Auto Farm Blaze Ember"]) or (not _G.OnBlzeQuest);
				end;
			end;
		end;
	end;
end;
function autoKillHydraEnforcer()
	if not (game:GetService("Workspace")).Enemies:FindFirstChild("Hydra Enforcer") then
		TweenPlayer(CFrame.new(4789.29639, 1078.59082, 962.764099, -0.381989956, 0.0000000198627319, 0.924166501, 0.0000000126859874, 1, -0.0000000162490341, -0.924166501, 0.00000000551699708, -0.381989956));
	else
		for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
			if v.Name == "Hydra Enforcer" then
				if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
					repeat
						task.wait(0.15);
						AutoHaki();
						EquipWeapon(_G.Settings.Main["Selected Weapon"]);
						v.Humanoid.WalkSpeed = 0;
						v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
						PosMon = v.HumanoidRootPart.CFrame;
						MonFarm = v.Name;
						TweenPlayer(v.HumanoidRootPart.CFrame * Pos);
						Attack();
					until not v.Parent or v.Humanoid.Health <= 0 or (not _G.Settings.DragonDojo["Auto Farm Blaze Ember"]) or (not _G.OnBlzeQuest);
				end;
			end;
		end;
	end;
end;
function autoDestroyHydraTrees()
	local Pos1 = CFrame.new(5260.28223, 1004.24329, 347.062622, 0.923247099, -0.00000000370291953, 0.384206682, -0.000000000671108058, 1, 0.0000000112505019, -0.384206682, -0.0000000106448379, 0.923247099);
	local Pos2 = CFrame.new(5237.94775, 1004.24329, 429.596344, 0.371416599, 0.00000000207420636, 0.92846632, 0.00000000476562345, 1, -0.00000000414041734, -0.92846632, 0.00000000596254068, 0.371416599);
	local Pos3 = CFrame.new(5320.87793, 1004.24329, 439.152954, 0.136340275, -0.0000000995428806, -0.990662038, 0.0000000610136723, 1, -0.0000000920841288, 0.990662038, -0.0000000478891593, 0.136340275);
	local Pos4 = CFrame.new(5346.70752, 1004.24329, 359.389008, 0.296962529, 0.0000000642768185, -0.954889119, -0.0000000737323518, 1, 0.0000000443832349, 0.954889119, 0.0000000572260639, 0.296962529);
	local myPos = (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame;
	if (myPos.Position - Pos1.Position).Magnitude <= 3 then
		useAllSkill();
	else
		TweenPlayer(Pos1);
	end;
	if (myPos.Position - Pos2.Position).Magnitude <= 3 then
		useAllSkill();
	else
		TweenPlayer(Pos2);
	end;
	if (myPos.Position - Pos3.Position).Magnitude <= 3 then
		useAllSkill();
	else
		TweenPlayer(Pos3);
	end;
	if (myPos.Position - Pos4.Position).Magnitude <= 3 then
		useAllSkill();
	else
		TweenPlayer(Pos4);
	end;
end;
DoneSkillGun = false;
DoneSkillSword = false;
DoneSkillFruit = false;
DoneSkillMelee = false;
function useAllSkill()
	if DoneSkillFruit == false then
		for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") then
				if v.ToolTip == "Blox Fruit" then
					game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
				end;
			end;
		end;
		(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
		task.wait(0);
		(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
		(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
		task.wait(0);
		(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
		(game:service("VirtualInputManager")):SendKeyEvent(true, "C", false, game);
		task.wait(0);
		(game:service("VirtualInputManager")):SendKeyEvent(false, "C", false, game);
		(game:service("VirtualInputManager")):SendKeyEvent(true, "V", false, game);
		task.wait(0);
		(game:service("VirtualInputManager")):SendKeyEvent(false, "V", false, game);
		(game:service("VirtualInputManager")):SendKeyEvent(true, "F", false, game);
		task.wait(0);
		(game:service("VirtualInputManager")):SendKeyEvent(false, "F", false, game);
		DoneSkillFruit = true;
	end;
	if DoneSkillMelee == false then
		for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") then
				if v.ToolTip == "Melee" then
					game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
				end;
			end;
		end;
		(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
		task.wait(0);
		(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
		(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
		task.wait(0);
		(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
		(game:service("VirtualInputManager")):SendKeyEvent(true, "C", false, game);
		task.wait(0);
		(game:service("VirtualInputManager")):SendKeyEvent(false, "C", false, game);
		(game:service("VirtualInputManager")):SendKeyEvent(true, "V", false, game);
		task.wait(0);
		(game:service("VirtualInputManager")):SendKeyEvent(false, "V", false, game);
		DoneSkillMelee = true;
	end;
	if DoneSkillSword == false then
		for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") then
				if v.ToolTip == "Sword" then
					game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
				end;
			end;
		end;
		(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
		task.wait(0);
		(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
		(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
		task.wait(0);
		(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
		DoneSkillSword = true;
	end;
	if DoneSkillGun == false then
		for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") then
				if v.ToolTip == "Gun" then
					game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
				end;
			end;
		end;
		(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
		task.wait(0.1);
		(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
		(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
		task.wait(0.1);
		(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
		DoneSkillGun = true;
	end;
	DoneSkillGun = false;
	DoneSkillSword = false;
	DoneSkillFruit = false;
	DoneSkillMelee = false;
end;
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.DragonDojo["Auto Farm Blaze Ember"] then
			pcall(function()
				if ((game:GetService("Workspace")):WaitForChild("EmberTemplate")):FindFirstChild("Part") then
					CollectBlazeEmber();
				end;
			end);
		end;
	end;
end);
CraftVolcanicMagnetButton = DojoTab:AddButton({
	Title = "Craft Volcanic Magnet",
	Callback = function()
		(((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("CraftItem", "Craft", "Volcanic Magnet");
	end
});
DojoTab:AddSection("Draco Trial");
GetQuestDracoLevel = function()
	local I = { [1] = { NPC = "Dragon Wizard", Command = "Upgrade" } };
	return (game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest")):InvokeServer(unpack(I));
end;
UpgradeDracoTrialToggle = DojoTab:AddToggle({
	Title = "Auto Upgrade Draco Trial",
	Desc = "Auto tween to Dragon Wizard and upgrade",
	Value = _G.Settings.DragonDojo["Auto Upgrade Draco Trial"],
	Callback = function(state)
		_G.Settings.DragonDojo["Auto Upgrade Draco Trial"] = state;
		StopTween(_G.Settings.DragonDojo["Auto Upgrade Draco Trial"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.Settings.DragonDojo["Auto Upgrade Draco Trial"] then
				if GetQuestDracoLevel() == false then
					return nil;
				elseif GetQuestDracoLevel() == true then
					TweenPlayer(CFrame.new(5814.4272460938, 1208.3267822266, 884.57855224609));
					local I = { [1] = { NPC = "Dragon Wizard", Command = "Upgrade" } };
					(game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest")):InvokeServer(unpack(I));
				end;
			end;
		end);
	end;
end);
DracoV1Toggle = DojoTab:AddToggle({
	Title = "Auto Draco V1",
	Desc = "Auto Quest 1 + Prehistoric Event + Collect Dragon Eggs",
	Value = _G.Settings.DragonDojo["Auto Draco V1"],
	Callback = function(state)
		_G.Settings.DragonDojo["Auto Draco V1"] = state;
		StopTween(_G.Settings.DragonDojo["Auto Draco V1"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.Settings.DragonDojo["Auto Draco V1"] then
				if GetM("Dragon Egg") <= 0 then
					repeat
						task.wait(0.1);
						_G.Prehis_Find = true;
						_G.Prehis_Skills = true;
						_G.Prehis_DE = true;
					until not _G.Settings.DragonDojo["Auto Draco V1"] or GetM("Dragon Egg") >= 1;
					_G.Prehis_Find = false;
					_G.Prehis_Skills = false;
					_G.Prehis_DE = false;
				end;
			end;
		end);
	end;
end);
DracoV2Toggle = DojoTab:AddToggle({
	Title = "Auto Draco V2",
	Desc = "Auto Kill Forest Pirate + Collect Fire Flower",
	Value = _G.Settings.DragonDojo["Auto Draco V2"],
	Callback = function(state)
		_G.Settings.DragonDojo["Auto Draco V2"] = state;
		StopTween(_G.Settings.DragonDojo["Auto Draco V2"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		if _G.Settings.DragonDojo["Auto Draco V2"] then
			pcall(function()
				local flowers = workspace:FindFirstChild("FireFlowers");
				local enemy = GetConnectionEnemies("Forest Pirate");
				if enemy then
					repeat
						task.wait(0.1);
						G.Kill(enemy, _G.Settings.DragonDojo["Auto Draco V2"]);
					until not _G.Settings.DragonDojo["Auto Draco V2"] or not enemy.Parent or enemy.Humanoid.Health <= 0 or flowers;
				else
					TweenPlayer(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375));
				end;
				if flowers then
					for _, f in pairs(flowers:GetChildren()) do
						if f:IsA("Model") and f.PrimaryPart then
							local dist = (f.PrimaryPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude;
							if dist <= 100 then
								(game:GetService("VirtualInputManager")):SendKeyEvent(true, "E", false, game);
								task.wait(1.5);
								(game:GetService("VirtualInputManager")):SendKeyEvent(false, "E", false, game);
							else
								TweenPlayer(CFrame.new(f.PrimaryPart.Position));
							end;
						end;
					end;
				end;
			end);
		end;
	end;
end);
DracoV3Toggle = DojoTab:AddToggle({
	Title = "Auto Draco V3",
	Desc = "Auto Sea Event Kill Terror Shark",
	Value = _G.Settings.DragonDojo["Auto Draco V3"],
	Callback = function(state)
		_G.Settings.DragonDojo["Auto Draco V3"] = state;
		StopTween(_G.Settings.DragonDojo["Auto Draco V3"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.Settings.DragonDojo["Auto Draco V3"] then
				repeat
					task.wait(0.1);
					_G.DangerSc = "Lv Infinite";
					_G.GrindSea = true;
					_G.Settings.SeaEvent["Auto Farm Terror Shark"] = true;
				until not _G.Settings.DragonDojo["Auto Draco V3"];
				_G.DangerSc = "Lv 1";
				_G.GrindSea = false;
				_G.Settings.SeaEvent["Auto Farm Terror Shark"] = false;
			end;
		end);
	end;
end);
RelicDracoTrialToggle = DojoTab:AddToggle({
	Title = "Auto Relic Draco Trial [Beta]",
	Desc = "Auto Trial V4 - Collect the Relic yourself first",
	Value = _G.Settings.DragonDojo["Auto Relic Draco Trial"],
	Callback = function(state)
		_G.Settings.DragonDojo["Auto Relic Draco Trial"] = state;
		StopTween(_G.Settings.DragonDojo["Auto Relic Draco Trial"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		if _G.Settings.DragonDojo["Auto Relic Draco Trial"] then
			pcall(function()
				local Root = game.Players.LocalPlayer.Character.HumanoidRootPart;
				if workspace.Map:FindFirstChild("DracoTrial") then
					game:GetService("ReplicatedStorage").Remotes.DracoTrial:InvokeServer();
					task.wait(0.5);
					repeat task.wait(0.1); TweenPlayer(CFrame.new(-39934.9765625, 10685.359375, 22999.34375));
					until not _G.Settings.DragonDojo["Auto Relic Draco Trial"] or (Root.Position - CFrame.new(-39934.9765625, 10685.359375, 22999.34375).Position).Magnitude <= 10;
					repeat task.wait(0.1); TweenPlayer(CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625));
					until not _G.Settings.DragonDojo["Auto Relic Draco Trial"] or (Root.Position - CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625).Position).Magnitude <= 10;
					task.wait(2.5);
					repeat task.wait(0.1); TweenPlayer(CFrame.new(-39914.65625, 10685.384765625, 23000.177734375));
					until not _G.Settings.DragonDojo["Auto Relic Draco Trial"] or (Root.Position - CFrame.new(-39914.65625, 10685.384765625, 23000.177734375).Position).Magnitude <= 10;
					repeat task.wait(0.1); TweenPlayer(CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375));
					until not _G.Settings.DragonDojo["Auto Relic Draco Trial"] or (Root.Position - CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375).Position).Magnitude <= 10;
					task.wait(2.5);
					repeat task.wait(0.1); TweenPlayer(CFrame.new(-39908.5, 10685.405273438, 22990.04296875));
					until not _G.Settings.DragonDojo["Auto Relic Draco Trial"] or (Root.Position - CFrame.new(-39908.5, 10685.405273438, 22990.04296875).Position).Magnitude <= 10;
					repeat task.wait(0.1); TweenPlayer(CFrame.new(-39609.5, 9376.400390625, 23472.94335975));
					until not _G.Settings.DragonDojo["Auto Relic Draco Trial"] or (Root.Position - CFrame.new(-39609.5, 9376.400390625, 23472.94335975).Position).Magnitude <= 10;
				else
					local tp = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport");
					if tp and tp:IsA("Part") then
						TweenPlayer(CFrame.new(tp.Position));
					end;
				end;
			end);
		end;
	end;
end);
local function CheckShark()
	for _, v in pairs(workspace:GetChildren()) do
		if v.Name == "Shark" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then return true; end;
	end;
	for _, v in pairs(workspace:GetDescendants()) do
		if (v.Name == "Shark" or v.Name == "Bull Shark") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then return true; end;
	end;
	return false;
end;
local function CheckTerrorShark()
	for _, v in pairs(workspace:GetChildren()) do
		if (v.Name == "Terror Shark" or v.Name == "TerrorShark") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then return true; end;
	end;
	return false;
end;
local function CheckFishCrew()
	for _, v in pairs(workspace.Enemies:GetChildren()) do
		if (string.find(v.Name, "Fish") or string.find(v.Name, "Crew")) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then return true; end;
	end;
	return false;
end;
local function CheckPiranha()
	for _, v in pairs(workspace:GetChildren()) do
		if v.Name == "Piranha" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then return true; end;
	end;
	return false;
end;
local function CheckEnemiesBoat()
	for _, v in pairs(workspace:GetDescendants()) do
		if (string.find(v.Name, "Pirate") or string.find(v.Name, "Marine")) and v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
			local hrp = v:FindFirstChild("HumanoidRootPart");
			if hrp then
				local plrHrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
				if plrHrp and (hrp.Position - plrHrp.Position).Magnitude < 500 then return true; end;
			end;
		end;
	end;
	return false;
end;
local function CheckPirateGrandBrigade()
	for _, v in pairs(workspace:GetDescendants()) do
		if string.find(v.Name, "Grand Brigade") and v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then return true; end;
	end;
	return false;
end;
local function CheckHauntedCrew()
	for _, v in pairs(workspace.Enemies:GetChildren()) do
		if (string.find(v.Name, "Haunted") or v.Name == "Ghost" or v.Name == "Pirate Ghost") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then return true; end;
	end;
	return false;
end;
local function CheckLeviathan()
	for _, v in pairs(workspace:GetChildren()) do
		if string.find(v.Name, "Leviathan") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then return true; end;
	end;
	return false;
end;


FruitSection = FruitTab:AddSection("Fruit");
AutoRandomFruitToggle = FruitTab:AddToggle({
	Title = "Auto Random Fruit",
	Value = _G.Settings.Fruit["Auto Buy Random Fruit"],
	Callback = function(state)
		_G.Settings.Fruit["Auto Buy Random Fruit"] = state;
	end
});
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if _G.Settings.Fruit["Auto Buy Random Fruit"] then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("Cousin", "Buy");
				task.wait(0.3);
				pcall(function()
					local pg = game.Players.LocalPlayer.PlayerGui;
					for _, gui in pairs(pg:GetDescendants()) do
						if gui:IsA("Frame") or gui:IsA("ScreenGui") then
							local n = gui.Name:lower();
							if n:find("spin") or n:find("gacha") or n:find("cousin") or n:find("fruitroll") or n:find("roll") then
								gui.Enabled = false;
								gui.Visible = false;
							end;
						end;
					end;
				end);
			end;
		end;
	end);
end);
local RarityFruits = {
	Common = {
		"Rocket Fruit",
		"Spin Fruit",
		"Blade Fruit",
		"Spring Fruit",
		"Bomb Fruit",
		"Smoke Fruit",
		"Spike Fruit"
	},
	Uncommon = {
		"Flame Fruit",
		"Falcon Fruit",
		"Ice Fruit",
		"Sand Fruit",
		"Diamond Fruit",
		"Dark Fruit"
	},
	Rare = {
		"Light Fruit",
		"Rubber Fruit",
		"Barrier Fruit",
		"Ghost Fruit",
		"Magma Fruit"
	},
	Legendary = {
		"Quake Fruit",
		"Buddha Fruit",
		"Love Fruit",
		"Spider Fruit",
		"Sound Fruit",
		"Phoenix Fruit",
		"Portal Fruit",
		"Rumble Fruit",
		"Pain Fruit",
		"Blizzard Fruit"
	},
	Mythical = {
		"Gravity Fruit",
		"Mammoth Fruit",
		"T-Rex Fruit",
		"Dough Fruit",
		"Shadow Fruit",
		"Venom Fruit",
		"Control Fruit",
		"Gas Fruit",
		"Spirit Fruit",
		"Leopard Fruit",
		"Yeti Fruit",
		"Kitsune Fruit",
		"Dragon Fruit"
	}
};
local SelectRarityFruits = {
	"Common - Mythical",
	"Uncommon - Mythical",
	"Rare - Mythical",
	"Legendary - Mythical",
	"Mythical"
};
StoreRarityFruitDropdown = FruitTab:AddDropdown({
	Title = "Store Rarity Fruit",
	Values = SelectRarityFruits,
	Value = _G.Settings.Fruit["Store Rarity Fruit"],
	Callback = function(option)
		_G.Settings.Fruit["Store Rarity Fruit"] = option;
		(getgenv()).SaveSetting();
	end
});
function CheckFruits()
	for i, v in pairs(RarityFruits) do
		if _G.Settings.Fruit["Store Rarity Fruit"] == "Common - Mythical" then
			if i == "Common" or i == "Uncommon" or i == "Rare" or i == "Legendary" or i == "Mythical" then
				for _, fruit in ipairs(v) do
					table.insert(ResultStoreFruits, fruit);
				end;
			end;
		elseif _G.Settings.Fruit["Store Rarity Fruit"] == "Uncommon - Mythical" then
			if i == "Uncommon" or i == "Rare" or i == "Legendary" or i == "Mythical" then
				for _, fruit in ipairs(v) do
					table.insert(ResultStoreFruits, fruit);
				end;
			end;
		elseif _G.Settings.Fruit["Store Rarity Fruit"] == "Rare - Mythical" then
			if i == "Rare" or i == "Legendary" or i == "Mythical" then
				for _, fruit in ipairs(v) do
					table.insert(ResultStoreFruits, fruit);
				end;
			end;
		elseif _G.Settings.Fruit["Store Rarity Fruit"] == "Legendary - Mythical" then
			if i == "Legendary" or i == "Mythical" then
				for _, fruit in ipairs(v) do
					table.insert(ResultStoreFruits, fruit);
				end;
			end;
		elseif _G.Settings.Fruit["Store Rarity Fruit"] == "Mythical" then
			if i == "Mythical" then
				for _, fruit in ipairs(v) do
					table.insert(ResultStoreFruits, fruit);
				end;
			end;
		end;
	end;
end;
AutoStoreFruitToggle = FruitTab:AddToggle({
	Title = "Auto Store Fruit",
	Desc = "Verifica inventario e armazena frutas elegiveis de forma rapida.",
	Value = _G.Settings.Fruit["Auto Store Fruit"],
	Callback = function(state)
		_G.Settings.Fruit["Auto Store Fruit"] = state;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while true do
		task.wait(0.3);
		if not _G.Settings.Fruit["Auto Store Fruit"] then continue; end;
		pcall(function()
			local plr = game.Players.LocalPlayer;
			ResultStoreFruits = {};
			CheckFruits();
			if #ResultStoreFruits == 0 then return; end;
			local containers = {plr.Backpack};
			if plr.Character then table.insert(containers, plr.Character); end;
			for _, container in ipairs(containers) do
				for _, tool in ipairs(container:GetChildren()) do
					if not tool.Name:find("Fruit") then continue; end;
					local shouldStore = false;
					for _, fruitName in ipairs(ResultStoreFruits) do
						if tool.Name == fruitName then shouldStore = true; break; end;
					end;
					if not shouldStore then continue; end;
					local hasSlot = true;
					pcall(function()
						local stashData = plr:FindFirstChild("Data") and plr.Data:FindFirstChild("Fruits");
						if stashData then
							local count = #stashData:GetChildren();
							if count >= 2 then hasSlot = false; end;
						end;
					end);
					if not hasSlot then continue; end;
					local toolRef = container:FindFirstChild(tool.Name);
					if toolRef then
						local firstName = string.gsub(tool.Name, " Fruit", "");
						pcall(function()
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
								"StoreFruit",
								firstName .. "-" .. firstName,
								toolRef
							);
						end);
						task.wait(0.1);
					end;
				end;
			end;
		end);
	end;
end);
FruitNotification = FruitTab:AddToggle({
	Title = "Fruit Notification",
	Value = _G.Settings.Fruit["Fruit Notification"],
	Callback = function(state)
		_G.Settings.Fruit["Fruit Notification"] = value;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(2) do
		if _G.Settings.Fruit["Fruit Notification"] then
			for i, v in pairs(game.Workspace:GetChildren()) do
				if string.find(v.Name, "Fruit") then
					Library:Notify({
						Title = "Fruit found",
						Content = v.Name,
						Icon = "bell",
						Duration = 3
					});
				end;
			end;
		end;
	end;
end);
_G.FruitInterrupt = false;

local _PORTAL_DON_FLAMINGO = CFrame.new(-5685.5, 318.4, -3246.5);
local _PORTAL_MANSION_S3   = CFrame.new(-12471, 374.9, -7551.6);
local _PORTAL_CASTLE_S3    = CFrame.new(-26880, 22.8, 473.1);
local _PORTAL_HYDRA_S3     = CFrame.new(5643.4, 1013, -340.5);

local function _getFruitInWorkspace()
	for _, v in pairs(workspace:GetChildren()) do
		if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
			return v;
		end;
	end;
	return nil;
end;

local function _getPortalForFruitPos(fruitPos)
	local function dist(cf) return (fruitPos - cf.Position).Magnitude; end;
	if World3 then
		if dist(_PORTAL_HYDRA_S3) < 3500 then return _PORTAL_HYDRA_S3; end;
		if dist(_PORTAL_MANSION_S3) < 5000 then return _PORTAL_MANSION_S3; end;
		if dist(_PORTAL_CASTLE_S3) < 5000 then return _PORTAL_CASTLE_S3; end;
	elseif World2 then
		if dist(_PORTAL_DON_FLAMINGO) < 8000 then return _PORTAL_DON_FLAMINGO; end;
	end;
	return nil;
end;

local function _tweenToFruitAndPick(fruit)
	if not fruit or not fruit.Parent or not fruit:FindFirstChild("Handle") then return; end;
	local char = game.Players.LocalPlayer.Character;
	if not char then return; end;
	local hrp = char:FindFirstChild("HumanoidRootPart");
	local hum = char:FindFirstChildOfClass("Humanoid");
	if not hrp or not hum then return; end;

	pcall(function()
		hrp.Anchored = false;
		hum.WalkSpeed = 16;
		hum.JumpPower = 50;
	end);

	local fruitPos = fruit.Handle.Position;
	local portal = _getPortalForFruitPos(fruitPos);
	local TweenSvc = game:GetService("TweenService");

	if portal then
		local distToPortal = (hrp.Position - portal.Position).Magnitude;
		if distToPortal > 100 then
			local dur1 = math.max(0.5, distToPortal / (_G.Settings.Setting["Player Tween Speed"] or 350));
			local tw1 = TweenSvc:Create(hrp, TweenInfo.new(dur1, Enum.EasingStyle.Linear), {CFrame = portal});
			tw1:Play();
			local t1 = 0;
			while tw1.PlaybackState == Enum.PlaybackState.Playing do
				task.wait(0.05); t1 = t1 + 0.05;
				if t1 > dur1 + 1 then break; end;
			end;
			task.wait(0.5);
			hrp.CFrame = portal;
			task.wait(0.3);
		end;
	end;

	if not fruit or not fruit.Parent or not fruit:FindFirstChild("Handle") then return; end;
	local dist = (hrp.Position - fruit.Handle.Position).Magnitude;
	local dur = math.max(0.3, dist / (_G.Settings.Setting["Player Tween Speed"] or 350));
	local info = TweenInfo.new(dur, Enum.EasingStyle.Linear);
	local tween = TweenSvc:Create(hrp, info, {CFrame = fruit.Handle.CFrame});
	tween:Play();
	local elapsed = 0;
	while tween.PlaybackState == Enum.PlaybackState.Playing do
		task.wait(0.05);
		elapsed = elapsed + 0.05;
		if elapsed > dur + 1 then break; end;
	end;
	pcall(function()
		if fruit and fruit.Parent and fruit:FindFirstChild("Handle") then
			fruit.Handle.CFrame = hrp.CFrame;
		end;
	end);
	pcall(function()
		hrp.Anchored = false;
		hum.WalkSpeed = 16;
		hum.JumpPower = 50;
	end);
end;

local function _pauseFarmForFruit(fruit)
	if _G.FruitInterrupt then return; end;
	local _volPhase = _G._volcanicPhase or "idle";
	if _G.FullyVolcanicActive and (
		_volPhase == "solving" or
		_volPhase == "sailing" or
		_volPhase == "tweening" or
		_volPhase == "resetting"
	) then return; end;
	if not fruit or not fruit.Parent or not fruit:FindFirstChild("Handle") then return; end;
	local _hrpNow = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
	if _hrpNow then
		local _fruitDist = (_hrpNow.Position - fruit.Handle.Position).Magnitude;
		if _fruitDist > 10000 then
			local _tikiDist = (_hrpNow.Position - CFrame.new(-16927.451, 9.086, 433.864).Position).Magnitude;
			if _tikiDist > 5000 then
				pcall(function()
					local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
					if hum then hum.Health = 0; end;
				end);
			end;
			return;
		end;
	end;
	_G.FruitInterrupt = true;
	local sv_EclipseStart = _G.EclipseStartFarm;
	local sv_EclipseLevel = _G.EclipseLevel;
	local sv_EclipseBone  = _G.EclipseFarm_Bone;
	local sv_EclipseCake  = _G.EclipseFarm_Cake;
	local sv_AutoFarm     = _G.Settings.Main["Auto Farm"];
	local sv_Mastery      = _G.Settings.Main["Auto Farm Fruit Mastery"];
	local sv_Sword        = _G.Settings.Main["Auto Farm Sword Mastery"];
	_G.EclipseStartFarm = false;
	_G.EclipseLevel     = false;
	_G.EclipseFarm_Bone = false;
	_G.EclipseFarm_Cake = false;
	_G.Settings.Main["Auto Farm"] = false;
	_G.Settings.Main["Auto Farm Fruit Mastery"] = false;
	_G.Settings.Main["Auto Farm Sword Mastery"] = false;
	StopTween(false);
	pcall(function()
		local char = game.Players.LocalPlayer.Character;
		if char then
			local hrp = char:FindFirstChild("HumanoidRootPart");
			local hum = char:FindFirstChildOfClass("Humanoid");
			if hrp then hrp.Anchored = false; end;
			if hum then hum.WalkSpeed = 16; hum.JumpPower = 50; end;
		end;
	end);
	task.wait(0.3);
	_tweenToFruitAndPick(fruit);
	task.wait(0.3);
	_G.FruitInterrupt = false;
	if _G.Settings.Fruit["Tween To Fruit"] then
		_G.EclipseStartFarm = sv_EclipseStart;
		_G.EclipseLevel     = sv_EclipseLevel;
		_G.EclipseFarm_Bone = sv_EclipseBone;
		_G.EclipseFarm_Cake = sv_EclipseCake;
		_G.Settings.Main["Auto Farm"] = sv_AutoFarm;
		_G.Settings.Main["Auto Farm Fruit Mastery"] = sv_Mastery;
		_G.Settings.Main["Auto Farm Sword Mastery"] = sv_Sword;
	end;
end;

workspace.ChildAdded:Connect(function(child)
	if _G.Settings.Fruit["Tween To Fruit"]
	   and not _G.FruitInterrupt
	   and string.find(child.Name, "Fruit")
	   and child:FindFirstChild("Handle") then
		task.spawn(function()
			task.wait(0.1);
			_pauseFarmForFruit(child);
		end);
	end;
end);

TeleportToFruitToggle = FruitTab:AddToggle({
	Title = "Teleport To Fruit",
	Desc = " RISCO DE BAN - Teleporta instantaneo para a fruta. Use com cautela.",
	Value = _G.Settings.Fruit["Teleport To Fruit"],
	Callback = function(state)
		_G.Settings.Fruit["Teleport To Fruit"] = state;
		if not state then StopTween(false); end;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		if _G.Settings.Fruit["Teleport To Fruit"] then
			local char = game.Players.LocalPlayer.Character;
			if not char then continue; end;
			local hrp = char:FindFirstChild("HumanoidRootPart");
			if not hrp then continue; end;
			for _, v in pairs(workspace:GetChildren()) do
				if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
					hrp.CFrame = v.Handle.CFrame;
					task.wait(0.05);
					v.Handle.CFrame = hrp.CFrame;
				end;
			end;
		end;
	end;
end);

local collectFruits = function()
	local char = game.Players.LocalPlayer.Character;
	if not char then return end;
	for _, v in pairs(workspace:GetChildren()) do
		if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
			v.Handle.CFrame = char.HumanoidRootPart.CFrame;
		end;
	end;
end;

TweenToFruitToggle = FruitTab:AddToggle({
	Title = "Tween To Fruit",
	Desc = "Move suavemente ate a fruta e para o farm quando ela aparecer.",
	Value = _G.Settings.Fruit["Tween To Fruit"],
	Callback = function(state)
		_G.Settings.Fruit["Tween To Fruit"] = state;
		if not state then
			_G.FruitInterrupt = false;
		end;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	local _lastFruitHandled = nil;
	while task.wait(0.5) do
		if not _G.Settings.Fruit["Tween To Fruit"] then
			_lastFruitHandled = nil;
			continue;
		end;
		if _G.FruitInterrupt then continue; end;
		local fruit = _getFruitInWorkspace();
		if fruit and fruit ~= _lastFruitHandled then
			_lastFruitHandled = fruit;
			task.spawn(function()
				_pauseFarmForFruit(fruit);
				_lastFruitHandled = nil;
			end);
		elseif not fruit then
			_lastFruitHandled = nil;
		end;
	end;
end);
GrabFruitButton = FruitTab:AddButton({
	Title = "Grab Fruit",
	Callback = function()
		for i, v in pairs(game.Workspace:GetChildren()) do
			if v:IsA("Tool") then
				v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame;
			end;
		end;
	end
});
VisualSection = FruitTab:AddSection("Visual");
function rainFruit()
	for h, i in pairs((game:GetObjects("rbxassetid://14759368201"))[1]:GetChildren()) do
		i.Parent = game.Workspace.Map;
		i:MoveTo(game.Players.LocalPlayer.Character.PrimaryPart.Position + Vector3.new(math.random((-50), 50), 100, math.random((-50), 50)));
		if i.Fruit:FindFirstChild("AnimationController") then
			((i.Fruit:FindFirstChild("AnimationController")):LoadAnimation(i.Fruit:FindFirstChild("Idle"))):Play();
		end;
		i.Handle.Touched:Connect(function(cR)
			if cR.Parent == game.Players.LocalPlayer.Character then
				i.Parent = game.Players.LocalPlayer.Backpack;
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(i);
			end;
		end);
	end;
end;
RainFruitButton = FruitTab:AddButton({
	Title = "Rain Fruit",
	Callback = function()
		rainFruit();
	end
});
MiscSection = SettingsTab:AddSection("Misc");
JoinPiratesTeamButton = SettingsTab:AddButton({
	Title = "Join Pirates Team",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("SetTeam", "Pirates");
	end
});
JoinMarinesTeamButton = SettingsTab:AddButton({
	Title = "Join Marines Team",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("SetTeam", "Marines");
	end
});
CodeSection = SettingsTab:AddSection("Codes");
local codeList = {
	"KITTGAMING",
	"ENYU_IS_PRO",
	"FUDD10",
	"BIGNEWS",
	"THEGREATACE",
	"SUB2GAMERROBOT_EXP1",
	"STRAWHATMAIME",
	"SUB2OFFICIALNOOBIE",
	"SUB2NOOBMASTER123",
	"SUB2DAIGROCK",
	"AXIORE",
	"TANTAIGAMIMG",
	"STRAWHATMAINE",
	"JCWK",
	"FUDD10_V2",
	"SUB2FER999",
	"MAGICBIS",
	"TY_FOR_WATCHING",
	"STARCODEHEO"
};
function redeemCode(code)
	(game:GetService("ReplicatedStorage")).Remotes.Redeem:InvokeServer(code);
end;
local RedeemAllCodesButton = SettingsTab:AddButton({
	Title = "Redeem All Codes",
	Callback = function()
		for i, v in pairs(codeList) do
			redeemCode(v);
		end;
	end
});
GraphicMiscSection = SettingsTab:AddSection("Graphic");
function boostFps()
	local I = true;
	local e = game;
	local K = e.Workspace;
	local n = e.Lighting;
	local d = K.Terrain;
	d.WaterWaveSize = 0;
	d.WaterWaveSpeed = 0;
	d.WaterReflectance = 0;
	d.WaterTransparency = 0;
	n.GlobalShadows = false;
	n.FogEnd = 9000000000.0;
	n.Brightness = 1;
	(settings()).Rendering.QualityLevel = "Level01";
	for e, K in pairs(e:GetDescendants()) do
		if K:IsA("Part") or K:IsA("Union") or K:IsA("CornerWedgePart") or K:IsA("TrussPart") then
			K.Material = "Plastic";
			K.Reflectance = 0;
		elseif K:IsA("Decal") or K:IsA("Texture") and I then
			K.Transparency = 1;
		elseif K:IsA("ParticleEmitter") or K:IsA("Trail") then
			K.Lifetime = NumberRange.new(0);
		elseif K:IsA("Explosion") then
			K.BlastPressure = 1;
			K.BlastRadius = 1;
		elseif K:IsA("Fire") or K:IsA("SpotLight") or K:IsA("Smoke") or K:IsA("Sparkles") then
			K.Enabled = false;
		elseif K:IsA("MeshPart") then
			K.Material = "Plastic";
			K.Reflectance = 0;
			K.TextureID = 10385902758728957;
		end;
	end;
	for I, e in pairs(n:GetChildren()) do
		if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
			e.Enabled = false;
		end;
	end;
end;
FpsBoostButton = SettingsTab:AddButton({
	Title = "Fps Boost",
	Callback = function()
		boostFps();
	end
});
RemoveFogButton = SettingsTab:AddButton({
	Title = "Remove Fog",
	Callback = function()
		(game:GetService("Lighting")).LightingLayers:Destroy();
		(game:GetService("Lighting")).Sky:Destroy();
		game.Lighting.FogEnd = 9000000000;
	end
});
RemoveLavaButton = SettingsTab:AddButton({
	Title = "Remove Lava",
	Callback = function()
		for i, v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == "Lava" then
				v:Destroy();
			end;
		end;
		for i, v in pairs(game.ReplicatedStorage:GetDescendants()) do
			if v.Name == "Lava" then
				v:Destroy();
			end;
		end;
	end
});
ServerTabSection = ServerTab:AddSection("Server");
local _FpsParagraph = ServerTab:AddParagraph({
	Title = "FPS",
	Desc = "0",
	Image = "monitor",
	ImageSize = 20
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			_FpsParagraph:SetDesc(math.floor(workspace:GetRealPhysicsFPS()));
		end);
	end;
end);
local _PingParagraph = ServerTab:AddParagraph({
	Title = "Ping",
	Desc = "0",
	Image = "signal",
	ImageSize = 20
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			_PingParagraph:SetDesc((game:GetService("Stats")).Network.ServerStatsItem["Data Ping"]:GetValueString() .. " ms");
		end);
	end;
end);
RejoinServerButton = ServerTab:AddButton({
	Title = "Rejoin Server",
	Callback = function()
		(game:GetService("TeleportService")):Teleport(game.PlaceId);
	end
});
ServerHopButton = ServerTab:AddButton({
	Title = "Server Hop",
	Callback = function()
		local module = (loadstring(game:HttpGet("https://raw.githubusercontent.com/raw-scriptpastebin/FE/main/Server_Hop_Settings")))();
		module:Teleport(game.PlaceId);
	end
});
JobIdParagraph = ServerTab:AddParagraph({
	Title = "Job ID",
	Desc = game.JobId,
	Buttons = {
		{
			Title = "Copy",
			Callback = function()
				setclipboard(game.JobId);
			end
		}
	}
});
EnterJobIdInput = ServerTab:AddInput({
	Title = "Enter Job ID",
	Callback = function(value)
		_G.JobId = value;
	end
});
JoinJobIdButton = ServerTab:AddButton({
	Title = "Join Job ID",
	Callback = function()
		(game:GetService("TeleportService")):TeleportToPlaceInstance(game.PlaceId, _G.JobId);
	end
});
StatusServerSection = ServerTab:AddSection("Status");
MoonServerParagraph = ServerTab:AddParagraph({
	Title = "Moon Server",
	Desc = "N/A"
});
KitsuneStatusParagraph = ServerTab:AddParagraph({
	Title = "Kitsune Status",
	Desc = "N/A"
});
FrozenStatusParagraph = ServerTab:AddParagraph({
	Title = "Frozen Status",
	Desc = "N/A"
});
MirageStatusParagraph = ServerTab:AddParagraph({
	Title = "Mirage Status",
	Desc = "N/A"
});
HakiDealerStatusParagraph = ServerTab:AddParagraph({
	Title = "Haki Dealer Status",
	Desc = "N/A"
});
PrehistoricStatusParagraph = ServerTab:AddParagraph({
	Title = "Prehistoric Status",
	Desc = "N/A"
});
task.spawn(function()
	while task.wait() do
		pcall(function()
			if (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
				MoonServerParagraph:SetDesc("Full Moon 100%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
				MoonServerParagraph:SetDesc("Full Moon 75%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
				MoonServerParagraph:SetDesc("Full Moon 50%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
				MoonServerParagraph:SetDesc("Full Moon 25%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
				MoonServerParagraph:SetDesc("Full Moon 15%");
			else
				MoonServerParagraph:SetDesc("Full Moon 0%");
			end;
		end);
	end;
end);
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if World3 then
				if game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
					KitsuneStatusParagraph:SetDesc("Kitsune Island is Spawning");
				else
					KitsuneStatusParagraph:SetDesc("Kitsune Island Not Spawn");
				end;
			else
				KitsuneStatusParagraph:SetDesc("World 3 Only");
			end;
		end;
	end);
end);
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if World3 then
				if game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
					PrehistoricStatusParagraph:SetDesc("Prehistoric Island is Spawning");
				else
					PrehistoricStatusParagraph:SetDesc("Prehistoric Island Not Spawn");
				end;
			else
				PrehistoricStatusParagraph:SetDesc("World 3 Only");
			end;
		end;
	end);
end);
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if game.Workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
				FrozenStatusParagraph:SetDesc("Frozen Dimension Spawning");
			else
				FrozenStatusParagraph:SetDesc("Frozen Dimension Not Spawn");
			end;
		end;
	end);
end);
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if World2 or World3 then
				if game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
					MirageStatusParagraph:SetDesc("Mirage Island is Spawning");
				else
					MirageStatusParagraph:SetDesc("Mirage Island Not Spawn");
				end;
			else
				MirageStatusParagraph:SetDesc("World 3 Only");
			end;
		end;
	end);
end);
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			local response = (((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("ColorsDealer", "1");
			if response then
				HakiDealerStatusParagraph:SetDesc("Master Of Auras Spawning");
			else
				HakiDealerStatusParagraph:SetDesc("Master Of Auras Not Spawn");
			end;
		end);
	end;
end);
local _seaStatusParagraph = ServerTab:AddParagraph({
	Title = "SEA ATUAL",
	Desc = "Detectando..."
});
local _serverTimeParagraph = ServerTab:AddParagraph({
	Title = "TEMPO DE SERVIDOR",
	Desc = "N/A"
});
local _fodStatusParagraph = ServerTab:AddParagraph({
	Title = "FIRST OF DARKNESS",
	Desc = "N/A"
});
local _chaliceStatusParagraph = ServerTab:AddParagraph({
	Title = "GOD CHALICE",
	Desc = "N/A"
});
local _raidBossStatusParagraph = ServerTab:AddParagraph({
	Title = "RAID BOSS",
	Desc = "N/A"
});
local _pirateRaidStatusParagraph = ServerTab:AddParagraph({
	Title = "PIRATES RAID",
	Desc = "N/A"
});
local _factoryStatusParagraph = ServerTab:AddParagraph({
	Title = "FACTORY",
	Desc = "N/A"
});
local _jobIdParagraph = ServerTab:AddParagraph({
	Title = "JOB ID",
	Desc = "Em breve"
});
local _serverStartTime = os.time();
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local elapsed = os.time() - _serverStartTime;
			local mins = math.floor(elapsed / 60);
			local secs = elapsed % 60;
			_serverTimeParagraph:SetDesc(string.format("%02d:%02d ativos", mins, secs));
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(0.5);
		pcall(function()
			if World1 then
				_seaStatusParagraph:SetDesc("SEA 1 (First Sea)");
			elseif World2 then
				_seaStatusParagraph:SetDesc("SEA 2 (Second Sea)");
			elseif World3 then
				_seaStatusParagraph:SetDesc("SEA 3 (Third Sea)");
			else
				_seaStatusParagraph:SetDesc("Sea desconhecido");
			end;
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local found = false;
			for _, v in pairs(workspace:GetDescendants()) do
				if v.Name:lower():find("first") and v.Name:lower():find("dark") then
					found = true; break;
				end;
			end;
			_fodStatusParagraph:SetDesc(found and "SPAWNED no servidor!" or "Nao encontrado");
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local found = false;
			for _, v in pairs(workspace:GetDescendants()) do
				if v.Name:lower():find("god") and v.Name:lower():find("chal") then
					found = true; break;
				end;
			end;
			_chaliceStatusParagraph:SetDesc(found and "SPAWNED no servidor!" or "Nao encontrado");
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local raidBossNames = {"Darkbeard", "rip_indra", "Dough King", "Ice Admiral", "Cyborg", "Thunder God"};
			local found = false;
			for _, bossName in pairs(raidBossNames) do
				if workspace.Enemies:FindFirstChild(bossName) then
					found = true;
					_raidBossStatusParagraph:SetDesc("SPAWNED: " .. bossName);
					break;
				end;
			end;
			if not found then _raidBossStatusParagraph:SetDesc("Nenhum Raid Boss ativo"); end;
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local pirateRaid = workspace:FindFirstChild("PirateRaid") or workspace:FindFirstChild("Pirate Raid") or workspace:FindFirstChild("PiratesRaid");
			if pirateRaid then
				_pirateRaidStatusParagraph:SetDesc("ATIVO no servidor!");
			else
				_pirateRaidStatusParagraph:SetDesc("Inativo");
			end;
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local factory = workspace:FindFirstChild("Factory") or workspace:FindFirstChild("FactoryFortress");
			if factory then
				_factoryStatusParagraph:SetDesc("ATIVO no servidor!");
			else
				_factoryStatusParagraph:SetDesc("Inativo");
			end;
		end);
	end;
end);
getgenv().HoldSkillConfig = {
	["Z"] = true,
	["X"] = true,
	["C"] = true,
	["V"] = false,
	["F"] = false,
	["Melee"] = false,
	["Sword"] = false,
	["Gun"] = false,
}

HoldAndSkillTab:AddSection("Skills Config - Selecione as skills para usar nos farms");

HoldAndSkillTab:AddParagraph({
	Title = "Como funciona",
	Desc = "Selecione abaixo quais teclas/skills serao usadas em TODOS os farms e funcoes do hub que precisam de skills. As combinacoes Z X C Melee, Z X C V F Fruit, Z X Sword e Z X Gun definem grupos rapidos."
});

HoldAndSkillTab:AddToggle({


_G.VolcanicAutoReset   = false;
_G.VolcanicCollectEgg  = false;
_G.VolcanicCollectBone = false;
_G._volcanicPhase      = "idle";
_G.VolcanicSelectedBoat = _G.VolcanicSelectedBoat or "Guardian";

local _V = {};

_V.TIKI_CF         = CFrame.new(-16927.451, 9.086, 433.864);
_V.DRAGON_CF       = CFrame.new(5864.86377, 1209.55066, 812.775024);
_V.JUNGLE_QUEST_CF = CFrame.new(-12680, 389, -9902);
_V.JUNGLE_MOB_CF   = CFrame.new(-11778, 426, -10592);
_V.VSLT_CF         = CFrame.new(4789.29639, 1078.59082, 962.764099);
_V.HYDRA_CF        = CFrame.new(4620.6157, 1002.2954, 399.0868);
_V.SAIL_CF         = CFrame.new(-148073.359, 9.0, 7721.051);
_V.BOAT_SPEED      = 300;

_V.TREE_CFS = {
	CFrame.new(5260.28223, 1004.24329, 347.062622),
	CFrame.new(5237.94775, 1004.24329, 429.596344),
	CFrame.new(5320.87793, 1004.24329, 439.152954),
	CFrame.new(5346.70752, 1004.24329, 359.389008),
};

_V.GOLEM_NAMES = {"Lava Golem","Aura Golem","Stone Golem","Rock Golem"};

local _vTweenPart = nil;
local _vTweenObj  = nil;
local _vMoving    = false;
local _vHB        = nil;

local function _vEnsureHB()
	if _vHB then return; end;
	if not _vTweenPart or not _vTweenPart.Parent then
		local p = Instance.new("Part");
		p.Name="__VP"; p.Size=Vector3.new(1,1,1); p.Anchored=true;
		p.CanCollide=false; p.CanTouch=false; p.Transparency=1; p.Parent=workspace;
		_vTweenPart = p;
	end;
	local plr = game.Players.LocalPlayer;
	_vHB = game:GetService("RunService").Heartbeat:Connect(function()
		if not _vMoving then return; end;
		pcall(function()
			local ch = plr.Character; if not ch then return; end;
			local hrp = ch:FindFirstChild("HumanoidRootPart"); if not hrp then return; end;
			if _vTweenPart and _vTweenPart.Parent then
				hrp.CFrame = _vTweenPart.CFrame;
			end;
		end);
	end);
end;

local function _vStopTween()
	_vMoving = false;
	if _vTweenObj then pcall(function() _vTweenObj:Cancel(); end); _vTweenObj = nil; end;
end;

local function _vStartTween(cf)
	shouldTween = false; _G.StopTween = true;
	local plr = game.Players.LocalPlayer;
	local ch  = plr.Character; if not ch then return; end;
	local hrp = ch:FindFirstChild("HumanoidRootPart"); if not hrp then return; end;
	local dist = (cf.Position - hrp.Position).Magnitude; if dist < 3 then return; end;
	_vEnsureHB();
	if _vTweenObj then pcall(function() _vTweenObj:Cancel(); end); _vTweenObj = nil; end;
	_vTweenPart.CFrame = hrp.CFrame;
	local speed = ((_G.Settings and _G.Settings.Setting and tonumber(_G.Settings.Setting["Player Tween Speed"])) or getgenv().TweenSpeedFar or 350);
	local ts = game:GetService("TweenService");
	_vTweenObj = ts:Create(_vTweenPart, TweenInfo.new(math.max(0.1, dist/speed), Enum.EasingStyle.Linear), {CFrame=cf});
	_vMoving = true;
	_vTweenObj:Play();
end;

local function _vWalkTo(cf, thr, timeout)
	thr=thr or 15; timeout=timeout or 90;
	local elapsed=0; local stuckT=0; local lastPos=nil;
	_vStartTween(cf);
	while _G.FullyVolcanicActive do
		task.wait(0.2); elapsed=elapsed+0.2;
		local ch  = game.Players.LocalPlayer.Character;
		local hrp = ch and ch:FindFirstChild("HumanoidRootPart");
		if not hrp then
			task.wait(1); elapsed=elapsed+1;
			_vStartTween(cf); continue;
		end;
		local d = (hrp.Position - cf.Position).Magnitude;
		if d <= thr then _vStopTween(); return true; end;
		if elapsed >= timeout then _vStopTween(); return false; end;
		if lastPos then
			if (hrp.Position - lastPos).Magnitude < 3 then
				stuckT=stuckT+0.2;
				if stuckT >= 1.0 then
					stuckT=0;
					if _vTweenObj then pcall(function() _vTweenObj:Cancel(); end); _vTweenObj=nil; end;
					_vTweenPart.CFrame = hrp.CFrame;
					local speed = ((_G.Settings and _G.Settings.Setting and tonumber(_G.Settings.Setting["Player Tween Speed"])) or getgenv().TweenSpeedFar or 350);
					local dist2 = (cf.Position - hrp.Position).Magnitude;
					local ts = game:GetService("TweenService");
					_vTweenObj = ts:Create(_vTweenPart, TweenInfo.new(math.max(0.1, dist2/speed), Enum.EasingStyle.Linear), {CFrame=cf});
					_vMoving = true;
					_vTweenObj:Play();
				end;
			else stuckT=0; end;
		end;
		lastPos = hrp.Position;
	end;
	_vStopTween(); return false;
end;

local _vBoatTweenObj  = nil;
local _vBoatSyncConn  = nil;
local _vBoatDone      = true;

local function _vStopBoat()
	_vBoatDone = true;
	if _vBoatSyncConn then _vBoatSyncConn:Disconnect(); _vBoatSyncConn=nil; end;
	if _vBoatTweenObj and _vBoatTweenObj.PlaybackState==Enum.PlaybackState.Playing then
		pcall(function() _vBoatTweenObj:Cancel(); end);
	end;
	_vBoatTweenObj=nil;
end;

local function _vLaunchBoatTween(seat, destCF)
	_vStopBoat();
	local dist = (seat.Position - destCF.Position).Magnitude;
	if dist < 30 then return; end;
	local speed = _G.SetSpeedBoat or _G.Settings.SeaEvent["Boat Tween Speed"] or _V.BOAT_SPEED;
	local dest  = CFrame.new(destCF.Position.X, seat.Position.Y, destCF.Position.Z);
	local ts = game:GetService("TweenService");
	local rs = game:GetService("RunService");
	_vBoatDone = false;
	_vBoatTweenObj = ts:Create(seat, TweenInfo.new(dist/speed, Enum.EasingStyle.Linear), {CFrame=dest});
	_vBoatSyncConn = rs.Heartbeat:Connect(function()
		if _vBoatDone then if _vBoatSyncConn then _vBoatSyncConn:Disconnect(); _vBoatSyncConn=nil; end; return; end;
		pcall(function()
			local ch  = game.Players.LocalPlayer.Character;
			local hrp = ch and ch:FindFirstChild("HumanoidRootPart");
			local hum = ch and ch:FindFirstChildOfClass("Humanoid");
			if not hrp or not hum then return; end;
			hrp.CFrame = seat.CFrame * CFrame.new(0, 1.5, 0);
		end);
	end);
	_vBoatTweenObj:Play();
	_vBoatTweenObj.Completed:Connect(function() _vStopBoat(); end);
end;

local function _vGetMat(name)
	local n=0;
	pcall(function()
		for _, v in pairs(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")) do
			if type(v)=="table" and v.Name==name then n=tonumber(v.Count) or 0; break; end;
		end;
	end);
	return n;
end;

local function _vHasItem(name)
	local ok=false;
	pcall(function()
		for _, v in pairs(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")) do
			if type(v)=="table" and v.Name==name then ok=true; break; end;
		end;
		if not ok then
			if game.Players.LocalPlayer.Backpack:FindFirstChild(name) then ok=true; end;
			local ch=game.Players.LocalPlayer.Character;
			if ch and ch:FindFirstChild(name) then ok=true; end;
		end;
	end);
	return ok;
end;

local function _vSendKey(k)
	local vim = game:GetService("VirtualInputManager");
	pcall(function() vim:SendKeyEvent(true,  k, false, game); task.wait(0.05); vim:SendKeyEvent(false, k, false, game); end);
end;

local function _vUseAllSkills()
	for _, k in pairs({"Z","X","C","V","F"}) do _vSendKey(k); end;
	Attack(); task.wait(0.1);
end;

local function _vUseEquippedSkills(toolTip)
	pcall(function()
		local plr = game.Players.LocalPlayer;
		for _, t in pairs(plr.Backpack:GetChildren()) do
			if t:IsA("Tool") and t.ToolTip==toolTip then
				plr.Character.Humanoid:EquipTool(t);
				for _, k in pairs({"Z","X","C","V","F"}) do _vSendKey(k); end;
				t.Parent = plr.Backpack;
				break;
			end;
		end;
	end);
	Attack(); task.wait(0.1);
end;

local function _vRemoveLava()
	pcall(function()
		local island = workspace.Map:FindFirstChild("PrehistoricIsland");
		if not island then return; end;
		local il = island:FindFirstChild("Core") and island.Core:FindFirstChild("InteriorLava");
		if il then il:Destroy(); end;
		for _, obj in pairs(island:GetDescendants()) do
			pcall(function()
				if (obj:IsA("BasePart") or obj:IsA("MeshPart")) and obj.Name:lower():find("lava") then
					obj:Destroy();
				end;
			end);
		end;
		local trial = island:FindFirstChild("TrialTeleport");
		for _, obj in pairs(island:GetDescendants()) do
			pcall(function()
				if obj.Name=="TouchInterest" and not (trial and obj:IsDescendantOf(trial)) then
					obj.Parent:Destroy();
				end;
			end);
		end;
	end);
end;

local function _vGetActiveVolcanoRock()
	local rock = nil;
	pcall(function()
		local vr = workspace.Map.PrehistoricIsland.Core.VolcanoRocks;
		for _, m in pairs(vr:GetChildren()) do
			if m:IsA("Model") then
				local vrock = m:FindFirstChild("volcanorock");
				if vrock and vrock:IsA("MeshPart") then
					local col = vrock.Color;
					if col == Color3.fromRGB(185,53,56) or col == Color3.fromRGB(185,53,57) then
						rock = vrock; return;
					end;
				end;
				local vfx = m:FindFirstChild("VFXLayer");
				local at0 = vfx and vfx:FindFirstChild("At0");
				local glow = at0 and at0:FindFirstChild("Glow");
				if glow and glow.Enabled then rock = vfx; return; end;
			end;
		end;
	end);
	return rock;
end;

local function _vGetGolem()
	for _, name in pairs(_V.GOLEM_NAMES) do
		for _, v in pairs(workspace.Enemies:GetChildren()) do
			if v.Name==name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
				return v;
			end;
		end;
	end;
	return nil;
end;

local function _vBuyBoat()
	local boatName = _G.VolcanicSelectedBoat or "Guardian";
	if workspace.Boats:FindFirstChild(boatName) then return; end;
	_vStopTween(); shouldTween=false; _G.StopTween=true; task.wait(0.1);
	local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
	if hrp and (hrp.Position - _V.TIKI_CF.Position).Magnitude > 80 then
		hrp.CFrame = _V.TIKI_CF; task.wait(0.5);
	end;
	game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", boatName);
	task.wait(2);
end;

local function _vSailToIsland(timeout)
	timeout = timeout or 700;
	_vStopBoat(); _vStopTween(); shouldTween=false; _G.StopTween=true; task.wait(0.1);
	local boatName  = _G.VolcanicSelectedBoat or "Guardian";
	local elapsed   = 0;
	local stuckT    = 0;
	local lastBPos  = nil;

	while _G.FullyVolcanicActive
		and not workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island")
		and elapsed < timeout do
		task.wait(1); elapsed=elapsed+1;
		pcall(function()
			local ch   = game.Players.LocalPlayer.Character;
			local hrp  = ch and ch:FindFirstChild("HumanoidRootPart");
			local hum  = ch and ch:FindFirstChildOfClass("Humanoid");
			if not hrp or not hum then return; end;
			local boat = workspace.Boats:FindFirstChild(boatName);
			if not boat then
				_vStopBoat();
				if (hrp.Position - _V.TIKI_CF.Position).Magnitude > 300 then hrp.CFrame = _V.TIKI_CF; task.wait(0.5); end;
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", boatName);
				task.wait(2); return;
			end;
			local seat = boat:FindFirstChildWhichIsA("VehicleSeat") or boat:FindFirstChild("VehicleSeat");
			if not seat then return; end;
			pcall(function() seat.MaxSpeed=_G.SetSpeedBoat or _G.Settings.SeaEvent["Boat Tween Speed"] or _V.BOAT_SPEED; seat.Torque=20; seat.TurnSpeed=8; end);
			if not hum.Sit then
				_vStopBoat();
				hrp.CFrame = seat.CFrame * CFrame.new(0, 1.5, 0); task.wait(0.5);
				hrp.CFrame = seat.CFrame * CFrame.new(0, 1.5, 0); task.wait(0.5);
			else
				if _vBoatDone then _vLaunchBoatTween(seat, _V.SAIL_CF); end;
				local bPos = seat.Position;
				if lastBPos then
					if (bPos - lastBPos).Magnitude < 3 then
						stuckT=stuckT+1;
						if stuckT >= 4 then stuckT=0; _vStopBoat(); _vLaunchBoatTween(seat, _V.SAIL_CF); end;
					else stuckT=0; end;
				end;
				lastBPos = bPos;
			end;
		end);
	end;
	_vStopBoat();
end;

local function _vBackToDojo()
	local ok=false;
	pcall(function()
		for _, grp in pairs(game.Players.LocalPlayer.PlayerGui.Notifications:GetChildren()) do
			local function checkText(t)
				if t and (t:find("Head back to the Dojo") or t:find("Task completed")) then ok=true; end;
			end;
			if grp.Name=="NotificationTemplate" then
				checkText(grp.Text);
				for _, n in pairs(grp:GetChildren()) do if n.Text then checkText(n.Text); end; end;
			end;
			for _, n in pairs(grp:GetChildren()) do if n.Text then checkText(n.Text); end; end;
		end;
	end);
	return ok;
end;

local function _vCheckQuestText()
	local text="";
	pcall(function()
		local res = game.ReplicatedStorage.Modules.Net:WaitForChild("RF/DragonHunter"):InvokeServer({Context="Check"});
		if res then
			for k,v in pairs(res) do if k=="Text" then text=tostring(v); break; end; end;
		end;
	end);
	return text;
end;

local function _vIsOnQuest()
	local t = _vCheckQuestText();
	return t:find("Venomous") or t:find("Hydra") or t:find("Destroy") or t:find("tree");
end;

local function _vRequestQuest()
	_vWalkTo(_V.DRAGON_CF, 20, 40);
	task.wait(0.5);
	pcall(function()
		game.ReplicatedStorage.Modules.Net:WaitForChild("RF/DragonHunter"):InvokeServer({Context="RequestQuest"});
	end);
	task.wait(1);
end;

local function _vStage1_ScrapMetal()
	local _vBringActive = true;
	task.spawn(function()
		while _G.FullyVolcanicActive and _vBringActive do
			pcall(function()
				_B = true;
				BringEnemy();
			end);
			task.wait(0.5);
		end;
	end);
	while _G.FullyVolcanicActive and _vGetMat("Scrap Metal") < 10 do
		pcall(function()
			local plr = game.Players.LocalPlayer;
			local qv  = false;
			pcall(function() qv = plr.PlayerGui.Main.Quest.Visible; end);
			if not qv then
				_vWalkTo(_V.JUNGLE_QUEST_CF, 25, 35);
				task.wait(0.4);
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest");
				task.wait(0.3);
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest","DeepForestIsland2",1);
				task.wait(0.5);
			else
				local found=false;
				for _, v in pairs(workspace.Enemies:GetChildren()) do
					if not _G.FullyVolcanicActive then break; end;
					if v.Name=="Jungle Pirate" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
						found=true;
						_vWalkTo(v.HumanoidRootPart.CFrame * CFrame.new(0,5,0), 12, 8);
						repeat
							if not _G.FullyVolcanicActive then break; end;
							task.wait(0.15);
							AutoHaki();
							EquipWeapon(_G.Settings.Main["Selected Weapon"]);
							pcall(function() v.Humanoid.WalkSpeed=0; v.HumanoidRootPart.CanCollide=false; end);
							Attack();
						until not _G.FullyVolcanicActive or not v.Parent or v.Humanoid.Health<=0 or _vGetMat("Scrap Metal")>=10;
						break;
					end;
				end;
				if not found then _vWalkTo(_V.JUNGLE_MOB_CF, 30, 20); end;
			end;
		end);
		task.wait(0.3);
	end;
	_vBringActive = false;
end;

local function _vStage2_BlazeEmber()

	local DRAGON_POS = CFrame.new(5864.86377, 1209.55066, 812.775024,
		0.879059196, 0.00000000381980803, 0.476712614,
		-0.0000000131110456, 1, 0.0000000161639893,
		-0.476712614, -0.0000000204593036, 0.879059196);
	local VSLT_POS   = CFrame.new(4789.29639, 1078.59082, 962.764099);
	local HYDRA_POS  = CFrame.new(4620.6157, 1002.2954, 399.0868);
	local SKY_HEIGHT = _G.Settings.Setting and _G.Settings.Setting["Farm Distance"] or 52;
	local VIM        = game:GetService("VirtualInputManager");

	local function _sk(k) pcall(function() VIM:SendKeyEvent(true,k,false,game); task.wait(0.05); VIM:SendKeyEvent(false,k,false,game); end); end;

	local function _equipAndSpam(toolTip)
		local plr = game.Players.LocalPlayer;
		local char = plr.Character; if not char then return; end;
		local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return; end;
		for _, t in pairs(plr.Backpack:GetChildren()) do
			if t:IsA("Tool") and t.ToolTip == toolTip then
				hum:EquipTool(t); task.wait(0.1);
				for _, k in pairs({"Z","X","C","V","F"}) do _sk(k); end;
				task.wait(0.1);
				break;
			end;
		end;
	end;

	local function _goToMobHeight(mobHRP)
		local myHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
		if not myHRP then return; end;
		local skyTarget = mobHRP.CFrame * CFrame.new(0, SKY_HEIGHT, 0);
		local dist = (myHRP.Position - skyTarget.Position).Magnitude;
		if dist > 8 then
			_vStartTween(skyTarget);
			local t = 0;
			while _G.FullyVolcanicActive and t < 10 do
				task.wait(0.15); t = t + 0.15;
				myHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
				if myHRP and (myHRP.Position - skyTarget.Position).Magnitude <= 12 then break; end;
			end;
		end;
	end;

	local function _getQuestText()
		local text = "";
		pcall(function()
			local RF  = game.ReplicatedStorage.Modules.Net:WaitForChild("RF/DragonHunter");
			local res = RF:InvokeServer({Context = "Check"});
			if res then for k,v in pairs(res) do if k=="Text" then text=tostring(v); break; end; end; end;
		end);
		return text;
	end;

	local function _requestAndGetQuest()
		local myHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
		if myHRP and (myHRP.Position - DRAGON_POS.Position).Magnitude > 25 then
			_vWalkTo(DRAGON_POS, 20, 40);
		end;
		task.wait(0.5);
		pcall(function()
			game.ReplicatedStorage.Modules.Net:WaitForChild("RF/DragonHunter"):InvokeServer({Context="RequestQuest"});
		end);
		local qt = ""; local tries = 0;
		while tries < 20 and _G.FullyVolcanicActive do
			task.wait(0.4);
			qt = _getQuestText();
			if qt:find("Venomous") or qt:find("Hydra") or qt:find("Destroy") or qt:find("tree") then break; end;
			tries = tries + 1;
		end;
		return qt;
	end;

	local function _backToDojo()
		local ok = false;
		pcall(function()
			for _, grp in pairs(game.Players.LocalPlayer.PlayerGui.Notifications:GetChildren()) do
				local function chk(t) if t and (t:find("Head back to the Dojo") or t:find("Task completed")) then ok=true; end; end;
				if grp.Name=="NotificationTemplate" then chk(grp.Text); end;
				for _, n in pairs(grp:GetChildren()) do if n.Text then chk(n.Text); end; end;
			end;
		end);
		return ok;
	end;

	local function _collectEmber()
		local t = 0;
		while _G.FullyVolcanicActive and t < 25 do
			local et = workspace:FindFirstChild("EmberTemplate") or workspace:FindFirstChild("AttachedAzureEmber");
			local part = et and et:FindFirstChild("Part");
			if part then
				_vStopTween();
				local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
				if hrp then hrp.CFrame = part.CFrame; end;
				task.wait(0.5); return;
			end;
			task.wait(0.5); t = t + 0.5;
		end;
	end;

	local function _killMob(mobName, spawnCF)
		local elapsed = 0;
		while _G.FullyVolcanicActive and not _backToDojo() and elapsed < 90 do
			elapsed = elapsed + 0.1;
			local mob = nil;
			local bestDist = math.huge;
			for _, v in pairs(workspace.Enemies:GetChildren()) do
				if v.Name == mobName and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
					local myHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
					local d = myHRP and (v.HumanoidRootPart.Position - myHRP.Position).Magnitude or 0;
					if d < bestDist then bestDist = d; mob = v; end;
				end;
			end;
			if mob then
				_goToMobHeight(mob.HumanoidRootPart);
				repeat
					if not _G.FullyVolcanicActive or _backToDojo() then break; end;
					task.wait(0.1);
					AutoHaki();
					pcall(function()
						mob.Humanoid.WalkSpeed = 0;
						mob.HumanoidRootPart.CanCollide = false;
						mob.HumanoidRootPart.Size = Vector3.new(1,1,1);
					end);
					pcall(function() sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge); end);
					EquipWeapon(_G.Settings.Main["Selected Weapon"]);
					Attack();
					pcall(function()
						local head = mob:FindFirstChild("Head") or mob:FindFirstChild("HumanoidRootPart");
						AttackModule:AttackEnemy(head, {});
					end);
				until not _G.FullyVolcanicActive
					or not mob.Parent
					or mob.Humanoid.Health <= 0
					or _backToDojo();
			else
				_vWalkTo(spawnCF, 25, 8);
				task.wait(0.3);
			end;
			task.wait(0.05);
		end;
	end;

	local function _destroyTrees()
		local elapsed = 0;
		while _G.FullyVolcanicActive and not _backToDojo() and elapsed < 120 do
			elapsed = elapsed + 0.3;
			local bamboo = nil;
			pcall(function() bamboo = workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true); end);
			local treePos = bamboo and bamboo.CFrame or nil;
			if not treePos then
				for _, cf in pairs(_V.TREE_CFS) do
					if not _G.FullyVolcanicActive or _backToDojo() then break; end;
					_vWalkTo(cf, 8, 10);
					task.wait(0.1);
					for _, tip in pairs({"Blox Fruit","Melee","Sword","Gun"}) do
						if _backToDojo() then break; end;
						_equipAndSpam(tip);
						task.wait(2);
					end;
				end;
				task.wait(0.2);
			else
				_vWalkTo(treePos, 8, 10);
				task.wait(0.1);
				local myHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
				if myHRP and (myHRP.Position - treePos.Position).Magnitude <= 200 then
					for _, tip in pairs({"Blox Fruit","Melee","Sword","Gun"}) do
						if not _G.FullyVolcanicActive or _backToDojo() then break; end;
						_equipAndSpam(tip);
						task.wait(2);
					end;
				end;
			end;
			task.wait(0.2);
		end;
	end;

	local _vBlazeBringActive = true;
	task.spawn(function()
		while _G.FullyVolcanicActive and _vBlazeBringActive do
			pcall(function()
				_B = true;
				BringEnemy();
			end);
			task.wait(0.5);
		end;
	end);

	while _G.FullyVolcanicActive and _vGetMat("Blaze Ember") < 15 do

		local qt = _getQuestText();
		local hasQuest = qt:find("Venomous") or qt:find("Hydra") or qt:find("Destroy") or qt:find("tree");
		if not hasQuest then qt = _requestAndGetQuest(); end;

		if qt:find("Venomous Assailant") then
			_killMob("Venomous Assailant", VSLT_POS);
		elseif qt:find("Hydra Enforcer") then
			_killMob("Hydra Enforcer", HYDRA_POS);
		elseif qt:find("Destroy") or qt:find("tree") then
			_destroyTrees();
		end;

		if _backToDojo() then
			_vStopTween();
			local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
			if hrp and (hrp.Position - DRAGON_POS.Position).Magnitude > 25 then hrp.CFrame = DRAGON_POS; end;
			task.wait(0.8);
			_collectEmber();
			task.wait(0.8);
		end;

		task.wait(0.2);
	end;
	_vBlazeBringActive = false;
end;

local function _vStage3_CraftMagnet()
	local DRAGON_NPC_CF = CFrame.new(5864.86377, 1209.55066, 812.775024);
	_vWalkTo(DRAGON_NPC_CF, 18, 45);
	local t2 = 0;
	while _G.FullyVolcanicActive and t2 < 5 do
		local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
		if hrp and (hrp.Position - DRAGON_NPC_CF.Position).Magnitude <= 25 then break; end;
		task.wait(0.5); t2 = t2 + 0.5;
	end;
	task.wait(0.8);
	local tries = 0;
	repeat
		tries = tries + 1;
		pcall(function()
			local args = {[1]="CraftItem",[2]="Craft",[3]="Volcanic Magnet"};
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args));
		end);
		task.wait(0.5);
		pcall(function()
			game.ReplicatedStorage.Modules.Net:WaitForChild("RF/Craft"):InvokeServer("PossibleHardcode","Volcanic Magnet");
		end);
		task.wait(0.5);
		pcall(function()
			game.ReplicatedStorage.Modules.Net:WaitForChild("RF/Craft"):InvokeServer("Craft","Volcanic Magnet",{});
		end);
		task.wait(0.5);
		pcall(function()
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CraftItem","Craft","Volcanic Magnet");
		end);
		task.wait(1);
	until _vHasItem("Volcanic Magnet") or tries >= 12 or not _G.FullyVolcanicActive;
end;

local function _vStage4_GoToIsland()
	_vStopBoat(); task.wait(0.5);
	pcall(function()
		local ch  = game.Players.LocalPlayer.Character;
		local hum = ch and ch:FindFirstChildOfClass("Humanoid");
		if hum and hum.Sit then
			local attempts = 0;
			repeat
				attempts = attempts + 1;
				hum.Jump = true; task.wait(0.3);
				hum.Jump = true; task.wait(0.4);
				ch  = game.Players.LocalPlayer.Character;
				hum = ch and ch:FindFirstChildOfClass("Humanoid");
				if not hum or not hum.Sit then break; end;
				if attempts >= 4 then
					local hrp2 = ch:FindFirstChild("HumanoidRootPart");
					if hrp2 then hrp2.CFrame = hrp2.CFrame * CFrame.new(0, 5, 0); end;
				end;
			until (not hum or not hum.Sit) or attempts >= 10;
		end;
	end);
	task.wait(0.8);
	local loc = workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island");
	if loc then
		local head = loc:FindFirstChild("HeadTeleport",true) or loc:FindFirstChild("Teleport_Head",true) or loc:FindFirstChild("Head",true);
		local target;
		if head then
			target = CFrame.new(head.CFrame.Position + Vector3.new(0,3,0));
		else
			target = CFrame.new(loc.Position + Vector3.new(0,8,0));
		end;
		_vWalkTo(target, 35, 90);
	end;
end;

local function _vStage5_Raid()
	local raidStart  = os.time();
	local islandDone = false;
	local VIM  = game:GetService("VirtualInputManager");
	local plr  = game.Players.LocalPlayer;
	local RE   = game.ReplicatedStorage;

	local function _sk(k)
		pcall(function()
			VIM:SendKeyEvent(true, k, false, game);
			task.wait(0.04);
			VIM:SendKeyEvent(false, k, false, game);
		end);
	end;

	local function _hasTool(name)
		if plr.Backpack:FindFirstChild(name) then return true; end;
		local ch = plr.Character; return ch and ch:FindFirstChild(name) ~= nil;
	end;

	local function _equipTool(name)
		local ch  = plr.Character; if not ch then return false; end;
		local hum = ch:FindFirstChildOfClass("Humanoid"); if not hum then return false; end;
		if ch:FindFirstChild(name) then return true; end;
		local t = plr.Backpack:FindFirstChild(name);
		if t then hum:EquipTool(t); task.wait(0.06); return true; end;
		return false;
	end;

	local function _spamToolSkills(name)
		if not _hasTool(name) then return; end;
		_equipTool(name);
		for _, k in ipairs({"Z","X","C","V","F"}) do _sk(k); end;
		task.wait(0.04);
	end;

	local function _spamAllWeapons()
		for _, tip in ipairs({"Blox Fruit","Melee","Sword","Gun"}) do
			local ch = plr.Character; if not ch then break; end;
			local hum = ch:FindFirstChildOfClass("Humanoid"); if not hum then break; end;
			for _, t in ipairs(plr.Backpack:GetChildren()) do
				if t:IsA("Tool") and t.ToolTip == tip then
					hum:EquipTool(t); task.wait(0.04);
					for _, k in ipairs({"Z","X","C","V","F"}) do _sk(k); end;
					task.wait(0.04); break;
				end;
			end;
		end;
		if _hasTool("Skull Guitar") then
			_equipTool("Skull Guitar");
			_sk("Z"); _sk("X"); task.wait(0.04);
		end;
		if _hasTool("Dragon Storm") then
			_equipTool("Dragon Storm");
			_sk("Z"); _sk("X"); task.wait(0.04);
		end;
		Attack();
	end;

	local function _getAllActiveRocks()
		local rocks = {};
		pcall(function()
			local vr = workspace.Map.PrehistoricIsland.Core.VolcanoRocks;
			for _, m in ipairs(vr:GetChildren()) do
				if not m:IsA("Model") then continue; end;
				local vrock = m:FindFirstChild("volcanorock");
				if vrock and vrock:IsA("MeshPart") then
					local col = vrock.Color;
					if col == Color3.fromRGB(185,53,56) or col == Color3.fromRGB(185,53,57) then
						table.insert(rocks, vrock);
					end;
				end;
				local vfx  = m:FindFirstChild("VFXLayer");
				local at0  = vfx and vfx:FindFirstChild("At0");
				local glow = at0 and at0:FindFirstChild("Glow");
				if glow and glow.Enabled then
					table.insert(rocks, vfx);
				end;
			end;
		end);
		return rocks;
	end;

	local function _getNearestRock(hrp)
		local rocks = _getAllActiveRocks();
		if #rocks == 0 then return nil; end;
		local best, bestD = rocks[1], math.huge;
		for _, r in ipairs(rocks) do
			local d = (r.Position - hrp.Position).Magnitude;
			if d < bestD then bestD = d; best = r; end;
		end;
		return best;
	end;

	local function _getAllGolems()
		local golems = {};
		for _, name in ipairs(_V.GOLEM_NAMES) do
			for _, v in ipairs(workspace.Enemies:GetChildren()) do
				if v.Name == name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
					table.insert(golems, v);
				end;
			end;
		end;
		return golems;
	end;

	local function _tweenTo(cf, thr)
		thr = thr or 10;
		_vStartTween(cf);
		local t = 0;
		repeat
			task.wait(0.1); t = t + 0.1;
			local hrp2 = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
			if hrp2 and (hrp2.Position - cf.Position).Magnitude <= thr then break; end;
		until t > 6 or not _G.FullyVolcanicActive or islandDone;
		_vStopTween();
	end;

	local function _removeLava()
		pcall(function()
			local island = workspace.Map:FindFirstChild("PrehistoricIsland");
			if not island then return; end;
			local il = island.Core:FindFirstChild("InteriorLava");
			if il then il:Destroy(); end;
			for _, obj in ipairs(island:GetDescendants()) do
				pcall(function()
					if (obj:IsA("BasePart") or obj:IsA("MeshPart")) and obj.Name:lower():find("lava") then obj:Destroy(); end;
				end);
			end;
			local trial = island:FindFirstChild("TrialTeleport");
			for _, obj in ipairs(island:GetDescendants()) do
				pcall(function()
					if obj.Name == "TouchInterest" and not (trial and obj:IsDescendantOf(trial)) then obj.Parent:Destroy(); end;
				end);
			end;
		end);
	end;

	local function _killGolemNow(golem)
		if not golem or not golem.Parent then return; end;
		pcall(function()
			golem.Humanoid.WalkSpeed   = 0;
			golem.HumanoidRootPart.CanCollide = false;
			golem.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
		end);
		pcall(function() sethiddenproperty(plr, "SimulationRadius", math.huge); end);
		AutoHaki();
		EquipWeapon(_G.Settings.Main["Selected Weapon"]);
		local head = golem:FindFirstChild("Head") or golem:FindFirstChild("HumanoidRootPart");
		local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
		if hrp then
			hrp.CFrame = golem.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0);
		end;
		for _ = 1, 12 do
			if not golem.Parent or golem.Humanoid.Health <= 0 then break; end;
			pcall(function()
				if golem:FindFirstChild("HumanoidRootPart") and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					plr.Character.HumanoidRootPart.CFrame = golem.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0);
					plr.Character.HumanoidRootPart.Velocity = Vector3.zero;
				end;
				golem.Humanoid.WalkSpeed = 0;
				golem.HumanoidRootPart.CanCollide = false;
			end);
			pcall(function() AttackModule:AttackEnemy(head, {}); end);
			if G and G.Kill then G.Kill(golem, true); end;
			_spamAllWeapons();
			task.wait(0.07);
		end;
	end;

	task.wait(1);
	pcall(function()
		local island = workspace.Map:FindFirstChild("PrehistoricIsland");
		if not island then return; end;
		local core = island:FindFirstChild("Core");
		local act  = core and (core:FindFirstChild("ActivationPrompt") or core:FindFirstChild("ActivationPrompt", true));
		if act then
			local pp = act:FindFirstChildOfClass("ProximityPrompt") or act:FindFirstChild("ProximityPrompt");
			if pp then
				local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
				if hrp and (hrp.Position - act.CFrame.Position).Magnitude > 120 then
					_tweenTo(act.CFrame, 20);
				end;
				fireproximityprompt(pp, math.huge);
				task.wait(0.5);
			end;
		end;
	end);
	task.wait(2);

	local _golemKillConn = workspace.Enemies.ChildAdded:Connect(function(child)
		if islandDone or not _G.FullyVolcanicActive then return; end;
		for _, name in ipairs(_V.GOLEM_NAMES) do
			if child.Name == name then
				task.spawn(function()
					task.wait(0.2);
					_killGolemNow(child);
				end);
				break;
			end;
		end;
	end);

	task.spawn(function()
		while _G.FullyVolcanicActive and not islandDone do
			_removeLava();
			task.wait(0.3);
		end;
	end);

	task.spawn(function()
		while _G.FullyVolcanicActive and not islandDone do
			pcall(function()
				local golems = _getAllGolems();
				for _, golem in ipairs(golems) do
					if not _G.FullyVolcanicActive or islandDone then break; end;
					pcall(function()
						golem.Humanoid.WalkSpeed = 0;
						golem.HumanoidRootPart.CanCollide = false;
					end);
					pcall(function() sethiddenproperty(plr, "SimulationRadius", math.huge); end);
					local head = golem:FindFirstChild("Head") or golem:FindFirstChild("HumanoidRootPart");
					pcall(function() AttackModule:AttackEnemy(head, {}); end);
					_spamAllWeapons();
				end;
			end);
			task.wait(0.15);
		end;
	end);

	while _G.FullyVolcanicActive and not islandDone do
		pcall(function()
			local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
			if not hrp then return; end;

			local rock = _getNearestRock(hrp);
			if rock then
				local dist = (hrp.Position - rock.Position).Magnitude;
				if dist > 12 then
					_tweenTo(CFrame.new(rock.Position), 10);
				end;
				hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
				if hrp and (hrp.Position - rock.Position).Magnitude <= 120 then
					AutoHaki();
					EquipWeapon(_G.Settings.Main["Selected Weapon"]);
					_spamAllWeapons();
					pcall(function() AttackModule:AttackEnemy(rock, {}); end);
				end;
			else
				local golems = _getAllGolems();
				if #golems > 0 then
					local golem = golems[1];
					local nearest = golem;
					local nearestD = math.huge;
					for _, g in ipairs(golems) do
						local d = (g.HumanoidRootPart.Position - hrp.Position).Magnitude;
						if d < nearestD then nearestD = d; nearest = g; end;
					end;
					golem = nearest;
					pcall(function() golem.Humanoid.WalkSpeed=0; golem.HumanoidRootPart.CanCollide=false; golem.HumanoidRootPart.Size=Vector3.new(50,50,50); end);
					pcall(function() sethiddenproperty(plr, "SimulationRadius", math.huge); end);
					PosMon = golem.HumanoidRootPart.Position;
					MonFarm = golem.Name;
					_B = true; BringEnemy();
					hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
					if hrp then
						hrp.CFrame = golem.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0);
						hrp.Velocity = Vector3.zero;
					end;
					AutoHaki();
					EquipWeapon(_G.Settings.Main["Selected Weapon"]);
					_spamAllWeapons();
					local head = golem:FindFirstChild("Head") or golem:FindFirstChild("HumanoidRootPart");
					pcall(function() AttackModule:AttackEnemy(head, {}); end);
					if G and G.Kill then G.Kill(golem, true); end;
				else
					pcall(function()
						local island2 = workspace.Map:FindFirstChild("PrehistoricIsland");
						local trial   = island2 and island2:FindFirstChild("TrialTeleport");
						local skull   = island2 and island2:FindFirstChild("Core")
							and island2.Core:FindFirstChild("PrehistoricRelic")
							and island2.Core.PrehistoricRelic:FindFirstChild("Skull");
						if trial and trial:IsA("BasePart") then
							_vStartTween(CFrame.new(trial.Position + Vector3.new(0,5,0)));
						elseif skull then
							_vStartTween(CFrame.new(skull.Position + Vector3.new(0,5,0)));
						end;
					end);
					task.wait(0.4);
				end;
			end;

			if not workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") and (os.time()-raidStart) > 30 then
				islandDone = true;
			end;
			if (os.time()-raidStart) >= 360 then islandDone = true; end;
		end);
		task.wait(0.1);
	end;

	islandDone = true;
	pcall(function() _golemKillConn:Disconnect(); end);
	_vStopTween();

	pcall(function()
		local island = workspace.Map:FindFirstChild("PrehistoricIsland");
		local trial  = island and island:FindFirstChild("TrialTeleport");
		local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
		if hrp and trial and trial:IsA("BasePart") then
			hrp.CFrame = CFrame.new(trial.Position + Vector3.new(0,6,0));
		end;
	end);
	task.wait(1);

	if _G.VolcanicCollectEgg and _G.FullyVolcanicActive then
		Library:Notify({Title="Volcanic Kaitun", Content="Coletando Dragon Egg...", Icon="egg", Duration=4});
		local et=0; local eggDone=false;
		while _G.FullyVolcanicActive and et<40 and not eggDone do
			pcall(function()
				local island = workspace.Map:FindFirstChild("PrehistoricIsland");
				local se = island and island:FindFirstChild("Core") and island.Core:FindFirstChild("SpawnedDragonEggs");
				if se then
					local eggs = se:GetChildren();
					if #eggs > 0 then
						local egg = eggs[1];
						if egg:IsA("Model") then
							local molten = egg:FindFirstChild("Molten");
							local pp = molten and (molten:FindFirstChildOfClass("ProximityPrompt") or molten:FindFirstChild("ProximityPrompt"));
							if molten then
								local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
								if hrp then hrp.CFrame = molten.CFrame; end;
								task.wait(0.3);
								if pp then fireproximityprompt(pp, 30); end;
								pcall(function()
									RE.Modules.Net["RE/CollectedDragonEgg"]:FireServer();
								end);
								pcall(function() VIM:SendKeyEvent(true,"E",false,game); task.wait(1); VIM:SendKeyEvent(false,"E",false,game); end);
								task.wait(0.5); eggDone = true;
							end;
						end;
					end;
				end;
			end);
			task.wait(1); et = et + 1;
		end;
	end;

	if _G.VolcanicCollectBone and _G.FullyVolcanicActive then
		Library:Notify({Title="Volcanic Kaitun", Content="Coletando Dino Bones...", Icon="box", Duration=4});
		local bt=0;
		while _G.FullyVolcanicActive and bt<30 do
			pcall(function()
				for _, v in ipairs(workspace:GetDescendants()) do
					if v:IsA("BasePart") and v.Name=="DinoBone" then
						local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
						if hrp then hrp.CFrame = CFrame.new(v.Position); end;
						task.wait(0.3);
					end;
				end;
			end);
			task.wait(1); bt = bt + 1;
		end;
	end;
end;

local _volcanicMainLoop;
_volcanicMainLoop = function()
	while _G.FullyVolcanicActive do

		local hasMagnet = _vHasItem("Volcanic Magnet");

		if not hasMagnet then
			_G._volcanicPhase = "scrap";
			if _vGetMat("Scrap Metal") < 10 then
				Library:Notify({Title="Volcanic Kaitun", Content="[1/9] Farmando Scrap Metal (".. _vGetMat("Scrap Metal") .."/10)...", Icon="pickaxe", Duration=4});
				local scrapTries = 0;
				while _G.FullyVolcanicActive and _vGetMat("Scrap Metal") < 10 and scrapTries < 6 do
					_vStage1_ScrapMetal(); scrapTries = scrapTries + 1; task.wait(0.5);
				end;
			end;
			if not _G.FullyVolcanicActive then break; end;

			_G._volcanicPhase = "blaze";
			if _vGetMat("Blaze Ember") < 15 then
				Library:Notify({Title="Volcanic Kaitun", Content="[2/9] Farmando Blaze Ember (".. _vGetMat("Blaze Ember") .."/15)...", Icon="flame", Duration=4});
				local blazeTries = 0;
				_G.Settings.DragonDojo["Auto Farm Blaze Ember"] = true;
				_G.OnBlzeQuest = false;
				while _G.FullyVolcanicActive and _vGetMat("Blaze Ember") < 15 and blazeTries < 12 do
					_vStage2_BlazeEmber(); blazeTries = blazeTries + 1; task.wait(0.5);
				end;
				_G.Settings.DragonDojo["Auto Farm Blaze Ember"] = false;
				_G.OnBlzeQuest = false;
			end;
			if not _G.FullyVolcanicActive then break; end;

			_G._volcanicPhase = "craft";
			Library:Notify({Title="Volcanic Kaitun", Content="[3/9] Craftando Volcanic Magnet...", Icon="hammer", Duration=4});
			_vStage3_CraftMagnet();
			if not _G.FullyVolcanicActive then break; end;
			hasMagnet = _vHasItem("Volcanic Magnet");
			if not hasMagnet then task.wait(1); continue; end;
			Library:Notify({Title="Volcanic Kaitun", Content="[3/9] Volcanic Magnet craftado!", Icon="check", Duration=3});
		end;

		if not workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
			_G._volcanicPhase = "sailing";
			Library:Notify({Title="Volcanic Kaitun", Content="[4/9] Indo ate Tiki Outpost e navegando para o Mar 6+...", Icon="anchor", Duration=5});
			_vStopTween();
			shouldTween = false; _G.StopTween = true;
			local boatName = _G.VolcanicSelectedBoat or "Guardian";
			local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
			if hrp and (hrp.Position - _V.TIKI_CF.Position).Magnitude > 80 then
				_vWalkTo(_V.TIKI_CF, 30, 60);
			end;
			if not workspace.Boats:FindFirstChild(boatName) then
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", boatName);
				task.wait(2);
			end;
			Library:Notify({Title="Volcanic Kaitun", Content="[5/9] Navegando... aguardando spawn da Prehistoric Island...", Icon="ship", Duration=6});
			_vSailToIsland(700);
		end;
		if not _G.FullyVolcanicActive then break; end;

		if workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
			Library:Notify({Title="Volcanic Kaitun", Content="[6/9] Prehistoric Island detectada! Indo ate ela via Tween...", Icon="map-pin", Duration=4});
			_G._volcanicPhase = "tweening";
			_vStage4_GoToIsland();
			Library:Notify({Title="Volcanic Kaitun", Content="[7/9] Na ilha! Ativando raid do vulcao...", Icon="zap", Duration=3});
		end;
		if not _G.FullyVolcanicActive then break; end;

		_G._volcanicPhase = "solving";
		Library:Notify({Title="Volcanic Kaitun", Content="[8/9] RAID ATIVA! Fechando buracos + Kill Golems...", Icon="shield", Duration=5});
		_vStage5_Raid();
		if not _G.FullyVolcanicActive then break; end;

		Library:Notify({Title="Volcanic Kaitun", Content="[9/9] FULLY VOLCANIC SOLADO! Aguardando reset...", Icon="trophy", Duration=8});
		_G._volcanicPhase = "resetting";
		if _G.VolcanicAutoReset then
			local t = 0;
			while t < 10 and _G.FullyVolcanicActive and _G.VolcanicAutoReset do task.wait(1); t = t + 1; end;
			if _G.FullyVolcanicActive and _G.VolcanicAutoReset then
				Library:Notify({Title="Volcanic Kaitun", Content="Resetando personagem para novo ciclo...", Icon="refresh-cw", Duration=3});
				pcall(function()
					local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
					if hum then hum.Health = 0; end;
				end);
				task.wait(4.5);
				_G._volcanicPhase = "idle";
			else break; end;
		else
			_G.FullyVolcanicActive = false;
			_G._volcanicPhase = "idle";
			break;
		end;
	end;

	_vStopBoat(); _vStopTween();
	if _vHB then pcall(function() _vHB:Disconnect(); end); _vHB=nil; end;
	shouldTween=false; _G.StopTween=false;
	_G._volcanicPhase = "idle";
	Library:Notify({Title="Volcanic Kaitun", Content="Auto Fully Volcanic desativado.", Icon="x", Duration=4});
end;


MultiFarmTab:AddSection("PRE HISTORIC KAITUN");

MultiFarmTab:AddDropdown({
	Title   = "Boat Selection",
	Desc    = "Barco para navegar ate a Prehistoric Island",
	Options = {"Guardian","Patrol Boat","Speedboat","Upgraded Boat","Cannon Raft"},
	CurrentOption = {_G.VolcanicSelectedBoat or "Guardian"},
	Callback = function(sel)
		_G.VolcanicSelectedBoat = sel[1] or "Guardian";
		if _G.Settings and _G.Settings.Multi then
			_G.Settings.Multi["Volcanic Selected Boat"] = _G.VolcanicSelectedBoat;
			(getgenv()).SaveSetting();
		end;
	end
});

MultiFarmTab:AddToggle({
	Title = "Auto Fully Volcanic",
	Desc  = "Scrap Metal → Blaze Ember (kill + tree) → Craft Magnet → Navega → Raid → Coleta → Reset.",
	Value = _G.Settings.Multi and _G.Settings.Multi["Auto Fully Volcanic"] or false,
	Callback = function(state)
		_G.FullyVolcanicActive = state;
		if _G.Settings and _G.Settings.Multi then
			_G.Settings.Multi["Auto Fully Volcanic"] = state; (getgenv()).SaveSetting();
		end;
		if state then
			task.spawn(_volcanicMainLoop);
		else
			_vStopBoat(); _vStopTween();
			if _vHB then pcall(function() _vHB:Disconnect(); end); _vHB=nil; end;
			shouldTween=false; _G.StopTween=false;
			_G._volcanicPhase = "idle";
		end;
	end
});

MultiFarmTab:AddToggle({
	Title = "Auto Reset After Complete",
	Desc  = "Espera 10s e reseta apos a raid.",
	Value = _G.Settings.Multi and _G.Settings.Multi["Auto Reset After Complete"] or false,
	Callback = function(state)
		_G.VolcanicAutoReset = state;
		if _G.Settings and _G.Settings.Multi then
			_G.Settings.Multi["Auto Reset After Complete"] = state; (getgenv()).SaveSetting();
		end;
	end
});

MultiFarmTab:AddToggle({
	Title = "Auto Collect Egg",
	Desc  = "Coleta Dragon Egg apos raid.",
	Value = _G.Settings.Multi and _G.Settings.Multi["Auto Collect Egg"] or false,
	Callback = function(state)
		_G.VolcanicCollectEgg = state;
		if _G.Settings and _G.Settings.Multi then
			_G.Settings.Multi["Auto Collect Egg"] = state; (getgenv()).SaveSetting();
		end;
	end
});

MultiFarmTab:AddToggle({
	Title = "Auto Collect Bone",
	Desc  = "Coleta DinoBones apos raid.",
	Value = _G.Settings.Multi and _G.Settings.Multi["Auto Collect Bone"] or false,
	Callback = function(state)
		_G.VolcanicCollectBone = state;
		if _G.Settings and _G.Settings.Multi then
			_G.Settings.Multi["Auto Collect Bone"] = state; (getgenv()).SaveSetting();
		end;
	end
});

MultiFarmTab:AddButton({
	Title = "Remove Lava (Manual)",
	Desc  = "Remove toda a lava da Prehistoric Island agora.",
	Callback = function()
		pcall(function()
			for _, v in pairs(workspace:GetDescendants()) do
				if v.Name == "Lava" or v.Name == "LavaPart" then pcall(function() v:Destroy(); end); end;
			end;
			for _, v in pairs(game.ReplicatedStorage:GetDescendants()) do
				if v.Name == "Lava" then pcall(function() v:Destroy(); end); end;
			end;
			local island = workspace.Map:FindFirstChild("PrehistoricIsland");
			if island then
				local il = island:FindFirstChild("Core") and island.Core:FindFirstChild("InteriorLava");
				if il then il:Destroy(); end;
				for _, obj in pairs(island:GetDescendants()) do
					pcall(function()
						if (obj:IsA("Part") or obj:IsA("MeshPart")) and (obj.Name:lower():find("lava") or obj.Name:lower():find("magma")) then
							obj:Destroy();
						end;
					end);
				end;
			end;
		end);
		Library:Notify({Title="Volcanic", Content="Lava removida!", Icon="check", Duration=3});
	end
});

task.spawn(function()
	task.wait(3);
	if _G.Settings.Multi and _G.Settings.Multi["Auto Fully Volcanic"] then
		_G.FullyVolcanicActive = true;
		_G.VolcanicAutoReset   = _G.Settings.Multi["Auto Reset After Complete"] or false;
		_G.VolcanicCollectEgg  = _G.Settings.Multi["Auto Collect Egg"] or false;
		_G.VolcanicCollectBone = _G.Settings.Multi["Auto Collect Bone"] or false;
		task.spawn(_volcanicMainLoop);
	end;
end);

task.spawn(function()
	local plr = game.Players.LocalPlayer;
	plr.CharacterAdded:Connect(function(char)
		if not _G.FullyVolcanicActive then return; end;
		if _G._volcanicPhase == "idle" then return; end;
		task.wait(4);
		if not _G.FullyVolcanicActive then return; end;
		Library:Notify({Title="Volcanic Kaitun", Content="Personagem ressurgiu - retomando ciclo...", Icon="refresh-cw", Duration=4});
		task.spawn(_volcanicMainLoop);
	end);
end);

task.spawn(function()
	while task.wait(1) do
		pcall(function()
			if not _G.VolcanicAutoReset then return; end;
			local island = workspace.Map:FindFirstChild("PrehistoricIsland");
			if not island then return; end;
			local trial = island:FindFirstChild("TrialTeleport");
			if not trial then return; end;
			local eventEnded = trial:FindFirstChild("TouchInterest");
			if not eventEnded then return; end;
			if _G.FullyVolcanicActive then return; end;
			task.wait(4.5);
			local shouldWait = true;
			while shouldWait do
				shouldWait = false;
				if _G.VolcanicCollectEgg then
					local se = island:FindFirstChild("Core") and island.Core:FindFirstChild("SpawnedDragonEggs");
					if se and se:FindFirstChild("DragonEgg") then shouldWait = true; end;
				end;
				if _G.VolcanicCollectBone and workspace:FindFirstChild("DinoBone") then
					shouldWait = true;
				end;
				if shouldWait then task.wait(0.5); end;
			end;
			local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
			if hum then hum.Health = 0; end;
		end);
	end;
end);


MultiFarmTab:AddSection("DUNGEON KAITUN");
_G.Settings.Main = _G.Settings.Main or {};
_G.Settings.Main["Auto Fully Dungeon"] = _G.Settings.Main["Auto Fully Dungeon"] or false;

MultiFarmTab:AddParagraph({
	Title = "Auto Fully Dungeon",
	Desc = "Entra na Dungeon, derrota todos os NPCs de cada Floor (incluindo Kitsune F10 e Gas F15), faz Skip Hub e repete. Funciona apenas na Dungeon World (Place ID: 73902483975735)."
});

local _AutoFullyDungeonToggle = MultiFarmTab:AddToggle({
	Title = "Auto Fully Dungeon",
	Desc = "Liga/desliga o ciclo completo de Dungeon automático.",
	Value = _G.Settings.Main["Auto Fully Dungeon"],
	Callback = function(state)
		_G.Settings.Main["Auto Fully Dungeon"] = state;
		if getgenv().DungeonConfig then
			getgenv().DungeonConfig.AutoFully = state;
			getgenv().DungeonConfig.AutoEnter    = state;
			getgenv().DungeonConfig.AutoComplete = state;
			getgenv().DungeonConfig.AutoSkipHub  = state;
			getgenv().DungeonConfig.SelectBuffs  = state;
		end;
		(getgenv()).SaveSetting();
	end
});

task.spawn(function()
	task.wait(3);
	if _G.Settings.Main["Auto Fully Dungeon"] then
		if getgenv().DungeonConfig then
			getgenv().DungeonConfig.AutoFully   = true;
			getgenv().DungeonConfig.AutoEnter   = true;
			getgenv().DungeonConfig.AutoComplete = true;
			getgenv().DungeonConfig.AutoSkipHub = true;
			getgenv().DungeonConfig.SelectBuffs = true;
		end;
		if _AutoFullyDungeonToggle and _AutoFullyDungeonToggle.SetStage then
			_AutoFullyDungeonToggle.SetStage(true);
		end;
		Library:Notify({Title = "Dungeon", Content = "Auto Fully Dungeon reativado automaticamente!", Icon = "zap", Duration = 4});
	end;
end);

task.spawn(function()
	local _DUNGEON_PID = 73902483975735;
	while true do
		task.wait(1);
		if not _G.Settings.Main["Auto Fully Dungeon"] then continue; end;
		if game.PlaceId ~= _DUNGEON_PID then
			Library:Notify({Title = "Auto Fully Dungeon", Content = "Não está na Dungeon World! Place ID: " .. _DUNGEON_PID, Icon = "alert-triangle", Duration = 5});
			task.wait(10);
			continue;
		end;
		pcall(function()
			if not (workspace:FindFirstChild("DungeonFloor") or workspace:FindFirstChild("FloorEnemies") or workspace:FindFirstChild("DungeonArea")) then
				if #game:GetService("Players"):GetPlayers() < 2 then return; end;
				for _, v in pairs(workspace:GetDescendants()) do
					local name = v.Name:lower();
					if (name:find("portal") or name:find("dungeon") or name:find("enter") or name:find("gate")) and v:IsA("BasePart") then
						TweenPlayer(v.CFrame * CFrame.new(0, 2, 0));
						task.wait(0.8);
						for _, pp in pairs(v:GetDescendants()) do
							if pp:IsA("ProximityPrompt") then pcall(function() fireproximityprompt(pp); end); end;
						end;
						local rep = game:GetService("ReplicatedStorage");
						local remote = rep:FindFirstChild("CommF_", true) or (rep.Remotes and rep.Remotes:FindFirstChild("CommF_"));
						if remote then
							pcall(function() remote:InvokeServer("EnterDungeon"); end);
							pcall(function() remote:InvokeServer("JoinDungeon"); end);
						end;
						break;
					end;
				end;
				return;
			end;

			local shrines = {};
			local leaks   = {};
			for _, v in pairs(workspace:GetDescendants()) do
				local name = v.Name:lower();
				if name:find("shrine") or (name:find("kitsune") and name:find("trap")) then
					if v:IsA("BasePart") or v:IsA("Model") then table.insert(shrines, v); end;
				end;
				if name:find("gas") or name:find("leak") then
					if v:IsA("BasePart") or v:IsA("Model") then table.insert(leaks, v); end;
				end;
			end;
			if #shrines > 0 then
				for _, sh in pairs(shrines) do
					local pos = sh:IsA("Model") and sh:GetPivot().Position or sh.Position;
					TweenPlayer(CFrame.new(pos.X, pos.Y + 15, pos.Z));
					task.wait(0.1);
					local vim = game:GetService("VirtualInputManager");
					for _, key in pairs({"Z","X","C","V","F"}) do
						pcall(function() vim:SendKeyEvent(true, key, false, game); task.wait(0.05); vim:SendKeyEvent(false, key, false, game); task.wait(0.03); end);
					end;
				end;
				return;
			end;
			if #leaks > 0 then
				for _, lk in pairs(leaks) do
					local pos = lk:IsA("Model") and lk:GetPivot().Position or lk.Position;
					TweenPlayer(CFrame.new(pos.X, pos.Y + 15, pos.Z));
					task.wait(0.1);
					local vim = game:GetService("VirtualInputManager");
					for _, key in pairs({"Z","X","C","V","F"}) do
						pcall(function() vim:SendKeyEvent(true, key, false, game); task.wait(0.05); vim:SendKeyEvent(false, key, false, game); task.wait(0.03); end);
					end;
				end;
				return;
			end;
			local enemyFolder = workspace:FindFirstChild("FloorEnemies") or workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("DungeonEnemies");
			if enemyFolder then
				for _, v in pairs(enemyFolder:GetChildren()) do
					if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						local hrp = v:FindFirstChild("HumanoidRootPart");
						if hrp then
							EquipWeapon(_G.Settings.Main["Selected Weapon"] or _G.SelectWeapon);
							TweenPlayer(hrp.CFrame * CFrame.new(0, 20, 0));
							task.wait(0.1);
							getgenv().UseConfiguredSkills(hrp.Position);
						end;
						return;
					end;
				end;
			end;
			local rep = game:GetService("ReplicatedStorage");
			local remote = rep:FindFirstChild("CommF_", true) or (rep.Remotes and rep.Remotes:FindFirstChild("CommF_"));
			if remote then
				pcall(function() remote:InvokeServer("NextFloor"); end);
				pcall(function() remote:InvokeServer("AdvanceFloor"); end);
			end;
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("ProximityPrompt") then
					local n = (v.ActionText or v.Name):lower();
					if n:find("next") or n:find("advance") or n:find("continue") or n:find("pass") then
						pcall(function() fireproximityprompt(v); end);
					end;
				end;
			end;

			local plrGui = game.Players.LocalPlayer.PlayerGui;
			for _, gui in pairs(plrGui:GetDescendants()) do
				if (gui:IsA("TextButton") or gui:IsA("ImageButton")) and gui.Visible then
					local t = (gui.Text or ""):lower();
					if t:find("skip") or t:find("lobby") or t:find("return") or t:find("continue") or t:find("next") then
						gui:Activate();
						task.wait(1);
					end;
				end;
			end;
		end);
	end;
end);


local _chestTweenActive = false;
local _chestTweenLastBeli = 0;
_chestTweenActive = false;
_chestBypassActive = false;
_G.ChestHopActive = false;
_G.ChestHopCount = 0;
_G.ChestHopLimit = 20;
_chestTweenLastBeli = 0;

local function _isSpecialChestItem()
	local result = false;
	pcall(function()
		local plr = game.Players.LocalPlayer;
		local function checkContainer(c)
			if not c then return; end;
			if c:FindFirstChild("Mysterious Treasure") then result = true; end;
			if c:FindFirstChild("First of Darkness") then result = true; end;
			if c:FindFirstChild("God's Chalice") then result = true; end;
		end;
		checkContainer(plr.Backpack);
		checkContainer(plr.Character);
	end);
	return result;
end;

AutoFarmChestTweenToggle = OthersTab:AddToggle({
	Title = "Auto Farm Chest Tween",
	Desc = "Tween preciso para cada bau. Confirma coleta via Beli antes de ir pro proximo.",
	Value = _G.Settings.Farm["Auto Farm Chest Tween"],
	Callback = function(state)
		_G.Settings.Farm["Auto Farm Chest Tween"] = state;
		_chestTweenActive = state;
		if not state then StopTween(false); end;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	local plr = game.Players.LocalPlayer;
	repeat task.wait() until plr.Data and plr.Data:FindFirstChild("Beli");
	plr.Data.Beli:GetPropertyChangedSignal("Value"):Connect(function()
		_chestTweenLastBeli = plr.Data.Beli.Value;
	end);
end);
task.spawn(function()
	while true do
		task.wait(0);
		if not _chestTweenActive then task.wait(0.2); continue; end;
		pcall(function()
			local plr = game.Players.LocalPlayer;
			local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
			if not hrp then return; end;
			if _isSpecialChestItem() then
				_chestTweenActive = false;
				_G.Settings.Farm["Auto Farm Chest Tween"] = false;
				Library:Notify({Title = "TRon Void Hub", Content = "Item especial encontrado! Auto Chest parado.", Icon = "bell", Duration = 6});
				return;
			end;
			local chests = {};
			for _, v in pairs(workspace.ChestModels:GetChildren()) do
				if v.Name:find("Chest") and v:FindFirstChild("RootPart") then
					local dist = (v.RootPart.Position - hrp.Position).Magnitude;
					table.insert(chests, {model = v, dist = dist});
				end;
			end;
			if #chests == 0 then task.wait(0.5); return; end;
			table.sort(chests, function(a, b) return a.dist < b.dist; end);
			for _, entry in ipairs(chests) do
				if not _chestTweenActive then break; end;
				local v = entry.model;
				if not v or not v.Parent or not v:FindFirstChild("RootPart") then continue; end;
				if _isSpecialChestItem() then
					_chestTweenActive = false;
					_G.Settings.Farm["Auto Farm Chest Tween"] = false;
					Library:Notify({Title = "TRon Void Hub", Content = "Item especial encontrado!", Icon = "bell", Duration = 6});
					break;
				end;
				local targetCF = v.RootPart.CFrame;
				local beliBefore = _chestTweenLastBeli;
				TweenPlayer(targetCF);
				local tw = 0;
				repeat
					task.wait(0.1); tw = tw + 0.1;
					hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
					if not hrp then break; end;
				until not _chestTweenActive or not v.Parent
					or _chestTweenLastBeli > beliBefore
					or (hrp and (hrp.Position - targetCF.Position).Magnitude < 5)
					or tw > 8;
				if v.Parent and _chestTweenLastBeli <= beliBefore then
					if hrp then hrp.CFrame = targetCF; end;
					task.wait(0.3);
				end;
				_G.ChestHopCount = _G.ChestHopCount + 1;
			end;
			if _G.ChestHopActive and _G.ChestHopCount >= _G.ChestHopLimit then
				_G.ChestHopCount = 0;
				Library:Notify({Title = "TRon Void Hub", Content = "Chest Hop: limite atingido, trocando server...", Icon = "bell", Duration = 4});
				task.wait(2);
				local module = (loadstring(game:HttpGet("https://raw.githubusercontent.com/raw-scriptpastebin/FE/main/Server_Hop_Settings")))();
				module:Teleport(game.PlaceId);
			end;
		end);
	end;
end);

local _chestBypassActive = false;
AutoFarmChestInstantToggle = OthersTab:AddToggle({
	Title = "Auto Farm Chest Bypass",
	Desc = "Teleporte instantaneo e preciso em cada bau. Aguarda confirmacao de coleta antes do proximo.",
	Value = _G.Settings.Farm["Auto Farm Chest Instant"],
	Callback = function(state)
		_G.Settings.Farm["Auto Farm Chest Instant"] = state;
		_chestBypassActive = state;
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while true do
		task.wait(0);
		if not _chestBypassActive then task.wait(0.2); continue; end;
		pcall(function()
			local plr = game.Players.LocalPlayer;
			local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
			if not hrp then return; end;
			if _isSpecialChestItem() then
				_chestBypassActive = false;
				_G.Settings.Farm["Auto Farm Chest Instant"] = false;
				Library:Notify({Title = "TRon Void Hub", Content = "Item especial encontrado! Chest Bypass parado.", Icon = "bell", Duration = 6});
				return;
			end;
			local chests = {};
			for _, v in pairs(workspace.ChestModels:GetChildren()) do
				if v and v.Parent and v.Name:find("Chest") and v:FindFirstChild("RootPart") then
					local dist = (v.RootPart.Position - hrp.Position).Magnitude;
					table.insert(chests, {model = v, dist = dist});
				end;
			end;
			if #chests == 0 then return; end;
			table.sort(chests, function(a, b) return a.dist < b.dist; end);
			local beli_ref = _chestTweenLastBeli;
			for _, entry in ipairs(chests) do
				if not _chestBypassActive then break; end;
				local v = entry.model;
				if not v or not v.Parent or not v:FindFirstChild("RootPart") then continue; end;
				if _isSpecialChestItem() then
					_chestBypassActive = false;
					_G.Settings.Farm["Auto Farm Chest Instant"] = false;
					break;
				end;
				local chestCF = v.RootPart.CFrame;
				local beliBefore = _chestTweenLastBeli;
				hrp.CFrame = chestCF;
				task.wait(0.03);
				local _VIM = game:GetService("VirtualInputManager");
				for _di = 1, 5 do
					pcall(function()
						_VIM:SendKeyEvent(true,  "Q", false, game);
						task.wait(0.02);
						_VIM:SendKeyEvent(false, "Q", false, game);
					end);
					task.wait(0.03);
				end;
				local timeout = 0;
				repeat
					task.wait(0.04); timeout = timeout + 0.04;
				until not _chestBypassActive or not v.Parent or _chestTweenLastBeli > beliBefore or timeout >= 1;
				if v.Parent and _chestTweenLastBeli <= beliBefore then
					hrp.CFrame = chestCF;
					task.wait(0.1);
				end;
				_G.ChestHopCount = _G.ChestHopCount + 1;
			end;
		end);
		if _chestBypassActive then
			local t = 0;
			while _chestBypassActive and t < 7 do task.wait(0.1); t = t + 0.1; end;
		end;
		if _G.ChestHopActive and _G.ChestHopCount >= _G.ChestHopLimit then
			_G.ChestHopCount = 0;
			Library:Notify({Title = "TRon Void Hub", Content = "Chest Hop: trocando server...", Icon = "bell", Duration = 4});
			task.wait(2);
			local module = (loadstring(game:HttpGet("https://raw.githubusercontent.com/raw-scriptpastebin/FE/main/Server_Hop_Settings")))();
			module:Teleport(game.PlaceId);
		end;
	end;
end);
OthersTab:AddToggle({
	Title = "Chest Hop",
	Desc = "Troca de servidor apos pegar X baus (define quantidade abaixo)",
	Value = false,
	Callback = function(state)
		_G.ChestHopActive = state;
		_G.ChestHopCount = 0;
	end
});
local _chestHopLimitOptions = {20,25,30,35,40,45,50};
OthersTab:AddDropdown({
	Title = "Chest Hop Limit",
	Desc = "Quantos baus pegar antes de trocar de servidor",
	Values = {"20","25","30","35","40","45","50"},
	Value = "20",
	Callback = function(v)
		_G.ChestHopLimit = tonumber(v) or 20;
	end
});
OthersTab:AddParagraph({
	Title = "Baus Coletados",
	Desc = "0"
});
task.spawn(function()
	local para = nil;
	for _, v in pairs(Tabs.OthersTab._elements or {}) do
		if type(v) == "table" and v.Title == "Baus Coletados" then para = v; break; end;
	end;
	while true do
		task.wait(1);
		if para and para.SetDesc then
			pcall(function() para:SetDesc(tostring(_G.ChestHopCount or 0) .. " / " .. tostring(_G.ChestHopLimit or 20)); end);
		end;
	end;
end);
AutoStopItemsToggle = OthersTab:AddToggle({
	Title = "Auto Stop Items",
	Desc = "Stop When Get God's Chalice or FoD",
	Value = _G.Settings.Farm["Auto Stop Items"],
	Callback = function(state)
		_G.Settings.Farm["Auto Stop Items"] = state;
		StopTween(_G.Settings.Farm["Auto Stop Items"]);
		(getgenv()).SaveSetting();
	end
});
task.spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Settings.Farm["Auto Stop Items"] then
				if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("God's Chalice") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("God's Chalice") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Fist of Darkness") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Fist of Darkness") then
					AutoFarmChestInstantToggle:SetValue(false);
					AutoFarmChestTweenToggle:SetValue(false);
					TweenPlayer((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame);
				end;
			end;
		end);
	end;
end);
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if _G.Settings.Farm["Auto Farm Chest Tween"] then
				for i, v in pairs((game:GetService("Workspace")).ChestModels:GetChildren()) do
					if v.Name:find("Chest") then
						repeat
							task.wait(0.1);
							TweenPlayer(v.RootPart.CFrame);
						until _G.Settings.Farm["Auto Farm Chest Tween"] == false or (not v.Parent);
						TweenPlayer((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame);
					end;
				end;
			end;
		end);
	end;
end);
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if _G.Settings.Farm["Auto Farm Chest Instant"] then
				for i, v in pairs((game:GetService("Workspace")).ChestModels:GetChildren()) do
					if v.Name:find("Chest") then
						repeat
							task.wait(0.1);
							if v.Name == "DiamondChest" then
								InstantTp(v.RootPart.CFrame);
							elseif v.Name == "GoldChest" then
								InstantTp(v.RootPart.CFrame);
							elseif v.Name == "SilverChest" then
								InstantTp(v.RootPart.CFrame);
							end;
						until not _G.Settings.Farm["Auto Farm Chest Instant"] or (not v.Parent);
					end;
				end;
			end;
		end);
	end;
end);

	MultiFarmTab:AddSection("Dungeon World");
	MultiFarmTab:AddParagraph({
		Title = "⚠ You are not in Dungeon World",
		Desc = "Please go to Dungeon World to use these features.\nDungeon Place ID: " .. tostring(_DUNGEON_PLACE_ID)
	});
else

	local _KNOWN_BUFFS = {
		"ATK UP","DEF UP","SPD UP","HP UP","CDR",
		"CRIT UP","DOUBLE HIT","LIFESTEAL","SHIELD",
		"REFLECT","REGEN","DASH UP","RANGE UP",
	};

	local function _InDungeonLobby()
		return workspace:FindFirstChild("DungeonLobby") ~= nil
			or workspace:FindFirstChild("Lobby") ~= nil;
	end;

	local function _InDungeonMatch()
		return workspace:FindFirstChild("DungeonFloor") ~= nil
			or workspace:FindFirstChild("FloorEnemies") ~= nil
			or workspace:FindFirstChild("DungeonArea") ~= nil;
	end;

	local function _FindRingNPC()
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("Model") then
				local name = v.Name:lower();
				if name:find("ring") and (name:find("npc") or name:find("dealer") or name:find("fus") or name:find("merge") or name:find("spin")) then
					return v;
				end;
			end;
		end;
		for _, v in pairs(workspace:FindFirstChild("NPCs") and workspace.NPCs:GetChildren() or {}) do
			if v.Name:lower():find("ring") then return v; end;
		end;
		return nil;
	end;

	local function _FindDungeonPortal()
		for _, v in pairs(workspace:GetDescendants()) do
			local name = v.Name:lower();
			if (name:find("portal") or name:find("dungeon") or name:find("enter") or name:find("gate")) and v:IsA("BasePart") then
				return v;
			end;
		end;
		return nil;
	end;

	local function _GetFloorEnemies()
		local enemies = {};
		local folder = workspace:FindFirstChild("FloorEnemies") or workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("DungeonEnemies");
		if folder then
			for _, v in pairs(folder:GetChildren()) do
				if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
					table.insert(enemies, v);
				end;
			end;
		end;
		return enemies;
	end;

	local function _GetKitsuneShrines()
		local shrines = {};
		for _, v in pairs(workspace:GetDescendants()) do
			local name = v.Name:lower();
			if name:find("shrine") or name:find("kitsune") or name:find("trap") then
				if v:IsA("BasePart") or v:IsA("Model") then
					table.insert(shrines, v);
				end;
			end;
		end;
		return shrines;
	end;

	local function _GetGasLeaks()
		local leaks = {};
		for _, v in pairs(workspace:GetDescendants()) do
			local name = v.Name:lower();
			if name:find("gas") or name:find("leak") or name:find("vent") or name:find("pipe") then
				if v:IsA("BasePart") or v:IsA("Model") then
					table.insert(leaks, v);
				end;
			end;
		end;
		return leaks;
	end;

	local function _AttackTarget(target)
		pcall(function()
			if not target then return; end;
			local hrp = target:IsA("Model") and (target:FindFirstChild("HumanoidRootPart") or target.PrimaryPart) or target;
			if not hrp then return; end;
			local char = game.Players.LocalPlayer.Character;
			if not char then return; end;
			EquipWeapon(_G.Settings.Main["Selected Weapon"] or _G.SelectWeapon);
			TweenPlayer(hrp.CFrame * CFrame.new(0, 20, 0));
			task.wait(0.1);
			getgenv().UseConfiguredSkills(hrp.Position);
		end);
	end;

	local function _SpamSkillsAt(pos)
		pcall(function()
			local char = game.Players.LocalPlayer.Character;
			if not char then return; end;
			TweenPlayer(CFrame.new(pos.X, pos.Y + 15, pos.Z));
			task.wait(0.15);
			local vim = game:GetService("VirtualInputManager");
			for _, key in pairs({"Z","X","C","V","F"}) do
				pcall(function()
					vim:SendKeyEvent(true, key, false, game);
					task.wait(0.06);
					vim:SendKeyEvent(false, key, false, game);
					task.wait(0.04);
				end);
			end;
		end);
	end;

	local function _SelectBuff(buffName)
		pcall(function()
			local plrGui = game.Players.LocalPlayer.PlayerGui;
			for _, gui in pairs(plrGui:GetDescendants()) do
				if (gui:IsA("TextButton") or gui:IsA("ImageButton")) then
					if gui.Text and gui.Text:lower():find(buffName:lower()) then
						gui:Activate();
						return;
					end;
				end;
			end;
		end);
	end;

	local function _PressSkipHub()
		pcall(function()
			local plrGui = game.Players.LocalPlayer.PlayerGui;
			for _, gui in pairs(plrGui:GetDescendants()) do
				if (gui:IsA("TextButton") or gui:IsA("ImageButton")) then
					local t = (gui.Text or ""):lower();
					if t:find("skip") or t:find("lobby") or t:find("return") or t:find("continue") or t:find("next") then
						gui:Activate();
						return;
					end;
				end;
			end;
		end);
	end;

	MultiFarmTab:AddSection("Rings");
	MultiFarmTab:AddToggle({
		Title = "Dungeon Auto Fuse Rings [BETA]",
		Desc = "Vai até o NPC de anéis no lobby e funde os anéis automaticamente.",
		Value = getgenv().DungeonConfig.AutoFuse,
		Callback = function(state)
			getgenv().DungeonConfig.AutoFuse = state;
		end
	});
	task.spawn(function()
		while true do
			task.wait(1);
			if not getgenv().DungeonConfig.AutoFuse then continue; end;
			pcall(function()
				local npc = _FindRingNPC();
				if not npc then return; end;
				local hrp_npc = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart;
				if not hrp_npc then return; end;
				TweenPlayer(hrp_npc.CFrame * CFrame.new(0, 0, 5));
				task.wait(0.8);
				local rep = game:GetService("ReplicatedStorage");
				local remote = rep:FindFirstChild("CommF_", true) or rep.Remotes and rep.Remotes:FindFirstChild("CommF_");
				if remote then
					pcall(function() remote:InvokeServer("FuseRing"); end);
					pcall(function() remote:InvokeServer("MergeRing"); end);
					pcall(function() remote:InvokeServer("CombineRing"); end);
				end;
				for _, pp in pairs(npc:GetDescendants()) do
					if pp:IsA("ProximityPrompt") then
						pcall(function() fireproximityprompt(pp); end);
					end;
				end;
			end);
		end;
	end);

	MultiFarmTab:AddToggle({
		Title = "Dungeon Auto Spin Rings [BETA]",
		Desc = "Gira anéis automaticamente no NPC do lobby.",
		Value = getgenv().DungeonConfig.AutoSpin,
		Callback = function(state)
			getgenv().DungeonConfig.AutoSpin = state;
		end
	});
	task.spawn(function()
		while true do
			task.wait(1);
			if not getgenv().DungeonConfig.AutoSpin then continue; end;
			pcall(function()
				local npc = _FindRingNPC();
				if not npc then return; end;
				local hrp_npc = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart;
				if not hrp_npc then return; end;
				TweenPlayer(hrp_npc.CFrame * CFrame.new(0, 0, 5));
				task.wait(0.8);
				local rep = game:GetService("ReplicatedStorage");
				local remote = rep:FindFirstChild("CommF_", true) or rep.Remotes and rep.Remotes:FindFirstChild("CommF_");
				if remote then
					pcall(function() remote:InvokeServer("SpinRing"); end);
					pcall(function() remote:InvokeServer("RollRing"); end);
					pcall(function() remote:InvokeServer("RerollRing"); end);
				end;
				for _, pp in pairs(npc:GetDescendants()) do
					if pp:IsA("ProximityPrompt") then
						local name = pp.ActionText and pp.ActionText:lower() or "";
						if name:find("spin") or name:find("roll") or name:find("reroll") then
							pcall(function() fireproximityprompt(pp); end);
						end;
					end;
				end;
			end);
		end;
	end);

	MultiFarmTab:AddSection("Dungeon");
	MultiFarmTab:AddToggle({
		Title = "Auto Enter Dungeon",
		Desc = "Teleporta para o chao amarelo na entrada da Dungeon e fica tentando iniciar a partida.",
		Value = getgenv().DungeonConfig.AutoEnter,
		Callback = function(state)
			getgenv().DungeonConfig.AutoEnter = state;
		end
	});
	local _DUNGEON_ENTRY_FLOOR_CF = CFrame.new(-2.5, 0.5, -35.5);
	task.spawn(function()
		while true do
			task.wait(0.5);
			if not getgenv().DungeonConfig.AutoEnter then continue; end;
			pcall(function()
				if _InDungeonMatch() then return; end;
				local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
				if not hrp then return; end;
				local yellowFloor = nil;
				for _, v in pairs(workspace:GetDescendants()) do
					if v:IsA("BasePart") then
						local col = v.Color;
						if col.R > 0.7 and col.G > 0.6 and col.B < 0.3 then
							local name = v.Name:lower();
							if name:find("floor") or name:find("enter") or name:find("lobby") or name:find("start") or name:find("ground") then
								yellowFloor = v;
								break;
							end;
						end;
					end;
				end;
				if yellowFloor then
					local targetCF = CFrame.new(yellowFloor.Position.X, yellowFloor.Position.Y + 3, yellowFloor.Position.Z);
					hrp.CFrame = targetCF;
				else
					local portal = _FindDungeonPortal();
					if portal then
						hrp.CFrame = portal.CFrame * CFrame.new(0, 3, 5);
					end;
				end;
				task.wait(0.2);
				for _, pp in pairs(workspace:GetDescendants()) do
					if pp:IsA("ProximityPrompt") then
						local n = (pp.ActionText or pp.Name):lower();
						if n:find("enter") or n:find("start") or n:find("join") or n:find("dungeon") or n:find("portal") then
							pcall(function() fireproximityprompt(pp); end);
						end;
					end;
				end;
				local rep = game:GetService("ReplicatedStorage");
				local remote = rep:FindFirstChild("CommF_", true) or (rep.Remotes and rep.Remotes:FindFirstChild("CommF_"));
				if remote then
					pcall(function() remote:InvokeServer("EnterDungeon"); end);
					pcall(function() remote:InvokeServer("JoinDungeon"); end);
					pcall(function() remote:InvokeServer("StartDungeon"); end);
				end;
			end);
		end;
	end);

	MultiFarmTab:AddToggle({
		Title = "Auto Complete Dungeon",
		Desc = "Ataca todos os NPCs proximos de cada Floor, destroi Shrines do Kitsune (Floor 10), destroi vazamentos de gas (Floor 15) e avanca automaticamente.",
		Value = getgenv().DungeonConfig.AutoComplete,
		Callback = function(state)
			getgenv().DungeonConfig.AutoComplete = state;
		end
	});
	task.spawn(function()
		while true do
			task.wait(0.15);
			if not getgenv().DungeonConfig.AutoComplete then continue; end;
			pcall(function()
				if not _InDungeonMatch() then return; end;
				local floorNum = 0;
				for _, v in pairs(workspace:GetDescendants()) do
					local name = v.Name:lower();
					if name:find("floor") then
						local n = tonumber(name:match("%d+"));
						if n and n > floorNum then floorNum = n; end;
					end;
				end;

				if floorNum == 10 then
					local shrines = _GetKitsuneShrines();
					if #shrines > 0 then
						for _, shrine in pairs(shrines) do
							if not getgenv().DungeonConfig.AutoComplete then break; end;
							local pos = shrine:IsA("Model") and shrine:GetPivot().Position or shrine.Position;
							local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
							if hrp then hrp.CFrame = CFrame.new(pos.X, pos.Y + 8, pos.Z); end;
							task.wait(0.05);
							_SpamSkillsAt(pos);
							task.wait(0.1);
						end;
						return;
					end;
				end;

				if floorNum == 15 then
					local leaks = _GetGasLeaks();
					if #leaks > 0 then
						for _, leak in pairs(leaks) do
							if not getgenv().DungeonConfig.AutoComplete then break; end;
							local pos = leak:IsA("Model") and leak:GetPivot().Position or leak.Position;
							local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
							if hrp then hrp.CFrame = CFrame.new(pos.X, pos.Y + 8, pos.Z); end;
							task.wait(0.05);
							_SpamSkillsAt(pos);
							task.wait(0.1);
						end;
						return;
					end;
				end;

				local enemies = _GetFloorEnemies();
				if #enemies > 0 then
					local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
					local nearest, nearestDist = enemies[1], math.huge;
					if hrp then
						for _, enemy in pairs(enemies) do
							if enemy:FindFirstChild("HumanoidRootPart") then
								local d = (enemy.HumanoidRootPart.Position - hrp.Position).Magnitude;
								if d < nearestDist then
									nearestDist = d;
									nearest = enemy;
								end;
							end;
						end;
					end;
					if nearest and nearest:FindFirstChild("Humanoid") and nearest.Humanoid.Health > 0 then
						pcall(function() nearest.Humanoid.WalkSpeed = 0; end);
						_AttackTarget(nearest);
					end;
				else
					local rep = game:GetService("ReplicatedStorage");
					local remote = rep:FindFirstChild("CommF_", true) or (rep.Remotes and rep.Remotes:FindFirstChild("CommF_"));
					if remote then
						pcall(function() remote:InvokeServer("NextFloor"); end);
						pcall(function() remote:InvokeServer("AdvanceFloor"); end);
						pcall(function() remote:InvokeServer("CompleteFloor"); end);
					end;
					for _, v in pairs(workspace:GetDescendants()) do
						if v:IsA("ProximityPrompt") then
							local n = (v.ActionText or v.Name):lower();
							if n:find("next") or n:find("advance") or n:find("continue") or n:find("pass") or n:find("floor") then
								pcall(function() fireproximityprompt(v); end);
							end;
						end;
					end;
				end;
			end);
		end;
	end);

	MultiFarmTab:AddSection("Buffs");
	MultiFarmTab:AddToggle({
		Title = "Dungeon Select Buffs [BETA]",
		Desc = "Ativa a seleção automática de buffs quando aparecer a tela de cartas na dungeon.",
		Value = getgenv().DungeonConfig.SelectBuffs,
		Callback = function(state)
			getgenv().DungeonConfig.SelectBuffs = state;
		end
	});
	MultiFarmTab:AddDropdown({
		Title = "Dungeon Buffs to Select [BETA]",
		Desc = "Escolha quais buffs devem ser selecionados automaticamente (multi-seleção)",
		Values = _KNOWN_BUFFS,
		Value = getgenv().DungeonConfig.SelectedBuffs[1] or _KNOWN_BUFFS[1],
		Callback = function(option)
			local found = false;
			for i, v in pairs(getgenv().DungeonConfig.SelectedBuffs) do
				if v == option then found = true; table.remove(getgenv().DungeonConfig.SelectedBuffs, i); break; end;
			end;
			if not found then table.insert(getgenv().DungeonConfig.SelectedBuffs, option); end;
		end
	});
	task.spawn(function()
		while true do
			task.wait(0.5);
			if not getgenv().DungeonConfig.SelectBuffs then continue; end;
			if #getgenv().DungeonConfig.SelectedBuffs == 0 then continue; end;
			pcall(function()
				local plrGui = game.Players.LocalPlayer.PlayerGui;
				for _, gui in pairs(plrGui:GetDescendants()) do
					if (gui:IsA("TextButton") or gui:IsA("ImageButton")) and gui.Visible then
						local t = (gui.Text or ""):lower();
						for _, buffName in pairs(getgenv().DungeonConfig.SelectedBuffs) do
							if t:find(buffName:lower()) then
								gui:Activate();
								task.wait(0.3);
								break;
							end;
						end;
					end;
				end;
			end);
		end;
	end);

	MultiFarmTab:AddSection("Post-Dungeon");
	MultiFarmTab:AddToggle({
		Title = "Dungeon Auto Skip Hub [BETA]",
		Desc = "Quando a dungeon terminar, aperta automaticamente para voltar ao lobby.",
		Value = getgenv().DungeonConfig.AutoSkipHub,
		Callback = function(state)
			getgenv().DungeonConfig.AutoSkipHub = state;
		end
	});
	task.spawn(function()
		while true do
			task.wait(1);
			if not getgenv().DungeonConfig.AutoSkipHub then continue; end;
			pcall(function()
				_PressSkipHub();
			end);
		end;
	end);

end;

local PvPTargetList = {};
local SelectedPvPTarget = nil;

local function RefreshPvPTargets()
	PvPTargetList = {};
	for _, p in pairs(game:GetService("Players"):GetPlayers()) do
		if p ~= game.Players.LocalPlayer then
			table.insert(PvPTargetList, p.Name);
		end;
	end;
	return PvPTargetList;
end;
RefreshPvPTargets();

local PvPPlayerDropdown = LocalPlayerTab:AddDropdown({
	Title = "Select Player",
	Desc = "Seleciona o jogador alvo para PvP",
	Values = PvPTargetList,
	Value = PvPTargetList[1] or "No Players",
	Callback = function(v)
		SelectedPvPTarget = v;
	end
});

LocalPlayerTab:AddButton({
	Title = " Refresh Player List",
	Desc = "Atualiza a lista de jogadores no servidor",
	Callback = function()
		RefreshPvPTargets();
		pcall(function()
			PvPPlayerDropdown:SetValues(PvPTargetList);
		end);
		pcall(function()
			PvPPlayerDropdown:Refresh(PvPTargetList);
		end);
		pcall(function()
			PvPPlayerDropdown:Set(PvPTargetList[1] or "");
		end);
	end
});

LocalPlayerTab:AddButton({
	Title = " TP to Selected Player",
	Desc = "Teleporta para a posicao do jogador selecionado",
	Callback = function()
		pcall(function()
			if SelectedPvPTarget then
				local target = game:GetService("Players"):FindFirstChild(SelectedPvPTarget);
				if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
					TweenPlayer(target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 5));
				end;
			end;
		end);
	end
});

local _PvPAutoTP = false;
LocalPlayerTab:AddToggle({
	Title = "Auto Follow / TP to Player",
	Desc = "Segue e fica em cima do jogador selecionado constantemente",
	Value = false,
	Callback = function(v)
		_PvPAutoTP = v;
	end
});
task.spawn(function()
	while task.wait(0.1) do
		if _PvPAutoTP and SelectedPvPTarget then
			pcall(function()
				local target = game:GetService("Players"):FindFirstChild(SelectedPvPTarget);
				if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
					TweenPlayer(target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 3));
				end;
			end);
		end;
	end;
end);

LocalPlayerTab:AddToggle({
	Title = "Auto Activate PvP",
	Desc = "Mantem PvP ativado automaticamente",
	Value = false,
	Callback = function(v)
		if v then
			task.spawn(function()
				while v do
					pcall(function()
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ActivatePvp", true);
					end);
					task.wait(5);
				end;
			end);
		end;
	end
});

local _PvPAutoKill = false;
LocalPlayerTab:AddToggle({
	Title = "Auto Kill Selected Player",
	Desc = "Mata automaticamente o jogador selecionado",
	Value = false,
	Callback = function(v)
		_PvPAutoKill = v;
	end
});
task.spawn(function()
	while task.wait(0.1) do
		if _PvPAutoKill and SelectedPvPTarget then
			pcall(function()
				local target = game:GetService("Players"):FindFirstChild(SelectedPvPTarget);
				if target and target.Character and target.Character:FindFirstChild("Humanoid")
				   and target.Character.Humanoid.Health > 0 then
					Attack();
					EquipWeapon(_G.Settings.Main["Selected Weapon"]);
					AutoHaki();
					TweenPlayer(target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 2));
				end;
			end);
		end;
	end;
end);

local _PvPSpamSkills = false;
LocalPlayerTab:AddToggle({
	Title = " Auto Spam Skills (All)",
	Desc = "Spama todas as skills de todas as categorias automaticamente em PvP",
	Value = false,
	Callback = function(v)
		_PvPSpamSkills = v;
	end
});
task.spawn(function()
	local VIM = game:GetService("VirtualInputManager");
	local VU  = game:GetService("VirtualUser");
	local skillKeys = {"Z","X","C","V","F"};
	local categories = {"Melee","Sword","Blox Fruit","Gun"};
	while true do
		task.wait(0.05);
		if _PvPSpamSkills then
			pcall(function()
				local char = game.Players.LocalPlayer.Character;
				if not char then return; end;
				if SelectedPvPTarget then
					local target = game:GetService("Players"):FindFirstChild(SelectedPvPTarget);
					if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
						workspace.CurrentCamera.CFrame = CFrame.lookAt(
							workspace.CurrentCamera.CFrame.Position,
							target.Character.HumanoidRootPart.Position
						);
					end;
				end;
				for _, toolType in ipairs(categories) do
					local tool = nil;
					for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA("Tool") and v.ToolTip == toolType then tool = v; break; end;
					end;
					if tool then
						char.Humanoid:EquipTool(tool);
						task.wait(0.05);
						for _, sk in ipairs(skillKeys) do
							VIM:SendKeyEvent(true, sk, false, game);
							task.wait(0.02);
							VIM:SendKeyEvent(false, sk, false, game);
						end;
						VU:CaptureController();
						VU:ClickButton1(Vector2.new(851, 158));
						task.wait(0.05);
					end;
				end;
				Attack();
			end);
		end;
	end;
end);

LocalPlayerTab:AddSection("Aimbot");


SettingsTab:AddSection("Weapon")
ChooseWeaponDropdown = SettingsTab:AddDropdown({
	Title = "Select Weapon",
	Options = {"Melee","Sword","Blox Fruit","Gun"},
	CurrentOption = {_G.Settings.Main["Select Weapon"] or "Melee"},
	Callback = function(sel)
		_G.SelectWeapon = sel[1] or sel
		_G.Settings.Main["Select Weapon"] = _G.SelectWeapon
		pcall(function() (getgenv()).SaveSetting() end)
	end
})

SettingsTab:AddSection("Farm Settings")
SettingsTab:AddSlider({
	Title = "Farm Distance",
	Min = 0, Max = 100,
	Default = _G.Settings.Setting["Farm Distance"] or 35,
	Callback = function(val)
		_G.Settings.Setting["Farm Distance"] = val
		Pos = CFrame.new(0, val, 0)
		pcall(function() (getgenv()).SaveSetting() end)
	end
})
SettingsTab:AddSlider({
	Title = "Tween Speed",
	Min = 50, Max = 1000,
	Default = _G.Settings.Setting["Player Tween Speed"] or 350,
	Callback = function(val)
		_G.Settings.Setting["Player Tween Speed"] = val
		getgenv().TweenSpeedFar = val
		pcall(function() (getgenv()).SaveSetting() end)
	end
})
SettingsTab:AddToggle({
	Title = "Bring Mob",
	Value = _G.Settings.Setting["Bring Mob"],
	Callback = function(state)
		_G.Settings.Setting["Bring Mob"] = state
		pcall(function() (getgenv()).SaveSetting() end)
	end
})
SettingsTab:AddToggle({
	Title = "Fast Attack",
	Value = _G.Settings.Setting["Fast Attack"],
	Callback = function(state)
		_G.Settings.Setting["Fast Attack"] = state
		pcall(function() (getgenv()).SaveSetting() end)
	end
})

SettingsTab:AddSection("Visual")
SettingsTab:AddToggle({
	Title = "Fix Lag / Low Quality",
	Value = getgenv().FixLagEnabled or false,
	Callback = function(state)
		getgenv().FixLagEnabled = state
	end
})
SettingsTab:AddButton({
	Title = "Reset Settings",
	Callback = function()
		Library:Notify({Title="TRon Void Hub",Content="Settings reset!",Icon="refresh-cw",Duration=3})
	end
})

MiscSection = SettingsTab:AddSection("Misc");
JoinPiratesTeamButton = SettingsTab:AddButton({
	Title = "Join Pirates Team",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("SetTeam", "Pirates");
	end
});
JoinMarinesTeamButton = SettingsTab:AddButton({
	Title = "Join Marines Team",
	Callback = function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("SetTeam", "Marines");
	end
});
CodeSection = SettingsTab:AddSection("Codes");
local codeList = {
	"KITTGAMING",
	"ENYU_IS_PRO",
	"FUDD10",
	"BIGNEWS",
	"THEGREATACE",
	"SUB2GAMERROBOT_EXP1",
	"STRAWHATMAIME",
	"SUB2OFFICIALNOOBIE",
	"SUB2NOOBMASTER123",
	"SUB2DAIGROCK",
	"AXIORE",
	"TANTAIGAMIMG",
	"STRAWHATMAINE",
	"JCWK",
	"FUDD10_V2",
	"SUB2FER999",
	"MAGICBIS",
	"TY_FOR_WATCHING",
	"STARCODEHEO"
};
function redeemCode(code)
	(game:GetService("ReplicatedStorage")).Remotes.Redeem:InvokeServer(code);
end;
local RedeemAllCodesButton = SettingsTab:AddButton({
	Title = "Redeem All Codes",
	Callback = function()
		for i, v in pairs(codeList) do
			redeemCode(v);
		end;
	end
});
GraphicMiscSection = SettingsTab:AddSection("Graphic");
function boostFps()
	local I = true;
	local e = game;
	local K = e.Workspace;
	local n = e.Lighting;
	local d = K.Terrain;
	d.WaterWaveSize = 0;
	d.WaterWaveSpeed = 0;
	d.WaterReflectance = 0;
	d.WaterTransparency = 0;
	n.GlobalShadows = false;
	n.FogEnd = 9000000000.0;
	n.Brightness = 1;
	(settings()).Rendering.QualityLevel = "Level01";
	for e, K in pairs(e:GetDescendants()) do
		if K:IsA("Part") or K:IsA("Union") or K:IsA("CornerWedgePart") or K:IsA("TrussPart") then
			K.Material = "Plastic";
			K.Reflectance = 0;
		elseif K:IsA("Decal") or K:IsA("Texture") and I then
			K.Transparency = 1;
		elseif K:IsA("ParticleEmitter") or K:IsA("Trail") then
			K.Lifetime = NumberRange.new(0);
		elseif K:IsA("Explosion") then
			K.BlastPressure = 1;
			K.BlastRadius = 1;
		elseif K:IsA("Fire") or K:IsA("SpotLight") or K:IsA("Smoke") or K:IsA("Sparkles") then
			K.Enabled = false;
		elseif K:IsA("MeshPart") then
			K.Material = "Plastic";
			K.Reflectance = 0;
			K.TextureID = 10385902758728957;
		end;
	end;
	for I, e in pairs(n:GetChildren()) do
		if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
			e.Enabled = false;
		end;
	end;
end;
FpsBoostButton = SettingsTab:AddButton({
	Title = "Fps Boost",
	Callback = function()
		boostFps();
	end
});
RemoveFogButton = SettingsTab:AddButton({
	Title = "Remove Fog",
	Callback = function()
		(game:GetService("Lighting")).LightingLayers:Destroy();
		(game:GetService("Lighting")).Sky:Destroy();
		game.Lighting.FogEnd = 9000000000;
	end
});
RemoveLavaButton = SettingsTab:AddButton({
	Title = "Remove Lava",
	Callback = function()
		for i, v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == "Lava" then
				v:Destroy();
			end;
		end;
		for i, v in pairs(game.ReplicatedStorage:GetDescendants()) do
			if v.Name == "Lava" then
				v:Destroy();
			end;
		end;
	end
});
ServerTabSection = ServerTab:AddSection("Server");
local _FpsParagraph = ServerTab:AddParagraph({
	Title = "FPS",
	Desc = "0",
	Image = "monitor",
	ImageSize = 20
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			_FpsParagraph:SetDesc(math.floor(workspace:GetRealPhysicsFPS()));
		end);
	end;
end);
local _PingParagraph = ServerTab:AddParagraph({
	Title = "Ping",
	Desc = "0",
	Image = "signal",
	ImageSize = 20
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			_PingParagraph:SetDesc((game:GetService("Stats")).Network.ServerStatsItem["Data Ping"]:GetValueString() .. " ms");
		end);
	end;
end);
RejoinServerButton = ServerTab:AddButton({
	Title = "Rejoin Server",
	Callback = function()
		(game:GetService("TeleportService")):Teleport(game.PlaceId);
	end
});
ServerHopButton = ServerTab:AddButton({
	Title = "Server Hop",
	Callback = function()
		local module = (loadstring(game:HttpGet("https://raw.githubusercontent.com/raw-scriptpastebin/FE/main/Server_Hop_Settings")))();
		module:Teleport(game.PlaceId);
	end
});
JobIdParagraph = ServerTab:AddParagraph({
	Title = "Job ID",
	Desc = game.JobId,
	Buttons = {
		{
			Title = "Copy",
			Callback = function()
				setclipboard(game.JobId);
			end
		}
	}
});
EnterJobIdInput = ServerTab:AddInput({
	Title = "Enter Job ID",
	Callback = function(value)
		_G.JobId = value;
	end
});
JoinJobIdButton = ServerTab:AddButton({
	Title = "Join Job ID",
	Callback = function()
		(game:GetService("TeleportService")):TeleportToPlaceInstance(game.PlaceId, _G.JobId);
	end
});
StatusServerSection = ServerTab:AddSection("Status");
MoonServerParagraph = ServerTab:AddParagraph({
	Title = "Moon Server",
	Desc = "N/A"
});
KitsuneStatusParagraph = ServerTab:AddParagraph({
	Title = "Kitsune Status",
	Desc = "N/A"
});
FrozenStatusParagraph = ServerTab:AddParagraph({
	Title = "Frozen Status",
	Desc = "N/A"
});
MirageStatusParagraph = ServerTab:AddParagraph({
	Title = "Mirage Status",
	Desc = "N/A"
});
HakiDealerStatusParagraph = ServerTab:AddParagraph({
	Title = "Haki Dealer Status",
	Desc = "N/A"
});
PrehistoricStatusParagraph = ServerTab:AddParagraph({
	Title = "Prehistoric Status",
	Desc = "N/A"
});
task.spawn(function()
	while task.wait() do
		pcall(function()
			if (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
				MoonServerParagraph:SetDesc("Full Moon 100%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
				MoonServerParagraph:SetDesc("Full Moon 75%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
				MoonServerParagraph:SetDesc("Full Moon 50%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
				MoonServerParagraph:SetDesc("Full Moon 25%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
				MoonServerParagraph:SetDesc("Full Moon 15%");
			else
				MoonServerParagraph:SetDesc("Full Moon 0%");
			end;
		end);
	end;
end);
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if World3 then
				if game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
					KitsuneStatusParagraph:SetDesc("Kitsune Island is Spawning");
				else
					KitsuneStatusParagraph:SetDesc("Kitsune Island Not Spawn");
				end;
			else
				KitsuneStatusParagraph:SetDesc("World 3 Only");
			end;
		end;
	end);
end);
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if World3 then
				if game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
					PrehistoricStatusParagraph:SetDesc("Prehistoric Island is Spawning");
				else
					PrehistoricStatusParagraph:SetDesc("Prehistoric Island Not Spawn");
				end;
			else
				PrehistoricStatusParagraph:SetDesc("World 3 Only");
			end;
		end;
	end);
end);
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if game.Workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
				FrozenStatusParagraph:SetDesc("Frozen Dimension Spawning");
			else
				FrozenStatusParagraph:SetDesc("Frozen Dimension Not Spawn");
			end;
		end;
	end);
end);
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if World2 or World3 then
				if game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
					MirageStatusParagraph:SetDesc("Mirage Island is Spawning");
				else
					MirageStatusParagraph:SetDesc("Mirage Island Not Spawn");
				end;
			else
				MirageStatusParagraph:SetDesc("World 3 Only");
			end;
		end;
	end);
end);
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			local response = (((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("ColorsDealer", "1");
			if response then
				HakiDealerStatusParagraph:SetDesc("Master Of Auras Spawning");
			else
				HakiDealerStatusParagraph:SetDesc("Master Of Auras Not Spawn");
			end;
		end);
	end;
end);
local _seaStatusParagraph = ServerTab:AddParagraph({
	Title = "SEA ATUAL",
	Desc = "Detectando..."
});
local _serverTimeParagraph = ServerTab:AddParagraph({
	Title = "TEMPO DE SERVIDOR",
	Desc = "N/A"
});
local _fodStatusParagraph = ServerTab:AddParagraph({
	Title = "FIRST OF DARKNESS",
	Desc = "N/A"
});
local _chaliceStatusParagraph = ServerTab:AddParagraph({
	Title = "GOD CHALICE",
	Desc = "N/A"
});
local _raidBossStatusParagraph = ServerTab:AddParagraph({
	Title = "RAID BOSS",
	Desc = "N/A"
});
local _pirateRaidStatusParagraph = ServerTab:AddParagraph({
	Title = "PIRATES RAID",
	Desc = "N/A"
});
local _factoryStatusParagraph = ServerTab:AddParagraph({
	Title = "FACTORY",
	Desc = "N/A"
});
local _jobIdParagraph = ServerTab:AddParagraph({
	Title = "JOB ID",
	Desc = "Em breve"
});
local _serverStartTime = os.time();
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local elapsed = os.time() - _serverStartTime;
			local mins = math.floor(elapsed / 60);
			local secs = elapsed % 60;
			_serverTimeParagraph:SetDesc(string.format("%02d:%02d ativos", mins, secs));
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(0.5);
		pcall(function()
			if World1 then
				_seaStatusParagraph:SetDesc("SEA 1 (First Sea)");
			elseif World2 then
				_seaStatusParagraph:SetDesc("SEA 2 (Second Sea)");
			elseif World3 then
				_seaStatusParagraph:SetDesc("SEA 3 (Third Sea)");
			else
				_seaStatusParagraph:SetDesc("Sea desconhecido");
			end;
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local found = false;
			for _, v in pairs(workspace:GetDescendants()) do
				if v.Name:lower():find("first") and v.Name:lower():find("dark") then
					found = true; break;
				end;
			end;
			_fodStatusParagraph:SetDesc(found and "SPAWNED no servidor!" or "Nao encontrado");
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local found = false;
			for _, v in pairs(workspace:GetDescendants()) do
				if v.Name:lower():find("god") and v.Name:lower():find("chal") then
					found = true; break;
				end;
			end;
			_chaliceStatusParagraph:SetDesc(found and "SPAWNED no servidor!" or "Nao encontrado");
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local raidBossNames = {"Darkbeard", "rip_indra", "Dough King", "Ice Admiral", "Cyborg", "Thunder God"};
			local found = false;
			for _, bossName in pairs(raidBossNames) do
				if workspace.Enemies:FindFirstChild(bossName) then
					found = true;
					_raidBossStatusParagraph:SetDesc("SPAWNED: " .. bossName);
					break;
				end;
			end;
			if not found then _raidBossStatusParagraph:SetDesc("Nenhum Raid Boss ativo"); end;
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local pirateRaid = workspace:FindFirstChild("PirateRaid") or workspace:FindFirstChild("Pirate Raid") or workspace:FindFirstChild("PiratesRaid");
			if pirateRaid then
				_pirateRaidStatusParagraph:SetDesc("ATIVO no servidor!");
			else
				_pirateRaidStatusParagraph:SetDesc("Inativo");
			end;
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local factory = workspace:FindFirstChild("Factory") or workspace:FindFirstChild("FactoryFortress");
			if factory then
				_factoryStatusParagraph:SetDesc("ATIVO no servidor!");
			else
				_factoryStatusParagraph:SetDesc("Inativo");
			end;
		end);
	end;
end);
getgenv().HoldSkillConfig = {
	["Z"] = true,
	["X"] = true,
	["C"] = true,
	["V"] = false,
	["F"] = false,
	["Melee"] = false,
	["Sword"] = false,
	["Gun"] = false,
}

HoldAndSkillTab:AddSection("Skills Config - Selecione as skills para usar nos farms");

HoldAndSkillTab:AddParagraph({
	Title = "Como funciona",
	Desc = "Selecione abaixo quais teclas/skills serao usadas em TODOS os farms e funcoes do hub que precisam de skills. As combinacoes Z X C Melee, Z X C V F Fruit, Z X Sword e Z X Gun definem grupos rapidos."
});

HoldAndSkillTab:AddToggle({
	Title = "Z X C Melee",
	Desc = "Usa apenas Z, X, C de Melee (Fighting Style)",
	Value = false,
	Callback = function(state)
		if state then
			getgenv().HoldSkillConfig["Z"] = true;
			getgenv().HoldSkillConfig["X"] = true;
			getgenv().HoldSkillConfig["C"] = true;
			getgenv().HoldSkillConfig["V"] = false;
			getgenv().HoldSkillConfig["F"] = false;
			getgenv().HoldSkillConfig["Melee"] = true;
			getgenv().HoldSkillConfig["Sword"] = false;
			getgenv().HoldSkillConfig["Gun"] = false;
		end
	end
});

HoldAndSkillTab:AddToggle({
	Title = "Z X C V F Fruit",
	Desc = "Usa Z, X, C, V e F de Fruta (Devil Fruit)",
	Value = false,
	Callback = function(state)
		if state then
			getgenv().HoldSkillConfig["Z"] = true;
			getgenv().HoldSkillConfig["X"] = true;
			getgenv().HoldSkillConfig["C"] = true;
			getgenv().HoldSkillConfig["V"] = true;
			getgenv().HoldSkillConfig["F"] = true;
			getgenv().HoldSkillConfig["Melee"] = false;
			getgenv().HoldSkillConfig["Sword"] = false;
			getgenv().HoldSkillConfig["Gun"] = false;
		end
	end
});

HoldAndSkillTab:AddToggle({
	Title = "Z X Sword",
	Desc = "Usa apenas Z e X de Espada (Sword)",
	Value = false,
	Callback = function(state)
		if state then
			getgenv().HoldSkillConfig["Z"] = true;
			getgenv().HoldSkillConfig["X"] = true;
			getgenv().HoldSkillConfig["C"] = false;
			getgenv().HoldSkillConfig["V"] = false;
			getgenv().HoldSkillConfig["F"] = false;
			getgenv().HoldSkillConfig["Melee"] = false;
			getgenv().HoldSkillConfig["Sword"] = true;
			getgenv().HoldSkillConfig["Gun"] = false;
		end
	end
});

HoldAndSkillTab:AddToggle({
	Title = "Z X Gun",
	Desc = "Usa apenas Z e X de Arma de Fogo (Gun)",
	Value = false,
	Callback = function(state)
		if state then
			getgenv().HoldSkillConfig["Z"] = true;
			getgenv().HoldSkillConfig["X"] = true;
			getgenv().HoldSkillConfig["C"] = false;
			getgenv().HoldSkillConfig["V"] = false;
			getgenv().HoldSkillConfig["F"] = false;
			getgenv().HoldSkillConfig["Melee"] = false;
			getgenv().HoldSkillConfig["Sword"] = false;
			getgenv().HoldSkillConfig["Gun"] = true;
		end
	end
});

HoldAndSkillTab:AddSection("Skills Individuais");

HoldAndSkillTab:AddToggle({
	Title = "Usar Skill Z",
	Desc = "Ativa o uso da tecla Z nos farms",
	Value = true,
	Callback = function(state)
		getgenv().HoldSkillConfig["Z"] = state;
	end
});
HoldAndSkillTab:AddToggle({
	Title = "Usar Skill X",
	Desc = "Ativa o uso da tecla X nos farms",
	Value = true,
	Callback = function(state)
		getgenv().HoldSkillConfig["X"] = state;
	end
});
HoldAndSkillTab:AddToggle({
	Title = "Usar Skill C",
	Desc = "Ativa o uso da tecla C nos farms",
	Value = true,
	Callback = function(state)
		getgenv().HoldSkillConfig["C"] = state;
	end
});
HoldAndSkillTab:AddToggle({
	Title = "Usar Skill V",
	Desc = "Ativa o uso da tecla V nos farms",
	Value = false,
	Callback = function(state)
		getgenv().HoldSkillConfig["V"] = state;
	end
});
HoldAndSkillTab:AddToggle({
	Title = "Usar Skill F",
	Desc = "Ativa o uso da tecla F nos farms",
	Value = false,
	Callback = function(state)
		getgenv().HoldSkillConfig["F"] = state;
	end
});

getgenv().UseConfiguredSkills = function(targetPosition)
	pcall(function()
		local char = game.Players.LocalPlayer.Character;
		if not char then return end
		local hrp = char:FindFirstChild("HumanoidRootPart");
		if not hrp and targetPosition then
			hrp.CFrame = CFrame.lookAt(hrp.Position, targetPosition);
		end
		local vim = game:GetService("VirtualInputManager");
		local skillsToUse = {};
		if getgenv().HoldSkillConfig["Z"] then table.insert(skillsToUse, "Z") end
		if getgenv().HoldSkillConfig["X"] then table.insert(skillsToUse, "X") end
		if getgenv().HoldSkillConfig["C"] then table.insert(skillsToUse, "C") end
		if getgenv().HoldSkillConfig["V"] then table.insert(skillsToUse, "V") end
		if getgenv().HoldSkillConfig["F"] then table.insert(skillsToUse, "F") end
		for _, key in pairs(skillsToUse) do
			pcall(function()
				vim:SendKeyEvent(true, key, false, game);
				task.wait(0.08);
				vim:SendKeyEvent(false, key, false, game);
				task.wait(0.05);
			end)
		end
	end)
end

task.spawn(function()
	task.wait(4);

	local S = _G.Settings;
	if not S then return; end;

	local function _reactivate(toggle, state)
		if toggle and toggle.SetValue then
			pcall(function() toggle:SetValue(state); end);
		end;
	end;

	if S.Main and S.Main["Auto Farm"] then
		pcall(function() AutoFarmToggle:SetValue(true); end);
	end;

	if S.Multi and S.Multi["Auto Fully Volcanic"] then
		_G.FullyVolcanicActive    = true;
		_G.VolcanicAutoReset      = S.Multi["Auto Reset After Complete"] or false;
		_G.VolcanicCollectEgg     = S.Multi["Auto Collect Egg"] or false;
		_G.VolcanicCollectBone    = S.Multi["Auto Collect Bone"] or false;
		task.spawn(_volcanicMainLoop);
		Library:Notify({Title="Volcanic Kaitun", Content="Auto Fully Volcanic reativado!", Icon="zap", Duration=5});
	end;

	if S.Main and S.Main["Auto Fully Dungeon"] then
		if getgenv().DungeonConfig then
			getgenv().DungeonConfig.AutoFully    = true;
			getgenv().DungeonConfig.AutoEnter    = true;
			getgenv().DungeonConfig.AutoComplete = true;
			getgenv().DungeonConfig.AutoSkipHub  = true;
			getgenv().DungeonConfig.SelectBuffs  = true;
		end;
		pcall(function() _AutoFullyDungeonToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Summon Prehistoric Island"] then
		pcall(function() AutoSummonPrehistoricIslandToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Tween To Prehistoric Island"] then
		pcall(function() TweenToPrehistoricIslandToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Auto Kill Lava Golem"] then
		pcall(function() AutoKillLavaGolemToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Summon Frozen Dimension"] then
		pcall(function() AutoSummonFrozenDimensionToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Tween To Frozen Dimension"] then
		pcall(function() TweenToFrozenDimensionToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Summon Kitsune Island"] then
		pcall(function() AutoSummonKitsuneIslandToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Tween To Kitsune Island"] then
		pcall(function() TweenToKitsuneIslandToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Auto Collect Azure Ember"] then
		pcall(function() AutoCollectAzureEmberToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Auto Trade Azure Ember"] then
		pcall(function() AutoTradeAzureEmberToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Tween To Mirage Island"] then
		pcall(function() TweenToMirageIslandToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Auto Find Mirage"] then
		_G.FindMirage = true;
	end;

	if S.SeaStack and S.SeaStack["Auto Attack Seabeasts"] then
		pcall(function() AutoAttackSeaBeastsToggle:SetValue(true); end);
	end;

	if S.Farm and S.Farm["Auto Pirate Raid"] then
		pcall(function() AutoPirateRaidToggle:SetValue(true); end);
	end;

	if S.Farm and S.Farm["Auto Factory Raid"] then
		pcall(function() AutoFactoryRaidToggle:SetValue(true); end);
	end;

	if S.SettingSea then
		if S.SettingSea.Lightning then
			pcall(function() LightningToggle:SetValue(true); end);
		end;
		if S.SettingSea["Increase Speed Boat"] then
			pcall(function() IncreaseSpeedBoatToggle:SetValue(true); end);
		end;
		if S.SettingSea["No Clip Rock"] then
			pcall(function() NoClipRockToggle:SetValue(true); end);
		end;
	end;

	if S.Setting then
		if S.Setting["Custom Speed Enabled"] then
			pcall(function() SettingsTab:GetDescendants(); end);
		end;
	end;

	Library:Notify({
		Title   = "TRon Void Hub",
		Content = "Auto Execute completo! Funcoes salvas reativadas.",
		Icon    = "check-circle",
		Duration = 5
	});
end);

getgenv().ReadyForGuiLoaded = true

Library:Notify({
	Title   = "TRon Void Hub",
	Content = "Auto Execute completo! Funcoes salvas reativadas.",
	Icon    = "check-circle",
	Duration = 5
})
