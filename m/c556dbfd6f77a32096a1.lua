local Run = game:GetService("RunService")
local Input = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local FOV = {}
local enabled, radius, thickness = false, 100, 2
local color, rainbow, mode, aimMode = Color3.fromRGB(90, 220, 230), false, "Center", "360"
local gui, ring, connection
local strokes = {}
local glowWidths = {10, 5, 1.5, 0}
local paintedColor, paintedThickness
local function sharedSettings()
local hub = _G.DarlingHub or _G.DarlingX
return hub and hub.Settings and hub.Settings.FOV
end
local function tint(c, white)
return Color3.fromRGB((c.R + (1 - c.R) * white) * 255,
(c.G + (1 - c.G) * white) * 255, (c.B + (1 - c.B) * white) * 255)
end
local function parentGui(item)
if gethui then local ok, parent = pcall(gethui); if ok and parent then item.Parent = parent; return end end
local player = Players.LocalPlayer
item.Parent = player and player:FindFirstChildOfClass("PlayerGui") or game:GetService("CoreGui")
end
local function paint()
local active = rainbow and Color3.fromHSV((os.clock() * .12) % 1, .75, 1) or color
if paintedColor == active and paintedThickness == thickness then return end
paintedColor, paintedThickness = active, thickness
for i, stroke in ipairs(strokes) do
stroke.Color = i == 4 and tint(active, .65) or active
stroke.Thickness = thickness + glowWidths[i]
end
end
local function draw()
if not gui or not enabled then return end
local position = UDim2.fromScale(.5, .5)
if mode == "Mouse" and not Input.TouchEnabled then
local mouse = Input:GetMouseLocation()
position = UDim2.fromOffset(mouse.X, mouse.Y)
end
ring.Position = position
ring.Size = UDim2.fromOffset(radius * 2, radius * 2)
paint()
end
local function build()
if gui and gui.Parent then return end
gui = Instance.new("ScreenGui")
gui.Name, gui.ResetOnSpawn, gui.IgnoreGuiInset = "SweetNeonFOV", false, true
gui.DisplayOrder, gui.ZIndexBehavior = 1000000, Enum.ZIndexBehavior.Sibling
ring = Instance.new("Frame")
ring.Name, ring.BackgroundTransparency, ring.BorderSizePixel = "NeonRing", 1, 0
ring.AnchorPoint, ring.Active, ring.Parent = Vector2.new(.5, .5), false, gui
strokes = {}
paintedColor, paintedThickness = nil, nil
for i, alpha in ipairs({.96, .86, .55, .08}) do
local layer = Instance.new("Frame")
layer.Name, layer.BackgroundTransparency, layer.BorderSizePixel = "NeonLayer" .. i, 1, 0
layer.Size, layer.Active, layer.Parent = UDim2.fromScale(1, 1), false, ring
local corner = Instance.new("UICorner")
corner.CornerRadius, corner.Parent = UDim.new(1, 0), layer
local stroke = Instance.new("UIStroke")
stroke.Name, stroke.Transparency = i == 4 and "BrightCore" or "Glow", alpha
stroke.ApplyStrokeMode, stroke.Parent = Enum.ApplyStrokeMode.Border, layer
strokes[i] = stroke
end
parentGui(gui)
end
function FOV.enable()
enabled = true
build(); draw()
if not connection then connection = Run.RenderStepped:Connect(draw) end
return true
end
function FOV.disable()
enabled = false
if connection then connection:Disconnect(); connection = nil end
if gui then gui:Destroy(); gui, ring = nil, nil end
strokes = {}
end
function FOV.toggle(value)
if value == nil then value = not enabled end
if value then FOV.enable() else FOV.disable() end
return enabled
end
function FOV.setRadius(value)
radius = math.clamp(tonumber(value) or 100, 10, 1200)
local settings = sharedSettings(); if settings then settings.Radius = radius end
local core = _G.DarlingCombatCore
if core and core.setFOVRadius then core.setFOVRadius(radius) end
draw()
end
function FOV.setThickness(value) thickness = math.clamp(tonumber(value) or 2, 1, 10); paint() end
function FOV.setColor(value)
if value == "Rainbow" then return FOV.setRainbow(true) end
if typeof(value) == "Color3" then color, rainbow = value, false; paint() end
end
function FOV.setRainbow(value) rainbow = value == true; paint() end
function FOV.setMode(value)
if value == "Center" or value == "Mouse" then
mode = value
local settings = sharedSettings(); if settings then settings.Mode = mode end
draw()
end
end
function FOV.getRadius() return radius end
function FOV.isEnabled() return enabled end
function FOV.setAimMode(value) aimMode = tostring(value or "360") end
function FOV.isAimModeFov() return aimMode:upper() == "FOV" end
function FOV.destroy() FOV.disable() end
return FOV
