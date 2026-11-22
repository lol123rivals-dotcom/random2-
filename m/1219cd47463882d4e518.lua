local Players=game:GetService('Players')
local Widgets={}
local function new(class,props,parent)local o=Instance.new(class);for k,v in pairs(props or{})do o[k]=v end;o.Parent=parent;return o end
function Widgets.Text(parent,value,x,y,w,h,size)
return new('TextLabel',{Text=value,Position=UDim2.new(x,0,0,y),Size=UDim2.new(w,0,0,h),BackgroundTransparency=1,
TextColor3=Color3.fromRGB(225,230,235),Font=Enum.Font.GothamMedium,TextSize=size or 14,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true},parent)
end
function Widgets.Data(p,names)
for _,rootName in ipairs({'Data','leaderstats','Stats'})do local root=p:FindFirstChild(rootName);if root then
for _,name in ipairs(names)do local obj=root:FindFirstChild(name);if obj and obj:IsA('ValueBase')then return obj.Value end end
end end
for _,name in ipairs(names)do local value=p:GetAttribute(name);if value~=nil then return value end end
end
function Widgets.Profile(p)
local h=p.Character and p.Character:FindFirstChildOfClass('Humanoid')
local result={Name=p.DisplayName or p.Name,Username=p.Name,UserId=p.UserId,
Fruit=Widgets.Data(p,{'DevilFruit','BloxFruit','Fruit'}),Race=Widgets.Data(p,{'Race'}),
Money=Widgets.Data(p,{'Beli','Money','Cash'}),Bounty=Widgets.Data(p,{'Bounty/Honor','Bounty','Honor'}),
Health=h and math.floor(h.Health),MaxHealth=h and math.floor(h.MaxHealth),Sword=Widgets.Data(p,{'Sword','EquippedSword'}),Gun=Widgets.Data(p,{'Gun','EquippedGun'})}
for _,container in ipairs({p.Character,p:FindFirstChildOfClass('Backpack')})do if container then for _,tool in ipairs(container:GetChildren())do
if tool:IsA('Tool')then
if tool.ToolTip=='Sword'then result.Sword=tool.Name elseif tool.ToolTip=='Gun'then result.Gun=tool.Name
elseif tool.ToolTip=='Blox Fruit'then result.Fruit=tool.Name end
end
end end end
return result
end
function Widgets.Viewport(parent,p)
local frame=new('ViewportFrame',{Name='BodyPreview',Size=UDim2.fromScale(1,1),BackgroundTransparency=1,
Ambient=Color3.fromRGB(185,195,210),LightColor=Color3.fromRGB(245,250,255),LightDirection=Vector3.new(-1,-.3,-1)},parent)
local world=new('WorldModel',{},frame)
local camera=new('Camera',{FieldOfView=34},frame);frame.CurrentCamera=camera
local view={Frame=frame,World=world,Camera=camera,Alive=true,Version=0}
function view:SetPlayer(person)
self.Version=self.Version+1;local version=self.Version
self.Player=person
task.spawn(function()
local model
local char=person.Character
if char then local previous=char.Archivable;char.Archivable=true;local ok,value=pcall(function()return char:Clone()end);char.Archivable=previous;if ok then model=value end end
if not model then local ok,value=pcall(function()local d=Players:GetHumanoidDescriptionFromUserId(person.UserId);return Players:CreateHumanoidModelFromDescription(d,Enum.HumanoidRigType.R15)end);if ok then model=value end end
if not model then return end
if not self.Alive or version~=self.Version then model:Destroy();return end
if self.Model then self.Model:Destroy()end
for _,obj in ipairs(model:GetDescendants())do
if obj:IsA('LuaSourceContainer')or obj:IsA('ParticleEmitter')or obj:IsA('Trail')or obj:IsA('Beam')or obj:IsA('Sound')then obj:Destroy()
elseif obj:IsA('BasePart')then obj.Anchored=true;obj.CanCollide=false end
end
model.Parent=world;model:PivotTo(CFrame.new(0,0,0)*CFrame.Angles(0,math.pi,0));self.Model=model
local cf,size=model:GetBoundingBox();local distance=math.max(size.Y,size.X*1.6)*.5/math.tan(math.rad(17))*1.18
camera.CFrame=CFrame.lookAt(cf.Position+Vector3.new(0,0,distance),cf.Position)
if self.OnChanged then self.OnChanged()end
end)
end
function view:SetHighlight(enabled,color)
self.OriginalColors=self.OriginalColors or setmetatable({},{__mode='k'})
if not self.Model then return end
for _,part in ipairs(self.Model:GetDescendants())do if part:IsA('BasePart')then
if enabled then if not self.OriginalColors[part]then self.OriginalColors[part]=part.Color end;part.Color=self.OriginalColors[part]:Lerp(color,.55)
elseif self.OriginalColors[part]then part.Color=self.OriginalColors[part]end
end end
end
function view:Project(position)
local point=camera.CFrame:PointToObjectSpace(position);local size=frame.AbsoluteSize
local z=-point.Z;if z<=.01 or size.Y<=0 then return nil end
local f=size.Y/(2*math.tan(math.rad(camera.FieldOfView/2)))
return Vector2.new(size.X/2+point.X/z*f,size.Y/2-point.Y/z*f)
end
function view:Geometry(design)
if not self.Model then return nil end
local cf,size=self.Model:GetBoundingBox();local minX,minY,maxX,maxY=math.huge,math.huge,-math.huge,-math.huge
for _,x in ipairs({-1,1})do for _,y in ipairs({-1,1})do for _,z in ipairs({-1,1})do
local point=self:Project(cf:PointToWorldSpace(Vector3.new(size.X*x/2,size.Y*y/2,size.Z*z/2)))
if point then minX,minY,maxX,maxY=math.min(minX,point.X),math.min(minY,point.Y),math.max(maxX,point.X),math.max(maxY,point.Y)end
end end end
if minX==math.huge then return nil end
local data=Widgets.Profile(self.Player);local g={X=minX,Y=minY,W=maxX-minX,H=maxY-minY,Name=data.Name,
Health=data.Health or 100,MaxHealth=data.MaxHealth or 100,Distance=20,Equipment=data.Fruit or 'Fruit / weapon',Bones={}}
for i,pair in ipairs(design.Bones)do local a,b=design.Part(self.Model,pair[1]),design.Part(self.Model,pair[2]);if a and b then
local ap,bp=self:Project(a.Position),self:Project(b.Position);if ap and bp then g.Bones[i]={ap-Vector2.new(minX,minY),bp-Vector2.new(minX,minY)}end
end end
g.Origin=Vector2.new(frame.AbsoluteSize.X/2-minX,frame.AbsoluteSize.Y-minY-3)
local scale=1;local ancestor=frame
while ancestor do for _,child in ipairs(ancestor:GetChildren())do if child:IsA('UIScale')then scale=scale*child.Scale end end;ancestor=ancestor.Parent end
g.X,g.Y,g.W,g.H=g.X/scale,g.Y/scale,g.W/scale,g.H/scale
g.Origin=g.Origin/scale
for _,pair in pairs(g.Bones)do pair[1],pair[2]=pair[1]/scale,pair[2]/scale end
return g
end
function view:Destroy()self.Alive=false;self.Version=self.Version+1;frame:Destroy()end
if p then view:SetPlayer(p)end
return view
end
function Widgets.Palette()
return {Purple=Color3.fromRGB(165,75,230),Red=Color3.fromRGB(220,50,50),Blue=Color3.fromRGB(65,145,255),
Cyan=Color3.fromRGB(55,210,225),Green=Color3.fromRGB(50,190,100),Gold=Color3.fromRGB(238,190,40),Pink=Color3.fromRGB(235,85,150),
Magenta=Color3.fromRGB(190,0,205),White=Color3.fromRGB(245,245,248),Black=Color3.fromRGB(20,20,24),Midnight=Color3.fromRGB(10,12,24),Orange=Color3.fromRGB(255,140,30)}
end
function Widgets.FruitImage(fruit)
local rs=game:GetService('ReplicatedStorage');local sprites=rs:FindFirstChild('Spritesheets')
if sprites then
local ok,result=pcall(function()local map=require(sprites);local image=map.match(tostring(fruit)..'1'):unwrap();return image end)
if ok and result and type(result.Image)=='string'and result.Image~=''then return result end
end
local p=Players.LocalPlayer;local containers={};if p.Character then containers[#containers+1]=p.Character end
local backpack=p:FindFirstChildOfClass('Backpack');if backpack then containers[#containers+1]=backpack end
for _,container in ipairs(containers)do for _,tool in ipairs(container:GetChildren())do
if tool:IsA('Tool')and tool.Name==fruit and tool.TextureId~=''then return {Image=tool.TextureId}end
end end
local pg=p:FindFirstChildOfClass('PlayerGui')
if pg then for _,image in ipairs(pg:GetDescendants())do
if(image:IsA('ImageLabel')or image:IsA('ImageButton'))and image.Image~=''then
local parent=image.Parent
if image.Name==fruit or(parent and(parent.Name==fruit or(parent:FindFirstChild('ToolName')and parent.ToolName.Text==fruit)))then return {Image=image.Image,ImageRectOffset=image.ImageRectOffset,ImageRectSize=image.ImageRectSize}end
end
end end
return nil
end
return Widgets
