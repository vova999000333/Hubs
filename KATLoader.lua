local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Organic - Kat", "Midnight")
local Player = Window:NewTab("Player")
local KAT = Window:NewTab("KAT")
local Tools = Window:NewTab("Tools")
local More = Window:NewTab("More")
local Credit = Window:NewTab("Credit")
local KATSection = KAT:NewSection("KAT")
local CreditSection = Credit:NewSection("Credit")
local MoreSection = More:NewSection("More")
local PlayerSection = Player:NewSection("Player")
local ToolsSection = Tools:NewSection("Tools")
-- Setup
local plr = game:GetService("Players").LocalPlayer
if plr:FindFirstChild("HasKey") ~= nil then
	if plr:FindFirstChild("HasKey").Value == false then
		plr:Kick("Invalid key!")
	end
end
-- Variables
local Players = game.Players:GetPlayers()
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local infjumpenabled = false
local Noclip = nil
local Clip = nil
local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(32, 32, 38)
}
-- Functions
function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end
function noclip()
	Clip = false
	local function Nocl()
		if Clip == false and game.Players.LocalPlayer.Character ~= nil then
			for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
					v.CanCollide = false
				end
			end
		end
		wait(0.50) -- basic optimization
	end
	Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

game:GetService("UserInputService").JumpRequest:Connect(function()
	if infjumpenabled == true then
		game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState("Jumping")
	end
end)

function infJumpOn()
	infjumpenabled = true
end

function infJumpOff()
	infjumpenabled = false
end

function clip()
	if Noclip then Noclip:Disconnect() end
	Clip = true
end
-- Player Tab

PlayerSection:NewSlider("Walkspeed", "Changes the walkspeed", 250, 16, function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)
 
PlayerSection:NewSlider("Jumppower", "Changes the jumppower", 250, 50, function(v)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)

PlayerSection:NewButton("Reset", "RespawnCaracter", function()
	local char = game.Players.LocalPlayer.Character
	if char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid"):ChangeState(15) end
	char:ClearAllChildren()
	local newChar = Instance.new("Model")
	newChar.Parent = workspace
	game.Players.LocalPlayer.Character = newChar
	wait()
	game.Players.LocalPlayer.Character = char
	newChar:Destroy()
end)

PlayerSection:NewButton("Godmode", "Inf Health", function()
	local Player = game.Players.LocalPlayer
	local Character = Player.Character
	local Humanoid = Character.Humanoid
 
	print('Godmode working.')
 
	Humanoid.MaxHealth = 999999
	Humanoid.Health = Humanoid.MaxHealth / 2
 
	Humanoid.HealthChanged:connect(function()
    if Humanoid.Health < 10 then
        Humanoid.Health = Humanoid.MaxHealth
    end
end)
    print("GodMode Enabled")
end)

PlayerSection:NewButton("Fly [E]", "Press 'E' to fly", function()
	repeat wait() 
	until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("UpperTorso") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid") 
local mouse = game.Players.LocalPlayer:GetMouse() 
repeat wait() until mouse
local plr = game.Players.LocalPlayer 
local torso = plr.Character.UpperTorso 
local flying = true
local deb = true 
local ctrl = {f = 0, b = 0, l = 0, r = 0} 
local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
local maxspeed = 120 
local speed = 0 
 
function Fly() 
local bg = Instance.new("BodyGyro", torso) 
bg.P = 9e4 
bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
bg.cframe = torso.CFrame 
local bv = Instance.new("BodyVelocity", torso) 
bv.velocity = Vector3.new(0,0.1,0) 
bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 
repeat wait() 
plr.Character.Humanoid.PlatformStand = true 
if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then 
speed = speed+.5+(speed/maxspeed) 
if speed > maxspeed then 
speed = maxspeed 
end 
elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then 
speed = speed-1 
if speed < 0 then 
speed = 0 
end 
end 
if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then 
bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 
elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then 
bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
else 
bv.velocity = Vector3.new(0,0.1,0) 
end 
bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
until not flying 
ctrl = {f = 0, b = 0, l = 0, r = 0} 
lastctrl = {f = 0, b = 0, l = 0, r = 0} 
speed = 0 
bg:Destroy() 
bv:Destroy() 
plr.Character.Humanoid.PlatformStand = false 
end 
mouse.KeyDown:connect(function(key) 
if key:lower() == "e" then 
if flying then flying = false 
else 
flying = true 
Fly() 
end 
elseif key:lower() == "w" then 
ctrl.f = 1 
elseif key:lower() == "s" then 
ctrl.b = -1 
elseif key:lower() == "a" then 
ctrl.l = -1 
elseif key:lower() == "d" then 
ctrl.r = 1 
end 
end) 
mouse.KeyUp:connect(function(key) 
if key:lower() == "w" then 
ctrl.f = 0 
elseif key:lower() == "s" then 
ctrl.b = 0 
elseif key:lower() == "a" then 
ctrl.l = 0 
elseif key:lower() == "d" then 
ctrl.r = 0 
end 
end)
Fly()
end)

PlayerSection:NewToggle("InfJump", "On / Off", function(state)
    if state then
		infJumpOn()
        print("infJump On")
    else
		infJumpOff()
        print("infJump Off")
    end
end)

PlayerSection:NewToggle("Noclip", "On / Off", function(state)
    if state then
		noclip()
        print("Noclip On")
    else
		clip()
        print("Noclip Off")
    end
end)
-- KAT Tab
KATSection:NewButton("Silent Aim Head", "Click for apply settings", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/vova999000333/Hubs/main/KAT_HeadPart.lua", true)()
end)
KATSection:NewButton("Silent Aim HumanoidRootPart", "Click for apply settings", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/vova999000333/Hubs/main/KAT_aim.lua", true)()
end)
-- Tool Tab
ToolsSection:NewButton("TpTool", "Teleport Tool", function()
	mouse = game.Players.LocalPlayer:GetMouse()
	tool = Instance.new("Tool")
	tool.RequiresHandle = false
	tool.Name = "Teleport Tool"
	tool.Activated:connect(function()
		local pos = mouse.Hit+Vector3.new(0,2.5,0)
		pos = CFrame.new(pos.X,pos.Y,pos.Z)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
	end)
	tool.Parent = game.Players.LocalPlayer.Backpack
end)
ToolsSection:NewButton("Btools", "Btools [Visual]", function()
	backpack = game:GetService("Players").LocalPlayer.Backpack

	hammer = Instance.new("HopperBin")
	hammer.Name = "Hammer"
	hammer.BinType = 4
	hammer.Parent = backpack

	cloneTool = Instance.new("HopperBin")
	cloneTool.Name = "Clone"
	cloneTool.BinType = 3
	cloneTool.Parent = backpack

	grabTool = Instance.new("HopperBin")
	grabTool.Name = "Grab"
	grabTool.BinType = 2
	grabTool.Parent = backpack
end)
-- More Tab
MoreSection:NewButton("ReJoin", "Rejoin On the Server", function()
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
-- KeyBind GUI
MoreSection:NewKeybind("Toggle Gui", "Show / Hide Gui", Enum.KeyCode.LeftAlt, function()
	Library:ToggleUI()
end)
MoreSection:NewButton("Radio Gui", "Play your own sounds [Visual]", function()
-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Play = Instance.new("TextButton")
local SoundTrack = Instance.new("Sound")
local UICorner_2 = Instance.new("UICorner")
local Stop = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local TextBox = Instance.new("TextBox")
local Exit = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")

local gui = Frame

local dragging
local dragInput
local dragStart
local startPos
--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SoundTrack.Parent = ScreenGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(105, 106, 96)
Frame.BackgroundTransparency = 0.250
Frame.Position = UDim2.new(0.0436991863, 0, 0.592730999, 0)
Frame.Size = UDim2.new(0, 182, 0, 97)

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Frame

Play.Name = "Play"
Play.Parent = Frame
Play.BackgroundColor3 = Color3.fromRGB(0, 255, 21)
Play.Position = UDim2.new(0.0494505502, 0, 0.556701005, 0)
Play.Size = UDim2.new(0, 81, 0, 31)
Play.Font = Enum.Font.SourceSans
Play.Text = "Play"
Play.TextColor3 = Color3.fromRGB(0, 0, 0)
Play.TextScaled = true
Play.TextSize = 14.000
Play.TextWrapped = true

UICorner_2.CornerRadius = UDim.new(0, 15)
UICorner_2.Parent = Play

Stop.Name = "Stop"
Stop.Parent = Frame
Stop.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Stop.Position = UDim2.new(0.494505495, 0, 0.556701005, 0)
Stop.Size = UDim2.new(0, 81, 0, 31)
Stop.Font = Enum.Font.SourceSans
Stop.Text = "Stop"
Stop.TextColor3 = Color3.fromRGB(0, 0, 0)
Stop.TextScaled = true
Stop.TextSize = 14.000
Stop.TextWrapped = true

UICorner_3.CornerRadius = UDim.new(0, 15)
UICorner_3.Parent = Stop

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 0.300
TextBox.Position = UDim2.new(0.0769230798, 0, 0.0824742243, 0)
TextBox.Size = UDim2.new(0, 153, 0, 35)
TextBox.Font = Enum.Font.SourceSans
TextBox.ClearTextOnFocus = false
TextBox.PlaceholderColor3 = Color3.fromRGB(40, 40, 40)
TextBox.PlaceholderText = "Id pls..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox.TextSize = 22.000

Exit.Name = "Exit"
Exit.Parent = Frame
Exit.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Exit.Position = UDim2.new(0.917582393, 0, -0.144329891, 0)
Exit.Size = UDim2.new(0, 28, 0, 30)
Exit.Font = Enum.Font.SourceSans
Exit.Text = "X"
Exit.TextColor3 = Color3.fromRGB(0, 0, 0)
Exit.TextScaled = true
Exit.TextSize = 14.000
Exit.TextWrapped = true

UICorner_4.CornerRadius = UDim.new(0, 15)
UICorner_4.Parent = Exit
Play.MouseButton1Click:Connect(function()
	if TextBox.Text ~= "" then
		SoundTrack.SoundId = "rbxassetid://"..TextBox.Text
		SoundTrack:Play()
	end
end)

Stop.MouseButton1Click:Connect(function()
	SoundTrack:Stop()
end)

Exit.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)



local function update(input)
	local delta = input.Position - dragStart
	gui.Position = gui:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), 'Out', 'Linear', 0, true); -- drag speed
end

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
print("Loaded Gui")
end)
-- Color Picker
local PickerTheme = More:NewSection("Custom Theme")
for theme, color in pairs(themes) do
    PickerTheme:NewColorPicker(theme, "Change your "..theme, color, function(color3)
        Library:ChangeColor(theme, color3)
    end)
end
-- Credits
CreditSection:NewButton("Created by : Настюшка#7777", "Click to copy", function()
	setclipboard("Настюшка#7777")
end)
CreditSection:NewButton("Idea by : LA_???#1000", "Click to copy", function()
	setclipboard("LA_???#1000")
end)
