-- Sweet Exploit — Premium Key Loader (Glass UI)
-- Compatible with Delta, Codex, Fluxus, Wave, Arceus X, etc.
-- Ready to be obfuscated with Luraph.

local API_URL = "https://sweet-keysystem-production.up.railway.app/api/verify"
local RUNTIME_URL = "https://raw.githubusercontent.com/lol123rivals-dotcom/random2-/main/r.lua?v=20261123-toggle-compat-1"
local KEY_PATH = "SweetExploit/key.txt"
local DISCORD_INVITE = "https://discord.gg/cmYtfCmQU"

local Players = game:GetService("Players")
local Tween = game:GetService("TweenService")
local Input = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local function httpRequest(options)
    local fn = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    if fn then
        return fn(options)
    end
    -- Fallback for basic executors
    if options.Method == "GET" and game.HttpGet then
        local ok, body = pcall(function() return game:HttpGet(options.Url, true) end)
        return { Success = ok, StatusCode = ok and 200 or 500, Body = body }
    end
    error("Executor does not support HTTP requests.")
end

local function getHWID()
    if gethwid then
        local ok, h = pcall(gethwid)
        if ok and type(h) == "string" and #h > 0 then return h end
    end
    local ok, cid = pcall(function() return game:GetService("RbxAnalyticsService"):GetClientId() end)
    if ok and type(cid) == "string" and #cid > 0 then return cid end
    return tostring(player.UserId) .. "-hwid-" .. tostring(game.PlaceId)
end

local function loadScript()
    local ok, source = pcall(function() return game:HttpGet(RUNTIME_URL, true) end)
    assert(ok and type(source) == "string", "Unable to download Sweet Exploit. Check connection.")
    local run, err = loadstring(source)
    assert(run, err)
    return run()
end

-- Save / Load local key
local function saveKey(k)
    if writefile then
        pcall(function()
            if makefolder and isfolder and not isfolder("SweetExploit") then
                makefolder("SweetExploit")
            end
            writefile(KEY_PATH, tostring(k):gsub("%s+", ""))
        end)
    end
end

local function readSavedKey()
    if isfile and readfile then
        local ok, val = pcall(function()
            if isfile(KEY_PATH) then return readfile(KEY_PATH) end
        end)
        if ok and type(val) == "string" and #val > 4 then
            return val:gsub("%s+", "")
        end
    end
    return nil
end

-- UI Builder
local C = {
    Shell = Color3.fromRGB(10, 10, 10),
    Card = Color3.fromRGB(14, 14, 14),
    Border = Color3.fromRGB(42, 42, 42),
    Text = Color3.fromRGB(245, 245, 245),
    Muted = Color3.fromRGB(155, 155, 155),
    Accent = Color3.fromRGB(220, 220, 220),
    AccentDark = Color3.fromRGB(180, 180, 180),
    Success = Color3.fromRGB(60, 220, 110),
    Error = Color3.fromRGB(240, 75, 75),
    Warning = Color3.fromRGB(245, 175, 45)
}

local font = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local fontMedium = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
local fontBold = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)

local gui = Instance.new("ScreenGui")
gui.Name = "SweetExploitKeyUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 9999

local parented = pcall(function()
    local hidden = gethui and gethui()
    gui.Parent = hidden or CoreGui
end)
if not parented then
    gui.Parent = player:WaitForChild("PlayerGui")
end

local blur = Instance.new("BlurEffect")
blur.Name = "SweetKey_Blur"
blur.Size = 8
blur.Enabled = true
blur.Parent = Lighting

local card = Instance.new("CanvasGroup")
card.Name = "KeyCard"
card.Size = UDim2.fromOffset(400, 310)
card.AnchorPoint = Vector2.new(0.5, 0.5)
card.Position = UDim2.fromScale(0.5, 0.5)
card.BackgroundColor3 = C.Shell
card.BackgroundTransparency = 0.12
card.BorderSizePixel = 0
card.GroupTransparency = 1
card.Parent = gui

local cardCorner = Instance.new("UICorner")
cardCorner.CornerRadius = UDim.new(0, 24)
cardCorner.Parent = card

local cardStroke = Instance.new("UIStroke")
cardStroke.Color = C.Accent
cardStroke.Transparency = 0.85
cardStroke.Thickness = 1.2
cardStroke.Parent = card

local uiScale = Instance.new("UIScale")
uiScale.Scale = 1
uiScale.Parent = card

local function updateScale()
    local cam = workspace.CurrentCamera
    if cam then
        local vp = cam.ViewportSize
        local s = math.clamp(math.min(vp.X / 460, vp.Y / 360), 0.72, 1.05)
        uiScale.Scale = s
    end
end
updateScale()
if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
end

-- Header elements
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = "Sweet Exploit"
title.FontFace = fontBold
title.TextSize = 22
title.TextColor3 = C.Text
title.BackgroundTransparency = 1
title.Size = UDim2.fromOffset(300, 28)
title.Position = UDim2.fromOffset(24, 22)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = card

local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.Text = "Premium Key Verification"
subtitle.FontFace = fontMedium
subtitle.TextSize = 12
subtitle.TextColor3 = C.Muted
subtitle.BackgroundTransparency = 1
subtitle.Size = UDim2.fromOffset(300, 18)
subtitle.Position = UDim2.fromOffset(24, 48)
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = card

-- Input Box Frame
local inputFrame = Instance.new("Frame")
inputFrame.Name = "InputFrame"
inputFrame.Size = UDim2.fromOffset(352, 46)
inputFrame.Position = UDim2.fromOffset(24, 82)
inputFrame.BackgroundColor3 = C.Card
inputFrame.BorderSizePixel = 0
inputFrame.Parent = card

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 12)
inputCorner.Parent = inputFrame

local inputStroke = Instance.new("UIStroke")
inputStroke.Color = C.Border
inputStroke.Transparency = 0.2
inputStroke.Thickness = 1
inputStroke.Parent = inputFrame

local keyInput = Instance.new("TextBox")
keyInput.Name = "KeyBox"
keyInput.Size = UDim2.fromOffset(275, 46)
keyInput.Position = UDim2.fromOffset(14, 0)
keyInput.BackgroundTransparency = 1
keyInput.Text = ""
keyInput.PlaceholderText = "SWEET-XXXXX-XXXXX-XXXXX"
keyInput.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
keyInput.TextColor3 = C.Text
keyInput.FontFace = fontMedium
keyInput.TextSize = 14
keyInput.ClearTextOnFocus = false
keyInput.TextXAlignment = Enum.TextXAlignment.Left
keyInput.Parent = inputFrame

local pasteBtn = Instance.new("TextButton")
pasteBtn.Name = "PasteButton"
pasteBtn.Size = UDim2.fromOffset(52, 30)
pasteBtn.Position = UDim2.fromOffset(292, 8)
pasteBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
pasteBtn.Text = "Paste"
pasteBtn.TextColor3 = C.Muted
pasteBtn.FontFace = fontMedium
pasteBtn.TextSize = 12
pasteBtn.BorderSizePixel = 0
pasteBtn.Parent = inputFrame

local pasteCorner = Instance.new("UICorner")
pasteCorner.CornerRadius = UDim.new(0, 8)
pasteCorner.Parent = pasteBtn

-- Status text
local status = Instance.new("TextLabel")
status.Name = "Status"
status.Text = "Enter your key or obtain one in Discord with .key"
status.FontFace = font
status.TextSize = 12
status.TextColor3 = C.Muted
status.BackgroundTransparency = 1
status.Size = UDim2.fromOffset(352, 32)
status.Position = UDim2.fromOffset(24, 134)
status.TextWrapped = true
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = card

-- Verify Button
local verifyBtn = Instance.new("TextButton")
verifyBtn.Name = "VerifyButton"
verifyBtn.Size = UDim2.fromOffset(352, 44)
verifyBtn.Position = UDim2.fromOffset(24, 178)
verifyBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
verifyBtn.Text = "Verify Key"
verifyBtn.TextColor3 = C.Text
verifyBtn.FontFace = fontBold
verifyBtn.TextSize = 15
verifyBtn.BorderSizePixel = 0
verifyBtn.Parent = card

local verifyCorner = Instance.new("UICorner")
verifyCorner.CornerRadius = UDim.new(0, 12)
verifyCorner.Parent = verifyBtn

local verifyStroke = Instance.new("UIStroke")
verifyStroke.Color = C.Accent
verifyStroke.Transparency = 0.75
verifyStroke.Thickness = 1.2
verifyStroke.Parent = verifyBtn

-- Actions row (Get Key / Reset HWID info)
local getBtn = Instance.new("TextButton")
getBtn.Name = "GetKeyButton"
getBtn.Size = UDim2.fromOffset(170, 36)
getBtn.Position = UDim2.fromOffset(24, 234)
getBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
getBtn.Text = "Get Key (Discord)"
getBtn.TextColor3 = C.Muted
getBtn.FontFace = fontMedium
getBtn.TextSize = 12
getBtn.BorderSizePixel = 0
getBtn.Parent = card

local getCorner = Instance.new("UICorner")
getCorner.CornerRadius = UDim.new(0, 10)
getCorner.Parent = getBtn

local resetInfoBtn = Instance.new("TextButton")
resetInfoBtn.Name = "ResetInfoButton"
resetInfoBtn.Size = UDim2.fromOffset(170, 36)
resetInfoBtn.Position = UDim2.fromOffset(206, 234)
resetInfoBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
resetInfoBtn.Text = "Reset HWID (.resethwid)"
resetInfoBtn.TextColor3 = C.Muted
resetInfoBtn.FontFace = fontMedium
resetInfoBtn.TextSize = 12
resetInfoBtn.BorderSizePixel = 0
resetInfoBtn.Parent = card

local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 10)
resetCorner.Parent = resetInfoBtn

-- Draggable implementation
local dragging, dragStart, startPos = false, nil, nil
card.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = card.Position
    end
end)
Input.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        card.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
local function stopDrag() dragging = false end
Input.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        stopDrag()
    end
end)

-- Paste logic
pasteBtn.Activated:Connect(function()
    local text = ""
    if getclipboard then
        local ok, cb = pcall(getclipboard)
        if ok and type(cb) == "string" then text = cb end
    end
    if #text > 0 then
        keyInput.Text = text:gsub("%s+", "")
        status.Text = "Key pasted from clipboard."
        status.TextColor3 = C.Muted
    else
        status.Text = "Clipboard is empty or unsupported."
        status.TextColor3 = C.Warning
    end
end)

getBtn.Activated:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_INVITE)
        status.Text = "Discord invite copied to clipboard! Type .key in #keys"
        status.TextColor3 = C.Success
    else
        status.Text = "Join: " .. DISCORD_INVITE
        status.TextColor3 = C.Muted
    end
end)

resetInfoBtn.Activated:Connect(function()
    status.Text = "To reset your HWID, type .resethwid in the Discord key channel."
    status.TextColor3 = C.Warning
end)

-- Verification flow
local verifying = false

local function performVerification(keyToTest)
    if verifying then return end
    verifying = true

    status.Text = "Verifying key with server..."
    status.TextColor3 = C.Warning
    verifyBtn.Text = "Verifying..."

    task.spawn(function()
        local hwid = getHWID()
        local payload = string.format('{"key":%q,"hwid":%q}', keyToTest, hwid)

        local ok, resp = pcall(function()
            return httpRequest({
                Url = API_URL,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = payload
            })
        end)

        if not ok or not resp then
            status.Text = "Error: Could not connect to verification server."
            status.TextColor3 = C.Error
            verifyBtn.Text = "Verify Key"
            verifying = false
            return
        end

        local body = resp.Body or ""
        local httpSuccess = resp.StatusCode == 200 or resp.Success == true

        if httpSuccess and body:find('"success"%s*:%s*true') then
            saveKey(keyToTest)
            status.Text = "Access granted! Loading Sweet Exploit..."
            status.TextColor3 = C.Success
            verifyBtn.Text = "Verified!"

            task.delay(0.4, function()
                Tween:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {GroupTransparency = 1}):Play()
                Tween:Create(blur, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {Size = 0}):Play()
                task.wait(0.4)
                gui:Destroy()
                blur:Destroy()
                loadScript()
            end)
        else
            -- If key is deleted, revoked, invalid, or blacklisted: wipe saved local key file
            if body:find('"KEY_DELETED"') or body:find('"INVALID_KEY"') or body:find('"BLACKLISTED"') then
                if delfile and isfile and isfile(KEY_PATH) then
                    pcall(delfile, KEY_PATH)
                elseif writefile then
                    pcall(writefile, KEY_PATH, "")
                end
                keyInput.Text = ""
            end

            -- Extract message
            local msg = body:match('"message"%s*:%s*"([^"]+)"') or "Invalid or expired key."
            status.Text = msg
            status.TextColor3 = C.Error
            verifyBtn.Text = "Verify Key"
            verifying = false
        end
    end)
end

verifyBtn.Activated:Connect(function()
    local text = keyInput.Text:gsub("%s+", "")
    if #text < 5 then
        status.Text = "Please enter a valid key format."
        status.TextColor3 = C.Warning
        return
    end
    performVerification(text)
end)

-- Auto-login check with saved key
local savedKey = readSavedKey()
if savedKey then
    keyInput.Text = savedKey
    status.Text = "Saved key found. Auto-authenticating..."
    status.TextColor3 = C.Warning
    -- Fade in smoothly
    Tween:Create(card, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {GroupTransparency = 0}):Play()
    performVerification(savedKey)
else
    -- Fade in prompt
    Tween:Create(card, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {GroupTransparency = 0}):Play()
end
