local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local VirtualInputManager = nil
pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)

local player = Players.LocalPlayer
local mouse = nil
pcall(function() mouse = player and player:GetMouse() end)
local camera = workspace.CurrentCamera
local playerGui = player:WaitForChild("PlayerGui", 10)

-- ============================================================
-- VARIABLES DE ESTADO (OFF BY DEFAULT)
-- ============================================================
_G.G_SilentAimSkill = false
_G.G_SilentAimTargetPlayers = true
_G.G_SilentAimSelectedPlayer = ""

local SuperJumpPower = 500
local AntiStunSuperJumpEnabled = false
local NormalSuperJumpEnabled = false
local SuperJumpKey = Enum.KeyCode.G

local NoAnimEnabled = false
local NoAnimConnection = nil

local SanguineBoostEnabled = false
local SanguineBoostKey = Enum.KeyCode.Z
local SanguineNoCDEnabled = false
local SanguineAutoDropDuration = 2.0
local sanguineLagBusy = false

local SoruInfinitoEnabled = false
local SoruAimbotEnabled = false
local SoruComboEnabled = false
local SoruComboKey = Enum.KeyCode.Q
local SoruComboExecuting = false
local SkillAimbotEnabled = false

local PortalVFX_ON = false
local IS_RAINBOW = true
local CURRENT_COLOR = Color3.fromRGB(255, 255, 255)
local CURRENT_SEQ = ColorSequence.new(CURRENT_COLOR)
local CURRENT_ASSET = "rbxassetid://82169952275337"
local animatedParts = {}

local DEFAULT_WALLPAPER = "rbxassetid://132404081379154"

local PORTAL_COLORS = {
    {name = "Red", asset = "rbxassetid://76510744628039", color = Color3.fromRGB(255,0,0), rainbow = false},
    {name = "Blue", asset = "rbxassetid://117614041400664", color = Color3.fromRGB(0,85,255), rainbow = false},
    {name = "Green", asset = "rbxassetid://116385647591964", color = Color3.fromRGB(0,255,85), rainbow = false},
    {name = "Purple", asset = "rbxassetid://89347414337740", color = Color3.fromRGB(170,0,255), rainbow = false},
    {name = "White", asset = "rbxassetid://123827196345973", color = Color3.fromRGB(255,255,255), rainbow = false},
    {name = "Yellow", asset = "rbxassetid://97994607396986", color = Color3.fromRGB(255,255,0), rainbow = false},
    {name = "Void", asset = "rbxassetid://86697718165683", color = Color3.fromRGB(20,20,20), rainbow = false},
    {name = "Rainbow", asset = "rbxassetid://82169952275337", color = Color3.fromRGB(255,255,255), rainbow = true},
}

-- ============================================================
-- NO ANIMATIONS (COPIADO EXACTO DE SACRED_AHK_V12.5_CLEAN.LUA)
-- ============================================================
local ATTACK_KEYWORDS = {"attack", "slash", "punch", "m1", "combo", "hit", "tool", "ability", "skill", "kamehameha", "bullet", "gun", "sword", "melee", "fruit"}

local function isAttackAnim(track)
    local name = string.lower(track.Name)
    for _, kw in ipairs(ATTACK_KEYWORDS) do
        if string.find(name, kw) then return true end
    end
    if track.Priority == Enum.AnimationPriority.Action then return true end
    return false
end

local function StartNoAnimLoop()
    if NoAnimConnection then NoAnimConnection:Disconnect() end
    NoAnimConnection = RunService.Stepped:Connect(function()
        if not NoAnimEnabled then return end
        local char = player.Character
        if not char then return end
        local hum = char:FindFirstChild("Humanoid")
        if not hum then return end
        hum.AutoRotate = true 
        local animator = hum:FindFirstChild("Animator")
        if not animator then return end
        for _, track in pairs(animator:GetPlayingAnimationTracks()) do
            if not isAttackAnim(track) then
                track:Stop(0)
            end
        end
    end)
end

local FLASH_NAMES = {"flashstep", "teleport", "soru", "dash"}
local FLASH_IDS = {"17555632156", "18461649274", "616006778", "616010882", "5403485593", "5403491911"}

local function isFlashstep(track)
    if not track or not track.Name then return false end
    local nameLower = string.lower(track.Name)
    for _, n in ipairs(FLASH_NAMES) do
        if string.find(nameLower, n, 1, true) then return true end
    end
    local id = (track.Animation and track.Animation.AnimationId) and track.Animation.AnimationId:match("%d+") or ""
    for _, fid in ipairs(FLASH_IDS) do
        if id == fid then return true end
    end
    return false
end

-- ============================================================
-- 1. NORMAL SUPER JUMP (AHK ORIGINAL VELOCITY)
-- ============================================================
local function doNormalSuperJump()
    if not NormalSuperJumpEnabled then return end
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum or hum.Health <= 0 then return end

    hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, SuperJumpPower, hrp.AssemblyLinearVelocity.Z)
end

-- ============================================================
-- 2. SUPER JUMP ANTI STUN (MÁS ALTO + BYPASS DE BLOQUEOS)
-- ============================================================
local function doAntiStunSuperJump()
    if not AntiStunSuperJumpEnabled then return end
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    -- Romper stuns y bloqueos
    pcall(function() hum.PlatformStand = false end)
    pcall(function() hum.Sit = false end)
    pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)

    for _, child in ipairs(char:GetChildren()) do
        local n = child.Name:lower()
        if n:find("stun") or n:find("freeze") or n:find("busy") or n:find("disable") or n:find("nojump") or n:find("sew") or n:find("combo") or n:find("ragdoll") then
            pcall(function() child:Destroy() end)
        end
    end
    for _, child in ipairs(hrp:GetChildren()) do
        if child:IsA("BodyPosition") or child:IsA("BodyGyro") or child:IsA("AlignPosition") or child:IsA("AlignOrientation") then
            pcall(function() child:Destroy() end)
        end
    end

    pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)

    -- Ascenso más alto
    task.spawn(function()
        local stepHeight = (SuperJumpPower / 20)
        for i = 1, 10 do
            if not char or not hrp then break end
            hrp.CFrame = hrp.CFrame + Vector3.new(0, stepHeight, 0)
            hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, SuperJumpPower / 3, hrp.AssemblyLinearVelocity.Z)
            RunService.RenderStepped:Wait()
        end
    end)
end

-- ============================================================
-- BOOST DIRIGIDO AL MOUSE (CON PROTECCIÓN ANTI-PISO)
-- ============================================================
local function triggerSanguineBoost()
    if not SanguineBoostEnabled then return end
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local targetPos = mouse and mouse.Hit and mouse.Hit.Position
    local dir
    if targetPos then
        dir = (targetPos - hrp.Position)
        if dir.Magnitude > 0 then dir = dir.Unit end
    else
        dir = camera.CFrame.LookVector
    end

    -- Protección anti-clip: Evitar que el boost te mande por debajo del suelo
    if dir.Y < 0 then
        dir = Vector3.new(dir.X, 0.05, dir.Z).Unit
    end

    task.spawn(function()
        for i = 1, 35 do
            if not char or not hrp then break end
            hrp.CFrame = hrp.CFrame + (dir * 14.3)
            hrp.AssemblyLinearVelocity = dir * 160
            RunService.RenderStepped:Wait()
        end
    end)
end

-- ============================================================
-- SANGUINE Z NO COOLDOWN
-- ============================================================
local noCDCharConnection = nil
local function setSanguineNoCD(v)
    SanguineNoCDEnabled = v
    if v then
        noCDCharConnection = player.CharacterAdded:Connect(function(char)
            char:SetAttribute("AllCooldown", 3)
        end)
        if player.Character then
            player.Character:SetAttribute("AllCooldown", 3)
        end
    else
        if noCDCharConnection then noCDCharConnection:Disconnect() end
        if player.Character then
            player.Character:SetAttribute("AllCooldown", nil)
        end
    end
end

local function dropFPS(duration)
    if sanguineLagBusy then return end
    sanguineLagBusy = true
    local DROP_TO_FPS = 20
    local stop = tick() + duration
    local interval = 1 / DROP_TO_FPS
    local con
    con = RunService.RenderStepped:Connect(function()
        if tick() > stop then
            if con then con:Disconnect() end
            sanguineLagBusy = false
            return
        end
        local now = tick()
        while tick() - now < interval do end
    end)
end

local function startSanguineAutoWatcher(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if not hum then return end
    local animator = hum:WaitForChild("Animator", 5)
    if not animator then return end

    animator.AnimationPlayed:Connect(function(track)
        if not SanguineBoostEnabled then return end
        local animId = track.Animation and track.Animation.AnimationId or ""
        if animId:find("14586872029") or animId:find("14418367908") or animId:find("14418370048") or animId:find("15682737850") then
            dropFPS(SanguineAutoDropDuration)
            triggerSanguineBoost()
        end
    end)
end

player.CharacterAdded:Connect(startSanguineAutoWatcher)
if player.Character then startSanguineAutoWatcher(player.Character) end

-- ============================================================
-- INFINITE SORU
-- ============================================================
local function enforceSoru(char)
    if not char then return end
    pcall(function()
        if SoruInfinitoEnabled then
            char:SetAttribute("FlashstepCooldown", 1)
        end
    end)
    char.AttributeChanged:Connect(function(attr)
        if attr == "FlashstepCooldown" and SoruInfinitoEnabled then
            pcall(function()
                if char:GetAttribute("FlashstepCooldown") ~= 1 then
                    char:SetAttribute("FlashstepCooldown", 1)
                end
            end)
        end
    end)
end

player.CharacterAdded:Connect(enforceSoru)
if player.Character then enforceSoru(player.Character) end

task.spawn(function()
    while true do
        task.wait(0.3)
        if SoruInfinitoEnabled and player.Character then
            pcall(function()
                player.Character:SetAttribute("FlashstepCooldown", 1)
            end)
        end
    end
end)

local function fireSoruRemote()
    local char = player.Character
    if not char then return end
    pcall(function() char:SetAttribute("FlashstepCooldown", 1) end)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local targetPos = mouse and mouse.Hit and mouse.Hit.Position or (hrp.Position + hrp.CFrame.LookVector * 60)
    pcall(function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if remotes and remotes:FindFirstChild("CommF_") then
            remotes.CommF_:InvokeServer("Flashstep", targetPos)
        end
    end)
end

-- ============================================================
-- BUSCADOR DE OBJETIVOS (PLAYERS ONLY)
-- ============================================================
local currentSilentAimTarget = nil

local function GetClosestTargetToCenter()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    if _G.G_SilentAimSelectedPlayer ~= "" then
        local pTarget = Players:FindFirstChild(_G.G_SilentAimSelectedPlayer)
        if pTarget and pTarget.Character then
            local thrp = pTarget.Character:FindFirstChild("HumanoidRootPart")
            local thum = pTarget.Character:FindFirstChildOfClass("Humanoid")
            if thrp and thum and thum.Health > 0 then
                return thrp
            end
        end
    end

    local closest, minDist = nil, 5000
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local thrp = p.Character:FindFirstChild("HumanoidRootPart")
            local thum = p.Character:FindFirstChildOfClass("Humanoid")
            if thrp and thum and thum.Health > 0 then
                local dist = (thrp.Position - hrp.Position).Magnitude
                if dist <= minDist then
                    minDist = dist
                    closest = thrp
                end
            end
        end
    end
    return closest
end

-- ============================================================
-- AIMLOCK X AIMBOT (CAMERA AIMLOCK + METATABLE HOOK)
-- ============================================================
RunService.RenderStepped:Connect(function()
    if SkillAimbotEnabled then
        currentSilentAimTarget = GetClosestTargetToCenter()
        if currentSilentAimTarget then
            camera.CFrame = CFrame.new(camera.CFrame.Position, currentSilentAimTarget.Position)
        end
    else
        currentSilentAimTarget = nil
    end
end)

pcall(function()
    local mt = getrawmetatable and getrawmetatable(game)
    if mt then
        local oldIndex = mt.__index
        local oldNamecall = mt.__namecall
        if setreadonly then pcall(setreadonly, mt, false) end

        mt.__index = newcclosure(function(self, key)
            if not checkcaller() and SkillAimbotEnabled and self == mouse then
                if currentSilentAimTarget then
                    if key == "Hit" or key == "hit" then return CFrame.new(currentSilentAimTarget.Position) end
                    if key == "Target" or key == "target" then return currentSilentAimTarget end
                end
            end
            return oldIndex(self, key)
        end)

        if oldNamecall then
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod and getnamecallmethod():lower() or ""
                if not checkcaller() and SkillAimbotEnabled and (method == "invokeserver" or method == "fireserver") then
                    if currentSilentAimTarget then
                        local args = {...}
                        for i, arg in ipairs(args) do
                            if typeof(arg) == "Vector3" then args[i] = currentSilentAimTarget.Position
                            elseif typeof(arg) == "CFrame" then args[i] = CFrame.new(currentSilentAimTarget.Position) end
                        end
                        return oldNamecall(self, unpack(args))
                    end
                end
                return oldNamecall(self, ...)
            end)
        end
        if setreadonly then pcall(setreadonly, mt, true) end
    end
end)

-- ============================================================
-- SORU COMBO XZ (CON TASK.WAIT 0.30)
-- ============================================================
local function executeSoruCombo()
    if SoruComboExecuting then return end
    SoruComboExecuting = true
    task.wait(0.30)
    pcall(function()
        if VirtualInputManager then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.X, false, game)
            task.wait(0.08)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.X, false, game)
            task.wait(0.12)
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
            task.wait(0.08)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
        end
    end)
    task.wait(0.2)
    SoruComboExecuting = false
end

local function monitorSoruAnimations(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if not hum then return end
    hum.AnimationPlayed:Connect(function(track)
        if isFlashstep(track) then
            if SoruAimbotEnabled then
                local targetHrp = GetClosestTargetToCenter()
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if targetHrp and hrp then
                    pcall(function()
                        hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 3)
                    end)
                end
            end

            if SoruComboEnabled then
                task.spawn(executeSoruCombo)
            end
        end
    end)
end

player.CharacterAdded:Connect(monitorSoruAnimations)
if player.Character then monitorSoruAnimations(player.Character) end

-- ============================================================
-- PORTAL COLOR CHANGER & HOTBAR ICON
-- ============================================================
local PORTAL_WORDS = {
    "portal", "rift", "cportal", "spikes", "windbeamtrail",
    "floorportal", "portaldashlines", "portalchainbeam", "portalsurround",
    "centralsphere", "ejectionarc", "centralspin", "ring1", "ring3", "ring5",
    "halo", "singularity", "portaleye", "vportal", "particles"
}

local function isPortalRelated(child)
    local name = string.lower(child.Name)
    for _, kw in ipairs(PORTAL_WORDS) do
        if string.find(name, kw, 1, true) then return true end
    end
    return false
end

local function applyVFX(child)
    if not PortalVFX_ON then return end
    if not child or not child.Parent then return end
    if not isPortalRelated(child) then return end

    local solidColor = CURRENT_COLOR
    if IS_RAINBOW then
        if child:IsA("BasePart") then pcall(function() child.Material = Enum.Material.Neon end); animatedParts[child] = "Part"
        elseif child:IsA("ParticleEmitter") or child:IsA("Trail") or child:IsA("Beam") then animatedParts[child] = "FX" end
    else
        if child:IsA("BasePart") then pcall(function() child.Material = Enum.Material.Neon; child.Color = solidColor end)
        elseif child:IsA("ParticleEmitter") or child:IsA("Trail") or child:IsA("Beam") then pcall(function() child.Color = CURRENT_SEQ end) end
    end
end

local function refreshVFX()
    animatedParts = {}
    for _, d in ipairs(workspace:GetDescendants()) do pcall(applyVFX, d) end
end

workspace.DescendantAdded:Connect(function(child)
    if PortalVFX_ON then pcall(applyVFX, child) end
end)

RunService.Heartbeat:Connect(function()
    if not PortalVFX_ON or not IS_RAINBOW then return end
    local rc = Color3.fromHSV((os.clock() % 5) / 5, 1, 1)
    for part, ptype in pairs(animatedParts) do
        if part.Parent then
            pcall(function()
                if ptype == "Part" then part.Color = rc
                elseif ptype == "FX" then part.Color = ColorSequence.new(rc) end
            end)
        else
            animatedParts[part] = nil
        end
    end
end)

local function updateHotbarIcon()
    pcall(function()
        if not playerGui then return end
        local backpackGui = playerGui:FindFirstChild("Backpack") or playerGui:FindFirstChild("Main")
        if not backpackGui then return end
        local hotbar = backpackGui:FindFirstChild("Hotbar") or backpackGui:FindFirstChild("Container")
        if not hotbar then return end
        local container = hotbar:FindFirstChild("Container") or hotbar

        local frames = {}
        for _, child in ipairs(container:GetChildren()) do
            if child:IsA("Frame") then table.insert(frames, child) end
        end

        for idx, slot in ipairs(frames) do
            local border = slot:FindFirstChild("Border") or slot
            local existing = border:FindFirstChild("SacredPortalIcon")

            local isPortalSlot = false
            if PortalVFX_ON then
                if slot.Name == "2" or slot.LayoutOrder == 2 or idx == 2 then
                    isPortalSlot = true
                end
            end

            if isPortalSlot then
                if not existing then
                    existing = Instance.new("ImageLabel")
                    existing.Name = "SacredPortalIcon"
                    existing.Size = UDim2.new(1, 0, 1, 0)
                    existing.Position = UDim2.new(0, 0, 0, 0)
                    existing.BackgroundTransparency = 1
                    existing.ZIndex = 10
                    existing.Parent = border
                end
                existing.Image = CURRENT_ASSET
            else
                if existing then existing:Destroy() end
            end
        end
    end)
end

task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(updateHotbarIcon)
    end
end)

-- ============================================================
-- INTERFAZ GRÁFICA (PC VERSION BY ISACREDRIVALS)
-- ============================================================
local gui = Instance.new("ScreenGui")
gui.Name = "Sacred_AHK_PC"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 460, 0, 460)
main.Position = UDim2.new(0.5, -230, 0.5, -230)
main.BackgroundColor3 = Color3.fromRGB(10, 8, 18)
main.Active = true
main.Draggable = true
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
local mStroke = Instance.new("UIStroke", main)
mStroke.Color = Color3.fromRGB(170, 0, 255)
mStroke.Thickness = 2

local bgImg = Instance.new("ImageLabel", main)
bgImg.Image = DEFAULT_WALLPAPER
bgImg.Size = UDim2.new(1, 0, 1, 0)
bgImg.BackgroundTransparency = 1
bgImg.ImageTransparency = 0.4
bgImg.ScaleType = Enum.ScaleType.Crop
bgImg.ZIndex = 1
Instance.new("UICorner", bgImg).CornerRadius = UDim.new(0, 12)

local hdr = Instance.new("Frame", main)
hdr.Size = UDim2.new(1, 0, 0, 42)
hdr.BackgroundColor3 = Color3.fromRGB(14, 10, 26)
hdr.ZIndex = 4
Instance.new("UICorner", hdr).CornerRadius = UDim.new(0, 12)

local ttl = Instance.new("TextLabel", hdr)
ttl.Size = UDim2.new(0.5, 0, 0, 20)
ttl.Position = UDim2.new(0, 12, 0, 3)
ttl.BackgroundTransparency = 1
ttl.Text = "Sacred AHK Pc Version"
ttl.TextColor3 = Color3.fromRGB(255, 255, 255)
ttl.Font = Enum.Font.GothamBold
ttl.TextSize = 13
ttl.TextXAlignment = Enum.TextXAlignment.Left
ttl.ZIndex = 5

local subTtl = Instance.new("TextLabel", hdr)
subTtl.Size = UDim2.new(0.5, 0, 0, 14)
subTtl.Position = UDim2.new(0, 12, 0, 23)
subTtl.BackgroundTransparency = 1
subTtl.Text = "by iSacredRivals"
subTtl.TextColor3 = Color3.fromRGB(180, 120, 255)
subTtl.Font = Enum.Font.GothamBold
subTtl.TextSize = 10
subTtl.TextXAlignment = Enum.TextXAlignment.Left
subTtl.ZIndex = 5

local closeBtn = Instance.new("TextButton", hdr)
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -34, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 60)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.ZIndex = 6
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
end)

local hintLbl = Instance.new("TextLabel", hdr)
hintLbl.Size = UDim2.new(0, 110, 1, 0)
hintLbl.Position = UDim2.new(1, -150, 0, 0)
hintLbl.BackgroundTransparency = 1
hintLbl.Text = "[ H / M ] Toggle"
hintLbl.TextColor3 = Color3.fromRGB(190, 150, 255)
hintLbl.Font = Enum.Font.GothamBold
hintLbl.TextSize = 10
hintLbl.ZIndex = 5

local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -16, 1, -52)
scroll.Position = UDim2.new(0, 8, 0, 48)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = Color3.fromRGB(170, 0, 255)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ZIndex = 3

local lay = Instance.new("UIListLayout", scroll)
lay.Padding = UDim.new(0, 8)
lay.SortOrder = Enum.SortOrder.LayoutOrder

local function makeSection(title, height)
    local f = Instance.new("Frame", scroll)
    f.Size = UDim2.new(1, -8, 0, height)
    f.BackgroundColor3 = Color3.fromRGB(14, 10, 24)
    f.BackgroundTransparency = 0.15
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local st = Instance.new("UIStroke", f)
    st.Color = Color3.fromRGB(130, 50, 200)
    st.Thickness = 1
    st.Transparency = 0.4

    local tl = Instance.new("TextLabel", f)
    tl.Size = UDim2.new(1, -12, 0, 22)
    tl.Position = UDim2.new(0, 8, 0, 4)
    tl.BackgroundTransparency = 1
    tl.Text = title
    tl.TextColor3 = Color3.fromRGB(255, 255, 255)
    tl.Font = Enum.Font.GothamBold
    tl.TextSize = 11
    tl.TextXAlignment = Enum.TextXAlignment.Left
    return f
end

local function addToggle(parent, text, yPos, initVal, callback)
    local lb = Instance.new("TextLabel", parent)
    lb.Size = UDim2.new(0.65, 0, 0, 24)
    lb.Position = UDim2.new(0, 10, 0, yPos)
    lb.BackgroundTransparency = 1
    lb.Text = text
    lb.TextColor3 = Color3.fromRGB(220, 220, 235)
    lb.Font = Enum.Font.GothamBold
    lb.TextSize = 10
    lb.TextXAlignment = Enum.TextXAlignment.Left

    local bt = Instance.new("TextButton", parent)
    bt.Size = UDim2.new(0, 55, 0, 22)
    bt.Position = UDim2.new(1, -70, 0, yPos + 1)
    bt.BackgroundColor3 = initVal and Color3.fromRGB(100, 0, 200) or Color3.fromRGB(45, 40, 55)
    bt.Text = initVal and "ON" or "OFF"
    bt.TextColor3 = Color3.fromRGB(255, 255, 255)
    bt.Font = Enum.Font.GothamBold
    bt.TextSize = 10
    Instance.new("UICorner", bt).CornerRadius = UDim.new(0, 5)

    local val = initVal
    bt.MouseButton1Click:Connect(function()
        val = not val
        bt.BackgroundColor3 = val and Color3.fromRGB(100, 0, 200) or Color3.fromRGB(45, 40, 55)
        bt.Text = val and "ON" or "OFF"
        callback(val)
    end)
    return bt
end

-- SUPER JUMP SECTION
local sjSec = makeSection("⚡ Super Jump", 150)
addToggle(sjSec, "Super Jump anti stun", 28, AntiStunSuperJumpEnabled, function(v) AntiStunSuperJumpEnabled = v end)
addToggle(sjSec, "Normal Super Jump", 56, NormalSuperJumpEnabled, function(v) NormalSuperJumpEnabled = v end)
addToggle(sjSec, "No Animation Mode", 84, NoAnimEnabled, function(v)
    NoAnimEnabled = v
    if v then StartNoAnimLoop() else if NoAnimConnection then NoAnimConnection:Disconnect(); NoAnimConnection = nil end end
end)

local pwrLbl = Instance.new("TextLabel", sjSec)
pwrLbl.Size = UDim2.new(0, 80, 0, 20)
pwrLbl.Position = UDim2.new(0, 10, 0, 116)
pwrLbl.BackgroundTransparency = 1
pwrLbl.Text = "Jump Power:"
pwrLbl.TextColor3 = Color3.fromRGB(190, 190, 210)
pwrLbl.Font = Enum.Font.GothamBold
pwrLbl.TextSize = 10
pwrLbl.TextXAlignment = Enum.TextXAlignment.Left

local mBtn = Instance.new("TextButton", sjSec)
mBtn.Size = UDim2.new(0, 24, 0, 20)
mBtn.Position = UDim2.new(0, 92, 0, 116)
mBtn.BackgroundColor3 = Color3.fromRGB(45, 40, 55)
mBtn.Text = "-"
mBtn.TextColor3 = Color3.fromRGB(255,255,255)
mBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", mBtn).CornerRadius = UDim.new(0, 4)

local pValLbl = Instance.new("TextLabel", sjSec)
pValLbl.Size = UDim2.new(0, 40, 0, 20)
pValLbl.Position = UDim2.new(0, 118, 0, 116)
pValLbl.BackgroundTransparency = 1
pValLbl.Text = tostring(SuperJumpPower)
pValLbl.TextColor3 = Color3.fromRGB(170, 0, 255)
pValLbl.Font = Enum.Font.GothamBold
pValLbl.TextSize = 11

local pBtn = Instance.new("TextButton", sjSec)
pBtn.Size = UDim2.new(0, 24, 0, 20)
pBtn.Position = UDim2.new(0, 160, 0, 116)
pBtn.BackgroundColor3 = Color3.fromRGB(45, 40, 55)
pBtn.Text = "+"
pBtn.TextColor3 = Color3.fromRGB(255,255,255)
pBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 4)

mBtn.MouseButton1Click:Connect(function() SuperJumpPower = math.max(100, SuperJumpPower - 50); pValLbl.Text = tostring(SuperJumpPower) end)
pBtn.MouseButton1Click:Connect(function() SuperJumpPower = math.min(1500, SuperJumpPower + 50); pValLbl.Text = tostring(SuperJumpPower) end)

local keyBindBtn = Instance.new("TextButton", sjSec)
keyBindBtn.Size = UDim2.new(0, 60, 0, 22)
keyBindBtn.Position = UDim2.new(1, -70, 0, 116)
keyBindBtn.BackgroundColor3 = Color3.fromRGB(45, 40, 55)
keyBindBtn.Text = "[" .. SuperJumpKey.Name .. "]"
keyBindBtn.TextColor3 = Color3.fromRGB(210, 180, 255)
keyBindBtn.Font = Enum.Font.GothamBold
keyBindBtn.TextSize = 10
Instance.new("UICorner", keyBindBtn).CornerRadius = UDim.new(0, 5)

local listeningForJumpKey = false
keyBindBtn.MouseButton1Click:Connect(function()
    listeningForJumpKey = true
    keyBindBtn.Text = "[...]"
end)

-- SANGUINE BOOST & NO CD SECTION (KEY Z POR DEFECTO)
local sangSec = makeSection("🩸 Sanguine Z Boost / No CD", 90)
addToggle(sangSec, "Sanguine Z Boost Active", 26, SanguineBoostEnabled, function(v)
    SanguineBoostEnabled = v
end)

addToggle(sangSec, "Sanguine Z No Cooldown", 56, SanguineNoCDEnabled, function(v)
    setSanguineNoCD(v)
end)

-- SORU & AIMBOT SECTION (TECLA SELECCIONABLE EN COMBO XZ)
local soruSec = makeSection("⚡ Soru Engine & Aimbot", 165)
addToggle(soruSec, "Infinite Soru (No CD)", 28, SoruInfinitoEnabled, function(v)
    SoruInfinitoEnabled = v
    if player.Character then enforceSoru(player.Character) end
end)

addToggle(soruSec, "Soru Aimbot", 56, SoruAimbotEnabled, function(v)
    SoruAimbotEnabled = v
end)

addToggle(soruSec, "Soru Combo XZ", 84, SoruComboEnabled, function(v)
    SoruComboEnabled = v
end)

local soruComboKeyBtn = Instance.new("TextButton", soruSec)
soruComboKeyBtn.Size = UDim2.new(0, 60, 0, 22)
soruComboKeyBtn.Position = UDim2.new(1, -140, 0, 85)
soruComboKeyBtn.BackgroundColor3 = Color3.fromRGB(45, 40, 55)
soruComboKeyBtn.Text = "[" .. SoruComboKey.Name .. "]"
soruComboKeyBtn.TextColor3 = Color3.fromRGB(210, 180, 255)
soruComboKeyBtn.Font = Enum.Font.GothamBold
soruComboKeyBtn.TextSize = 10
Instance.new("UICorner", soruComboKeyBtn).CornerRadius = UDim.new(0, 5)

local listeningForSoruComboKey = false
soruComboKeyBtn.MouseButton1Click:Connect(function()
    listeningForSoruComboKey = true
    soruComboKeyBtn.Text = "[...]"
end)

local targetBtn = Instance.new("TextButton", soruSec)
targetBtn.Size = UDim2.new(1, -16, 0, 22)
targetBtn.Position = UDim2.new(0, 8, 0, 112)
targetBtn.BackgroundColor3 = Color3.fromRGB(28, 22, 42)
targetBtn.Text = "🎯 Target: " .. (_G.G_SilentAimSelectedPlayer ~= "" and _G.G_SilentAimSelectedPlayer or "Nearest")
targetBtn.TextColor3 = Color3.fromRGB(210, 180, 255)
targetBtn.Font = Enum.Font.GothamBold
targetBtn.TextSize = 10
Instance.new("UICorner", targetBtn).CornerRadius = UDim.new(0, 5)

targetBtn.MouseButton1Click:Connect(function()
    local plist = {"Nearest"}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then table.insert(plist, p.Name) end
    end
    local currIdx = 1
    for i, name in ipairs(plist) do
        if name == (_G.G_SilentAimSelectedPlayer ~= "" and _G.G_SilentAimSelectedPlayer or "Nearest") then currIdx = i break end
    end
    currIdx = (currIdx % #plist) + 1
    local sel = plist[currIdx]
    _G.G_SilentAimSelectedPlayer = (sel == "Nearest" and "" or sel)
    targetBtn.Text = "🎯 Target: " .. sel
end)

addToggle(soruSec, "aimlock x aimbot", 138, SkillAimbotEnabled, function(v)
    _G.G_SilentAimSkill = v
    _G.G_SilentAimTargetPlayers = v
    SkillAimbotEnabled = v
end)

-- PORTAL COLOR CHANGER SECTION
local portalSec = makeSection("🌌 Portal Color Changer", 120)
addToggle(portalSec, "Portal VFX & Icon", 26, PortalVFX_ON, function(v)
    PortalVFX_ON = v
    if v then refreshVFX() end
    pcall(updateHotbarIcon)
end)

local colorContainer = Instance.new("Frame", portalSec)
colorContainer.Size = UDim2.new(1, -16, 0, 60)
colorContainer.Position = UDim2.new(0, 8, 0, 54)
colorContainer.BackgroundTransparency = 1

local colorLayout = Instance.new("UIGridLayout", colorContainer)
colorLayout.CellSize = UDim2.new(0, 42, 0, 26)
colorLayout.CellPadding = UDim2.new(0, 6, 0, 4)
colorLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

for _, c in ipairs(PORTAL_COLORS) do
    local cBtn = Instance.new("TextButton", colorContainer)
    cBtn.BackgroundColor3 = c.color
    cBtn.Text = c.name:sub(1, 3)
    cBtn.TextColor3 = (c.name == "White" or c.name == "Yellow") and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
    cBtn.Font = Enum.Font.GothamBold
    cBtn.TextSize = 9
    Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 4)
    local cSt = Instance.new("UIStroke", cBtn)
    cSt.Color = Color3.fromRGB(255, 255, 255)
    cSt.Thickness = 1
    cSt.Transparency = 0.5

    cBtn.MouseButton1Click:Connect(function()
        IS_RAINBOW = c.rainbow
        CURRENT_COLOR = c.color
        CURRENT_SEQ = ColorSequence.new(c.color)
        CURRENT_ASSET = c.asset
        if PortalVFX_ON then refreshVFX() end
        pcall(updateHotbarIcon)
    end)
end

-- UNFILTERED KEY INPUT LISTENER
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if listeningForJumpKey and input.UserInputType == Enum.UserInputType.Keyboard then
        SuperJumpKey = input.KeyCode
        keyBindBtn.Text = "[" .. SuperJumpKey.Name .. "]"
        listeningForJumpKey = false
        return
    end

    if listeningForSoruComboKey and input.UserInputType == Enum.UserInputType.Keyboard then
        SoruComboKey = input.KeyCode
        soruComboKeyBtn.Text = "[" .. SoruComboKey.Name .. "]"
        listeningForSoruComboKey = false
        return
    end

    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.H or input.KeyCode == Enum.KeyCode.M then
            if not UserInputService:GetFocusedTextBox() then
                main.Visible = not main.Visible
            end
            return
        end

        if UserInputService:GetFocusedTextBox() then return end

        if (AntiStunSuperJumpEnabled or NormalSuperJumpEnabled) and input.KeyCode == SuperJumpKey then
            if AntiStunSuperJumpEnabled then task.spawn(doAntiStunSuperJump) end
            if NormalSuperJumpEnabled then task.spawn(doNormalSuperJump) end
        end
        if SanguineBoostEnabled and input.KeyCode == SanguineBoostKey then
            task.spawn(triggerSanguineBoost)
        end
        if SoruComboEnabled and input.KeyCode == SoruComboKey then
            task.spawn(executeSoruCombo)
        end
        if SoruInfinitoEnabled and input.KeyCode == Enum.KeyCode.R then
            task.spawn(fireSoruRemote)
        end
    end
end)

print("[Sacred AHK PC] Task.wait(0.30) Soru Combo Delay Applied!")
