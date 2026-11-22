local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local localPlayer = lp or Players.LocalPlayer
local character = localPlayer.Character
local humanoidRootPart = character and (character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso"))
localPlayer.CharacterAdded:Connect(function(newCharacter)
character = newCharacter
humanoidRootPart = newCharacter:WaitForChild("HumanoidRootPart", 5)
end)
local function ensureHRP()
if humanoidRootPart and humanoidRootPart.Parent then return humanoidRootPart end
local c = localPlayer.Character
humanoidRootPart = c and (c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("UpperTorso"))
return humanoidRootPart
end
local netFolder = ReplicatedStorage:FindFirstChild("Modules")
netFolder = netFolder and netFolder:FindFirstChild("Net")
local registerAttack = netFolder and netFolder:FindFirstChild("RE/RegisterAttack")
local registerHit = netFolder and netFolder:FindFirstChild("RE/RegisterHit")
local enemiesFolder = Workspace:FindFirstChild("Enemies") or Workspace
local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes")
local commF = remotesFolder and remotesFolder:FindFirstChild("CommF_")
local BOSS_ROOMS = { [5] = true, [10] = true, [15] = true, [20] = true }
local function GetDungeonRooms()
local mapFolder = Workspace:FindFirstChild("Map")
if not mapFolder then return {} end
local dungeonFolder = mapFolder:FindFirstChild("Dungeon")
if not dungeonFolder then return {} end
local rooms = dungeonFolder:GetChildren()
table.sort(rooms, function(a, b)
local numA = tonumber(string.match(a.Name, "%d+")) or 0
local numB = tonumber(string.match(b.Name, "%d+")) or 0
return numA < numB
end)
return rooms
end
local function GetCurrentRoomNumber()
local hrp = ensureHRP()
if not hrp then return 0 end
local rooms = GetDungeonRooms()
if #rooms == 0 then return 0 end
local myPos = hrp.Position
local currentRoomIdx = 1
local minDist = math.huge
for i, room in ipairs(rooms) do
local roomPart = room:FindFirstChildOfClass("Part")
or room:FindFirstChildOfClass("MeshPart")
or room:FindFirstChild("Floor")
if roomPart then
local dist = (roomPart.Position - myPos).Magnitude
if dist < minDist then
minDist = dist
currentRoomIdx = i
end
end
end
local room = rooms[currentRoomIdx]
if not room then return currentRoomIdx end
return tonumber(string.match(room.Name, "%d+")) or currentRoomIdx
end
local function IsBossModel(obj)
if not obj then return false end
local n = string.lower(obj.Name or "")
if string.find(n, "shadow", 1, true) or string.find(n, "sombra", 1, true) then return false end
if string.find(n, "buddy", 1, true) or string.find(n, "clone", 1, true) then return false end
if string.find(n, "fruit", 1, true) then return false end
if string.find(n, "summon", 1, true) or string.find(n, "ally", 1, true) then return false end
if string.find(n, "ancient beast", 1, true) then return true end
if string.find(n, "ancient", 1, true) and string.find(n, "beast", 1, true) then return true end
if string.find(n, "kitsune lord", 1, true) then return true end
if string.find(n, "kitsune", 1, true) and string.find(n, "lord", 1, true) then return true end
if string.find(n, "gas knight", 1, true) then return true end
if string.find(n, "gas", 1, true) and string.find(n, "knight", 1, true) then return true end
if n == "zero" or string.find(n, "zero", 1, true) then return true end
if string.find(n, "boss", 1, true) then return true end
return false
end
local function GetAliveBoss()
local sourceFolder = Workspace:FindFirstChild("Enemies") or enemiesFolder
if not sourceFolder then return nil end
local best, bestDist = nil, math.huge
local hrp = ensureHRP()
if not hrp then return nil end
for _, obj in ipairs(sourceFolder:GetChildren()) do
if obj:IsA("Model") and IsBossModel(obj) then
local hum = obj:FindFirstChildOfClass("Humanoid")
local root = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Head")
if hum and hum.Health > 0 and root then
local d = (root.Position - hrp.Position).Magnitude
if d < bestDist then
bestDist = d
best = obj
end
end
end
end
return best
end
local function HasAliveBoss()
return GetAliveBoss() ~= nil
end
local currentTarget = nil
local lastTarget = nil
local VoidConfig = {
Enabled = false,
Interval = 0.08,
VoidOnlyBossRoom = true,
}
local AutoLoad = true
local function GetPlayerFruit()
local char = localPlayer.Character
if char then
for _, tool in ipairs(char:GetChildren()) do
if tool:IsA("Tool") and tool.ToolTip == "Blox Fruit" then
return tool
end
end
end
local backpack = localPlayer:FindFirstChild("Backpack")
if backpack then
for _, tool in ipairs(backpack:GetChildren()) do
if tool:IsA("Tool") and tool.ToolTip == "Blox Fruit" then
return tool
end
end
end
return nil
end
local function GetMaxCombo(tool)
if not tool then return 5 end
local n = tool.Name
if n == "T-Rex-T-Rex" then return 4 end
if n == "Blade-Blade" then return 2 end
if n == "Pain-Pain" then return 4 end
if n == "Control-Control" then return 4 end
if n == "Gas-Gas" then return 5 end
if n == "Kitsune-Kitsune" then return 5 end
if n == "Magma-Magma" then return 5 end
if n == "Dragon-Dragon" then
local char = localPlayer.Character
return (char and char:FindFirstChild("DragonHybrid")) and 5 or 3
end
return 5
end
local voidRunning = false
local lastRoomNum = -1
local function IsAllyModel_Safe(object)
if not object then return true end
local n = string.lower(object.Name or "")
if string.find(n, "shadow", 1, true) or string.find(n, "sombra", 1, true) then return true end
if string.find(n, "buddy", 1, true) or string.find(n, "clone", 1, true) then return true end
if string.find(n, "summon", 1, true) or string.find(n, "ally", 1, true) then return true end
if Players:GetPlayerFromCharacter(object) then return true end
return false
end
local function CanUseVoidNow()
if not VoidConfig.Enabled then return false end
local roomNum = GetCurrentRoomNumber()
if VoidConfig.VoidOnlyBossRoom then
if not BOSS_ROOMS[roomNum] then
return false
end
end
if HasAliveBoss() then
return true
end
if BOSS_ROOMS[roomNum] then
local folder = Workspace:FindFirstChild("Enemies") or enemiesFolder
if folder then
for _, obj in ipairs(folder:GetChildren()) do
if obj:IsA("Model") and not IsAllyModel_Safe(obj) then
local hum = obj:FindFirstChildOfClass("Humanoid")
if hum and hum.Health > 0 and hum.MaxHealth >= 50000 then
return true
end
end
end
end
end
return false
end
local function VoidLoop()
if voidRunning then return end
voidRunning = true
task.spawn(function()
while VoidConfig.Enabled do
pcall(function()
local roomNum = GetCurrentRoomNumber()
if roomNum ~= lastRoomNum then
lastRoomNum = roomNum
end
if not CanUseVoidNow() then return end
local fruit = GetPlayerFruit()
if not fruit then return end
local remote = fruit:FindFirstChild("LeftClickRemote")
if not remote then return end
local char = localPlayer.Character
if char and fruit.Parent ~= char then
local hum = char:FindFirstChildOfClass("Humanoid")
if hum then pcall(function() hum:EquipTool(fruit) end) end
end
local maxCombo = GetMaxCombo(fruit)
remote:FireServer(Vector3.new(9e30, 9e30, 9e30), maxCombo, true)
end)
task.wait(tonumber(VoidConfig.Interval) or 0.08)
end
voidRunning = false
lastRoomNum = -1
end)
end
local justDied = false
local attackHeight = 40
local selectedWeapon = "Sword"
local weaponOptions = { "Sword", "Melee", "Blox Fruit" }
local autoDungeonActive = false
local autoV4Active = false
localPlayer.CharacterAdded:Connect(function()
justDied = true
end)
local function GetWeaponInBackpack(weaponName)
local backpack = localPlayer:FindFirstChildOfClass("Backpack")
if not backpack then return nil end
for _, tool in ipairs(backpack:GetChildren()) do
if string.find(string.lower(tool.Name), string.lower(weaponName), 1, true) or tool.ToolTip == weaponName then
return tool
end
end
return nil
end
local function EquipSelectedWeapon()
if not character or not autoDungeonActive then return end
if VoidConfig.Enabled and CanUseVoidNow() then
local fruit = GetPlayerFruit()
if fruit then
local hum = character:FindFirstChildOfClass("Humanoid")
if hum and fruit.Parent ~= character then
pcall(function() hum:EquipTool(fruit) end)
end
return
end
end
local currentTool = character:FindFirstChildOfClass("Tool")
if currentTool and (string.find(string.lower(currentTool.Name), string.lower(selectedWeapon), 1, true) or currentTool.ToolTip == selectedWeapon) then
return
end
local toolToEquip = GetWeaponInBackpack(selectedWeapon)
if toolToEquip then
local humanoid = character:FindFirstChildOfClass("Humanoid")
if humanoid then humanoid:EquipTool(toolToEquip) end
end
end
local function ForceActivateHaki()
if not character or not autoDungeonActive then return end
if not character:FindFirstChild("HasBuso") then
pcall(function() commF:InvokeServer("Buso") end)
end
end
task.spawn(function()
while true do
task.wait(0.5)
if autoV4Active and autoDungeonActive and character then
pcall(function()
VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Y, false, game)
task.wait(0.1)
VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Y, false, game)
end)
end
end
end)
local function StartAutoBuffs()
task.spawn(function()
while autoDungeonActive do
EquipSelectedWeapon()
task.wait(0.3)
end
end)
task.spawn(function()
while autoDungeonActive do
ForceActivateHaki()
task.wait(0.15)
end
end)
end
local function IsAllyModel(object)
return IsAllyModel_Safe(object)
end
local function IsValidEnemy(object, currentCharacter, jefeVivo)
if not object or not object:IsA("Model") then return false end
if object == currentCharacter then return false end
if IsAllyModel(object) then return false end
if object.Name == "PropHitboxPlaceholder" and not jefeVivo then return false end
local humanoid = object:FindFirstChildOfClass("Humanoid")
local root = object:FindFirstChild("HumanoidRootPart") or object:FindFirstChild("Head")
if not humanoid or humanoid.Health <= 0 or not root or not object.Parent then return false end
return true
end
local function GetClosestEnemy()
if justDied then return nil end
local currentCharacter = localPlayer.Character
if not currentCharacter or not currentCharacter:FindFirstChild("HumanoidRootPart") then return nil end
local myPos = currentCharacter.HumanoidRootPart.Position
local sourceFolder = Workspace:FindFirstChild("Enemies") or enemiesFolder
if not sourceFolder then return nil end
local jefeVivo = HasAliveBoss()
local closestEnemy, shortestDistance = nil, math.huge
for _, object in ipairs(sourceFolder:GetChildren()) do
if IsValidEnemy(object, currentCharacter, jefeVivo) then
local root = object:FindFirstChild("HumanoidRootPart") or object:FindFirstChild("Head")
local distance = (root.Position - myPos).Magnitude
if IsBossModel(object) then
distance = distance - 80
end
if distance < shortestDistance then
shortestDistance = distance
closestEnemy = object
end
end
end
return closestEnemy
end
local function EnemyStillAlive(enemy)
if not enemy or not enemy.Parent then return false end
local hum = enemy:FindFirstChildOfClass("Humanoid")
return hum and hum.Health > 0
end
local TP_BYPASS_RANGE = 320
local TWEEN_SPEED = 900
local lastHpWatch = {}
local function TweenNearEnemy(enemyRoot)
if not humanoidRootPart or not enemyRoot then return end
local dest = enemyRoot.Position + Vector3.new(0, attackHeight, 0)
local dist = (humanoidRootPart.Position - dest).Magnitude
if dist <= 35 then
humanoidRootPart.CFrame = CFrame.new(dest)
return
end
local approach = math.min(dist, TP_BYPASS_RANGE * 0.85)
local alpha = math.clamp(approach / dist, 0.35, 0.92)
local mid = humanoidRootPart.Position:Lerp(dest, alpha)
mid = Vector3.new(mid.X, dest.Y, mid.Z)
local t = math.clamp(dist / TWEEN_SPEED, 0.04, 0.55)
local tw = TweenService:Create(humanoidRootPart, TweenInfo.new(t, Enum.EasingStyle.Linear), {
CFrame = CFrame.new(mid)
})
tw:Play()
tw.Completed:Wait()
if enemyRoot.Parent then
pcall(function()
humanoidRootPart.CFrame = enemyRoot.CFrame * CFrame.new(0, attackHeight, 0)
end)
end
end
local function TeleportToEnemy(enemy)
if not enemy or not enemy.Parent or not humanoidRootPart then return false end
local enemyRoot = enemy:FindFirstChild("HumanoidRootPart") or enemy:FindFirstChild("Head")
if not enemyRoot then return false end
local dist = (humanoidRootPart.Position - enemyRoot.Position).Magnitude
local hum = enemy:FindFirstChildOfClass("Humanoid")
local key = tostring(enemy)
local prevHp = lastHpWatch[key]
local curHp = hum and hum.Health or nil
local noDamage = false
if prevHp and curHp and curHp >= prevHp - 0.5 and dist > 55 then
noDamage = true
end
if curHp then lastHpWatch[key] = curHp end
if dist > TP_BYPASS_RANGE or noDamage then
TweenNearEnemy(enemyRoot)
return true
end
local success = pcall(function()
humanoidRootPart.CFrame = enemyRoot.CFrame * CFrame.new(0, attackHeight, 0)
end)
if not success then
TweenNearEnemy(enemyRoot)
end
return true
end
local function AttackEnemy(enemy)
if not enemy or not enemy.Parent then return end
local enemyHead = enemy:FindFirstChild("Head") or enemy:FindFirstChild("HumanoidRootPart")
local enemyHumanoid = enemy:FindFirstChildOfClass("Humanoid")
if not enemyHead or not enemyHumanoid then return end
local tool = character and character:FindFirstChildOfClass("Tool")
if tool then tool:Activate() end
pcall(function()
registerAttack:FireServer(0)
registerHit:FireServer(enemyHead, { { enemy, enemyHead } })
end)
end
local function AutoPassRoom()
local rooms = GetDungeonRooms()
if #rooms == 0 then return false end
local currentRoomIdx = 1
if humanoidRootPart then
local myPos = humanoidRootPart.Position
local minDistanceToRoomCenter = math.huge
for i, room in ipairs(rooms) do
local roomPart = room:FindFirstChildOfClass("Part")
or room:FindFirstChildOfClass("MeshPart")
or room:FindFirstChild("Floor")
if roomPart then
local dist = (roomPart.Position - myPos).Magnitude
if dist < minDistanceToRoomCenter then
minDistanceToRoomCenter = dist
currentRoomIdx = i
end
end
end
end
local activeRoom = rooms[currentRoomIdx]
if not activeRoom then return false end
local teleporter = activeRoom:FindFirstChild("ExitTeleporter")
if not teleporter then return false end
local rootPart = teleporter:FindFirstChild("Root")
if not rootPart or not rootPart:IsA("BasePart") or not humanoidRootPart then return false end
humanoidRootPart.CFrame = rootPart.CFrame
task.wait(0.12)
if firetouchinterest then
pcall(function()
firetouchinterest(humanoidRootPart, rootPart, 0)
task.wait(0.1)
firetouchinterest(humanoidRootPart, rootPart, 1)
end)
end
if justDied then justDied = false end
return true
end
local function RotateTargets()
while autoDungeonActive do
if justDied then
local attempts = 0
while autoDungeonActive and justDied and attempts < 10 do
if AutoPassRoom() then
justDied = false
break
end
attempts = attempts + 1
task.wait(0.5)
end
if attempts >= 10 then justDied = false end
else
if not EnemyStillAlive(currentTarget) or IsAllyModel(currentTarget) then
currentTarget = nil
local roomNum = GetCurrentRoomNumber()
if BOSS_ROOMS[roomNum] then
currentTarget = GetAliveBoss() or GetClosestEnemy()
else
currentTarget = GetClosestEnemy()
end
lastTarget = currentTarget
end
if currentTarget and EnemyStillAlive(currentTarget) and not IsAllyModel(currentTarget) then
while autoDungeonActive and not justDied
and EnemyStillAlive(currentTarget) and not IsAllyModel(currentTarget) do
TeleportToEnemy(currentTarget)
AttackEnemy(currentTarget)
task.wait(0.03)
end
currentTarget = nil
else
task.wait(0.4)
if not AutoPassRoom() then
task.wait(0.3)
end
end
end
end
end
local E={}
function E.SetEnabled(value)
autoDungeonActive=value
if value then justDied=false;StartAutoBuffs();task.spawn(RotateTargets)else currentTarget=nil;lastTarget=nil;justDied=false end
end
function E.SetOption(key,value)
if key=='Weapon'then selectedWeapon=value elseif key=='Height'then attackHeight=value elseif key=='AutoV4'then autoV4Active=value
elseif key=='AutoLoad'then AutoLoad=value elseif key=='VoidInterval'then VoidConfig.Interval=value elseif key=='BossOnly'then VoidConfig.VoidOnlyBossRoom=value end
end
function E.SetVoid(value)VoidConfig.Enabled=value;if value then voidRunning=false;VoidLoop()end end
function E.Destroy()autoDungeonActive=false;AutoLoad=false;VoidConfig.Enabled=false;currentTarget=nil end
return E
