-- Sweet Exploit | native Roblox UI | desktop + touch
-- Execute this entire file in Delta. The optimized 128px icon is bundled below (3 KiB).
-- Optional local images go through getcustomasset; each must be <= 512 KiB.
-- Monody feature engines are loaded locally from the bundle, on demand.

local Config = {
    Title = "Sweet Exploit",
    LogoPath = "SweetExploit/icon-v3.jpg", -- written from the bundled image on first run
    AvatarPath = "", -- empty = the current player's Roblox avatar photo
    MaxAssetBytes = 512 * 1024,
    ToggleKey = Enum.KeyCode.RightControl,
    DimBackground = true,
    WindowScale = 0.90,
    FontFamily = "rbxasset://fonts/families/Roboto.json",
    GlassTransparency = 0.18,
    WorldBlur = true,
    BlurSize = 3,
    OnChanged = function(key, value, state)
        -- Optional observer. Feature callbacks are wired independently below.
    end,
}

-- Optimized copy of the selected photo; no external image host is needed.
local SweetLogoBase64 = [[
/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAcFBQYFBAcGBgYIBwcICxILCwoKCxYPEA0SGhYbGhkWGRgcICgiHB4mHhgZIzAkJiorLS4tGyIyNTEsNSgsLSz/
2wBDAQcICAsJCxULCxUsHRkdLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCz/wAARCACAAIADASIAAhEBAxEB/8QA
HQAAAAcBAQEAAAAAAAAAAAAAAgMEBQYHCAEACf/EADUQAAEDAwIFAgQEBgMBAAAAAAECAwQABREGIQcSMUFRE2EUIjJxI4GhwQgVQlJikRax0eH/xAAXAQEB
AQEAAAAAAAAAAAAAAAABAAID/8QAHBEBAQEBAQEAAwAAAAAAAAAAAAERAiExEkFx/9oADAMBAAIRAxEAPwDOG1er1dxtW2XK9ivV0HFSBwPFd5cGukY75rlS
DbQpawgDc0rbt7gkhogkk9qftEaJn6ouKAy2tLAOCsDr7CpDrmHE07cEWmKhAcaGXljc58ZqwxYOktT6e07bY0CAw2Epx6rjqRzOHuas2DrG0yW0mGht1Z/p
CQaye1OUlYKVbipPY9VrhPJKUcqh/UkkU6sapVarVqJlP8wtEOUnGAHWUkj7GoZqXgNpO7NLVboirbLO6QhZ5D+RzSvhtrL+bRfTe9Ra098VYinUPr9EA84A
Ufas0svy/wCG3UjZfUwuK6lCeZGV4Kvb71Tl4tcm0T3ocpstvNK5VJPYjtX0FU6UFST2AOcday1x50g4xqZ27IbCUy1ZwO58iqBR3P7UEnPXr5pXMhqivlta
QCPfNEEBSQMBOO9XxBPKYLSQ0ghXcmiQcUJbZQkEkHIzsaBSHq7jAB81yvUp6pXobQ1x1ldksRmlBpJHqOkfKkUi0dp//kepoduUsobeWAtYGcJ7mtp6F0db
dM2lpiDHS22kbZ3Uo/3E+alDTYNJW/QOlvQjoBeCCVLO6vJrKGrLku46ilyVnJccJ/Wtk60HpWqWs9Ayo/oaxNdDzznD/kar8UFNuZpyhuqCthj3NI47GBml
ClqA5R0rJTaw6zn2JTfwTxRyKCz/AJEVZelOLMuZqf1rg4kIcTheNkjzgfpVCMu4GAacrc+428CknNIbNs14ZvUdx5pQIbXyfoCf+zUb4paWa1DpB5KU4kRs
usqHUeR/qopwruzzEJtpwkhxwqOfyqzp7yXkLaP0qT/8ow/WCbuh5u5vofUVLSspJ84NIu9SbXLSGdVXBpCQE+sSKjXLVi1woGNyOlAKPFKlN4PigFAB3Bx7
VfxE2DnpXuU0cU10HlQoFIJPQ+KvV4V2G8yrDdWp0RZQ60oEHz7VpnhlxxZv8tMC6IREkH6CFfKv2371ljG9OFluEi1XZiXFx6zSwpORnf7VSptviDMZGjZr
4WD+Aof7FYsnJ5p7mOhUcVfF41FdJnChT9x5W3nwMpTttmqJCeeRnvmtWZACl1xsYUBijULU5nDdO1rs381uKGeblyOtSKbpI2yN6jmOXFZ1uc2zUSjR1rIB
HWpPYLIuVLSkJJ3ou3wjJkpSlPt0q3NHWGLDLbj5GSQeUDJPtilnNP2j7GqIhlJTgpNO+rNTw9PW56TIfSkpSeUZ3JqUW+2oFuKkoLTriTjPVJNZX46OTmNW
uwHlKPpNtjlByOhP71FXupbom636TKT9Li1KB+5J/empO5o+PbZMlClpQeVPUkUWW1IUQoYo/QOLsbB6UnUwalNws7seQtCm1J5T0IpsehlKiDWsBlU15FFl
rFOhj4O+cUWYxO2M0YjaWhjbOc1P+G+h3bzcm5DrZ5AcjI6DzRuheGdx1TObX8OpEXm3WRgGtQ6a0PA03aktJSCUpytXmmefUqDiryQtMNwm/lSkpQAP9/sK
pWOxzSAB3q0eMFyTLvXoNH8JCjjHeq2jozIAHc1rr1JJYWvh3w4dsHrT7qa5fFNMR0dSOZVGh+0C2x48KIt+YQBtkZPvXIen5My/NRHMLkOEFeOifasWNTrJ
h00Np4vOpdcTt1q/LJZmIjCVBCebAGcVCWLWbPFDDKRgDBVTWvVE2LBd9N1xC2nUp64OMgH9ajLiztR31nTtldmODmWBhCfJ/wDKpi82KDqOS9dZ2FyH0pJW
ftTTxB1TMfkpiPSHF+rGJSCc7g5/aq9u3EOY0y3GZ2SlCQd+vyiiBKX7Jb4DKm/l5f7vNVbqD0Gpq0tEHBPShTdWTpaCkuFKT2pjcdU4oqUck06MbeuekrPd
ATKhNqUf6gMGoFqPg7FdbW9a3fTV19NfT/dWuelJJTbi0HBASO1bCiY3B6c9u/JZZHjdRqQ2/h9pjTAbk3iShw5xlxOQT7JqzGISnDlXyppk1PoRi/D1PWWh
1IwnfYU+AutPEDQ1uZS23dGUEbD8NQA/SkuqeKVmVFTEgSC8HvqUgEZHgVVk/hndIMpZ9MvpTuOXvTIuE9BDr0oFKx8oB7VnNUpn1XcDcLy450BJwPAprtzJ
dkgJG9BkuF2QtZ7mnawM/iFXLknapRNrKWrTbRIUwkuY2J61LtD2hxSnLnIH4jqsiopZoy7zOaYGSw2cn3q24LCI0VDSBgJGKZNJSpPqjcA4otqw2ubNUuXG
B9RISvCsDbpRySADQkqznFVhlR7iHwoh3y3N3G1LUiZCHMlvOUupByU/esoaohmDfH4xBHpqxv4Arc9meUXFNE5SodKqXilwIj3qJLvllecRPQnnXHUMpcx1
x4OK5plhRydhiubAUolRnIz62nE8qkHBFJynahqVvnFervtXMHxXRh4dMUFSsEJH1GuqUEJKicAdaSuP+i0XFbuOfSnv7CoirpLahQnHFEFQBx/7We9bXT1p
DpzuomrH1pqBLbTjPqZCd3FA9/AqkLpNM+aslQT1O5pBC2C44B271JLcDyJYZB5lfUfPtUfhJLjvKgZJqy9G2FbriV+iSR1UoZxRmpNNI2lNutiXFjDjn+6l
zR+TJ60hhw/SSCs8ygMDwB7UuSgAV1zIA0uA996PYaWtPSkzLKEuFWCSadYhOQEozms0ldsSI6ytSVFWMAAU7s86msuDBPaimGlNIyvlT7ClI6VxrTG/HLSy
bDxEmlhoNx5OH0AdMK64/PNViWjnpWlv4lbYFv2uaE7qbU2T9jn96zu5HIJzVA3MDg5rql53xQFKCRknApKpbzxOMMsjqpXU1tC5755m2W0lalHOB4Hn2qMa
mv6LYy4n1gqSofOvOzY8Ck2qdaw7S641DeDrpTylSTk5qo7/AKiTJKlSH+Y9fSQckn3NMwE2pr+qa4UoJDYO3+R81FWmHJTpPbzRiluTXxtjmOwFSKHbQwwg
rHLkZz5oQNoYZt60vOp5wndQO2asjh1rOJdfio7paYUhz8JGQMp/fpVVXyb8LBc5Tgq+UVCUznmHgtlxSFg5CknBFM6/FfWzkSmFdFp296UIUgjIOax/a7tc
HprTaZL6ipQBAWTzb1rq0Nctsj8yCg+mn5T1G3SuvPWgvjpDiwkHGakEJDDKgEgqWe+Kb4EYLWBsKdmkJbUQ2MnuquXd3wwoLaVKClZJHvQ65nCcmvJ3SM1x
aVjxu09Lv1khiIwXSypRVgbgECs3TdNT2HFhyK4nl65Sa21JZDzRSRv2qPybXFd5vUjtrJ2OUitz2JXkHXsu4IK0wJA8KWnb9BTdchqK+uFCZi221bcoHKB+
poaLnbIrji0fECOn6gUfSfemC48QHH+ePbm0NDOAo7nFaxnTJqbTjNoSoy7v6z6v6GwST+dQZ1gKcyEkA/SD1NTGbDcUx8ZLJdkOn5QtWSfypVZdLtFXx11c
S00Nwg9VfYVYCDTOmklpU6afTjI3Kj39hQ7hORIkLc5QhtIwhA7AdBUhliTfFiHb45RFbHypG2fvUHvMGdbkynZDCwprqnGeXxmrEjGo5okSAw2chsZP3piD
SjkcvXvT/pywy9S39mEyklby/nV4Hc1f8zhJp6Ta0tNxA0+hvkS6gkHOOpHeqc3oy4YODvDiNFgsX+4IDsh0c7CDuGx/d9/+qudtPYDaoHw8flW2MvT1wQUS
IWzZPRaM7EVY0RAI5q6zyAqiIIxTqxsAMUljoB2FKfUSz13VXG+tSFBGQRXgMDFJmXVPO+Eij8nmxisEKmiZhLy6didqaJhPMsHtTyn/2Q==
]]

local Players = game:GetService("Players")
local Input = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")
local Run = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
if not player then return end

local env = (getgenv and getgenv()) or _G
local previous = env.SweetExploit
if type(previous) == "table" and type(previous.Destroy) == "function" then
    pcall(previous.Destroy)
end

local C = {
    Shell = Color3.fromRGB(0, 0, 0),
    Sidebar = Color3.fromRGB(0, 0, 0),
    Card = Color3.fromRGB(0, 0, 0),
    Raised = Color3.fromRGB(8, 8, 8),
    Border = Color3.fromRGB(32, 32, 32),
    Text = Color3.fromRGB(245, 245, 245),
    Muted = Color3.fromRGB(164, 164, 164),
    Soft = Color3.fromRGB(106, 106, 106),
    Accent = Color3.fromRGB(220, 220, 220),
    AccentDark = Color3.fromRGB(207, 207, 207),
    Selection = Color3.fromRGB(18, 18, 18),
    Ink = Color3.fromRGB(12, 12, 12),
}
local regular = Font.new(Config.FontFamily, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local medium = Font.new(Config.FontFamily, Enum.FontWeight.Medium, Enum.FontStyle.Normal)
local bold = Font.new(Config.FontFamily, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local connections, tweens, alive = {}, {}, true
local state = {
    Tab = "Dashboard",
    AimbotEnabled = false, TeamCheck = true, WallCheck = true,
    TargetPart = "Head", FOV = 160, Smoothing = 0.18,
    PVPEnabled = false, SafeHealth = 30, AutoEquip = false, Weapon = "Melee",
    ShowFOV = false, PlayerESP = false, ShowDistance = true, ESPDistance = 1500,
    MacroEnabled = false, MacroDelay = 0.25, MacroKey = "Z", RepeatMacro = false,
    CompactNumbers = true, ShowDim = Config.DimBackground,
}
local api = {State = state, Config = Config}
env.SweetExploit = api

local function connect(signal, callback)
    local connection = signal:Connect(callback)
    connections[#connections + 1] = connection
    return connection
end
local function new(class, props, parent)
    local item = Instance.new(class)
    for k, v in pairs(props or {}) do item[k] = v end
    item.Parent = parent
    return item
end
local function corner(item, radius)
    return new("UICorner", {CornerRadius = UDim.new(0, radius or 16)}, item)
end
local function stroke(item, color, transparency, thickness)
    return new("UIStroke", {
        Color = color or C.Border, Transparency = transparency or 0,
        Thickness = thickness or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, item)
end
local function frame(parent, name, color, radius)
    local f = new("Frame", {
        Name = name, BackgroundColor3 = color or C.Card, BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
    }, parent)
    if radius then corner(f, radius) end
    return f
end
local function glassHighlight(parent, radius)
    local sheen = frame(parent, "GlassHighlight", C.Accent, radius)
    sheen.BackgroundTransparency, sheen.Active = 0.96, false
    new("UIGradient", {
        Rotation = 90,
        Color = ColorSequence.new({ColorSequenceKeypoint.new(0, C.Accent), ColorSequenceKeypoint.new(1, C.Accent)}),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.35, 0.7), NumberSequenceKeypoint.new(1, 1)}),
    }, sheen)
end
local function place(item, x, y, w, h)
    item.Position = UDim2.fromOffset(x, y)
    item.Size = UDim2.fromOffset(math.max(0, w), math.max(0, h))
end
local function label(parent, text, size, color, font)
    return new("TextLabel", {
        Name = "Text", BackgroundTransparency = 1, BorderSizePixel = 0,
        Text = text, TextSize = size or 14, FontFace = font or regular,
        TextColor3 = color or C.Text, TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd,
        Size = UDim2.fromScale(1, 1),
    }, parent)
end
local function animate(item, props)
    if tweens[item] then tweens[item]:Cancel() end
    local tween = Tween:Create(item, TweenInfo.new(0.16, Enum.EasingStyle.Quad), props)
    tweens[item] = tween
    tween:Play()
end
local function button(parent, name, text, color, radius)
    local b = new("TextButton", {
        Name = name, Text = text or "", FontFace = regular, TextSize = 13,
        TextColor3 = C.Text, BackgroundColor3 = color or C.Card,
        BorderSizePixel = 0, AutoButtonColor = false, Size = UDim2.fromOffset(44, 44),
    }, parent)
    corner(b, radius or 10)
    return b
end
local function line(parent, ax, ay, bx, by, color, width, transparency)
    local dx, dy = bx - ax, by - ay
    local f = frame(parent, "Line", color)
    f.AnchorPoint = Vector2.new(0.5, 0.5)
    f.Position = UDim2.fromOffset((ax + bx) / 2, (ay + by) / 2)
    f.Size = UDim2.fromOffset(math.sqrt(dx * dx + dy * dy), width or 1.4)
    f.Rotation = math.deg(math.atan2(dy, dx))
    f.BackgroundTransparency = transparency or 0
    return f
end
local function ring(parent, x, y, size, color, thickness)
    local f = frame(parent, "Ring", color, size)
    f.BackgroundTransparency = 1
    place(f, x, y, size, size)
    stroke(f, color, 0, thickness or 1.3)
    return f
end
-- All icons are native geometry, including the brand mark.
local function icon(parent, kind, color)
    color = color or C.Text
    local root = frame(parent, "Icon_" .. kind, color)
    root.BackgroundTransparency = 1
    root.Size = UDim2.fromOffset(22, 22)
    local function l(a, b, c, d, width) return line(root, a, b, c, d, color, width) end
    if kind == "Dashboard" then
        for row = 0, 1 do for col = 0, 1 do
            local cell = frame(root, "GridCell", color, 2)
            cell.BackgroundTransparency = 1
            place(cell, 3 + col * 10, 3 + row * 10, 6, 6)
            stroke(cell, color, 0, 1.2)
        end end
    elseif kind == "Aimbot" then
        ring(root, 5, 5, 12, color)
        l(11, 1, 11, 7); l(11, 15, 11, 21); l(1, 11, 7, 11); l(15, 11, 21, 11)
    elseif kind == "PVP" then
        l(4, 3, 18, 18, 2); l(18, 3, 4, 18, 2)
        l(2, 14, 8, 20); l(14, 20, 20, 14)
    elseif kind == "Visual" then
        l(2, 11, 6, 6); l(6, 6, 16, 6); l(16, 6, 20, 11)
        l(20, 11, 16, 16); l(16, 16, 6, 16); l(6, 16, 2, 11)
        ring(root, 8, 8, 6, color)
    elseif kind == "Macro" then
        local f = frame(root, "Keys", color, 3); f.BackgroundTransparency = 1
        place(f, 2, 5, 18, 13); stroke(f, color)
        for row = 0, 1 do for col = 0, 3 do
            l(5 + col * 4, 9 + row * 4, 6 + col * 4, 9 + row * 4)
        end end
    elseif kind == "Settings" then
        ring(root, 5, 5, 12, color); ring(root, 9, 9, 4, color)
        for i = 0, 7 do
            local a = i * math.pi / 4
            l(11 + math.cos(a) * 7, 11 + math.sin(a) * 7,
                11 + math.cos(a) * 10, 11 + math.sin(a) * 10, 2)
        end
    elseif kind == "Support" then
        local f = frame(root, "Bubble", color, 5); f.BackgroundTransparency = 1
        place(f, 3, 3, 16, 14); stroke(f, color)
        l(7, 17, 7, 21); l(7, 21, 11, 17)
        local t = label(root, "?", 12, color, medium); t.TextXAlignment = Enum.TextXAlignment.Center
        place(t, 3, 2, 16, 15)
    elseif kind == "Bell" then
        l(5, 15, 7, 7); l(7, 7, 11, 4); l(11, 4, 15, 7)
        l(15, 7, 17, 15); l(5, 15, 17, 15); l(9, 18, 13, 18)
    elseif kind == "Close" then l(6, 6, 16, 16); l(16, 6, 6, 16)
    elseif kind == "Health" then
        local points = {{11,19},{3,11},{3,6},{6,3},{9,3},{11,6},{13,3},{16,3},{19,6},{19,11},{11,19}}
        for i = 2, #points do l(points[i-1][1], points[i-1][2], points[i][1], points[i][2], 1.5) end
    elseif kind == "Energy" then
        l(13,2,5,12,1.7); l(5,12,11,12,1.7); l(11,12,9,20,1.7)
        l(9,20,18,9,1.7); l(18,9,12,9,1.7); l(12,9,13,2,1.7)
    elseif kind == "Fruit" then
        local points = {{11,7},{6,6},{3,9},{3,14},{6,19},{10,20},{12,19},{16,20},{19,15},{19,10},{16,7},{11,7}}
        for i = 2, #points do l(points[i-1][1], points[i-1][2], points[i][1], points[i][2], 1.4) end
        l(11,7,12,3); l(12,3,16,2); l(16,2,15,5); l(15,5,12,6)
    elseif kind == "Race" then
        local points = {{3,7},{7,4},{15,4},{19,7},{17,17},{11,20},{5,17},{3,7}}
        for i = 2, #points do l(points[i-1][1], points[i-1][2], points[i][1], points[i][2], 1.4) end
        l(6,10,9,10); l(13,10,16,10); l(9,15,13,15)
    elseif kind == "Chevron" then l(6, 9, 11, 14); l(11, 14, 16, 9)
    elseif kind == "Arrow" then
        l(6, 16, 16, 6); l(9, 6, 16, 6); l(16, 6, 16, 13)
    elseif kind == "Brand" then
        l(3, 3, 3, 19, 3); l(19, 3, 19, 19, 3)
        l(3, 11, 19, 11, 3); l(3, 4, 11, 11, 2); l(19, 18, 11, 11, 2)
    else ring(root, 4, 4, 14, color) end
    return root
end

local function localAsset(path)
    if type(path) ~= "string" or path == "" then return nil end
    local asset = getcustomasset or getsynasset
    if type(asset) ~= "function" or type(readfile) ~= "function" or type(isfile) ~= "function" then
        warn("Sweet Exploit: local asset functions unavailable; using native fallback.")
        return nil
    end
    local ok, content = pcall(function()
        if not isfile(path) then return nil end
        return readfile(path)
    end)
    if not ok or type(content) ~= "string" or #content > Config.MaxAssetBytes then
        warn("Sweet Exploit: missing/unreadable image or image exceeds 512 KiB: " .. path)
        return nil
    end
    local success, uri = pcall(asset, path)
    return success and uri or nil
end
api.LoadLocalAsset = localAsset

local function decodeBase64(encoded)
    local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    local values, output = {}, {}
    for i = 1, #alphabet do values[alphabet:sub(i, i)] = i - 1 end
    encoded = encoded:gsub("%s", "")
    for i = 1, #encoded, 4 do
        local c, d = encoded:sub(i + 2, i + 2), encoded:sub(i + 3, i + 3)
        local value = values[encoded:sub(i, i)] * 262144 + values[encoded:sub(i + 1, i + 1)] * 4096
            + (values[c] or 0) * 64 + (values[d] or 0)
        output[#output + 1] = string.char(math.floor(value / 65536) % 256)
        if c ~= "=" then output[#output + 1] = string.char(math.floor(value / 256) % 256) end
        if d ~= "=" then output[#output + 1] = string.char(value % 256) end
    end
    return table.concat(output)
end
local function prepareSweetLogo()
    if Config.LogoPath == "SweetExploit/icon-v3.jpg" and type(writefile) == "function"
        and type(isfile) == "function" and type(readfile) == "function" then
        local ok, err = pcall(function()
            if not isfile(Config.LogoPath) then
                if type(makefolder) == "function" then
                    if type(isfolder) ~= "function" or not isfolder("SweetExploit") then
                        pcall(makefolder, "SweetExploit")
                    end
                end
                local bytes = decodeBase64(SweetLogoBase64)
                assert(#bytes <= Config.MaxAssetBytes, "Bundled logo exceeds asset limit")
                writefile(Config.LogoPath, bytes)
            end
        end)
        if not ok then warn("Sweet Exploit: could not prepare local logo: " .. tostring(err)) end
    end
    return localAsset(Config.LogoPath)
end
local sweetImageURI = prepareSweetLogo()
SweetLogoBase64 = nil

local gui = new("ScreenGui", {
    Name = "SweetExploitUI", ResetOnSpawn = false, IgnoreGuiInset = true,
    DisplayOrder = 80, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})
local hiddenOK, hidden = pcall(function() return gethui and gethui() end)
local parented = pcall(function() gui.Parent = (hiddenOK and hidden) or CoreGui end)
if not parented then gui.Parent = player:WaitForChild("PlayerGui") end

local dim = frame(gui, "Backdrop", Color3.fromRGB(0, 0, 0))
dim.BackgroundTransparency = 0.75
dim.Visible = state.ShowDim
local glassBlur = new("BlurEffect", {
    Name = "SweetExploit_GlassBlur", Size = math.clamp(Config.BlurSize, 0, 24), Enabled = Config.WorldBlur,
}, Lighting)
local shell = frame(gui, "Window", C.Shell, 28)
shell.Active = true
shell.BackgroundTransparency = Config.GlassTransparency
shell.AnchorPoint = Vector2.new(0.5, 0.5)
local panelScale = new("UIScale", {Name = "FitEntirePanel", Scale = 1}, shell)
shell.ClipsDescendants = true
stroke(shell, C.Accent, 0.78)
glassHighlight(shell, 28)
local boot=frame(gui,"Startup",Color3.fromRGB(3,3,3))
boot.ZIndex,boot.Active,boot.BackgroundTransparency=9000,true,.08
local bootCard=new("CanvasGroup",{Name="StartupCard",AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),
    Size=UDim2.fromOffset(300,194),BackgroundColor3=Color3.fromRGB(10,10,10),BackgroundTransparency=.1,BorderSizePixel=0,GroupTransparency=0},boot)
corner(bootCard,22);stroke(bootCard,C.Accent,.88)
local bootScale=new("UIScale",{Scale=.94},bootCard)
local bootLogo=new("ImageLabel",{Image=sweetImageURI or "",BackgroundTransparency=1,ScaleType=Enum.ScaleType.Crop},bootCard)
place(bootLogo,122,24,56,56);corner(bootLogo,14)
local bootTitle=label(bootCard,Config.Title,20,C.Text,bold);place(bootTitle,22,91,256,28);bootTitle.TextXAlignment=Enum.TextXAlignment.Center
local bootStatus=label(bootCard,"Preparing interface",12,C.Muted);place(bootStatus,22,123,256,20);bootStatus.TextXAlignment=Enum.TextXAlignment.Center
local bootTrack=frame(bootCard,"ProgressTrack",Color3.fromRGB(28,28,28),3);place(bootTrack,30,161,240,3)
local bootFill=frame(bootTrack,"Progress",C.Accent,3);bootFill.Size=UDim2.fromScale(.2,1)
Tween:Create(bootScale,TweenInfo.new(.25,Enum.EasingStyle.Quad),{Scale=1}):Play()
function api.BootProgress(value,message)
 if boot.Parent then bootStatus.Text=message;Tween:Create(bootFill,TweenInfo.new(.18,Enum.EasingStyle.Quad),{Size=UDim2.fromScale(math.clamp(value,0,1),1)}):Play()end
end
function api.FinishBoot()
 task.delay(.15,function()
  if not alive or not boot.Parent then return end
  Tween:Create(bootCard,TweenInfo.new(.22,Enum.EasingStyle.Quad),{GroupTransparency=1}):Play()
  Tween:Create(boot,TweenInfo.new(.22,Enum.EasingStyle.Quad),{BackgroundTransparency=1}):Play()
  task.delay(.24,function()if boot.Parent then boot:Destroy()end end)
 end)
end
local sidebar = frame(shell, "Sidebar", C.Sidebar, 24)
sidebar.BackgroundTransparency = 0.26
glassHighlight(sidebar, 24)
local brandIcon = icon(sidebar, "Brand")
local brandImageURI = sweetImageURI
if brandImageURI then
    brandIcon:Destroy()
    brandIcon = new("ImageLabel", {Name = "LocalLogo", Image = brandImageURI,
        BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Crop}, sidebar)
    corner(brandIcon, 8)
end
local brand = label(sidebar, Config.Title, 18, C.Text, medium)
local edition = label(sidebar, "By Darling", 11, C.Muted, medium)
edition.Name = "BrandCredit"
local nav = new("ScrollingFrame", {
    Name = "ScrollingTabs", BackgroundTransparency = 1, BorderSizePixel = 0,
    ScrollBarThickness = 2, ScrollBarImageColor3 = C.Accent,
    CanvasSize = UDim2.fromOffset(0, 268), ScrollingDirection = Enum.ScrollingDirection.Y,
    ElasticBehavior = Enum.ElasticBehavior.WhenScrollable, Active = true,
}, sidebar)
local navButtons, footerButtons = {}, {}
-- Sidebar schema: {internal page ID, displayed name, geometry icon name}.
local tabGroups = {
    {Title = "Home", Tabs = {{"Dashboard", "Dashboard", "Dashboard"}}},
    {Title = "Combat", Tabs = {
        {"Aimbot", "Aimbot", "Aimbot"}, {"PVP", "PvP", "PVP"}, {"Soru", "Soru", "Arrow"},
    }},
    {Title = "Visuals", Tabs = {
        {"Visual", "Visual", "Visual"}, {"ESP", "ESP", "Visual"}, {"HUD", "HUD", "Dashboard"},
        {"Skins", "Skins", "Brand"}, {"Animations", "Animations", "Macro"}, {"Waifu", "Waifu", "Health"},
    }},
    {Title = "Automation", Tabs = {
        {"Macro", "Macro", "Macro"}, {"TikiKaitun", "Tiki Kaitun", "Dashboard"},
        {"LeviathanKaitun", "Leviathan Kaitun", "Dashboard"}, {"Dungeons", "Dungeons", "PVP"},
    }},
    {Title = "Players", Tabs = {
        {"PlayerList", "Player List", "Support"}, {"PlayerControl", "Player Control", "Aimbot"},
    }},
    {Title = "Personalization", Tabs = {
        {"Music", "Music", "Bell"}, {"Themes", "Themes", "Visual"},
    }},
    {Title = "Utilities", Tabs = {
        {"ScamFruit", "Scam Fruit", "Macro"}, {"FFlags", "FFlags", "Settings"},
        {"ScriptHub", "Script Hub", "Macro"}, {"Keybinds", "Keybinds", "Macro"}, {"Misc", "Misc", "Settings"},
    }},
}
local tabNames, tabLabels, navSections = {}, {}, {}
local navHeight = 0
local navigate, layout, refreshStats
for _, group in ipairs(tabGroups) do
    local heading = label(nav, string.upper(group.Title), 10, C.Soft, medium)
    navSections[#navSections + 1] = {Root = heading, Y = navHeight}
    navHeight = navHeight + 28
    for _, entry in ipairs(group.Tabs) do
        local name, caption, iconName = entry[1], entry[2], entry[3]
        tabNames[#tabNames + 1], tabLabels[name] = name, caption
        local b = button(nav, "Tab_" .. name, "", C.Sidebar, 10)
        b.BackgroundTransparency = 1
        local fill = frame(b, "Selected", C.Selection, 14)
        local marker = frame(fill, "ActiveMarker", C.Accent, 2)
        place(marker, 0, 15, 2, 20)
        fill.Visible = name == "Dashboard"
        local glyph = icon(b, iconName, name == "Dashboard" and C.Text or C.Muted)
        local title = label(b, caption, 16, name == "Dashboard" and C.Text or C.Muted, medium)
        navButtons[name] = {Button = b, Fill = fill, Icon = glyph, Title = title, Y = navHeight}
        connect(b.Activated, function() navigate(name) end)
        navHeight = navHeight + 60
    end
    navHeight = navHeight + 12
end
nav.ScrollBarThickness = 3
nav.CanvasSize = UDim2.fromOffset(0, navHeight)
for _, name in ipairs({"Settings", "Support"}) do
    local b = button(sidebar, name, "", C.Sidebar, 12)
    b.BackgroundTransparency = 1
    local fill = frame(b, "Selected", C.Selection, 14)
    fill.Visible = false
    local marker = frame(fill, "ActiveMarker", C.Accent, 2)
    place(marker, 0, 15, 2, 20)
    local glyph, title = icon(b, name, C.Muted), label(b, name, 16, C.Muted)
    place(glyph, 16, 12, 22, 22); place(title, 49, 0, 145, 46)
    footerButtons[name] = {Button = b, Fill = fill, Icon = glyph, Title = title}
    connect(b.Activated, function() navigate(name) end)
end

local main = frame(shell, "Main", C.Shell)
main.BackgroundTransparency = 1
local dragArea = frame(main, "DragArea", C.Shell)
dragArea.BackgroundTransparency = 1
dragArea.Active = true
local greeting = label(dragArea, "Dashboard", 30, C.Text, bold)
local subtitle = label(dragArea, "Welcome, " .. (player.DisplayName or player.Name), 16, C.Muted)

local avatar = button(main, "Profile", "", C.Raised)
avatar.FontFace, avatar.TextSize = medium, 18
local avatarURI = localAsset(Config.AvatarPath)
local playerPhoto = new("ImageLabel", {
    Name = "PlayerPhoto", Image = avatarURI or ("rbxthumb://type=AvatarHeadShot&id=" .. tostring(player.UserId) .. "&w=150&h=150"),
    Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Crop,
}, avatar)
corner(playerPhoto, 10)
if not avatarURI then
    task.spawn(function()
        local ok, uri, ready = pcall(function()
            return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        end)
        if alive and ok and ready and type(uri) == "string" and uri ~= "" then playerPhoto.Image = uri end
    end)
end
connect(avatar.Activated, function() navigate("Dashboard") end)
local profileName = label(main, player.DisplayName or player.Name, 16, C.Text, medium)
local profileHandle = label(main, "@" .. player.Name, 13, C.Muted)
-- A compact control group lives in the header and scales with the window.
local windowControls = frame(main, "WindowControls", C.Selection, 11)
windowControls.BackgroundTransparency = 0.28
stroke(windowControls, C.Border, 0.45)
local minimize = button(windowControls, "Minimize", "", C.Raised, 6)
place(minimize, 3, 3, 40, 40)
minimize.BackgroundTransparency = 1
line(minimize, 12, 21, 28, 21, C.Accent, 1.5)
local divider = frame(windowControls, "Divider", C.Border)
place(divider, 47, 13, 1, 20)
divider.BackgroundTransparency = 0.45
local close = button(windowControls, "Close", "", C.Raised, 6)
place(close, 52, 3, 40, 40)
close.BackgroundTransparency = 1
local closeIcon = icon(close, "Close", C.Accent); place(closeIcon, 7, 7, 26, 26)
for _, b in ipairs({minimize, close}) do
    connect(b.MouseEnter, function()
        animate(b, {BackgroundTransparency = 0,
            BackgroundColor3 = Color3.fromRGB(34, 34, 34)})
    end)
    connect(b.MouseLeave, function() animate(b, {BackgroundTransparency = 1}) end)
end

local content = new("ScrollingFrame", {
    Name = "PageScroll", BackgroundTransparency = 1, BorderSizePixel = 0,
    ScrollBarThickness = 3, ScrollBarImageColor3 = C.Accent,
    CanvasSize = UDim2.new(), ScrollingDirection = Enum.ScrollingDirection.Y,
    ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
    Active = true, ClipsDescendants = true,
}, main)
local dashboard = frame(content, "Dashboard", C.Card)
dashboard.BackgroundTransparency = 1
local function card(parent, name)
    local f = frame(parent, name, C.Card, 22)
    f.BackgroundTransparency = 0.28
    stroke(f, C.Accent, 0.88)
    glassHighlight(f, 22)
    return f
end

-- Four account values share one surface; the rest of the page is real character data.
local account = card(dashboard, "AccountSummary")
local metrics = {}
for i, caption in ipairs({"Level", "Bounty / Honor", "Beli", "Fragments"}) do
    local root = frame(account, "Metric_" .. i, C.Card)
    root.BackgroundTransparency = 1
    local title = label(root, caption, 17, C.Muted)
    local value = label(root, "--", 36, C.Text, bold)
    title.Name, value.Name = "MetricLabel", "MetricValue"
    local divider = frame(root, "Divider", C.Border)
    divider.BackgroundTransparency = 0.65
    divider.Visible = i < 4
    metrics[i] = {Root = root, Title = title, Value = value, Divider = divider}
end

local vitals = card(dashboard, "Vitals")
local vitalsTitle = label(vitals, "Vitals", 23, C.Text, bold)
local vitalRows = {}
for i, name in ipairs({"Health", "Energy"}) do
    local row = frame(vitals, name .. "Row", C.Card)
    row.BackgroundTransparency = 1
    local glyph = icon(row, name, C.Accent)
    local title = label(row, name, 17, C.Muted, medium)
    local value = label(row, "--", 29, C.Text, bold)
    value.Name = "VitalValue"
    local gauge = frame(row, "Gauge", C.Card)
    gauge.BackgroundTransparency = 1
    local segments = {}
    for index = 1, 28 do
        local angle = -math.pi / 2 + (index - 1) * math.pi * 2 / 28
        local segment = frame(gauge, "Segment" .. index, C.Accent, 2)
        segment.AnchorPoint = Vector2.new(0.5, 0.5)
        segment.Position = UDim2.fromOffset(40 + math.cos(angle) * 35, 40 + math.sin(angle) * 35)
        segment.Size = UDim2.fromOffset(7, 3)
        segment.Rotation, segment.BackgroundTransparency = math.deg(angle), 0.88
        segments[index] = segment
    end
    local percent = label(gauge, "--", 18, C.Accent, bold)
    percent.Name = "VitalPercent"
    percent.TextXAlignment = Enum.TextXAlignment.Center
    local detail = label(row, "Not available", 14, C.Soft)
    local divider = frame(row, "Divider", C.Border)
    divider.BackgroundTransparency = 0.65
    divider.Visible = i == 1
    vitalRows[i] = {Root = row, Icon = glyph, Title = title, Value = value, Gauge = gauge,
        Segments = segments, Percent = percent, Detail = detail, Divider = divider}
end

local equipment = card(dashboard, "Equipment")
local equipmentTitle = label(equipment, "Equipment", 23, C.Text, bold)
local equipmentRows = {}
for i, name in ipairs({"Blox Fruit", "Weapon", "Race"}) do
    local row = frame(equipment, "EquipmentRow" .. i, C.Card)
    row.BackgroundTransparency = 1
    local title = label(row, name, 16, C.Muted)
    local value = label(row, "--", 22, C.Text, medium)
    value.Name = "EquipmentValue"
    local well = frame(row, "IconWell", C.Selection, 14)
    well.BackgroundTransparency = 0.5
    local glyph = icon(well, ({"Fruit", "PVP", "Race"})[i], C.Accent)
    place(glyph, 11, 11, 22, 22)
    local divider = frame(row, "Divider", C.Border)
    divider.BackgroundTransparency = 0.7
    divider.Visible = i < 3
    equipmentRows[i] = {Root = row, IconWell = well, Title = title, Value = value, Divider = divider}
end
local dataNote = label(dashboard, "Waiting for Blox Fruits data", 15, C.Muted)

-- Feature pages: stateful UI only. Connect Config.OnChanged or api.OnChanged.
local pages, controls = {}, {}
local function set(key, value, runCallback)
    state[key] = value
    if controls[key] then controls[key].Render(value) end
    if key == "ShowDim" then dim.Visible = value and shell.Visible end
    if key == "CompactNumbers" and refreshStats then refreshStats() end
    if runCallback ~= false and controls[key] and controls[key].Callback then
        local ok, err = pcall(controls[key].Callback, value)
        if not ok then error(err, 0) end
    end
    if api.QueueSave then api.QueueSave(key)end
    local callback = api.OnChanged or Config.OnChanged
    if callback then
        local ok, err = pcall(callback, key, value, state)
        if not ok then warn("Sweet Exploit callback: " .. tostring(err)) end
    end
end
function api.Set(key, value)
    local control = controls[key]
    if not control then return false, "Unknown control: " .. tostring(key) end
    if control.Kind == "button" then return false, "Action buttons do not store a value" end
    if control.Kind == "input" and type(value) ~= "string" then return false, "Expected string" end
    if control.Kind == "toggle" and type(value) ~= "boolean" then return false, "Expected boolean" end
    if control.Kind == "slider" then
        if type(value) ~= "number" or value ~= value then return false, "Expected finite number" end
        value = math.clamp(value, control.Min, control.Max)
        value = math.floor(value / control.Step + 0.5) * control.Step
    elseif control.Kind == "choice" then
        local found = false
        for _, choice in ipairs(control.Values) do if value == choice then found = true end end
        if not found then return false, "Unknown choice" end
    end
    set(key, value)
    return true
end
local activeSlider
local function page(name, titleText, description)
    local root = frame(content, "Page_" .. name, C.Card)
    root.BackgroundTransparency = 1; root.Visible = false
    local heading = label(root, titleText, 22, C.Text, medium)
    local sub = label(root, description, 12, C.Muted)
    sub.TextWrapped = true
    local status = label(root, "Module not connected", 14, C.Muted)
    local p = {Root = root, Heading = heading, Subtitle = sub, Status = status, Rows = {}}
    pages[name] = p
    return p
end
local function control(p, kind, key, titleText, description, options)
    options = options or {}
    local root = card(p.Root, "Control_" .. key)
    local title = label(root, titleText, 16, C.Text, medium)
    local sub = label(root, description, 12, C.Muted)
    sub.TextWrapped = true
    title.TextWrapped,title.TextTruncate,title.TextYAlignment=true,Enum.TextTruncate.None,Enum.TextYAlignment.Top
    sub.TextTruncate,sub.TextYAlignment=Enum.TextTruncate.None,Enum.TextYAlignment.Top
    local c = {Root = root, Title = title, Subtitle = sub, Kind = kind, Key = key, Callback = options.OnChanged}
    root.ClipsDescendants=true
    if kind == "toggle" then
        local b = button(root, "Toggle_" .. key, "", C.Raised, 16)
        local dot = frame(b, "Knob", C.Muted, 10)
        local indicator=label(root,'OFF',10,C.Muted,medium);indicator.Name='State_'..key;indicator.TextXAlignment=Enum.TextXAlignment.Center
        c.StateLabel=indicator
        local function render(value)
            animate(b, {BackgroundColor3 = value and C.Accent or Color3.fromRGB(35, 35, 39)})
            indicator.Text=value and 'ON'or 'OFF';indicator.TextColor3=value and C.Accent or C.Muted
            animate(dot, {Position = UDim2.fromOffset(value and 24 or 4, 4),
                BackgroundColor3 = value and C.Ink or C.Muted})
        end
        place(dot, state[key] and 24 or 4, 4, 20, 20)
        c.Input, c.Render = b, render
        local tap = button(root, "RowTap_" .. key, "", C.Card, 12)
        tap.BackgroundTransparency = 1
        c.RowTap = tap
        connect(tap.Activated, function() set(key, not state[key]) end)
        render(state[key])
        connect(b.Activated, function() set(key, not state[key]) end)
    elseif kind == "choice" then
        c.Values, c.Open = options.Values, false
        local b = button(root, "Choice_" .. key, "", C.Selection, 9)
        b.TextSize, b.TextColor3 = 14, C.Text
        local list = new("ScrollingFrame", {
            Name = "Options_" .. key, BackgroundColor3 = C.Raised, BorderSizePixel = 0,
            ScrollBarThickness = 3, ScrollBarImageColor3 = C.Accent,
            CanvasSize = UDim2.new(), ScrollingDirection = Enum.ScrollingDirection.Y,
            Active = true, Visible = false, ClipsDescendants = true,
        }, root)
        corner(list, 10)
        c.Input, c.List, c.OptionButtons = b, list, {}
        c.Render = function(value)
            b.Text = tostring(value) .. (c.Open and "  ∧" or "  ∨")
            for index, option in ipairs(c.OptionButtons) do
                local selected = c.Values[index] == value
                option.Text = (selected and "✓  " or "    ") .. tostring(c.Values[index])
                option.BackgroundTransparency = selected and 0.2 or 1
            end
        end
        c.RebuildOptions = function()
            for _, option in ipairs(c.OptionButtons) do option:Destroy() end
            c.OptionButtons = {}
            for index, value in ipairs(c.Values) do
                local option = button(list, "Option_" .. index, "", C.Selection, 8)
                option.TextSize, option.TextXAlignment = 14, Enum.TextXAlignment.Left
                c.OptionButtons[index] = option
                connect(option.Activated, function()
                    c.Open, list.Visible = false, false
                    set(key, value)
                    layout()
                end)
            end
            list.CanvasSize = UDim2.fromOffset(0, #c.Values * 36 + 8)
            c.Render(state[key])
        end
        c.RebuildOptions()
        connect(b.Activated, function()
            c.Open = not c.Open; list.Visible = c.Open
            c.Render(state[key]); layout()
        end)
    elseif kind == "foldout" then
        c.Open, c.Items, c.Wide = false, {}, true
        local b = button(root, "Expand_" .. key, "", C.Selection, 9)
        b.TextSize, b.TextColor3 = 14, C.Text
        local list = new("ScrollingFrame", {
            Name = "Items_" .. key, BackgroundTransparency = 1, BorderSizePixel = 0,
            ScrollBarThickness = 3, ScrollBarImageColor3 = C.Accent,
            CanvasSize = UDim2.new(), ScrollingDirection = Enum.ScrollingDirection.Y,
            Active = true, Visible = false, ClipsDescendants = true,
        }, root)
        c.Input, c.List = b, list
        c.Render = function()
            local count = 0
            for _, item in ipairs(c.Items) do if state[item.Key] then count = count + 1 end end
            sub.Text = count == 0 and "No skills excluded" or (tostring(count) .. (count == 1 and " skill excluded" or " skills excluded"))
            b.Text = c.Open and "Hide options  ∧" or "Choose skills  ∨"
        end
        connect(b.Activated, function()
            c.Open = not c.Open; list.Visible = c.Open
            c.Render(); layout()
        end)
    elseif kind == "custom" then
        c.CustomHeight,c.Wide=options.Height or 320,true
        c.Body=frame(root,"CustomBody",C.Card)
        c.Body.BackgroundTransparency=1
        c.Body.ClipsDescendants=true
        c.Render=function()end
    elseif kind == "input" then
        local box = new("TextBox", {
            Name = "Input_" .. key, Text = tostring(state[key] or ""),
            PlaceholderText = options.Placeholder or "", ClearTextOnFocus = false,
            FontFace = regular, TextSize = 15, TextColor3 = C.Text,
            PlaceholderColor3 = C.Soft, BackgroundColor3 = C.Selection,
            BorderSizePixel = 0, TextTruncate = Enum.TextTruncate.AtEnd,
        }, root)
        corner(box, 10)
        box.TextTruncate=Enum.TextTruncate.None;box.ClipsDescendants=true
        new('UIPadding',{PaddingLeft=UDim.new(0,12),PaddingRight=UDim.new(0,12)},box)
        c.Input, c.Render = box, function(v) box.Text = tostring(v or "") end
        connect(box.FocusLost, function() set(key, box.Text) end)
    elseif kind == "button" then
        local b = button(root, "Action_" .. key, options.Text or "Run", C.Selection, 9)
        b.TextColor3, b.TextSize, b.FontFace = C.Text, 14, medium
        c.Input, c.Render = b, function() end
        connect(b.Activated, function()
            if options.OnActivate then
                local ok, err = pcall(options.OnActivate, state, api)
                if not ok then warn("Sweet Exploit action: " .. tostring(err)) end
            end
        end)
    elseif kind == "slider" then
        c.Min, c.Max, c.Step = options.Min, options.Max, options.Step or 1
        local value = label(root, "", 16, C.Accent, medium)
        value.TextXAlignment = Enum.TextXAlignment.Right
        local hit = button(root, "Slider_" .. key, "", C.Raised, 4)
        hit.BackgroundTransparency = 1
        local track = frame(hit, "Track", C.Raised, 3)
        local fill = frame(track, "Fill", C.AccentDark, 3)
        local knob = frame(track, "Knob", C.Accent, 7)
        knob.AnchorPoint = Vector2.new(0.5, 0.5)
        c.Input, c.Value, c.Track = hit, value, track
        c.Render = function(v)
            local fraction = (v - c.Min) / (c.Max - c.Min)
            fill.Size = UDim2.new(fraction, 0, 1, 0)
            knob.Position = UDim2.new(fraction, 0, 0.5, 0)
            knob.Size = UDim2.fromOffset(16, 16)
            value.Text = string.format(c.Step < 1 and "%.2f" or "%d", v) .. (options.Suffix or "")
        end
        c.Update = function(x)
            local fraction = math.clamp((x - track.AbsolutePosition.X) / math.max(1, track.AbsoluteSize.X), 0, 1)
            local v = c.Min + (c.Max - c.Min) * fraction
            set(key, math.clamp(math.floor(v / c.Step + 0.5) * c.Step, c.Min, c.Max))
        end
        connect(hit.InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                activeSlider = {Control = c, Input = input, Touch = input.UserInputType == Enum.UserInputType.Touch}
                c.Update(input.Position.X)
            end
        end)
        c.Render(state[key])
    end
    p.Rows[#p.Rows + 1] = c
    if kind ~= "foldout" and kind ~= "custom" then controls[key] = c end
    return c
end
-- BEGIN FEATURE DEFINITIONS: native control adapter; engines are registered below.
for _, name in ipairs(tabNames) do
    if name ~= "Dashboard" then page(name, tabLabels[name], "") end
end
local settings = page("Settings", "Settings", "Interface preferences.")
settings.Status.Text = "Changes apply immediately"
control(settings, "toggle", "CompactNumbers", "Compact numbers", "Abbreviate dashboard amounts.")
control(settings, "toggle", "ShowDim", "Dim background", "Darken the scene behind the panel.")
-- END FEATURE DEFINITIONS
local support = page("Support", "Support", "Send a suggestion or bug report in English.")
-- The image IS the hit target. No child ImageLabel can intercept touch input.
local floating
if sweetImageURI then
    floating = new("ImageButton", {
        Name = "ShowSweetExploit", Image = sweetImageURI, ScaleType = Enum.ScaleType.Crop,
        Size = UDim2.fromOffset(44, 44), BackgroundTransparency = 1, BorderSizePixel = 0,
        AutoButtonColor = false, Active = true, Selectable = false,
    }, gui)
    corner(floating, 10)
else
    floating = button(gui, "ShowSweetExploit", "S", C.Sidebar, 10)
    floating.BackgroundTransparency, floating.Active = 1, true
    floating.FontFace, floating.TextSize, floating.TextColor3 = bold, 20, C.Accent
end
floating.Position = UDim2.new(0, 12, 0.5, -22)
floating.Visible = true
local visible = true
local photoGesture, floatingPosition
local photoMoveConnection, photoEndConnection
local photoDragged, photoLastTap = false, -math.huge
local function moveFloating(position)
    local viewport, size = gui.AbsoluteSize, floating.AbsoluteSize
    floatingPosition = Vector2.new(
        math.clamp(position.X, 8, math.max(8, viewport.X - size.X - 8)),
        math.clamp(position.Y, 8, math.max(8, viewport.Y - size.Y - 8)))
    floating.Position = UDim2.fromOffset(floatingPosition.X, floatingPosition.Y)
end
function api.Toggle(value)
    if not alive then return end
    if type(value) ~= "boolean" then value = not visible end
    visible = value
    shell.Visible, windowControls.Visible, floating.Visible = value, value, true
    dim.Visible = value and state.ShowDim
    glassBlur.Enabled = value and Config.WorldBlur
    if api.UpdateUISubscriptions then api.UpdateUISubscriptions()end
end
function api.Minimize() api.Toggle(false) end
connect(minimize.Activated, api.Minimize)
connect(close.Activated, function() api.Destroy() end)
-- Monody's per-press drag: preserve the original UDim2 and follow the delta.
local function stopPhotoDrag()
    if photoMoveConnection then photoMoveConnection:Disconnect(); photoMoveConnection = nil end
    if photoEndConnection then photoEndConnection:Disconnect(); photoEndConnection = nil end
    photoGesture = nil
end
local function tapPhoto()
    if not alive or photoDragged or photoGesture or os.clock() - photoLastTap <= 0.25 then return end
    photoLastTap = os.clock()
    api.Toggle()
end
connect(floating.InputBegan, function(input)
    local kind = input.UserInputType
    if kind ~= Enum.UserInputType.MouseButton1 and kind ~= Enum.UserInputType.Touch then return end
    stopPhotoDrag()
    photoDragged = false
    photoGesture = {Input = input, Start = input.Position, Origin = floating.Position,
        Touch = kind == Enum.UserInputType.Touch}
    photoMoveConnection = Input.InputChanged:Connect(function(moved)
        local g = photoGesture
        if not g then return end
        if g.Touch and moved ~= g.Input then return end
        if not g.Touch and moved.UserInputType ~= Enum.UserInputType.MouseMovement then return end
        local delta = moved.Position - g.Start
        if delta.X * delta.X + delta.Y * delta.Y > 36 then
            photoDragged = true
            floating.Position = UDim2.new(g.Origin.X.Scale, g.Origin.X.Offset + delta.X,
                g.Origin.Y.Scale, g.Origin.Y.Offset + delta.Y)
            floatingPosition = floating.AbsolutePosition
        end
    end)
    photoEndConnection = Input.InputEnded:Connect(function(ended)
        local g = photoGesture
        if not g then return end
        if g.Touch and ended ~= g.Input then return end
        if not g.Touch and ended.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        if ended.UserInputState == Enum.UserInputState.Cancel then photoDragged = true end
        stopPhotoDrag()
        tapPhoto()
    end)
end)
-- Fallback events share the same debounce, so one release can only toggle once.
connect(floating.Activated, tapPhoto)
connect(floating.MouseButton1Click, tapPhoto)
connect(Input.WindowFocusReleased, function() photoDragged = true; stopPhotoDrag() end)
connect(Input.InputBegan, function(input, processed)
    if not processed and input.KeyCode == Config.ToggleKey and not Input:GetFocusedTextBox() then api.Toggle() end
end)


-- Data adapter: no server invokes, farming loops, fake earnings or sample stats.
local function readValue(root, names)
    if not root then return nil end
    for _, name in ipairs(names) do
        local item = root:FindFirstChild(name)
        if item and item:IsA("ValueBase") then return item.Value end
        local ok, attribute = pcall(function() return root:GetAttribute(name) end)
        if ok and attribute ~= nil then return attribute end
    end
    return nil
end
local function dataValue(names)
    for _, rootName in ipairs({"Data", "leaderstats", "Stats"}) do
        local value = readValue(player:FindFirstChild(rootName), names)
        if value ~= nil then return value end
    end
    return readValue(player, names)
end
local function number(value, compact)
    local v = tonumber(value)
    if not v then return value == nil and "--" or tostring(value) end
    if compact and math.abs(v) >= 1000 then
        local divisor, suffix = 1e3, "K"
        if math.abs(v) >= 1e9 then divisor, suffix = 1e9, "B"
        elseif math.abs(v) >= 1e6 then divisor, suffix = 1e6, "M" end
        return (string.format("%.2f", v / divisor):gsub("%.?0+$", "")) .. suffix
    end
    local s = tostring(math.floor(math.abs(v)))
    s = s:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    return (v < 0 and "-" or "") .. s
end
local function sea()
    local seas = {[2753915549] = "SEA 1", [4442272183] = "SEA 2", [7449423635] = "SEA 3"}
    return seas[game.PlaceId] or "ROBLOX"
end



refreshStats = function()
    if not alive then return end
    local level = dataValue({"Level", "Lvl"})
    local bounty = dataValue({"Bounty/Honor", "Bounty", "Honor"})
    local beli = dataValue({"Beli", "Money", "Cash"})
    local fragments = dataValue({"Fragments", "Fragment"})
    local values = {level or false, bounty or false, beli or false, fragments or false}
    for i, value in ipairs(values) do
        local text = number(value ~= false and value or nil, i ~= 1 and state.CompactNumbers)
        metrics[i].Value.Text = text
        metrics[i].Value.TextSize = #text > 8 and 28 or 36
    end
    local char = player.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    local energyObject = char and char:FindFirstChild("Energy")
    local energy = readValue(char, {"Energy"})
    local maxEnergy = readValue(energyObject, {"MaxValue", "Max"}) or dataValue({"MaxEnergy", "Energy"})
    local live = {
        {humanoid and humanoid.Health, humanoid and humanoid.MaxHealth},
        {energy, maxEnergy},
    }
    for i, pair in ipairs(live) do
        local current, maximum = tonumber(pair[1]), tonumber(pair[2])
        local row = vitalRows[i]
        row.Value.Text = current and number(current, false) or "--"
        row.Detail.Text = maximum and ("/ " .. number(maximum, false) .. " max") or "Not available"
        local fraction = current and maximum and maximum > 0 and math.clamp(current / maximum, 0, 1) or 0
        row.Percent.Text = current and maximum and maximum > 0 and (tostring(math.floor(fraction * 100 + 0.5)) .. "%") or "--"
        local filled = math.floor(fraction * #row.Segments + 0.5)
        for index, segment in ipairs(row.Segments) do
            segment.BackgroundTransparency = index <= filled and 0.08 or 0.88
        end
    end
    local fruit = dataValue({"DevilFruit", "BloxFruit", "Fruit"})
    local tool = char and char:FindFirstChildOfClass("Tool")
    local race = dataValue({"Race"})
    equipmentRows[1].Value.Text = fruit and tostring(fruit) or "--"
    equipmentRows[2].Value.Text = tool and tool.Name or "None equipped"
    equipmentRows[3].Value.Text = race and tostring(race) or "--"
    dataNote.Text = level ~= nil and ("Live player data  ·  " .. sea()) or "Waiting for Blox Fruits data"
end

api.Refresh = refreshStats

local cameraConnection
local windowOffset = Vector2.new(0, 0)
local windowW, windowH, viewW, viewH = 1140, 768, 1200, 900
local renderedW, renderedH = windowW, windowH
local dragging
local function positionWindow()
    -- Allow real movement even when the panel initially fills a phone's height.
    -- Keep a grabbable portion of the top edge on screen, not the entire panel.
    local reach = math.min(120, viewW / 2)
    local minX, maxX = reach - (renderedW + viewW) / 2, (renderedW + viewW) / 2 - reach
    local minY, maxY = 8 + (renderedH - viewH) / 2, (renderedH + viewH) / 2 - 48
    windowOffset = Vector2.new(math.clamp(windowOffset.X, minX, maxX),
        math.clamp(windowOffset.Y, minY, math.max(minY, maxY)))
    local cx, cy = viewW / 2 + windowOffset.X, viewH / 2 + windowOffset.Y
    shell.Position = UDim2.fromOffset(cx, cy)
    if floatingPosition then
        moveFloating(floatingPosition)
    elseif cx - renderedW / 2 >= 64 then
        moveFloating(Vector2.new(12, cy - 22))
    else
        moveFloating(Vector2.new(16, math.max(8, cy - renderedH / 2 - 54)))
    end
end
layout = function()
    if not alive then return end
    local camera = workspace.CurrentCamera
    local viewport = gui.AbsoluteSize
    if viewport.X <= 0 or viewport.Y <= 0 then
        viewport = camera and camera.ViewportSize or Vector2.new(1200, 900)
    end
    viewW, viewH = viewport.X, viewport.Y
    -- The window is only 60 design pixels wider than the preceding version.
    windowW, windowH = 1140, 768
    panelScale.Scale = math.max(0.01, math.min(1, (viewW - 32) / windowW, (viewH - 32) / windowH) * Config.WindowScale)
    renderedW, renderedH = windowW * panelScale.Scale, windowH * panelScale.Scale
    shell.Size = UDim2.fromOffset(windowW, windowH)
    positionWindow()

    local padding, sideW, gap = 18, 220, 22
    local sideH = windowH - padding * 2
    place(sidebar, padding, padding, sideW, sideH)
    place(brandIcon, 16, 24, brandImageURI and 40 or 22, brandImageURI and 40 or 22)
    place(brand, 69, 20, sideW - 81, 28)
    place(edition, 69, 48, sideW - 81, 20)
    place(nav, 12, 102, sideW - 24, sideH - 226)
    for _, section in ipairs(navSections) do place(section.Root, 14, section.Y, sideW - 54, 22) end
    for _, name in ipairs(tabNames) do
        local n = navButtons[name]
        place(n.Button, 0, n.Y, sideW - 24, 50)
        place(n.Icon, 15, 14, 22, 22)
        place(n.Title, 48, 0, sideW - 82, 50)
        n.Title.Visible = true
    end
    for i, name in ipairs({"Settings", "Support"}) do
        local f = footerButtons[name]
        place(f.Button, 12, sideH - (3 - i) * 54 - 12, sideW - 24, 50)
        place(f.Icon, 15, 14, 22, 22)
        place(f.Title, 48, 0, sideW - 82, 50)
    end
    local mx = padding + sideW + gap
    local mw, mh = windowW - mx - padding, windowH - padding * 2
    place(main, mx, padding, mw, mh)
    place(dragArea, 0, 0, mw - 330, 92)
    greeting.Text = tabLabels[state.Tab] or state.Tab
    subtitle.Text = state.Tab == "Dashboard" and ("Welcome, " .. (player.DisplayName or player.Name)) or
        (pages[state.Tab] and pages[state.Tab].Subtitle.Text or "")
    place(greeting, 0, 13, mw - 340, 38)
    place(subtitle, 0, 55, mw - 340, 25)
    place(avatar, mw - 308, 18, 42, 42)
    place(profileName, mw - 253, 17, 132, 25)
    place(profileHandle, mw - 253, 43, 132, 22)
    place(windowControls, mw - 95, 4, 95, 46)

    local contentY = 104
    local ch, cw = mh - contentY, mw - 4
    place(content, 0, contentY, mw, ch)
    place(dashboard, 0, 0, cw, 618)
    place(account, 0, 0, cw, 156)
    local metricW = cw / 4
    for i, metric in ipairs(metrics) do
        place(metric.Root, (i - 1) * metricW, 0, metricW, 156)
        place(metric.Title, 22, 25, metricW - 38, 26)
        place(metric.Value, 22, 63, metricW - 38, 52)
        place(metric.Divider, metricW - 1, 29, 1, 98)
    end
    local colW, bottomY, bottomH = (cw - 18) / 2, 174, 402
    place(vitals, 0, bottomY, colW, bottomH)
    place(equipment, colW + 18, bottomY, colW, bottomH)
    place(vitalsTitle, 24, 19, colW - 48, 34)
    place(equipmentTitle, 24, 19, colW - 48, 34)
    for i, row in ipairs(vitalRows) do
        place(row.Root, 24, 83 + (i - 1) * 150, colW - 48, 134)
        place(row.Gauge, 0, 20, 80, 80)
        place(row.Percent, 0, 0, 80, 80)
        place(row.Icon, 106, 6, 22, 22)
        place(row.Title, 138, 4, colW - 186, 28)
        place(row.Value, 106, 38, colW - 154, 42)
        place(row.Detail, 106, 87, colW - 154, 24)
        place(row.Divider, 106, 128, colW - 154, 1)
    end
    for i, row in ipairs(equipmentRows) do
        place(row.Root, 24, 80 + (i - 1) * 102, colW - 48, 96)
        place(row.IconWell, 0, 14, 44, 44)
        place(row.Title, 66, 7, colW - 114, 24)
        place(row.Value, 66, 35, colW - 114, 36)
        place(row.Divider, 66, 87, colW - 114, 1)
    end
    place(dataNote, 2, 592, cw - 4, 24)

    local function textHeight(object,width,minHeight)
        local value=tostring(object.Text or '')
        if value==''then return 0 end
        local fontSize=object.TextSize or 14
        local measured
        pcall(function()measured=game:GetService('TextService'):GetTextSize(value,fontSize,Enum.Font.Gotham,Vector2.new(math.max(1,width),10000)).Y end)
        if not measured then measured=math.ceil(#value*fontSize*.56/math.max(1,width))*fontSize*1.3 end
        return math.max(minHeight or fontSize+4,math.ceil(measured)+6)
    end
    for _, p in pairs(pages) do
        p.Heading.Visible, p.Subtitle.Visible = false, false
        place(p.Status, 0, 0, cw, 28)
        local y, controlW, column, rowHeight = 40, (cw - 12) / 2, 0, 0
        for _, c in ipairs(p.Rows) do
            if c.Wide and column == 1 then y, column, rowHeight = y + rowHeight + 10, 0, 0 end
            local width = c.Wide and cw or controlW
            local height = (c.Kind == "slider" or c.Kind == "input") and 100 or 80
            local textWidth=width-112
            local titleHeight=textHeight(c.Title,textWidth,22)
            local subtitleHeight=textHeight(c.Subtitle,textWidth,18)
            if c.Kind=='toggle'or c.Kind=='button'then height=math.max(94,30+titleHeight+subtitleHeight)end
            if c.Kind=='choice'or c.Kind=='input'or c.Kind=='slider'then
                titleHeight=textHeight(c.Title,width-32,22)
                height=math.max(c.Kind=='slider'and 108 or 94,52+titleHeight+34)
            end
            if c.Kind=="custom" then height=c.CustomHeight end
            if c.Kind == "choice" and c.Open then height = titleHeight+68 + math.min(#c.Values * 36 + 8, 188) end
            if c.Kind == "foldout" and c.Open then height = 90 + math.min(#c.Items * 40, 240) end
            place(c.Root, column * (controlW + 12), y, width, height)
            place(c.Title,16,14,textWidth,titleHeight)
            place(c.Subtitle,16,20+titleHeight,textWidth,subtitleHeight)
            if c.Kind=="custom" then
                place(c.Title,14,10,width-28,25);c.Subtitle.Visible=false
                place(c.Body,14,44,width-28,height-58)
            elseif c.Kind == "slider" then
                place(c.Title,16,12,width-32,titleHeight)
                c.Subtitle.Visible=false
                place(c.Value,width-114,12+titleHeight,98,24)
                place(c.Input,18,40+titleHeight,width-36,36)
                place(c.Track,0,15,width-36,5)
            elseif c.Kind == "toggle" then
                local switchY=math.floor((height-44)/2)
                place(c.Input,width-64,switchY,48,28)
                place(c.StateLabel,width-70,switchY+32,60,14)
                place(c.RowTap,0,0,width-76,height)
            elseif c.Kind == "choice" then
                place(c.Title,16,12,width-32,titleHeight)
                c.Subtitle.Visible=false
                local inputY=20+titleHeight
                place(c.Input,14,inputY,width-28,34)
                local listY=inputY+42
                place(c.List,10,listY,width-20,height-listY-10)
                for index,option in ipairs(c.OptionButtons)do place(option,4,4+(index-1)*36,width-32,34)end
            elseif c.Kind == "foldout" then
                place(c.Title, 14, 10, width - 210, 24)
                place(c.Subtitle, 14, 37, width - 210, 24)
                place(c.Input, width - 190, 24, 176, 34)
                place(c.List, 14, 80, width - 28, height - 90)
                c.List.CanvasSize = UDim2.fromOffset(0, #c.Items * 40)
                for index, item in ipairs(c.Items) do
                    place(item.Root, 0, (index - 1) * 40, width - 34, 40)
                    place(item.Title, 10, 5, width - 116, 30)
                    item.Title.TextSize = 14; item.Subtitle.Visible = false
                    if item.StateLabel then item.StateLabel.Visible=false end
                    place(item.Input, width - 96, 6, 48, 28)
                    place(item.RowTap, 0, 0, width - 110, 40)
                end
                c.Render()
            elseif c.Kind == "input" then
                place(c.Title,16,12,width-32,titleHeight)
                c.Subtitle.Visible=false
                place(c.Input,14,20+titleHeight,width-28,40)
            else
                place(c.Input,width-94,math.floor((height-36)/2),78,36)
            end
            if c.Wide then
                y, column, rowHeight = y + height + 10, 0, 0
            elseif column == 0 then
                column, rowHeight = 1, height
            else
                y, column, rowHeight = y + math.max(rowHeight, height) + 10, 0, 0
            end
        end
        if column == 1 then y = y + rowHeight + 10 end
        if p.Help then
            place(p.Help, 0, y, cw, 480)
            place(p.HelpText, 24, 24, cw - 48, 432)
            y = y + 494
        end
        place(p.Root, 0, 0, cw, y + 4)
    end
    local selected = state.Tab == "Dashboard" and dashboard or pages[state.Tab].Root
    content.CanvasSize = UDim2.fromOffset(0, selected.Size.Y.Offset)
    content.ScrollingEnabled = state.Tab ~= "Dashboard"
end

navigate = function(name)
    if name ~= "Dashboard" and not pages[name] then return end
    state.Tab = name
    dashboard.Visible = name == "Dashboard"
    for key, p in pairs(pages) do p.Root.Visible = key == name end
    for _, group in ipairs({navButtons, footerButtons}) do
        for key, n in pairs(group) do
            n.Fill.Visible = key == name
            n.Title.TextColor3 = key == name and C.Text or C.Muted
            for _, part in ipairs(n.Icon:GetDescendants()) do
                if part:IsA("Frame") then part.BackgroundColor3 = key == name and C.Text or C.Muted end
                if part:IsA("UIStroke") then part.Color = key == name and C.Text or C.Muted end
            end
        end
    end
    content.CanvasPosition = Vector2.new(0, 0)
    layout()
    if api.UpdateUISubscriptions then api.UpdateUISubscriptions()end
end
api.Navigate = navigate
api.Gui = gui
function api.Destroy()
    if not alive then return end
    if api.BeforeDestroy then pcall(api.BeforeDestroy)end
    alive = false
    if api.UnloadFeatures then pcall(api.UnloadFeatures) end
    stopPhotoDrag()
    activeSlider, dragging, photoGesture = nil, nil, nil
    for _, connection in ipairs(connections) do connection:Disconnect() end
    if cameraConnection then cameraConnection:Disconnect() end
    for _, tween in pairs(tweens) do tween:Cancel() end
    tweens = {}
    glassBlur:Destroy()
    gui:Destroy()
    if env.SweetExploit == api then env.SweetExploit = nil end
end

local function beginPanelDrag(input, target)
    if dragging or activeSlider or photoGesture then return end
    local ancestor = target
    while ancestor and ancestor ~= shell do
        if ancestor:IsA("GuiButton") or ancestor:IsA("TextBox") then return end
        -- Do not turn a scroll gesture into a window drag.
        if ancestor:IsA("ScrollingFrame") and ancestor.ScrollingEnabled
            and ancestor.CanvasSize.Y.Offset > ancestor.AbsoluteSize.Y / panelScale.Scale then return end
        ancestor = ancestor.Parent
    end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = {Input = input, Start = Vector2.new(input.Position.X, input.Position.Y), Offset = windowOffset,
            Touch = input.UserInputType == Enum.UserInputType.Touch}
    end
end
-- Bind empty surfaces and labels, but never a button or any of its descendants.
local function bindPanelSurface(target)
    if target:IsA("Frame") or target:IsA("TextLabel") or target:IsA("ImageLabel") then
        local ancestor = target
        while ancestor and ancestor ~= shell do
            if ancestor:IsA("GuiButton") or ancestor:IsA("TextBox") then return end
            ancestor = ancestor.Parent
        end
        connect(target.InputBegan, function(input) beginPanelDrag(input, target) end)
    end
end
bindPanelSurface(shell)
for _, target in ipairs(shell:GetDescendants()) do bindPanelSurface(target) end
connect(shell.DescendantAdded, bindPanelSurface)
connect(Input.InputChanged, function(input)
    if activeSlider and ((activeSlider.Touch and input == activeSlider.Input) or
        (not activeSlider.Touch and input.UserInputType == Enum.UserInputType.MouseMovement)) then
        activeSlider.Control.Update(input.Position.X)
    elseif dragging and ((dragging.Touch and input == dragging.Input) or
        (not dragging.Touch and input.UserInputType == Enum.UserInputType.MouseMovement)) then
        windowOffset = dragging.Offset + Vector2.new(input.Position.X, input.Position.Y) - dragging.Start
        -- Input deltas are screen pixels; never divide by the panel scale.
        positionWindow()
    end
end)
connect(Input.InputEnded, function(input)
    if activeSlider and (input == activeSlider.Input or
        (not activeSlider.Touch and input.UserInputType == Enum.UserInputType.MouseButton1)) then activeSlider = nil end
    if dragging and (input == dragging.Input or
        (not dragging.Touch and input.UserInputType == Enum.UserInputType.MouseButton1)) then dragging = nil end
end)
local function watchCamera()
    if cameraConnection then cameraConnection:Disconnect() end
    local camera = workspace.CurrentCamera
    if camera then cameraConnection = camera:GetPropertyChangedSignal("ViewportSize"):Connect(layout) end
    layout()
end
connect(workspace:GetPropertyChangedSignal("CurrentCamera"), watchCamera)
connect(gui:GetPropertyChangedSignal("AbsoluteSize"), layout)
connect(player.CharacterAdded, function() task.defer(refreshStats) end)
local statsConnection
function api.UpdateUISubscriptions()
 if statsConnection then statsConnection:Disconnect();statsConnection=nil end
 if shell.Visible and state.Tab=="Dashboard"then
  local elapsed=0
  statsConnection=connect(Run.Heartbeat,function(dt)elapsed=elapsed+dt;if elapsed>=1 then elapsed=0;refreshStats()end end)
 end
end
;(function()
    -- Local, lazy Monody engine bridge. Original main.lua/bootstrap is never executed.
    local sourceModules = (function()
 local base='https://raw.githubusercontent.com/lol123rivals-dotcom/random2-/main/'
 local function fetch(path,expected)
  local name=path:match('([^/]+)$');local cache='SweetExploit/module-cache/'..name
  local function valid(raw)return type(raw)=='string'and #raw==expected and type(loadstring(raw))=='function'end
  if isfile and readfile then local ok,raw=pcall(function()if isfile(cache)then return readfile(cache)end end);if ok and valid(raw)then return raw end end
  local ok,raw=pcall(function()return game:HttpGet(base..path,true)end)
  assert(ok and valid(raw),'Could not load component. Check the connection and try again.')
  if writefile then pcall(function()
   if makefolder and isfolder then
    if not isfolder('SweetExploit')then makefolder('SweetExploit')end
    if not isfolder('SweetExploit/module-cache')then makefolder('SweetExploit/module-cache')end
   end
   writefile(cache,raw)
  end)end
  return raw
 end
 return {
["modules/ai/mika.lua"]=function()return fetch("m/201928212cf33aa366b8.lua",157465)end,
["modules/combat/aimbot_core.lua"]=function()return fetch("m/5dcd00405e43c7e64b98.lua",33303)end,
["modules/combat/blacklist.lua"]=function()return fetch("m/765a944390234dd75e0d.lua",2373)end,
["modules/combat/dungeon_engine.lua"]=function()return fetch("m/d3ba19b4c6964195963b.lua",16380)end,
["modules/combat/fast_attack_fruits.lua"]=function()return fetch("m/98aaab6c32b15cee70b6.lua",7081)end,
["modules/combat/fov.lua"]=function()return fetch("m/c556dbfd6f77a32096a1.lua",4309)end,
["modules/combat/kit_one_shot.lua"]=function()return fetch("m/bec49ded78742b0130c3.lua",10668)end,
["modules/combat/npc_aimbot.lua"]=function()return fetch("m/85b6e3dc183f24cd89d7.lua",1593)end,
["modules/combat/player_aimbot.lua"]=function()return fetch("m/429ad28d3fedb2b20a59.lua",2668)end,
["modules/combat/saishi_one_shot.lua"]=function()return fetch("m/f07f31bce01dc680f91e.lua",5746)end,
["modules/combat/tracers.lua"]=function()return fetch("m/93deffcb9480f1ffb9f2.lua",9996)end,
["modules/core/embedded_assets.lua"]=function()return fetch("m/d18b5932adec5b26c444.lua",131)end,
["modules/esp/design.lua"]=function()return fetch("m/eb219c468c27f130e196.lua",4595)end,
["modules/esp/esp_pvp.lua"]=function()return fetch("m/d07fb416b52b6bce6de4.lua",4142)end,
["modules/macro/macro_engine.lua"]=function()return fetch("m/e643c323277799f23990.lua",16774)end,
["modules/macro/macro_tab.lua"]=function()return fetch("m/0a6c44f77b0324ca5f8c.lua",3630)end,
["modules/misc/client_tweaks.lua"]=function()return fetch("m/ed0c687d80eb05c42041.lua",7587)end,
["modules/misc/ghost_ship.lua"]=function()return fetch("m/f5f7abdf272817ea9a72.lua",1596)end,
["modules/mobility/movement_engine.lua"]=function()return fetch("m/fd2eac5707bbb41b761a.lua",14395)end,
["modules/pvp/auto_combat.lua"]=function()return fetch("m/3dc9bbeb10156452265d.lua",2920)end,
["modules/pvp/camlock.lua"]=function()return fetch("m/0af62750ed0ab3daac09.lua",6582)end,
["modules/pvp/dragon_gun_m1.lua"]=function()return fetch("m/67daa3c62360a66913d5.lua",6896)end,
["modules/pvp/extra_widgets.lua"]=function()return fetch("m/92514a072d2dda8dc620.lua",17022)end,
["modules/pvp/fast_attack.lua"]=function()return fetch("m/8bc0319d386aad7d0ff3.lua",3898)end,
["modules/pvp/floating_widget.lua"]=function()return fetch("m/22f1642b557ec3f6eb5b.lua",7815)end,
["modules/pvp/hitbox_expander.lua"]=function()return fetch("m/db4753f091e899f40d22.lua",2724)end,
["modules/pvp/sanguine_boost.lua"]=function()return fetch("m/51fbf607f82fe862e901.lua",2537)end,
["modules/pvp/static_cam.lua"]=function()return fetch("m/1c93fda8d5624d520eaf.lua",850)end,
["modules/pvp/tracker.lua"]=function()return fetch("m/cdc92549cf79110d34bc.lua",6209)end,
["modules/soru/soru_controller.lua"]=function()return fetch("m/db905bab9aeb04d2505a.lua",12044)end,
["modules/special/admin_cinematic.lua"]=function()return fetch("m/01e56b4fef0a33c26aba.lua",48540)end,
["modules/special/comeback_cinematic.lua"]=function()return fetch("m/923ecf8058fa652f394c.lua",90221)end,
["modules/special/halloween_cinematic.lua"]=function()return fetch("m/9f112dd4708c192e7708.lua",37156)end,
["modules/special/kings_throne.lua"]=function()return fetch("m/9132b48a594ecb4ce258.lua",59902)end,
["modules/special/sanctuary_cinematic.lua"]=function()return fetch("m/639923fa38c8df599240.lua",35692)end,
["modules/special/transcendence_dragon.lua"]=function()return fetch("m/349b188183711c1f045d.lua",79959)end,
["modules/special/worldbreaker.lua"]=function()return fetch("m/99396a590525bc11c343.lua",59872)end,
["modules/ui/controls_hud.lua"]=function()return fetch("m/cf70be229188c3a22f86.lua",15280)end,
["modules/ui/keybinds_system.lua"]=function()return fetch("m/c3174b01938cf221ffb3.lua",5576)end,
["modules/ui/widgets.lua"]=function()return fetch("m/1219cd47463882d4e518.lua",7648)end,
["modules/visuals/avatar_changer.lua"]=function()return fetch("m/144dca2918cded0a8301.lua",29573)end,
["modules/visuals/buddha_rainbow.lua"]=function()return fetch("m/5208257930a604513b88.lua",4938)end,
["modules/visuals/fruit_palette.lua"]=function()return fetch("m/3bc7acdde1116d565667.lua",3079)end,
["modules/visuals/skins_system.lua"]=function()return fetch("m/c8d816743a5e01592fa6.lua",30324)end,
["modules/visuals/sky_changer.lua"]=function()return fetch("m/1194ce882b03ac1f4852.lua",8358)end,
["tiki_engine.lua"]=function()return fetch("m/b8020333577d452ed604.lua",85468)end,
["levi_engine.lua"]=function()return fetch("m/1da1d0443d8bdd30be7a.lua",176766)end,
["modules/misc/flags.lua"]=function()return fetch("m/c511cd948f718ef18e9a.lua",2702)end,
["modules/visuals/hit_feedback.lua"]=function()return fetch("m/8b8a4f25a7a7c25f22f3.lua",5431)end
}
end)()
    local featureSources = {
["Aimbot"]=[==========[
local function isPlayerAlly(player)
if not player or player == lp then return false end
if not _G.DarlingX_IgnoreAllies then return false end
local ok, ally = pcall(function()
local main = lp and lp:FindFirstChild("PlayerGui") and lp.PlayerGui:FindFirstChild("Main")
local frame = main and main:FindFirstChild("Allies")
and main.Allies:FindFirstChild("Container")
and main.Allies.Container:FindFirstChild("Allies")
and main.Allies.Container.Allies:FindFirstChild("ScrollingFrame")
and main.Allies.Container.Allies:FindFirstChild("Frame")
if frame and frame:FindFirstChild(player.Name) then return true end
local myTeam = lp and lp.Team
local targetTeam = player.Team
if myTeam and targetTeam and myTeam.Name == "Marines" and targetTeam.Name == "Marines" then return true end
return false
end)
return ok and ally
end
local function isPlayerPvPEnabled(player)
if not player or player == lp then return false end
local ok, enabled = pcall(function()
if player:GetAttribute("PvpDisabled") == true then return false end
local char = player.Character
if char then
if char:FindFirstChildOfClass("ForceField") then return false end
if char:GetAttribute("PvpDisabled") == true then return false end
end
return true
end)
return not ok or enabled
end
local function isPlayerInSafeZone(player)
if not player or player == lp then return false end
local ok, inZone = pcall(function()
local char = player.Character
if not char then return false end
local hum = char:FindFirstChildOfClass("Humanoid")
if hum and hum.Sit == true then return true end
if char:FindFirstChildOfClass("ForceField") then return true end
if char:GetAttribute("SafeZone") == true then return true end
if player:GetAttribute("SafeZone") == true then return true end
local hrp = char:FindFirstChild("HumanoidRootPart")
if not hrp then return false end
local hrpPos = hrp.Position
local function checkFolder(folder)
if not folder then return false end
for _, zone in ipairs(folder:GetChildren()) do
if zone:IsA("BasePart") then
local mesh = zone:FindFirstChild("Mesh")
local radius = 0
if mesh and mesh:IsA("SpecialMesh") then
radius = (zone.Size.X * mesh.Scale.X) / 2
else
radius = math.min(zone.Size.X, zone.Size.Z) / 2
end
if radius > 500 then radius = 350 end
if radius <= 0 then radius = 350 end
if (zone.Position - hrpPos).Magnitude <= radius then return true end
local localPos = zone.CFrame:PointToObjectSpace(hrpPos)
local halfSize = zone.Size / 2
if math.abs(localPos.X) <= halfSize.X and math.abs(localPos.Y) <= halfSize.Y + 25 and math.abs(localPos.Z) <= halfSize.Z then
return true
end
end
end
return false
end
local wo = Workspace:FindFirstChild("_WorldOrigin")
if wo and checkFolder(wo:FindFirstChild("SafeZones")) then return true end
if wo and checkFolder(wo:FindFirstChild("TempSafeZones")) then return true end
if checkFolder(Workspace:FindFirstChild("SafeZones")) then return true end
local map = Workspace:FindFirstChild("Map")
if map and checkFolder(map:FindFirstChild("SafeZones")) then return true end
return false
end)
return ok and inZone
end
local function hookAimbotTargetFilter()
pcall(function()
local core = _G.DarlingCombatCore
if core and not core._DarlingFilterHooked then
core._DarlingFilterHooked = true
local origBlacklisted = core.isPlayerBlacklisted
core.isPlayerBlacklisted = function(player)
if not player then return false end
if (core.PlayerLockEnabled or _G.DarlingX_TargetLock) and (core.LockedTargetPlayer == player or _G.DarlingX_LockedTarget == player) then
return false
end
if origBlacklisted and origBlacklisted(player) then return true end
if _G.DarlingX_IgnoreAllies and isPlayerAlly(player) then
return true
end
if _G.DarlingX_IgnorePvPOff and not isPlayerPvPEnabled(player) then
return true
end
if _G.DarlingX_IgnoreSafeZone and isPlayerInSafeZone(player) then
return true
end
return false
end
end
end)
end
local aimCard = CreateCard(AimbotPage, "Silent Aim")
AddToggle(aimCard, "Player Silent Aim", "Redirect skills toward enemy players", false, function(state)
local mod = RequireModule("modules/combat/player_aimbot.lua")
if mod then
if state then mod.enable() else mod.disable() end
end
Notify("Aimbot", "Player Silent Aim: " .. (state and "Enabled" or "Disabled"))
end)
_G.DarlingX_SyncAimLockUI = function(state)
if UI_TOGGLES["Silent Aim Lock"] and UI_TOGGLES["Silent Aim Lock"].set then
pcall(function() UI_TOGGLES["Silent Aim Lock"].set(state == true, false) end)
end
if UI_TOGGLES["Silent Aim Player Lock"] and UI_TOGGLES["Silent Aim Player Lock"].set then
pcall(function() UI_TOGGLES["Silent Aim Player Lock"].set(state == true, false) end)
end
end
AddToggle(aimCard, "Silent Aim Lock", "Lock onto targeted player without moving camera", false, function(state)
_G.DarlingX_TargetLock = state
local core = RequireModule("modules/combat/aimbot_core.lua")
if core and core.SetPlayerLock then
local locked = core.SetPlayerLock(state)
if state and locked then
Notify("Aimbot", "Locked: " .. tostring(locked.DisplayName or locked.Name))
else
Notify("Aimbot", "Silent Aim Lock: " .. (state and "Enabled (Aiming)" or "Disabled (Free)"))
end
end
end)
AddToggle(aimCard, "Silent Aim Lock Floating Widget", "Movable on-screen toggle for Silent Aim Lock", false, function(state)
local ew = _G.DarlingX_ExtraWidgets or (M and M.getExtraWidgets and M.getExtraWidgets())
if ew and ew.SetAimLockWidgetVisible then
ew.SetAimLockWidgetVisible(state)
end
end)
AddButton(aimCard, "Lock Current Target", function()
local core = RequireModule("modules/combat/aimbot_core.lua")
if core and core.SetPlayerLock then
local isLocked = not (core.PlayerLockEnabled or _G.DarlingX_TargetLock)
if UI_TOGGLES["Silent Aim Lock"] then
UI_TOGGLES["Silent Aim Lock"].set(isLocked, true)
elseif UI_TOGGLES["Silent Aim Player Lock"] then
UI_TOGGLES["Silent Aim Player Lock"].set(isLocked, true)
else
local locked = core.SetPlayerLock(isLocked)
if isLocked and locked then
Notify("Aimbot", "Locked: " .. tostring(locked.DisplayName or locked.Name))
else
Notify("Aimbot", "Silent Aim Lock: " .. (isLocked and "Enabled" or "Disabled"))
end
end
end
end)
AddToggle(aimCard, "NPC Silent Aim", "Redirect skills toward mobs and bosses", false, function(state)
local mod = RequireModule("modules/combat/npc_aimbot.lua")
if mod then
if state then mod.enable() else mod.disable() end
end
Notify("Aimbot", "NPC Silent Aim: " .. (state and "Enabled" or "Disabled"))
end)
AddToggle(aimCard, "Show FOV Circle", "Display aim boundary circle", false, function(state)
local fovMod = RequireModule("modules/combat/fov.lua")
if fovMod then
if state then fovMod.enable() else fovMod.disable() end
end
Notify("FOV", "FOV Circle: " .. (state and "Visible" or "Hidden"))
end)
AddToggle(aimCard, "Ignore Allies", "Do not target allied players", false, function(state)
_G.DarlingX_IgnoreAllies = state
hookAimbotTargetFilter()
Notify("Aimbot", "Ignore Allies: " .. (state and "Enabled" or "Disabled"))
end)
AddToggle(aimCard, "Ignore PvP Off", "Do not target players with PvP disabled", false, function(state)
_G.DarlingX_IgnorePvPOff = state
hookAimbotTargetFilter()
Notify("Aimbot", "Ignore PvP Off: " .. (state and "Enabled" or "Disabled"))
end)
AddToggle(aimCard, "Ignore Safe Zone", "Do not target players inside safe zones", false, function(state)
_G.DarlingX_IgnoreSafeZone = state
hookAimbotTargetFilter()
Notify("Aimbot", "Ignore Safe Zone: " .. (state and "Enabled" or "Disabled"))
end)
AddChoice(aimCard, "Target Priority", { "Nearest", "Low HP", "Looking At Me" }, 1, function(val)
local core = RequireModule("modules/combat/aimbot_core.lua")
if core then core.TargetPriority = val end
_G.DarlingX.Settings.Aim.Priority = val
end)
AddChoice(aimCard, "Aim Mode", { "360", "FOV", "180" }, 1, function(val)
local core = RequireModule("modules/combat/aimbot_core.lua")
if core then core.AimMode = val end
_G.DarlingX.Settings.Aim.Mode = val
local fovMod = RequireModule("modules/combat/fov.lua")
if fovMod and fovMod.setAimMode then
fovMod.setAimMode(val)
end
end)
AddChoice(aimCard, "Target Hitbox", { "HumanoidRootPart", "Head", "UpperTorso" }, 1, function(val)
local core = RequireModule("modules/combat/aimbot_core.lua")
if core then
core.TargetHitbox = val
core.TargetPart = val
end
_G.DarlingX.Settings.Aim.TargetPart = val
end)
AddSlider(aimCard, "Max Range", 100, 3000, 1000, 50, function(val)
local core = RequireModule("modules/combat/aimbot_core.lua")
if core then core.MaxRange = val end
_G.DarlingX.Settings.Aim.MaxRange = val
end)
AddToggle(aimCard, "Enable Target Prediction", "Calculates lead vector based on enemy velocity and ping", false, function(state)
local core = RequireModule("modules/combat/aimbot_core.lua")
if core then core.PredictionEnabled = state end
_G.DarlingX.Settings.Aim.Prediction = state
end)
AddSlider(aimCard, "Prediction Amount", 5, 30, 12, 1, function(val)
local core = RequireModule("modules/combat/aimbot_core.lua")
local factor = val / 100
if core then core.PredictionAmount = factor end
_G.DarlingX.Settings.Aim.PredictionAmount = factor
end)
local fovCard = CreateCard(AimbotPage, "Field of View")
AddSlider(fovCard, "FOV Radius", 20, 600, 100, 5, function(val)
local fovMod = RequireModule("modules/combat/fov.lua")
if fovMod and fovMod.setRadius then fovMod.setRadius(val) end
local core = RequireModule("modules/combat/aimbot_core.lua")
if core and core.setFOVRadius then core.setFOVRadius(val) end
_G.DarlingX.Settings.FOV.Radius = val
end)
AddChoice(fovCard, "FOV Position", { "Center", "Mouse" }, 1, function(val)
local fovMod = RequireModule("modules/combat/fov.lua")
if fovMod and fovMod.setMode then fovMod.setMode(val) end
_G.DarlingX.Settings.FOV.Mode = val
end)
AddChoice(fovCard, "FOV Color", { "Cyan", "White", "Blue", "Rainbow", "Pink", "Green", "Yellow", "Orange", "Red", "Purple" }, 1, function(val)
local fovMod = RequireModule("modules/combat/fov.lua")
if fovMod then
if val == "Rainbow" then
if fovMod.setRainbow then fovMod.setRainbow(true) end
else
if fovMod.setRainbow then fovMod.setRainbow(false) end
local col = THEMES[val] or Color3.fromRGB(255, 255, 255)
if fovMod.setColor then fovMod.setColor(col) end
end
end
end)
AddSlider(fovCard, "FOV Thickness", 1, 8, 2, 1, function(val)
local fovMod = RequireModule("modules/combat/fov.lua")
if fovMod and fovMod.setThickness then fovMod.setThickness(val) end
end)
local tracersCard = CreateCard(AimbotPage, "Tracers")
AddToggle(tracersCard, "Show Tracers", "Renders hardware 3D Beams and 2D lines to target", false, function(state)
local mod = RequireModule("modules/combat/tracers.lua")
if mod then
if state then mod.enable() else mod.disable() end
end
Notify("Tracers", "Tracers: " .. (state and "Enabled" or "Disabled"))
end)
AddChoice(tracersCard, "Tracer Mode", { "Both", "3D Beam", "2D Line" }, 1, function(val)
local mod = RequireModule("modules/combat/tracers.lua")
if mod and mod.setType then mod.setType(val) end
_G.DarlingX.Settings.Tracers.Type = val
end)
AddChoice(tracersCard, "Tracer Origin", { "Player", "Bottom", "Center", "Mouse" }, 1, function(val)
local mod = RequireModule("modules/combat/tracers.lua")
if mod and mod.setOrigin then mod.setOrigin(val) end
_G.DarlingX.Settings.Tracers.Origin = val
end)
AddChoice(tracersCard, "Tracer Color", { "Cyan", "White", "Blue", "Rainbow", "Pink", "Green", "Yellow", "Orange", "Red", "Purple" }, 1, function(val)
local mod = RequireModule("modules/combat/tracers.lua")
if mod then
if val == "Rainbow" then
if mod.setRainbow then mod.setRainbow(true) end
else
if mod.setRainbow then mod.setRainbow(false) end
local col = THEMES[val] or Color3.fromRGB(255, 255, 255)
if mod.setColor then mod.setColor(col) end
end
end
end)
AddSlider(tracersCard, "Tracer Thickness", 1, 6, 2, 1, function(val)
local mod = RequireModule("modules/combat/tracers.lua")
if mod and mod.setThickness then mod.setThickness(val) end
end)
local blCard = CreateCard(AimbotPage, "Skill Blacklist")
local blSkills = {
{ name = "Melee Z", cat = "Melee", key = "Z" },
{ name = "Melee X", cat = "Melee", key = "X" },
{ name = "Melee C", cat = "Melee", key = "C" },
{ name = "Sword Z", cat = "Sword", key = "Z" },
{ name = "Sword X", cat = "Sword", key = "X" },
{ name = "Fruit Z", cat = "Fruit", key = "Z" },
{ name = "Fruit X", cat = "Fruit", key = "X" },
{ name = "Fruit C", cat = "Fruit", key = "C" },
{ name = "Fruit V", cat = "Fruit", key = "V" },
{ name = "Fruit F", cat = "Fruit", key = "F" },
{ name = "Fruit TAP", cat = "Fruit", key = "TAP" },
{ name = "Gun Z", cat = "Gun", key = "Z" },
{ name = "Gun X", cat = "Gun", key = "X" },
}
AddMultiSelect(blCard, "Skill blacklist", blSkills, function(skill, value)
local m = RequireModule("modules/combat/blacklist.lua")
if value then m.add(skill.cat, skill.key) else m.remove(skill.cat, skill.key) end
end)
_G.SweetAimFilter = hookAimbotTargetFilter
]==========],
["PVP"]=[==========[
local combatCard = CreateCard(PvPPage, "Auto Combat")
AddToggle(combatCard, "Fast Attack", "Rapid melee and weapon strikes", false, function(state)
_G.DarlingX_FastAttack = state
local fa = M.getFastAttack(); if fa then
if state then fa.enable() else fa.disable() end
end
Notify("PvP", "Fast Attack: " .. (state and "Enabled" or "Disabled"))
end)
AddToggle(combatCard, "Fruit Fast Attack", "Fast Attack supporting Devil Fruits (By Darling)", false, function(state)
_G.DarlingX_FruitFastAttack = state
local ffa = M.getFruitFastAttack()
if ffa then ffa.toggle(state) end
local ew = _G.DarlingX_ExtraWidgets or M.getExtraWidgets()
if ew and ew.UpdateFruitFastAttackVisual then
ew.UpdateFruitFastAttackVisual(state)
end
Notify("PvP", "Fruit Fast Attack: " .. (state and "Enabled" or "Disabled"))
pcall(SaveConfigProfile)
end)
AddToggle(combatCard, "Fruit Fast Attack Floating Widget", "Movable on-screen toggle for Fruit Fast Attack", false, function(state)
local ew = _G.DarlingX_ExtraWidgets or M.getExtraWidgets()
if ew and ew.SetFruitFastAttackWidgetVisible then
ew.SetFruitFastAttackWidgetVisible(state)
end
pcall(SaveConfigProfile)
end)
AddToggle(combatCard, "Auto Buso Haki", "Keep Armament Haki active", false, function(state)
local ac = M.getAutoCombat(); if ac then ac.SetAutoBuso(state) end
Notify("PvP", "Auto Buso: " .. (state and "Enabled" or "Disabled"))
end)
AddToggle(combatCard, "Auto Race V3", "Cast Race V3 when in combat", false, function(state)
local ac = M.getAutoCombat(); if ac then ac.SetAutoV3(state) end
Notify("PvP", "Auto V3: " .. (state and "Enabled" or "Disabled"))
end)
AddToggle(combatCard, "Auto Race V4", "Cast Race V4 when gauge is full", false, function(state)
local ac = M.getAutoCombat(); if ac then ac.SetAutoV4(state) end
Notify("PvP", "Auto V4: " .. (state and "Enabled" or "Disabled"))
end)
AddToggle(combatCard, "Dragon Gun M1 [Ban Risk]", "Rapid fire M1 gun shots [Ban Risk]", false, function(state)
_G.DarlingX_DragonM1Enabled = state
local dg = M.getDragonGun(); if dg then dg.SetEnabled(state) end
local ew = M.getExtraWidgets(); if ew then ew.SetDragonM1WidgetVisible(state); ew.UpdateDragonM1Visual(state) end
Notify("PvP", "Dragon Gun M1: " .. (state and "Enabled" or "Disabled"))
end)
AddToggle(combatCard, "Saishi Sword One Shot", "Teleport combo with velocity reset (Mobile widget & Z/F keys)", false, function(state)
local s = M.getSaishiOneShot()
if s then s.SetEnabled(state) end
Notify("PvP", "Saishi One Shot: " .. (state and "Enabled" or "Disabled"))
pcall(SaveConfigProfile)
end)
AddToggle(combatCard, "Combat Tracker", "Lock behind target with floating button (Darling/Spooky)", false, function(state)
local t = M.getTracker()
if t then t.SetEnabled(state) end
Notify("PvP", "Combat Tracker: " .. (state and "Enabled" or "Disabled"))
pcall(SaveConfigProfile)
end)
local kitCard = CreateCard(PvPPage, "Kit One Shot")
AddToggle(kitCard, "Kit One Shot", "Instant 18k+ Fruit M1 Void Remote attack", false, function(state)
local kos = M.getKitOneShot()
if kos then kos.toggle(state) end
Notify("PvP", "Kit One Shot: " .. (state and "Enabled" or "Disabled"))
pcall(SaveConfigProfile)
end)
AddChoice(kitCard, "M1 Delay", { "0.05s (Fast)", "0.10s", "0.15s (Def)", "0.25s", "0.50s" }, 3, function(choice)
local val = tonumber(string.match(choice, "[%d%.]+")) or 0.15
local kos = M.getKitOneShot()
if kos and kos.setDelay then kos.setDelay(val) end
Notify("PvP", "Kit One Shot Delay: " .. tostring(val) .. "s")
end)
AddToggle(kitCard, "Kit One Shot Floating Widget", "Movable on-screen toggle for Kit One Shot", false, function(state)
local ew = _G.DarlingX_ExtraWidgets or M.getExtraWidgets()
if ew and ew.SetKitOneShotWidgetVisible then
ew.SetKitOneShotWidgetVisible(state)
end
end)
local techCard = CreateCard(PvPPage, "Combat Tech")
AddToggle(techCard, "Camlock", "Lock camera onto enemy", false, function(state)
local cl = M.getCamlock(); if cl then cl.SetEnabled(state) end
end)
AddToggle(techCard, "Sanguine Boost", "Forward velocity boost", false, function(state)
_G.DarlingX_SanguineBoost = state
local sb = M.getSanguineBoost(); if sb then sb.SetEnabled(state) end
local ew = M.getExtraWidgets(); if ew then ew.SetSanguineWidgetVisible(state) end
Notify("PvP", "Sanguine Boost: " .. (state and "Active" or "Inactive"))
end)
local sanguineKey = "None"
AddChoice(techCard, "Camlock Keybind", { "C", "Q", "E", "R", "T", "X", "V", "B", "None" }, 1, function(val)
local cl = M.getCamlock(); if cl then cl.SetKeybind(val) end
end)
AddChoice(techCard, "Sanguine Keybind", { "None", "Z", "Q", "E", "R", "T", "X", "C", "V", "B" }, 1, function(val)
sanguineKey = val
end)
AddSlider(techCard, "Camera FOV", 70, 120, 70, 5, function(val)
if Workspace.CurrentCamera then Workspace.CurrentCamera.FieldOfView=val end
local cl = M.getCamlock(); if cl then cl.SetCameraFOV(val) end
end)
local hitboxMod = RequireModule("modules/pvp/hitbox_expander.lua")
local staticCamMod = RequireModule("modules/pvp/static_cam.lua")
AddToggle(techCard, "Hitbox Expander", "Expand enemy hitboxes for guaranteed hits", false, function(state)
if hitboxMod then hitboxMod.SetEnabled(state) end
Notify("PvP", "Hitbox Expander: " .. (state and "Enabled" or "Disabled"))
end)
AddSlider(techCard, "Hitbox Size", 15, 45, 25, 5, function(val)
if hitboxMod then hitboxMod.SetSize(val) end
end)
AddToggle(techCard, "Hitbox Visual Forcefield", "Translucent pulse shader on expanded target", false, function(state)
if hitboxMod then hitboxMod.SetVisuals(state) end
end)
AddToggle(techCard, "Static Camera", "Eliminates camera shake, recoil, and bobbing during PvP", false, function(state)
if staticCamMod then staticCamMod.SetEnabled(state) end
Notify("PvP", "Static Camera: " .. (state and "Enabled" or "Disabled"))
end)
UserInputService.InputBegan:Connect(function(input, gpe)
if gpe then return end
if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
local key = input.KeyCode.Name
if sanguineKey ~= "None" and key == sanguineKey then
local sb = M.getSanguineBoost(); if sb then sb.Trigger() end
end
end)
local moveCard = CreateCard(PvPPage, "Movement")
AddToggle(moveCard, "Custom WalkSpeed", "Speed up player movement", false, function(state)
local mm = M.getMoveMod(); if mm then mm.SetWalkSpeed(state) end
Notify("PvP", "WalkSpeed: " .. (state and "Enabled" or "Disabled"))
end)
AddSlider(moveCard, "WalkSpeed Value", 16, 500, 150, 5, function(val)
local mm = M.getMoveMod(); if mm then mm.SetWalkSpeedValue(val) end
end)
AddToggle(moveCard, "Custom Dash Length", "Increase dash distance", false, function(state)
local mm = M.getMoveMod(); if mm then mm.SetDashLength(state) end
Notify("PvP", "Dash Length: " .. (state and "Enabled" or "Disabled"))
end)
AddSlider(moveCard, "Dash Distance", 15, 150, 30, 5, function(val)
local mm = M.getMoveMod(); if mm then mm.SetDashDistance(val) end
end)
AddToggle(moveCard, "Super Jump", "High jump leap", false, function(state)
local mm = M.getMoveMod(); if mm then mm.SetSuperJump(state) end
Notify("PvP", "Super Jump: " .. (state and "Enabled" or "Disabled"))
end)
AddSlider(moveCard, "Super Jump Force", 50, 350, 216, 5, function(val)
local mm = M.getMoveMod(); if mm then mm.SetSuperJumpPower(val) end
end)
AddToggle(moveCard, "Infinite Jump", "Jump continuously in mid-air", false, function(state)
local mm = M.getMoveMod(); if mm then mm.SetInfiniteJump(state) end
Notify("PvP", "Infinite Jump: " .. (state and "Enabled" or "Disabled"))
end)
AddToggle(moveCard, "Noclip Wallpass", "Pass through walls and objects", false, function(state)
local mm = M.getMoveMod(); if mm then mm.SetNoclip(state) end
Notify("PvP", "Noclip: " .. (state and "Enabled" or "Disabled"))
end)
AddToggle(moveCard, "Walk on Water", "Walk on ocean surface", false, function(state)
local mm = M.getMoveMod(); if mm then mm.SetWalkOnWater(state) end
Notify("PvP", "Walk on Water: " .. (state and "Enabled" or "Disabled"))
end)
AddToggle(moveCard, "Anti-Lava Damage", "Immunity to lava damage", false, function(state)
local mm = M.getMoveMod(); if mm then mm.SetAntiLava(state) end
Notify("PvP", "Anti-Lava: " .. (state and "Active" or "Disabled"))
end)
AddToggle(moveCard, "Fly", "Glide freely through the air", false, function(state)
local mm = M.getMoveMod(); if mm then mm.SetFly(state) end
Notify("PvP", "Fly: " .. (state and "Enabled" or "Disabled"))
end)
AddSlider(moveCard, "Fly Speed", 20, 500, 70, 5, function(val)
local mm = M.getMoveMod(); if mm then mm.SetFlySpeed(val) end
end)
]==========],
["Soru"]=[==========[
local soruMod = nil
local function getSoruMod()
if not soruMod then soruMod = RequireModule("modules/soru/soru_controller.lua") end
return soruMod
end
local cdCard = CreateCard(SoruPage, "Infinite Soru [Ban Risk]")
AddToggle(cdCard, "Infinite Soru [Ban Risk]", "Remove flashstep cooldown [Ban Risk]", false, function(state)
local sm = getSoruMod(); if sm and sm.setInfinite then sm.setInfinite(state) end
Notify("Soru", "Infinite Soru: " .. (state and "Enabled" or "Disabled"))
end)
local aimCard = CreateCard(SoruPage, "Soru Aimbot")
AddToggle(aimCard, "Soru Aimbot", "Teleport soru directly to enemy", false, function(state)
local sm = getSoruMod(); if sm and sm.setAimbot then sm.setAimbot(state) end
Notify("Soru", "Soru Aimbot: " .. (state and "Enabled" or "Disabled"))
end)
AddChoice(aimCard, "Soru Target Mode", { "Nearest Player", "Selected Player" }, 1, function(val)
local sm = getSoruMod(); if sm then sm.TargetMode = val end
end)
local playerList = { "None" }
pcall(function()
for _, p in ipairs(Players:GetPlayers()) do
if p ~= lp then table.insert(playerList, p.Name) end
end
end)
AddChoice(aimCard, "Target Player Selection", playerList, 1, function(val)
local sm = getSoruMod(); if sm then sm.SelectedPlayer = (val ~= "None" and val or nil) end
end)
AddSlider(aimCard, "Max Soru Range", 200, 3000, 2000, 100, function(val)
local sm = getSoruMod(); if sm then sm.MaxDistance = val end
end)
local comboCard = CreateCard(SoruPage, "Soru Skill Combo")
AddToggle(comboCard, "Auto Skill on Soru", "Use skill instantly after Soru", false, function(state)
local sm = getSoruMod(); if sm and sm.setSkillCombo then sm.setSkillCombo(state) end
Notify("Soru", "Skill Combo: " .. (state and "Enabled" or "Disabled"))
end)
AddChoice(comboCard, "Combo Weapon", { "Fruit", "Melee", "Sword", "Gun" }, 1, function(val)
local sm = getSoruMod(); if sm then sm.SkillWeapon = val end
end)
AddChoice(comboCard, "Combo Key", { "Z", "X", "C", "V", "F" }, 1, function(val)
local sm = getSoruMod(); if sm then sm.SkillKey = val end
end)
AddSlider(comboCard, "Skill Delay", 50, 800, 300, 25, function(val)
local sm = getSoruMod(); if sm then sm.SkillDelay = val / 1000 end
end)
AddToggle(aimCard,"Soru Button","Use the game's native Flash Step. Drag to move; tap to cast.",false,function(value)
getSoruMod().setButtonEnabled(value)
end)
AddChoice(aimCard,"Soru button mode",{"Normal Flash Step","Toward nearest player"},1,function(value)getSoruMod().ButtonMode=value end)
]==========],
["ESP"]=[==========[
local Design=RequireModule('modules/esp/design.lua')
local Widgets=RequireModule('modules/ui/widgets.lua')
local config={};for key,value in pairs(Design.Defaults)do config[key]=value end
local preview,view,drawing
local function refresh()
if preview and view then view:SetHighlight(config.Chams,config.Color);Design.Draw(drawing,config,view:Geometry(Design))end
local mod=RequireModule('modules/esp/esp_pvp.lua');for key,value in pairs(config)do if key~='Enabled'then mod[key]=value end end
end
local card=CreateCard(ESPPage,'Player ESP')
AddCustom(card,'Live ESP preview',330,function(body)
preview=body;view=Widgets.Viewport(body,lp);drawing=Design.New(body)
view.OnChanged=refresh;body:GetPropertyChangedSignal('AbsoluteSize'):Connect(refresh)
OnUnload(function()view:Destroy()end)
end)
AddToggle(card,'Master ESP','Enable the selected design on other players.',false,function(v)refresh();RequireModule('modules/esp/esp_pvp.lua').SetEnabled(v)end)
AddChoice(card,'ESP design',{'Corners','Outline','Floating tag'},1,function(v)config.Style=v;refresh()end)
for _,spec in ipairs({{'Boxes','Box outline',true},{'Names','Player names',true},{'Health','Health bar',true},
{'Distance','Distance label',true},{'Equipment','Fruit and equipped weapon',true},{'Skeleton','Skeleton lines',false},
{'Tracers','Player connection lines',false},{'Chams','Body highlight',false}})do
local option=spec;AddToggle(card,option[2],'Updates the mannequin and live player overlay.',option[3],function(v)config[option[1]]=v;refresh()end)
end
AddChoice(card,'ESP color',{'Cyan','White','Blue','Pink','Green','Red'},1,function(v)config.Color=THEMES[v];refresh()end)
AddSlider(card,'ESP text size',10,20,13,1,function(v)config.TextSize=v;refresh()end)
AddSlider(card,'ESP distance',100,5000,2500,100,function(v)config.MaxDistance=v;refresh()end)
]==========],
["Macro"]=[==========[
local m=RequireModule("modules/macro/macro_tab.lua")
m.Build(MacroPage,{CreateCard=CreateCard,AddToggle=AddToggle,AddChoice=AddChoice,AddButton=AddButton,Notify=Notify,RequireModule=RequireModule})
]==========],
["HUD"]=[==========[
local hudCard1 = CreateCard(HUDPage, "Blox Fruits Controls HUD")
local hudMod = nil
local function getHUDMod()
if not hudMod then
hudMod = RequireModule("modules/ui/controls_hud.lua")
end
return hudMod
end
local editToggle = nil
editToggle = AddToggle(hudCard1, "Unlock Dragging (Edit Controls)", "Allows dragging skill buttons (Z, X, C, V, F), dash, jump, and hotbar", false, function(v)
local mod = getHUDMod()
if mod then
mod.SetEditMode(v)
end
end)
AddToggle(hudCard1, "Lock Widgets & Toggles", "Lock floating widgets and controls from moving", false, function(v)
_G.DarlingX.LockWidgets = v
local langDict = TRANSLATIONS_DICT[CurrentLanguage]
local lockTxt = (CurrentLanguage ~= "English" and langDict and langDict["Widget lock:"]) or "Widget lock:"
local stateTxt = v and ((CurrentLanguage ~= "English" and langDict and langDict["Enabled"]) or "Enabled") or ((CurrentLanguage ~= "English" and langDict and langDict["Disabled"]) or "Disabled")
Notify("Widgets", lockTxt .. " " .. stateTxt)
pcall(SaveConfigProfile)
end)
local mod = getHUDMod()
if mod then
mod.OnModeChanged = function(active, reason)
if editToggle and editToggle.set then
pcall(function() editToggle.set(active == true, true) end)
end
end
end
AddButton(hudCard1, "Save & Lock Custom Layout", function()
local m = getHUDMod()
if m then
m.SetEditMode(false)
Notify("HUD Editor", "Controls layout saved successfully.")
end
end)
AddButton(hudCard1, "Discard Changes", function()
local m = getHUDMod()
if m then
m.CancelEdit()
Notify("HUD Editor", "Changes discarded. Restored last layout.")
end
end)
AddButton(hudCard1, "Reset to Default Layout", function()
local m = getHUDMod()
if m then
m.ResetLayout()
Notify("HUD Editor", "Controls restored to default game positions.")
end
end)
]==========],
["Skins"]=[==========[
local Widgets=RequireModule('modules/ui/widgets.lua')
local colors=Widgets.Palette()
local card=CreateCard(SkinsPage,'Fruit skins')
local selectedFruit,selectedPreset
local fruitLabel,buttons={}
local function fruitInfo()
local data=Widgets.Profile(lp);local fruit=data.Fruit
if not fruit or fruit==''or fruit=='None'then return nil,nil end
return tostring(fruit),Widgets.FruitImage(fruit)
end
local function refresh()
local fruit,image=fruitInfo();selectedFruit=fruit
if fruitLabel then fruitLabel.Text=fruit and('Detected fruit: '..fruit)or 'Equip a fruit to choose its skin'end
for _,b in ipairs(buttons)do
b.Image.Image=image and image.Image or '';b.Image.Visible=image~=nil;b.Button.Active=fruit~=nil
b.Image.ImageRectOffset=image and image.ImageRectOffset or Vector2.new(0,0);b.Image.ImageRectSize=image and image.ImageRectSize or Vector2.new(0,0)
b.Missing.Visible=not image
end
if fruit and not image and fruitLabel then fruitLabel.Text='Detected fruit: '..fruit..' · loading native fruit image'end
end
AddCustom(card,'Fruit color gallery',440,function(body)
fruitLabel=Widgets.Text(body,'',0,0,1,28,16);buttons={}
local ordered={'Purple','Red','Blue','Cyan','Green','Gold','Pink','Magenta','White','Black','Midnight','Orange'}
for i,name in ipairs(ordered)do
local col,row=(i-1)%4,math.floor((i-1)/4)
local b=Instance.new('TextButton');b.Name='FruitSkin_'..name;b.Text='';b.AutoButtonColor=false;b.BackgroundColor3=Color3.fromRGB(16,17,20);b.BorderSizePixel=0
b.Position=UDim2.new(col*.25,4,0,36+row*112);b.Size=UDim2.new(.25,-8,0,104);b.Parent=body
local round=Instance.new('UICorner');round.CornerRadius=UDim.new(0,12);round.Parent=b
local image=Instance.new('ImageLabel');image.ImageColor3=colors[name]:Lerp(Color3.new(1,1,1),.12);image.BackgroundTransparency=1;image.Position=UDim2.new(.5,-34,0,4);image.Size=UDim2.fromOffset(68,68);image.ScaleType=Enum.ScaleType.Fit;image.Parent=b
local missing=Widgets.Text(b,'Image unavailable',0,18,1,44,11);missing.TextXAlignment=Enum.TextXAlignment.Center;missing.TextWrapped=true
local label=Widgets.Text(b,name,0,76,1,22,13);label.TextXAlignment=Enum.TextXAlignment.Center
local entry={Button=b,Image=image,Missing=missing};buttons[#buttons+1]=entry
b.Activated:Connect(function()
refresh();if not selectedFruit then Notify('Skins','Equip a fruit first');return end
RequireModule('modules/visuals/fruit_palette.lua').Apply(selectedFruit,colors[name],name)
selectedPreset=name;SetPersistent('FruitPreset',name)
Notify('Skins',selectedFruit..' · '..name..' applied')
end)
end
refresh()
end)
AddButton(card,'Refresh detected fruit',refresh)
AddButton(card,'Restore fruit colors',function()RequireModule('modules/visuals/fruit_palette.lua').Reset();RequireModule('modules/visuals/skins_system.lua').resetCategoryToolSkin('Fruits');SetPersistent('FruitPreset','')end)
OnPageVisibility(SkinsPage,function(visible)if visible then refresh()end end)
_G.RestoreFruitPreset=function(name)
refresh();if selectedFruit and colors[name]then RequireModule('modules/visuals/fruit_palette.lua').Apply(selectedFruit,colors[name],name)end
end
local effects=CreateCard(SkinsPage,'Effect recoloring')
AddToggle(effects,'Enable VFX recolor','Keep the existing combat-effect recoloring engine available.',false,function(v)RequireModule('modules/visuals/skins_system.lua').setVFXEnabled(v)end)
AddChoice(effects,'VFX color',{'Purple','Red','Blue','Cyan','Green','Gold','Pink','White','Orange'},1,function(v)RequireModule('modules/visuals/skins_system.lua').setVFXColor(colors[v])end)
AddButton(effects,'Reset original VFX',function()RequireModule('modules/visuals/skins_system.lua').resetOriginalVFX()end)
local avatar=CreateCard(SkinsPage,'Avatar cloner')
local cloneInput=''
AddInput(avatar,'Player name or user ID','Username or numeric Roblox user ID','',function(v)cloneInput=v end)
AddButton(avatar,'Clone nearest player',function()local ok,message=RequireModule('modules/visuals/skins_system.lua').cloneNearestPlayer();assert(ok,message);Notify('Avatar',message or'Applied')end)
AddButton(avatar,'Apply avatar',function()assert(cloneInput~='','Enter a username or user ID first');local ok,message=RequireModule('modules/visuals/skins_system.lua').cloneByUserId(cloneInput);assert(ok,message)end)
AddButton(avatar,'Restore original avatar',function()RequireModule('modules/visuals/skins_system.lua').resetClonedAvatar()end)
]==========],
["Visual"]=[==========[
local feedback=RequireModule('modules/visuals/hit_feedback.lua')
local hitCard=CreateCard(VisualsPage,'Hit feedback')
AddToggle(hitCard,'Bullet effects','Show a tracer when the native damage feedback registers a recent attack.',false,function(v)feedback.SetBullets(v)end)
AddToggle(hitCard,'Ability impact effects','Add a local impact effect to native damage feedback.',false,function(v)feedback.SetHits(v)end)
AddToggle(hitCard,'Custom hit sounds','Play the selected sound when an attack produces damage feedback.',false,function(v)feedback.SetSound(v)end)
AddButton(hitCard,'Preview effects',function()feedback.PreviewEffects()end)
AddChoice(hitCard,'Bullet effect style',{'Neon','Lightning'},1,function(v)feedback.Style=v end)
AddChoice(hitCard,'Impact style',{'Pulse','Shatter'},1,function(v)feedback.HitStyle=v end)
local soundIds={Click='rbxasset://sounds/button.wav',Bell='rbxassetid://6534947240',Pop='rbxassetid://9118823106'}
AddChoice(hitCard,'Hit sound',{'Click','Bell','Pop'},1,function(v)feedback.SoundId=soundIds[v]end)
AddInput(hitCard,'Custom hit sound ID','Optional Roblox sound asset ID','',function(v)if tostring(v):match('%d+')then feedback.SoundId='rbxassetid://'..tostring(v):match('%d+')end end)
AddSlider(hitCard,'Hit sound volume (%)',0,100,50,5,function(v)feedback.Volume=v/100 end)
AddChoice(hitCard,'Hit effect color',{'Cyan','White','Blue','Pink','Red','Green'},1,function(v)feedback.Color=THEMES[v]end)
AddButton(hitCard,'Preview hit sound',function()feedback.TestSound()end)
local buddhaCard = CreateCard(VisualsPage, "Buddha Rainbow Circle")
AddToggle(buddhaCard, "Buddha Rainbow Circle", "Recolors your Buddha circle with animated rainbow gradient (Client-only)", false, function(state)
local br = M.getBuddhaRainbow()
if br then br.toggle(state) end
Notify("Visuals", "Buddha Rainbow Circle: " .. (state and "Enabled" or "Disabled"))
pcall(SaveConfigProfile)
end)
AddToggle(buddhaCard, "Only My Buddha Circle", "Only affects your own character instead of all nearby Buddha users", true, function(state)
local br = M.getBuddhaRainbow()
if br then br.OnlyMyCircle = state end
end)
local ghostShipCard = CreateCard(VisualsPage, "Delete Ghost Ship (Sea 2)")
AddToggle(ghostShipCard, "Delete Ghost Ship", "Removes interior walls and objects from Cursed Ship in Sea 2", false, function(state)
local gs = RequireModule("modules/misc/ghost_ship.lua")
if gs and gs.SetEnabled then
gs.SetEnabled(state)
end
Notify("Ghost Ship", state and "Ghost Ship structures deleted." or "Ghost Ship deletion stopped.")
pcall(SaveConfigProfile)
end)
]==========],
["Music"]=[==========[
local ytCard = CreateCard(MusicPage, "YouTube & External Players")
AddButton(ytCard, "Launch Universal YouTube Player", function()
Notify("YouTube Player", "Launching Universal YouTube Music Player...")
task.spawn(function()
local ok, err = pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Dan41/Roblox-Scripts/refs/heads/main/Youtube%20Music%20Player/YoutubeMusicPlayer.lua", true))()
end)
if not ok then
Notify("YouTube Player", "Failed to launch: " .. tostring(err))
end
end)
end)
local mCard1 = CreateCard(MusicPage, "Roblox Audio Player")
local customIdInput = "7025810761"
local origBgmVols = {}
local bgmConn = nil
local function toggleMuteGameMusic(state)
_G.DarlingX_MuteGameMusic = state
if state then
local function silence(s)
if s:IsA("Sound") and s.Name ~= "MonodyBGM" and not s:IsDescendantOf(ScreenGui) then
if origBgmVols[s] == nil then origBgmVols[s] = s.Volume end
s.Volume = 0
end
end
for _, s in ipairs(game:GetService("SoundService"):GetDescendants()) do silence(s) end
for _, s in ipairs(Workspace:GetDescendants()) do if s:IsA("Sound") and s.Name ~= "MonodyBGM" then silence(s) end end
if not bgmConn then
bgmConn = game:GetService("SoundService").DescendantAdded:Connect(function(s)
if _G.DarlingX_MuteGameMusic and s:IsA("Sound") and s.Name ~= "MonodyBGM" then
if origBgmVols[s] == nil then origBgmVols[s] = s.Volume end
s.Volume = 0
end
end)
end
else
if bgmConn then bgmConn:Disconnect(); bgmConn = nil end
for s, vol in pairs(origBgmVols) do
if s and s.Parent then pcall(function() s.Volume = vol end) end
end
table.clear(origBgmVols)
end
end
AddToggle(mCard1, "Mute Game Background Music", "Mute Roblox Blox Fruits background music while playing custom audio", false, function(state)
toggleMuteGameMusic(state)
Notify("Music Player", "Game BGM: " .. (state and "Muted" or "Restored"))
end)
local soundInputObj = AddInput(mCard1, "Custom Sound ID", "Enter Roblox Asset ID (e.g. 7025810761)...", "7025810761", function(v)
customIdInput = tostring(v or "")
end)
AddButton(mCard1, "Play", function()
local raw = (soundInputObj and soundInputObj.GetText and soundInputObj.GetText()) or customIdInput or "90089940136467"
local trimmed = tostring(raw):gsub("^%s+", ""):gsub("%s+$", "")
if _G.MonodyMusic then
if #trimmed > 0 then
_G.MonodyMusic.Play(trimmed, "")
Notify("Music Player", "Playing audio: " .. trimmed)
else
_G.MonodyMusic.Play("90089940136467", "Montagem Phonk")
Notify("Music Player", "Playing Montagem Phonk")
end
end
end)
AddButton(mCard1, "Pause", function()
if _G.MonodyMusic then
_G.MonodyMusic.Pause()
Notify("Music Player", "Playback paused")
end
end)
AddButton(mCard1, "Resume", function()
if _G.MonodyMusic then
_G.MonodyMusic.Resume()
Notify("Music Player", "Playback resumed")
end
end)
AddButton(mCard1, "Stop", function()
if _G.MonodyMusic then
_G.MonodyMusic.Stop()
Notify("Music Player", "Playback stopped")
end
end)
AddButton(mCard1, "Play Montagem Phonk", function()
if soundInputObj and soundInputObj.SetText then soundInputObj.SetText("90089940136467") end
if _G.MonodyMusic then
_G.MonodyMusic.Play("90089940136467", "Montagem Phonk")
Notify("Music Player", "Now playing: Montagem Phonk")
end
end)
AddSlider(mCard1, "Volume", 0, 100, 100, 5, function(v)
if _G.MonodyMusic then _G.MonodyMusic.SetVolume(v / 100) end
end)
AddSlider(mCard1, "Pitch / Speed", 0.5, 2.0, 1.0, 0.1, function(v)
if _G.MonodyMusic then _G.MonodyMusic.SetPitch(v) end
end)
AddToggle(mCard1, "Loop Track", "Repeats the current song automatically", true, function(v)
if _G.MonodyMusic then _G.MonodyMusic.SetLooped(v) end
end)
local isGameMuted = false
local originalSoundVolumes = setmetatable({}, { __mode = "k" })
local muteConns = {}
AddToggle(mCard1, "Mute Game Audio", "Silences ambient game SFX so only your music plays", false, function(v)
isGameMuted = v
if v then
local targets = { game:GetService("SoundService"), Workspace }
local pGui = lp:FindFirstChildOfClass("PlayerGui")
if pGui then table.insert(targets, pGui) end
for _, container in ipairs(targets) do
for _, obj in ipairs(container:GetDescendants()) do
if obj:IsA("Sound") and obj ~= (_G.MonodyMusic and _G.MonodyMusic.Sound) and obj.Name ~= "MonodyBGM" then
if originalSoundVolumes[obj] == nil then
originalSoundVolumes[obj] = obj.Volume
end
obj.Volume = 0
end
end
local conn = container.DescendantAdded:Connect(function(obj)
if isGameMuted and obj:IsA("Sound") and obj ~= (_G.MonodyMusic and _G.MonodyMusic.Sound) and obj.Name ~= "MonodyBGM" then
task.defer(function()
if isGameMuted and obj and obj.Parent then
if originalSoundVolumes[obj] == nil then
originalSoundVolumes[obj] = obj.Volume
end
obj.Volume = 0
end
end)
end
end)
table.insert(muteConns, conn)
end
Notify("Music Player", "Game audio muted.")
else
for _, conn in ipairs(muteConns) do
pcall(function() conn:Disconnect() end)
end
table.clear(muteConns)
for obj, vol in pairs(originalSoundVolumes) do
if obj and obj.Parent then
pcall(function() obj.Volume = vol end)
end
end
table.clear(originalSoundVolumes)
Notify("Music Player", "Game audio restored.")
end
end)
AddToggle(mCard1, "Show Top Music Bar", "Displays the audio player on the top header", true, function(v)
if _G.MonodyMusic and _G.MonodyMusic.TopBarFrame then
_G.MonodyMusic.TopBarFrame.Visible = v
end
end)
]==========],
["Waifu"]=[==========[
local c=CreateCard(WaifuPage,'Mika companion')
local function module()return RequireModule('modules/ai/mika.lua')end
AddToggle(c,'Enable Waifu','Original animated Mika, health alerts and quick tools.',false,function(v)
if v then module().Spawn({Parent=ScreenGui,OnTool=function(name)if name=='Players'then NavigateTo('PlayerList')elseif name=='Music'then NavigateTo('Music')end end})else module().Destroy()end
end)
AddToggle(c,'Companion quick tools','Show live Vitals, Player List and Music shortcuts.',true,function(v)module().SetTools(v)end)
AddToggle(c,'Companion idle dialogue','Allow optional idle dialogue; health alerts remain available.',false,function(v)module().SetAutoTalk(v)end)
AddToggle(c,'Follow cursor','React to your mouse or touch position.',true,function(v)module().SetFollow(v)end)
AddSlider(c,'Companion size',80,220,115,5,function(v)module().SetSize(v)end)
]==========],
["FFlags"]=[==========[
local flags=RequireModule('modules/misc/flags.lua')
local presets={['Low textures']={DFFlagTextureQualityOverrideEnabled=true,DFIntTextureQualityOverride=0},['No grass']={FIntFRMMinGrassDistance=0,FIntFRMMaxGrassDistance=0},['No MSAA']={FIntDebugForceMSAASamples=0}}
local chosen='Low textures'
local c=CreateCard(FFlagsPage,'FFlags executor')
local report,editor
local text=GetPersistent('FFlagsJSON')or '{}'
local function show(message)if report then report.Text=tostring(message)end;Notify('FFlags',message)end
local function apply(value)local ok,result=pcall(function()return flags.Apply(value)end);show(ok and result or tostring(result));return ok end
AddChoice(c,'FFlags preset',{'Low textures','No grass','No MSAA'},1,function(v)chosen=v end)
AddButton(c,'Run selected preset',function()apply(HttpService:JSONEncode(presets[chosen]))end)
editor=AddTextEditor(c,'FFlags JSON',340,{Name='FFlagsJSON',Text=text,Placeholder='{\"DFIntTextureQualityOverride\": 0}',Code=true},function(value)text=value;SetPersistent('FFlagsJSON',value)end)
AddButton(c,'Execute FFlags JSON',function()text=editor.Text;SetPersistent('FFlagsJSON',text);apply(text)end)
AddButton(c,'Restore original flag values',function()show(flags.Restore())end)
AddToggle(c,'Apply saved FFlags on startup','Only runs your saved JSON when this option is enabled.',false,function(v)if v then apply(GetPersistent('FFlagsJSON')or text)end end)
report=AddTextEditor(c,'Execution results',240,{Name='FFlagsResults',Text='Run a preset or your JSON to see verified, accepted and failed flags.',ReadOnly=true})
local perf=CreateCard(FFlagsPage,'Client performance')
AddToggle(perf,'Client FPS booster','Apply the existing client rendering optimizations.',false,SetFFlags1)
AddToggle(perf,'No Animations','Disable non-attack animations.',false,SetNoAnimations)
local sky=RequireModule('modules/visuals/sky_changer.lua')
local skyCard=CreateCard(FFlagsPage,'Sky')
AddToggle(skyCard,'Custom Sky','Use a custom skybox.',false,function(v)sky.SetEnabled(v)end)
AddChoice(skyCard,'Sky Preset',{'Realistic','Cloudy','FPS Boost','Mountains','Midnight','Galaxy'},6,function(v)sky.SetPreset(v)end)
]==========],
["Dungeons"]=[==========[
local c=CreateCard(DungeonPage,'Dungeon engine')
local function module()return RequireModule('modules/combat/dungeon_engine.lua')end
AddToggle(c,'Start Auto Dungeon','Run the original dungeon combat and room progression.',false,function(v)module().SetEnabled(v)end)
AddChoice(c,'Selected Weapon',{'Sword','Melee','Blox Fruit','Gun'},1,function(v)module().SetOption('Weapon',v)end)
AddSlider(c,'Attack Height',10,100,40,5,function(v)module().SetOption('Height',v)end)
AddToggle(c,'Auto Race V4','Activate race transformation during dungeon combat.',false,function(v)module().SetOption('AutoV4',v)end)
AddToggle(c,'Enable Void M1','Use the original Void M1 engine.',false,function(v)module().SetVoid(v)end)
AddToggle(c,'Void Only Boss Rooms','Use Void M1 only in boss rooms.',true,function(v)module().SetOption('BossOnly',v)end)
AddSlider(c,'Void Interval (s)',.05,.5,.08,.01,function(v)module().SetOption('VoidInterval',v)end)
AddToggle(c,'Auto Load Dungeon','Resume dungeon progression when available.',false,function(v)module().SetOption('AutoLoad',v)end)
]==========],
["Misc"]=[==========[
local W=RequireModule('modules/ui/widgets.lua')
local c=CreateCard(MiscPage,'Dev Darling')
local photo
AddCustom(c,'Developer',160,function(body)
photo=Instance.new('ImageLabel');photo.Size=UDim2.fromOffset(86,86);photo.Position=UDim2.fromOffset(0,4);photo.BackgroundTransparency=1;photo.Image=DeveloperImage or '';photo.ScaleType=Enum.ScaleType.Crop;photo.Parent=body
local r=Instance.new('UICorner');r.CornerRadius=UDim.new(0,18);r.Parent=photo
local name=W.Text(body,'Dev Darling',0,8,1,28,20);name.Position=UDim2.fromOffset(104,8);name.Size=UDim2.new(1,-104,0,28)
local social=W.Text(body,'TikTok · @rivalsxrodx',0,44,1,24,14);social.Position=UDim2.fromOffset(104,44);social.Size=UDim2.new(1,-104,0,24)
W.Text(body,'Sweet Exploit · Community & updates',0,112,1,24,13)
end)
AddInput(c,'Developer photo asset','rbxassetid://... or executor image path','',function(v)if photo then photo.Image=ResolveImage(v)or DeveloperImage or ''end end)
local function copy(value)assert(type(setclipboard)=='function','Clipboard is unavailable');setclipboard(value);Notify('Copied',value)end
AddButton(c,'Copy TikTok profile',function()copy('https://www.tiktok.com/@rivalsxrodx')end)
AddButton(c,'Copy Discord invite',function()copy('https://discord.gg/Q5JP8mKcRZ')end)
AddButton(c,'Copy server ID',function()copy(game.JobId)end)
AddButton(c,'Rejoin current server',RejoinServer)
AddButton(c,'Save configuration now',function()local ok,err=SaveConfigProfile();assert(ok,err);Notify('Configuration','Saved')end)
AddButton(c,'Open Support',function()NavigateTo('Support')end)
]==========],
["ScriptHub"]=[==========[
local HUB_SCRIPTS = {
{
name = "Cokeboys Keyless",
desc = "Full-featured Blox Fruits PvP & automation suite",
code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/rivals-hash/idk/main/scripts/cokeboys_keyless.lua"))()'
},
{
name = "Banana Cat Keyless",
desc = "Devx Banana Cat edition with auto-farm and boss hunter",
code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/rivals-hash/idk/main/scripts/banana_cat.lua"))()'
},
{
name = "Sacred AHK",
desc = "High-precision combo engine & macro automation (v12.5)",
code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/rivals-hash/idk/main/scripts/sacred_ahk.lua"))()'
},
{
name = "RJR Auto Bounty",
desc = "Automated bounty hunter & target tracker",
code = 'getgenv().language = "English"\nloadstring(game:HttpGet("https://rjr-loader.top/script/auto_bounty"))()'
},
{
name = "RJR Auto Find Fruits",
desc = "Fruit notifier and automated fruit collection",
code = 'getgenv().Language = "English"\nloadstring(game:HttpGet("https://rjr-loader.top/script/findfruit"))()'
},
{
name = "RJR Auto Levi",
desc = "Automated Leviathan hunting and Kaitun engine",
code = 'loadstring(game:HttpGet("https://rjr-loader.top/script/kaitunlevi"))()'
},
{
name = "Delta Executor In-Game",
desc = "In-game pastefy execution environment",
code = 'loadstring(game:HttpGet("https://pastefy.app/iXvqMv4G/raw", true))()'
},
{
name = "Supremacy",
desc = "Supremacy edition by Adramelech",
code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/rivals-hash/idk/main/scripts/supremacy.lua"))()'
},
{
name = "Nameless Cracked",
desc = "Nameless hit free edition",
code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/iSacredRivals/namelesshitfree/refs/heads/main/namelesscracked"))()'
},
{
name = "MasterTrap",
desc = "MasterTrap source edition by Darling",
code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/rivals-hash/idk/main/scripts/mastertrap.lua"))()'
},
}
for _, item in ipairs(HUB_SCRIPTS) do
local c=CreateCard(ScriptHubPage,item.name)
AddButton(c,item.name,function()
Notify("Script Hub","Launching "..item.name)
local f,e=loadstring(item.code); if not f then error(e) end; f()
end)
end
]==========],
["PlayerList"]=[==========[
local Widgets=RequireModule('modules/ui/widgets.lua')
local card=CreateCard(PlayersPage,'Players')
local chosen=lp.Name
local view,body,labels,title
local function selected()return Players:FindFirstChild(chosen)or lp end
local function refreshProfile(rebuild)
local p=selected();local data=Widgets.Profile(p)
if title then title.Text=data.Name..'  @'..data.Username end
if view and(rebuild or view.Player~=p)then view:SetPlayer(p)end
for key,label in pairs(labels or{})do
local value=data[key]
if key=='Health'and data.Health then value=tostring(data.Health)..' / '..tostring(data.MaxHealth)end
label.Text=value~=nil and tostring(value)or 'Unavailable'
end
end
AddCustom(card,'Player profile',390,function(root)
body=root;local model=Instance.new('Frame');model.BackgroundTransparency=1;model.Size=UDim2.fromScale(.40,1);model.Parent=root
view=Widgets.Viewport(model,selected());labels={}
title=Widgets.Text(root,'',.43,0,.55,32,18)
for i,entry in ipairs({{'Fruit','Fruit'},{'Sword','Sword'},{'Gun','Gun'},{'Race','Race'},{'Money','Money'},{'Bounty','Bounty / Honor'},{'Health','Health'}})do
Widgets.Text(root,entry[2],.43,38+(i-1)*38,.25,18,12).TextColor3=Color3.fromRGB(145,150,160)
labels[entry[1]]=Widgets.Text(root,'Unavailable',.65,38+(i-1)*38,.33,28,14)
end
refreshProfile();OnUnload(function()view:Destroy()end)
end)
local selector
local function refreshList()
local names={};for _,p in ipairs(Players:GetPlayers())do names[#names+1]=p.Name end;table.sort(names)
local index=table.find(names,chosen)or 1;chosen=names[index]or lp.Name
if selector and #names>0 then selector.SetValues(names,index,false)end
refreshProfile()
end
local names={};for _,p in ipairs(Players:GetPlayers())do names[#names+1]=p.Name end;table.sort(names)
selector=AddChoice(card,'Selected player',names,table.find(names,chosen)or 1,function(v)chosen=v;refreshProfile(true)end)
AddButton(card,'Refresh player profile',function()refreshList();refreshProfile(true)end)
AddButton(card,'Spectate selected player',function()local p=selected();local h=p.Character and p.Character:FindFirstChildOfClass('Humanoid');assert(h,'Character unavailable');Workspace.CurrentCamera.CameraSubject=h end)
local function stop()local h=lp.Character and lp.Character:FindFirstChildOfClass('Humanoid');if h then Workspace.CurrentCamera.CameraSubject=h end end
AddButton(card,'Stop spectating',stop)
AddToggle(card,'Blacklist selected player','Exclude this player from skill targeting.',false,function(v)local p=selected();_G.DarlingBlacklistedPlayers=_G.DarlingBlacklistedPlayers or{};_G.DarlingBlacklistedPlayers[p.UserId]=v;_G.DarlingBlacklistedPlayers[p.Name]=v end)
local poll
OnPageVisibility(PlayersPage,function(visible)
if poll then poll:Disconnect();poll=nil end
if visible then refreshList();local elapsed=0;poll=RunService.Heartbeat:Connect(function(dt)elapsed=elapsed+dt;if elapsed>=1 then elapsed=0;refreshProfile()end end)end
end)
OnUnload(function()if poll then poll:Disconnect()end;stop()end)
]==========],
["Keybinds"]=[==========[
local card=CreateCard(KeybindsPage,'Keyboard bindings')
local target,key,mode='None','F','Toggle'
local function names()
local list={};for name in pairs(UI_BINDABLES)do list[#list+1]=name end;table.sort(list);if #list==0 then list={'None'}end;return list
end
local function engine()return RequireModule('modules/ui/keybinds_system.lua')end
local values=names();target=values[1]
local feature=AddChoice(card,'Feature',values,1,function(v)target=v end)
AddChoice(card,'Key',{'F','Q','E','R','T','Z','X','C','V','B','G','H','J','K','L','One','Two','Three','Four','Five'},1,function(v)key=v end)
AddChoice(card,'Binding mode',{'Toggle','Hold','Press'},1,function(v)mode=v end)
AddButton(card,'Refresh available features',function()feature.SetValues(names(),1,true)end)
AddButton(card,'Add keybind',function()assert(target~='None','Open a feature tab first');local kb=engine();kb.Init();kb.AddKeybind(target,key,mode);Notify('Keybinds',target..' → '..key)end)
AddButton(card,'Clear all bindings',function()engine().ClearAll()end)
AddToggle(card,'Lock Widgets & Toggles','Prevent feature widgets from being dragged.',false,function(v)_G.DarlingX.LockWidgets=v end)
]==========],
["TikiKaitun"]=[==========[
local card=CreateCard(TikiKaitunPage,"Tiki Kaitun")
local engine
local function get() if not engine then engine=RequireModule("tiki_engine.lua") end;return engine end
AddToggle(card,"Start Tiki Kaitun","Farm the Tiki group, break arena pots, summon and defeat the boss.",false,function(v)get():SetEnabled(v)end)
AddChoice(card,"Weapon category",{"Melee","Sword","Fruit","Gun"},1,function(v)get():SetWeapon(v)end)
local safety=CreateCard(TikiKaitunPage,"Safety and farming")
for _,option in ipairs({
{"Protection","Low health protection",false},{"ResetAfterEscape","Reset after escaping",false},
{"AutoV4","Auto Race V4",false},{"ESPNPCs","NPC ESP",false},{"ESPBoss","Boss ESP",false},
{"AntiAFK","Anti AFK",true},{"AutoReconnect","Auto reconnect",true},{"AutoResume","Resume after teleport",true},
{"AutoRecovery","Recover after errors",true},{"FastAttack","Fast attack",true},{"AutoBuso","Auto Buso",true},
{"FarmNPCs","Farm NPCs",true},{"SpawnBoss","Summon boss",true},{"KillBoss","Kill boss",true},
}) do local spec=option;AddToggle(safety,spec[2],"Tiki engine option.",spec[3],function(v)get():SetOption(spec[1],v)end)end
for _,option in ipairs({{"LowHP","Escape below HP (%)",5,90,25,5},{"ResumeHP","Resume above HP (%)",10,100,75,5},{"Distance","Attack distance",3,25,8,1},{"TweenSpeed","Travel speed",100,400,210,5},{"TPRange","Teleport range",100,600,320,10}})do
local spec=option;AddSlider(safety,spec[2],spec[3],spec[4],spec[5],spec[6],function(v)get():SetOption(spec[1],v)end)
end
local report=CreateCard(TikiKaitunPage,"Status and reports")
AddButton(report,"Refresh Tiki status",function()local m=get();Notify("Tiki",tostring(m.State.Phase).." · Bosses "..tostring(m.State.BossDefeats).." · "..tostring(m.State.LastError or ""))end)
AddButton(report,"Save Tiki settings",function()get():SaveSettings();Notify("Tiki","Settings saved")end)
local url,interval="",60
AddInput(report,"Webhook URL","Optional Discord webhook URL","",function(v)url=v end)
AddSlider(report,"Report interval (minutes)",1,1440,60,1,function(v)interval=v end)
AddButton(report,"Save webhook settings",function()local ok,msg=get():SetWebhook(url,interval);if not ok then error(msg)end;Notify("Tiki",msg)end)
]==========],
["Themes"]=[==========[
local card=CreateCard(ThemesPage,"Dark appearance")
AddChoice(card,"Accent",{"White","Blue","Cyan","Green","Red","Pink","Yellow","Orange"},1,function(v)SweetAppearance.Accent(THEMES[v])end)
AddToggle(card,"Rainbow chroma","Animate the selected accent; keeps the dark surfaces.",false,function(v)SweetAppearance.Rainbow(v)end)
AddSlider(card,"Chroma speed",1,20,5,1,function(v)SweetAppearance.Speed(v/10)end)
AddSlider(card,"UI scale (%)",60,110,90,5,function(v)SweetAppearance.Scale(v/100)end)
AddChoice(card,"Glass strength",{"Smoked","Dark","Clear"},1,function(v)SweetAppearance.Glass(({Smoked=.18,Dark=.08,Clear=.35})[v])end)
AddChoice(card,"Font",{"Roboto","Gotham","SourceSansPro"},1,function(v)SweetAppearance.Font(v)end)
local wallpaperCard=CreateCard(ThemesPage,'Monody wallpapers')
local images={["Pikachu Starry Night"]="rbxassetid://121128577777470",["Knight in Cherry Blossoms"]="rbxassetid://71827928567053",["Crimson Angel"]="rbxassetid://108707236134250",["Eren Freedom"]="rbxassetid://98256258425377",["Animated Eyes"]="rbxassetid://97258407261189",["Miyamoto Musashi"]="rbxassetid://128389547809270",["Gengar Moonlight"]="rbxassetid://136115136156508",["Guts Crimson Eclipse"]="rbxassetid://74555352216405",["Griffith White Hawk"]="rbxassetid://136542796199352",["Light Yagami Judgment"]="rbxassetid://88753907462884",["Rukia White Dance"]="rbxassetid://76499109585246",["Rize Dragon"]="rbxassetid://92257414824880",["Subaru Dark Resolve"]="rbxassetid://90788397237794",["Gojo vs Sukuna"]="rbxassetid://118127455002284",["Unlimited Blade Works"]="rbxassetid://115330236878579",["Snow Angel"]="rbxassetid://107868389809187",["Neon Lights"]="rbxassetid://83813882888748",["Sunset Waves"]="rbxassetid://137543963570634"}
local names={'None'};for name in pairs(images)do names[#names+1]=name end;table.sort(names,function(a,b)if a=='None'then return true elseif b=='None'then return false end;return a<b end)
local preset,custom='None',''
local function applyWallpaper()SweetAppearance.Wallpaper(custom~=''and custom or images[preset]or '')end
AddChoice(wallpaperCard,'Monody wallpaper',names,1,function(v)preset=v;applyWallpaper()end)
AddInput(wallpaperCard,'Wallpaper asset or local path','rbxassetid://... or local executor image','',function(v)custom=v;applyWallpaper()end)
AddSlider(wallpaperCard,'Wallpaper dim (%)',0,100,65,5,function(v)SweetAppearance.WallpaperDim(v/100)end)
AddButton(wallpaperCard,'Clear wallpaper',function()custom='';preset='None';SweetAppearance.Wallpaper('');SetUIControl('Themes.Monody_wallpaper','None');SetUIControl('Themes.Wallpaper_asset_or_local_path','')end)
AddButton(card,'Reset appearance',function()SweetAppearance.Reset()end)
]==========],
["Animations"]=[==========[
local aCard = CreateCard(AnimationsPage, "Darling Hub Cinematics")
local CINEMATIC_NAMES = {
"Worldbreaker", "The Hollow Lantern", "The Aureate Sanctuary", "Transcendence Dragon", "King's Throne", "Admin Cinematic", "Comeback"
}
local CINEMATIC_MODULES = {
["Worldbreaker"] = "modules/special/worldbreaker.lua",
["The Hollow Lantern"] = "modules/special/halloween_cinematic.lua",
["The Aureate Sanctuary"] = "modules/special/sanctuary_cinematic.lua",
["Transcendence Dragon"] = "modules/special/transcendence_dragon.lua",
["King's Throne"] = "modules/special/kings_throne.lua",
["Admin Cinematic"] = "modules/special/admin_cinematic.lua",
["Comeback"] = "modules/special/comeback_cinematic.lua",
}
local selectedCinematic = "Worldbreaker"
local activeCinematicMod = nil
local function StopAllAnimations()
if activeCinematicMod then
pcall(function()
if activeCinematicMod.stop then
activeCinematicMod.stop()
elseif activeCinematicMod.dismiss then
activeCinematicMod.dismiss()
elseif activeCinematicMod.dismount then
activeCinematicMod.dismount()
end
end)
activeCinematicMod = nil
end
pcall(function()
local char = lp.Character
local hum = char and char:FindFirstChildOfClass("Humanoid")
if hum then Workspace.CurrentCamera.CameraSubject = hum end
end)
Notify("Visuals", "Cinematic cutscene stopped.")
end
local function PlayCinematic(name)
StopAllAnimations()
local relPath = CINEMATIC_MODULES[name]
if not relPath then return end
Notify("Cinematic", "Loading " .. name .. " engine...")
local cinematic = RequireModule(relPath)
if not cinematic then
Notify("Cinematic", "Failed to load " .. name .. " module.")
return
end
activeCinematicMod = cinematic
Notify("Cinematic", "Now playing: " .. name)
task.spawn(function()
pcall(function()
if name == "King's Throne" then
if cinematic.play then
cinematic.play(StopAllAnimations)
elseif cinematic.mount then
cinematic.mount()
end
elseif name == "Admin Cinematic" then
if cinematic.play then
cinematic.play(nil, StopAllAnimations)
end
elseif name == "Worldbreaker" then
if cinematic.play then
cinematic.play(StopAllAnimations)
end
elseif name == "The Hollow Lantern" then
if cinematic.play then
cinematic.play(StopAllAnimations)
end
elseif name == "The Aureate Sanctuary" then
if cinematic.play then
cinematic.play(StopAllAnimations)
end
elseif name == "Transcendence Dragon" then
if cinematic.play then
cinematic.play()
end
elseif name == "Comeback" then
if cinematic.play then
cinematic.play(nil, StopAllAnimations)
end
end
end)
end)
end
AddChoice(aCard, "Select Cinematic", CINEMATIC_NAMES, 1, function(v)
selectedCinematic = v
end)
AddButton(aCard, "Play Cinematic", function()
PlayCinematic(selectedCinematic)
end)
AddButton(aCard, "Skip Cinematic", StopAllAnimations)
local hideDragonLoop = nil
AddToggle(aCard, "Hide Dragon", "Hides or displays dragon model and visual aura", false, function(state)
local mod = RequireModule("modules/special/transcendence_dragon.lua")
if mod and mod.setHidden then mod.setHidden(state) end
if hideDragonLoop then
pcall(function() hideDragonLoop:Disconnect() end)
hideDragonLoop = nil
end
local function applyCharDragonHidden(hide)
pcall(function()
local char = localPlayer.Character
if not char then return end
for _, child in ipairs(char:GetChildren()) do
local cName = child.Name:lower()
if cName:find("dragon") or cName:find("wing") or cName:find("tail") or cName:find("hybrid") then
if child:IsA("BasePart") then
child.LocalTransparencyModifier = hide and 1 or 0
elseif child:IsA("Model") or child:IsA("Folder") then
for _, part in ipairs(child:GetDescendants()) do
if part:IsA("BasePart") then
part.LocalTransparencyModifier = hide and 1 or 0
elseif part:IsA("ParticleEmitter") or part:IsA("Light") or part:IsA("Beam") or part:IsA("Trail") then
part.Enabled = not hide
elseif part:IsA("Decal") or part:IsA("Texture") then
part.Transparency = hide and 1 or 0
end
end
end
end
end
end)
end
applyCharDragonHidden(state)
if state then
hideDragonLoop = RunService.RenderStepped:Connect(function()
applyCharDragonHidden(true)
end)
end
end)
AddToggle(aCard, "Hide Throne", "Hides or displays the king's throne model", false, function(state)
local mod = RequireModule("modules/special/kings_throne.lua")
if mod and mod.setHidden then
mod.setHidden(state)
elseif mod and state and mod.dismiss then
mod.dismiss()
end
end)
OnUnload(function()if activeCinematicMod then StopAllAnimations()end end)
]==========],
["LeviathanKaitun"]=[==========[
local c=CreateCard(LeviathanKaitunPage,'Leviathan Kaitun')
local function engine()return RequireModule('levi_engine.lua')end
AddToggle(c,'Start Leviathan Kaitun','Run the supplied Leviathan captain/follower engine.',false,function(v)engine():SetEnabled(v)end)
AddChoice(c,'Crew role',{'Captain','Follower'},1,function(v)engine():SetOption('Mode',v=='Captain'and 'Capitán'or 'Seguidor')end)
AddInput(c,'Captain name','Exact username to follow','',function(v)engine():SetOption('FollowTarget',v)end)
AddChoice(c,'Combat weapon',{'Sword','Melee','Blox Fruit','Gun'},1,function(v)engine():SetOption('SelectWeapon',v)end)
for _,spec in ipairs({{'AutoBuso','Auto Buso',true},{'AutoKen','Auto observation',false},{'FastAttack','Fast attack',false},
{'DragonGunLeviathan','Dragonstorm against Leviathan',false},{'HuntFightEvents','Fight sea events',false},
{'RespawnRebuy','Rebuy destroyed boats',false},{'AutoV3','Auto Race V3',false},{'AutoV4','Auto Race V4',false}})do
local option=spec;AddToggle(c,option[2],'Option from the supplied Leviathan engine.',option[3],function(v)engine():SetOption(option[1],v)end)
end
AddSlider(c,'Boat speed',50,500,250,10,function(v)engine():SetOption('BoatSpeed',v)end)
AddSlider(c,'Boat height',30,500,150,10,function(v)engine():SetOption('BoatHeight',v);engine():SetOption('BoatLockY',v)end)
AddButton(c,'Stop Leviathan',function()local t=UI_TOGGLES['Start Leviathan Kaitun'];if t then t.set(false,true)end end)
]==========],
["Support"]=[==========[
local category,title,message='Bug report','',''
local W=RequireModule('modules/ui/widgets.lua')
local c=CreateCard(SupportPage,'Suggestions & bug reports')
local bodyInput,status
local lastSend=-100
AddChoice(c,'Report type',{'Bug report','Suggestion'},1,function(v)category=v end)
AddInput(c,'Report title','Short title in English','',function(v)title=v end)
bodyInput=AddTextEditor(c,'Report message',320,{Name='SupportMessage',Text=GetPersistent('SupportDraft')or '',Placeholder='Write in English. Include steps to reproduce, expected behavior and what happened.'},function(value)SetPersistent('SupportDraft',value)end)
AddCustom(c,'Submission status',132,function(body)status=W.Text(body,'Your message is sent only when you press Send report.',0,0,1,64,14);status.Size=UDim2.fromScale(1,1);status.TextYAlignment=Enum.TextYAlignment.Top;status.TextWrapped=true end)
AddButton(c,'Send report',function()
assert(os.clock()-lastSend>=30,'Wait 30 seconds between reports')
message=bodyInput.Text
assert(#title>=3 and #title<=120,'Enter a title with 3–120 characters')
assert(#message>=10 and #message<=3000,'Enter a report with 10–3000 characters')
local send=(syn and syn.request)or request or http_request
assert(type(send)=='function','This executor does not support HTTP requests')
local payload={username='Sweet Exploit Support',allowed_mentions={parse={}},embeds={{title=category..': '..title,description=message,color=5814783,fields={{name='Game place ID',value=tostring(game.PlaceId),inline=true},{name='Report language',value='English',inline=true}}}}}
lastSend=os.clock();status.Text='Sending…'
task.spawn(function()
local ok,result=pcall(send,{Url='https://discord.com/api/webhooks/1574132191741607956/ZKakRCBV1-XJoqZKLaCDniCioy1Dsjx4jPXMOHWe3pGzpBTXcwBBEIDJx_LToywRfMir',Method='POST',Headers={['Content-Type']='application/json'},Body=HttpService:JSONEncode(payload)})
local code=ok and type(result)=='table'and tonumber(result.StatusCode or result.Status)
if code and code>=200 and code<300 then status.Text='Report sent. Thank you.';bodyInput.Text='';SetPersistent('SupportDraft','')
else status.Text='Report was not sent: '..(code and('HTTP '..code)or 'request failed')end
end)
end)
]==========]
}
    local loaded, building, built, failed = {}, {}, {}, {}
    local disposers, featureConnections = {}, {}
    local tasks = setmetatable({}, {__mode = "k"})
    local ownedInstances = setmetatable({}, {__mode = "k"})
    local shuttingDown = false
    local engineGlobals = setmetatable({}, {__index = env})
    local engineEnv = setmetatable({}, {__index = env})
    local uiToggles, uiChoices, uiSliders, bindables = {}, {}, {}, {}
    local defaults = {}
    local persistent={}
    engineEnv.SetUIControl=function(key,value)return api.Set(key,value)end
    engineEnv.GetPersistent=function(key)return persistent[key]end
    engineEnv.DeveloperImage=sweetImageURI
    engineEnv.ResolveImage=function(value)return localAsset(value) or (tostring(value):match("^rbxasset") and value)end
    engineEnv.NavigateTo=function(name)return api.Navigate(name)end
    engineEnv.SetPersistent=function(key,value)persistent[key]=value;if api.QueueSave then api.QueueSave(key)end end
    local function onUnload(fn) disposers[#disposers + 1] = fn end
    local function track(signal, fn)
        local c = signal:Connect(fn)
        featureConnections[#featureConnections + 1] = c
        return c
    end
    local function notice(title, text)
        api.LastNotice = tostring(title) .. ": " .. tostring(text)
        local p = pages[state.Tab]
        if p then p.Status.Text = api.LastNotice end
    end
    local serviceCache = {}
    local function serviceProxy(service)
        if serviceCache[service] then return serviceCache[service] end
        local proxy = setmetatable({}, {
            __index = function(_, key)
                local value = service[key]
                if typeof(value) == "RBXScriptSignal" then
                    return {Connect = function(_, fn) return track(value, fn) end,
                        Wait = function() return value:Wait() end,
                        Once = function(_, fn) local c; c = track(value,function(...) c:Disconnect(); fn(...) end); return c end}
                end
                if type(value) == "function" then return function(_, ...) return value(service, ...) end end
                return value
            end,
            __newindex = function(_, key, value) service[key] = value end,
        })
        serviceCache[service] = proxy
        return proxy
    end
    local gameProxy = setmetatable({}, {__index = function(_, key)
        if key == "GetService" then return function(_, name)
            local value = game:GetService(name)
            if name == "RunService" or name == "UserInputService" or name == "Players" then
                return serviceProxy(value)
            end
            return value
        end end
        local value = game[key]
        if type(value) == "function" then return function(_, ...) return value(game, ...) end end
        return value
    end})
    local function scheduled(method, fn, ...)
        if shuttingDown then return end
        local thread = task[method](fn, ...)
        if thread then tasks[thread] = true end
        return thread
    end
    engineEnv._G, engineEnv.getgenv = engineGlobals, function() return engineGlobals end
    engineGlobals._G = engineGlobals
    engineEnv.game, engineEnv.workspace = gameProxy, workspace
    engineEnv.task = setmetatable({
        spawn = function(fn, ...) return scheduled("spawn", fn, ...) end,
        defer = function(fn, ...) return scheduled("defer", fn, ...) end,
        delay = function(seconds, fn, ...)
            if shuttingDown then return end
            local thread = task.delay(seconds, fn, ...)
            if thread then tasks[thread] = true end
            return thread
        end,
    }, {__index = task})
    engineEnv.Instance = setmetatable({new = function(class, parent)
        local object = Instance.new(class, parent)
        ownedInstances[object] = true
        return object
    end}, {__index = Instance})
    engineEnv.SweetLogoURI = sweetImageURI or ""
    local requireModule
    local function compile(source, name)
        source=("\n"..source):gsub("([^%w_%.%]%)]%s*)([%a_][%w_%.]*):Connect%s*%(", "%1TrackConnection(%2,")
        local fn, err = (loadstring or load)(source, "@Sweet/" .. name)
        if not fn then error(err, 0) end
        assert(type(setfenv)=="function", "This executor must support setfenv for isolated feature modules")
        setfenv(fn, engineEnv)
        return fn
    end
    local hostFactory=compile([==========[
return function(base, sources, specs, native)
    local host = {Records = {}}
    local unpack = table.unpack or unpack
    local passive = {setRadius=true,setColor=true,setThickness=true,setMode=true,setRainbow=true,setType=true,setOrigin=true,
        setAimMode=true,setHitbox=true,setTeamCheck=true,setPriority=true,setMaxRange=true,setPrediction=true,setDelay=true,
        SetKeybind=true,SetCameraFOV=true,SetSmoothness=true,SetSize=true,SetVisuals=true,SetWalkSpeedValue=true,
        SetDashDistance=true,SetSuperJumpPower=true,SetFlySpeed=true,SaveSettings=true,SetSize=true,SetAutoTalk=true,SetTools=true,SetFollow=true,SetPose=true,SetMood=true,SetOption=true,SetWeapon=true,SetWebhook=true,
        setSlot=true,setVFXColor=true,setHidden=true,SetPreset=true,SetActiveSlot=true}
    local stops = {disable=true,stop=true,stopLoop=true,StopLoop=true,stopMacro=true,Destroy=true,destroy=true,
        ResetAll=true,Reset=true,reset=true,ClearAll=true,resetClonedAvatar=true,dismiss=true,dismount=true,RemoveUI=true,RemoveWidget=true,resetAllToolSkins=true,resetCategoryToolSkin=true,resetOriginalVFX=true}
    local starts = {enable=true,start=true,startLoop=true,StartLoop=true,Spawn=true,play=true,mount=true,executeCombo=true,Execute=true,
        applyToolSkin=true,recolorAllHotbarSlots=true,cloneNearestPlayer=true,cloneByUserId=true,apply=true,applyAsync=true}
    local pure = {['modules/macro/macro_tab.lua']=true,['modules/ui/widgets.lua']=true,['modules/esp/design.lua']=true,['modules/combat/blacklist.lua']=true}
    local function pack(...) return {n=select('#',...),...} end
    local function copy(value)
        if type(value)~='table' then return value end
        local result={};for k,v in pairs(value)do result[k]=copy(v)end;return result
    end
    local function loadSource(path)
        local value=sources[path]
        if type(value)=='function' then value=value();sources[path]=value end
        assert(type(value)=='string','Missing module: '..path)
        return value
    end
    local function trackScope(scope, signal, callback)
        if scope.Closed then return {Disconnect=function()end} end
        local c=signal:Connect(function(...) if not scope.Closed then return callback(...) end end)
        scope.Connections[#scope.Connections+1]=c;return c
    end
    local function makeScope(record)
        local scope={Connections={},Tasks=setmetatable({},{__mode='k'}),Objects=setmetatable({},{__mode='k'}),Closed=false}
        local environment=setmetatable({}, {__index=base})
        local globals=base._G
        if record.Path=='levi_engine.lua' then globals=setmetatable({}, {__index=base._G}) end
        environment._G,environment.getgenv=globals,function()return globals end
        environment.RawGame=native.game
        environment.TrackConnection=function(signal,fn)return trackScope(scope,signal,fn)end
        environment.Instance=setmetatable({new=function(class,parent)
            local object=native.Instance.new(class,parent);scope.Objects[object]=true;return object
        end},{__index=native.Instance})
        local function spawn(method,fn,...)
            if scope.Closed then return end
            local thread=native.task[method](function(...)if not scope.Closed then return fn(...)end end,...)
            if thread then scope.Tasks[thread]=true end;return thread
        end
        environment.task=setmetatable({spawn=function(fn,...)return spawn('spawn',fn,...)end,
            defer=function(fn,...)return spawn('defer',fn,...)end,
            delay=function(seconds,fn,...)
                if scope.Closed then return end
                local thread=native.task.delay(seconds,function(...)if not scope.Closed then return fn(...)end end,...)
                if thread then scope.Tasks[thread]=true end;return thread
            end},{__index=native.task})
        environment.spawn,environment.wait,environment.delay=environment.task.spawn,native.task.wait,environment.task.delay
        local services={}
        local function wrap(service)
            if services[service] then return services[service] end
            local proxy=setmetatable({}, {__index=function(_,key)
                local value=service[key]
                if typeof(value)=='RBXScriptSignal' then
                    return {Connect=function(_,fn)return trackScope(scope,value,fn)end,Wait=function()return value:Wait()end}
                end
                if type(value)=='function' then return function(_,...)return value(service,...)end end
                return value
            end,__newindex=function(_,key,value)service[key]=value end})
            services[service]=proxy;return proxy
        end
        environment.game=setmetatable({}, {__index=function(_,key)
            if key=='GetService'then return function(_,name)
                local service=native.game:GetService(name)
                if name=='VirtualInputManager'then return setmetatable({}, {__index=function(_,key)local fn=service[key];if type(fn)=='function'then return function(_,...)local args=pack(...);for i=1,args.n do if args[i]==environment.game then args[i]=native.game end end;return fn(service,unpack(args,1,args.n))end end;return fn end})end
                if name=='RunService'or name=='UserInputService'or name=='Players'then return wrap(service)end
                return service
            end end
            local value=native.game[key]
            if type(value)=='function'then return function(_,...)return value(native.game,...)end end
            return value
        end})
        environment.workspace=native.workspace
        if native.hookmetamethod then environment.hookmetamethod=function(object,...)return native.hookmetamethod(object==environment.game and native.game or object,...)end end
        if native.getrawmetatable then environment.getrawmetatable=function(object)return native.getrawmetatable(object==environment.game and native.game or object)end end
        environment.RequireModule=function(path)
            if path~=record.Path then record.Dependencies[path]=true end
            return host.Require(path)
        end
        scope.Environment,scope.Globals=environment,globals
        return scope
    end
    local function compile(source,path,environment)
        source=('\n'..source):gsub('([^%w_%.%]%)]%s*)([%a_][%w_%.]*):Connect%s*%(',' %1TrackConnection(%2,')
        source=source:gsub('([%a_][%w_%.]*):GetPropertyChangedSignal%(([^%)]*)%):Connect%s*%(','TrackConnection(%1:GetPropertyChangedSignal(%2),')
        source=source:gsub('([%a_][%w_%.]*):GetAttributeChangedSignal%(([^%)]*)%):Connect%s*%(','TrackConnection(%1:GetAttributeChangedSignal(%2),')
        local fn,err=(loadstring or load)(source,'@module/'..path);assert(fn,err);setfenv(fn,environment);return fn
    end
    local function merge(target,values)
        for key,value in pairs(values)do
            if type(value)=='table'and type(target[key])=='table'then merge(target[key],value)else target[key]=copy(value)end
        end
    end
    local function ensure(record)
        if record.Value~=nil then return record.Value end
        assert(not record.Building,'Circular module: '..record.Path);record.Building=true
        record.Scope=makeScope(record)
        if record.Path=='tiki_engine.lua'then record.Scope.Globals.TikiKaitunSource=loadSource(record.Path)end
        local ok,value=pcall(function()return compile(loadSource(record.Path),record.Path,record.Scope.Environment)()end)
        record.Building=false
        if not ok then host.Release(record.Path,true);error(value,0)end
        record.Value=value or {};merge(record.Value,record.Properties)
        for _,call in ipairs(record.Pending)do
            local fn=record.Value[call.Name]
            if type(fn)=='function'then
                if call.Colon then fn(record.Value,unpack(call.Args,1,call.Args.n))else fn(unpack(call.Args,1,call.Args.n))end
            end
        end
        if record.Path=='modules/combat/aimbot_core.lua' and base._G.SweetAimFilter then base._G.SweetAimFilter()end
        return record.Value
    end
    local function hasActive(record)for _,value in pairs(record.Active)do if value then return true end end;return false end
    local function used(path)
        for _,other in pairs(host.Records)do
            if other.Value and other.Path~=path and hasActive(other)and other.Dependencies[path]then return true end
        end
        return false
    end
    function host.Release(path,force)
        local record=host.Records[path];if not record or not record.Scope then return end
        if pure[path] and not force then return end
        if not force and(hasActive(record)or used(path))then return end
        local scope,mod=record.Scope,record.Value
        if record.Closing then return end;record.Closing=true
        if type(mod)=='table'then
            local method=mod.Destroy or mod.destroy or mod.ResetAll or mod.disable or mod.stop or mod.stopLoop
            if type(method)=='function'then pcall(method,mod)end
        end
        scope.Closed=true
        for _,c in ipairs(scope.Connections)do pcall(function()c:Disconnect()end)end
        for thread in pairs(scope.Tasks)do if thread~=coroutine.running()then pcall(native.task.cancel,thread)end end
        for object in pairs(scope.Objects)do pcall(function()object:Destroy()end)end
        for key,value in pairs(scope.Globals)do if value==mod then scope.Globals[key]=nil end end
        record.Value,record.Scope,record.Closing=nil,nil,false
        record.Active={}
        for dependency in pairs(record.Dependencies)do host.Release(dependency,false)end
    end
    local function nested(record,path)
        return setmetatable({}, {__index=function(_,key)
            local live=record.Value;local stored=record.Properties
            for _,part in ipairs(path)do live=type(live)=='table'and live[part]or nil;stored=stored[part]end
            local value=live and live[key];if value==nil then value=stored[key]end
            if type(value)=='table'then local nextPath={unpack(path)};nextPath[#nextPath+1]=key;return nested(record,nextPath)end
            return value
        end,__newindex=function(_,key,value)
            local live=record.Value;local stored=record.Properties
            for _,part in ipairs(path)do live=type(live)=='table'and live[part]or nil;stored=stored[part]end
            stored[key]=value;if live then live[key]=value end
        end})
    end
    local function invoke(record,name,...)
        local args=pack(...);local colon=args[1]==record.Proxy
        if colon then for i=1,args.n-1 do args[i]=args[i+1]end;args[args.n]=nil;args.n=args.n-1 end
        if name:match("^Update")then passive[name]=true end
        if passive[name]then
            local identity=name..(name=='setSlot'and tostring(args[1])or name=='SetOption'and tostring(args[1])or '')
            record.PendingKeys=record.PendingKeys or{}
            local entry={Name=name,Args=args,Colon=colon}
            if record.PendingKeys[identity]then
                local previous=record.Pending[record.PendingKeys[identity]]
                if name=='setSlot'then for i=2,args.n do if args[i]~=nil then previous.Args[i]=args[i]end end;previous.Args.n=math.max(previous.Args.n,args.n)else record.Pending[record.PendingKeys[identity]]=entry end
            else record.Pending[#record.Pending+1]=entry;record.PendingKeys[identity]=#record.Pending end
            if not record.Value then return true end
        end
        if stops[name]and not record.Value then return end
        if(name=='isEnabled'or name=='IsEnabled')and not record.Value then return false end
        if name=='getRadius'and not record.Value then return record.Properties.Radius or 100 end
        if name=='GetActive'and not record.Value then return nil end
        if name=='GetStatus'and not record.Value then return {Phase='Inactive',Enabled=false}end
        local first=args[1]
        local isToggle=not passive[name]and(type(first)=='boolean')and not name:match('^Get')
        if isToggle then
            record.Generation=(record.Generation or 0)+1
            record.Active[name]=first
            if not first and not record.Value then return end
        elseif starts[name]then record.Active[name]=true
        elseif stops[name]then record.Active={}
        elseif not passive[name]and not name:match('^[Gg]et')and not name:match('^[Ii]s')then record.Active[name]=true end
        local generation=record.Generation
        local mod=ensure(record)
        if isToggle and generation~=record.Generation and record.Active[name]~=first then host.Release(record.Path,false);return end
        local fn=mod[name]
        assert(type(fn)=='function','Unavailable method '..record.Path..':'..name)
        local ok,result=pcall(function()if colon then return pack(fn(mod,unpack(args,1,args.n)))else return pack(fn(unpack(args,1,args.n)))end end)
        if not ok then host.Release(record.Path,true);error(result,0)end
        if isToggle and not first or stops[name]then
            if name=='disable'or name=='Destroy'or name=='destroy'then record.Active={}end
            host.Release(record.Path,false)
        end
        return unpack(result,1,result.n)
    end
    function host.Require(path)
        if pure[path]then
            local record=host.Records[path]
            if not record then record={Path=path,Properties={},Pending={},Active={},Dependencies={}};host.Records[path]=record end
            return ensure(record)
        end
        if host.Records[path]then return host.Records[path].Proxy end
        local spec=specs[path]or{}
        local record={Path=path,Properties=copy(spec.Defaults or{}),Pending={},Active={},Dependencies=copy(spec.Dependencies or{})}
        record.Proxy=setmetatable({}, {__index=function(_,key)
            if spec.Methods and spec.Methods[key]then return function(...)return invoke(record,key,...)end end
            local value=record.Value and record.Value[key]
            if value==nil then value=record.Properties[key]end
            if type(value)=='function'then return function(...)return invoke(record,key,...)end end
            if type(value)=='table'then record.Properties[key]=record.Properties[key]or{};return nested(record,{key})end
            return value
        end,__newindex=function(_,key,value)
            record.Properties[key]=value;if record.Value then record.Value[key]=value end
        end})
        host.Records[path]=record;return record.Proxy
    end
    function host.Status()
        local result={};for path,r in pairs(host.Records)do result[path]={Loaded=r.Value~=nil,Active=hasActive(r),Connections=r.Scope and #r.Scope.Connections or 0}end;return result
    end
    function host.Destroy()for path in pairs(host.Records)do host.Release(path,true)end end
    return host
end
]==========],"host.lua")()
    local moduleHost=hostFactory(engineEnv,sourceModules,{["modules/ai/mika.lua"]={["Methods"]={["SetTools"]=true,["SetVisible"]=true,["SetThemeColor"]=true,["Destroy"]=true,["Spawn"]=true,["Express"]=true,["SetAutoTalk"]=true,["SetSize"]=true,["GetActive"]=true,["ReactToKill"]=true,["ReactToDeath"]=true,["Speak"]=true,["ReactToLowHp"]=true,["HideBubble"]=true,["RandomPhrase"]=true,["SetFollow"]=true},["Dependencies"]={},["Defaults"]={}},["modules/combat/aimbot_core.lua"]={["Methods"]={["isPlayerBlacklisted"]=true,["getFOVRadius"]=true,["__newindex"]=true,["getFOVCenter"]=true,["__index"]=true,["isKeyBlacklisted"]=true,["setLockPlayer"]=true,["faceTarget"]=true,["installHooks"]=true,["SetPlayerLock"]=true,["getToolCategory"]=true,["toggleLockPlayer"]=true,["predictPosition"]=true,["resolveAnyTarget"]=true,["stopLoop"]=true,["startLoop"]=true,["setCurrentSkillKey"]=true},["Dependencies"]={["modules/pvp/floating_widget.lua"]=true},["Defaults"]={["FOV"]={["Radius"]=100,["Mode"]="Center"},["BlacklistedKeys"]={["Melee"]={},["Fruit"]={},["Sword"]={},["Gun"]={}}}},["modules/combat/blacklist.lua"]={["Methods"]={["remove"]=true,["apply"]=true,["getTable"]=true,["add"]=true,["reset"]=true,["get"]=true,["set"]=true},["Dependencies"]={},["Defaults"]={}},["modules/combat/dungeon_engine.lua"]={["Methods"]={["SetVoid"]=true,["Destroy"]=true,["SetEnabled"]=true,["SetOption"]=true},["Dependencies"]={},["Defaults"]={}},["modules/combat/fast_attack_fruits.lua"]={["Methods"]={["enable"]=true,["isEnabled"]=true,["disable"]=true,["toggle"]=true},["Dependencies"]={},["Defaults"]={}},["modules/combat/fov.lua"]={["Methods"]={["isEnabled"]=true,["setAimMode"]=true,["enable"]=true,["disable"]=true,["setRainbow"]=true,["toggle"]=true,["setRadius"]=true,["setMode"]=true,["destroy"]=true,["setThickness"]=true,["setColor"]=true,["isAimModeFov"]=true,["getRadius"]=true},["Dependencies"]={},["Defaults"]={}},["modules/combat/kit_one_shot.lua"]={["Methods"]={["IsPain"]=true,["isEnabled"]=true,["MaxCombo"]=true,["GetFruit"]=true,["GetTapState"]=true,["IsBlade"]=true,["toggle"]=true,["ScanTapFn"]=true,["setDelay"]=true,["IsGas"]=true,["IsTrex"]=true,["IsTransformed"]=true,["IsControl"]=true,["TapInterval"]=true,["IsDragon"]=true},["Dependencies"]={},["Defaults"]={}},["modules/combat/npc_aimbot.lua"]={["Methods"]={["enable"]=true,["isEnabled"]=true,["setMaxRange"]=true,["disable"]=true},["Dependencies"]={["modules/combat/aimbot_core.lua"]=true},["Defaults"]={}},["modules/combat/player_aimbot.lua"]={["Methods"]={["setSelectedPlayer"]=true,["isEnabled"]=true,["setAimMode"]=true,["enable"]=true,["disable"]=true,["setHitbox"]=true,["setPrediction"]=true,["setPriority"]=true,["setMaxRange"]=true,["setTeamCheck"]=true},["Dependencies"]={["modules/combat/aimbot_core.lua"]=true},["Defaults"]={}},["modules/combat/saishi_one_shot.lua"]={["Methods"]={["RemoveUI"]=true,["SetEnabled"]=true,["CreateUI"]=true,["Execute"]=true},["Dependencies"]={},["Defaults"]={}},["modules/combat/tracers.lua"]={["Methods"]={["setThickness"]=true,["isEnabled"]=true,["setOrigin"]=true,["enable"]=true,["disable"]=true,["setRainbow"]=true,["destroy"]=true,["setType"]=true,["setVisible"]=true,["setColor"]=true},["Dependencies"]={},["Defaults"]={}},["modules/core/embedded_assets.lua"]={["Methods"]={},["Dependencies"]={},["Defaults"]={}},["modules/esp/design.lua"]={["Methods"]={["New"]=true,["Destroy"]=true,["Part"]=true,["Draw"]=true},["Dependencies"]={},["Defaults"]={}},["modules/esp/esp_pvp.lua"]={["Methods"]={["enable"]=true,["Destroy"]=true,["SetEnabled"]=true,["disable"]=true,["toggle"]=true},["Dependencies"]={["modules/esp/design.lua"]=true},["Defaults"]={}},["modules/macro/macro_engine.lua"]={["Methods"]={["stopMacro"]=true,["executeCombo"]=true,["setSlot"]=true,["startMacro"]=true,["ensureMobileButton"]=true,["setStatusCallback"]=true,["toggle"]=true},["Dependencies"]={},["Defaults"]={["ActiveSlot"]=1,["Slots"]={{["Blocks"]={{},{},{},{},{},{}}},{["Blocks"]={{},{},{},{},{},{}}},{["Blocks"]={{},{},{},{},{},{}}},{["Blocks"]={{},{},{},{},{},{}}},{["Blocks"]={{},{},{},{},{},{}}}}}},["modules/macro/macro_tab.lua"]={["Methods"]={["Build"]=true},["Dependencies"]={["modules/macro/macro_engine.lua"]=true},["Defaults"]={}},["modules/misc/client_tweaks.lua"]={["Methods"]={["ApplyFastFFlags"]=true,["SetNoAnimations"]=true,["SetFFlags1"]=true,["ResetAll"]=true},["Dependencies"]={},["Defaults"]={}},["modules/misc/ghost_ship.lua"]={["Methods"]={["StartLoop"]=true,["DeleteStructure"]=true,["SetEnabled"]=true},["Dependencies"]={},["Defaults"]={}},["modules/mobility/movement_engine.lua"]={["Methods"]={["SetWalkSpeedValue"]=true,["SetWalkSpeed"]=true,["SetNoclip"]=true,["SetWalkOnWater"]=true,["SetDashDistance"]=true,["SetSuperJump"]=true,["SetFly"]=true,["ResetAll"]=true,["SetInfiniteJump"]=true,["SetFlySpeed"]=true,["DoSuperJump"]=true,["SetDashLength"]=true,["SetSuperJumpPower"]=true,["SetAntiLava"]=true},["Dependencies"]={},["Defaults"]={}},["modules/pvp/auto_combat.lua"]={["Methods"]={["SetAutoV3"]=true,["ResetAll"]=true,["SetAutoV4"]=true,["SetAutoBuso"]=true},["Dependencies"]={},["Defaults"]={}},["modules/pvp/camlock.lua"]={["Methods"]={["Toggle"]=true,["StartLoop"]=true,["StopLoop"]=true,["Unlock"]=true,["DarlingX_SetCamlock"]=true,["SetKeybind"]=true,["DarlingX_ToggleCamlock"]=true,["SetSmoothness"]=true,["ToggleActive"]=true,["Lock"]=true,["SetActive"]=true,["SetCameraFOV"]=true,["SetEnabled"]=true},["Dependencies"]={},["Defaults"]={}},["modules/pvp/dragon_gun_m1.lua"]={["Methods"]={},["Dependencies"]={["modules/pvp/extra_widgets.lua"]=true},["Defaults"]={}},["modules/pvp/extra_widgets.lua"]={["Methods"]={},["Dependencies"]={["modules/pvp/camlock.lua"]=true,["modules/combat/aimbot_core.lua"]=true},["Defaults"]={}},["modules/pvp/fast_attack.lua"]={["Methods"]={["enable"]=true,["disable"]=true,["toggle"]=true},["Dependencies"]={},["Defaults"]={}},["modules/pvp/floating_widget.lua"]={["Methods"]={["Toggle"]=true,["TriggerAction"]=true,["SetVisible"]=true,["GetWidget"]=true,["create"]=true,["SetLabel"]=true,["SetWidgetVisible"]=true,["SetState"]=true,["Destroy"]=true,["LockAll"]=true,["Set"]=true},["Dependencies"]={},["Defaults"]={}},["modules/pvp/hitbox_expander.lua"]={["Methods"]={["SetSize"]=true,["SetEnabled"]=true,["SetVisuals"]=true},["Dependencies"]={},["Defaults"]={}},["modules/pvp/sanguine_boost.lua"]={["Methods"]={},["Dependencies"]={["modules/pvp/extra_widgets.lua"]=true},["Defaults"]={}},["modules/pvp/static_cam.lua"]={["Methods"]={["SetEnabled"]=true},["Dependencies"]={},["Defaults"]={}},["modules/pvp/tracker.lua"]={["Methods"]={["SetEnabled"]=true,["CreateWidget"]=true,["RemoveWidget"]=true},["Dependencies"]={},["Defaults"]={}},["modules/soru/soru_controller.lua"]={["Methods"]={["BeginAim"]=true,["setInfinite"]=true,["setAimbot"]=true,["SoruToNearest"]=true,["setSkillCombo"]=true,["setButtonEnabled"]=true,["ActivateButton"]=true,["Destroy"]=true},["Dependencies"]={},["Defaults"]={}},["modules/special/admin_cinematic.lua"]={["Methods"]={["destroy"]=true,["play"]=true,["stop"]=true,["Stop"]=true,["enable"]=true,["isPlaying"]=true,["dismiss"]=true},["Dependencies"]={},["Defaults"]={}},["modules/special/comeback_cinematic.lua"]={["Methods"]={["Stop"]=true,["enable"]=true,["horn"]=true,["destroy"]=true,["shard"]=true,["isPlaying"]=true,["ball"]=true,["update"]=true,["plate"]=true,["triangle"]=true,["stop"]=true,["nativeSurface"]=true,["part"]=true,["loft"]=true,["gem"]=true,["dismiss"]=true,["rod"]=true,["surface"]=true,["wedge"]=true,["play"]=true},["Dependencies"]={},["Defaults"]={}},["modules/special/halloween_cinematic.lua"]={["Methods"]={["Skip"]=true,["Stop"]=true,["stop"]=true,["play"]=true},["Dependencies"]={},["Defaults"]={}},["modules/special/kings_throne.lua"]={["Methods"]={["setHidden"]=true,["AddShake"]=true,["createDiamond"]=true,["SmoothRestore"]=true,["createLightningBolt"]=true,["dismount"]=true,["TriggerMeganovaFlash"]=true,["SetCosmicMidnight"]=true,["new"]=true,["SmoothHandOff"]=true,["playCinematic"]=true,["Update"]=true,["dismiss"]=true,["createParticleEmitter"]=true,["createPart"]=true,["mount"]=true,["play"]=true},["Dependencies"]={["modules/utility/music_engine.lua"]=true},["Defaults"]={}},["modules/special/sanctuary_cinematic.lua"]={["Methods"]={["Skip"]=true,["Stop"]=true,["stop"]=true,["play"]=true},["Dependencies"]={},["Defaults"]={}},["modules/special/transcendence_dragon.lua"]={["Methods"]={["setHidden"]=true,["startFlightController"]=true,["toggleMount"]=true,["dismount"]=true,["dismiss"]=true,["setMountPromptVisible"]=true,["spawnDirect"]=true,["mount"]=true,["toggleHidden"]=true,["play"]=true},["Dependencies"]={},["Defaults"]={}},["modules/special/worldbreaker.lua"]={["Methods"]={["Stop"]=true,["samplePoint"]=true,["stop"]=true,["play"]=true},["Dependencies"]={},["Defaults"]={}},["modules/ui/controls_hud.lua"]={["Methods"]={},["Dependencies"]={},["Defaults"]={}},["modules/ui/keybinds_system.lua"]={["Methods"]={["GetAllBindablesList"]=true,["SetKey"]=true,["RemoveKeybind"]=true,["SetMode"]=true,["Load"]=true,["ClearAll"]=true,["AddKeybind"]=true,["Init"]=true,["Save"]=true,["GetBindable"]=true,["RegisterBindable"]=true},["Dependencies"]={},["Defaults"]={}},["modules/ui/widgets.lua"]={["Methods"]={["Profile"]=true,["SetPlayer"]=true,["Geometry"]=true,["Viewport"]=true,["Text"]=true,["FruitImage"]=true,["SetHighlight"]=true,["Data"]=true,["Destroy"]=true,["Project"]=true,["Palette"]=true},["Dependencies"]={},["Defaults"]={}},["modules/visuals/avatar_changer.lua"]={["Methods"]={["apply"]=true,["setGiant"]=true,["isGiant"]=true,["applyAsync"]=true,["getDiagnostics"]=true,["destroy"]=true,["onStatusChanged"]=true,["getStatus"]=true,["reset"]=true,["getActiveId"]=true},["Dependencies"]={},["Defaults"]={}},["modules/visuals/buddha_rainbow.lua"]={["Methods"]={["isEnabled"]=true,["start"]=true,["stop"]=true,["toggle"]=true},["Dependencies"]={},["Defaults"]={}},["modules/visuals/fruit_palette.lua"]={["Methods"]={["Apply"]=true,["Destroy"]=true,["Reset"]=true},["Dependencies"]={["modules/visuals/skins_system.lua"]=true},["Defaults"]={}},["modules/visuals/skins_system.lua"]={["Methods"]={["resetCharacterSkin"]=true,["startVFXWatchers"]=true,["cloneNearestPlayer"]=true,["getTargetItem"]=true,["applyCharacterSkin"]=true,["destroy"]=true,["setVFXEnabled"]=true,["setAuraEnabled"]=true,["stopVFXWatchers"]=true,["cloneByUserId"]=true,["cloneCharacterAppearance"]=true,["setVFXColor"]=true,["resetCategoryToolSkin"]=true,["resetClonedAvatar"]=true,["resetOriginalVFX"]=true,["refreshAllVFX"]=true,["getDiagnostics"]=true,["resetAllToolSkins"]=true,["recolorAllHotbarSlots"]=true,["applyToolSkin"]=true},["Dependencies"]={["modules/visuals/avatar_changer.lua"]=true},["Defaults"]={["VFX"]={},["Tools"]={},["Character"]={}}},["modules/visuals/sky_changer.lua"]={["Methods"]={["ApplySky"]=true,["SetEnabled"]=true,["SetPreset"]=true,["Reset"]=true},["Dependencies"]={},["Defaults"]={}},["tiki_engine.lua"]={["Methods"]={["SaveSettings"]=true,["AimAt"]=true,["SetWebhook"]=true,["ArenaController"]=true,["MaintainBuso"]=true,["SetWeapon"]=true,["SetFarming"]=true,["Finite"]=true,["ReleaseArenaInput"]=true,["PrepareGate"]=true,["SetOption"]=true,["GunValidator"]=true,["GetStats"]=true,["HitPart"]=true,["SetEnabled"]=true,["Number"]=true,["ArenaInputBlocked"]=true,["GetBreakableDiagnostics"]=true,["GetReportPayload"]=true,["QuantumShoot"]=true,["ReadEyeProgress"]=true,["Allow"]=true,["ClickArenaM1"]=true,["ArenaNativeM1"]=true,["Read"]=true,["Destroy"]=true,["SaveWebhook"]=true},["Dependencies"]={},["Defaults"]={["State"]={["Phase"]="Inactive",["BossDefeats"]=0},["Config"]={}}},["levi_engine.lua"]={["Methods"]={["ApplyAutoFastMode"]=true,["RJR_StartBoatDeadMonitor"]=true,["RJR_ResetCharacterAtTiki"]=true,["RJR_BreakPhantomSeat"]=true,["ApplyFPSBoost"]=true,["GetStatus"]=true,["RJR_RefreshStatus"]=true,["SetOption"]=true,["ApplyAntiDracoAura"]=true,["RJR_StartKenLoop"]=true,["RJR_SeatConfirmed"]=true,["Destroy"]=true,["SetEnabled"]=true,["RJR_LeviathanPresent"]=true,["RJR_ResetMapNoclipState"]=true},["Dependencies"]={},["Defaults"]={}},["modules/misc/flags.lua"]={["Methods"]={["Restore"]=true,["Apply"]=true},["Dependencies"]={},["Defaults"]={}},["modules/visuals/hit_feedback.lua"]={["Methods"]={["SetHits"]=true,["PreviewEffects"]=true,["Destroy"]=true,["TestSound"]=true,["SetBullets"]=true,["SetSound"]=true},["Dependencies"]={},["Defaults"]={}}},{game=game,workspace=workspace,Instance=Instance,task=task,
        hookmetamethod=hookmetamethod,getrawmetatable=getrawmetatable})
    requireModule=moduleHost.Require
    api.ModuleStatus=moduleHost.Status
    engineEnv.RequireModule, engineGlobals.RequireModule = requireModule, requireModule
    engineGlobals.DarlingX = {
        Settings = {
            Aim = {Priority = "Nearest", Mode = "360", MaxRange = 1000, TargetPart = "HumanoidRootPart", Prediction = false, PredictionAmount = .12},
            FOV = {Radius = 100, Mode = "Center", Color = C.Accent},
            Tracers = {Type = "Both", Origin = "Player", Color = C.Accent},
            Blacklist = {Melee = {}, Sword = {}, Fruit = {}, Gun = {}},
        },
        Require = function(_, path) return requireModule(path) end,
        LockWidgets = false, CurrentLanguage = "en",
    }
    engineGlobals.DarlingHub = engineGlobals.DarlingX
    engineGlobals.UI_TOGGLES, engineGlobals.DarlingX_Bindables = uiToggles, bindables
    engineEnv.UI_TOGGLES, engineEnv.UI_CHOICES, engineEnv.UI_SLIDERS = uiToggles, uiChoices, uiSliders
    engineEnv.UI_BINDABLES = bindables
    engineEnv.OnUnload = onUnload
    engineEnv.TrackConnection = track
    engineEnv.Notify = notice
    engineEnv.CurrentLanguage, engineEnv.TRANSLATIONS_DICT = "English", {}
    engineEnv.CurrentAccent = C.Accent
    engineEnv.Players = game:GetService("Players")
    engineEnv.UserInputService = serviceProxy(Input)
    engineEnv.RunService = serviceProxy(Run)
    engineEnv.Workspace = workspace
    engineEnv.HttpService = game:GetService("HttpService")
    engineEnv.TweenService, engineEnv.CoreGui = Tween, CoreGui
    engineEnv.lp, engineEnv.localPlayer, engineEnv.pGui = player, player, player:FindFirstChild("PlayerGui")
    engineEnv.ScreenGui, engineEnv.parentGui, engineEnv.MainScale = gui, gui.Parent, panelScale
    engineEnv.Pages = {}
    engineEnv.UpdateCardGeometry, engineEnv.UpdatePageCanvas = function() end, function() end
    engineEnv.THEMES = {
        White = Color3.fromRGB(220,220,220), Purple = Color3.fromRGB(170,110,220),
        Red = Color3.fromRGB(235,80,80), Green = Color3.fromRGB(90,210,140), Blue = Color3.fromRGB(90,155,240),
        Pink = Color3.fromRGB(240,150,200), Cyan = Color3.fromRGB(90,220,230), Yellow = Color3.fromRGB(240,220,120),
        Orange = Color3.fromRGB(235,155,80),
    }
    local moduleGetters = {
        FastAttack="pvp/fast_attack", FruitFastAttack="combat/fast_attack_fruits", Macro="macro/macro_engine",
        DragonGun="pvp/dragon_gun_m1", SanguineBoost="pvp/sanguine_boost", ExtraWidgets="pvp/extra_widgets",
        AutoCombat="pvp/auto_combat", Camlock="pvp/camlock", MoveMod="mobility/movement_engine",
        Mika="ai/mika", KitOneShot="combat/kit_one_shot", SaishiOneShot="combat/saishi_one_shot",
        Tracker="pvp/tracker", BuddhaRainbow="visuals/buddha_rainbow",
    }
    engineEnv.M = {get = requireModule}
    for name, path in pairs(moduleGetters) do
        engineEnv.M["get" .. name] = function() return requireModule("modules/" .. path .. ".lua") end
    end
    local aliases = {PvP="PVP", Esp="ESP", Visuals="Visual", Players="PlayerList", Dungeon="Dungeons", WaifuAI="Waifu", Config="Settings"}
    engineEnv.RegisterTab = function(name) return pages[aliases[name] or name] end
    engineEnv.CreateCard = function(p, title) return {Page = p, Title = title} end
    local visibility={}
    local function updateVisibility()
        for name,callbacks in pairs(visibility)do for _,fn in ipairs(callbacks)do pcall(fn,shell.Visible and state.Tab==name)end end
    end
    engineEnv.OnPageVisibility=function(p,fn)
        for name,candidate in pairs(pages)do if candidate==p then visibility[name]=visibility[name]or{};table.insert(visibility[name],fn);fn(shell.Visible and state.Tab==name);return end end
    end
    engineEnv.AddCustom=function(cardInfo,title,height,build)
        local item=control(cardInfo.Page,'custom','Custom_'..title:gsub('%W',''),title,'',{Height=height})
        build(item.Body);return item
    end
    engineEnv.AddTextEditor=function(cardInfo,title,height,options,changed)
        options=options or{}
        local result
        engineEnv.AddCustom(cardInfo,title,height,function(body)
            local scroll=new('ScrollingFrame',{Name='EditorScroll',BackgroundColor3=Color3.fromRGB(12,13,16),BorderSizePixel=0,Size=UDim2.new(1,0,1,-26),
                CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=5,ScrollBarImageColor3=C.Muted,ClipsDescendants=true,Active=true},body)
            corner(scroll,10);stroke(scroll,C.Border,.3,1)
            local box=new('TextBox',{Name=options.Name or 'Editor',Text=options.Text or '',PlaceholderText=options.Placeholder or '',ClearTextOnFocus=false,
                MultiLine=true,TextWrapped=true,RichText=false,TextEditable=not options.ReadOnly,TextTruncate=Enum.TextTruncate.None,TextXAlignment=Enum.TextXAlignment.Left,
                TextYAlignment=Enum.TextYAlignment.Top,TextSize=15,Font=options.Code and Enum.Font.Code or Enum.Font.Gotham,
                TextColor3=C.Text,PlaceholderColor3=C.Muted,BackgroundTransparency=1,BorderSizePixel=0,Position=UDim2.fromOffset(12,12),
                Size=UDim2.new(1,-32,0,math.max(80,height-112)),AutomaticSize=Enum.AutomaticSize.Y},scroll)
            local footer=label(body,options.Note or (options.ReadOnly and 'Select text to copy results'or 'Changes are saved automatically'),11,C.Muted)
            footer.Position=UDim2.new(0,2,1,-20);footer.Size=UDim2.new(1,-4,0,18)
            if not options.ReadOnly then track(box:GetPropertyChangedSignal('Text'),function()if changed then changed(box.Text)end end)end
            result=box
        end)
        return result
    end
    local counters = {}
    local function add(cardInfo, kind, title, description, default, options, callback)
        local p = assert(cardInfo.Page, "Missing page")
        local pageId
        for name, candidate in pairs(pages) do if candidate == p then pageId = name; break end end
        local stem = pageId .. "." .. title:gsub("[^%w]+", "_"):gsub("_$", "")
        counters[stem] = (counters[stem] or 0) + 1
        local key = stem .. (counters[stem] > 1 and ("_" .. counters[stem]) or "")
        options = options or {}
        state[key], defaults[key] = default, default
        local last = default
        local function invoke(value)
            if shuttingDown then return end
            local ok, err = pcall(callback or function() end, value)
            if not ok then
                if kind ~= "button" then set(key, last, false) end
                local control=controls[key]
                if control then
                    control.Subtitle.Text='Could not enable: '..tostring(err):sub(1,120)
                    control.Subtitle.TextColor3=Color3.fromRGB(238,155,145)
                    if layout then layout()end
                end
                p.Status.Text = "Error: " .. tostring(err):sub(1, 190)
                warn("Sweet Exploit · " .. key .. ": " .. tostring(err))
                return false, err
            end
            if controls[key]then controls[key].Subtitle.Text=description~=''and description or cardInfo.Title;controls[key].Subtitle.TextColor3=C.Muted end
            last = value
            return true
        end
        options.OnChanged = invoke
        if kind == "button" then options.OnActivate = function() invoke() end end
        local c = control(p, kind, key, title, description ~= "" and description or cardInfo.Title, options)
        if pageId=='Visual'and kind=='toggle'then c.Wide=true end
        if (pageId=='Support'or pageId=='FFlags')and(kind=='input'or kind=='button')then c.Wide=true end
        local proxy = {Instance = c.Root, Key = key}
        proxy.get = function() return state[key] end
        proxy.set = function(value, runCallback)
            if state[key] ~= value then set(key, value, runCallback == true) end
        end
        proxy.SetState, proxy.SetText = proxy.set, proxy.set
        proxy.GetText = function() return c.Input.Text end
        proxy.SetIndex = function(value, runCallback)
            if type(value) == "number" then value = c.Values[value] end
            if value then proxy.set(value, runCallback) end
        end
        proxy.SetValues = function(values, index, runCallback)
            if values and #values > 0 then c.Values = values; if c.RebuildOptions then c.RebuildOptions() end; proxy.SetIndex(index or 1, runCallback); if layout then layout() end end
        end
        proxy.Refresh = proxy.SetValues
        if kind == "toggle" then
            uiToggles[title] = proxy
            bindables[pageId .. " · " .. title] = {name = title, kind = "Toggle", get = proxy.get,
                set = function(v) proxy.set(v,true) end, toggle = function() proxy.set(not proxy.get(),true) end}
        elseif kind == "button" then
            bindables[pageId .. " · " .. title] = {name = title, kind = "Button", trigger = function() invoke() end}
        elseif kind == "choice" then uiChoices[title] = proxy
        elseif kind == "slider" then uiSliders[title] = proxy end
        return proxy
    end
    engineEnv.AddToggle = function(cardInfo,title,description,default,callback)
        return add(cardInfo,"toggle",title,description,default == true,nil,callback)
    end
    engineEnv.AddChoice = function(cardInfo,title,values,index,callback)
        local chosen = values[index or 1] or values[1]
        return add(cardInfo,"choice",title,"",chosen,{Values=values},function(value)
            local choices=uiChoices[title];local i=table.find((choices and controls[choices.Key].Values)or values,value)or 1
            if callback then return callback(value,i) end
        end)
    end
    engineEnv.AddSlider = function(cardInfo,title,min,max,default,step,callback)
        return add(cardInfo,"slider",title,"",default,{Min=min,Max=max,Step=step},callback)
    end
    engineEnv.AddButton = function(cardInfo,title,callback) return add(cardInfo,"button",title,"",nil,nil,callback) end
    engineEnv.AddInput = function(cardInfo,title,placeholder,default,callback)
        return add(cardInfo,"input",title,"",default or "",{Placeholder=placeholder},callback)
    end
    engineEnv.AddMultiSelect = function(cardInfo, title, items, callback)
        local p = cardInfo.Page
        local group = control(p, "foldout", "SkillBlacklist", title, "", {})
        for _, item in ipairs(items) do
            local proxy = add(cardInfo, "toggle", "Exclude " .. item.name, "", false, nil,
                function(value) return callback(item, value) end)
            local child = controls[proxy.Key]
            table.remove(p.Rows, #p.Rows)
            child.Root.Parent, child.Root.BackgroundTransparency = group.List, 1
            for _, decoration in ipairs(child.Root:GetChildren()) do
                if decoration:IsA("UIStroke") then decoration.Enabled = false end
                if decoration.Name == "GlassHighlight" then decoration.Visible = false end
            end
            group.Items[#group.Items + 1] = child
            local render = child.Render
            child.Render = function(value) render(value); group.Render() end
        end
        group.Render()
        return group
    end
    engineEnv.SetFFlags1 = function(value) return requireModule("modules/misc/client_tweaks.lua").SetFFlags1(value) end
    engineEnv.SetNoAnimations = function(value) return requireModule("modules/misc/client_tweaks.lua").SetNoAnimations(value) end
    engineEnv.ApplyFastFFlags = function() return requireModule("modules/misc/client_tweaks.lua").ApplyFastFFlags() end
    engineEnv.RejoinServer = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,player) end
    local function resetPreferences()
        for key, value in pairs(defaults) do if controls[key] and controls[key].Kind ~= "button" then set(key,value) end end
    end
    engineEnv.ResetConfigProfile = resetPreferences
    local function sync(title, flag)
        return function(value)
            if flag then engineGlobals[flag] = value == true end
            local t = uiToggles[title]; if t then t.set(value == true,false) end
        end
    end
    engineGlobals.DarlingX_SyncFruitFastAttackUI = sync("Fruit Fast Attack","DarlingX_FruitFastAttack")
    engineGlobals.DarlingX_SyncKitOneShotUI = sync("Kit One Shot","DarlingX_KitOneShot")
    engineGlobals.DarlingX_SyncMacroUI = sync("Macro","DarlingX_Macro")
    engineGlobals.DarlingX_SyncCamlockUI = sync("Camlock")
    -- Monody's music actions use this headless Sound adapter, with no second player UI.
    local music = {Sound = nil}
    local musicVolume,musicPitch,musicLoop = 1,1,true
    local function ensureMusic()
        if not music.Sound then
            music.Sound = Instance.new("Sound"); music.Sound.Name = "MonodyBGM"
            music.Sound.Volume, music.Sound.Looped, music.Sound.PlaybackSpeed = musicVolume, musicLoop, musicPitch
            music.Sound.Parent = game:GetService("SoundService")
            ownedInstances[music.Sound] = true
        end
        return music.Sound
    end
    function music.Play(id)
        local raw=tostring(id);local digits=raw:match("%d+")
        assert(raw:match("^rbxasset") or digits,"Invalid Sound ID")
        ensureMusic()
        music.Sound.SoundId = tostring(id):match("^rbxasset") and tostring(id) or ("rbxassetid://"..tostring(id):match("%d+"))
        music.Sound:Stop(); music.Sound.TimePosition=0; music.Sound:Play()
    end
    function music.Pause() if music.Sound then music.Sound:Pause() end end
    function music.Resume() if music.Sound then music.Sound:Resume() end end
    function music.Stop() if music.Sound then music.Sound:Stop() end end
    function music.SetVolume(v) musicVolume=v; if music.Sound then music.Sound.Volume=v end end
    function music.SetPitch(v) musicPitch=v; if music.Sound then music.Sound.PlaybackSpeed=v end end
    function music.SetLooped(v) musicLoop=v; if music.Sound then music.Sound.Looped=v end end
    engineGlobals.MonodyMusic = music
    local rainbow, rainbowSpeed, wallpaper, rainbowTime = false, .5, nil, 0
    local wallpaperDim=.65
    local rainbowConnection
    local function applyAccent(color)
        C.Accent, C.AccentDark = color, color
        for _,c in pairs(controls) do
            if c.Kind == "choice" or c.Kind == "button" then c.Input.TextColor3=color end
            c.Render(state[c.Key])
        end
        engineEnv.CurrentAccent=color
    end
    engineEnv.SweetAppearance = {
        Accent=applyAccent, Rainbow=function(v)
            rainbow=v
            if rainbowConnection then rainbowConnection:Disconnect();rainbowConnection=nil end
            if v then rainbowConnection=track(Run.RenderStepped,function(dt)rainbowTime=rainbowTime+dt*rainbowSpeed*.1;applyAccent(Color3.fromHSV(rainbowTime%1,.48,.86))end)end
        end, Speed=function(v)rainbowSpeed=v end,
        Scale=function(v)Config.WindowScale=v;layout()end,
        Glass=function(v)Config.GlassTransparency=v;shell.BackgroundTransparency=v end,
        Font=function(name)
            local family="rbxasset://fonts/families/"..name..".json"
            for _,obj in ipairs(gui:GetDescendants()) do
                if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                    local old=obj.FontFace; obj.FontFace=Font.new(family,old.Weight,old.Style)
                end
            end
        end,
        Wallpaper=function(value)
            if not wallpaper then
                wallpaper=new("ImageLabel",{Name="CustomWallpaper",BackgroundTransparency=1,Size=UDim2.fromScale(1,1),ScaleType=Enum.ScaleType.Crop,ImageTransparency=wallpaperDim,ZIndex=0},shell)
                corner(wallpaper,28)
            end
            local id=tostring(value):match("^%d+$")
            wallpaper.Image=id and ("rbxassetid://"..id) or (localAsset(value) or (tostring(value):match("^rbxassetid://") and value) or "")
            wallpaper.Visible=wallpaper.Image~=""
        end,
        WallpaperDim=function(v)wallpaperDim=v;if wallpaper then wallpaper.ImageTransparency=v end end,
    }
    engineEnv.SweetAppearance.Reset=function()
        engineEnv.SweetAppearance.Rainbow(false);applyAccent(Color3.fromRGB(220,220,220));Config.WindowScale=.90
        Config.GlassTransparency=.18;shell.BackgroundTransparency=.18
        engineEnv.SweetAppearance.Font("Roboto");if wallpaper then wallpaper:Destroy();wallpaper=nil end;layout()
    end
    function api.LoadFeatures(name)
        if built[name] then return true end
        if failed[name] then return false, failed[name] end
        local source = featureSources[name]
        if not source then return false, "No Monody counterpart" end
        local p = pages[name]
        p.Status.Text = "Loading…"
        for _, alias in ipairs({name.."Page",name=="PVP" and "PvPPage" or name.."Page",name=="Visual" and "VisualsPage" or name.."Page",name=="PlayerList" and "PlayersPage" or name.."Page",name=="Dungeons" and "DungeonPage" or name.."Page"}) do engineEnv[alias] = p end
        local ok, err = pcall(function() compile(source,"tabs/"..name..".lua")() end)
        if ok then built[name] = true; p.Status.Text = "Ready"
        else failed[name] = tostring(err); p.Status.Text = "Load error: "..tostring(err):sub(1,180); warn("Sweet "..name..": "..tostring(err)) end
        layout()
        return ok,err
    end
    local originalNavigate = navigate
    navigate = function(name)
        if featureSources[name] then api.LoadFeatures(name) end
        originalNavigate(name)
        updateVisibility()
    end
    api.Navigate = navigate
    local originalToggle=api.Toggle
    api.Toggle=function(value)originalToggle(value);updateVisibility()end
    api.GetTiki = function() return requireModule("tiki_engine.lua") end
    api.FeatureStatus = {Loaded=built,Errors=failed}
    api.ControlKeys = function(name)
        local keys={}; for key in pairs(controls) do if not name or key:sub(1,#name+1)==name.."." then keys[#keys+1]=key end end
        table.sort(keys);return keys
    end
    function api.UnloadFeatures()
        if shuttingDown then return end
        -- Stop active switches before cancelling engine tasks and restoring owned resources.
        for key,c in pairs(controls) do
            if c.Kind == "toggle" and c.Callback and state[key] then pcall(set,key,false) end
        end
        for _,fn in ipairs(disposers) do pcall(fn) end
        moduleHost.Destroy()
        for path,mod in pairs(loaded) do
            if type(mod)=="table" then
                if path=="tiki_engine.lua" then pcall(function() mod:Destroy() end)
                else
                    for _,method in ipairs({"ResetAll","disable","stopMacro","stopLoop","StopLoop","stop","dismiss","RemoveWidget","RemoveUI","destroy","Destroy"}) do
                        if type(mod[method])=="function" then pcall(mod[method]) end
                    end
                end
            end
        end
        shuttingDown=true
        for _,c in ipairs(featureConnections) do pcall(function() c:Disconnect() end) end
        for thread in pairs(tasks) do pcall(task.cancel,thread) end
        for instance in pairs(ownedInstances) do pcall(function() instance:Destroy() end) end
    end
    local dictionaries=compile([==========[
local dictionaries={
    -- Translation Tables
    ["Spanish"] = {
        -- Kit One Shot & Visuals / Buddha Rainbow
        ["Kit One Shot"] = "Kit One Shot",
        ["Instant 18k+ Fruit M1 Void Remote attack"] = "Ataque remoto vacio 18k+ instantaneo con M1",
        ["Instant 18k+ Fruit M1 Void Remote attack (Activates Fruit Fast Attack)"] = "Ataque remoto vacio 18k+ instantaneo con M1",
        ["M1 Delay"] = "Velocidad M1",
        ["Kit One Shot Floating Widget"] = "Widget Flotante Kit One Shot",
        ["Movable on-screen toggle for Kit One Shot"] = "Boton flotante en pantalla para Kit One Shot",
        ["Saishi Sword One Shot"] = "Saishi Sword One Shot",
        ["Teleport combo with velocity reset (Mobile widget & Z/F keys)"] = "Combo de teletransporte con reinicio de velocidad (Widget movil y teclas Z/F)",
        ["Silent Aim Lock"] = "Bloqueo Silent Aim",
        ["Silent Aim Lock Floating Widget"] = "Widget Flotante Silent Aim Lock",
        ["Movable on-screen toggle for Silent Aim Lock"] = "Boton flotante en pantalla para Silent Aim Lock",
        ["Silent Aim Player Lock"] = "Bloqueo de Jugador (Silent Aim)",
        ["Lock onto targeted player without moving camera"] = "Fijar al jugador apuntado sin mover la camara",
        ["Lock Current Target"] = "Bloquear Objetivo Actual",
        ["Unlock Target"] = "Desbloquear Objetivo",
        ["Fruit Fast Attack Floating Widget"] = "Widget Flotante Fruit Fast Attack",
        ["X-Ray Wall Vision"] = "Vision Rayos X de Paredes",
        ["X-Ray Vision"] = "Vision Rayos X",
        ["Makes map walls and objects transparent to spot players and chests easily"] = "Vuelve transparentes las paredes del mapa para ver jugadores y cofres",
        ["Buddha Rainbow Circle"] = "Circulo Buddha Arcoiris",
        ["Recolors your Buddha circle with animated rainbow gradient (Client-only)"] = "Colorea el circulo de Buddha con gradiente arcoiris animado (Solo tu cliente)",
        ["Only My Buddha Circle"] = "Solo Mi Circulo de Buddha",
        ["Only affects your own character instead of all nearby Buddha users"] = "Solo afecta a tu propio personaje y no a otros usuarios de Buddha",
        ["Delete Ghost Ship (Sea 2)"] = "Borrar Barco Fantasma (Mar 2)",
        ["Delete Ghost Ship"] = "Borrar Barco Fantasma",
        ["Removes interior walls and objects from Cursed Ship in Sea 2"] = "Elimina paredes interiores y objetos del Barco Maldito en Mar 2",
        ["Lock Widgets & Toggles"] = "Bloquear Widgets y Controles",
        ["Lock floating widgets and controls from moving"] = "Bloquea el movimiento de toggles y widgets flotantes",
        ["Active Keybinds"] = "Atajos Activos",
        ["No keybinds configured. Click '+' to add one."] = "No hay atajos configurados. Haz clic en '+' para agregar uno.",
        ["+ Add Keybind"] = "+ Agregar Atajo",
        ["Clear All Keybinds"] = "Eliminar Todos los Atajos",
        ["Select a feature to bind"] = "Selecciona una funcion para enlazar",
        ["Click a feature then press any key:"] = "Haz clic en una funcion y luego presiona la tecla deseada:",
        ["PRESS ANY KEY..."] = "PRESIONA CUALQUIER TECLA...",
        ["No buttons or toggles available to bind."] = "No hay botones o toggles disponibles para enlazar.",
        ["bound to"] = "asignado a",
        ["Mode changed to"] = "Modo cambiado a",
        ["All keybinds were cleared."] = "Todos los atajos fueron eliminados.",
        ["Widget lock:"] = "Bloqueo de widgets:",
        ["Keybinds"] = "Atajos",
        ["General"] = "General",
        ["Enabled"] = "Activado",
        ["Disabled"] = "Desactivado",
        -- Monody New Additions & Performance Features
        ["Waifu AI"] = "Waifu AI",
        ["Waifu AI Companion"] = "Companera Waifu AI",
        ["Activar Waifu"] = "Activar Waifu",
        ["Hablar con Waifu"] = "Hablar con Waifu",
        ["Bailar / Hacer Animación"] = "Bailar / Hacer Animacion",
        ["Dar Ánimos / Frase Kawaii"] = "Dar Animos (Kawaii)",
        ["Alerta de Peligro / Combate"] = "Alerta de Peligro",
        ["Ajustes de Waifu"] = "Ajustes de Waifu",
        ["Reacciones de Combate & Peligro"] = "Reacciones de Combate y Peligro",
        ["Seguir Cursor / Touch"] = "Seguir Cursor y Toque",
        ["Pensamientos Automáticos"] = "Pensamientos Automaticos",
        ["Color Adaptable al Tema"] = "Color Adaptable al Tema",
        ["Tamaño de Waifu"] = "Tamano de Waifu",
        ["FFlags"] = "FFlags",
        ["Reset to Defaults"] = "Restablecer por Defecto",
        ["Configure Discord notification webhook and target trade recipient to transfer fruits automatically."] = "Configura el webhook de Discord y el usuario receptor para transferir frutas automaticamente.",
        ["Fruit Fast Attack"] = "Fruit Fast Attack",
        ["Fast Attack supporting Devil Fruits (By Darling)"] = "Fast Attack con soporte para Frutas (By Darling)",
        ["Apply Ultimate Potato (120 FPS + Max Performance)"] = "Aplicar Ultimate Potato (120 FPS + Rendimiento Max)",
        ["Ultimate Performance (1-Tap Potato)"] = "Rendimiento Maximo (Potato 1-Toque)",
        ["FFlags JSON Editor"] = "Editor JSON de FFlags",
        ["Apply FFlags JSON"] = "Aplicar FFlags JSON",
        ["One-tap master optimization: 120 FPS cap, low geometry, smooth plastic textures, shadow removal, and particle clearing."] = "Optimizacion maestra en 1 toque: tope de 120 FPS, geometria baja, texturas lisas, sin sombras y limpieza de particulas.",
        ["Cokeboys Keyless"] = "Cokeboys Keyless",
        ["Iruka Hub Keyless"] = "Iruka Hub Keyless",
        ["Banana Cat Keyless"] = "Banana Cat Keyless",
        ["Sacred AHK"] = "Sacred AHK",
        ["RJR Auto Bounty"] = "RJR Auto Bounty",
        ["RJR Auto Find Fruits"] = "RJR Auto Buscar Frutas",
        ["RJR Auto Levi"] = "RJR Auto Leviatan",
        ["Delta Executor In-Game"] = "Delta Executor en Juego",
        ["Supremacy"] = "Supremacy",
        ["Nameless Cracked"] = "Nameless Cracked",
        ["MasterTrap"] = "MasterTrap",
        ["Execute"] = "Ejecutar",
        ["Copy Loadstring"] = "Copiar Loadstring",
        ["FFlags Editor Personalizado"] = "Editor de FFlags Personalizado",
        ["Pegar FFlags JSON"] = "Pegar FFlags JSON",
        ["Aplicar FFlags"] = "Aplicar FFlags",
        ["Limpiar Editor"] = "Limpiar Editor",
        ["Auto Aplicar FFlags al Iniciar"] = "Auto-Aplicar FFlags al Iniciar",
        ["Modo Patata (Potato FFlags)"] = "Modo Patata (Potato FFlags)",
        ["Cargar FFlags Potato en Editor"] = "Cargar FFlags Patata",
        ["Performance Presets"] = "Presets de Rendimiento",
        ["Load Pro Preset"] = "Cargar Preset Pro",
        ["Load Android Preset"] = "Cargar Preset Android",
        ["Apply Pro Preset"] = "Aplicar Preset Pro",
        ["Load Potato Preset"] = "Cargar Preset Patata",
        ["FFlags Editor"] = "Editor de FFlags",
        ["Potato Mode"] = "Modo Patata",
        ["Optimizacion FFlags"] = "Optimizacion FFlags",
        ["Activar FFlags"] = "Activar FFlags",
        ["Editor de FFlags Personalizadas"] = "Editor de FFlags Personalizadas",
        ["Pegar FFlags JSON"] = "Pegar FFlags JSON",
        ["Aplicar FFlags"] = "Aplicar FFlags",
        ["Paste Discord Webhook..."] = "Pega el Webhook de Discord...",
        ["Enter Username..."] = "Ingresa el Usuario...",
        ["Activa todas las optimizaciones al maximo: 120 FPS, texturas SmoothPlastic, sin sombras y sin niebla."] = "Activa todas las optimizaciones al maximo: 120 FPS, texturas SmoothPlastic, sin sombras y sin niebla.",
        ["Boost 120 FPS"] = "Mejorar 120 FPS",
        ["FPS Booster"] = "Mejora de FPS",
        ["Auto Apply"] = "Auto-Aplicar",
        ["Auto apply optimizations on game launch"] = "Aplicar optimizaciones al iniciar juego",
        ["Custom FFlags"] = "FFlags Personalizadas",
        ["JSON Code"] = "Codigo JSON",
        ["Apply JSON"] = "Aplicar JSON",
        ["Custom Sky"] = "Cielo Personalizado",
        ["Sky Preset"] = "Preset de Cielo",
        ["Replaces the sky with custom skybox"] = "Reemplaza el cielo por un cielo personalizado",
        ["Macro"] = "Macro",
        ["Smart autonomous combo macro engine"] = "Motor de macro de combo autonomo",
        ["Fast Attack supporting Devil Fruits"] = "Fast Attack con soporte para Frutas del Diablo",
        ["Boost FPS"] = "Mejorar FPS",
        ["Combo Sequence"] = "Secuencia de Combo",
        ["Toggle Macro"] = "Activar Macro",
        ["Stop Macro"] = "Detener Macro",
        ["Hitbox Expander"] = "Expansor de Hitbox",
        ["Hitbox Size"] = "Tamano de Hitbox",
        ["Hitbox Visual Forcefield"] = "Efecto Visual Neon de Hitbox",
        ["Static Camera"] = "Camara Estatica (Sin Movimiento)",
        ["Mute Game Background Music"] = "Silenciar Musica del Juego",
        ["B1 Backup Skill"] = "B1 Habilidad Secundaria",
        ["B2 Backup Skill"] = "B2 Habilidad Secundaria",
        ["B3 Backup Skill"] = "B3 Habilidad Secundaria",
        ["B4 Backup Skill"] = "B4 Habilidad Secundaria",
        ["B5 Backup Skill"] = "B5 Habilidad Secundaria",
        ["B6 Backup Skill"] = "B6 Habilidad Secundaria",
        ["Tap"] = "Toque Rapido",
        ["Hold"] = "Mantener Cargado",
        ["Transform"] = "Transformacion",
        ["Midnight"] = "Medianoche",
        ["Black"] = "Negro",
        ["White"] = "Blanco",
        ["Gold"] = "Dorado",
        ["Red"] = "Rojo",
        ["Green"] = "Verde",
        ["Blue"] = "Azul",
        ["Cyan"] = "Cian",
        ["Purple"] = "Morado",
        ["Pink"] = "Rosa",
        ["Magenta"] = "Magenta",
        ["Orange"] = "Naranja",
        ["God Mode"] = "Modo Dios",
        ["God Mode Engine"] = "Motor de Modo Dios",
        ["Boat Desync (Anti-Player)"] = "Desync de Barco (Anti-Jugadores)",
        ["Physics Desync (Global)"] = "Desync de Fisicas (Global)",
        ["Safe Zone Desync"] = "Desync de Zona Segura",
        ["Anti-Stun & Combo Breaker"] = "Anti-Stun y Rompe Combos",
        ["Desync Offset"] = "Distancia de Desync",
        ["Prioritize Own Boat"] = "Priorizar Mi Barco",
        ["Disable All God Modes"] = "Desactivar Todos los Modos Dios",
        ["Desynchronizes character position via boat relative CFrame so other players miss"] = "Desincroniza la posicion del personaje via barco para que los ataques de otros jugadores fallen",
        ["Desynchronizes physics simulation from local rendering"] = "Desincroniza la simulacion de fisicas del renderizado local",
        ["Projects coordinates into safe zone sphere to gain safe zone status"] = "Proyecta coordenadas a la zona segura para obtener proteccion de zona segura",
        ["Instantly cancels stun flags, unlocks walkspeed and prevents ragdoll locks"] = "Cancela instantaneamente stuns, desbloquea velocidad y evita bloqueos",

        ["Sky Changer & Environment"] = "Cambiador de Cielo y Entorno",
        ["Sky Changer"] = "Cambiador de Cielo",
        ["Enable Custom Sky"] = "Activar Cielo Personalizado",
        ["Replaces the sky with high resolution custom skybox (Sets time to 14:00 Day)"] = "Reemplaza el cielo por skybox HD (Fija hora a las 14:00 Dia)",
        ["Skybox Preset"] = "Preset de Cielo",
        ["Hide Dragon"] = "Ocultar Dragon",
        ["Hides or displays dragon model and visual aura"] = "Oculta o muestra el modelo del dragon y su aura",
        ["Hide Throne"] = "Ocultar Trono",
        ["Hides or displays the king's throne model"] = "Oculta o muestra el modelo del trono del rey",
        ["The Hollow Lantern"] = "La Linterna Hueca",
        ["Transcendence Dragon"] = "Dragon de Trascendencia",
        ["Script Hub"] = "Script Hub",
        ["Ready for scripts. Provide your loadstrings to populate this hub!"] = "Listo para scripts. ¡Pasa tus loadstrings para agregarlos a este hub!",
        ["Play Montagem Phonk"] = "Reproducir Montagem Phonk",
        ["Montagem Phonk"] = "Montagem Phonk",

        ["Player Management"] = "Gestion de Jugadores",
        ["Search Player..."] = "Buscar Jugador...",
        ["Refresh Player List"] = "Actualizar Lista",
        ["Blacklist"] = "Lista Negra",
        ["Blacklisted"] = "En Lista Negra",
        ["Spectate"] = "Espectear",
        ["Spectating"] = "Espectando",
        ["Stop Spectating"] = "Dejar de Espectear",
        ["Teleport to Player"] = "Teletransportarse al Jugador",
        ["Total Players"] = "Total de Jugadores",
        ["Auto Dungeon Engine"] = "Motor Auto Dungeon",
        ["Start Auto Dungeon"] = "Iniciar Auto Dungeon",
        ["Auto Buso"] = "Auto Buso",
        ["Selected Weapon"] = "Arma Seleccionada",
        ["Sword"] = "Espada",
        ["Melee"] = "Cuerpo a Cuerpo",
        ["Blox Fruit"] = "Fruta Blox",
        ["Attack Height"] = "Altura de Ataque",
        ["Auto Pass Room"] = "Auto Pasar Sala",
        ["Void M1 Engine"] = "Motor Void M1",
        ["Enable Void M1"] = "Activar Void M1",
        ["Void Only Boss Rooms"] = "Void Solo Salas de Jefe",
        ["Void Interval (s)"] = "Intervalo de Void (s)",
        ["Dungeon Status & Utilities"] = "Estado y Utilidades de Dungeon",
        ["Auto Load Dungeon"] = "Cargar Dungeon Automaticamente",
        ["Current Room"] = "Sala Actual",
        ["Boss Status"] = "Estado del Jefe",
        ["Island Teleport"] = "Teletransporte de Islas",
        ["Select Sea"] = "Seleccionar Mar",
        ["Sea 1"] = "Mar 1",
        ["Sea 2"] = "Mar 2",
        ["Sea 3"] = "Mar 3",
        ["Target Island"] = "Isla de Destino",
        ["Tween Speed"] = "Velocidad de Tween",
        ["Travel Altitude"] = "Altitud de Viaje",
        ["Noclip during Tween"] = "Noclip durante Tween",
        ["Start Teleport"] = "Iniciar Teletransporte",
        ["Stop Teleport"] = "Detener Teletransporte",
        ["Controls Layout Editor"] = "Editor de Controles",
        ["Unlock Drag (Edit HUD)"] = "Desbloquear Arrastre (Editar HUD)",
        ["Controls Global Scale"] = "Escala Global de Controles",
        ["Save Custom Layout"] = "Guardar Disposicion",
        ["Reset Default Layout"] = "Restablecer Disposicion",
        ["HUD Overlays"] = "Superposiciones de HUD",
        ["Performance Watermark"] = "Marca de Rendimiento",
        ["Custom Crosshair"] = "Punto de Mira Personalizado",
        ["Weapon Skins"] = "Skins de Armas",
        ["Select Weapon Skin"] = "Seleccionar Skin de Arma",
        ["Apply Weapon Skin"] = "Aplicar Skin de Arma",
        ["Reset Weapon Skin"] = "Restablecer Skin de Arma",
        ["Haki & Aura Customization"] = "Personalizacion de Haki y Aura",
        ["Haki Color"] = "Color de Haki",
        ["Rainbow Haki"] = "Haki Arcoiris",
        ["Custom Trail VFX"] = "Efectos Visuales de Estela",
        ["Music Player"] = "Reproductor de Musica",
        ["Genre / Category"] = "Genero / Categoria",
        ["Track Preset"] = "Pista Preestablecida",
        ["Custom Sound ID"] = "Sound ID Personalizado",
        ["Volume"] = "Volumen",
        ["Pitch / Speed"] = "Tono / Velocidad",
        ["Loop Track"] = "Repetir Pista",
        ["Show Top Music Bar"] = "Mostrar Barra de Musica Superior",
        ["Play"] = "Reproducir",
        ["Pause"] = "Pausar",
        ["Resume"] = "Reanudar",
        ["Stop"] = "Detener",
        ["Cinematic Animations"] = "Animaciones Cinematicas",
        ["Select Animation"] = "Seleccionar Animacion",
        ["Hide Accessories & Weapons"] = "Ocultar Accesorios y Armas",
        ["Play Animation"] = "Reproducir Animacion",
        ["Stop Animation"] = "Detener Animacion",
        ["Pure White"] = "Blanco Puro",
        ["Crimson Red"] = "Rojo Carmesi",
        ["Midnight Purple"] = "Purpura Medianoche",
        ["Electric Blue"] = "Azul Electrico",
        ["Emerald Green"] = "Verde Esmeralda",
        ["Golden Sun"] = "Sol Dorado",
        ["Default"] = "Por Defecto",
        ["None"] = "Ninguno",
        ["180"] = "180",
        ["2D Boxes"] = "Cajas 2D",
        ["2D Line"] = "Linea 2D",
        ["360"] = "360",
        ["3D Beam"] = "Rayo 3D",
        ["Accent Color & Theme Studio"] = "Estudio de Temas y Colores",
        ["Account & Player Statistics"] = "Estadisticas del Jugador",
        ["Aesthetic Studio Presets"] = "Ajustes Preestablecidos",
        ["Aim Mode"] = "Modo de Punteria",
        ["Aimbot"] = "Aimbot",
        ["Allows continuous mid-air jumping without cooldown"] = "Permite saltar en el aire continuamente sin recarga",
        ["Anti-Lava Damage"] = "Anti-Danio de Lava",
        ["Anti-Lava Immunity"] = "Inmunidad a la Lava",
        ["Apply Fast FFlags"] = "Aplicar Optimizacion FFlags",
        ["Apply Wallpaper"] = "Aplicar Fondo",
        ["Atmosphere Wallpaper"] = "Fondo de Pantalla Atmosferico",
        ["Atmosphere Wallpaper Presets (24 Styles)"] = "Fondos Atmosfericos (24 Estilos)",
        ["Auto Buso Haki"] = "Auto Haki de Armadura",
        ["Auto Combat"] = "Combate Automatico",
        ["Auto Race V3"] = "Auto Race V3",
        ["Auto Race V4"] = "Auto Race V4",
        ["Auto Skill Combo"] = "Auto Combo de Habilidades",
        ["Auto Skill on Soru"] = "Habilidad Automatica con Soru",
        ["Automatically activates Buso Armament Haki (No Ken)"] = "Activa automaticamente Buso Haki de armamento (sin Ken)",
        ["Automatically casts Race V3 ability in combat"] = "Lanza automaticamente la habilidad de Raza V3 en combate",
        ["Automatically triggers Race Awakening V4 when gauge is filled"] = "Activa despertar de Raza V4 cuando se llena la barra",
        ["B"] = "B",
        ["BELI"] = "BELI",
        ["BOUNTY"] = "RECOMPENSA",
        ["Background Dimming (%)"] = "Oscurecimiento de Fondo (%)",
        ["Balanced (65%)"] = "Equilibrado (65%)",
        ["Blue"] = "Azul",
        ["Both"] = "Ambos",
        ["Bottom"] = "Abajo",
        ["Bypasses walkspeed reset with direct physical impulse"] = "Evita el reinicio de velocidad con impulso fisico directo",
        ["C"] = "C",
        ["Calculates lead vector based on enemy velocity and ping"] = "Calcula anticipacion segun velocidad y ping",
        ["Camera FOV"] = "FOV de Camara",
        ["Camlock"] = "Camlock",
        ["Camlock (Combat Camera)"] = "Camlock (Camara de Combate)",
        ["Camlock Floating Widget"] = "Widget Flotante Camlock",
        ["Camlock Keybind"] = "Tecla de Camlock",
        ["Caps client to 22 FPS during Sanguine Z cooldown for physics boost"] = "Limita cliente a 22 FPS en cooldown de Sanguine Z para impulso",
        ["Cast Race V3 when in combat"] = "Activa Race V3 durante el combate",
        ["Cast Race V4 when gauge is full"] = "Activa Race V4 al llenarse la barra",
        ["Center"] = "Centro",
        ["Chams & Tracers"] = "Chams y Lineas",
        ["Chams Highlight Color"] = "Color de Chams",
        ["Clear / Dark Glass"] = "Limpiar / Cristal Oscuro",
        ["Combat Passives & Auto Skills"] = "Pasivas de Combate y Auto Habilidades",
        ["Combat PvP Status"] = "Estado de Combate PvP",
        ["Combat Targeting & Silent Aim"] = "Punteria de Combate y Silent Aim",
        ["Combat Tech"] = "Tecnicas de Combate",
        ["Combo Key"] = "Tecla de Combo",
        ["Combo Weapon"] = "Arma de Combo",
        ["Community"] = "Comunidad",
        ["Compact (80%)"] = "Compacto (80%)",
        ["Config"] = "Configuracion",
        ["Configuration Profiles"] = "Perfiles de Configuracion",
        ["Configuration Reset"] = "Reinicio de Configuracion",
        ["Copy Discord Invite Link"] = "Copiar Enlace de Discord",
        ["Copy Server JobId"] = "Copiar JobId del Servidor",
        ["Credits"] = "Creditos",
        ["Crystal (80%)"] = "Cristal (80%)",
        ["Custom Dash Length"] = "Distancia de Deslizamiento",
        ["Custom WalkSpeed"] = "Velocidad Personalizada",
        ["Custom Wallpaper"] = "Fondo Personalizado",
        ["Custom Wallpaper Studio"] = "Estudio de Fondos Personalizados",
        ["Cyan"] = "Cian",
        ["Dash Distance"] = "Distancia de Impulso",
        ["Destroys environmental lava kill zones and damage parts"] = "Destruye zonas de dano y lava del entorno",
        ["Detects safe zone and in-combat status indicators"] = "Detecta zona segura y estado de combate",
        ["Developer & Content Creator"] = "Desarrollador y Creador",
        ["Development Team & Content Creators"] = "Equipo de Desarrollo y Creadores",
        ["Devil Fruit Tracker"] = "Rastreador de Frutas",
        ["Direct Wallpaper"] = "Fondo Directo",
        ["Disable All Visuals"] = "Desactivar Todos los Visuales",
        ["Display aim boundary circle"] = "Muestra el circulo limite de punteria",
        ["Displays formatted usernames above character heads"] = "Muestra el nombre sobre la cabeza del jugador",
        ["Displays live gradient health bars and HP percentage"] = "Muestra barras de salud y porcentaje de vida",
        ["Displays movable on-screen JUMP button for touch"] = "Muestra un boton tactil movil de SALTO en pantalla",
        ["Displays movable on-screen action button for Sanguine Z"] = "Muestra boton flotante de accion para Sanguine Z",
        ["Displays movable on-screen button to toggle camera lock"] = "Muestra un boton movil en pantalla para alternar bloqueo de camara",
        ["Displays movable on-screen toggle for Dragon Gun M1"] = "Muestra un control movil en pantalla para Dragon Gun M1",
        ["Displays movable on-screen toggle for camera lock"] = "Muestra boton flotante para fijar camara",
        ["Displays player bounty or honor value in millions"] = "Muestra recompensa o valor de honor en millones",
        ["Displays targeting circle boundary on screen"] = "Muestra el limite del circulo de punteria en pantalla",
        ["Distance Indicator"] = "Indicador de Distancia",
        ["Dragon Gun M1"] = "Dragon Gun M1",
        ["Dragon Gun M1 Floating Widget"] = "Widget Flotante Dragon Gun M1",
        ["Draws dynamic bounding boxes around enemy players"] = "Dibuja recuadros dinamicos en enemigos",
        ["Draws line from bottom of screen to tracked players"] = "Dibuja linea desde abajo hacia jugadores",
        ["E"] = "E",
        ["ESP Style"] = "Estilo de ESP",
        ["ESP Text Font Size"] = "Tamano de Fuente ESP",
        ["ESP Visuals"] = "Visuales ESP",
        ["Enable All Visuals"] = "Activar Todos los Visuales",
        ["Enable Target Prediction"] = "Activar Prediccion de Blanco",
        ["Enable player visual highlights"] = "Activa el resaltado de jugadores",
        ["Enables custom movement speed multiplier"] = "Habilita multiplicador de velocidad personalizada",
        ["Enables high-performance player visual tracking"] = "Habilita rastreo visual de jugadores de alto rendimiento",
        ["English"] = "Ingles",
        ["Equipped Tool / Weapon"] = "Arma Equipada",
        ["Equips weapon and casts chosen skill upon Soru animation"] = "Equipa arma y lanza habilidad al hacer Soru",
        ["Esp"] = "Visuales",
        ["Executes rapid melee, sword, and fruit attack bursts"] = "Ejecuta rafagas veloces para melee, espadas y frutas",
        ["Executes rapid primary attacks on all nearby enemies"] = "Ejecuta ataques principales rapidos contra todos los enemigos cercanos",
        ["F"] = "F",
        ["FACTION"] = "FACCION",
        ["FOV"] = "FOV",
        ["FOV Color"] = "Color del FOV",
        ["FOV Position"] = "Posicion del FOV",
        ["FOV Radius"] = "Radio de FOV",
        ["FOV Thickness"] = "Grosor de FOV",
        ["FPS"] = "FPS",
        ["FRUIT"] = "FRUTA",
        ["Fast Attack"] = "Ataque Rapido",
        ["Fast Attack (Melee, Sword, Fruit)"] = "Ataque Rapido (Melee, Espada, Fruta)",
        ["Fast Flags"] = "Optimizacion Rapida",
        ["FFlags 1 (FPS Booster)"] = "FFlags 1 (Mejora de FPS)",
        ["120 FPS cap, smooth plastic textures, removes atmosphere fog, hides debris"] = "Limite de 120 FPS, texturas plasticas, elimina niebla y oculta escombros",
        ["No Animations"] = "Sin Animaciones",
        ["Stops non-attack animations to fix sideways bug and character freezes"] = "Detiene animaciones ajenas al ataque para corregir congelamientos",
        ["Fast Flags & Engine Tuning"] = "Fast Flags y Ajustes de Motor",
        ["Field of View"] = "Campo de Vision",
        ["Field of View (FOV Customization)"] = "Campo de Vision (FOV)",
        ["Forward velocity boost"] = "Impulso de velocidad hacia adelante",
        ["French"] = "Frances",
        ["Fruit"] = "Fruta",
        ["Game Stats"] = "Estadisticas de Juego",
        ["Glass Interface & Visual Effects"] = "Interfaz de Cristal y Efectos",
        ["Glass Transparency"] = "Transparencia de Cristal",
        ["Green"] = "Verde",
        ["Gun"] = "Arma",
        ["Gun Aura (Dragon Gun M1)"] = "Gun Aura (Dragon Gun M1)",
        ["Head"] = "Cabeza",
        ["High jump leap"] = "Salto de gran altura",
        ["High-distance forward velocity boost with keybind Z"] = "Impulso de velocidad frontal de larga distancia con tecla Z",
        ["Home"] = "Inicio",
        ["HumanoidRootPart"] = "HumanoidRootPart",
        ["Identifies equipped Devil Fruit power (Kitsune, Portal, etc.)"] = "Identifica la fruta equipada (Kitsune, Portal, etc.)",
        ["Illuminates full player character models through walls"] = "Ilumina modelos de jugadores a traves de paredes",
        ["Immunity to lava damage"] = "Inmunidad al danio de lava",
        ["In-Game Attributes"] = "Atributos del Juego",
        ["Increase dash distance"] = "Aumenta la distancia del deslizamiento",
        ["Infinite Jump"] = "Salto Infinito",
        ["Infinite Soru"] = "Soru Infinito",
        ["Interface Effects"] = "Efectos Visuales",
        ["Interface Language"] = "Idioma de Interfaz",
        ["Interface Scale"] = "Escala de Interfaz",
        ["Jump continuously in mid-air"] = "Salta continuamente en el aire",
        ["Keep Armament Haki active"] = "Mantiene el Haki de Armadura activo",
        ["LEVEL"] = "NIVEL",
        ["Language"] = "Idioma",
        ["Language & Localization"] = "Idioma y Localizacion",
        ["Large (120%)"] = "Grande (120%)",
        ["Load Configuration Profile"] = "Cargar Perfil de Configuracion",
        ["Load Config"] = "Cargar Configuracion",
        ["Lock camera onto enemy"] = "Fija la camara al enemigo",
        ["Locks camera perspective directly onto focused enemy player"] = "Fija la camara directamente sobre el jugador enemigo enfocado",
        ["Looking At Me"] = "Mirandome",
        ["Low HP"] = "Menor Vida",
        ["Master ESP"] = "ESP Principal",
        ["Master ESP Toggle"] = "Interruptor Maestro de ESP",
        ["Master Visuals & Chams"] = "Visuales Maestros y Chams",
        ["Max Range"] = "Rango Maximo",
        ["Max Soru Range"] = "Rango Maximo de Soru",
        ["Melee"] = "Cuerpo a Cuerpo",
        ["Misc"] = "Varios",
        ["Mouse"] = "Raton",
        ["Move smoothly through structures and physical obstacles"] = "Permite moverse a traves de estructuras y obstaculos",
        ["Movement"] = "Movimiento",
        ["Movement & Agility (PvP Physics)"] = "Movimiento y Agilidad (Fisicas PvP)",
        ["Multiplies dash distance for high-speed repositioning"] = "Multiplica distancia de dash para reposicionamiento rapido",
        ["Multiplies jump impulse for vertical escape and aerial combat"] = "Multiplica impulso de salto para escape vertical y combate",
        ["NPC Silent Aim"] = "Silent Aim en NPCs",
        ["Nearest"] = "Mas Cercano",
        ["Nearest Player"] = "Jugador Mas Cercano",
        ["Neon Rain Layer"] = "Lluvia Cyber Neon",
        ["Next (›)"] = "Siguiente (›)",
        ["Noclip Wallpass"] = "Noclip Traspasar Paredes",
        ["None"] = "Ninguno",
        ["Official Community & Discord"] = "Comunidad Oficial y Discord",
        ["Orange"] = "Naranja",
        ["Overhead Billboard"] = "Rotulo Superior",
        ["PING"] = "LATENCIA",
        ["PLAYERS"] = "JUGADORES",
        ["Pass through walls and objects"] = "Atraviesa paredes y objetos",
        ["Performance"] = "Rendimiento",
        ["Performance & Network"] = "Rendimiento y Red",
        ["Pink"] = "Rosa",
        ["Player"] = "Jugador",
        ["Player 2D Boxes"] = "Cajas 2D de Jugadores",
        ["Player Bounty Tracker"] = "Bounty del Jugador",
        ["Player Chams & Tracers"] = "Chams y Rastreadores",
        ["Player Chams (Highlight)"] = "Chams de Jugador (Highlight)",
        ["Player Health Status"] = "Salud del Jugador",
        ["Player Level Display"] = "Nivel del Jugador",
        ["Player Names"] = "Nombres de Jugadores",
        ["Player Profile"] = "Perfil del Jugador",
        ["Player Profile & Account"] = "Perfil del Jugador y Cuenta",
        ["Player Radar Elements"] = "Elementos de Radar de Jugador",
        ["Player Silent Aim"] = "Silent Aim en Jugadores",
        ["Player Tracer Color"] = "Color de Linea de Jugador",
        ["Player Tracers"] = "Lineas a Jugadores",
        ["Portuguese"] = "Portugues",
        ["Prediction Amount"] = "Cantidad de Prediccion",
        ["Premium User  •  Active Session"] = "Usuario Premium  •  Sesion Activa",
        ["Preset: Crimson Slayer"] = "Estilo: Asesino Carmesi",
        ["Preset: Cyberpunk Violet"] = "Estilo: Violeta Cyberpunk",
        ["Preset: Emerald Forest"] = "Estilo: Bosque Esmeralda",
        ["Preset: Shorekeeper Cyan"] = "Estilo: Shorekeeper Cian",
        ["Previous (‹)"] = "Anterior (‹)",
        ["Purple"] = "Morado",
        ["PvP"] = "PvP",
        ["PvP Tech, Camlock & Universal Keybinds"] = "Tecnologia PvP, Camlock y Teclas",
        ["Q"] = "Q",
        ["Quick Actions"] = "Acciones Rapidas",
        ["R"] = "R",
        ["RACE"] = "RAZA",
        ["Radar Elements"] = "Elementos de Radar",
        ["Rainbow"] = "Arcoiris",
        ["Rainbow Chroma Speed"] = "Velocidad de Chroma Arcoiris",
        ["Raindrop Density"] = "Densidad de Gotas",
        ["Random (Shuffle)"] = "Aleatorio",
        ["Rapid fire M1 gun shots"] = "Disparos M1 ultra rapidos",
        ["Rapid melee and weapon strikes"] = "Golpes rapidos cuerpo a cuerpo",
        ["Rapid weapon hit bursts"] = "Golpes continuos de arma",
        ["Rapid-fire gun attack loop targeting nearest combatant"] = "Ataque rapido con arma de fuego al objetivo mas cercano",
        ["Red"] = "Rojo",
        ["Redirect skills toward enemy players"] = "Redirige habilidades a jugadores enemigos",
        ["Redirect skills toward mobs and bosses"] = "Redirige habilidades a monstruos y jefes",
        ["Redirects Flashstep teleport directly to enemy player"] = "Redirige el teletransporte directamente al jugador enemigo",
        ["Redirects skills and attacks towards enemy players"] = "Redirige habilidades y ataques hacia jugadores enemigos",
        ["Redirects skills and attacks towards mobs and bosses"] = "Redirige habilidades y ataques hacia monstruos y jefes",
        ["Rejoin Current Server"] = "Reconectar al Servidor",
        ["Remove flashstep cooldown"] = "Elimina el enfriamiento del flashstep",
        ["Removes cooldown delay and bypasses stamina limits"] = "Elimina tiempo de recarga y limites de energia",
        ["Renders hardware 3D Beams and 2D lines to target"] = "Dibuja rayos 3D y lineas 2D al objetivo",
        ["Reset All Settings to Factory Defaults"] = "Restablecer Todo de Fabrica",
        ["Reset Configuration Profile"] = "Restablecer Perfil de Configuracion",
        ["Reset Config"] = "Restablecer Configuracion",
        ["Configuration profile reset to defaults."] = "Perfil de configuracion restablecido a valores por defecto.",
        ["Reset Theme to Purple"] = "Restablecer Tema a Purpura",
        ["Sanguine Boost"] = "Sanguine Boost",
        ["Sanguine Boost Floating Widget"] = "Widget Flotante Sanguine Z",
        ["Sanguine Keybind"] = "Tecla de Sanguine",
        ["Save Configuration Profile"] = "Guardar Perfil de Configuracion",
        ["Save Config"] = "Guardar Configuracion",
        ["Selected Player"] = "Jugador Seleccionado",
        ["Server Hop (Fast)"] = "Cambio de Servidor (Rapido)",
        ["Show FOV Circle"] = "Mostrar Circulo FOV",
        ["Show Tracers"] = "Mostrar Lineas de Rastreo",
        ["Shows distance measurement in studs below player feet"] = "Muestra la distancia en studs bajo los pies",
        ["Shows player rank and numerical level tag"] = "Muestra rango y nivel numerico del jugador",
        ["Shows weapon, sword, fruit or gun held by the player"] = "Muestra arma, espada, fruta o pistola equipada",
        ["Silent Aim"] = "Silent Aim",
        ["Skill Blacklist"] = "Lista Negra de Habilidades",
        ["Skill Delay"] = "Retardo de Habilidad",
        ["Skill Redirection Blacklist"] = "Lista Negra de Habilidades",
        ["Soru"] = "Soru",
        ["Soru Aimbot"] = "Soru Aimbot",
        ["Soru Combat Aimbot"] = "Aimbot Soru",
        ["Soru Flashstep Engine"] = "Motor Soru Flashstep",
        ["Soru Skill Combo"] = "Combo de Habilidades Soru",
        ["Soru Skill Combo Automation"] = "Auto Combo de Habilidades Soru",
        ["Soru Target Mode"] = "Modo de Objetivo Soru",
        ["Spanish"] = "Espanol",
        ["Spawns water surface collider allowing sprint across oceans"] = "Crea plataforma acuatica para correr sobre oceanos",
        ["Speed up player movement"] = "Aumenta la velocidad del jugador",
        ["Standard (100%)"] = "Estandar (100%)",
        ["Subtle (50%)"] = "Sutil (50%)",
        ["Super Jump"] = "Super Salto",
        ["Super Jump Floating Widget"] = "Widget Flotante de Super Salto",
        ["Super Jump Force"] = "Fuerza de Super Salto",
        ["Sword"] = "Espada",
        ["System Info"] = "Informacion del Sistema",
        ["T"] = "T",
        ["Target Hitbox"] = "Zona de Impacto",
        ["Target Player Selection"] = "Seleccion de Jugador Objetivo",
        ["Target Priority"] = "Prioridad de Blanco",
        ["Target Selection & Aim Mode"] = "Seleccion de Objetivo y Modo",
        ["Target Tracers"] = "Rastreadores de Objetivo",
        ["Teleport soru directly to enemy"] = "Teletransporta con soru hacia el enemigo",
        ["Theme Presets"] = "Estilos de Tema",
        ["Theme Reset"] = "Restablecer Tema",
        ["Themes"] = "Temas",
        ["Toggle Rainbow Chroma Mode"] = "Activar Modo Chroma Arcoiris",
        ["Toggle animated falling cyber rain streaks"] = "Activa lluvia animada cyber neon",
        ["Tracer Color"] = "Color de Linea",
        ["Tracer Mode"] = "Modo de Linea",
        ["Tracer Origin"] = "Origen de Linea",
        ["Tracer Thickness"] = "Grosor de Linea",
        ["Tracers"] = "Lineas de Rastreo",
        ["Trigger Super Jump"] = "Activar Super Salto",
        ["Typography Font"] = "Fuente Tipografica",
        ["Typography Studio"] = "Estudio de Tipografia",
        ["UPTIME"] = "TIEMPO ACTIVO",
        ["Ultra fast burst firing with CombatController validator"] = "Disparos en rafaga ultra veloces con validador CombatController",
        ["UpperTorso"] = "Torso Superior",
        ["Use skill instantly after Soru"] = "Lanza habilidad al usar Soru",
        ["V"] = "V",
        ["Vietnamese"] = "Vietnamita",
        ["Visuals"] = "Visuales",
        ["Vitality & Energy Status"] = "Estado de Salud y Energia",
        ["Walk on Water"] = "Caminar sobre el Agua",
        ["Walk on ocean surface"] = "Caminar sobre el mar",
        ["WalkSpeed Value"] = "Valor de Velocidad",
        ["Wallpaper"] = "Fondo de Pantalla",
        ["Wallpapers"] = "Fondos de Pantalla",
        ["White"] = "Blanco",
        ["World & Client Optimization"] = "Optimizacion de Mundo y Cliente",
        ["X"] = "X",
        ["Yellow"] = "Amarillo",
        ["Z"] = "Z",
        ["Z Sanguine Boost"] = "Impulso Sanguine Z",
        ["B1 Hold Time (s)"] = "B1 Tiempo de Retencion (s)",
        ["B1 Mode"] = "B1 Modo",
        ["B1 Post Jumps"] = "B1 Saltos Posteriores",
        ["B1 Skill Key"] = "B1 Tecla",
        ["B1 Weapon"] = "B1 Arma",
        ["B2 Hold Time (s)"] = "B2 Tiempo de Retencion (s)",
        ["B2 Mode"] = "B2 Modo",
        ["B2 Post Jumps"] = "B2 Saltos Posteriores",
        ["B2 Skill Key"] = "B2 Tecla",
        ["B2 Weapon"] = "B2 Arma",
        ["B3 Hold Time (s)"] = "B3 Tiempo de Retencion (s)",
        ["B3 Mode"] = "B3 Modo",
        ["B3 Post Jumps"] = "B3 Saltos Posteriores",
        ["B3 Skill Key"] = "B3 Tecla",
        ["B3 Weapon"] = "B3 Arma",
        ["B4 Hold Time (s)"] = "B4 Tiempo de Retencion (s)",
        ["B4 Mode"] = "B4 Modo",
        ["B4 Post Jumps"] = "B4 Saltos Posteriores",
        ["B4 Skill Key"] = "B4 Tecla",
        ["B4 Weapon"] = "B4 Arma",
        ["B5 Hold Time (s)"] = "B5 Tiempo de Retencion (s)",
        ["B5 Mode"] = "B5 Modo",
        ["B5 Post Jumps"] = "B5 Saltos Posteriores",
        ["B5 Skill Key"] = "B5 Tecla",
        ["B5 Weapon"] = "B5 Arma",
        ["B6 Hold Time (s)"] = "B6 Tiempo de Retencion (s)",
        ["B6 Mode"] = "B6 Modo",
        ["B6 Post Jumps"] = "B6 Saltos Posteriores",
        ["B6 Skill Key"] = "B6 Tecla",
        ["B6 Weapon"] = "B6 Arma",
        ["Block 1 Enabled"] = "Bloque 1 Activado",
        ["Block 2 Enabled"] = "Bloque 2 Activado",
        ["Block 3 Enabled"] = "Bloque 3 Activado",
        ["Block 4 Enabled"] = "Bloque 4 Activado",
        ["Block 5 Enabled"] = "Bloque 5 Activado",
        ["Block 6 Enabled"] = "Bloque 6 Activado",
        ["Combo Sequence (6 Blocks)"] = "Secuencia de Combo (6 Bloques)",
        ["Display real-time FPS and ping overlay top-left"] = "Muestra overlay de FPS y ping en tiempo real",
        ["Displays on-screen one-touch button to trigger combo"] = "Muestra boton en pantalla para activar combo",
        ["Do not target allied players"] = "No apuntar a jugadores aliados",
        ["Do not target players inside safe zones"] = "No apuntar a jugadores dentro de zonas seguras",
        ["Do not target players with PvP disabled"] = "No apuntar a jugadores con PvP desactivado",
        ["Enable step 1 in combo"] = "Activa el paso 1 en el combo",
        ["Enable step 2 in combo"] = "Activa el paso 2 en el combo",
        ["Enable step 3 in combo"] = "Activa el paso 3 en el combo",
        ["Enable step 4 in combo"] = "Activa el paso 4 en el combo",
        ["Enable step 5 in combo"] = "Activa el paso 5 en el combo",
        ["Enable step 6 in combo"] = "Activa el paso 6 en el combo",
        ["Enables keyboard trigger and loop execution"] = "Habilita activacion por teclado y bucle",
        ["Fly"] = "Volar",
        ["Fly Speed"] = "Velocidad de Vuelo",
        ["Glide freely through the air"] = "Planea libremente por el aire",
        ["Ignore Allies"] = "Ignorar Aliados",
        ["Ignore PvP Off"] = "Ignorar PvP Desactivado",
        ["Ignore Safe Zone"] = "Ignorar Zona Segura",
        ["Loop Sequence"] = "Secuencia en Bucle",
        ["Macro"] = "Macro",
        ["Macro Controller"] = "Controlador de Macro",
        ["Macro Enabled"] = "Macro Activado",
        ["Macro Floating Widget"] = "Widget Flotante de Macro",
        ["Macro Slot"] = "Ranura de Macro",
        ["Repeat sequence continuously until stopped"] = "Repite la secuencia continuamente hasta detenerla",
        ["Show FPS & Ping"] = "Mostrar FPS y Ping",
        ["Start Combo Sequence"] = "Iniciar Secuencia de Combo",
        ["Stop Combo Sequence"] = "Detener Secuencia de Combo",
        ["Trigger Key (PC)"] = "Tecla de Activacion (PC)",
        ["YouTube & External Players"] = "Reproductores Externos y YouTube",
        ["Launch Universal YouTube Player"] = "Lanzar Reproductor Universal de YouTube",
        ["Launch Audio Library Player"] = "Lanzar Biblioteca de Audio",
        ["Roblox Audio Player"] = "Reproductor de Audio Roblox",
    },
    ["Portuguese"] = {
        -- Kit One Shot & Visuals / Buddha Rainbow
        ["Kit One Shot"] = "Kit One Shot",
        ["Instant 18k+ Fruit M1 Void Remote attack"] = "Ataque remoto de vácuo 18k+ instantâneo com M1",
        ["Instant 18k+ Fruit M1 Void Remote attack (Activates Fruit Fast Attack)"] = "Ataque remoto de vácuo 18k+ instantâneo com M1",
        ["M1 Delay"] = "Velocidade M1",
        ["Kit One Shot Floating Widget"] = "Widget Flutuante Kit One Shot",
        ["Movable on-screen toggle for Kit One Shot"] = "Botão flutuante na tela para Kit One Shot",
        ["Saishi Sword One Shot"] = "Saishi Sword One Shot",
        ["Teleport combo with velocity reset (Mobile widget & Z/F keys)"] = "Combo de teletransporte com reset de velocidade (Widget movel e teclas Z/F)",
        ["Silent Aim Lock"] = "Bloqueio Silent Aim",
        ["Silent Aim Lock Floating Widget"] = "Widget Flutuante Silent Aim Lock",
        ["Movable on-screen toggle for Silent Aim Lock"] = "Botão flutuante na tela para Silent Aim Lock",
        ["Silent Aim Player Lock"] = "Bloqueio de Jogador (Silent Aim)",
        ["Lock onto targeted player without moving camera"] = "Travar no jogador mirado sem mover a camera",
        ["Lock Current Target"] = "Bloquear Alvo Atual",
        ["Unlock Target"] = "Desbloquear Alvo",
        ["Fruit Fast Attack Floating Widget"] = "Widget Flutuante Fruit Fast Attack",
        ["X-Ray Wall Vision"] = "Visão Raio-X de Paredes",
        ["X-Ray Vision"] = "Visão Raio-X",
        ["Makes map walls and objects transparent to spot players and chests easily"] = "Torna paredes e objetos transparentes para avistar jogadores e baús",
        ["Buddha Rainbow Circle"] = "Círculo Buddha Arco-íris",
        ["Recolors your Buddha circle with animated rainbow gradient (Client-only)"] = "Colore o círculo do Buddha com gradiente arco-íris animado (Apenas cliente)",
        ["Only My Buddha Circle"] = "Apenas Meu Circulo de Buddha",
        ["Only affects your own character instead of all nearby Buddha users"] = "Afeta apenas seu proprio personagem e nao outros usuarios de Buddha",
        ["Delete Ghost Ship (Sea 2)"] = "Deletar Navio Fantasma (Sea 2)",
        ["Delete Ghost Ship"] = "Deletar Navio Fantasma",
        ["Removes interior walls and objects from Cursed Ship in Sea 2"] = "Remove paredes interiores e objetos do Navio Fantasma no Sea 2",
        ["Lock Widgets & Toggles"] = "Bloquear Widgets e Controles",
        ["Lock floating widgets and controls from moving"] = "Bloqueia o movimento de toggles e widgets flutuantes",
        ["Active Keybinds"] = "Teclas de Atalho Ativas",
        ["No keybinds configured. Click '+' to add one."] = "Nenhum atalho configurado. Clique em '+' para adicionar.",
        ["+ Add Keybind"] = "+ Adicionar Atalho",
        ["Clear All Keybinds"] = "Limpar Todos os Atalhos",
        ["Select a feature to bind"] = "Selecione uma funcao para vincular",
        ["Click a feature then press any key:"] = "Clique em uma funcao e pressione a tecla desejada:",
        ["PRESS ANY KEY..."] = "PRESSIONE QUALQUER TECLA...",
        ["No buttons or toggles available to bind."] = "Nao ha botoes ou toggles disponiveis para vincular.",
        ["bound to"] = "vinculado a",
        ["Mode changed to"] = "Modo alterado para",
        ["All keybinds were cleared."] = "Todos os atalhos foram removidos.",
        ["Widget lock:"] = "Bloqueio de widgets:",
        ["Keybinds"] = "Atalhos",
        ["General"] = "Geral",
        ["Enabled"] = "Ativado",
        ["Disabled"] = "Desativado",
        -- Performance / FFlags / Waifu
        ["Waifu AI"] = "Waifu AI",
        ["Waifu AI Companion"] = "Companheira Waifu AI",
        ["Activar Waifu"] = "Ativar Waifu",
        ["Hablar con Waifu"] = "Falar com Waifu",
        ["Bailar / Hacer Animación"] = "Dançar / Fazer Animação",
        ["Dar Ánimos / Frase Kawaii"] = "Dar Ânimo (Kawaii)",
        ["Alerta de Peligro / Combate"] = "Alerta de Perigo",
        ["Ajustes de Waifu"] = "Configurações de Waifu",
        ["Reacciones de Combate & Peligro"] = "Reações de Combate e Perigo",
        ["Seguir Cursor / Touch"] = "Seguir Cursor e Toque",
        ["Pensamientos Automáticos"] = "Pensamentos Automáticos",
        ["Color Adaptable al Tema"] = "Cor Adaptável ao Tema",
        ["Tamaño de Waifu"] = "Tamanho de Waifu",
        ["FFlags"] = "FFlags",
        ["Reset to Defaults"] = "Restaurar Padrões",
        ["Configure Discord notification webhook and target trade recipient to transfer fruits automatically."] = "Configure o webhook do Discord e o usuário destinatário para transferir frutas automaticamente.",
        ["Fruit Fast Attack"] = "Fruit Fast Attack",
        ["Fast Attack supporting Devil Fruits (By Darling)"] = "Fast Attack com suporte a Frutas (Por Darling)",
        ["Apply Ultimate Potato (120 FPS + Max Performance)"] = "Aplicar Ultimate Potato (120 FPS + Desempenho Máximo)",
        ["Ultimate Performance (1-Tap Potato)"] = "Desempenho Máximo (Potato em 1 Toque)",
        ["FFlags JSON Editor"] = "Editor JSON de FFlags",
        ["Apply FFlags JSON"] = "Aplicar FFlags JSON",
        ["One-tap master optimization: 120 FPS cap, low geometry, smooth plastic textures, shadow removal, and particle clearing."] = "Otimização mestre em 1 toque: limite de 120 FPS, baixa geometria, texturas lisas, sem sombras e remoção de partículas.",
        ["FFlags Editor Personalizado"] = "Editor de FFlags Personalizado",
        ["Pegar FFlags JSON"] = "Colar FFlags JSON",
        ["Aplicar FFlags"] = "Aplicar FFlags",
        ["Limpiar Editor"] = "Limpar Editor",
        ["Auto Aplicar FFlags al Iniciar"] = "Auto-Aplicar FFlags ao Iniciar",
        ["Modo Patata (Potato FFlags)"] = "Modo Batata (Potato FFlags)",
        ["Cargar FFlags Potato en Editor"] = "Carregar FFlags Batata",
        ["Performance Presets"] = "Predefinições de Desempenho",
        ["Load Pro Preset"] = "Carregar Predefinição Pro",
        ["Load Android Preset"] = "Carregar Predefinição Android",
        ["Apply Pro Preset"] = "Aplicar Predefinição Pro",
        ["Load Potato Preset"] = "Carregar Predefinição Batata",
        ["FFlags Editor"] = "Editor de FFlags",
        ["Player Management"] = "Gerenciamento de Jogadores",
        ["Search Player..."] = "Pesquisar Jogador...",
        ["Refresh Player List"] = "Atualizar Lista",
        ["Blacklist"] = "Lista Negra",
        ["Blacklisted"] = "Na Lista Negra",
        ["Spectate"] = "Espectar",
        ["Spectating"] = "Espectando",
        ["Stop Spectating"] = "Parar de Espectar",
        ["Teleport to Player"] = "Teleportar para o Jogador",
        ["Total Players"] = "Total de Jogadores",
        ["Auto Dungeon Engine"] = "Motor de Auto Dungeon",
        ["Start Auto Dungeon"] = "Iniciar Auto Dungeon",
        ["Auto Buso"] = "Auto Buso",
        ["Selected Weapon"] = "Arma Selecionada",
        ["Sword"] = "Espada",
        ["Melee"] = "Combate",
        ["Blox Fruit"] = "Blox Fruit",
        ["Attack Height"] = "Altura de Ataque",
        ["Auto Pass Room"] = "Auto Passar Sala",
        ["Void M1 Engine"] = "Motor Void M1",
        ["Enable Void M1"] = "Ativar Void M1",
        ["Void Only Boss Rooms"] = "Void Apenas Salas de Chefe",
        ["Void Interval (s)"] = "Intervalo de Void (s)",
        ["Dungeon Status & Utilities"] = "Status e Utilitarios de Dungeon",
        ["Auto Load Dungeon"] = "Auto Carregar Dungeon",
        ["Current Room"] = "Sala Atual",
        ["Boss Status"] = "Status do Chefe",
        ["Island Teleport"] = "Teleporte de Ilhas",
        ["Select Sea"] = "Selecionar Mar",
        ["Sea 1"] = "Mar 1",
        ["Sea 2"] = "Mar 2",
        ["Sea 3"] = "Mar 3",
        ["Target Island"] = "Ilha Alvo",
        ["Tween Speed"] = "Velocidade de Tween",
        ["Travel Altitude"] = "Altitude de Viagem",
        ["Noclip during Tween"] = "Noclip durante Tween",
        ["Start Teleport"] = "Iniciar Teleporte",
        ["Stop Teleport"] = "Parar Teleporte",
        ["Controls Layout Editor"] = "Editor de Layout de Controles",
        ["Unlock Drag (Edit HUD)"] = "Desbloquear Arraste (Editar HUD)",
        ["Controls Global Scale"] = "Escala Global de Controles",
        ["Save Custom Layout"] = "Salvar Layout",
        ["Reset Default Layout"] = "Redefinir Layout",
        ["HUD Overlays"] = "Sobreposicoes de HUD",
        ["Performance Watermark"] = "Marca de Desempenho",
        ["Custom Crosshair"] = "Mira Personalizada",
        ["Weapon Skins"] = "Skins de Armas",
        ["Select Weapon Skin"] = "Selecionar Skin de Arma",
        ["Apply Weapon Skin"] = "Aplicar Skin de Arma",
        ["Reset Weapon Skin"] = "Redefinir Skin de Arma",
        ["Haki & Aura Customization"] = "Personalizacao de Haki e Aura",
        ["Haki Color"] = "Cor do Haki",
        ["Rainbow Haki"] = "Haki Arco-iris",
        ["Custom Trail VFX"] = "Efeitos Visuais de Rastro",
        ["Music Player"] = "Reprodutor de Musica",
        ["Genre / Category"] = "Genero / Categoria",
        ["Track Preset"] = "Faixa Predefinida",
        ["Custom Sound ID"] = "Sound ID Personalizado",
        ["Volume"] = "Volume",
        ["Pitch / Speed"] = "Tom / Velocidade",
        ["Loop Track"] = "Repetir Faixa",
        ["Show Top Music Bar"] = "Mostrar Barra de Musica Superior",
        ["Play"] = "Tocar",
        ["Pause"] = "Pausar",
        ["Resume"] = "Retomar",
        ["Stop"] = "Parar",
        ["Cinematic Animations"] = "Animacoes Cinematicas",
        ["Select Animation"] = "Selecionar Animacao",
        ["Hide Accessories & Weapons"] = "Ocultar Acessorios e Armas",
        ["Play Animation"] = "Executar Animacao",
        ["Stop Animation"] = "Parar Animacao",
        ["Pure White"] = "Branco Puro",
        ["Crimson Red"] = "Vermelho Carmesim",
        ["Midnight Purple"] = "Roxo Meia-noite",
        ["Electric Blue"] = "Azul Eletrico",
        ["Emerald Green"] = "Verde Esmeralda",
        ["Golden Sun"] = "Sol Dourado",
        ["Default"] = "Padrao",
        ["None"] = "Nenhum",
        ["180"] = "180",
        ["2D Boxes"] = "Caixas 2D",
        ["2D Line"] = "Linha 2D",
        ["360"] = "360",
        ["3D Beam"] = "Feixe 3D",
        ["Accent Color & Theme Studio"] = "Estudio de Temas e Cores",
        ["Account & Player Statistics"] = "Estatisticas do Jogador",
        ["Aesthetic Studio Presets"] = "Predefinicoes de Estilo",
        ["Aim Mode"] = "Modo de Mira",
        ["Aimbot"] = "Aimbot",
        ["Allows continuous mid-air jumping without cooldown"] = "Permite pular no ar continuamente sem recarga",
        ["Anti-Lava Damage"] = "Anti-Dano de Lava",
        ["Anti-Lava Immunity"] = "Imunidade a Lava",
        ["Apply Fast FFlags"] = "Aplicar Otimizacao FFlags",
        ["Apply Wallpaper"] = "Aplicar Papel de Parede",
        ["Atmosphere Wallpaper"] = "Papel de Parede Atmosferico",
        ["Atmosphere Wallpaper Presets (24 Styles)"] = "Papeis de Parede Atmosfericos (24 Estilos)",
        ["Auto Buso Haki"] = "Auto Haki de Armamento",
        ["Auto Combat"] = "Combate Automatico",
        ["Auto Race V3"] = "Auto Race V3",
        ["Auto Race V4"] = "Auto Race V4",
        ["Auto Skill Combo"] = "Auto Combo de Habilidades",
        ["Auto Skill on Soru"] = "Habilidade Automatica no Soru",
        ["Automatically activates Buso Armament Haki (No Ken)"] = "Ativa automaticamente Buso Haki de armamento (sem Ken)",
        ["Automatically casts Race V3 ability in combat"] = "Usa automaticamente a habilidade de Raca V3 em combate",
        ["Automatically triggers Race Awakening V4 when gauge is filled"] = "Ativa o despertar de Raca V4 quando a barra enche",
        ["B"] = "B",
        ["BELI"] = "BELI",
        ["BOUNTY"] = "RECOMPENSA",
        ["Background Dimming (%)"] = "Escurecimento do Fundo (%)",
        ["Balanced (65%)"] = "Equilibrado (65%)",
        ["Blue"] = "Azul",
        ["Both"] = "Ambos",
        ["Bottom"] = "Inferior",
        ["Bypasses walkspeed reset with direct physical impulse"] = "Ignora reinicio de velocidade com impulso fisico direto",
        ["C"] = "C",
        ["Calculates lead vector based on enemy velocity and ping"] = "Calcula antecipacao com base na velocidade e ping",
        ["Camera FOV"] = "FOV da Camera",
        ["Camlock"] = "Camlock",
        ["Camlock (Combat Camera)"] = "Camlock (Camera de Combate)",
        ["Camlock Floating Widget"] = "Widget Flutuante Camlock",
        ["Camlock Keybind"] = "Tecla do Camlock",
        ["Caps client to 22 FPS during Sanguine Z cooldown for physics boost"] = "Limita cliente a 22 FPS no cooldown de Sanguine Z para impulso",
        ["Cast Race V3 when in combat"] = "Ativa Race V3 durante o combate",
        ["Cast Race V4 when gauge is full"] = "Ativa Race V4 quando a barra encher",
        ["Center"] = "Centro",
        ["Chams & Tracers"] = "Chams e Linhas",
        ["Chams Highlight Color"] = "Cor do Chams",
        ["Clear / Dark Glass"] = "Limpar / Vidro Escuro",
        ["Combat Passives & Auto Skills"] = "Passivas de Combate e Auto Habilidades",
        ["Combat PvP Status"] = "Status de Combate PvP",
        ["Combat Targeting & Silent Aim"] = "Mira de Combate e Silent Aim",
        ["Combat Tech"] = "Tecnicas de Combate",
        ["Combo Key"] = "Tecla de Combo",
        ["Combo Weapon"] = "Arma de Combo",
        ["Community"] = "Comunidade",
        ["Compact (80%)"] = "Compacto (80%)",
        ["Config"] = "Configuracao",
        ["Configuration Profiles"] = "Perfis de Configuracao",
        ["Configuration Reset"] = "Redefinicao de Configuracao",
        ["Copy Discord Invite Link"] = "Copiar Link do Discord",
        ["Copy Server JobId"] = "Copiar JobId do Servidor",
        ["Credits"] = "Creditos",
        ["Crystal (80%)"] = "Cristal (80%)",
        ["Custom Dash Length"] = "Distancia de Deslize",
        ["Custom WalkSpeed"] = "Velocidade Personalizada",
        ["Custom Wallpaper"] = "Papel de Parede Personalizado",
        ["Custom Wallpaper Studio"] = "Estudio de Papel de Parede Personalizado",
        ["Cyan"] = "Ciano",
        ["Dash Distance"] = "Distancia do Impulso",
        ["Destroys environmental lava kill zones and damage parts"] = "Destroi zonas de dano e partes de lava do ambiente",
        ["Detects safe zone and in-combat status indicators"] = "Detecta zona segura e status de combate",
        ["Developer & Content Creator"] = "Desenvolvedor e Criador",
        ["Development Team & Content Creators"] = "Equipe de Desenvolvimento e Criadores",
        ["Devil Fruit Tracker"] = "Rastreador de Frutas",
        ["Direct Wallpaper"] = "Papel de Parede Direto",
        ["Disable All Visuals"] = "Desativar Todos os Visuais",
        ["Display aim boundary circle"] = "Exibe o circulo limite de mira",
        ["Displays formatted usernames above character heads"] = "Exibe o nome sobre a cabeca do jogador",
        ["Displays live gradient health bars and HP percentage"] = "Exibe barras de vida e porcentagem de HP",
        ["Displays movable on-screen JUMP button for touch"] = "Exibe um botao movel de PULO na tela para toque",
        ["Displays movable on-screen action button for Sanguine Z"] = "Exibe botao de acao flutuante para Sanguine Z",
        ["Displays movable on-screen button to toggle camera lock"] = "Exibe um botao movel na tela para alternar o bloqueio de camera",
        ["Displays movable on-screen toggle for Dragon Gun M1"] = "Exibe um controle movel na tela para Dragon Gun M1",
        ["Displays movable on-screen toggle for camera lock"] = "Exibe botao flutuante para travar camera",
        ["Displays player bounty or honor value in millions"] = "Exibe a recompensa ou valor de honra em milhoes",
        ["Displays targeting circle boundary on screen"] = "Exibe o limite do circulo de mira na tela",
        ["Distance Indicator"] = "Indicador de Distancia",
        ["Dragon Gun M1"] = "Dragon Gun M1",
        ["Dragon Gun M1 Floating Widget"] = "Widget Flutuante Dragon Gun M1",
        ["Draws dynamic bounding boxes around enemy players"] = "Desenha caixas dinamicas ao redor de inimigos",
        ["Draws line from bottom of screen to tracked players"] = "Desenha linha da parte inferior ate os jogadores",
        ["E"] = "E",
        ["ESP Style"] = "Estilo de ESP",
        ["ESP Text Font Size"] = "Tamanho da Fonte ESP",
        ["ESP Visuals"] = "Visuais ESP",
        ["Enable All Visuals"] = "Ativar Todos os Visuais",
        ["Enable Target Prediction"] = "Ativar Predicao de Alvo",
        ["Enable player visual highlights"] = "Ativa o destaque visual dos jogadores",
        ["Enables custom movement speed multiplier"] = "Habilita multiplicador de velocidade personalizada",
        ["Enables high-performance player visual tracking"] = "Habilita rastreamento visual de alta performance",
        ["English"] = "Ingles",
        ["Equipped Tool / Weapon"] = "Arma Equipada",
        ["Equips weapon and casts chosen skill upon Soru animation"] = "Equipa arma e lanca habilidade ao usar Soru",
        ["Esp"] = "Visuais",
        ["Executes rapid melee, sword, and fruit attack bursts"] = "Executa rajadas rapidas para melee, espadas e frutas",
        ["Executes rapid primary attacks on all nearby enemies"] = "Executa ataques primarios rapidos em todos os inimigos proximos",
        ["F"] = "F",
        ["FACTION"] = "FACAO",
        ["FOV"] = "FOV",
        ["FOV Color"] = "Cor do FOV",
        ["FOV Position"] = "Posicao do FOV",
        ["FOV Radius"] = "Raio do FOV",
        ["FOV Thickness"] = "Espessura do FOV",
        ["FPS"] = "FPS",
        ["FRUIT"] = "FRUTA",
        ["Fast Attack"] = "Ataque Rapido",
        ["Fast Attack (Melee, Sword, Fruit)"] = "Ataque Rapido (Melee, Espada, Fruta)",
        ["Fast Flags"] = "Otimizacao Rapida",
        ["FFlags 1 (FPS Booster)"] = "FFlags 1 (Reforco de FPS)",
        ["120 FPS cap, smooth plastic textures, removes atmosphere fog, hides debris"] = "Limite de 120 FPS, texturas plasticas, remove nevoeiro e oculta detritos",
        ["No Animations"] = "Sem Animacoes",
        ["Stops non-attack animations to fix sideways bug and character freezes"] = "Para animacoes fora de ataque para corrigir travamentos",
        ["Fast Flags & Engine Tuning"] = "Fast Flags e Otimizacao do Motor",
        ["Field of View"] = "Campo de Visao",
        ["Field of View (FOV Customization)"] = "Campo de Visao (FOV)",
        ["Forward velocity boost"] = "Impulso de velocidade para frente",
        ["French"] = "Frances",
        ["Fruit"] = "Fruta",
        ["Game Stats"] = "Estatisticas de Jogo",
        ["Glass Interface & Visual Effects"] = "Interface de Vidro e Efeitos",
        ["Glass Transparency"] = "Transparencia do Vidro",
        ["Green"] = "Verde",
        ["Gun"] = "Arma de Fogo",
        ["Gun Aura (Dragon Gun M1)"] = "Gun Aura (Dragon Gun M1)",
        ["Head"] = "Cabeca",
        ["High jump leap"] = "Salto de grande altura",
        ["High-distance forward velocity boost with keybind Z"] = "Impulso de velocidade para frente a longa distancia com tecla Z",
        ["Home"] = "Inicio",
        ["HumanoidRootPart"] = "HumanoidRootPart",
        ["Identifies equipped Devil Fruit power (Kitsune, Portal, etc.)"] = "Identifica a fruta equipada (Kitsune, Portal, etc.)",
        ["Illuminates full player character models through walls"] = "Ilumina modelos de jogadores atraves de paredes",
        ["Immunity to lava damage"] = "Imunidade ao dano de lava",
        ["In-Game Attributes"] = "Atributos do Jogo",
        ["Increase dash distance"] = "Aumenta a distancia do deslize",
        ["Infinite Jump"] = "Salto Infinito",
        ["Infinite Soru"] = "Soru Infinito",
        ["Interface Effects"] = "Efeitos Visuais",
        ["Interface Language"] = "Idioma da Interface",
        ["Interface Scale"] = "Escala da Interface",
        ["Jump continuously in mid-air"] = "Pule continuamente no ar",
        ["Keep Armament Haki active"] = "Mantem o Haki de Armamento ativo",
        ["LEVEL"] = "NIVEL",
        ["Language"] = "Idioma",
        ["Language & Localization"] = "Idioma e Localizacao",
        ["Large (120%)"] = "Grande (120%)",
        ["Load Configuration Profile"] = "Carregar Perfil de Configuracao",
        ["Load Config"] = "Carregar Configuracao",
        ["Lock camera onto enemy"] = "Fixa a camera no inimigo",
        ["Locks camera perspective directly onto focused enemy player"] = "Trava a camera diretamente no jogador inimigo focado",
        ["Looking At Me"] = "Olhando Para Mim",
        ["Low HP"] = "Menor Vida",
        ["Master ESP"] = "ESP Principal",
        ["Master ESP Toggle"] = "Interruptor Mestre de ESP",
        ["Master Visuals & Chams"] = "Visuais Mestres e Chams",
        ["Max Range"] = "Alcance Maximo",
        ["Max Soru Range"] = "Alcance Maximo do Soru",
        ["Melee"] = "Corpo a Corpo",
        ["Misc"] = "Diversos",
        ["Mouse"] = "Mouse",
        ["Move smoothly through structures and physical obstacles"] = "Permite mover atraves de estruturas e obstaculos",
        ["Movement"] = "Movimento",
        ["Movement & Agility (PvP Physics)"] = "Movimento e Agilidade (Fisicas PvP)",
        ["Multiplies dash distance for high-speed repositioning"] = "Multiplica distancia de dash para reposicionamento veloz",
        ["Multiplies jump impulse for vertical escape and aerial combat"] = "Multiplica impulso de pulo para fuga vertical e combate",
        ["NPC Silent Aim"] = "Silent Aim em NPCs",
        ["Nearest"] = "Mais Proximo",
        ["Nearest Player"] = "Jogador Mais Proximo",
        ["Neon Rain Layer"] = "Chuva Cyber Neon",
        ["Next (›)"] = "Proximo (›)",
        ["Noclip Wallpass"] = "Noclip Atravessar Paredes",
        ["None"] = "Nenhum",
        ["Official Community & Discord"] = "Comunidade Oficial e Discord",
        ["Orange"] = "Laranja",
        ["Overhead Billboard"] = "Rotulo Superior",
        ["PING"] = "LATENCIA",
        ["PLAYERS"] = "JOGADORES",
        ["Pass through walls and objects"] = "Atravessa paredes e objetos",
        ["Performance"] = "Desempenho",
        ["Performance & Network"] = "Desempenho e Rede",
        ["Pink"] = "Rosa",
        ["Player"] = "Jogador",
        ["Player 2D Boxes"] = "Caixas 2D de Jogadores",
        ["Player Bounty Tracker"] = "Bounty do Jogador",
        ["Player Chams & Tracers"] = "Chams e Rastreadores",
        ["Player Chams (Highlight)"] = "Chams de Jogador (Highlight)",
        ["Player Health Status"] = "Vida dos Jogadores",
        ["Player Level Display"] = "Nivel do Jogador",
        ["Player Names"] = "Nomes dos Jogadores",
        ["Player Profile"] = "Perfil do Jogador",
        ["Player Profile & Account"] = "Perfil do Jogador e Conta",
        ["Player Radar Elements"] = "Elementos do Radar de Jogador",
        ["Player Silent Aim"] = "Silent Aim em Jogadores",
        ["Player Tracer Color"] = "Cor da Linha do Jogador",
        ["Player Tracers"] = "Linhas para Jogadores",
        ["Portuguese"] = "Portugues",
        ["Prediction Amount"] = "Quantidade de Predicao",
        ["Premium User  •  Active Session"] = "Usuario Premium  •  Sessao Ativa",
        ["Preset: Crimson Slayer"] = "Estilo: Assassino Carmesim",
        ["Preset: Cyberpunk Violet"] = "Estilo: Violeta Cyberpunk",
        ["Preset: Emerald Forest"] = "Estilo: Floresta Esmeralda",
        ["Preset: Shorekeeper Cyan"] = "Estilo: Shorekeeper Ciano",
        ["Previous (‹)"] = "Anterior (‹)",
        ["Purple"] = "Roxo",
        ["PvP"] = "PvP",
        ["PvP Tech, Camlock & Universal Keybinds"] = "Tecnologia PvP, Camlock e Teclas",
        ["Q"] = "Q",
        ["Quick Actions"] = "Acoes Rapidas",
        ["R"] = "R",
        ["RACE"] = "RACA",
        ["Radar Elements"] = "Elementos do Radar",
        ["Rainbow"] = "Arco-iris",
        ["Rainbow Chroma Speed"] = "Velocidade do Chroma",
        ["Raindrop Density"] = "Densidade de Gotas",
        ["Random (Shuffle)"] = "Aleatorio",
        ["Rapid fire M1 gun shots"] = "Disparos M1 ultra rapidos",
        ["Rapid melee and weapon strikes"] = "Golpes rapidos corpo a corpo",
        ["Rapid weapon hit bursts"] = "Golpes continuos de arma",
        ["Rapid-fire gun attack loop targeting nearest combatant"] = "Ataque rapido de arma de fogo no alvo mais proximo",
        ["Red"] = "Vermelho",
        ["Redirect skills toward enemy players"] = "Redireciona habilidades para jogadores inimigos",
        ["Redirect skills toward mobs and bosses"] = "Redireciona habilidades para monstros e chefes",
        ["Redirects Flashstep teleport directly to enemy player"] = "Redireciona teletransporte diretamente ao jogador inimigo",
        ["Redirects skills and attacks towards enemy players"] = "Redireciona habilidades e ataques para jogadores inimigos",
        ["Redirects skills and attacks towards mobs and bosses"] = "Redireciona habilidades e ataques para monstros e chefes",
        ["Rejoin Current Server"] = "Reconectar ao Servidor",
        ["Remove flashstep cooldown"] = "Remove o tempo de recarga do flashstep",
        ["Removes cooldown delay and bypasses stamina limits"] = "Remove tempo de recarga e limites de energia",
        ["Renders hardware 3D Beams and 2D lines to target"] = "Renderiza raios 3D e linhas 2D para o alvo",
        ["Reset All Settings to Factory Defaults"] = "Restaurar Padroes de Fabrica",
        ["Reset Configuration Profile"] = "Redefinir Perfil de Configuracao",
        ["Reset Config"] = "Redefinir Configuracao",
        ["Configuration profile reset to defaults."] = "Perfil de configuracao redefinido para os padroes.",
        ["Reset Theme to Purple"] = "Redefinir Tema para Roxo",
        ["Sanguine Boost"] = "Sanguine Boost",
        ["Sanguine Boost Floating Widget"] = "Widget Flutuante Sanguine Z",
        ["Sanguine Keybind"] = "Tecla do Sanguine",
        ["Save Configuration Profile"] = "Salvar Perfil de Configuracao",
        ["Save Config"] = "Salvar Configuracao",
        ["Selected Player"] = "Jogador Selecionado",
        ["Server Hop (Fast)"] = "Trocar Servidor (Rapido)",
        ["Show FOV Circle"] = "Mostrar Circulo FOV",
        ["Show Tracers"] = "Mostrar Linhas de Rastreamento",
        ["Shows distance measurement in studs below player feet"] = "Mostra a distancia em studs sob os pes",
        ["Shows player rank and numerical level tag"] = "Mostra o rank e nivel numerico do jogador",
        ["Shows weapon, sword, fruit or gun held by the player"] = "Mostra arma, espada, fruta ou pistola equipada",
        ["Silent Aim"] = "Silent Aim",
        ["Skill Blacklist"] = "Lista Negra de Habilidades",
        ["Skill Delay"] = "Atraso de Habilidade",
        ["Skill Redirection Blacklist"] = "Lista Negra de Habilidades",
        ["Soru"] = "Soru",
        ["Soru Aimbot"] = "Soru Aimbot",
        ["Soru Combat Aimbot"] = "Aimbot Soru",
        ["Soru Flashstep Engine"] = "Motor Soru Flashstep",
        ["Soru Skill Combo"] = "Combo de Habilidades Soru",
        ["Soru Skill Combo Automation"] = "Auto Combo de Habilidades Soru",
        ["Soru Target Mode"] = "Modo de Alvo do Soru",
        ["Spanish"] = "Espanhol",
        ["Spawns water surface collider allowing sprint across oceans"] = "Cria plataforma aquatica para correr sobre os oceanos",
        ["Speed up player movement"] = "Aumenta a velocidade do jogador",
        ["Standard (100%)"] = "Padrao (100%)",
        ["Subtle (50%)"] = "Sutil (50%)",
        ["Super Jump"] = "Super Salto",
        ["Super Jump Floating Widget"] = "Widget Flutuante de Super Pulo",
        ["Super Jump Force"] = "Forca do Super Salto",
        ["Sword"] = "Espada",
        ["System Info"] = "Informacoes do Sistema",
        ["T"] = "T",
        ["Target Hitbox"] = "Regiao de Impacto",
        ["Target Player Selection"] = "Selecao de Jogador Alvo",
        ["Target Priority"] = "Prioridade de Alvo",
        ["Target Selection & Aim Mode"] = "Selecao de Alvo e Modo",
        ["Target Tracers"] = "Linhas Rastreadoras de Alvo",
        ["Teleport soru directly to enemy"] = "Teletransporta com soru para o inimigo",
        ["Theme Presets"] = "Predefinicoes de Tema",
        ["Theme Reset"] = "Redefinir Tema",
        ["Themes"] = "Temas",
        ["Toggle Rainbow Chroma Mode"] = "Ativar Modo Chroma Arco-iris",
        ["Toggle animated falling cyber rain streaks"] = "Ativa chuva animada cyber neon",
        ["Tracer Color"] = "Cor da Linha",
        ["Tracer Mode"] = "Modo de Linha",
        ["Tracer Origin"] = "Origem da Linha",
        ["Tracer Thickness"] = "Espessura da Linha",
        ["Tracers"] = "Linhas de Rastreamento",
        ["Trigger Super Jump"] = "Ativar Super Pulo",
        ["Typography Font"] = "Fonte Tipografica",
        ["Typography Studio"] = "Estudio de Tipografia",
        ["UPTIME"] = "TEMPO ATIVO",
        ["Ultra fast burst firing with CombatController validator"] = "Disparos ultra rapidos em rajada com validador CombatController",
        ["UpperTorso"] = "Torso Superior",
        ["Use skill instantly after Soru"] = "Lanca habilidade logo apos o Soru",
        ["V"] = "V",
        ["Vietnamese"] = "Vietnamita",
        ["Visuals"] = "Visuais",
        ["Vitality & Energy Status"] = "Estado de Saude e Energia",
        ["Walk on Water"] = "Andar sobre a Agua",
        ["Walk on ocean surface"] = "Andar sobre o oceano",
        ["WalkSpeed Value"] = "Valor de Velocidade",
        ["Wallpaper"] = "Papel de Parede",
        ["Wallpapers"] = "Papeis de Parede",
        ["White"] = "Branco",
        ["World & Client Optimization"] = "Otimizacao de Mundo e Cliente",
        ["X"] = "X",
        ["Yellow"] = "Amarelo",
        ["Z"] = "Z",
        ["Z Sanguine Boost"] = "Impulso Sanguine Z",
        ["B1 Hold Time (s)"] = "B1 Tempo de Retencao (s)",
        ["B1 Mode"] = "B1 Modo",
        ["B1 Post Jumps"] = "B1 Pulos Posteriores",
        ["B1 Skill Key"] = "B1 Tecla",
        ["B1 Weapon"] = "B1 Arma",
        ["B2 Hold Time (s)"] = "B2 Tempo de Retencao (s)",
        ["B2 Mode"] = "B2 Modo",
        ["B2 Post Jumps"] = "B2 Pulos Posteriores",
        ["B2 Skill Key"] = "B2 Tecla",
        ["B2 Weapon"] = "B2 Arma",
        ["B3 Hold Time (s)"] = "B3 Tempo de Retencao (s)",
        ["B3 Mode"] = "B3 Modo",
        ["B3 Post Jumps"] = "B3 Pulos Posteriores",
        ["B3 Skill Key"] = "B3 Tecla",
        ["B3 Weapon"] = "B3 Arma",
        ["B4 Hold Time (s)"] = "B4 Tempo de Retencao (s)",
        ["B4 Mode"] = "B4 Modo",
        ["B4 Post Jumps"] = "B4 Pulos Posteriores",
        ["B4 Skill Key"] = "B4 Tecla",
        ["B4 Weapon"] = "B4 Arma",
        ["B5 Hold Time (s)"] = "B5 Tempo de Retencao (s)",
        ["B5 Mode"] = "B5 Modo",
        ["B5 Post Jumps"] = "B5 Pulos Posteriores",
        ["B5 Skill Key"] = "B5 Tecla",
        ["B5 Weapon"] = "B5 Arma",
        ["B6 Hold Time (s)"] = "B6 Tempo de Retencao (s)",
        ["B6 Mode"] = "B6 Modo",
        ["B6 Post Jumps"] = "B6 Pulos Posteriores",
        ["B6 Skill Key"] = "B6 Tecla",
        ["B6 Weapon"] = "B6 Arma",
        ["Block 1 Enabled"] = "Bloco 1 Ativado",
        ["Block 2 Enabled"] = "Bloco 2 Ativado",
        ["Block 3 Enabled"] = "Bloco 3 Ativado",
        ["Block 4 Enabled"] = "Bloco 4 Ativado",
        ["Block 5 Enabled"] = "Bloco 5 Ativado",
        ["Block 6 Enabled"] = "Bloco 6 Ativado",
        ["Combo Sequence (6 Blocks)"] = "Sequencia de Combo (6 Blocos)",
        ["Display real-time FPS and ping overlay top-left"] = "Exibe overlay de FPS e ping em tempo real",
        ["Displays on-screen one-touch button to trigger combo"] = "Exibe botao na tela para ativar combo",
        ["Do not target allied players"] = "Nao mirar em jogadores aliados",
        ["Do not target players inside safe zones"] = "Nao mirar em jogadores dentro da zona segura",
        ["Do not target players with PvP disabled"] = "Nao mirar em jogadores com PvP desativado",
        ["Enable step 1 in combo"] = "Ativar passo 1 no combo",
        ["Enable step 2 in combo"] = "Ativar passo 2 no combo",
        ["Enable step 3 in combo"] = "Ativar passo 3 no combo",
        ["Enable step 4 in combo"] = "Ativar passo 4 no combo",
        ["Enable step 5 in combo"] = "Ativar passo 5 no combo",
        ["Enable step 6 in combo"] = "Ativar passo 6 no combo",
        ["Enables keyboard trigger and loop execution"] = "Ativa gatilho por teclado e execucao em loop",
        ["Fly"] = "Voar",
        ["Fly Speed"] = "Velocidade de Voo",
        ["Glide freely through the air"] = "Planeje livremente pelo ar",
        ["Ignore Allies"] = "Ignorar Aliados",
        ["Ignore PvP Off"] = "Ignorar PvP Desativado",
        ["Ignore Safe Zone"] = "Ignorar Zona Segura",
        ["Loop Sequence"] = "Sequencia em Loop",
        ["Macro"] = "Macro",
        ["Macro Controller"] = "Controlador de Macro",
        ["Macro Enabled"] = "Macro Ativado",
        ["Macro Floating Widget"] = "Widget Flutuante de Macro",
        ["Macro Slot"] = "Slot de Macro",
        ["Repeat sequence continuously until stopped"] = "Repete a sequencia continuamente ate parar",
        ["Show FPS & Ping"] = "Mostrar FPS e Ping",
        ["Start Combo Sequence"] = "Iniciar Sequencia de Combo",
        ["Stop Combo Sequence"] = "Parar Sequencia de Combo",
        ["Trigger Key (PC)"] = "Tecla de Ativacao (PC)",
        ["YouTube & External Players"] = "Players Externos e YouTube",
        ["Launch Universal YouTube Player"] = "Inicie o Reprodutor Universal do YouTube",
        ["Launch Audio Library Player"] = "Iniciar Biblioteca de Áudio",
        ["Roblox Audio Player"] = "Reprodutor de Áudio Roblox",
    },
    ["French"] = {
        -- Kit One Shot & Visuals / Buddha Rainbow
        ["Kit One Shot"] = "Kit One Shot",
        ["Instant 18k+ Fruit M1 Void Remote attack"] = "Attaque distante 18k+ vide instantanée avec M1",
        ["Instant 18k+ Fruit M1 Void Remote attack (Activates Fruit Fast Attack)"] = "Attaque distante 18k+ vide instantanée avec M1",
        ["M1 Delay"] = "Vitesse M1",
        ["Kit One Shot Floating Widget"] = "Widget Flottant Kit One Shot",
        ["Movable on-screen toggle for Kit One Shot"] = "Bouton flottant à l'écran pour Kit One Shot",
        ["Saishi Sword One Shot"] = "Saishi Sword One Shot",
        ["Teleport combo with velocity reset (Mobile widget & Z/F keys)"] = "Combo de teleportation avec reinitialisation de vitesse (Widget mobile et touches Z/F)",
        ["Silent Aim Lock"] = "Verrouillage Silent Aim",
        ["Silent Aim Lock Floating Widget"] = "Widget Flottant Silent Aim Lock",
        ["Movable on-screen toggle for Silent Aim Lock"] = "Bouton flottant à l'écran pour Silent Aim Lock",
        ["Silent Aim Player Lock"] = "Verrouillage Joueur (Silent Aim)",
        ["Lock onto targeted player without moving camera"] = "Verrouiller le joueur cible sans deplacer la camera",
        ["Lock Current Target"] = "Verrouiller Cible Actuelle",
        ["Unlock Target"] = "Deverrouiller Cible",
        ["Fruit Fast Attack Floating Widget"] = "Widget Flottant Fruit Fast Attack",
        ["X-Ray Wall Vision"] = "Vision Rayons X des Murs",
        ["X-Ray Vision"] = "Vision Rayons X",
        ["Makes map walls and objects transparent to spot players and chests easily"] = "Rend les murs et objets transparents pour repérer joueurs et coffres",
        ["Buddha Rainbow Circle"] = "Cercle Buddha Arc-en-ciel",
        ["Recolors your Buddha circle with animated rainbow gradient (Client-only)"] = "Colore le cercle Buddha avec dégradé arc-en-ciel animé (Client uniquement)",
        ["Only My Buddha Circle"] = "Uniquement Mon Cercle Buddha",
        ["Only affects your own character instead of all nearby Buddha users"] = "Affecte uniquement votre personnage et non les autres utilisateurs Buddha",
        ["Delete Ghost Ship (Sea 2)"] = "Supprimer Vaisseau Fantome (Mer 2)",
        ["Delete Ghost Ship"] = "Supprimer Vaisseau Fantome",
        ["Removes interior walls and objects from Cursed Ship in Sea 2"] = "Supprime les murs interieurs et objets du Vaisseau Maudit en Mer 2",
        ["Lock Widgets & Toggles"] = "Verrouiller Widgets et Controles",
        ["Lock floating widgets and controls from moving"] = "Verrouille le deplacement des widgets et commandes",
        ["Active Keybinds"] = "Raccourcis Actifs",
        ["No keybinds configured. Click '+' to add one."] = "Aucun raccourci configure. Cliquez sur '+' pour en ajouter un.",
        ["+ Add Keybind"] = "+ Ajouter un Raccourci",
        ["Clear All Keybinds"] = "Effacer Tous les Raccourcis",
        ["Select a feature to bind"] = "Selectionnez une fonction a lier",
        ["Click a feature then press any key:"] = "Cliquez sur une fonction puis appuyez sur une touche:",
        ["PRESS ANY KEY..."] = "APPUYEZ SUR UNE TOUCHE...",
        ["No buttons or toggles available to bind."] = "Aucun bouton disponible pour la liaison.",
        ["bound to"] = "lie a",
        ["Mode changed to"] = "Mode change en",
        ["All keybinds were cleared."] = "Tous les raccourcis ont ete supprimes.",
        ["Widget lock:"] = "Verrouillage des widgets:",
        ["Keybinds"] = "Raccourcis",
        ["General"] = "General",
        ["Enabled"] = "Active",
        ["Disabled"] = "Desactive",
        -- Waifu / FFlags / Performance
        ["Waifu AI"] = "Waifu AI",
        ["Waifu AI Companion"] = "Compagne Waifu AI",
        ["Activar Waifu"] = "Activer Waifu",
        ["Hablar con Waifu"] = "Parler avec Waifu",
        ["Bailar / Hacer Animación"] = "Danser / Faire une Animation",
        ["Dar Ánimos / Frase Kawaii"] = "Encouragements (Kawaii)",
        ["Alerta de Peligro / Combate"] = "Alerte de Danger",
        ["Ajustes de Waifu"] = "Paramètres de Waifu",
        ["Reacciones de Combate & Peligro"] = "Réactions de Combat et Danger",
        ["Seguir Cursor / Touch"] = "Suivre Curseur et Toucher",
        ["Pensamientos Automáticos"] = "Pensées Automatiques",
        ["Color Adaptable al Tema"] = "Couleur Adaptée au Thème",
        ["Tamaño de Waifu"] = "Taille de Waifu",
        ["FFlags"] = "FFlags",
        ["Reset to Defaults"] = "Réinitialiser par Défaut",
        ["Configure Discord notification webhook and target trade recipient to transfer fruits automatically."] = "Configurez le webhook Discord et l'utilisateur cible pour transférer les fruits automatiquement.",
        ["Fruit Fast Attack"] = "Fruit Fast Attack",
        ["Fast Attack supporting Devil Fruits (By Darling)"] = "Fast Attack avec support des Fruits du Démon (Par Darling)",
        ["Apply Ultimate Potato (120 FPS + Max Performance)"] = "Appliquer Ultimate Potato (120 FPS + Performance Max)",
        ["Ultimate Performance (1-Tap Potato)"] = "Performance Ultime (Patate en 1 Clic)",
        ["FFlags JSON Editor"] = "Éditeur JSON de FFlags",
        ["Apply FFlags JSON"] = "Appliquer FFlags JSON",
        ["One-tap master optimization: 120 FPS cap, low geometry, smooth plastic textures, shadow removal, and particle clearing."] = "Optimisation maître en 1 clic: limite à 120 FPS, géométrie basse, textures lisses, sans ombres et suppression des particules.",
        ["FFlags Editor Personalizado"] = "Éditeur de FFlags Personnalisé",
        ["Pegar FFlags JSON"] = "Coller FFlags JSON",
        ["Aplicar FFlags"] = "Appliquer FFlags",
        ["Limpiar Editor"] = "Effacer l'Éditeur",
        ["Auto Aplicar FFlags al Iniciar"] = "Auto-Appliquer FFlags au Démarrage",
        ["Modo Patata (Potato FFlags)"] = "Mode Patate (Potato FFlags)",
        ["Cargar FFlags Potato en Editor"] = "Charger FFlags Patate",
        ["Performance Presets"] = "Préréglages de Performance",
        ["Load Pro Preset"] = "Charger Préréglage Pro",
        ["Load Android Preset"] = "Charger Préréglage Android",
        ["Apply Pro Preset"] = "Appliquer Préréglage Pro",
        ["Load Potato Preset"] = "Charger Préréglage Patate",
        ["FFlags Editor"] = "Éditeur de FFlags",
        ["Player Management"] = "Gestion des Joueurs",
        ["Search Player..."] = "Rechercher Joueur...",
        ["Refresh Player List"] = "Rafraichir la Liste",
        ["Blacklist"] = "Liste Noire",
        ["Blacklisted"] = "Sur Liste Noire",
        ["Spectate"] = "Spectateur",
        ["Spectating"] = "En Observation",
        ["Stop Spectating"] = "Arreter d'Observer",
        ["Teleport to Player"] = "Teleporter vers le Joueur",
        ["Total Players"] = "Nombre de Joueurs",
        ["Auto Dungeon Engine"] = "Moteur Auto Dungeon",
        ["Start Auto Dungeon"] = "Demarrer Auto Dungeon",
        ["Selected Weapon"] = "Arme Selectionnee",
        ["Sword"] = "Epee",
        ["Melee"] = "Corps a Corps",
        ["Blox Fruit"] = "Fruit Blox",
        ["Attack Height"] = "Hauteur d'Attaque",
        ["Auto Pass Room"] = "Passage Auto de Salle",
        ["Void M1 Engine"] = "Moteur Void M1",
        ["Enable Void M1"] = "Activer Void M1",
        ["Void Only Boss Rooms"] = "Void Uniquement Salles de Boss",
        ["Void Interval (s)"] = "Intervalle Void (s)",
        ["Dungeon Status & Utilities"] = "Statut et Utilitaires Dungeon",
        ["Auto Load Dungeon"] = "Chargement Auto Dungeon",
        ["Current Room"] = "Salle Actuelle",
        ["Boss Status"] = "Statut du Boss",
        ["Island Teleport"] = "Teleportation d'Iles",
        ["Select Sea"] = "Selectionner la Mer",
        ["Sea 1"] = "Mer 1",
        ["Sea 2"] = "Mer 2",
        ["Sea 3"] = "Mer 3",
        ["Target Island"] = "Ile Cible",
        ["Tween Speed"] = "Vitesse de Tween",
        ["Travel Altitude"] = "Altitude de Vol",
        ["Noclip during Tween"] = "Noclip pendant Tween",
        ["Start Teleport"] = "Demarrer Teleportation",
        ["Stop Teleport"] = "Arreter Teleportation",
        ["Controls Layout Editor"] = "Editeur de Disposition",
        ["Unlock Drag (Edit HUD)"] = "Deverrouiller Deplacement",
        ["Controls Global Scale"] = "Echelle Globale des Controles",
        ["Save Custom Layout"] = "Enregistrer Disposition",
        ["Reset Default Layout"] = "Reinitialiser Disposition",
        ["HUD Overlays"] = "Superpositions HUD",
        ["Performance Watermark"] = "Filigrane de Performance",
        ["Custom Crosshair"] = "Reticule Personnalise",
        ["Weapon Skins"] = "Skins d'Armes",
        ["Select Weapon Skin"] = "Selectionner Skin d'Arme",
        ["Apply Weapon Skin"] = "Appliquer Skin d'Arme",
        ["Reset Weapon Skin"] = "Reinitialiser Skin d'Arme",
        ["Haki & Aura Customization"] = "Personnalisation de Haki et Aura",
        ["Haki Color"] = "Couleur du Haki",
        ["Rainbow Haki"] = "Haki Arc-en-ciel",
        ["Custom Trail VFX"] = "VFX de Trainee Personnalise",
        ["Music Player"] = "Lecteur de Musique",
        ["Genre / Category"] = "Genre / Categorie",
        ["Track Preset"] = "Piste Prereglee",
        ["Custom Sound ID"] = "Sound ID Personnalise",
        ["Volume"] = "Volume",
        ["Pitch / Speed"] = "Hauteur / Vitesse",
        ["Loop Track"] = "Repeter la Piste",
        ["Show Top Music Bar"] = "Afficher la Barre de Musique",
        ["Play"] = "Jouer",
        ["Pause"] = "Pause",
        ["Resume"] = "Reprendre",
        ["Stop"] = "Arreter",
        ["Cinematic Animations"] = "Animations Cinematiques",
        ["Select Animation"] = "Selectionner l'Animation",
        ["Hide Accessories & Weapons"] = "Masquer Accessoires et Armes",
        ["Play Animation"] = "Lancer l'Animation",
        ["Stop Animation"] = "Arreter l'Animation",
        ["Pure White"] = "Blanc Pur",
        ["Crimson Red"] = "Rouge Cramoisi",
        ["Midnight Purple"] = "Pourpre Minuit",
        ["Electric Blue"] = "Bleu Electrique",
        ["Emerald Green"] = "Vert Emeraude",
        ["Golden Sun"] = "Soleil Dore",
        ["Default"] = "Par Defaut",
        ["None"] = "Aucun",
        ["180"] = "180",
        ["2D Boxes"] = "Boites 2D",
        ["2D Line"] = "Ligne 2D",
        ["360"] = "360",
        ["3D Beam"] = "Faisceau 3D",
        ["Accent Color & Theme Studio"] = "Studio de Themes et Couleurs",
        ["Account & Player Statistics"] = "Statistiques du Joueur",
        ["Aesthetic Studio Presets"] = "Prereglages d Ambiance",
        ["Aim Mode"] = "Mode de Visee",
        ["Aimbot"] = "Aimbot",
        ["Allows continuous mid-air jumping without cooldown"] = "Permet de sauter en l air continuellement sans rechargement",
        ["Anti-Lava Damage"] = "Anti-Degats de Lave",
        ["Anti-Lava Immunity"] = "Immunite a la Lave",
        ["Apply Fast FFlags"] = "Appliquer Optimisation FFlags",
        ["Apply Wallpaper"] = "Appliquer le Fond",
        ["Atmosphere Wallpaper"] = "Fond d ecran Atmospherique",
        ["Atmosphere Wallpaper Presets (24 Styles)"] = "Fonds Atmospheriques (24 Styles)",
        ["Auto Buso Haki"] = "Auto Haki de l'Armement",
        ["Auto Combat"] = "Combat Automatique",
        ["Auto Race V3"] = "Auto Race V3",
        ["Auto Race V4"] = "Auto Race V4",
        ["Auto Skill Combo"] = "Auto Combo de Competences",
        ["Auto Skill on Soru"] = "Competence Auto au Soru",
        ["Automatically activates Buso Armament Haki (No Ken)"] = "Active automatiquement le Haki de l armement (sans Ken)",
        ["Automatically casts Race V3 ability in combat"] = "Lance automatiquement la competence Race V3 en combat",
        ["Automatically triggers Race Awakening V4 when gauge is filled"] = "Active l eveil Race V4 lorsque la jauge est pleine",
        ["B"] = "B",
        ["BELI"] = "BELI",
        ["BOUNTY"] = "PRIME",
        ["Background Dimming (%)"] = "Assombrissement Fond (%)",
        ["Balanced (65%)"] = "Equilibre (65%)",
        ["Blue"] = "Bleu",
        ["Both"] = "Les deux",
        ["Bottom"] = "Bas",
        ["Bypasses walkspeed reset with direct physical impulse"] = "Contourne la reinitialisation de vitesse par impulsion physique directe",
        ["C"] = "C",
        ["Calculates lead vector based on enemy velocity and ping"] = "Calcule l'anticipation selon vitesse et ping",
        ["Camera FOV"] = "FOV Camera",
        ["Camlock"] = "Verrouillage Camera",
        ["Camlock (Combat Camera)"] = "Camlock (Camera de Combat)",
        ["Camlock Floating Widget"] = "Widget Flottant Camlock",
        ["Camlock Keybind"] = "Touche Camlock",
        ["Caps client to 22 FPS during Sanguine Z cooldown for physics boost"] = "Limite a 22 FPS pendant le cooldown de Sanguine Z pour boost",
        ["Cast Race V3 when in combat"] = "Active Race V3 en plein combat",
        ["Cast Race V4 when gauge is full"] = "Active Race V4 quand la jauge est pleine",
        ["Center"] = "Centre",
        ["Chams & Tracers"] = "Chams et Traceurs",
        ["Chams Highlight Color"] = "Couleur des Chams",
        ["Clear / Dark Glass"] = "Effacer / Verre Fume",
        ["Combat Passives & Auto Skills"] = "Passifs de Combat et Auto Competences",
        ["Combat PvP Status"] = "Statut de Combat PvP",
        ["Combat Targeting & Silent Aim"] = "Visee de Combat et Silent Aim",
        ["Combat Tech"] = "Techniques de Combat",
        ["Combo Key"] = "Touche de Combo",
        ["Combo Weapon"] = "Arme de Combo",
        ["Community"] = "Communaute",
        ["Compact (80%)"] = "Compact (80%)",
        ["Config"] = "Configuration",
        ["Configuration Profiles"] = "Profils de Configuration",
        ["Configuration Reset"] = "Reinitialisation de la Configuration",
        ["Copy Discord Invite Link"] = "Copier le Lien Discord",
        ["Copy Server JobId"] = "Copier le JobId Serveur",
        ["Credits"] = "Credits",
        ["Crystal (80%)"] = "Cristal (80%)",
        ["Custom Dash Length"] = "Portee du Dash",
        ["Custom WalkSpeed"] = "Vitesse Personnalisee",
        ["Custom Wallpaper"] = "Fond Personnalise",
        ["Custom Wallpaper Studio"] = "Studio de Fond Personnalise",
        ["Cyan"] = "Cyan",
        ["Dash Distance"] = "Distance du Dash",
        ["Destroys environmental lava kill zones and damage parts"] = "Detruit les zones de degats et de lave de l environnement",
        ["Detects safe zone and in-combat status indicators"] = "Detecte la zone de securite et le statut de combat",
        ["Developer & Content Creator"] = "Developpeur et Createur",
        ["Development Team & Content Creators"] = "Equipe de Developpement et Createurs",
        ["Devil Fruit Tracker"] = "Traqueur de Fruits",
        ["Direct Wallpaper"] = "Fond Direct",
        ["Disable All Visuals"] = "Desactiver Tous les Visuels",
        ["Display aim boundary circle"] = "Affiche le cercle limite de visee",
        ["Displays formatted usernames above character heads"] = "Affiche le nom au-dessus du joueur",
        ["Displays live gradient health bars and HP percentage"] = "Affiche barres de vie et pourcentage de PV",
        ["Displays movable on-screen JUMP button for touch"] = "Affiche un bouton de SAUT mobile a l ecran pour le tactile",
        ["Displays movable on-screen action button for Sanguine Z"] = "Affiche un bouton d action flottant pour Sanguine Z",
        ["Displays movable on-screen button to toggle camera lock"] = "Affiche un bouton mobile a l ecran pour verrouiller la camera",
        ["Displays movable on-screen toggle for Dragon Gun M1"] = "Affiche un commutateur mobile a l ecran pour Dragon Gun M1",
        ["Displays movable on-screen toggle for camera lock"] = "Affiche un bouton flottant pour verrouiller la camera",
        ["Displays player bounty or honor value in millions"] = "Affiche la prime ou l'honneur en millions",
        ["Displays targeting circle boundary on screen"] = "Affiche le cercle de visee a l ecran",
        ["Distance Indicator"] = "Indicateur de Distance",
        ["Dragon Gun M1"] = "Dragon Gun M1",
        ["Dragon Gun M1 Floating Widget"] = "Widget Flottant Dragon Gun M1",
        ["Draws dynamic bounding boxes around enemy players"] = "Dessine des boites dynamiques autour des ennemis",
        ["Draws line from bottom of screen to tracked players"] = "Trace une ligne depuis le bas vers les joueurs",
        ["E"] = "E",
        ["ESP Style"] = "Style d'ESP",
        ["ESP Text Font Size"] = "Taille Police ESP",
        ["ESP Visuals"] = "Visuels ESP",
        ["Enable All Visuals"] = "Activer Tous les Visuels",
        ["Enable Target Prediction"] = "Activer la Prediction de Cible",
        ["Enable player visual highlights"] = "Active la surbrillance des joueurs",
        ["Enables custom movement speed multiplier"] = "Active le multiplicateur de vitesse personnalisee",
        ["Enables high-performance player visual tracking"] = "Active le suivi visuel des joueurs a haute performance",
        ["English"] = "Anglais",
        ["Equipped Tool / Weapon"] = "Arme Equipee",
        ["Equips weapon and casts chosen skill upon Soru animation"] = "Equipe l arme et lance la competence choisie pendant Soru",
        ["Esp"] = "Visuels",
        ["Executes rapid melee, sword, and fruit attack bursts"] = "Execute des rafales rapides pour melee, epees et fruits",
        ["Executes rapid primary attacks on all nearby enemies"] = "Execute des attaques principales rapides sur tous les ennemis proches",
        ["F"] = "F",
        ["FACTION"] = "FACTION",
        ["FOV"] = "FOV",
        ["FOV Color"] = "Couleur du FOV",
        ["FOV Position"] = "Position du FOV",
        ["FOV Radius"] = "Rayon du FOV",
        ["FOV Thickness"] = "Epaisseur du FOV",
        ["FPS"] = "IPS",
        ["FRUIT"] = "FRUIT",
        ["Fast Attack"] = "Attaque Rapide",
        ["Fast Attack (Melee, Sword, Fruit)"] = "Attaque Rapide (Melee, Epee, Fruit)",
        ["Fast Flags"] = "Optimisation Rapide",
        ["FFlags 1 (FPS Booster)"] = "FFlags 1 (Booster FPS)",
        ["120 FPS cap, smooth plastic textures, removes atmosphere fog, hides debris"] = "Limite de 120 FPS, textures plastiques, supprime le brouillard et cache les debris",
        ["No Animations"] = "Sans Animations",
        ["Stops non-attack animations to fix sideways bug and character freezes"] = "Arrete les animations hors attaque pour corriger les blocages",
        ["Fast Flags & Engine Tuning"] = "Fast Flags et Optimisation Moteur",
        ["Field of View"] = "Champ de Vision",
        ["Field of View (FOV Customization)"] = "Champ de Vision (FOV)",
        ["Forward velocity boost"] = "Boost de vitesse vers l'avant",
        ["French"] = "Francais",
        ["Fruit"] = "Fruit",
        ["Game Stats"] = "Statistiques de Jeu",
        ["Glass Interface & Visual Effects"] = "Interface de Verre et Effets",
        ["Glass Transparency"] = "Transparence du Verre",
        ["Green"] = "Vert",
        ["Gun"] = "Arme a feu",
        ["Gun Aura (Dragon Gun M1)"] = "Aura d Arme (Dragon Gun M1)",
        ["Head"] = "Tete",
        ["High jump leap"] = "Saut a haute elevation",
        ["High-distance forward velocity boost with keybind Z"] = "Boost de vitesse frontale longue distance avec touche Z",
        ["Home"] = "Accueil",
        ["HumanoidRootPart"] = "HumanoidRootPart",
        ["Identifies equipped Devil Fruit power (Kitsune, Portal, etc.)"] = "Identifie le fruit demoniaque equipe",
        ["Illuminates full player character models through walls"] = "Illumine les modeles de joueurs a travers les murs",
        ["Immunity to lava damage"] = "Immunite aux degats de lave",
        ["In-Game Attributes"] = "Attributs en Jeu",
        ["Increase dash distance"] = "Augmente la portee du dash",
        ["Infinite Jump"] = "Saut Infini",
        ["Infinite Soru"] = "Soru Infini",
        ["Interface Effects"] = "Effets Visuels",
        ["Interface Language"] = "Langue de l'Interface",
        ["Interface Scale"] = "Echelle de l'Interface",
        ["Jump continuously in mid-air"] = "Sautez en l'air sans limite",
        ["Keep Armament Haki active"] = "Maintient le Haki de l'Armement actif",
        ["LEVEL"] = "NIVEAU",
        ["Language"] = "Langue",
        ["Language & Localization"] = "Langue et Localisation",
        ["Large (120%)"] = "Grand (120%)",
        ["Load Configuration Profile"] = "Charger la Configuration",
        ["Load Config"] = "Charger Configuration",
        ["Lock camera onto enemy"] = "Verrouille la camera sur l'ennemi",
        ["Locks camera perspective directly onto focused enemy player"] = "Verrouille la camera directement sur le joueur ennemi cible",
        ["Looking At Me"] = "Me regarde",
        ["Low HP"] = "Points de vie bas",
        ["Master ESP"] = "ESP Principal",
        ["Master ESP Toggle"] = "Interrupteur Maitre ESP",
        ["Master Visuals & Chams"] = "Visuels Maitres et Chams",
        ["Max Range"] = "Portee Maximale",
        ["Max Soru Range"] = "Portee Maximale du Soru",
        ["Melee"] = "Corps a corps",
        ["Misc"] = "Divers",
        ["Mouse"] = "Souris",
        ["Move smoothly through structures and physical obstacles"] = "Permet de traverser les structures et obstacles",
        ["Movement"] = "Mouvement",
        ["Movement & Agility (PvP Physics)"] = "Mouvement et Agilite (Physique PvP)",
        ["Multiplies dash distance for high-speed repositioning"] = "Multiplie la distance de dash pour un repositionnement rapide",
        ["Multiplies jump impulse for vertical escape and aerial combat"] = "Multiplie l impulsion de saut pour fuite verticale et combat",
        ["NPC Silent Aim"] = "Silent Aim sur PNJs",
        ["Nearest"] = "Le plus proche",
        ["Nearest Player"] = "Joueur le plus proche",
        ["Neon Rain Layer"] = "Pluie Cyber Neon",
        ["Next (›)"] = "Suivant (›)",
        ["Noclip Wallpass"] = "Noclip Passe-Muraille",
        ["None"] = "Aucun",
        ["Official Community & Discord"] = "Communaute Officielle et Discord",
        ["Orange"] = "Orange",
        ["Overhead Billboard"] = "Bandeau Superieur",
        ["PING"] = "LATENCE",
        ["PLAYERS"] = "JOUEURS",
        ["Pass through walls and objects"] = "Traverse les murs et les objets",
        ["Performance"] = "Performance",
        ["Performance & Network"] = "Performances et Reseau",
        ["Pink"] = "Rose",
        ["Player"] = "Joueur",
        ["Player 2D Boxes"] = "Boites 2D Joueurs",
        ["Player Bounty Tracker"] = "Prime du Joueur",
        ["Player Chams & Tracers"] = "Chams et Traceurs",
        ["Player Chams (Highlight)"] = "Chams Joueur (Surbrillance)",
        ["Player Health Status"] = "Sante des Joueurs",
        ["Player Level Display"] = "Niveau du Joueur",
        ["Player Names"] = "Noms des Joueurs",
        ["Player Profile"] = "Profil du Joueur",
        ["Player Profile & Account"] = "Profil Joueur et Compte",
        ["Player Radar Elements"] = "Elements du Radar Joueur",
        ["Player Silent Aim"] = "Silent Aim sur Joueurs",
        ["Player Tracer Color"] = "Couleur Ligne Joueur",
        ["Player Tracers"] = "Traceurs vers Joueurs",
        ["Portuguese"] = "Portugais",
        ["Prediction Amount"] = "Quantite de Prediction",
        ["Premium User  •  Active Session"] = "Utilisateur Premium  •  Session Active",
        ["Preset: Crimson Slayer"] = "Style: Tueur Cramoisi",
        ["Preset: Cyberpunk Violet"] = "Style: Violet Cyberpunk",
        ["Preset: Emerald Forest"] = "Style: Foret Emeraude",
        ["Preset: Shorekeeper Cyan"] = "Style: Shorekeeper Cyan",
        ["Previous (‹)"] = "Precedent (‹)",
        ["Purple"] = "Violet",
        ["PvP"] = "PvP",
        ["PvP Tech, Camlock & Universal Keybinds"] = "Technologie PvP, Camlock et Raccourcis",
        ["Q"] = "Q",
        ["Quick Actions"] = "Actions Rapides",
        ["R"] = "R",
        ["RACE"] = "RACE",
        ["Radar Elements"] = "Elements du Radar",
        ["Rainbow"] = "Arc-en-ciel",
        ["Rainbow Chroma Speed"] = "Vitesse Chroma Arc-en-ciel",
        ["Raindrop Density"] = "Densite des Gouttes",
        ["Random (Shuffle)"] = "Aleatoire",
        ["Rapid fire M1 gun shots"] = "Tirs M1 ultra rapides",
        ["Rapid melee and weapon strikes"] = "Frappes rapides au corps a corps",
        ["Rapid weapon hit bursts"] = "Attaques continues a l'arme",
        ["Rapid-fire gun attack loop targeting nearest combatant"] = "Attaque rapide a l arme a feu sur la cible la plus proche",
        ["Red"] = "Rouge",
        ["Redirect skills toward enemy players"] = "Redirige les competences vers les joueurs",
        ["Redirect skills toward mobs and bosses"] = "Redirige les competences vers les monstres et boss",
        ["Redirects Flashstep teleport directly to enemy player"] = "Redirige la teleportation directement vers le joueur ennemi",
        ["Redirects skills and attacks towards enemy players"] = "Redirige les competences et attaques vers les joueurs ennemis",
        ["Redirects skills and attacks towards mobs and bosses"] = "Redirige les competences et attaques vers les monstres et boss",
        ["Rejoin Current Server"] = "Rejoindre le Serveur",
        ["Remove flashstep cooldown"] = "Supprime le temps de recharge du pas eclair",
        ["Removes cooldown delay and bypasses stamina limits"] = "Supprime le temps de recharge et limites d endurance",
        ["Renders hardware 3D Beams and 2D lines to target"] = "Genere des faisceaux 3D et lignes 2D vers la cible",
        ["Reset All Settings to Factory Defaults"] = "Reinitialiser aux Valeurs Usine",
        ["Reset Configuration Profile"] = "Reinitialiser la Configuration",
        ["Reset Config"] = "Reinitialiser Configuration",
        ["Configuration profile reset to defaults."] = "Profil de configuration reinitialise par defaut.",
        ["Reset Theme to Purple"] = "Reinitialiser le Theme en Violet",
        ["Sanguine Boost"] = "Boost Sanguin",
        ["Sanguine Boost Floating Widget"] = "Widget Flottant Sanguine Z",
        ["Sanguine Keybind"] = "Touche Sanguine",
        ["Save Configuration Profile"] = "Sauvegarder la Configuration",
        ["Save Config"] = "Sauvegarder Configuration",
        ["Selected Player"] = "Joueur selectionne",
        ["Server Hop (Fast)"] = "Changer de Serveur (Rapide)",
        ["Show FOV Circle"] = "Afficher Cercle FOV",
        ["Show Tracers"] = "Afficher Lignes de Traceurs",
        ["Shows distance measurement in studs below player feet"] = "Affiche la distance en studs sous les pieds",
        ["Shows player rank and numerical level tag"] = "Affiche le rang et le niveau numerique du joueur",
        ["Shows weapon, sword, fruit or gun held by the player"] = "Affiche l'arme, epee, fruit ou pistolet tenu",
        ["Silent Aim"] = "Visee Silencieuse",
        ["Skill Blacklist"] = "Liste Noire de Competences",
        ["Skill Delay"] = "Delai de Competence",
        ["Skill Redirection Blacklist"] = "Liste Noire de Competences",
        ["Soru"] = "Soru",
        ["Soru Aimbot"] = "Soru Aimbot",
        ["Soru Combat Aimbot"] = "Aimbot Soru",
        ["Soru Flashstep Engine"] = "Moteur Soru Flashstep",
        ["Soru Skill Combo"] = "Combo de Competences Soru",
        ["Soru Skill Combo Automation"] = "Auto Combo de Competences Soru",
        ["Soru Target Mode"] = "Mode Cible Soru",
        ["Spanish"] = "Espagnol",
        ["Spawns water surface collider allowing sprint across oceans"] = "Cree une plateforme aquatique pour courir sur les oceans",
        ["Speed up player movement"] = "Augmente la vitesse du joueur",
        ["Standard (100%)"] = "Standard (100%)",
        ["Subtle (50%)"] = "Subtil (50%)",
        ["Super Jump"] = "Super Saut",
        ["Super Jump Floating Widget"] = "Widget Flottant de Super Saut",
        ["Super Jump Force"] = "Force du Super Saut",
        ["Sword"] = "Epee",
        ["System Info"] = "Infos Systeme",
        ["T"] = "T",
        ["Target Hitbox"] = "Zone d'Impact",
        ["Target Player Selection"] = "Selection du Joueur Cible",
        ["Target Priority"] = "Priorite de Cible",
        ["Target Selection & Aim Mode"] = "Selection de Cible et Mode",
        ["Target Tracers"] = "Traceurs de Cible",
        ["Teleport soru directly to enemy"] = "Teleporte en soru directement vers l'ennemi",
        ["Theme Presets"] = "Styles Predefinis",
        ["Theme Reset"] = "Reinitialiser le Theme",
        ["Themes"] = "Themes",
        ["Toggle Rainbow Chroma Mode"] = "Mode Chroma Arc-en-ciel",
        ["Toggle animated falling cyber rain streaks"] = "Active la pluie cyber animee",
        ["Tracer Color"] = "Couleur de Ligne",
        ["Tracer Mode"] = "Mode de Ligne",
        ["Tracer Origin"] = "Origine de Ligne",
        ["Tracer Thickness"] = "Epaisseur de Ligne",
        ["Tracers"] = "Lignes de Traceurs",
        ["Trigger Super Jump"] = "Declencher Super Saut",
        ["Typography Font"] = "Police Typographique",
        ["Typography Studio"] = "Studio de Typographie",
        ["UPTIME"] = "DUREE",
        ["Ultra fast burst firing with CombatController validator"] = "Tir en rafale ultra rapide avec validateur CombatController",
        ["UpperTorso"] = "Torse Superieur",
        ["Use skill instantly after Soru"] = "Lance une competence immediatement apres le Soru",
        ["V"] = "V",
        ["Vietnamese"] = "Vietnamien",
        ["Visuals"] = "Visuels",
        ["Vitality & Energy Status"] = "Etat de Sante et Energie",
        ["Walk on Water"] = "Marcher sur l'Eau",
        ["Walk on ocean surface"] = "Marcher sur la surface de l'ocean",
        ["WalkSpeed Value"] = "Valeur de Vitesse",
        ["Wallpaper"] = "Fond d'ecran",
        ["Wallpapers"] = "Fonds d'ecran",
        ["White"] = "Blanc",
        ["World & Client Optimization"] = "Optimisation Monde et Client",
        ["X"] = "X",
        ["Yellow"] = "Jaune",
        ["Z"] = "Z",
        ["Z Sanguine Boost"] = "Boost Sanguine Z",
        ["B1 Hold Time (s)"] = "B1 Temps de Maintien (s)",
        ["B1 Mode"] = "B1 Mode",
        ["B1 Post Jumps"] = "B1 Sauts Posterieurs",
        ["B1 Skill Key"] = "B1 Touche",
        ["B1 Weapon"] = "B1 Arme",
        ["B2 Hold Time (s)"] = "B2 Temps de Maintien (s)",
        ["B2 Mode"] = "B2 Mode",
        ["B2 Post Jumps"] = "B2 Sauts Posterieurs",
        ["B2 Skill Key"] = "B2 Touche",
        ["B2 Weapon"] = "B2 Arme",
        ["B3 Hold Time (s)"] = "B3 Temps de Maintien (s)",
        ["B3 Mode"] = "B3 Mode",
        ["B3 Post Jumps"] = "B3 Sauts Posterieurs",
        ["B3 Skill Key"] = "B3 Touche",
        ["B3 Weapon"] = "B3 Arme",
        ["B4 Hold Time (s)"] = "B4 Temps de Maintien (s)",
        ["B4 Mode"] = "B4 Mode",
        ["B4 Post Jumps"] = "B4 Sauts Posterieurs",
        ["B4 Skill Key"] = "B4 Touche",
        ["B4 Weapon"] = "B4 Arme",
        ["B5 Hold Time (s)"] = "B5 Temps de Maintien (s)",
        ["B5 Mode"] = "B5 Mode",
        ["B5 Post Jumps"] = "B5 Sauts Posterieurs",
        ["B5 Skill Key"] = "B5 Touche",
        ["B5 Weapon"] = "B5 Arme",
        ["B6 Hold Time (s)"] = "B6 Temps de Maintien (s)",
        ["B6 Mode"] = "B6 Mode",
        ["B6 Post Jumps"] = "B6 Sauts Posterieurs",
        ["B6 Skill Key"] = "B6 Touche",
        ["B6 Weapon"] = "B6 Arme",
        ["Block 1 Enabled"] = "Bloc 1 Active",
        ["Block 2 Enabled"] = "Bloc 2 Active",
        ["Block 3 Enabled"] = "Bloc 3 Active",
        ["Block 4 Enabled"] = "Bloc 4 Active",
        ["Block 5 Enabled"] = "Bloc 5 Active",
        ["Block 6 Enabled"] = "Bloc 6 Active",
        ["Combo Sequence (6 Blocks)"] = "Sequence de Combo (6 Blocs)",
        ["Display real-time FPS and ping overlay top-left"] = "Affiche l'overlay FPS et ping en temps reel",
        ["Displays on-screen one-touch button to trigger combo"] = "Affiche un bouton a l'ecran pour lancer le combo",
        ["Do not target allied players"] = "Ne pas cibler les allies",
        ["Do not target players inside safe zones"] = "Ne pas cibler les joueurs en zone sure",
        ["Do not target players with PvP disabled"] = "Ne pas cibler les joueurs sans PvP",
        ["Enable step 1 in combo"] = "Activer l'etape 1 du combo",
        ["Enable step 2 in combo"] = "Activer l'etape 2 du combo",
        ["Enable step 3 in combo"] = "Activer l'etape 3 du combo",
        ["Enable step 4 in combo"] = "Activer l'etape 4 du combo",
        ["Enable step 5 in combo"] = "Activer l'etape 5 du combo",
        ["Enable step 6 in combo"] = "Activer l'etape 6 du combo",
        ["Enables keyboard trigger and loop execution"] = "Active le declencheur clavier et l'execution en boucle",
        ["Fly"] = "Voler",
        ["Fly Speed"] = "Vitesse de Vol",
        ["Glide freely through the air"] = "Glissez librement dans les airs",
        ["Ignore Allies"] = "Ignorer les Allies",
        ["Ignore PvP Off"] = "Ignorer PvP Desactive",
        ["Ignore Safe Zone"] = "Ignorer Zone Sure",
        ["Loop Sequence"] = "Sequence en Boucle",
        ["Macro"] = "Macro",
        ["Macro Controller"] = "Controleur de Macro",
        ["Macro Enabled"] = "Macro Active",
        ["Macro Floating Widget"] = "Widget Flottant de Macro",
        ["Macro Slot"] = "Emplacement Macro",
        ["Repeat sequence continuously until stopped"] = "Repete la sequence en boucle jusqu'a l'arret",
        ["Show FPS & Ping"] = "Afficher FPS et Ping",
        ["Start Combo Sequence"] = "Demarrer Sequence de Combo",
        ["Stop Combo Sequence"] = "Arreter Sequence de Combo",
        ["Trigger Key (PC)"] = "Touche d'Activation (PC)",
        ["YouTube & External Players"] = "Lecteurs Externes et YouTube",
        ["Launch Universal YouTube Player"] = "Lancez le Lecteur YouTube Universel",
        ["Launch Audio Library Player"] = "Lancer la Bibliothèque Audio",
        ["Roblox Audio Player"] = "Lecteur Audio Roblox",
    },
    ["Vietnamese"] = {
        -- Kit One Shot & Visuals / Buddha Rainbow
        ["Kit One Shot"] = "Kit One Shot",
        ["Instant 18k+ Fruit M1 Void Remote attack"] = "Đòn đánh M1 hư vô từ xa 18k+ tức thì",
        ["Instant 18k+ Fruit M1 Void Remote attack (Activates Fruit Fast Attack)"] = "Đòn đánh M1 hư vô từ xa 18k+ tức thì",
        ["M1 Delay"] = "Tốc độ M1",
        ["Kit One Shot Floating Widget"] = "Nút Nổi Kit One Shot",
        ["Movable on-screen toggle for Kit One Shot"] = "Nút nổi di chuyển trên màn hình cho Kit One Shot",
        ["Saishi Sword One Shot"] = "Saishi Sword One Shot",
        ["Teleport combo with velocity reset (Mobile widget & Z/F keys)"] = "Combo dich chuyen dat lai van toc (Widget di dong va phim Z/F)",
        ["Silent Aim Lock"] = "Khoá Mục Tiêu Silent Aim",
        ["Silent Aim Lock Floating Widget"] = "Nút Nổi Silent Aim Lock",
        ["Movable on-screen toggle for Silent Aim Lock"] = "Nút nổi di chuyển trên màn hình cho Silent Aim Lock",
        ["Silent Aim Player Lock"] = "Khoa Muc Tieu Nguoi Choi (Silent Aim)",
        ["Lock onto targeted player without moving camera"] = "Khoa vao nguoi choi dang nham ma khong di chuyen camera",
        ["Lock Current Target"] = "Khoa Muc Tieu Hien Tai",
        ["Unlock Target"] = "Mo Khoa Muc Tieu",
        ["Fruit Fast Attack Floating Widget"] = "Nút Nổi Fruit Fast Attack",
        ["X-Ray Wall Vision"] = "X-Ray Xuyên Tường",
        ["X-Ray Vision"] = "Tầm Nhìn X-Ray",
        ["Makes map walls and objects transparent to spot players and chests easily"] = "Làm trong suốt tường và vật thể để dễ thấy người chơi và rương",
        ["Buddha Rainbow Circle"] = "Vòng Buddha Cầu Vồng",
        ["Recolors your Buddha circle with animated rainbow gradient (Client-only)"] = "Đổi màu vòng Buddha hiệu ứng cầu vồng chuyển động (Chỉ máy bạn)",
        ["Only My Buddha Circle"] = "Chỉ Vòng Buddha Của Tôi",
        ["Only affects your own character instead of all nearby Buddha users"] = "Chỉ tác động lên bản thân thay vì mọi người chơi Buddha xung quanh",
        ["Delete Ghost Ship (Sea 2)"] = "Xoa Tau Ma (Bien 2)",
        ["Delete Ghost Ship"] = "Xoa Tau Ma",
        ["Removes interior walls and objects from Cursed Ship in Sea 2"] = "Xoa tuong va vat the ben trong Tau Nguyen Rua o Bien 2",
        ["Lock Widgets & Toggles"] = "Khoa Widget va Dieu khien",
        ["Lock floating widgets and controls from moving"] = "Khoa khong cho di chuyen widget va nut bam",
        ["Active Keybinds"] = "Phim Tat Hoat Dong",
        ["No keybinds configured. Click '+' to add one."] = "Chua co phim tat nao. Bam '+' de them mot phim tat.",
        ["+ Add Keybind"] = "+ Them Phim Tat",
        ["Clear All Keybinds"] = "Xoa Tat Ca Phim Tat",
        ["Select a feature to bind"] = "Chon mot tinh nang de gan phim",
        ["Click a feature then press any key:"] = "Nhan vao mot tinh nang roi bam phim muon gan:",
        ["PRESS ANY KEY..."] = "BAM PHIM BAT KY...",
        ["No buttons or toggles available to bind."] = "Khong co nut hoac toggle nao de gan phim.",
        ["bound to"] = "gan vao",
        ["Mode changed to"] = "Che do doi thanh",
        ["All keybinds were cleared."] = "Tat ca phim tat da duoc xoa.",
        ["Widget lock:"] = "Khoa widget:",
        ["Keybinds"] = "Phim tat",
        ["General"] = "Chung",
        ["Enabled"] = "Bat",
        ["Disabled"] = "Tat",
        -- Waifu / FFlags / Performance
        ["Waifu AI"] = "Waifu AI",
        ["Waifu AI Companion"] = "Bạn Đồng Hành Waifu AI",
        ["Activar Waifu"] = "Bật Waifu",
        ["Hablar con Waifu"] = "Nói chuyện với Waifu",
        ["Bailar / Hacer Animación"] = "Nhảy / Làm Động Tác",
        ["Dar Ánimos / Frase Kawaii"] = "Động viên (Kawaii)",
        ["Alerta de Peligro / Combate"] = "Cảnh Báo Nguy Hiểm",
        ["Ajustes de Waifu"] = "Cài Đặt Waifu",
        ["Reacciones de Combate & Peligro"] = "Phản Ứng Chiến Đấu & Nguy Hiểm",
        ["Seguir Cursor / Touch"] = "Đi Theo Chuột / Chạm",
        ["Pensamientos Automáticos"] = "Suy Nghĩ Tự Động",
        ["Color Adaptable al Tema"] = "Màu Theo Giao Diện",
        ["Tamaño de Waifu"] = "Kích Thước Waifu",
        ["FFlags"] = "FFlags",
        ["Reset to Defaults"] = "Đặt Lại Mặc Định",
        ["Configure Discord notification webhook and target trade recipient to transfer fruits automatically."] = "Cấu hình webhook Discord và người nhận để tự động chuyển trái ác quỷ.",
        ["Fruit Fast Attack"] = "Fruit Fast Attack",
        ["Fast Attack supporting Devil Fruits (By Darling)"] = "Fast Attack hỗ trợ Trái Ác Quỷ (Bởi Darling)",
        ["Apply Ultimate Potato (120 FPS + Max Performance)"] = "Bật Siêu Potato (120 FPS + Tối Đa Hiệu Năng)",
        ["Ultimate Performance (1-Tap Potato)"] = "Hiệu Năng Tối Đa (Potato 1 Chạm)",
        ["FFlags JSON Editor"] = "Trình Chỉnh Sửa FFlags JSON",
        ["Apply FFlags JSON"] = "Áp Dụng FFlags JSON",
        ["One-tap master optimization: 120 FPS cap, low geometry, smooth plastic textures, shadow removal, and particle clearing."] = "Tối ưu hóa tổng thể 1 chạm: giới hạn 120 FPS, giảm chi tiết hình học, texture nhựa mịn, xóa bóng và dọn sạch hạt hiệu ứng.",
        ["FFlags Editor Personalizado"] = "Trình Chỉnh Sửa FFlags Tùy Chỉnh",
        ["Pegar FFlags JSON"] = "Dán FFlags JSON",
        ["Aplicar FFlags"] = "Áp Dụng FFlags",
        ["Limpiar Editor"] = "Xóa Trình Chỉnh Sửa",
        ["Auto Aplicar FFlags al Iniciar"] = "Tự Động Áp Dụng FFlags Khi Khởi Động",
        ["Modo Patata (Potato FFlags)"] = "Chế Độ Khoai Tây (Potato FFlags)",
        ["Cargar FFlags Potato en Editor"] = "Tải FFlags Khoai Tây",
        ["Performance Presets"] = "Cấu Hình Hiệu Năng Có Sẵn",
        ["Load Pro Preset"] = "Tải Cấu Hình Pro",
        ["Load Android Preset"] = "Tải Cấu Hình Android",
        ["Apply Pro Preset"] = "Áp Dụng Cấu Hình Pro",
        ["Load Potato Preset"] = "Tải Cấu Hình Khoai Tây",
        ["FFlags Editor"] = "Trình Chỉnh Sửa FFlags",
        ["Player Management"] = "Quan ly Nguoi choi",
        ["Search Player..."] = "Tim kiem Nguoi choi...",
        ["Refresh Player List"] = "Lam moi danh sach",
        ["Blacklist"] = "Danh sach den",
        ["Blacklisted"] = "Da vao danh sach den",
        ["Spectate"] = "Theo doi",
        ["Spectating"] = "Dang theo doi",
        ["Stop Spectating"] = "Dung theo doi",
        ["Teleport to Player"] = "Dich chuyen den Nguoi choi",
        ["Total Players"] = "Tong so nguoi choi",
        ["Auto Dungeon Engine"] = "Dong co Auto Dungeon",
        ["Start Auto Dungeon"] = "Bat dau Auto Dungeon",
        ["Selected Weapon"] = "Vu khi da chon",
        ["Sword"] = "Kiem",
        ["Melee"] = "Can chien",
        ["Blox Fruit"] = "Trai ac quy",
        ["Attack Height"] = "Do cao tan cong",
        ["Auto Pass Room"] = "Tu dong qua phong",
        ["Void M1 Engine"] = "Dong co Void M1",
        ["Enable Void M1"] = "Bat Void M1",
        ["Void Only Boss Rooms"] = "Void chi phong Boss",
        ["Void Interval (s)"] = "Khoang cach Void (giay)",
        ["Dungeon Status & Utilities"] = "Trang thai & Tien ich Dungeon",
        ["Auto Load Dungeon"] = "Tu dong tai Dungeon",
        ["Current Room"] = "Phong hien tai",
        ["Boss Status"] = "Trang thai Boss",
        ["Island Teleport"] = "Dich chuyen Dao",
        ["Select Sea"] = "Chon Bien",
        ["Sea 1"] = "Bien 1",
        ["Sea 2"] = "Bien 2",
        ["Sea 3"] = "Bien 3",
        ["Target Island"] = "Dao muc tieu",
        ["Tween Speed"] = "Toc do Tween",
        ["Travel Altitude"] = "Do cao di chuyen",
        ["Noclip during Tween"] = "Di xuyen tuong khi Tween",
        ["Start Teleport"] = "Bat dau Dich chuyen",
        ["Stop Teleport"] = "Dung Dich chuyen",
        ["Controls Layout Editor"] = "Trinh chinh sua bo tri",
        ["Unlock Drag (Edit HUD)"] = "Mo khoa keo (Sua HUD)",
        ["Controls Global Scale"] = "Ty le tong the dieu khien",
        ["Save Custom Layout"] = "Luu bo tri",
        ["Reset Default Layout"] = "Dat lai bo tri mac dinh",
        ["HUD Overlays"] = "Lop phu HUD",
        ["Performance Watermark"] = "Chi so hieu nang",
        ["Custom Crosshair"] = "Tam ngam tuy chinh",
        ["Weapon Skins"] = "Skin Vu khi",
        ["Select Weapon Skin"] = "Chon Skin Vu khi",
        ["Apply Weapon Skin"] = "Ap dung Skin Vu khi",
        ["Reset Weapon Skin"] = "Dat lai Skin Vu khi",
        ["Haki & Aura Customization"] = "Tuy chinh Haki va Hao quang",
        ["Haki Color"] = "Mau Haki",
        ["Rainbow Haki"] = "Haki cau vong",
        ["Custom Trail VFX"] = "Hieu ung vet chem tuy chinh",
        ["Music Player"] = "Trinh phat Nhac",
        ["Genre / Category"] = "The loai / Danh muc",
        ["Track Preset"] = "Ban nhac co san",
        ["Custom Sound ID"] = "ID Am thanh tuy chinh",
        ["Volume"] = "Am luong",
        ["Pitch / Speed"] = "Cao do / Toc do",
        ["Loop Track"] = "Lap lai ban nhac",
        ["Show Top Music Bar"] = "Hien thanh nhac phia tren",
        ["Play"] = "Phat",
        ["Pause"] = "Tam dung",
        ["Resume"] = "Tiep tuc",
        ["Stop"] = "Dung",
        ["Cinematic Animations"] = "Hoat anh Dien anh",
        ["Select Animation"] = "Chon Hoat anh",
        ["Hide Accessories & Weapons"] = "An Phu kien va Vu khi",
        ["Play Animation"] = "Chay Hoat anh",
        ["Stop Animation"] = "Dung Hoat anh",
        ["Pure White"] = "Trang Tinh Khiet",
        ["Crimson Red"] = "Do Tham",
        ["Midnight Purple"] = "Tim Dem",
        ["Electric Blue"] = "Xanh Lam Tia Chop",
        ["Emerald Green"] = "Xanh Luc Bao",
        ["Golden Sun"] = "Vang Mat Troi",
        ["Default"] = "Mac dinh",
        ["None"] = "Khong co",
        ["180"] = "180",
        ["2D Boxes"] = "Khung 2D",
        ["2D Line"] = "Duong 2D",
        ["360"] = "360",
        ["3D Beam"] = "Tia 3D",
        ["Accent Color & Theme Studio"] = "Tuy chinh mau sac va Chu de",
        ["Account & Player Statistics"] = "Thong ke Nguoi choi",
        ["Aesthetic Studio Presets"] = "Mau giao dien co san",
        ["Aim Mode"] = "Che do ngam",
        ["Aimbot"] = "Aimbot",
        ["Allows continuous mid-air jumping without cooldown"] = "Cho phep nhay lien tuc tren khong khong hoi chieu",
        ["Anti-Lava Damage"] = "Chong sat thuong dung nham",
        ["Anti-Lava Immunity"] = "Mien nhiem dung nham",
        ["Apply Fast FFlags"] = "Ap dung toi uu FFlags",
        ["Apply Wallpaper"] = "Ap dung hinh nen",
        ["Atmosphere Wallpaper"] = "Hinh nen Khong gian",
        ["Atmosphere Wallpaper Presets (24 Styles)"] = "Hinh nen khong gian (24 Kieu)",
        ["Auto Buso Haki"] = "Tu dong bat Haki Vu Trang",
        ["Auto Combat"] = "Chien dau tu dong",
        ["Auto Race V3"] = "Tu dong bat Toc V3",
        ["Auto Race V4"] = "Tu dong bat Toc V4",
        ["Auto Skill Combo"] = "Tu dong Combo ky nang",
        ["Auto Skill on Soru"] = "Tu dong dung chieu khi Soru",
        ["Automatically activates Buso Armament Haki (No Ken)"] = "Tu dong bat Buso Haki vu trang (khong bat Ken)",
        ["Automatically casts Race V3 ability in combat"] = "Tu dong dung ky nang Toc V3 trong chien dau",
        ["Automatically triggers Race Awakening V4 when gauge is filled"] = "Tu dong thuc tinh Toc V4 khi thanh nang luong day",
        ["B"] = "B",
        ["BELI"] = "TIEN BELI",
        ["BOUNTY"] = "TIEN THUONG",
        ["Background Dimming (%)"] = "Do toi nen (%)",
        ["Balanced (65%)"] = "Can bang (65%)",
        ["Blue"] = "Xanh duong",
        ["Both"] = "Ca hai",
        ["Bottom"] = "Duoi cung",
        ["Bypasses walkspeed reset with direct physical impulse"] = "Bo qua dat lai toc do chay bang xung luc vat ly truc tiep",
        ["C"] = "C",
        ["Calculates lead vector based on enemy velocity and ping"] = "Tinh toan huong don dua tren toc do va ping",
        ["Camera FOV"] = "FOV goc nhin",
        ["Camlock"] = "Khoa goc nhin",
        ["Camlock (Combat Camera)"] = "Camlock (Camera chien dau)",
        ["Camlock Floating Widget"] = "Nut noi Camlock",
        ["Camlock Keybind"] = "Phim tat Camlock",
        ["Caps client to 22 FPS during Sanguine Z cooldown for physics boost"] = "Gioi han 22 FPS trong hoi chieu Sanguine Z de day vat ly",
        ["Cast Race V3 when in combat"] = "Kich hoat Toc V3 khi giao tranh",
        ["Cast Race V4 when gauge is full"] = "Kich hoat Toc V4 khi day thanh no",
        ["Center"] = "Trung tam",
        ["Chams & Tracers"] = "Chams va Dan huong",
        ["Chams Highlight Color"] = "Mau Chams",
        ["Clear / Dark Glass"] = "Xoa / Kinh toi mau",
        ["Combat Passives & Auto Skills"] = "Noi tai chien dau va Tu dong ky nang",
        ["Combat PvP Status"] = "Trang thai giao tranh PvP",
        ["Combat Targeting & Silent Aim"] = "Khoa muc tieu va Silent Aim",
        ["Combat Tech"] = "Ky thuat chien dau",
        ["Combo Key"] = "Phim tat Combo",
        ["Combo Weapon"] = "Vu khi Combo",
        ["Community"] = "Cong dong",
        ["Compact (80%)"] = "Gon gang (80%)",
        ["Config"] = "Cau hinh",
        ["Configuration Profiles"] = "Cau hinh da luu",
        ["Configuration Reset"] = "Dat lai cau hinh",
        ["Copy Discord Invite Link"] = "Sao chep lien ket Discord",
        ["Copy Server JobId"] = "Sao chep JobId may chu",
        ["Credits"] = "Tac gia",
        ["Crystal (80%)"] = "Trong suot (80%)",
        ["Custom Dash Length"] = "Khoang cach luot",
        ["Custom WalkSpeed"] = "Toc do chay tuy chon",
        ["Custom Wallpaper"] = "Hinh nen tuy chon",
        ["Custom Wallpaper Studio"] = "Tuy chinh hinh nen rieng",
        ["Cyan"] = "Xanh lo",
        ["Dash Distance"] = "Khoang cach luot",
        ["Destroys environmental lava kill zones and damage parts"] = "Pha huy cac vung dung nham gay sat thuong trong moi truong",
        ["Detects safe zone and in-combat status indicators"] = "Phat hien khu vuc an toan va trang thai chien dau",
        ["Developer & Content Creator"] = "Nha phat trien va Sang tao noi dung",
        ["Development Team & Content Creators"] = "Doi ngu phat trien va Sang tao",
        ["Devil Fruit Tracker"] = "Dinh vi trai ac quy",
        ["Direct Wallpaper"] = "Hinh nen truc tiep",
        ["Disable All Visuals"] = "Tat tat ca hien thi",
        ["Display aim boundary circle"] = "Hien thi vong tron gioi han tam ngam",
        ["Displays formatted usernames above character heads"] = "Hien thi ten tren dau nhan vat",
        ["Displays live gradient health bars and HP percentage"] = "Hien thi thanh mau va phan tram mau",
        ["Displays movable on-screen JUMP button for touch"] = "Hien thi nut NHAY di dong tren man hinh cho cam ung",
        ["Displays movable on-screen action button for Sanguine Z"] = "Hien thi nut noi hanh dong cho chieu Sanguine Z",
        ["Displays movable on-screen button to toggle camera lock"] = "Hien thi nut di dong tren man hinh de khoa camera",
        ["Displays movable on-screen toggle for Dragon Gun M1"] = "Hien thi nut chuyen di dong tren man hinh cho Dragon Gun M1",
        ["Displays movable on-screen toggle for camera lock"] = "Hien thi nut noi di chuyen duoc de bat tat khoa camera",
        ["Displays player bounty or honor value in millions"] = "Hien thi tien truy na hoac danh du theo trieu",
        ["Displays targeting circle boundary on screen"] = "Hien thi vong tron ngam muc tieu tren man hinh",
        ["Distance Indicator"] = "Khoang cach",
        ["Dragon Gun M1"] = "Dragon Gun M1",
        ["Dragon Gun M1 Floating Widget"] = "Tien ich noi Dragon Gun M1",
        ["Draws dynamic bounding boxes around enemy players"] = "Ve khung bao quanh nguoi choi dich",
        ["Draws line from bottom of screen to tracked players"] = "Ve duong dan tu duoi man hinh den muc tieu",
        ["E"] = "E",
        ["ESP Style"] = "Kieu ESP",
        ["ESP Text Font Size"] = "Co chu ESP",
        ["ESP Visuals"] = "Hien thi ESP",
        ["Enable All Visuals"] = "Bat tat ca hien thi",
        ["Enable Target Prediction"] = "Bat doan huong muc tieu",
        ["Enable player visual highlights"] = "Bat lam noi bat nguoi choi",
        ["Enables custom movement speed multiplier"] = "Bat he so nhan toc do di chuyen tuy chinh",
        ["Enables high-performance player visual tracking"] = "Bat theo doi nguoi choi hieu nang cao",
        ["English"] = "English",
        ["Equipped Tool / Weapon"] = "Vu khi trang bi",
        ["Equips weapon and casts chosen skill upon Soru animation"] = "Trang bi vu khi va tung chieu ngay khi dung Soru",
        ["Esp"] = "Hien thi",
        ["Executes rapid melee, sword, and fruit attack bursts"] = "Thuc hien chuoi danh cuc nhanh cho can chien, kiem va trai",
        ["Executes rapid primary attacks on all nearby enemies"] = "Thuc hien danh don co ban cuc nhanh vao moi ke dich xung quanh",
        ["F"] = "F",
        ["FACTION"] = "PHE PHAI",
        ["FOV"] = "FOV",
        ["FOV Color"] = "Mau vong FOV",
        ["FOV Position"] = "Vi tri tam FOV",
        ["FOV Radius"] = "Ban kinh FOV",
        ["FOV Thickness"] = "Do day vong FOV",
        ["FPS"] = "KHUNG HINH",
        ["FRUIT"] = "TRAI AC QUY",
        ["Fast Attack"] = "Tan cong nhanh",
        ["Fast Attack (Melee, Sword, Fruit)"] = "Tan cong nhanh (Can chien, Kiem, Trai)",
        ["Fast Flags"] = "Toi uu hoa nhanh",
        ["FFlags 1 (FPS Booster)"] = "FFlags 1 (Tang cuong FPS)",
        ["120 FPS cap, smooth plastic textures, removes atmosphere fog, hides debris"] = "Gioi han 120 FPS, ket cau nhua min, xoa suong mu va an manh vo",
        ["No Animations"] = "Khong Hoat Anh",
        ["Stops non-attack animations to fix sideways bug and character freezes"] = "Dung cac hoat anh khong tan cong de sua loi bi dung hinh",
        ["Fast Flags & Engine Tuning"] = "Fast Flags va Toi uu he thong",
        ["Field of View"] = "Vung tam nhin",
        ["Field of View (FOV Customization)"] = "Goc nhin (Tuy chinh FOV)",
        ["Forward velocity boost"] = "Day van toc ve phia truoc",
        ["French"] = "Tieng Phap",
        ["Fruit"] = "Trai quy",
        ["Game Stats"] = "Thong so tro choi",
        ["Glass Interface & Visual Effects"] = "Hieu ung kinh va Giao dien",
        ["Glass Transparency"] = "Do trong suot cua kinh",
        ["Green"] = "Xanh la",
        ["Gun"] = "Sung",
        ["Gun Aura (Dragon Gun M1)"] = "Gun Aura (Dragon Gun M1)",
        ["Head"] = "Dau",
        ["High jump leap"] = "Cu nhay vao khong trung",
        ["High-distance forward velocity boost with keybind Z"] = "Tang toc tien ve phia truoc khoang cach xa bang phim Z",
        ["Home"] = "Trang chu",
        ["HumanoidRootPart"] = "HumanoidRootPart",
        ["Identifies equipped Devil Fruit power (Kitsune, Portal, etc.)"] = "Nhan dien trai ac quy dang dung",
        ["Illuminates full player character models through walls"] = "Chieu sang mo hinh nguoi choi qua tuong",
        ["Immunity to lava damage"] = "Mien nhiem sat thuong nham thach",
        ["In-Game Attributes"] = "Chi so trong Game",
        ["Increase dash distance"] = "Tang khoang cach luot",
        ["Infinite Jump"] = "Nhay vo han",
        ["Infinite Soru"] = "Soru vo han",
        ["Interface Effects"] = "Hieu ung giao dien",
        ["Interface Language"] = "Ngon ngu giao dien",
        ["Interface Scale"] = "Ti le giao dien",
        ["Jump continuously in mid-air"] = "Nhay lien tuc tren khong",
        ["Keep Armament Haki active"] = "Tu dong kich hoat Haki Vu Trang",
        ["LEVEL"] = "CAP DO",
        ["Language"] = "Ngon ngu",
        ["Language & Localization"] = "Ngon ngu va Ban dia hoa",
        ["Large (120%)"] = "Lon (120%)",
        ["Load Configuration Profile"] = "Tai cau hinh",
        ["Load Config"] = "Tai Cau hinh",
        ["Lock camera onto enemy"] = "Khoa camera vao muc tieu",
        ["Locks camera perspective directly onto focused enemy player"] = "Khoa goc nhin camera truc tiep vao nguoi choi doi thu",
        ["Looking At Me"] = "Dang nhin toi",
        ["Low HP"] = "Mau thap nhat",
        ["Master ESP"] = "Tong the ESP",
        ["Master ESP Toggle"] = "Bat tat ESP chinh",
        ["Master Visuals & Chams"] = "Hinh anh chinh va Chams",
        ["Max Range"] = "Tam xa toi da",
        ["Max Soru Range"] = "Tam xa Soru toi da",
        ["Melee"] = "Can chien",
        ["Misc"] = "Khac",
        ["Mouse"] = "Con tro chuot",
        ["Move smoothly through structures and physical obstacles"] = "Di chuyen muot ma qua cac cong trinh va vat can",
        ["Movement"] = "Di chuyen",
        ["Movement & Agility (PvP Physics)"] = "Di chuyen va Linh hoat (Vat ly PvP)",
        ["Multiplies dash distance for high-speed repositioning"] = "Nhan khoang cach luot de thay doi vi tri nhanh chong",
        ["Multiplies jump impulse for vertical escape and aerial combat"] = "Nhan luc nhay de thoat hiem tren cao va khong chien",
        ["NPC Silent Aim"] = "Silent Aim NPC",
        ["Nearest"] = "Gan nhat",
        ["Nearest Player"] = "Nguoi choi gan nhat",
        ["Neon Rain Layer"] = "Hieu ung mua Neon Cyber",
        ["Next (›)"] = "Tiep theo (›)",
        ["Noclip Wallpass"] = "Noclip di xuyen tuong",
        ["None"] = "Khong co",
        ["Official Community & Discord"] = "Cong dong chinh thuc va Discord",
        ["Orange"] = "Cam",
        ["Overhead Billboard"] = "Bang ten tren dau",
        ["PING"] = "DO TRE",
        ["PLAYERS"] = "NGUOI CHOI",
        ["Pass through walls and objects"] = "Di xuyen qua tuong va vat the",
        ["Performance"] = "Hieu nang",
        ["Performance & Network"] = "Hieu nang va Mang",
        ["Pink"] = "Hong",
        ["Player"] = "Nguoi choi",
        ["Player 2D Boxes"] = "Khung 2D nguoi choi",
        ["Player Bounty Tracker"] = "Tien thuong nguoi choi",
        ["Player Chams & Tracers"] = "Chams va Duong ke nguoi choi",
        ["Player Chams (Highlight)"] = "Chams nguoi choi (Highlight)",
        ["Player Health Status"] = "Mau nguoi choi",
        ["Player Level Display"] = "Cap do nguoi choi",
        ["Player Names"] = "Ten nguoi choi",
        ["Player Profile"] = "Ho so nguoi choi",
        ["Player Profile & Account"] = "Ho so nguoi choi va Tai khoan",
        ["Player Radar Elements"] = "Phan tu radar nguoi choi",
        ["Player Silent Aim"] = "Silent Aim nguoi choi",
        ["Player Tracer Color"] = "Mau duong dan nguoi choi",
        ["Player Tracers"] = "Duong dan den nguoi choi",
        ["Portuguese"] = "Tieng Bo Dao Nha",
        ["Prediction Amount"] = "Muc doan truoc",
        ["Premium User  •  Active Session"] = "Nguoi dung Premium  •  Phien hoat dong",
        ["Preset: Crimson Slayer"] = "Mau: Sat Thu Do Tham",
        ["Preset: Cyberpunk Violet"] = "Mau: Tim Cyberpunk",
        ["Preset: Emerald Forest"] = "Mau: Rung Ngoc Luc Bao",
        ["Preset: Shorekeeper Cyan"] = "Mau: Shorekeeper Xanh Lo",
        ["Previous (‹)"] = "Truoc do (‹)",
        ["Purple"] = "Tim",
        ["PvP"] = "PvP",
        ["PvP Tech, Camlock & Universal Keybinds"] = "Cong nghe PvP, Camlock va Phim tat",
        ["Q"] = "Q",
        ["Quick Actions"] = "Hanh dong nhanh",
        ["R"] = "R",
        ["RACE"] = "CHUNG TOC",
        ["Radar Elements"] = "Thanh phan Radar",
        ["Rainbow"] = "Cau vong",
        ["Rainbow Chroma Speed"] = "Toc do cau vong Chroma",
        ["Raindrop Density"] = "Mat do hat mua",
        ["Random (Shuffle)"] = "Ngau nhien",
        ["Rapid fire M1 gun shots"] = "Ban dan M1 sieu toc",
        ["Rapid melee and weapon strikes"] = "Tan cong can chien toc do cao",
        ["Rapid weapon hit bursts"] = "Danh lien hoan vu khi",
        ["Rapid-fire gun attack loop targeting nearest combatant"] = "Vong lap ban sung toc do cao vao muc tieu gan nhat",
        ["Red"] = "Do",
        ["Redirect skills toward enemy players"] = "Chuyen huong chieu thuc toi nguoi choi",
        ["Redirect skills toward mobs and bosses"] = "Chuyen huong chieu thuc toi quai va trum",
        ["Redirects Flashstep teleport directly to enemy player"] = "Dich chuyen Soru truc tiep toi nguoi choi muc tieu",
        ["Redirects skills and attacks towards enemy players"] = "Dinh huong ky nang va don danh ve phia nguoi choi dich",
        ["Redirects skills and attacks towards mobs and bosses"] = "Dinh huong ky nang va don danh ve phia quai va trum",
        ["Rejoin Current Server"] = "Vao lai may chu hien tai",
        ["Remove flashstep cooldown"] = "Xoa thoi gian hoi chieu toc bien",
        ["Removes cooldown delay and bypasses stamina limits"] = "Xoa thoi gian hoi chieu va khong ton the luc",
        ["Renders hardware 3D Beams and 2D lines to target"] = "Ve tia 3D va duong 2D den muc tieu",
        ["Reset All Settings to Factory Defaults"] = "Khoi phuc mac dinh goc",
        ["Reset Configuration Profile"] = "Khoi phuc cau hinh goc",
        ["Reset Config"] = "Dat lai Cau hinh",
        ["Configuration profile reset to defaults."] = "Ho so cau hinh da duoc dat lai ve mac dinh.",
        ["Reset Theme to Purple"] = "Dat lai giao dien mau tim",
        ["Sanguine Boost"] = "Tang toc Sanguine",
        ["Sanguine Boost Floating Widget"] = "Nut noi Sanguine Z",
        ["Sanguine Keybind"] = "Phim tat Sanguine",
        ["Save Configuration Profile"] = "Luu cau hinh",
        ["Save Config"] = "Luu Cau hinh",
        ["Selected Player"] = "Nguoi choi da chon",
        ["Server Hop (Fast)"] = "Chuyen may chu (Nhanh)",
        ["Show FOV Circle"] = "Hien thi vong FOV",
        ["Show Tracers"] = "Hien thi duong dan huong",
        ["Shows distance measurement in studs below player feet"] = "Hien thi khoang cach bang studs duoi chan",
        ["Shows player rank and numerical level tag"] = "Hien thi thu hang va cap do nguoi choi",
        ["Shows weapon, sword, fruit or gun held by the player"] = "Hien thi vu khi, kiem, sung hoac trai dang cam",
        ["Silent Aim"] = "Ban tu dong",
        ["Skill Blacklist"] = "Danh sach ky nang chan",
        ["Skill Delay"] = "Do tre ky nang",
        ["Skill Redirection Blacklist"] = "Danh sach den ky nang",
        ["Soru"] = "Soru",
        ["Soru Aimbot"] = "Soru Aimbot",
        ["Soru Combat Aimbot"] = "Aimbot Soru",
        ["Soru Flashstep Engine"] = "Dong co Soru Flashstep",
        ["Soru Skill Combo"] = "Combo ky nang Soru",
        ["Soru Skill Combo Automation"] = "Tu dong Combo ky nang Soru",
        ["Soru Target Mode"] = "Che do muc tieu Soru",
        ["Spanish"] = "Tieng Tay Ban Nha",
        ["Spawns water surface collider allowing sprint across oceans"] = "Tao mat san nuoc cho phep chay tren bien",
        ["Speed up player movement"] = "Tang toc do di chuyen nguoi choi",
        ["Standard (100%)"] = "Tieu chuan (100%)",
        ["Subtle (50%)"] = "Tinh te (50%)",
        ["Super Jump"] = "Sieu nhay",
        ["Super Jump Floating Widget"] = "Tien ich noi Sieu Nhay",
        ["Super Jump Force"] = "Luc sieu nhay",
        ["Sword"] = "Kiem",
        ["System Info"] = "Thong tin he thong",
        ["T"] = "T",
        ["Target Hitbox"] = "Vung va cham muc tieu",
        ["Target Player Selection"] = "Chon nguoi choi muc tieu",
        ["Target Priority"] = "Uu tien muc tieu",
        ["Target Selection & Aim Mode"] = "Chon muc tieu va Che do ngam",
        ["Target Tracers"] = "Duong ke chi muc tieu",
        ["Teleport soru directly to enemy"] = "Dich chuyen soru thang vao ke thu",
        ["Theme Presets"] = "Mau giao dien san",
        ["Theme Reset"] = "Dat lai giao dien",
        ["Themes"] = "Giao dien",
        ["Toggle Rainbow Chroma Mode"] = "Bat che do mau cau vong Chroma",
        ["Toggle animated falling cyber rain streaks"] = "Bat tat hieu ung mua cong nghe chuyen dong",
        ["Tracer Color"] = "Mau duong dan huong",
        ["Tracer Mode"] = "Che do duong dan huong",
        ["Tracer Origin"] = "Diem bat dau duong dan",
        ["Tracer Thickness"] = "Do day duong dan huong",
        ["Tracers"] = "Duong dan huong",
        ["Trigger Super Jump"] = "Kich hoat Sieu nhay",
        ["Typography Font"] = "Kieu phong chu",
        ["Typography Studio"] = "Phong chu hien thi",
        ["UPTIME"] = "THOI GIAN CHAY",
        ["Ultra fast burst firing with CombatController validator"] = "Ban lien thanh sieu nhanh voi trinh xac thuc CombatController",
        ["UpperTorso"] = "Than tren",
        ["Use skill instantly after Soru"] = "Tung ky nang ngay lap tuc sau Soru",
        ["V"] = "V",
        ["Vietnamese"] = "Tieng Viet",
        ["Visuals"] = "Hien thi",
        ["Vitality & Energy Status"] = "Trang thai Mau va Nang luong",
        ["Walk on Water"] = "Di tren mat nuoc",
        ["Walk on ocean surface"] = "Di chuyen tren mat bien",
        ["WalkSpeed Value"] = "Gia tri toc do",
        ["Wallpaper"] = "Hinh nen",
        ["Wallpapers"] = "Danh sach hinh nen",
        ["White"] = "Trang",
        ["World & Client Optimization"] = "Toi uu hoa the gioi va ung dung",
        ["X"] = "X",
        ["Yellow"] = "Vang",
        ["Z"] = "Z",
        ["Z Sanguine Boost"] = "Tang toc Sanguine Z",
        ["B1 Hold Time (s)"] = "B1 Thoi gian giu (s)",
        ["B1 Mode"] = "B1 Che do",
        ["B1 Post Jumps"] = "B1 Buoc nhay phu",
        ["B1 Skill Key"] = "B1 Phim chieu",
        ["B1 Weapon"] = "B1 Vu khi",
        ["B2 Hold Time (s)"] = "B2 Thoi gian giu (s)",
        ["B2 Mode"] = "B2 Che do",
        ["B2 Post Jumps"] = "B2 Buoc nhay phu",
        ["B2 Skill Key"] = "B2 Phim chieu",
        ["B2 Weapon"] = "B2 Vu khi",
        ["B3 Hold Time (s)"] = "B3 Thoi gian giu (s)",
        ["B3 Mode"] = "B3 Che do",
        ["B3 Post Jumps"] = "B3 Buoc nhay phu",
        ["B3 Skill Key"] = "B3 Phim chieu",
        ["B3 Weapon"] = "B3 Vu khi",
        ["B4 Hold Time (s)"] = "B4 Thoi gian giu (s)",
        ["B4 Mode"] = "B4 Che do",
        ["B4 Post Jumps"] = "B4 Buoc nhay phu",
        ["B4 Skill Key"] = "B4 Phim chieu",
        ["B4 Weapon"] = "B4 Vu khi",
        ["B5 Hold Time (s)"] = "B5 Thoi gian giu (s)",
        ["B5 Mode"] = "B5 Che do",
        ["B5 Post Jumps"] = "B5 Buoc nhay phu",
        ["B5 Skill Key"] = "B5 Phim chieu",
        ["B5 Weapon"] = "B5 Vu khi",
        ["B6 Hold Time (s)"] = "B6 Thoi gian giu (s)",
        ["B6 Mode"] = "B6 Che do",
        ["B6 Post Jumps"] = "B6 Buoc nhay phu",
        ["B6 Skill Key"] = "B6 Phim chieu",
        ["B6 Weapon"] = "B6 Vu khi",
        ["Block 1 Enabled"] = "Bat Khoi 1",
        ["Block 2 Enabled"] = "Bat Khoi 2",
        ["Block 3 Enabled"] = "Bat Khoi 3",
        ["Block 4 Enabled"] = "Bat Khoi 4",
        ["Block 5 Enabled"] = "Bat Khoi 5",
        ["Block 6 Enabled"] = "Bat Khoi 6",
        ["Combo Sequence (6 Blocks)"] = "Chuoi Combo (6 Khoi)",
        ["Display real-time FPS and ping overlay top-left"] = "Hien thong so FPS va ping o goc tren ben trai",
        ["Displays on-screen one-touch button to trigger combo"] = "Hien nut mot cham tren man hinh de kich hoat combo",
        ["Do not target allied players"] = "Khong ngam vao dong doi",
        ["Do not target players inside safe zones"] = "Khong ngam vao nguoi trong vung an toan",
        ["Do not target players with PvP disabled"] = "Khong ngam vao nguoi choi tat PvP",
        ["Enable step 1 in combo"] = "Kich hoat buoc 1 trong combo",
        ["Enable step 2 in combo"] = "Kich hoat buoc 2 trong combo",
        ["Enable step 3 in combo"] = "Kich hoat buoc 3 trong combo",
        ["Enable step 4 in combo"] = "Kich hoat buoc 4 trong combo",
        ["Enable step 5 in combo"] = "Kich hoat buoc 5 trong combo",
        ["Enable step 6 in combo"] = "Kich hoat buoc 6 trong combo",
        ["Enables keyboard trigger and loop execution"] = "Kich hoat phim tat va chay vong lap",
        ["Fly"] = "Bay",
        ["Fly Speed"] = "Toc do bay",
        ["Glide freely through the air"] = "Luon tu do tren khong trung",
        ["Ignore Allies"] = "Bo qua dong doi",
        ["Ignore PvP Off"] = "Bo qua nguoi tat PvP",
        ["Ignore Safe Zone"] = "Bo qua Vung an toan",
        ["Loop Sequence"] = "Lap lai chuoi",
        ["Macro"] = "Macro",
        ["Macro Controller"] = "Bo dieu khien Macro",
        ["Macro Enabled"] = "Bat Macro",
        ["Macro Floating Widget"] = "Nut Macro noi tren man hinh",
        ["Macro Slot"] = "O chua Macro",
        ["Repeat sequence continuously until stopped"] = "Lap lai lien tuc cho den khi dung",
        ["Show FPS & Ping"] = "Hien FPS va Ping",
        ["Start Combo Sequence"] = "Bat dau chuoi Combo",
        ["Stop Combo Sequence"] = "Dung chuoi Combo",
        ["Trigger Key (PC)"] = "Phim kich hoat (PC)",
        ["YouTube & External Players"] = "Trình phát Ngoài & YouTube",
        ["Launch Universal YouTube Player"] = "Khởi chạy Trình phát YouTube Phổ quát",
        ["Launch Audio Library Player"] = "Khởi chạy Thư viện Âm thanh",
        ["Roblox Audio Player"] = "Trình phát Âm thanh Roblox",
    },
}
local extra={
 ['Interface language']='Idioma de la interfaz',['Auto save configuration']='Guardar configuración automáticamente',
 ['Restore saved configuration']='Restaurar configuración guardada',['Save preferences']='Guardar preferencias',
 ['Load saved preferences']='Cargar preferencias',['Reset feature preferences']='Restablecer preferencias',
 ['Animations']='Animaciones',['Player List']='Lista de jugadores',['Player profile']='Perfil del jugador',
 ['Selected player']='Jugador seleccionado',['Live ESP preview']='Vista previa del ESP',['ESP design']='Diseño del ESP',
 ['Corners']='Esquinas',['Outline']='Contorno',['Floating tag']='Etiqueta flotante',['Skeleton lines']='Líneas del esqueleto',
 ['Body highlight']='Resaltar el cuerpo',['Player connection lines']='Líneas hacia jugadores',['Fruit and equipped weapon']='Fruta y arma equipada',
 ['ESP color']='Color del ESP',['ESP text size']='Tamaño del texto ESP',['ESP distance']='Distancia del ESP',
 ['Fruit color gallery']='Galería de colores de fruta',['Refresh detected fruit']='Actualizar fruta detectada',
 ['Restore fruit colors']='Restaurar colores de fruta',['Unavailable']='No disponible',['By Darling']='By Darling',
 ['Skill blacklist']='Lista de habilidades excluidas',['Choose skills']='Elegir habilidades',['Hide options']='Ocultar opciones',
 ['Enable Waifu']='Activar compañera',['Companion pose']='Pose de la compañera',['Companion expression']='Expresión de la compañera',
 ['Stand']='De pie',['Sit']='Sentada',['Calm']='Tranquila',['Happy']='Alegre',['Focused']='Concentrada',['Wave']='Saludar',
 ['Follow cursor']='Seguir el cursor',['Companion size']='Tamaño de la compañera',['Yuki companion']='Compañera Yuki',
 ['Start Leviathan Kaitun']='Iniciar Kaitun Leviathan',['Crew role']='Rol en la tripulación',['Captain']='Capitán',['Follower']='Seguidor',
 ['Captain name']='Nombre del capitán',['Combat weapon']='Arma de combate',['Rebuy destroyed boats']='Recomprar barcos destruidos',
 ['Fight sea events']='Luchar en eventos marinos',['Boat speed']='Velocidad del barco',['Boat height']='Altura del barco',
 ['Stop Leviathan']='Detener Leviathan',['Money']='Dinero',['Fruit']='Fruta',['Sword']='Espada',['Race']='Raza',['Health']='Vida',
 ['Gun']='Pistola',['Run']='Ejecutar',['Ready']='Listo',['Loading…']='Cargando…',['Preparing interface']='Preparando interfaz',
 ['Restoring preferences']='Restaurando preferencias',['No skills excluded']='Ninguna habilidad excluida',
 ['Max Soru Range']='Alcance máximo de Soru',['Soru Target Mode']='Modo de objetivo de Soru',
}
for key,value in pairs(extra)do dictionaries.Spanish[key]=value end
return dictionaries
]==========],'languages.lua')()
    local language='English'
    local textRecords=setmetatable({},{__mode='k'})
    local translating=setmetatable({},{__mode='k'})
    local function translated(value)
        if language=='English'or type(value)~='string'then return value end
        local dict=dictionaries[language]or{}
        if dict[value]then return dict[value]end
        local suffix=''
        for _,tail in ipairs({'  ∨','  ∧'})do if value:sub(-#tail)==tail then suffix=tail;value=value:sub(1,-#tail-1);break end end
        local prefix='';if value:sub(1,5)=='✓  'then prefix='✓  ';value=value:sub(6)end
        return prefix..(dict[value]or value)..suffix
    end
    api.Translate=translated
    local function setText(object,value)
        translating[object]=true;object.Text=translated(value);translating[object]=nil
    end
    local function registerText(object)
        if textRecords[object]or not(object:IsA('TextLabel')or object:IsA('TextButton'))then return end
        textRecords[object]=object.Text
        track(object:GetPropertyChangedSignal('Text'),function()
            if translating[object]then return end
            textRecords[object]=object.Text;setText(object,object.Text)
        end)
        setText(object,object.Text)
    end
    for _,object in ipairs(gui:GetDescendants())do registerText(object)end
    track(gui.DescendantAdded,function(object)task.defer(function()if alive then registerText(object)end end)end)
    function api.SetLanguage(value)
        assert(value=='English'or dictionaries[value],'Unsupported language')
        language=value;engineEnv.CurrentLanguage=value;engineGlobals.DarlingX.CurrentLanguage=value
        for object,original in pairs(textRecords)do if object.Parent then setText(object,original)end end
        if layout then layout()end
    end
    local restoring=true
    local saveGeneration=0
    local autoKey,restoreKey
    local configPath='SweetExploit/preferences-'..tostring(player.UserId)..'.json'
    local saved={Controls={},Persistent={}}
    local function readConfig()
        if not readfile or not isfile then return end
        local path=isfile(configPath)and configPath or isfile('SweetExploit/preferences.json')and 'SweetExploit/preferences.json'
        if not path then return end
        local ok,value=pcall(function()return game:GetService('HttpService'):JSONDecode(readfile(path))end)
        if ok and type(value)=='table'then
            saved=value.Controls and value or {Controls=value,Persistent={}}
            persistent=saved.Persistent or{}
            local migrations={['ESP.Player_2D_Boxes']='ESP.Box_outline',['ESP.Player_Names']='ESP.Player_names',
                ['ESP.Player_Health_Status']='ESP.Health_bar',['ESP.Distance_Indicator']='ESP.Distance_label',
                ['ESP.Player_Chams_Highlight']='ESP.Body_highlight',['ESP.Player_Tracers']='ESP.Player_connection_lines',
                ['Skins.Monody_VFX_Engine']='Skins.Enable_VFX_recolor'}
            for old,new in pairs(migrations)do if saved.Controls[new]==nil then saved.Controls[new]=saved.Controls[old]end;saved.Controls[old]=nil end
            for _,name in ipairs({'Select_Cinematic','Hide_Dragon','Hide_Throne'})do
                local old='Visual.'..name;local new='Animations.'..name
                if saved.Controls[new]==nil then saved.Controls[new]=saved.Controls[old]end;saved.Controls[old]=nil
            end

        end
    end
    readConfig()
    local function save()
        if not writefile then return false,'File storage unavailable'end
        for key,c in pairs(controls)do if c.Kind~='button'then saved.Controls[key]=state[key]end end
        saved.Persistent=persistent;saved.Version=2
        local ok,err=pcall(function()
            if makefolder and isfolder and not isfolder('SweetExploit')then makefolder('SweetExploit')end
            writefile(configPath,game:GetService('HttpService'):JSONEncode(saved))
        end)
        return ok,err
    end
    engineEnv.SaveConfigProfile=save
    api.QueueSave=function(key)
        if restoring or not alive or(state[autoKey]==false and key~=autoKey)then return end
        saveGeneration=saveGeneration+1;local generation=saveGeneration
        task.delay(.45,function()if alive and not restoring and generation==saveGeneration then save()end end)
    end
    local c=engineEnv.CreateCard(settings,'Configuration')
    local auto=engineEnv.AddToggle(c,'Auto save configuration','Save changed controls automatically.',true,function()end);autoKey=auto.Key
    local restore=engineEnv.AddToggle(c,'Restore saved configuration','Restore preferences and enabled features at startup.',true,function()end);restoreKey=restore.Key
    engineEnv.AddChoice(c,'Interface language',{'English','Spanish','Portuguese','French','Vietnamese'},1,api.SetLanguage)
    engineEnv.AddButton(c,'Save preferences',function()local ok,err=save();assert(ok,err);notice('Preferences','Saved')end)
    local function applySaved()
        restoring=true
        local names={};for key in pairs(saved.Controls)do local name=key:match('^([^.]+)%.');if name and featureSources[name]then names[name]=true end end
        for name in pairs(names)do api.LoadFeatures(name)end
        for key,value in pairs(saved.Controls)do if controls[key]and controls[key].Kind~='toggle'then pcall(api.Set,key,value)end end
        for _,enabled in ipairs({false,true})do for key,value in pairs(saved.Controls)do
            if controls[key]and controls[key].Kind=='toggle'and value==enabled then pcall(api.Set,key,value)end
        end end
        restoring=false
    end
    engineEnv.AddButton(c,'Load saved preferences',function()readConfig();applySaved();notice('Preferences','Loaded')end)
    engineEnv.AddButton(c,'Reset feature preferences',function()
        restoring=true;resetPreferences();restoring=false;save();notice('Preferences','Reset')
    end)
    api.BeforeDestroy=function()
        if state[autoKey]~=false then save()end
        restoring=true;saveGeneration=saveGeneration+1
    end
    function api.Start()
        task.defer(function()
            if not alive then return end
            if api.BootProgress then api.BootProgress(.7,'Restoring preferences')end
            local wantRestore=saved.Controls[restoreKey]~=false
            if wantRestore then applySaved()else
                for _,key in ipairs({autoKey,restoreKey,'Settings.Interface_language'})do
                    if saved.Controls[key]~=nil then pcall(api.Set,key,saved.Controls[key])end
                end
                restoring=false
            end
            if wantRestore and persistent.FruitPreset and persistent.FruitPreset~=''then
                api.LoadFeatures('Skins')
                if engineGlobals.RestoreFruitPreset then pcall(engineGlobals.RestoreFruitPreset,persistent.FruitPreset)end
            end
            if wantRestore and isfile and readfile and isfile('DarlingX_Keybinds.json')then
                local ok,bindings=pcall(function()return game:GetService('HttpService'):JSONDecode(readfile('DarlingX_Keybinds.json'))end)
                if ok and type(bindings)=='table'and #bindings>0 then requireModule('modules/ui/keybinds_system.lua').Init()end
            end
            if api.BootProgress then api.BootProgress(1,'Ready')end
            if api.FinishBoot then api.FinishBoot()end
        end)
    end
    settings.Status.Text='Configuration is saved after each change'


end)()

watchCamera()
refreshStats()
api.UpdateUISubscriptions()
if api.Start then api.Start()end
return api
