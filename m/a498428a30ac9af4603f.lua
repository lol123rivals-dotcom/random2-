local Raw = RawGame or game
local Players,Input = Raw:GetService('Players'),Raw:GetService('UserInputService')
local Run,CAS = Raw:GetService('RunService'),Raw:GetService('ContextActionService')
local player=Players.LocalPlayer
local mouse=player:GetMouse()
local currentCamera=workspace.CurrentCamera
local S={InfiniteEnabled=false,AimbotEnabled=false,SkillComboEnabled=false,TargetMode='Nearest Player',MaxDistance=2000,
SkillWeapon='Fruit',SkillKey='Z',SkillDelay=.3,Hooked=false,ButtonEnabled=false}
local alive=true
local connections={}
local saved=setmetatable({},{__mode='k'})
local intentUntil,target=0,nil
local forcedNearestUntil=0
local oldIndex,ownIndex,oldNamecall,ownNamecall,mt
local action='SweetSoruAim_'..tostring(player.UserId)
local function connect(signal,fn)local c=signal:Connect(fn);connections[#connections+1]=c;return c end
local function valid(p,root)
if p==player or not p.Character then return nil end
local h=p.Character:FindFirstChildOfClass('Humanoid');local part=p.Character:FindFirstChild('HumanoidRootPart')
if not part or not h or h.Health<=0 or p.Character:FindFirstChildOfClass('ForceField')then return nil end
if player.Team and p.Team==player.Team and p.Team.Name=='Marines'then return nil end
if (part.Position-root.Position).Magnitude>S.MaxDistance then return nil end
return part
end
local function selectTarget(forceNearest)
local root=player.Character and player.Character:FindFirstChild('HumanoidRootPart');if not root then return nil end
if not forceNearest and S.TargetMode=='Selected Player'then
local p=S.SelectedPlayer and Players:FindFirstChild(S.SelectedPlayer);return p and valid(p,root)
end
local best,distance=nil,S.MaxDistance
for _,p in ipairs(Players:GetPlayers())do
local part=valid(p,root)
if part then local d=(part.Position-root.Position).Magnitude;if d<distance then best,distance=part,d end end
end
return best
end
local function aimed()
if not(alive and(S.AimbotEnabled or S.ButtonEnabled)and os.clock()<intentUntil and target)then return nil end
local parent=oldIndex and oldIndex(target,'Parent')or target.Parent
return parent and target or nil
end
local function beginAim(forceNearest)
if not (S.AimbotEnabled or S.ButtonEnabled) then return end
if not forceNearest and os.clock()<forcedNearestUntil and target and target.Parent then intentUntil=os.clock()+.35;return end
target=selectTarget(forceNearest);intentUntil=os.clock()+.35
if forceNearest then forcedNearestUntil=intentUntil end
end
local function installHooks()
if S.Hooked then return end
assert(getrawmetatable and setreadonly and newcclosure,'Soru aiming needs executor metamethod support')
mt=getrawmetatable(Raw);assert(mt,'Game metatable is unavailable')
oldIndex,oldNamecall=mt.__index,mt.__namecall
ownIndex=newcclosure(function(object,key)
if not alive or not(S.AimbotEnabled or S.ButtonEnabled)or os.clock()>=intentUntil then return oldIndex(object,key)end
if checkcaller and checkcaller()then return oldIndex(object,key)end
if object~=mouse and not(object==currentCamera and key=='CFrame')then return oldIndex(object,key)end
local part=aimed()
if part then
if object==mouse then
if key=='Hit'then return CFrame.new(part.Position)elseif key=='Target'then return part end
elseif object==currentCamera then
local actual=oldIndex(object,key);return CFrame.lookAt(actual.Position,part.Position)
end
end
return oldIndex(object,key)
end)
ownNamecall=newcclosure(function(object,...)
local args={...};local method=getnamecallmethod and getnamecallmethod()
if (S.AimbotEnabled or S.ButtonEnabled) and (method=='FireServer'or method=='InvokeServer')then
local kind=args[1]
if kind=='Soru'or kind=='FlashStep'or kind=='Flashstep'then
beginAim();local part=aimed()
if part then for i=2,#args do if typeof(args[i])=='Vector3' then args[i]=part.Position elseif typeof(args[i])=='CFrame'then args[i]=CFrame.new(part.Position)end end end
end
end
return oldNamecall(object,table.unpack(args))
end)
setreadonly(mt,false);mt.__index,mt.__namecall=ownIndex,ownNamecall;setreadonly(mt,true);S.Hooked=true
end
local function cooldown(on)
local char=player.Character;if not char then return end
if on then
if not saved[char]then saved[char]={Value=char:GetAttribute('FlashstepCooldown')}end
char:SetAttribute('FlashstepCooldown',1)
else
for model,value in pairs(saved)do if model.Parent then model:SetAttribute('FlashstepCooldown',value.Value)end;saved[model]=nil end
end
end
local function castCombo()
if not S.SkillComboEnabled then return end
task.delay(S.SkillDelay,function()
if not alive or not S.SkillComboEnabled then return end
local char=player.Character;local h=char and char:FindFirstChildOfClass('Humanoid');local backpack=player:FindFirstChildOfClass('Backpack')
if not h then return end
for _,container in ipairs({char,backpack})do if container then for _,tool in ipairs(container:GetChildren())do
local category=tool.ToolTip=='Blox Fruit'and 'Fruit'or tool.ToolTip
if tool:IsA('Tool')and category==S.SkillWeapon then h:EquipTool(tool);break end
end end end
local key=Enum.KeyCode[S.SkillKey];if key then local vim=Raw:GetService('VirtualInputManager');vim:SendKeyEvent(true,key,false,Raw);task.wait(.05);vim:SendKeyEvent(false,key,false,Raw)end
end)
end
local function input(_,state)
if state==Enum.UserInputState.Begin then beginAim();castCombo()end
return Enum.ContextActionResult.Pass
end
CAS:BindActionAtPriority(action,input,false,3000,Enum.KeyCode.R)
connect(workspace:GetPropertyChangedSignal('CurrentCamera'),function()currentCamera=workspace.CurrentCamera end)
local function bindButton(button)
if not(button:IsA('GuiButton'))then return end
local name=button.Name:lower()
if name=='soru'or name:find('flashstep',1,true)then connect(button.InputBegan,function(event)
if event.UserInputType==Enum.UserInputType.Touch or event.UserInputType==Enum.UserInputType.MouseButton1 then beginAim();castCombo()end
end)end
end
local pg=player:FindFirstChildOfClass('PlayerGui')
if pg then for _,obj in ipairs(pg:GetDescendants())do bindButton(obj)end;connect(pg.DescendantAdded,bindButton)end
local elapsed=0
connect(Run.Heartbeat,function(dt)elapsed=elapsed+dt;if elapsed>=.25 then elapsed=0;if S.InfiniteEnabled then cooldown(true)end end end)
connect(player.CharacterAdded,function()if S.InfiniteEnabled then task.defer(function()cooldown(true)end)end end)
function S.setInfinite(value)S.InfiniteEnabled=value==true;cooldown(S.InfiniteEnabled)end
function S.setAimbot(value)if value then installHooks()end;S.AimbotEnabled=value==true;if not value then intentUntil,target=0,nil end end
function S.setSkillCombo(value)S.SkillComboEnabled=value==true end
function S.BeginAim()beginAim();return target~=nil end
local buttonGui
local buttonConnections={}
local lastSoru=0
function S.SoruToNearest()
assert(S.ButtonEnabled,'Enable the Soru button first')
if os.clock()-lastSoru<.3 then return false end
beginAim(true);assert(target,'No valid player within Soru range')
local char=player.Character
assert(char and char:FindFirstChild('Soru'),'Soru is not unlocked on this character')
lastSoru=os.clock()
local vim=Raw:GetService('VirtualInputManager')
local ok,err=pcall(function()vim:SendKeyEvent(true,Enum.KeyCode.R,false,Raw);vim:SendKeyEvent(false,Enum.KeyCode.R,false,Raw)end)
if not ok then error('Native Soru input is unavailable: '..tostring(err))end
return true
end
function S.setButtonEnabled(value)
S.ButtonEnabled=value==true
for _,c in ipairs(buttonConnections)do c:Disconnect()end;buttonConnections={}
if buttonGui then buttonGui:Destroy();buttonGui=nil end
if not value then return end
installHooks()
buttonGui=Instance.new('ScreenGui');buttonGui.Name='SoruButton';buttonGui.ResetOnSpawn=false;buttonGui.IgnoreGuiInset=true
buttonGui.Parent=(gethui and gethui())or Raw:GetService('CoreGui')
local button=Instance.new('TextButton');button.Name='NativeSoru';button.Text='SORU';button.Font=Enum.Font.GothamBold;button.TextSize=14
button.Size=UDim2.fromOffset(78,42);button.Position=UDim2.new(1,-110,.5,80);button.BackgroundColor3=Color3.fromRGB(18,20,24)
button.TextColor3=Color3.fromRGB(230,235,242);button.BorderSizePixel=0;button.AutoButtonColor=false;button.Parent=buttonGui
local corner=Instance.new('UICorner');corner.CornerRadius=UDim.new(0,12);corner.Parent=button
local owner,start,origin,moved
local function buttonConnect(signal,fn)local c=connect(signal,fn);buttonConnections[#buttonConnections+1]=c;return c end
buttonConnect(button.InputBegan,function(event)
if event.UserInputType==Enum.UserInputType.Touch or event.UserInputType==Enum.UserInputType.MouseButton1 then owner,start,origin,moved=event,event.Position,button.Position,false end
end)
buttonConnect(Input.InputChanged,function(event)
if not owner then return end
if owner.UserInputType==Enum.UserInputType.Touch and event~=owner then return end
if owner.UserInputType~=Enum.UserInputType.Touch and event.UserInputType~=Enum.UserInputType.MouseMovement then return end
local d=event.Position-start;if d.X*d.X+d.Y*d.Y>36 then moved=true;button.Position=UDim2.new(origin.X.Scale,origin.X.Offset+d.X,origin.Y.Scale,origin.Y.Offset+d.Y)end
end)
buttonConnect(Input.WindowFocusReleased,function()owner=nil;moved=true end)
buttonConnect(Input.InputEnded,function(event)
if not owner then return end
if owner.UserInputType==Enum.UserInputType.Touch and event~=owner then return end
if owner.UserInputType~=Enum.UserInputType.Touch and event.UserInputType~=Enum.UserInputType.MouseButton1 then return end
owner=nil
if not moved and event.UserInputState~=Enum.UserInputState.Cancel then local ok,err=pcall(S.SoruToNearest);if not ok then button.Text='NO TARGET';task.delay(1,function()if button.Parent then button.Text='SORU'end end);warn(err)end end
end)
end
function S.Destroy()
alive=false;S.AimbotEnabled,S.InfiniteEnabled,S.SkillComboEnabled,S.ButtonEnabled=false,false,false,false;cooldown(false)
if buttonGui then buttonGui:Destroy();buttonGui=nil end
CAS:UnbindAction(action);for _,c in ipairs(connections)do c:Disconnect()end
if mt then pcall(function()setreadonly(mt,false);if mt.__index==ownIndex then mt.__index=oldIndex end;if mt.__namecall==ownNamecall then mt.__namecall=oldNamecall end;setreadonly(mt,true)end)end
end
return S
