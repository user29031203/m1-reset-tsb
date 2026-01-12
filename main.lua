local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local vim = game:GetService("VirtualInputManager")
local lp = Players.LocalPlayer

-- load original m1 reset script
loadstring(game:HttpGet("https://raw.githubusercontent.com/minhnhatdepzai8-cloud/The-Strongest-BattleGround/refs/heads/main/M1RESET.lua.txt"))()

-- find first TextButton created by m1 reset script
local frame = CoreGui:WaitForChild("CustomUI"):WaitForChild("Frame")
local buttons = {}
for _, child in ipairs(frame:GetChildren()) do
	if child:IsA("TextButton") then
		table.insert(buttons, child)
	end
end

if #buttons == 0 then
	warn("No TextButtons found")
	return
end

local button = buttons[1]

-- click function
local function clickButton()
	if not button then return end

    local pos = button.AbsolutePosition
    local size = button.AbsoluteSize
    local insetY = GuiService:GetGuiInset().Y

    local centerX = math.floor(pos.X + (size.X / 2))
    local centerY = math.floor(pos.Y + (size.Y / 2) + insetY)

    local originalBehavior = UserInputService.MouseBehavior
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    
    vim:SendTouchEvent(0, 0, centerX, centerY) 
    task.wait(0.01)
    vim:SendTouchEvent(0, 2, centerX, centerY) 
  
    UserInputService.MouseBehavior = originalBehavior
end

-- bind click func to R key
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.R then
		clickButton()
	end
end)