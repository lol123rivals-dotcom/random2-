local Players,Run=game:GetService('Players'),game:GetService('RunService')
local Design=RequireModule('modules/esp/design.lua')
local ESP={};for k,v in pairs(Design.Defaults)do ESP[k]=v end
local gui,render
local renderName='SweetESP_'..tostring(Players.LocalPlayer.UserId)
local renderBound=false
local links,entries={},{}
local signs={-1,1}
local function remove(p)
local e=entries[p];if not e then return end
if e.View then e.View:Destroy()end
if e.Highlight then e.Highlight:Destroy()end
entries[p]=nil
end
local function add(p)if p~=Players.LocalPlayer then entries[p]=entries[p]or{Player=p,NextMeta=0,NextBounds=0,NextParts=0}end end
local function bind(e,char)
if e.Highlight then e.Highlight:Destroy();e.Highlight=nil end
e.Character=char;e.Humanoid=char and char:FindFirstChildOfClass('Humanoid');e.Root=char and char:FindFirstChild('HumanoidRootPart')
e.Parts,e.BonePairs,e.Corners={},{},nil;e.Geometry=nil;e.NextParts=0;e.NextBounds=0;e.NextMeta=0
end
local function parts(e,now)
e.NextParts=now+1;e.Parts={};e.BonePairs={};if e.Geometry then e.Geometry.Bones={}end
for _,p in ipairs(e.Character:GetChildren())do if p:IsA('BasePart')and p.Name~='HumanoidRootPart'then e.Parts[#e.Parts+1]=p end end
for i,pair in ipairs(Design.Bones)do local a,b=Design.Part(e.Character,pair[1]),Design.Part(e.Character,pair[2]);if a and b then e.BonePairs[i]={a,b}end end
end
local function bounds(e,now)
e.NextBounds=now+.1
local root=e.Root.CFrame
local minX,minY,minZ,maxX,maxY,maxZ=math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge
for _,part in ipairs(e.Parts)do if part.Parent then
local cf,size=part.CFrame,part.Size
for _,x in ipairs(signs)do for _,y in ipairs(signs)do for _,z in ipairs(signs)do
local point=root:PointToObjectSpace(cf:PointToWorldSpace(Vector3.new(size.X*x/2,size.Y*y/2,size.Z*z/2)))
minX,minY,minZ=math.min(minX,point.X),math.min(minY,point.Y),math.min(minZ,point.Z)
maxX,maxY,maxZ=math.max(maxX,point.X),math.max(maxY,point.Y),math.max(maxZ,point.Z)
end end end
end end
if minX==math.huge then minX,minY,minZ,maxX,maxY,maxZ=-2,-3,-1.5,2,3,1.5 end
local corners=e.Corners or{};local index=0
for _,x in ipairs({minX,maxX})do for _,y in ipairs({minY,maxY})do for _,z in ipairs({minZ,maxZ})do index=index+1;corners[index]=Vector3.new(x,y,z)end end end
e.Corners=corners
end
local function draw()
local camera=workspace.CurrentCamera;local lp=Players.LocalPlayer
local own=lp.Character and lp.Character:FindFirstChild('HumanoidRootPart')
if not camera or not own or camera.ViewportSize.X<=0 or camera.ViewportSize.Y<=0 then
for _,e in pairs(entries)do if e.View then Design.Draw(e.View,ESP,nil)end end;return
end
local sx,sy=gui.AbsoluteSize.X/camera.ViewportSize.X,gui.AbsoluteSize.Y/camera.ViewportSize.Y
local now=os.clock()
for p,e in pairs(entries)do
local char=p.Character
if e.Character~=char or not e.Root or not e.Root.Parent then bind(e,char)end
local h,root=e.Humanoid,e.Root
local distance=root and(root.Position-own.Position).Magnitude
if not h or not root or h.Health<=0 or distance>ESP.MaxDistance then
if e.View then e.View:Destroy();e.View=nil end
if e.Highlight then e.Highlight.Enabled=false end
else
if not e.View then e.View=Design.New(gui)end
if ESP.Chams then
if not e.Highlight then e.Highlight=Instance.new('Highlight');e.Highlight.Adornee=char;e.Highlight.Parent=char end
e.Highlight.FillColor,e.Highlight.OutlineColor=ESP.Color,ESP.Color;e.Highlight.FillTransparency=.8;e.Highlight.OutlineTransparency=.1;e.Highlight.Enabled=true
elseif e.Highlight then e.Highlight.Enabled=false end
local center,visible=camera:WorldToViewportPoint(root.Position)
if visible and center.Z>0 then
if now>=e.NextParts then parts(e,now)end
bounds(e,now)
local minX,minY,maxX,maxY=math.huge,math.huge,-math.huge,-math.huge
local rootCF=root.CFrame
for _,corner in ipairs(e.Corners)do
local point=camera:WorldToViewportPoint(rootCF:PointToWorldSpace(corner))
if point.Z>0 then minX,minY,maxX,maxY=math.min(minX,point.X),math.min(minY,point.Y),math.max(maxX,point.X),math.max(maxY,point.Y)end
end
if minX~=math.huge then
if now>=e.NextMeta then
e.NextMeta=now+.2
local data=p:FindFirstChild('Data');local fruit=data and data:FindFirstChild('DevilFruit');local tool=char:FindFirstChildOfClass('Tool')
e.Equipment=table.concat({fruit and tostring(fruit.Value)or'',tool and tool.Name or''},' ')
end
local x,y,w,height=minX*sx,minY*sy,math.max(1,(maxX-minX)*sx),math.max(1,(maxY-minY)*sy)
local g=e.Geometry or{Bones={}};e.Geometry=g
g.X,g.Y,g.W,g.H=x,y,w,height;g.Name=p.DisplayName;g.Health,g.MaxHealth=h.Health,h.MaxHealth;g.Distance=distance;g.Equipment=e.Equipment
g.Origin=ESP.Tracers and Vector2.new(gui.AbsoluteSize.X/2-x,gui.AbsoluteSize.Y-y-16)or nil
if ESP.Skeleton then
for i,pair in pairs(e.BonePairs)do
local a,b=pair[1],pair[2]
if a.Parent and b.Parent then
local ap,bp=camera:WorldToViewportPoint(a.Position),camera:WorldToViewportPoint(b.Position)
if ap.Z>0 and bp.Z>0 then g.Bones[i]={Vector2.new(ap.X*sx-x,ap.Y*sy-y),Vector2.new(bp.X*sx-x,bp.Y*sy-y)}else g.Bones[i]=nil end
else g.Bones[i]=nil end
end
end
Design.Draw(e.View,ESP,g)
else Design.Draw(e.View,ESP,nil)end
else Design.Draw(e.View,ESP,nil)end
end
end
end
function ESP.enable()
if render or renderBound then return end;ESP.Enabled=true
gui=Instance.new('ScreenGui');gui.Name='PlayerOverlay';gui.IgnoreGuiInset=true;gui.ResetOnSpawn=false;gui.DisplayOrder=100000
pcall(function()gui.ScreenInsets=Enum.ScreenInsets.None end)
gui.Parent=(gethui and gethui())or game:GetService('CoreGui')
for _,p in ipairs(Players:GetPlayers())do add(p)end
links={Players.PlayerAdded:Connect(add),Players.PlayerRemoving:Connect(remove)}
local ok=pcall(function()Run:BindToRenderStep(renderName,Enum.RenderPriority.Last.Value,draw)end)
renderBound=ok
if not ok then render=Run.RenderStepped:Connect(draw)end
end
function ESP.disable()
ESP.Enabled=false;if renderBound then Run:UnbindFromRenderStep(renderName);renderBound=false end;if render then render:Disconnect();render=nil end
for _,c in ipairs(links)do c:Disconnect()end;links={}
for p in pairs(entries)do remove(p)end
if gui then gui:Destroy();gui=nil end
end
function ESP.SetEnabled(v)if v then ESP.enable()else ESP.disable()end end
function ESP.toggle(v)ESP.SetEnabled(v)end
function ESP.Destroy()ESP.disable()end
return ESP
