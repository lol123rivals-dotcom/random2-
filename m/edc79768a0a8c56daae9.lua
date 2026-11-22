local Run=game:GetService('RunService')
local Input=game:GetService('UserInputService')
local M={}
local pet
local config={Size=160,Follow=true,Pose='Stand',Mood='Calm'}
local function new(class,props,parent)local o=Instance.new(class);for k,v in pairs(props)do o[k]=v end;o.Parent=parent;return o end
function M.Destroy()
if not pet then return end;pet.Alive=false
for _,c in ipairs(pet.Connections)do c:Disconnect()end;pet.Root:Destroy();pet=nil
end
function M.Spawn(options)
M.Destroy();options=options or{}
local width=config.Size
local root=new('Frame',{Name='YukiCompanion',BackgroundColor3=Color3.fromRGB(10,12,16),BackgroundTransparency=.15,
BorderSizePixel=0,Size=UDim2.fromOffset(width,width*1.35),Position=UDim2.new(1,-width-20,1,-width*1.35-35)},options.Parent)
new('UICorner',{CornerRadius=UDim.new(0,18)},root)
local viewport=new('ViewportFrame',{Name='Character',BackgroundTransparency=1,Size=UDim2.new(1,0,1,-34),Ambient=Color3.fromRGB(190,190,205),LightColor=Color3.fromRGB(255,245,235)},root)
local world=new('WorldModel',{},viewport);local camera=new('Camera',{FieldOfView=32,CFrame=CFrame.lookAt(Vector3.new(0,.8,8),Vector3.new(0,.8,0))},viewport);viewport.CurrentCamera=camera
local model=new('Model',{Name='Yuki'},world)
local skin=Color3.fromRGB(245,215,200);local hair=Color3.fromRGB(35,40,56);local dress=Color3.fromRGB(135,210,225)
local bases={};local rightArm
local function part(name,size,position,color,shape)
local p=new('Part',{Name=name,Size=size,CFrame=CFrame.new(position),Color=color,Anchored=true,CanCollide=false,Material=Enum.Material.SmoothPlastic,Shape=shape or Enum.PartType.Block},model)
bases[p]=p.CFrame;return p
end
part('Hair',Vector3.new(1.25,1.35,.95),Vector3.new(0,2,-.14),hair,Enum.PartType.Ball)
part('Face',Vector3.new(1,1.05,.9),Vector3.new(0,1.97,.12),skin,Enum.PartType.Ball)
part('BangsL',Vector3.new(.46,.45,.27),Vector3.new(-.33,2.35,.46),hair,Enum.PartType.Ball)
part('BangsR',Vector3.new(.46,.36,.27),Vector3.new(.23,2.39,.46),hair,Enum.PartType.Ball)
local leftEye=part('EyeL',Vector3.new(.09,.15,.05),Vector3.new(-.23,2.02,.56),hair,Enum.PartType.Ball)
local rightEye=part('EyeR',Vector3.new(.09,.15,.05),Vector3.new(.23,2.02,.56),hair,Enum.PartType.Ball)
part('BlushL',Vector3.new(.16,.055,.025),Vector3.new(-.34,1.88,.54),Color3.fromRGB(238,160,165),Enum.PartType.Ball)
part('BlushR',Vector3.new(.16,.055,.025),Vector3.new(.34,1.88,.54),Color3.fromRGB(238,160,165),Enum.PartType.Ball)
part('Mouth',Vector3.new(.12,.035,.025),Vector3.new(0,1.79,.56),hair,Enum.PartType.Ball)
for _,side in ipairs({-1,1})do
local ear=new('WedgePart',{Name='CatEar',Size=Vector3.new(.34,.5,.28),CFrame=CFrame.new(side*.48,2.65,-.05)*CFrame.Angles(0,0,math.rad(side*-16)),Color=hair,Anchored=true,CanCollide=false},model);bases[ear]=ear.CFrame
part('HairStrand',Vector3.new(.25,1.16,.34),Vector3.new(side*.57,1.65,-.05),hair,Enum.PartType.Ball)
end
part('Neck',Vector3.new(.25,.25,.25),Vector3.new(0,1.34,0),skin)
part('Dress',Vector3.new(.85,1.05,.52),Vector3.new(0,.75,0),dress)
part('Skirt',Vector3.new(1.07,.45,.65),Vector3.new(0,.12,0),dress)
part('ArmL',Vector3.new(.24,.85,.28),Vector3.new(-.59,.76,0),skin,Enum.PartType.Ball)
rightArm=part('ArmR',Vector3.new(.24,.85,.28),Vector3.new(.59,.76,0),skin,Enum.PartType.Ball)
for _,side in ipairs({-1,1})do
part('Leg',Vector3.new(.29,.78,.31),Vector3.new(side*.24,-.47,0),Color3.fromRGB(232,236,243))
part('Shoe',Vector3.new(.34,.24,.5),Vector3.new(side*.24,-.94,.10),hair)
end
local label=new('TextLabel',{Text='Yuki · Calm',Font=Enum.Font.GothamMedium,TextSize=12,TextColor3=Color3.fromRGB(230,235,242),BackgroundTransparency=1,
Size=UDim2.new(1,-38,0,30),Position=UDim2.new(0,12,1,-32),TextXAlignment=Enum.TextXAlignment.Left},root)
local close=new('TextButton',{Text='×',Font=Enum.Font.Gotham,TextSize=18,TextColor3=Color3.fromRGB(200,205,215),BackgroundTransparency=1,Size=UDim2.fromOffset(30,30),Position=UDim2.new(1,-32,0,0)},root)
pet={Root=root,Alive=true,Connections={},WaveUntil=0}
local p=pet
local function connect(signal,fn)local c=signal:Connect(fn);p.Connections[#p.Connections+1]=c;return c end
connect(close.Activated,function()if options.OnClose then options.OnClose()else M.Destroy()end end)
local start,origin,owner,moved
connect(root.InputBegan,function(input)if input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseButton1 then start,origin,owner,moved=input.Position,root.Position,input,false end end)
connect(Input.InputChanged,function(input)
if not owner then return end
if owner.UserInputType==Enum.UserInputType.Touch and input~=owner then return end
if owner.UserInputType~=Enum.UserInputType.Touch and input.UserInputType~=Enum.UserInputType.MouseMovement then return end
local d=input.Position-start;if d.X*d.X+d.Y*d.Y>36 then moved=true;root.Position=UDim2.new(origin.X.Scale,origin.X.Offset+d.X,origin.Y.Scale,origin.Y.Offset+d.Y)end
end)
connect(Input.InputEnded,function(input)if input==owner or owner and input.UserInputType==Enum.UserInputType.MouseButton1 then if not moved then p.WaveUntil=os.clock()+2 end;owner=nil end end)
local elapsed=0
connect(Run.RenderStepped,function(dt)
elapsed=elapsed+dt;if elapsed<1/24 then return end;elapsed=0
local t=os.clock();local yaw=0
if config.Follow then local cursor=Input:GetMouseLocation();yaw=math.clamp((cursor.X-root.AbsolutePosition.X-width/2)/600,-.35,.35)end
local motion=CFrame.new(0,math.sin(t*1.8)*.035,0)*CFrame.Angles(0,yaw,0)
for part,base in pairs(bases)do
local cf=base
if part==rightArm and t<p.WaveUntil then cf=CFrame.new(.68,1.2,0)*CFrame.Angles(0,0,math.rad(125)+math.sin(t*14)*.18)end
if config.Pose=='Sit'and(part.Name=='Leg'or part.Name=='Shoe')then cf=CFrame.new(base.Position.X,-.15,.35)*CFrame.Angles(math.rad(-75),0,0)end
part.CFrame=motion*cf
end
local happy=config.Mood=='Happy';leftEye.Size=Vector3.new(.09,happy and .055 or .15,.05);rightEye.Size=leftEye.Size
label.Text='Yuki · '..config.Mood
end)
return p
end
function M.SetSize(value)config.Size=math.clamp(value,100,240);if pet then pet.Root.Size=UDim2.fromOffset(config.Size,config.Size*1.35)end end
function M.SetFollow(value)config.Follow=value==true end
function M.SetPose(value)config.Pose=value end
function M.SetMood(value)config.Mood=value end
function M.TriggerWave()if pet then pet.WaveUntil=os.clock()+2.2 end end
function M.GetActive()return pet end
return M
