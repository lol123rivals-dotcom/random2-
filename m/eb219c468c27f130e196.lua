local Design={}
Design.Defaults={Enabled=false,Boxes=true,Names=true,Health=true,Distance=true,Equipment=true,Skeleton=false,Tracers=false,Chams=false,
Style='Corners',Color=Color3.fromRGB(130,225,235),TextSize=13,MaxDistance=2500}
Design.Bones={{'Head','UpperTorso|Torso'},{'UpperTorso|Torso','LowerTorso|Torso'},
{'UpperTorso|Torso','LeftUpperArm|Left Arm'},{'LeftUpperArm|Left Arm','LeftLowerArm|Left Arm'},{'LeftLowerArm|Left Arm','LeftHand|Left Arm'},
{'UpperTorso|Torso','RightUpperArm|Right Arm'},{'RightUpperArm|Right Arm','RightLowerArm|Right Arm'},{'RightLowerArm|Right Arm','RightHand|Right Arm'},
{'LowerTorso|Torso','LeftUpperLeg|Left Leg'},{'LeftUpperLeg|Left Leg','LeftLowerLeg|Left Leg'},{'LeftLowerLeg|Left Leg','LeftFoot|Left Leg'},
{'LowerTorso|Torso','RightUpperLeg|Right Leg'},{'RightUpperLeg|Right Leg','RightLowerLeg|Right Leg'},{'RightLowerLeg|Right Leg','RightFoot|Right Leg'}}
function Design.Part(model,names)
for name in names:gmatch('[^|]+')do local p=model:FindFirstChild(name);if p and p:IsA('BasePart')then return p end end
end
local function frame(parent,name)
local f=Instance.new('Frame');f.Name=name;f.BorderSizePixel=0;f.BackgroundTransparency=1;f.Parent=parent;return f
end
local function label(parent,name)
local l=Instance.new('TextLabel');l.Name=name;l.BackgroundTransparency=1;l.Font=Enum.Font.GothamMedium;l.TextStrokeTransparency=.5
l.TextColor3=Color3.fromRGB(240,245,248);l.TextSize=13;l.Parent=parent;return l
end
local function segment(f,a,b,color,width)
local dx,dy=b.X-a.X,b.Y-a.Y
f.AnchorPoint=Vector2.new(.5,.5);f.Position=UDim2.fromOffset((a.X+b.X)/2,(a.Y+b.Y)/2)
f.Size=UDim2.fromOffset(math.sqrt(dx*dx+dy*dy),width or 1.5);f.Rotation=math.deg(math.atan2(dy,dx))
f.BackgroundColor3=color;f.BackgroundTransparency=.08;f.Visible=true
end
function Design.New(parent)
local d={Root=frame(parent,'ESPDesign'),Edges={},Bones={}}
for i=1,8 do d.Edges[i]=frame(d.Root,'Edge'..i)end
for i=1,#Design.Bones do d.Bones[i]=frame(d.Root,'Bone'..i)end
d.Name=label(d.Root,'Name');d.Info=label(d.Root,'Info');d.HealthText=label(d.Root,'HealthValue')
d.HealthTrack=frame(d.Root,'HealthTrack');d.HealthTrack.BackgroundTransparency=.15;d.HealthTrack.BackgroundColor3=Color3.fromRGB(20,20,24)
d.HealthFill=frame(d.HealthTrack,'HealthFill');d.Line=frame(d.Root,'PlayerLine')
function d:Destroy()self.Root:Destroy()end
return d
end
function Design.Draw(d,c,g)
d.Root.Visible=g~=nil;if not g then return end
local w,h=g.W,g.H;d.Root.Position=UDim2.fromOffset(g.X,g.Y);d.Root.Size=UDim2.fromOffset(w,h)
local color=c.Color;local box=c.Boxes and c.Style~='Floating tag'
for _,f in ipairs(d.Edges)do f.Visible=false end
if box then
local x=math.max(8,math.min(w*.22,24));local y=math.max(8,math.min(h*.12,24))
local points
if c.Style=='Outline'then points={{{0,0},{w,0}},{{w,0},{w,h}},{{w,h},{0,h}},{{0,h},{0,0}}}
else points={{{0,y},{0,0}},{{0,0},{x,0}},{{w-x,0},{w,0}},{{w,0},{w,y}},{{0,h-y},{0,h}},{{0,h},{x,h}},{{w-x,h},{w,h}},{{w,h-y},{w,h}}}end
for i,p in ipairs(points)do segment(d.Edges[i],Vector2.new(p[1][1],p[1][2]),Vector2.new(p[2][1],p[2][2]),color,1.5)end
end
for i,f in ipairs(d.Bones)do
local pair=g.Bones and g.Bones[i];f.Visible=c.Skeleton and pair~=nil
if f.Visible then segment(f,pair[1],pair[2],color,1.5)end
end
d.Name.Visible=c.Names;d.Name.Text=g.Name or 'Preview';d.Name.TextSize=c.TextSize
d.Name.Position=UDim2.fromOffset(-60,-24);d.Name.Size=UDim2.fromOffset(w+120,22)
local info={};if c.Distance and g.Distance then info[#info+1]=tostring(math.floor(g.Distance))..' studs'end
if c.Equipment and g.Equipment and g.Equipment~=''then info[#info+1]=g.Equipment end
d.Info.Visible=#info>0;d.Info.Text=table.concat(info,' · ');d.Info.TextSize=math.max(10,c.TextSize-1)
d.Info.Position=UDim2.fromOffset(-90,h+5);d.Info.Size=UDim2.fromOffset(w+180,36);d.Info.TextWrapped=true
local fraction=math.clamp((g.Health or 0)/math.max(g.MaxHealth or 1,1),0,1)
d.HealthTrack.Visible=c.Health;d.HealthTrack.Position=UDim2.fromOffset(-8,0);d.HealthTrack.Size=UDim2.fromOffset(3,h)
d.HealthFill.BackgroundTransparency=0;d.HealthFill.BackgroundColor3=Color3.fromRGB(90+130*(1-fraction),190*fraction+40,120)
d.HealthFill.Position=UDim2.fromScale(0,1-fraction);d.HealthFill.Size=UDim2.fromScale(1,fraction)
d.HealthText.Visible=c.Health;d.HealthText.Text=tostring(math.floor(g.Health or 0));d.HealthText.TextSize=10
d.HealthText.Position=UDim2.fromOffset(-40,h*(1-fraction)-9);d.HealthText.Size=UDim2.fromOffset(28,18)
d.Line.Visible=c.Tracers and g.Origin~=nil
if d.Line.Visible then segment(d.Line,g.Origin,Vector2.new(w/2,h),color,1.2)end
end
return Design
