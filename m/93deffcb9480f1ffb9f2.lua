local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Tracers = {}
local enabled, thickness, rainbow = false, 2, false
local color = Color3.fromRGB(90, 220, 230)
local origin, style = "Player", "Both"
local gui, line, dot, dotStroke, connection
local layers, beams = {}, {}
local holder, sourceAttachment, targetAttachment
local glowWidths = {10, 5, 1.5, 0}
local painted2DColor, painted2DThickness, painted3DColor, painted3DThickness
local function bright(c, amount)
return Color3.fromRGB((c.R + (1-c.R)*amount)*255,(c.G + (1-c.G)*amount)*255,(c.B + (1-c.B)*amount)*255)
end
local function parentGui(item)
if gethui then local ok, parent = pcall(gethui); if ok and parent then item.Parent = parent; return end end
local player = Players.LocalPlayer
item.Parent = player and player:FindFirstChildOfClass("PlayerGui") or game:GetService("CoreGui")
end
local function build2D()
if gui and gui.Parent then return end
gui = Instance.new("ScreenGui")
gui.Name, gui.ResetOnSpawn, gui.IgnoreGuiInset = "SweetNeonTracers", false, true
gui.DisplayOrder, gui.ZIndexBehavior = 1000001, Enum.ZIndexBehavior.Sibling
line = Instance.new("Frame")
line.Name, line.BackgroundTransparency, line.BorderSizePixel = "NeonTracer", 1, 0
line.AnchorPoint, line.Visible, line.Active, line.Parent = Vector2.new(.5,.5), false, false, gui
layers = {}
painted2DColor, painted2DThickness = nil, nil
for index, alpha in ipairs({.94, .80, .40, .02}) do
local layer = Instance.new("Frame")
layer.Name, layer.AnchorPoint = "LineLayer" .. index, Vector2.new(.5,.5)
layer.Position, layer.BorderSizePixel, layer.BackgroundTransparency = UDim2.fromScale(.5,.5), 0, alpha
layer.Active, layer.Parent = false, line
local corner = Instance.new("UICorner")
corner.CornerRadius, corner.Parent = UDim.new(1,0), layer
layers[index] = layer
end
dot = Instance.new("Frame")
dot.Name, dot.AnchorPoint, dot.Size = "TargetPoint", Vector2.new(.5,.5), UDim2.fromOffset(10,10)
dot.BackgroundTransparency, dot.BorderSizePixel, dot.Visible = .9, 0, false
dot.Active, dot.Parent = false, gui
local corner = Instance.new("UICorner"); corner.CornerRadius, corner.Parent = UDim.new(1,0), dot
dotStroke = Instance.new("UIStroke"); dotStroke.Thickness, dotStroke.Transparency, dotStroke.Parent = 1.5, .2, dot
local center = Instance.new("Frame")
center.Name, center.AnchorPoint, center.Size = "Core", Vector2.new(.5,.5), UDim2.fromOffset(3,3)
center.Position, center.BackgroundColor3, center.BorderSizePixel = UDim2.fromScale(.5,.5), Color3.fromRGB(245,255,255), 0
center.Parent = dot
local centerCorner = Instance.new("UICorner"); centerCorner.CornerRadius, centerCorner.Parent = UDim.new(1,0), center
parentGui(gui)
end
local function build3D()
if holder and holder.Parent then return end
holder = Instance.new("Part")
holder.Name, holder.Size = "SweetNeonTracerHolder", Vector3.new(1,1,1)
holder.Anchored, holder.Transparency, holder.CanCollide = true, 1, false
holder.CanTouch, holder.CanQuery, holder.Parent = false, false, Workspace
sourceAttachment, targetAttachment = Instance.new("Attachment"), Instance.new("Attachment")
sourceAttachment.Name, sourceAttachment.Parent = "Origin", holder
targetAttachment.Name, targetAttachment.Parent = "Target", holder
beams = {}
painted3DColor, painted3DThickness = nil, nil
for i = 1, 2 do
local beam = Instance.new("Beam")
beam.Name = i == 1 and "SoftGlow" or "BrightCore"
beam.Attachment0, beam.Attachment1 = sourceAttachment, targetAttachment
beam.LightEmission, beam.LightInfluence, beam.FaceCamera = 1, 0, true
beam.Segments, beam.Enabled = 1, false
beam.Transparency = i == 1 and NumberSequence.new(.86) or NumberSequence.new({
NumberSequenceKeypoint.new(0,.65), NumberSequenceKeypoint.new(.12,.18),
NumberSequenceKeypoint.new(.85,.04), NumberSequenceKeypoint.new(1,.3),
})
beam.Parent, beams[i] = holder, beam
end
end
local function isAlive(char)
if not char then return false end
local hum = char:FindFirstChildOfClass("Humanoid")
return hum ~= nil and hum.Health > 0
end
local function resolveTargetPart()
local env = (getgenv and getgenv()) or _G
local core = env.DarlingCombatCore or _G.DarlingCombatCore
if core and core.CurrentTargetPart and core.CurrentTargetPart.Parent then
if isAlive(core.CurrentTargetPart.Parent) then
return core.CurrentTargetPart
end
end
if _G.currentSilentAimTarget and _G.currentSilentAimTarget.Parent then
local parentChar = _G.currentSilentAimTarget.Parent
if isAlive(parentChar) then
return _G.currentSilentAimTarget
end
end
if _G.DarlingSilentAimTarget and _G.DarlingSilentAimTarget.Parent then
local parentChar = _G.DarlingSilentAimTarget.Parent
if isAlive(parentChar) then
return _G.DarlingSilentAimTarget
end
end
local abTarget = _G.DarlingAutoBountyTarget or _G.DarlingTarget
if abTarget then
local char = abTarget.Character or (abTarget:IsA("Model") and abTarget)
if isAlive(char) then
local p = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head") or char:FindFirstChild("Torso")
if p then return p end
end
end
local camera = Workspace.CurrentCamera
if not camera then return nil end
local viewport = camera.ViewportSize
local screenCenter = Vector2.new(viewport.X / 2, viewport.Y / 2)
local closestPart = nil
local shortestDist = math.huge
local lp = Players.LocalPlayer or LocalPlayer
for _, p in ipairs(Players:GetPlayers()) do
if p ~= lp and p.Character and isAlive(p.Character) then
local hrp = p.Character:FindFirstChild("HumanoidRootPart") or p.Character:FindFirstChild("Head")
if hrp then
local sPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
if onScreen and sPos.Z > 0 then
local d = (Vector2.new(sPos.X, sPos.Y) - screenCenter).Magnitude
if d < shortestDist then
shortestDist = d
closestPart = hrp
end
end
end
end
end
return closestPart
end
local function hide2D()
if line then line.Visible = false end
if dot then dot.Visible = false end
end
local function hide3D() for _, beam in ipairs(beams) do beam.Enabled = false end end
local function getOriginPosition(root, camera)
local viewport = camera.ViewportSize
if origin == "Mouse" and not UserInputService.TouchEnabled then return UserInputService:GetMouseLocation() end
if origin == "Bottom" then return Vector2.new(viewport.X/2, viewport.Y-16) end
if origin == "Player" then
local point, visible = camera:WorldToViewportPoint(root.Position)
if visible and point.Z > 0 then return Vector2.new(point.X,point.Y) end
end
return Vector2.new(viewport.X/2, viewport.Y/2)
end
local function draw()
if not enabled then hide2D(); hide3D(); return end
local player = Players.LocalPlayer
local root = player and player.Character and player.Character:FindFirstChild("HumanoidRootPart")
local target = resolveTargetPart()
if not root or not target then hide2D(); hide3D(); return end
local active = rainbow and Color3.fromHSV((os.clock()*.12)%1,.75,1) or color
local core = bright(active,.70)
if style ~= "2D Line" then
build3D()
sourceAttachment.WorldPosition, targetAttachment.WorldPosition = root.Position, target.Position
local width = math.clamp(thickness*.045,.04,.32)
local repaint = painted3DColor ~= active or painted3DThickness ~= thickness
for i, beam in ipairs(beams) do
if repaint then
beam.Width0, beam.Width1 = width*(i==1 and 4 or 1), width*(i==1 and 2.5 or .55)
beam.Color = ColorSequence.new(i==1 and active or core)
end
beam.Enabled = true
end
painted3DColor, painted3DThickness = active, thickness
else hide3D() end
if style == "3D Beam" then hide2D(); return end
local camera = Workspace.CurrentCamera
if not camera then hide2D(); return end
local to, visible = camera:WorldToViewportPoint(target.Position)
if not visible or to.Z <= 0 then hide2D(); return end
build2D()
local from = getOriginPosition(root,camera)
local dx,dy = to.X-from.X,to.Y-from.Y
local distance = math.sqrt(dx*dx+dy*dy)
if distance < 1 then hide2D(); return end
line.Position, line.Size = UDim2.fromOffset((from.X+to.X)/2,(from.Y+to.Y)/2), UDim2.fromOffset(distance,thickness)
line.Rotation = math.deg(math.atan2(dy,dx))
if painted2DColor ~= active or painted2DThickness ~= thickness then
for i, layer in ipairs(layers) do
layer.Size = UDim2.new(1,0,0,thickness+glowWidths[i])
layer.BackgroundColor3 = i==4 and core or active
end
painted2DColor, painted2DThickness = active, thickness
end
line.Visible = true
dot.Position, dot.BackgroundColor3, dotStroke.Color = UDim2.fromOffset(to.X,to.Y), active, active
dot.Visible = true
end
function Tracers.enable()
enabled = true; _G.G_SilentAimShowLine, _G.DarlingTracersVisible = true, true
if not connection then connection = RunService.RenderStepped:Connect(draw) end
draw(); return true
end
function Tracers.disable()
enabled = false; _G.G_SilentAimShowLine, _G.DarlingTracersVisible = false, false
if connection then connection:Disconnect(); connection = nil end
hide2D(); hide3D()
end
function Tracers.setVisible(value) if value then return Tracers.enable() else Tracers.disable() end end
function Tracers.setColor(value)
if value == "Rainbow" then rainbow = true elseif typeof(value)=="Color3" then color,rainbow=value,false end
if enabled then draw() end
end
function Tracers.setRainbow(value) rainbow=value==true; if enabled then draw() end end
function Tracers.setThickness(value) thickness=math.clamp(tonumber(value)or 2,1,10);if enabled then draw() end end
function Tracers.setType(value)
if value=="3D Beam" or value=="2D Line" or value=="Both" then style=value;if enabled then draw() end end
end
function Tracers.setOrigin(value)
if value=="Player"or value=="Mouse"or value=="Bottom"or value=="Center"then origin=value;if enabled then draw()end end
end
function Tracers.isEnabled() return enabled end
function Tracers.destroy()
Tracers.disable()
if gui then gui:Destroy() end
if holder then holder:Destroy() end
gui,line,dot,dotStroke,holder,sourceAttachment,targetAttachment=nil,nil,nil,nil,nil,nil,nil
layers,beams={},{}
end
return Tracers
