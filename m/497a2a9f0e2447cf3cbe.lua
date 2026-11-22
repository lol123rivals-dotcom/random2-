local Players,Run=game:GetService('Players'),game:GetService('RunService')
local Design=RequireModule('modules/esp/design.lua')
local ESP={};for k,v in pairs(Design.Defaults)do ESP[k]=v end
local gui,connection
local cache={}
local function destroyPlayer(p)local entry=cache[p];if entry then entry.View:Destroy();if entry.Highlight then entry.Highlight:Destroy()end;cache[p]=nil end end
local function update()
local camera=workspace.CurrentCamera;local player=Players.LocalPlayer;local root=player.Character and player.Character:FindFirstChild('HumanoidRootPart')
if not camera or not root then return end
local seen={};local sx,sy=gui.AbsoluteSize.X/camera.ViewportSize.X,gui.AbsoluteSize.Y/camera.ViewportSize.Y
for _,p in ipairs(Players:GetPlayers())do if p~=player then
seen[p]=true
local char=p.Character;local h=char and char:FindFirstChildOfClass('Humanoid');local hrp=char and char:FindFirstChild('HumanoidRootPart')
local distance=hrp and(hrp.Position-root.Position).Magnitude
if not h or not hrp or h.Health<=0 or distance>ESP.MaxDistance then destroyPlayer(p)
else
local center,visible=camera:WorldToViewportPoint(hrp.Position)
if not cache[p]then cache[p]={View=Design.New(gui)}end;local e=cache[p]
if ESP.Chams then
if not e.Highlight or e.Highlight.Adornee~=char then if e.Highlight then e.Highlight:Destroy()end;e.Highlight=Instance.new('Highlight');e.Highlight.Adornee=char;e.Highlight.Parent=char end
e.Highlight.FillColor,e.Highlight.OutlineColor=ESP.Color,ESP.Color;e.Highlight.FillTransparency=.78;e.Highlight.OutlineTransparency=.15;e.Highlight.Enabled=true
elseif e.Highlight then e.Highlight.Enabled=false end
if visible and center.Z>0 then
local cf,size=char:GetBoundingBox();local a,b=camera:WorldToViewportPoint(cf.Position+Vector3.new(0,size.Y/2,0)),camera:WorldToViewportPoint(cf.Position-Vector3.new(0,size.Y/2,0))
local height=math.abs(b.Y-a.Y)*sy;local width=height*.58;local x,y=center.X*sx-width/2,math.min(a.Y,b.Y)*sy
local fruit=p:FindFirstChild('Data');fruit=fruit and fruit:FindFirstChild('DevilFruit');local tool=char:FindFirstChildOfClass('Tool')
local g={X=x,Y=y,W=width,H=height,Name=p.DisplayName,Health=h.Health,MaxHealth=h.MaxHealth,Distance=distance,
Equipment=table.concat({fruit and tostring(fruit.Value)or'',tool and tool.Name or''},' '),Bones={},Origin=Vector2.new(gui.AbsoluteSize.X/2-x,gui.AbsoluteSize.Y-y-16)}
for i,pair in ipairs(Design.Bones)do local pa,pb=Design.Part(char,pair[1]),Design.Part(char,pair[2]);if pa and pb then
local ap,bp=camera:WorldToViewportPoint(pa.Position),camera:WorldToViewportPoint(pb.Position)
if ap.Z>0 and bp.Z>0 then g.Bones[i]={Vector2.new(ap.X*sx-x,ap.Y*sy-y),Vector2.new(bp.X*sx-x,bp.Y*sy-y)}end
end end
Design.Draw(e.View,ESP,g)
else Design.Draw(e.View,ESP,nil)end
end
end end
for p in pairs(cache)do if not seen[p]then destroyPlayer(p)end end
end
function ESP.enable()
if ESP.Enabled then return end;ESP.Enabled=true
gui=Instance.new('ScreenGui');gui.Name='PlayerOverlay';gui.IgnoreGuiInset=true;gui.ResetOnSpawn=false;gui.DisplayOrder=100000
gui.Parent=(gethui and gethui())or game:GetService('CoreGui')
local elapsed=0;connection=Run.RenderStepped:Connect(function(dt)elapsed=elapsed+dt;if elapsed>=.04 then elapsed=0;update()end end)
end
function ESP.disable()
ESP.Enabled=false;if connection then connection:Disconnect();connection=nil end
for p in pairs(cache)do destroyPlayer(p)end
if gui then gui:Destroy();gui=nil end
end
function ESP.toggle(value)if value then ESP.enable()else ESP.disable()end end
function ESP.Destroy()ESP.disable()end
return ESP
