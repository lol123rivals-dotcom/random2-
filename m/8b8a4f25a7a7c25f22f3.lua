local Raw=RawGame or game
local P,RS=Raw:GetService('Players'),Raw:GetService('ReplicatedStorage')
local Debris,Tween=Raw:GetService('Debris'),Raw:GetService('TweenService')
local F={Bullets=false,Hits=false,Sound=false,Style='Neon',HitStyle='Pulse',SoundId='rbxasset://sounds/button.wav',Volume=.5,Color=Color3.fromRGB(120,225,255)}
local module,original,wrapped,lastAttack,lastFeedback=nil,nil,nil,0,0
local connections,started={},false
local function playSound(position)
local part=Instance.new('Part');part.Size=Vector3.new(.1,.1,.1);part.Position=position;part.Transparency=1;part.Anchored=true;part.CanCollide=false;part.CanTouch=false;part.CanQuery=false;part.Parent=workspace
local sound=Instance.new('Sound');sound.SoundId=F.SoundId;sound.Volume=F.Volume;sound.RollOffMaxDistance=160;sound.Parent=part;sound:Play();Debris:AddItem(part,3)
end
local function line(a,b)
local delta=b-a;if delta.Magnitude<.1 then return end
local part=Instance.new('Part');part.Name='SweetBulletEffect';part.Anchored=true;part.CanCollide=false;part.CanTouch=false;part.CanQuery=false;part.CastShadow=false;part.Material=Enum.Material.Neon;part.Color=F.Color
part.Size=Vector3.new(.18,.18,delta.Magnitude);part.CFrame=CFrame.lookAt((a+b)/2,b);part.Parent=workspace
Tween:Create(part,TweenInfo.new(.4),{Transparency=1}):Play();Debris:AddItem(part,.45)
end
local function feedback(data)
if os.clock()-lastAttack>3 or os.clock()-lastFeedback<.055 then return end
local char=P.LocalPlayer.Character;local root=char and char:FindFirstChild('HumanoidRootPart')
local hit=data.Root;local point=hit and hit.Position or data.Position
if not root or typeof(point)~='Vector3'or(hit and hit:IsDescendantOf(char))then return end
lastFeedback=os.clock()
if F.Bullets then
local tool=char:FindFirstChildOfClass('Tool');local handle=tool and tool:FindFirstChild('Handle');local start=handle and handle.Position or root.Position
if F.Style=='Lightning'then local prior=start;for i=1,5 do local p=i==5 and point or start:Lerp(point,i/5)+Vector3.new(math.random(-2,2),math.random(-2,2),math.random(-2,2));line(prior,p);prior=p end else line(start,point)end
end
if F.Hits then
local part=Instance.new('Part');part.Name='SweetHitEffect';part.Anchored=true;part.CanCollide=false;part.CanTouch=false;part.CanQuery=false;part.CastShadow=false;part.Material=Enum.Material.Neon;part.Color=F.Color;part.Transparency=.2
part.Shape=F.HitStyle=='Pulse'and Enum.PartType.Ball or Enum.PartType.Block;part.Size=Vector3.new(.5,.5,.5);part.Position=point;part.Parent=workspace
Tween:Create(part,TweenInfo.new(.28),{Size=Vector3.new(7,7,7),Transparency=1}):Play();Debris:AddItem(part,.3)
end
if F.Sound then playSound(point)end
end
local function stop()
for _,connection in ipairs(connections)do connection:Disconnect()end;connections={};started=false
if module and module.Run==wrapped then module.Run=original end
module,original,wrapped=nil,nil,nil
end
local function update()
if not(F.Bullets or F.Hits or F.Sound)then stop();return end
if started then return end
started=true
local effect=RS:FindFirstChild('Effect');local container=effect and effect:FindFirstChild('Container');local misc=container and container:FindFirstChild('Misc');local damage=misc and misc:FindFirstChild('Damage')
local hooked=false
if damage then
local ok,value=pcall(require,damage)
if ok and type(value)=='table'and type(value.Run)=='function'then
module=value;original=module.Run
wrapped=function(data,...)
local results=table.pack(original(data,...))
task.defer(function()pcall(feedback,data)end)
return table.unpack(results,1,results.n)
end
hooked=pcall(function()module.Run=wrapped end)
end
end
F.Backend=hooked and 'Native damage feedback'or 'Native damage counters'
if not hooked then
local root=workspace:FindFirstChild('_WorldOrigin')or workspace:FindFirstChildOfClass('Terrain')or workspace
connections[#connections+1]=root.DescendantAdded:Connect(function(object)
if not object:IsA('BillboardGui')or not object.Name:lower():find('damage',1,true)then return end
task.delay(.05,function()
if not started or not object.Parent then return end
local point=object.StudsOffsetWorldSpace
if typeof(point)=='Vector3'and point.Magnitude>.01 then pcall(feedback,{Position=point})end
end)
end)
end
connections[#connections+1]=Raw:GetService('UserInputService').InputBegan:Connect(function(input,processed)
if not processed and(input.UserInputType==Enum.UserInputType.MouseButton1 or input.KeyCode==Enum.KeyCode.Z or input.KeyCode==Enum.KeyCode.X or input.KeyCode==Enum.KeyCode.C or input.KeyCode==Enum.KeyCode.V or input.KeyCode==Enum.KeyCode.F)then lastAttack=os.clock()end
end)
end
function F.PreviewEffects()
local char=P.LocalPlayer.Character;local root=char and char:FindFirstChild('HumanoidRootPart');assert(root,'Character unavailable')
local bullets,hits,sound=F.Bullets,F.Hits,F.Sound
F.Bullets,F.Hits,F.Sound=true,true,false;lastAttack,lastFeedback=os.clock(),-math.huge
local ok,reason=pcall(feedback,{Position=root.Position+root.CFrame.LookVector*14})
F.Bullets,F.Hits,F.Sound=bullets,hits,sound
assert(ok,reason)
end
function F.SetBullets(v)F.Bullets=v;update()end
function F.SetHits(v)F.Hits=v;update()end
function F.SetSound(v)F.Sound=v;update()end
function F.TestSound()local c=P.LocalPlayer.Character;local root=c and c:FindFirstChild('HumanoidRootPart');if root then playSound(root.Position)end end
function F.Destroy()F.Bullets,F.Hits,F.Sound=false,false,false;stop()end
return F
