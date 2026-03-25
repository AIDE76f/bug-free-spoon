--[[ 
    GOD SNIPER V3 - ANTI-DEATH & FAST COLLECT
    - يتجاهل الليزر والفخاخ
    - يكرر اللمس بسرعة لزيادة المال
    - يستهدف الأغراض المجانية فقط
]]

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleBtn = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

-- إعدادات الواجهة (سريعة وبسيطة)
ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 220, 0, 120)
MainFrame.Position = UDim2.new(0.1, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true

ToggleBtn.Parent = MainFrame
ToggleBtn.Size = UDim2.new(0.8, 0, 0.4, 0)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
ToggleBtn.Text = "ACTIVATE GOD SNIPER"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ToggleBtn.TextColor3 = Color3.new(1,1,1)

StatusLabel.Parent = MainFrame
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0.8, 0)
StatusLabel.Text = "Status: Standing By"
StatusLabel.TextColor3 = Color3.new(0.5, 0.5, 0.5)

-- الكلمات المحظورة (تجنب الموت)
local BANNED_NAMES = {"Lava", "Kill", "Laser", "Death", "Trap", "Void"}
local isRunning = false

local function isSafe(objName)
    for _, word in ipairs(BANNED_NAMES) do
        if string.find(objName:lower(), word:lower()) then return false end
    end
    return true
end

ToggleBtn.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    ToggleBtn.Text = isRunning and "DEACTIVATE" or "ACTIVATE GOD SNIPER"
    ToggleBtn.BackgroundColor3 = isRunning and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(0, 150, 255)
    
    task.spawn(function()
        while isRunning do
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("TouchTransmitter") then
                    local part = obj.Parent
                    -- فحص الأمان: لا يلمس الليزر ولا يلمس أشياء الروبوكس
                    if part and isSafe(part.Name) and not part:FindFirstChild("RobuxIcon") then
                        -- تكرار اللمس 5 مرات بسرعة البرق لكل غرض
                        for i = 1, 5 do 
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, part, 0)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, part, 1)
                        end
                    end
                end
            end
            task.wait(0.1) -- سرعة المسح (كل 0.1 ثانية)
        end
    end)
end)
