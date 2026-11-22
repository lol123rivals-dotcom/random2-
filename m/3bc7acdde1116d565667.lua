local Players=game:GetService('Players')
local player=Players.LocalPlayer
local Palette={}
local old=setmetatable({},{__mode='k'})
local connections={}
local selectedColor,selectedFruit
local function remember(object,key,value,attribute)
if not old[object]then old[object]={}end
local name=(attribute and '@'or '')..key
if old[object][name]==nil then old[object][name]={Value=attribute and object:GetAttribute(key)or object[key],Attribute=attribute,Key=key}end
if attribute then object:SetAttribute(key,value)else object[key]=value end
end
local function recolor(object)
if not selectedColor then return end
if object:IsA('ParticleEmitter')or object:IsA('Trail')or object:IsA('Beam')then remember(object,'Color',ColorSequence.new(selectedColor))
elseif object:IsA('PointLight')or object:IsA('SpotLight')then remember(object,'Color',selectedColor)end
end
local function paletteRoot()
for _,root in ipairs({game:GetService('ReplicatedStorage'),game:GetService('Lighting'),workspace})do
local value=root:FindFirstChild(selectedFruit..'FruitVFXColor',true);if value then return value end
end
end
local function applyNativePalette()
local root=paletteRoot();local original=root and root:FindFirstChild('Default');local shifted=root and root:FindFirstChild('Shifted')
if original and shifted then
for index=1,32 do
local base=original:GetAttribute('Default_Color'..index);if typeof(base)~='Color3'then break end
local luminance=math.max(base.R,base.G,base.B)
remember(shifted,'Shifted_Color'..index,selectedColor:Lerp(Color3.new(1,1,1),math.clamp(luminance-.5,0,.35)),true)
end
end
end
local function scan(root)
if not root then return end
for _,object in ipairs(root:GetDescendants())do recolor(object)end
end
function Palette.Apply(fruit,color,name)
Palette.Reset();selectedFruit=tostring(fruit):gsub('%-.*$',''):gsub(' Fruit$','');selectedColor=color
local skins=RequireModule('modules/visuals/skins_system.lua');skins.applyToolSkin('Fruits',name,color)
applyNativePalette()
local function own(object)
local name=object.Name:lower();if name:find(selectedFruit:lower(),1,true)then recolor(object);scan(object)end
end
local wo=workspace:FindFirstChild('_WorldOrigin');if wo then
for _,object in ipairs(wo:GetChildren())do own(object)end
connections[#connections+1]=wo.DescendantAdded:Connect(function(object)
local cursor=object;for _=1,5 do if not cursor then break end;if cursor.Name:lower():find(selectedFruit:lower(),1,true)then recolor(object);break end;cursor=cursor.Parent end
end)
end
local tool=player.Character and player.Character:FindFirstChildOfClass('Tool')
if tool and tool.ToolTip=='Blox Fruit'then scan(tool)end
end
function Palette.Reset()
for _,c in ipairs(connections)do c:Disconnect()end;connections={}
for object,properties in pairs(old)do if object.Parent then for _,data in pairs(properties)do pcall(function()if data.Attribute then object:SetAttribute(data.Key,data.Value)else object[data.Key]=data.Value end end)end end end
old=setmetatable({},{__mode='k'});selectedColor,selectedFruit=nil,nil
end
function Palette.Destroy()Palette.Reset()end
return Palette
