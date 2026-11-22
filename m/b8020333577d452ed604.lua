if not game:IsLoaded() then game.Loaded:Wait() end
assert(type(loadstring) == "function", "Your executor must support loadstring.")
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
while not player do task.wait(); player = Players.LocalPlayer end
local reconnectPlaceId = game.PlaceId
local function detectThirdSea()
local ok, mapName = pcall(function() return workspace:GetAttribute("MAP") end)
if ok and (mapName == "Sea1" or mapName == "Sea2" or mapName == "Sea3") then
return mapName == "Sea3", "workspace.MAP = " .. mapName
end
if game.PlaceId == 7449423635 then return true, "recognized Third Sea place" end
local gui = player:FindFirstChild("PlayerGui")
if gui then
for _, item in ipairs(gui:GetDescendants()) do
if item:IsA("TextLabel") or item:IsA("TextButton") then
local text = tostring(item.Text or ""):lower()
if #text < 160 and (text:match("v%d+%.") or item.Name:lower():find("version", 1, true)) then
local sea = text:match("sea%s*(%d+)")
if sea then return sea == "3", "game version footer: Sea" .. sea end
end
end
end
end
local landmarks = { tikioutpost = true, floatingturtle = true, hydraisland = true, hauntedcastle = true }
local map = workspace:FindFirstChild("Map")
if map then
for _, item in ipairs(map:GetChildren()) do
if landmarks[item.Name:lower():gsub("[^%w]", "")] then return true, "Third Sea map landmark: " .. item.Name end
end
end
return false, "Sea not identified yet (place " .. tostring(game.PlaceId) .. ")"
end
local env = (getgenv and getgenv()) or _G
local resume = env.TikiKaitunResume
env.TikiKaitunResume = nil
local function optionalService(name)
local ok, service = pcall(function() return game:GetService(name) end)
if ok then return service end
end
local TeleportService = optionalService("TeleportService")
local CoreGui = optionalService("CoreGui")
local VirtualUser = optionalService("VirtualUser")
local HttpService = optionalService("HttpService")
local settingsPath = "TikiKaitun_v3_" .. tostring(player.UserId or "local") .. ".json"
local function savedSnapshot()
local memory = env.TikiKaitunSaved
if type(memory) == "table" and memory.UserId == player.UserId then return memory end
local read = readfile or env.readfile
if type(read) == "function" and HttpService then
local ok, saved = pcall(function() return HttpService:JSONDecode(read(settingsPath)) end)
if ok and type(saved) == "table" and saved.Version == 3 and saved.UserId == player.UserId then return saved end
end
end
if env.TikiKaitun and type(env.TikiKaitun.Destroy) == "function" then
env.TikiKaitun:Destroy()
end
if type(resume) ~= "table" then resume = savedSnapshot() end
local cfg = {
Enabled = false,
FarmNPCs = true,
SpawnBoss = true,
KillBoss = true,
NPCTarget = "Tyrant farm group",
Protection = false,
ResetAfterEscape = false,
LowHP = 25,
ResumeHP = 75,
EscapeHeight = 600,
ResetDelay = 2,
TPRange = 320,
TweenSpeed = 210,
Distance = 8,
WeaponType = "Melee",
WeaponName = "",
CombatRemotes = true,
FastAttack = true,
AutoBuso = true,
Skills = false,
BreakableMode = "Guitar M1 + skills",
WebhookEnabled = true,
WebhookURL = "",
WebhookIntervalMinutes = 60,
AutoV4 = false,
ESPNPCs = false,
ESPBoss = false,
AntiAFK = true,
AutoReconnect = true,
AutoResume = true,
AutoRecovery = true,
ReconnectDelay = 5,
MaxReconnectAttempts = 10,
}
local resumeEnabled=false
if type(resume) == "table" and type(resume.Config) == "table" then
for key, default in pairs(cfg) do
if type(resume.Config[key]) == type(default) then cfg[key] = resume.Config[key] end
end
cfg.TweenSpeed = math.max(100, math.min(300, cfg.TweenSpeed))
resumeEnabled=cfg.Enabled
cfg.Enabled, cfg.AutoV4, cfg.ESPNPCs, cfg.ESPBoss = false, false, false, false
end
local ctx={Summon={NextLoad=0,NextShot=0},Safety={},Report={Queue={},NextAt=0,Generation=0}}
ctx.Continue=type(resume)=="table"and resume.StatsVersion==2 and type(resume.Stats)=="table"
and(resume==env.TikiKaitunSaved or resume.ContinueSession==true)
local stats={ElapsedSeconds=0,ActiveSeconds=0,Deaths=0,Reconnects=0,Recoveries=0}
if ctx.Continue then
for key,value in pairs(resume.Stats)do
if type(value)=="number"and value==value and math.abs(value)<1e15 then stats[key]=value end
end
end
stats.SessionID=ctx.Continue and resume.Stats.SessionID or(tostring(player.UserId)..":"..os.time()..":"..os.clock())
local sessionStart, lastActiveTick = os.clock(), os.clock()
local elapsedBefore = stats.ElapsedSeconds
local state = {
Alive = true, Phase = "Idle", Target = nil,
Escaping = false, LastError = "None",
PotCount = 0, ErrorCount = 0, V4Status = "Off", WeaponStatus = "Not checked",
Reconnecting = false, ReconnectStatus = "Armed while Kaitun is enabled",
AFKStatus = "Ready", ResumeStatus = "Not checked", RecoveryStatus = "Ready",
SaveStatus = "Not saved yet",
BossDefeats = ctx.Continue and tonumber(resume.BossDefeats) or 0,
}
local arena = Vector3.new(-16194, 155, 1421)
local tikiEntry = Vector3.new(-16257, 22, 1062)
local lastTravelCharacter
local npcNames = {
["Isle Outlaw"] = true, ["Island Boy"] = true,
["Sun-kissed Warrior"] = true, ["Isle Champion"] = true,
["Serpent Hunter"] = true, ["Skull Slayer"] = true,
}
local connections, hover, movementActive = {}, nil, false
local approachTween, approachRoot
local approachGoal, travelGoal, movementWatch, movementFallback
local spawnCache, spawnVisit, nextSpawnScan = {}, nil, 0
local streamThread, streamGeneration, streamBusy = nil, 0, false
local nativeCombat, nativeUtil, nativeThread, nextNativeResolve = nil, nil, nil, 0
local nativeResolving = false
local fast={Owner={},WindowUntil=0,HitPartIndex=0}
local damageWatch
local eyeProgress = { Found = 0, Lit = nil, Text = "Eyes not read yet" }
local nextEyeRead = 0
local espObjects = {}
local collision = setmetatable({}, { __mode = "k" })
local tracked = setmetatable({}, { __mode = "k" })
local mobDeathConnections = {}
local pots,potIndex={},1
local nextPotScan, nextSweep, sweepUntil = 0, 0, 0
local nextAttack, nextSkill, skillIndex = 0, 0, 0
local nextAura = 0
local escapePosition, escapeStarted, protectionCharacter
local window, masterToggle
local v4Thread, v4Generation = nil, 0
local weaponThread, weaponGeneration = nil, 0
local auraThread, auraGeneration = nil, 0
local netResolverThread, nextHitResolve, resolvedHit, resolvingHit = nil, 0, nil, false
local weaponBusy, auraBusy = false, false
local reconnectThread, reconnectAttempts, reconnectNext, reconnectGeneration = nil, 0, 0, 0
local reconnectPendingSince, queuedResume = nil, false
local recoveryUntil, recoveryFailures = 0, 0
local maintenanceSuspended = false
local deathConnection, watchedHumanoid
local lastAFK = -math.huge
local targetWatch, nextMaintenance = nil, 0
local suppressSaving, lastSavedConfig, nextDiskSave = false, nil, 0
local keysDown = {}
local vimOK, VIM = pcall(function() return game:GetService("VirtualInputManager") end)
if not vimOK then VIM = nil end
function ctx.Finite(value)
return type(value)=="number"and value==value and math.abs(value)<1e15
end
local function wallet()
if env.Darling and type(env.Darling.ReadOriginalWallet)=="function"then
local ok,beli,fragments=pcall(function()return env.Darling:ReadOriginalWallet()end)
if ok then return ctx.Finite(beli)and beli or nil,ctx.Finite(fragments)and fragments or nil end
state.WalletStatus="Original wallet reader unavailable"
return nil,nil
end
local data=player:FindFirstChild("Data")
local beli=data and data:FindFirstChild("Beli")
local fragments=data and data:FindFirstChild("Fragments")
local b,f=beli and tonumber(beli.Value),fragments and tonumber(fragments.Value)
return ctx.Finite(b)and b or nil,ctx.Finite(f)and f or nil
end
local function updateStatsTime()
local now=os.clock()
stats.ElapsedSeconds=elapsedBefore+math.max(0,now-sessionStart)
if cfg.Enabled and not state.Reconnecting and now>=recoveryUntil then
stats.ActiveSeconds=stats.ActiveSeconds+math.max(0,now-lastActiveTick)
end
lastActiveTick=now
local beli,fragments=wallet()
if beli~=nil and stats.StartBeli==nil then stats.StartBeli=beli end
if fragments~=nil and stats.StartFragments==nil then stats.StartFragments=fragments end
stats.CurrentBeli,stats.CurrentFragments=beli,fragments
stats.NetBeli=beli and stats.StartBeli and(beli-stats.StartBeli)or nil
stats.NetFragments=fragments and stats.StartFragments and(fragments-stats.StartFragments)or nil
state.WalletStatus=beli~=nil and fragments~=nil and "Real replicated wallet"or "Waiting for wallet data"
end
function ctx.Number(value,signed,prefix)
if not ctx.Finite(value)then return "Unavailable"end
local text=string.format("%.0f",math.abs(value)):reverse():gsub("(%d%d%d)","%1,"):reverse():gsub("^,","")
local sign=value<0 and "-"or(signed and "+"or "")
return sign..(prefix or "")..text
end
local function formatTime(seconds)
local value = math.floor(seconds)
return string.format("%02d:%02d:%02d", math.floor(value / 3600), math.floor(value / 60) % 60, value % 60)
end
local function character()
local char = player.Character
if not char then return end
local hum = char:FindFirstChildOfClass("Humanoid")
local root = char:FindFirstChild("HumanoidRootPart")
if hum and root and hum.Health > 0 then return char, hum, root end
end
local function notify(message)
state.LastNotice=tostring(message)
if ctx.UI then ctx.UI:Log(message)end
end
local function cancelMove()
movementActive = false
if approachTween then approachTween:Cancel() end
approachTween, approachRoot = nil, nil
approachGoal, travelGoal, movementWatch, movementFallback = nil, nil, nil, nil
end
local function cancelThread(thread)
if thread and task.cancel and thread ~= coroutine.running() then pcall(task.cancel, thread) end
end
local function cancelNativeWorkers()
cancelThread(nativeThread)
nativeThread, nativeResolving, nextNativeResolve = nil, false, 0
streamGeneration = streamGeneration + 1
cancelThread(streamThread)
streamThread, spawnVisit, damageWatch, streamBusy = nil, nil, nil, false
end
local function cancelWeaponRequest()
weaponGeneration = weaponGeneration + 1
cancelThread(weaponThread)
weaponThread = nil
weaponBusy = false
ctx.Summon.Aim=nil
if ctx.ReleaseArenaInput then ctx.ReleaseArenaInput()end
end
local function awakeningRemote()
local backpack = player:FindFirstChild("Backpack")
for _, container in pairs({ backpack, player.Character }) do
local awakening = container and container:FindFirstChild("Awakening")
local remote = awakening and awakening:FindFirstChild("RemoteFunction")
if remote and remote:IsA("RemoteFunction") then return remote end
end
end
local function setAutoV4(enabled)
cfg.AutoV4 = enabled and state.Alive or false
v4Generation = v4Generation + 1
local generation = v4Generation
cancelThread(v4Thread)
v4Thread = nil
state.V4Status = cfg.AutoV4 and "Waiting for Awakening" or "Off"
if not cfg.AutoV4 then return end
v4Thread = task.spawn(function()
while state.Alive and cfg.AutoV4 and generation == v4Generation do
local char = character()
local remote = char and awakeningRemote()
local energy=char and char:FindFirstChild("RaceEnergy")
local transformed=char and char:FindFirstChild("RaceTransformed")
local ready=energy and energy.Value>=1 and not(transformed and transformed.Value==true)
if remote and ready then
state.V4Status = "Requesting activation"
local ok, result = pcall(function() return remote:InvokeServer(true) end)
if generation ~= v4Generation or not state.Alive then return end
state.V4Status = ok and "Request sent; waiting for server readiness"
or ("Request failed: " .. tostring(result))
else
state.V4Status=not char and "Waiting for respawn"or(transformed and transformed.Value==true and "V4 active"or "Waiting for full V4 charge")
end
task.wait(0.5)
end
end)
end
local function releaseKeys()
for key in pairs(keysDown) do
if VIM then pcall(function() VIM:SendKeyEvent(false, key, false, game) end) end
keysDown[key] = nil
end
end
local function restorePhysics()
cancelMove()
releaseKeys()
if hover then hover:Destroy(); hover = nil end
for part, original in pairs(collision) do
if part.Parent then part.CanCollide = original end
collision[part] = nil
end
end
local function clearProtection()
state.Escaping = false
escapePosition, escapeStarted, protectionCharacter = nil, nil, nil
ctx.Safety.LatchedReset,ctx.Safety.NextTry,ctx.Safety.Attempts=nil,nil,0
end
local function clearESP(bossOnly)
for model, entry in pairs(espObjects) do
if bossOnly == nil or entry.Boss == bossOnly then
entry.Highlight:Destroy()
entry.Billboard:Destroy()
espObjects[model] = nil
end
end
end
local function queueFunction()
local candidates = { queue_on_teleport, queueonteleport, env.queue_on_teleport,
syn and syn.queue_on_teleport, fluxus and fluxus.queue_on_teleport }
for _, candidate in pairs(candidates) do if type(candidate) == "function" then return candidate end end
end
local function literal(value)
if type(value) == "string" then return string.format("%q", value) end
if type(value) == "number" or type(value) == "boolean" then return tostring(value) end
if type(value) == "table" then
local fields = {}
for key, item in pairs(value) do fields[#fields + 1] = "[" .. literal(key) .. "]=" .. literal(item) end
return "{" .. table.concat(fields, ",") .. "}"
end
return "nil"
end
local function saveSettings(force)
if suppressSaving then return end
updateStatsTime()
local snapshot = { Version = 3, StatsVersion=2, UserId = player.UserId, Config = {}, Stats = {}, BossDefeats = state.BossDefeats }
for key, value in pairs(cfg) do snapshot.Config[key] = value end
for key, value in pairs(stats) do snapshot.Stats[key] = value end
env.TikiKaitunSaved = snapshot
local write = writefile or env.writefile
if type(write) ~= "function" or not HttpService then
state.SaveStatus = "Saved in memory; executor file support unavailable"
return snapshot
end
local fingerprint = literal(cfg)
if force or fingerprint ~= lastSavedConfig or os.clock() >= nextDiskSave then
local ok, err = pcall(function() write(settingsPath, HttpService:JSONEncode(snapshot)) end)
if ok then
lastSavedConfig, nextDiskSave = fingerprint, os.clock() + 30
state.SaveStatus = "Saved to executor file"
else state.SaveStatus = "Memory saved; file save failed: " .. tostring(err) end
end
return snapshot
end
local resumeToken = tostring(os.time()) .. ":" .. tostring(os.clock())
local function queueResume()
if not cfg.AutoResume then state.ResumeStatus = "Disabled; restart manually after reconnect"; return false end
if queuedResume then return true end
local queue = queueFunction()
if not queue or type(env.TikiKaitunSource) ~= "string" then
state.ResumeStatus = "Unavailable: executor must support queue_on_teleport"
return false
end
updateStatsTime()
local snapshot = { StatsVersion=2, ContinueSession=true, Config = cfg, Stats = stats, BossDefeats = state.BossDefeats }
local code = "local e=(getgenv and getgenv()) or _G\n"
.. "if e.__TikiResumeToken==" .. literal(resumeToken) .. " then return end\n"
.. "e.__TikiResumeToken=" .. literal(resumeToken) .. "\n"
.. "e.TikiKaitunSource=" .. literal(env.TikiKaitunSource) .. "\n"
.. "e.TikiKaitunResume=" .. literal(snapshot) .. "\n"
.. "assert(loadstring(e.TikiKaitunSource))()"
local ok, err = pcall(queue, code)
queuedResume = ok
state.ResumeStatus = ok and "Script, settings and stats queued" or ("Queue failed: " .. tostring(err))
return ok
end
local function antiAFK()
if not state.Alive or not cfg.AntiAFK or maintenanceSuspended or os.clock() - lastAFK < 30 then return end
lastAFK = os.clock()
local ok, err = pcall(function()
assert(VirtualUser, "VirtualUser unavailable")
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new(0, 0))
end)
state.AFKStatus = ok and "Idle input sent" or ("Input unavailable: " .. tostring(err))
end
local function cancelReconnect()
reconnectGeneration = reconnectGeneration + 1
cancelThread(reconnectThread)
reconnectThread = nil
state.Reconnecting = false
reconnectPendingSince, reconnectNext, reconnectAttempts = nil, 0, 0
state.ReconnectStatus = "Stopped"
end
local function beginReconnect(reason, manual)
if not state.Alive or state.Reconnecting then return end
if not manual and (not cfg.AutoReconnect or not cfg.Enabled or maintenanceSuspended) then return end
if not TeleportService then state.ReconnectStatus = "TeleportService unavailable"; return end
state.Reconnecting = true
if ctx.Report.Ready then ctx.Report.Exit("Disconnected / reconnecting")end
reconnectAttempts, reconnectNext = 0, os.clock() + cfg.ReconnectDelay
reconnectPendingSince = nil
state.ReconnectStatus = "Reconnect scheduled: " .. tostring(reason)
restorePhysics()
cancelWeaponRequest()
cancelNativeWorkers()
cancelThread(netResolverThread)
netResolverThread, resolvingHit = nil, false
end
local function reconnectFailure(message)
if not state.Reconnecting then return end
reconnectPendingSince = nil
reconnectNext = os.clock() + math.min(cfg.ReconnectDelay * 2 ^ math.max(reconnectAttempts - 1, 0), 60)
state.ReconnectStatus = "Retry pending: " .. tostring(message)
end
local function reconnectTick()
if not state.Reconnecting then return end
if reconnectPendingSince then
if os.clock() - reconnectPendingSince >= 30 then
cancelThread(reconnectThread)
reconnectThread = nil
reconnectFailure("teleport timed out")
end
return
end
if os.clock() < reconnectNext then return end
if reconnectAttempts >= cfg.MaxReconnectAttempts then
state.ReconnectStatus = "Retry limit reached; manual intervention required"
reconnectNext = math.huge
return
end
reconnectAttempts = reconnectAttempts + 1
stats.Reconnects = stats.Reconnects + 1
queueResume()
reconnectPendingSince = os.clock()
local generation = reconnectGeneration
state.ReconnectStatus = "Joining Third Sea; attempt " .. reconnectAttempts
reconnectThread = task.spawn(function()
if generation ~= reconnectGeneration or not state.Alive then return end
local ok, err = pcall(function() TeleportService:Teleport(reconnectPlaceId, player) end)
if generation == reconnectGeneration and not ok then reconnectFailure(err) end
end)
end
local function stop()
updateStatsTime()
cfg.Enabled = false
for model,connection in pairs(mobDeathConnections)do
connection:Disconnect();mobDeathConnections[model]=nil;tracked[model]=nil
end
fast.WindowUntil,fast.WindowModel=0,nil
ctx.Summon.Aim,ctx.Summon.Tool,ctx.Summon.Part=nil,nil,nil
ctx.Safety.Return=nil
maintenanceSuspended = true
recoveryUntil = 0
cancelReconnect()
setAutoV4(false)
cancelWeaponRequest()
cancelNativeWorkers()
cancelThread(netResolverThread)
netResolverThread, resolvingHit = nil, false
auraGeneration = auraGeneration + 1
cancelThread(auraThread)
auraThread = nil
auraBusy = false
cfg.ESPNPCs, cfg.ESPBoss = false, false
clearESP()
state.Target, state.Phase = nil, "Stopped"
state.TravelToTiki = false
clearProtection()
restorePhysics()
end
local function movement(cf, immediate, speedOverride)
local _, _, root = character()
if not root then return end
movementActive = true
local delta = cf.Position - root.Position
local now = os.clock()
local range = math.max(32, math.min(tonumber(cfg.TPRange) or 320, 320))
if immediate or delta.Magnitude <= range then
if approachTween then approachTween:Cancel() end
approachTween, approachRoot = nil, nil
approachGoal, travelGoal, movementWatch, movementFallback = nil, nil, nil, nil
root.CFrame = cf
root.AssemblyLinearVelocity = Vector3.zero
root.AssemblyAngularVelocity = Vector3.zero
return
end
travelGoal = cf
if movementFallback and movementFallback.Root == root then
movementFallback.Goal = cf
movementFallback.Speed = math.max(100, math.min(speedOverride or cfg.TweenSpeed, 300))
return
end
if movementWatch and (root.Position - movementWatch.Position).Magnitude > 100 then approachGoal = nil end
if not movementWatch or movementWatch.Root ~= root or (movementWatch.Goal - cf.Position).Magnitude >= 35 then
movementWatch = { Root = root, Position = root.Position, Goal = cf.Position, BestDistance = delta.Magnitude, At = now }
elseif delta.Magnitude <= movementWatch.BestDistance - 3 then
movementWatch.Position, movementWatch.BestDistance, movementWatch.At = root.Position, delta.Magnitude, now
end
local stalled = now - movementWatch.At >= 2.5
if stalled then
movementWatch.At = now
state.RecoveryStatus = "Tween stalled; using frame-based movement to the same destination"
stats.Recoveries = stats.Recoveries + 1
if approachTween then approachTween:Cancel() end
approachTween = nil
movementFallback = { Root = root, Goal = cf, Speed = math.max(100, math.min(speedOverride or cfg.TweenSpeed, 300)) }
return
end
if not stalled and approachTween and approachRoot == root and approachGoal
and (approachGoal - cf.Position).Magnitude < 35
and approachTween.PlaybackState == Enum.PlaybackState.Playing then return end
if approachTween then approachTween:Cancel() end
local distance = math.min(400, math.max(delta.Magnitude - range * 0.8, 1))
local position = root.Position + delta.Unit * distance
approachRoot, approachGoal = root, cf.Position
local speed = speedOverride or cfg.TweenSpeed
local duration = math.max((root.Position - position).Magnitude / math.max(100, math.min(speed, 300)), 0.04)
approachTween = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Linear),
{ CFrame = CFrame.lookAt(position, cf.Position) })
approachTween:Play()
end
local function baseName(name)
return (name:gsub("%s*%[.*$", ""):match("^%s*(.-)%s*$"))
end
local function nameKey(name) return baseName(name):lower():gsub("[^%w]", "") end
local tikiKeys = {}
for name in pairs(npcNames) do tikiKeys[nameKey(name)] = true end
local tyrantKeys = { serpenthunter = true, skullslayer = true, islechampion = true, sunkissedwarrior = true }
local function childPath(root, ...)
for _, name in ipairs({ ... }) do root = root and root:FindFirstChild(name) end
return root
end
local function isBoss(model)
return nameKey(model.Name) == "tyrantoftheskies"
end
local function living(model)
local hum = model:FindFirstChildOfClass("Humanoid")
local root = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
if hum and root and hum.Health > 0 then return hum, root end
end
local function isTikiNPC(model, root)
local key = nameKey(model.Name)
return tikiKeys[key] == true and (cfg.NPCTarget == "All Tiki NPCs"
or (cfg.NPCTarget == "Tyrant farm group" and tyrantKeys[key] == true) or key == nameKey(cfg.NPCTarget))
end
local function readEyeProgress()
local map = workspace:FindFirstChild("Map")
local eyes, found, lit = {}, 0, 0
local island = childPath(map, "TikiOutpost", "IslandModel")
local east = childPath(island, "IslandChunks", "E")
local known = {
childPath(island, "Eye1"), childPath(island, "Eye2"), childPath(east, "Eye3"), childPath(east, "Eye4"),
}
for index = 1, 4 do
local eye = known[index]
if eye and eye:IsA("BasePart") and type(eye.Transparency) == "number" then
eyes[tostring(index)] = eye
found = found + 1
if eye.Transparency == 0 then lit = lit + 1 end
end
end
if map then
for _, object in ipairs(map:GetDescendants()) do
local index = object.Name:lower():match("^eye([1-4])$")
if index and object:IsA("BasePart") and not eyes[index]
and (object.Position - arena).Magnitude < 1800 and type(object.Transparency) == "number" then
eyes[index] = object
found = found + 1
if object.Transparency == 0 then lit = lit + 1 end
end
end
end
eyeProgress = { Found = found, Lit = found == 4 and lit or nil, Paths = {} }
for _, object in pairs(eyes) do eyeProgress.Paths[#eyeProgress.Paths + 1] = object:GetFullName() end
if found < 4 then
eyeProgress.Text = "Eyes: unavailable (" .. found .. "/4 eye parts found). Exact kills remaining are not exposed here."
else
local minimum = lit == 4 and 0 or (3 - lit) * 75 + 1
local maximum = (4 - lit) * 75
eyeProgress.MinRemaining, eyeProgress.MaxRemaining = minimum, maximum
eyeProgress.Text = "Eyes: " .. lit .. "/4 | Tiki kills remaining: "
.. (minimum == maximum and tostring(minimum) or (minimum .. "–" .. maximum))
.. (lit == 4 and " — pots ready" or " (range from visible eye stages)")
end
state.EyeProgress = eyeProgress.Text
nextEyeRead = os.clock() + 2
return eyeProgress
end
local function enemies()
local folder = workspace:FindFirstChild("Enemies")
return folder and folder:GetChildren() or {}
end
local function isActiveEnemy(model)
for _, enemy in ipairs(enemies()) do if enemy == model then return true end end
return false
end
local function findTarget(bossOnly)
local _, _, root = character()
if not root then return end
local best, nearest = nil, math.huge
for _, model in ipairs(enemies()) do
local hum, part = living(model)
if hum and ((bossOnly and isBoss(model))
or (not bossOnly and isTikiNPC(model, part))) then
local distance = (root.Position - part.Position).Magnitude
if distance < nearest then best, nearest = model, distance end
end
end
return best
end
local function rememberSpawn(name, position, source)
if not position or not tikiKeys[nameKey(name)] or (position - tikiEntry).Magnitude > 6000 then return end
if #spawnCache >= 256 then return end
for _, point in ipairs(spawnCache) do
if nameKey(point.Name) == nameKey(name) and (point.Position - position).Magnitude < 45 then return end
end
spawnCache[#spawnCache + 1] = { Name = name, Position = position, Source = source }
end
local function refreshSpawns()
if os.clock() < nextSpawnScan then return end
nextSpawnScan = os.clock() + 4
local markers = RS:FindFirstChild("FortBuilderReplicatedSpawnPositionsFolder")
local origin = workspace:FindFirstChild("_WorldOrigin")
local worldMarkers = origin and origin:FindFirstChild("EnemySpawns")
for _, folder in pairs({ markers, worldMarkers }) do
for _, point in ipairs(folder:GetDescendants()) do
if point:IsA("BasePart") then rememberSpawn(point.Name, point.Position, folder.Name) end
end
end
local function rememberModels(folder)
if not folder then return end
for _, model in ipairs(folder:GetChildren()) do
if model:IsA("Model") then
local part = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
if part then rememberSpawn(model.Name, part.Position, folder.Name) end
end
end
end
rememberModels(RS)
rememberModels(RS:FindFirstChild("Enemies"))
rememberModels(workspace:FindFirstChild("Enemies"))
end
local function seekSpawn(root)
refreshSpawns()
local points = {}
for _, point in ipairs(spawnCache) do if isTikiNPC({ Name = point.Name }) then points[#points + 1] = point end end
state.SpawnPoints = #points
if #points == 0 then
state.SpawnStatus = "No matching replicated spawn markers or stored enemy positions found"
return false
end
local now = os.clock()
if not spawnVisit or not isTikiNPC({ Name = spawnVisit.Point.Name }) then
table.sort(points, function(a, b) return (a.Position - root.Position).Magnitude < (b.Position - root.Position).Magnitude end)
spawnVisit = { Point = points[1] }
elseif spawnVisit.Arrived and now - spawnVisit.Arrived >= 8 and #points > 1 then
local current = 1
for i, point in ipairs(points) do if point == spawnVisit.Point then current = i; break end end
spawnVisit = { Point = points[current % #points + 1] }
end
local point = spawnVisit.Point
local destination = CFrame.new(point.Position + Vector3.new(0, cfg.Distance, 0))
state.SpawnStatus = point.Name .. " (" .. point.Source .. ")"
if (root.Position - destination.Position).Magnitude > 12 then
state.Phase = "Moving to " .. baseName(point.Name) .. " spawn"
movement(destination)
else
spawnVisit.Arrived = spawnVisit.Arrived or now
state.Phase = "Waiting at " .. baseName(point.Name) .. " spawn for NPCs to load / respawn"
restorePhysics()
if not spawnVisit.Requested and not streamBusy and workspace.StreamingEnabled and type(player.RequestStreamAroundAsync) == "function" then
spawnVisit.Requested, streamBusy = true, true
local token = streamGeneration
streamThread = task.spawn(function()
local ok, err = pcall(function() player:RequestStreamAroundAsync(point.Position, 3) end)
if token == streamGeneration then
streamBusy = false
if not ok then state.SpawnStatus = "Stream request: " .. tostring(err) end
end
end)
end
end
return true
end
local function watchTarget(model)
if not isBoss(model)or tracked[model] then return end
local hum = model:FindFirstChildOfClass("Humanoid")
if not hum then return end
tracked[model] = true
local connection
connection = hum.Died:Connect(function()
connection:Disconnect()
mobDeathConnections[model] = nil
tracked[model]=nil
if not state.Alive or not cfg.Enabled then return end
state.BossDefeats=state.BossDefeats+1
nextSweep=os.clock()+15
end)
mobDeathConnections[model] = connection
end
local function toolCategory(tool)
local category = tostring(tool.ToolTip or ""):lower():gsub("%s", "")
if category == "fruit" or category == "bloxfruit" or category == "bloxfruits" then return "Blox Fruit" end
return ({ melee = "Melee", sword = "Sword", gun = "Gun" })[category]
end
local function selectedTool()
local function matches(tool)
if not tool:IsA("Tool") then return false end
if cfg.WeaponName ~= "" then return tool.Name:lower() == cfg.WeaponName:lower() end
return toolCategory(tool) == cfg.WeaponType
end
local char = player.Character
if char then
for _, tool in ipairs(char:GetChildren()) do if matches(tool) then return tool end end
end
local backpack = player:FindFirstChild("Backpack")
if backpack then
for _, tool in ipairs(backpack:GetChildren()) do if matches(tool) then return tool end end
end
end
local function equip()
local char, hum = character()
if not char then return end
local tool = selectedTool()
if tool and tool.Parent ~= char then hum:EquipTool(tool) end
return tool
end
local function combatNet()
local modules = RS:FindFirstChild("Modules")
local net = modules and modules:FindFirstChild("Net")
if not net then return end
local attack = net:FindFirstChild("RE/RegisterAttack")
local hit = resolvedHit or net:FindFirstChild("RE/RegisterHit")
if net:IsA("ModuleScript") and not resolvedHit and not resolvingHit and os.clock() >= nextHitResolve then
resolvingHit = true
nextHitResolve = os.clock() + 15
netResolverThread = task.spawn(function()
local ok, remote = pcall(function()
local api = require(net)
return api:RemoteEvent("RegisterHit", true)
end)
if state.Alive and ok and remote then resolvedHit = remote end
if not ok then state.LastError = "Native RegisterHit resolver: " .. tostring(remote) end
resolvingHit = false
end)
end
local okAttack,sendAttack=pcall(function()return attack and attack.FireServer end)
local okHit,sendHit=pcall(function()return hit and hit.FireServer end)
if okAttack and okHit and type(sendAttack)=="function"and type(sendHit)=="function"then return attack,hit end
end
function fast.PrepareGate()
if not nativeUtil or type(nativeUtil.CanAttack)~="function"then
state.FastAttackStatus="CombatUtil.CanAttack unavailable; native fallback remains available"
return
end
local registry=env.DarlingTikiAttackGates
if type(registry)~="table"then registry=setmetatable({},{__mode="k"});env.DarlingTikiAttackGates=registry end
local fn=nativeUtil.CanAttack
local bridge=registry[fn]
if not bridge then
bridge={Original=fn}
local function replacement(...)
if bridge.Allow and bridge.Allow()then return true end
return bridge.Original(...)
end
local hook=hookfunction or env.hookfunction
local closure=newcclosure or env.newcclosure
local wrapped=replacement
if type(closure)=="function"then
local ok,result=pcall(closure,replacement);if ok and type(result)=="function"then wrapped=result end
end
if type(hook)=="function"then
local ok,old=pcall(hook,fn,wrapped)
if ok and type(old)=="function"then bridge.Original=old;bridge.Method="function hook"end
end
if not bridge.Method then
local ok=pcall(function()nativeUtil.CanAttack=wrapped end)
if not ok then state.FastAttackStatus="Executor could not prepare the native attack gate";return end
registry[wrapped]=bridge;bridge.Method="module function override"
end
registry[fn]=bridge
end
bridge.Owner=fast.Owner
bridge.Allow=function()
if not state.Alive or not cfg.Enabled or not cfg.FastAttack or state.Escaping then return false end
local _,_,root=character()
local arenaAim=ctx.Summon.Aim
if root and arenaAim and arenaAim.Target and arenaAim.Target.Parent and os.clock()<=arenaAim.Until
and(root.Position-arenaAim.Hit.Position).Magnitude<=75 then return true end
if os.clock()>fast.WindowUntil then return false end
local targetRoot
if fast.WindowModel then local unused;unused,targetRoot=living(fast.WindowModel)end
return root~=nil and targetRoot~=nil and isActiveEnemy(fast.WindowModel)
and(root.Position-targetRoot.Position).Magnitude<=50
end
fast.Gate=bridge
state.FastAttackStatus="Native CanAttack ready via "..bridge.Method
end
function fast.HitPart(model)
local names={"RightLowerArm","RightUpperArm","LeftLowerArm","LeftUpperArm","RightHand","LeftHand"}
for _=1,#names do
fast.HitPartIndex=fast.HitPartIndex%#names+1
local part=model:FindFirstChild(names[fast.HitPartIndex])
if part then return part end
end
return model:FindFirstChild("HumanoidRootPart")or model.PrimaryPart or model:FindFirstChild("UpperTorso")or model:FindFirstChild("Head")
end
function fast.MaintainBuso()
if not cfg.Enabled or not cfg.AutoBuso or state.Escaping or state.Reconnecting or os.clock()<nextAura or auraBusy then return end
local char=character()
if not char then return end
if char:FindFirstChild("HasBuso")then state.BusoStatus="Armament Haki active";return end
local remotes=RS:FindFirstChild("Remotes")
local comm=remotes and remotes:FindFirstChild("CommF_")
if not comm or not comm:IsA("RemoteFunction")then state.BusoStatus="CommF_ unavailable";return end
nextAura=os.clock()+5
local generation=auraGeneration
auraBusy=true;state.BusoStatus="Enabling Armament Haki"
auraThread=task.spawn(function()
if generation~=auraGeneration or not cfg.Enabled or not cfg.AutoBuso then return end
local ok,err=pcall(function()comm:InvokeServer("Buso")end)
if generation~=auraGeneration then return end
auraBusy=false
state.BusoStatus=ok and "Buso requested; waiting for HasBuso"or("Buso failed: "..tostring(err))
end)
end
local function resolveNativeCombat()
if nativeResolving or os.clock() < nextNativeResolve or (nativeCombat and nativeUtil) then return end
nextNativeResolve = os.clock() + 15
local controllers, modules = RS:FindFirstChild("Controllers"), RS:FindFirstChild("Modules")
local combatSource = controllers and controllers:FindFirstChild("CombatController")
local utilSource = modules and modules:FindFirstChild("CombatUtil")
if not combatSource and not utilSource then return end
nativeResolving = true
nativeThread = task.spawn(function()
if combatSource then
local ok, result = pcall(require, combatSource)
if ok and type(result) == "table" and type(result.Attack) == "function" then nativeCombat = result end
end
if utilSource then
local ok, result = pcall(require, utilSource)
if ok and type(result) == "table" then nativeUtil = result;fast.PrepareGate() end
end
nativeThread, nativeResolving = nil, false
end)
end
local function playNativeAttack(char, hum)
if not nativeUtil then return end
local equipped = char:FindFirstChild("EquippedWeapon")
if not equipped then return end
local ok, err = pcall(function()
local name = nativeUtil:GetWeaponName(equipped)
local data = nativeUtil:GetWeaponData(name)
local basics = data and data.Moveset and data.Moveset.Basic
if not basics or #basics == 0 then return end
local cache = nativeUtil:GetMovesetAnimCache(hum)
local animation = cache[nativeUtil:GetPureWeaponName(name) .. "-basic" .. math.random(1, #basics)]
if animation then
animation:Play(0, 1, (animation:GetAttribute("SpeedMult") or 1) * 5)
animation.TimePosition = 0.01
end
end)
if not ok then state.LastError = "Native attack animation: " .. tostring(err) end
end
local function observeDamage(model, tool)
local hum = model and model:FindFirstChildOfClass("Humanoid")
if not hum then return false end
local now = os.clock()
if not damageWatch or damageWatch.Model ~= model or damageWatch.Tool ~= tool then
damageWatch = { Model = model, Tool = tool, Health = hum.Health, Since = now, Attempts = 0 }
state.DamageStatus = "Watching target health"
elseif hum.Health < damageWatch.Health then
damageWatch.Health, damageWatch.Since = hum.Health, now
state.DamageStatus = "Target health decreased"
damageWatch.FallbackUntil = nil
end
damageWatch.Health = hum.Health
damageWatch.Attempts = damageWatch.Attempts + 1
if now - damageWatch.Since >= 4 and damageWatch.Attempts >= 4
and (not damageWatch.FallbackUntil or now >= damageWatch.FallbackUntil) then
state.DamageStatus = "No target health decrease for 4s; trying native combat controller"
damageWatch.FallbackUntil = now + 5
damageWatch.Since, damageWatch.Attempts = now, 0
end
return damageWatch.FallbackUntil and now < damageWatch.FallbackUntil
end
local function useSkill(force)
if ctx.Input and ctx.Input.GetFocusedTextBox then
local ok,focused=pcall(function()return ctx.Input:GetFocusedTextBox()end)
if ok and focused then return end
end
if (not cfg.Skills and not force) or not VIM or os.clock() < nextSkill then return end
nextSkill = os.clock() + 1.3
local skillKeys = { Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C }
skillIndex = skillIndex % #skillKeys + 1
local key = skillKeys[skillIndex]
keysDown[key] = true
local ok, err = pcall(function() VIM:SendKeyEvent(true, key, false, game) end)
if not ok then
keysDown[key] = nil
cfg.Skills = false
state.LastError = "Skill input unavailable: " .. tostring(err)
return
end
task.delay(0.12, function()
if keysDown[key] then
pcall(function() VIM:SendKeyEvent(false, key, false, game) end)
keysDown[key] = nil
end
end)
return true
end
local function attack(model, position)
local char, hum, root = character()
if not char or state.Escaping or not cfg.Enabled then return end
if (root.Position - position).Magnitude > 50 then
if damageWatch and damageWatch.Model == model then damageWatch = nil end
return
end
if os.clock() < nextAttack then return end
local interval = cfg.FastAttack and 0.12 or 0.3
nextAttack = os.clock() + interval
local tool = equip()
if not tool then state.WeaponStatus = "No matching weapon; choose a loaded weapon"; return end
if tool.Parent ~= char then state.WeaponStatus = "Waiting for weapon to equip"; return end
resolveNativeCombat()
if cfg.FastAttack and nativeUtil and(not fast.Gate or fast.Gate.Owner~=fast.Owner)then fast.PrepareGate()end
fast.WindowUntil,fast.WindowModel=os.clock()+0.25,model
local fallback = observeDamage(model, tool)
if fallback and not nativeCombat then state.DamageStatus = "No target health decrease; native controller unavailable, trying Tool:Activate" end
local category = toolCategory(tool)
local leftClick = tool:FindFirstChild("LeftClickRemote")
local gunRemote = tool:FindFirstChild("RemoteFunctionShoot")
local sent = false
if model and cfg.CombatRemotes and (category == "Melee" or category == "Sword") then
local register, hit = combatNet()
local part = fast.HitPart(model)
if cfg.FastAttack and not fallback and register and part then
local ok, err = pcall(function()
register:FireServer(0.3)
playNativeAttack(char, hum)
local token = tostring(player.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15)
hit:FireServer(part, { { model, part } }, nil, nil, token)
end)
sent = ok
state.WeaponStatus = ok and (tool.Name .. (nativeUtil and " (fast attack + native moveset)" or " (fast attack; native moveset loading)")) or ("Hit request failed: " .. tostring(err))
elseif nativeCombat and not weaponBusy then
local generation = weaponGeneration
weaponBusy, sent = true, true
weaponThread = task.spawn(function()
if generation ~= weaponGeneration then return end
if not cfg.Enabled or state.Escaping or tool.Parent ~= player.Character or not isActiveEnemy(model) then
weaponBusy = false
return
end
fast.WindowUntil,fast.WindowModel=os.clock()+0.25,model
local ok, err = pcall(function() nativeCombat:Attack(tool) end)
if generation ~= weaponGeneration then return end
weaponBusy = false
if not ok then state.LastError = "CombatController: " .. tostring(err) end
end)
state.WeaponStatus = tool.Name .. " (native CombatController)"
elseif nativeCombat and weaponBusy then
sent = true
state.WeaponStatus = tool.Name .. " (native attack in progress)"
elseif not nativeCombat and not fallback and register and part then
local ok = pcall(function()
register:FireServer(0.3)
playNativeAttack(char, hum)
hit:FireServer(part, { { model, part } }, nil, nil,
tostring(player.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15))
end)
sent = ok
state.WeaponStatus = tool.Name .. " (NPC hit requests; see damage status)"
end
elseif cfg.CombatRemotes and leftClick and leftClick:IsA("RemoteEvent") then
local direction = position - root.Position
if direction.Magnitude > 0 then
sent = pcall(function() leftClick:FireServer(direction.Unit, 1) end)
end
state.WeaponStatus = tool.Name .. " (LeftClickRemote)"
elseif model and cfg.CombatRemotes and category == "Gun" and gunRemote and gunRemote:IsA("RemoteFunction") then
if not weaponBusy then
local head = model:FindFirstChild("Head") or model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
local generation = weaponGeneration
weaponBusy = true
weaponThread = task.spawn(function()
if generation ~= weaponGeneration or not cfg.Enabled or state.Escaping then return end
local ok, result = pcall(function() return gunRemote:InvokeServer(position, head) end)
if generation ~= weaponGeneration then return end
weaponBusy = false
if not ok then state.LastError = "Gun request failed: " .. tostring(result) end
end)
end
sent = true
state.WeaponStatus = tool.Name .. " (gun request)"
end
if not sent then
local ok, err = pcall(function() tool:Activate() end)
state.WeaponStatus = ok and (tool.Name .. " (Tool:Activate fallback)") or ("Weapon activation failed: " .. tostring(err))
end
useSkill(model == nil)
fast.MaintainBuso()
end
function ctx.AimAt(position,part)
local summon=ctx.Summon
summon.Aim={Hit=CFrame.new(position),Target=part,Until=os.clock()+2}
local bridge=env.DarlingTikiAimBridge
if not bridge then
local hook=hookmetamethod or env.hookmetamethod
local closure=newcclosure or env.newcclosure
local ok,mouse=pcall(function()return player:GetMouse()end)
if type(hook)~="function"or not ok or not mouse then return end
bridge={Mouse=mouse}
local old
local function index(object,key)
if object==bridge.Mouse and(key=="Hit"or key=="Target")and bridge.Read then
local aim=bridge.Read()
if aim then return aim[key]end
end
return old(object,key)
end
local fn=index
if type(closure)=="function"then
local built,value=pcall(closure,index);if built and type(value)=="function"then fn=value end
end
local installed,result=pcall(hook,game,"__index",fn)
if not installed or type(result)~="function"then return end
old=result;env.DarlingTikiAimBridge=bridge
end
bridge.Owner=fast.Owner
bridge.Read=function()
local aim=ctx.Summon.Aim
if state.Alive and cfg.Enabled and not state.Escaping and aim and os.clock()<=aim.Until then return aim end
end
end
function ctx.GunValidator()
local comm=childPath(RS,"Remotes","Validator2")
if not comm or not nativeCombat or type(nativeCombat.Attack)~="function"then return end
local getter=getupvalue or env.getupvalue
local setter=setupvalue or env.setupvalue
if type(getter)~="function"and debug then getter=debug.getupvalue end
if type(setter)~="function"and debug then setter=debug.setupvalue end
if type(getter)~="function"or type(setter)~="function"then return end
local function read(fn,index)
local a,b=getter(fn,index)
return type(a)=="string"and b~=nil and b or a
end
local ok,token,counter=pcall(function()
local generator=read(nativeCombat.Attack,9)
assert(type(generator)=="function","Native gun validator layout unavailable")
local a,b,c,d,e,f,g=read(generator,15),read(generator,13),read(generator,16),read(generator,17),read(generator,14),read(generator,18),read(generator,19)
for _,value in ipairs({a,b,c,d,e,f,g})do assert(ctx.Finite(value),"Native gun validator state unavailable")end
assert(d>0 and f>0,"Native gun validator modulus unavailable")
local n=((a*e+b*c)%d*d+b*e)%f
local high=math.floor(n/d)
setter(generator,15,high);setter(generator,13,n-high*d);setter(generator,19,g+1)
return math.floor(n/f*16777215),g+1
end)
if ok then
local sent=pcall(function()comm:FireServer(token,counter)end)
state.SummonStatus=sent and "Native gun validator prepared"or "Native validator request failed"
return sent
end
end
function ctx.ArenaController()
local summon=ctx.Summon
if summon.GameController and type(summon.GameController.Attack)=="function"then return summon.GameController end
if os.clock()>=(summon.NextControllerProbe or 0)then
summon.NextControllerProbe=os.clock()+3
local gc=getgc or env.getgc
if type(gc)=="function"and debug then
local ok,objects=pcall(gc,true)
if ok and type(objects)=="table"then
for _,object in ipairs(objects)do
if type(object)=="table"then
local fn=rawget(object,"Attack")
if type(fn)=="function"then
local found,source=pcall(function()
if debug.info then return debug.info(fn,"s")end
local info=debug.getinfo(fn,"S");return info and info.source
end)
if found and tostring(source):find("ReplicatedStorage.Controllers.CombatController",1,true)then
summon.GameController=object;return object
end
end
end
end
end
end
end
return nativeCombat
end
function ctx.ArenaNativeM1(gun)
local combat=ctx.ArenaController()
if not combat or type(combat.Attack)~="function"then return false,"native controller unavailable"end
local set=setthreadidentity or setidentity or env.setthreadidentity or env.setidentity
local get=getthreadidentity or getidentity or env.getthreadidentity or env.getidentity
local previous=8
if type(get)=="function"then local ok,value=pcall(get);if ok and type(value)=="number"then previous=value end end
local switched=false
if type(set)=="function"then
local ok=pcall(set,2)
if not ok then return false,"game-script context unavailable"end
switched=true
end
local ok,result=pcall(function()
return combat:Attack(gun,{UserInputType=Enum.UserInputType.MouseButton1,
UserInputState=Enum.UserInputState.Begin,Position=Vector3.zero})
end)
if switched then pcall(set,previous)end
if not ok then return false,tostring(result)end
if result==false then return false,"native controller declined M1"end
return true,"native input context"
end
function ctx.ReleaseArenaInput()
local record=ctx.Summon.InputHold
ctx.Summon.InputHold=nil
ctx.Summon.InputGeneration=(ctx.Summon.InputGeneration or 0)+1
if not record then return end
if record.Down then pcall(record.Send,false)end
if record.Camera and workspace.CurrentCamera==record.Camera then
pcall(function()
if record.Camera.CameraType==Enum.CameraType.Scriptable then
record.Camera.CFrame=record.OriginalCFrame
record.Camera.CameraType=record.OriginalType
end
end)
end
end
function ctx.ArenaInputBlocked(x,y)
if ctx.Input and ctx.Input.GetFocusedTextBox then
local ok,focused=pcall(function()return ctx.Input:GetFocusedTextBox()end)
if ok and focused then return true,"text box focused"end
end
local gui=player:FindFirstChild("PlayerGui")
local ok,objects=pcall(function()return gui:GetGuiObjectsAtPosition(x,y)end)
if ok and type(objects)=="table"then
for _,object in ipairs(objects)do
local active=object.Active
if object:IsA("TextButton")or object:IsA("ImageButton")or object:IsA("TextBox")or active then return true,"interactive UI at aim point"end
end
end
if ctx.UI and ctx.UI.Root.Visible then
local view=ctx.UI
local controls=view.View=="reports"and{view.URL,view.Interval,view.Save,view.Back,view.ReportClose,view.ReportMinimize}
or{view.Start,view.Weapon,view.OpenReports,view.MainClose,view.MainMinimize}
for _,object in ipairs(controls)do
local pos,size=object.AbsolutePosition,object.AbsoluteSize
if pos and size and x>=pos.X and y>=pos.Y and x<=pos.X+size.X and y<=pos.Y+size.Y then return true,"Darling control at aim point"end
end
end
return false
end
function ctx.ClickArenaM1(position,part)
local camera=workspace.CurrentCamera
if not camera then return false,"camera unavailable"end
if ctx.Summon.InputHold then return false,"mouse click pending"end
local focused=ctx.Input and ctx.Input.GetFocusedTextBox and ctx.Input:GetFocusedTextBox()
if focused then return false,"text box focused"end
local record={Camera=camera,OriginalCFrame=camera.CFrame,OriginalType=camera.CameraType}
local projected
local ok=pcall(function()
camera.CameraType=Enum.CameraType.Scriptable
for _,offset in ipairs({0,14,-14,22,-22})do
camera.CFrame=CFrame.lookAt(position+Vector3.new(0,18,24),position+Vector3.new(offset,0,0))
local point,visible=camera:WorldToViewportPoint(position)
if visible and point.Z>0 and point.X>8 and point.Y>48 then
local blocked=ctx.ArenaInputBlocked(point.X,point.Y)
if not blocked then projected=Vector2.new(math.floor(point.X),math.floor(point.Y));break end
end
end
end)
if not ok or not projected then
pcall(function()camera.CFrame=record.OriginalCFrame;camera.CameraType=record.OriginalType end)
return false,ok and "world click blocked by UI"or "camera projection unavailable"
end
local methods={}
if not ctx.Summon.ProbedVirtualInput then
ctx.Summon.ProbedVirtualInput=true
local available,virtual=pcall(function()return ctx.Input:CreateVirtualInput()end)
if available then ctx.Summon.VirtualInput=virtual end
end
local virtual=ctx.Summon.VirtualInput
if virtual then methods[#methods+1]={Name="VirtualInput",Send=function(down)
virtual:SendMousePosition(projected)
virtual:SendMouseButton(projected,Enum.UserInputType.MouseButton1,down,0)
end}end
if VIM then methods[#methods+1]={Name="VirtualInputManager",Send=function(down)
VIM:SendMouseMoveEvent(projected.X,projected.Y)
VIM:SendMouseButtonEvent(projected.X,projected.Y,0,down,game,0)
end}end
if VirtualUser then methods[#methods+1]={Name="VirtualUser",Send=function(down)
VirtualUser:CaptureController()
if down then VirtualUser:Button1Down(projected,camera.CFrame)else VirtualUser:Button1Up(projected,camera.CFrame)end
end}end
ctx.AimAt(position,part)
for _,method in ipairs(methods)do
local sent=pcall(method.Send,true)
if sent then
record.Down,record.Send,record.Backend=true,method.Send,method.Name
ctx.Summon.InputHold=record
local generation=ctx.Summon.InputGeneration or 0
task.delay(0.09,function()
if ctx.Summon.InputHold==record and (ctx.Summon.InputGeneration or 0)==generation then ctx.ReleaseArenaInput()end
end)
return true,method.Name
end
pcall(method.Send,false)
end
pcall(function()camera.CFrame=record.OriginalCFrame;camera.CameraType=record.OriginalType end)
return false,"executor denied mouse input"
end
function ctx.QuantumShoot(gun,position,root)
pcall(function()
gun.Enabled=true
gun:SetAttribute("IsReloading_Client",false)
gun:SetAttribute("LocalShotsLeft",100)
gun:SetAttribute("LocalTotalShots",(gun:GetAttribute("LocalTotalShots")or 0)+1)
end)
local remote=gun:FindFirstChild("RemoteEvent")
local sent=false
if gun.Name=="Skull Guitar"and remote then
sent=pcall(function()remote:FireServer("TAP",position)end)
else
local validated=ctx.GunValidator()
local shoot=childPath(RS,"Modules","Net","RE/ShootGunEvent")
if validated and shoot then sent=pcall(function()shoot:FireServer(position,{root})end)
else sent=pcall(function()gun:Activate()end)end
end
if remote then sent=pcall(function()remote:FireServer("TAP",position)end)or sent end
return sent
end
local function attackVase(position,part)
local char,hum,root=character()
if not char or not cfg.Enabled or state.Escaping or not part or not part.Parent then return end
if eyeProgress.Found~=4 or eyeProgress.Lit~=4 then
state.SummonStatus="Waiting for confirmed 4/4 eyes";return
end
local summon=ctx.Summon
local now=os.clock()
if summon.Part~=part then
ctx.ReleaseArenaInput()
summon.Part,summon.TargetStarted,summon.Attempts=part,now,0
summon.NextShot,summon.CastUntil=0,0
end
if now<(summon.CastUntil or 0)then
state.SummonStatus="Allowing the skill to finish";return
end
resolveNativeCombat()
if nativeUtil and(not fast.Gate or fast.Gate.Owner~=fast.Owner)then fast.PrepareGate()end
local backpack=player:FindFirstChild("Backpack")
local gun
for _,name in ipairs({"Skull Guitar","Soul Guitar"})do
local candidate=char:FindFirstChild(name)or(backpack and backpack:FindFirstChild(name))
if candidate and candidate:IsA("Tool")then gun=candidate;break end
end
local elapsed=now-summon.TargetStarted
local skillPhase=not gun or(elapsed>=8 and math.floor((elapsed-8)/4)%2==0)
local selected=selectedTool()
local tool=skillPhase and(selected or gun)or gun
local destination
if skillPhase then
destination=CFrame.lookAt(position+Vector3.new(0,3,6),position+Vector3.new(0,3,0))
else
local ok,pose=pcall(function()return part.CFrame*CFrame.new(0,15,0)end)
destination=ok and pose or CFrame.new(position+Vector3.new(0,15,0))
end
if(root.Position-destination.Position).Magnitude>3 then movement(destination);return end
if tool and(tool~=summon.Tool or tool.Parent~=char)then
if weaponBusy then cancelWeaponRequest()end
summon.Tool,summon.ReadyAt=tool,now+0.35
if tool.Parent~=char then hum:EquipTool(tool)end
state.WeaponStatus="Equipping "..tool.Name.." for breakables";return
end
if tool and now<(summon.ReadyAt or 0)then return end
if not gun and now>=(summon.NextLoad or 0)and not weaponBusy then
local comm=childPath(RS,"Remotes","CommF_")
if comm and comm:IsA("RemoteFunction")then
summon.NextLoad=now+10;summon.LoadIndex=(summon.LoadIndex or 0)%2+1
local name=({"Skull Guitar","Soul Guitar"})[summon.LoadIndex]
local generation=weaponGeneration;weaponBusy=true
weaponThread=task.spawn(function()
if generation~=weaponGeneration or not cfg.Enabled then return end
pcall(function()comm:InvokeServer("LoadItem",name)end)
if generation==weaponGeneration then weaponBusy=false end
end)
end
end
ctx.AimAt(position,part)
if skillPhase then
if tool and now>=nextSkill then
restorePhysics()
ctx.AimAt(position,part)
if useSkill(true)then summon.CastUntil=now+1.1 end
end
state.WeaponStatus=tool and(tool.Name.." skills → breakable")or "No loaded weapon"
state.SummonStatus=tool and("Skills: "..tool.Name)or "Load a guitar or combat tool"
return
end
if not gun or gun.Parent~=char or now<(summon.NextShot or 0)or weaponBusy then return end
summon.NextShot=now+0.65
if ctx.Input and ctx.Input.GetFocusedTextBox and ctx.Input:GetFocusedTextBox()then
state.SummonStatus="M1 paused: text box focused";return
end
summon.Attempts=summon.Attempts+1
local generation=weaponGeneration;weaponBusy=true
weaponThread=task.spawn(function()
if generation~=weaponGeneration then return end
if not cfg.Enabled or state.Escaping or gun.Parent~=player.Character or not part.Parent then weaponBusy=false;return end
ctx.AimAt(position,part)
local sent,backend=false,nil
if summon.Attempts>2 and workspace.CurrentCamera then
sent,backend=ctx.ClickArenaM1(position,part)
if sent then
summon.MouseClicks=(summon.MouseClicks or 0)+1;state.SummonStatus="M1 input: "..backend
end
end
if not sent then
sent,backend=ctx.ArenaNativeM1(gun)
if generation~=weaponGeneration then return end
if sent then
summon.NativeInputs=(summon.NativeInputs or 0)+1;state.SummonStatus="M1 request: game input"
else
summon.NativeIssue=backend
local inputSent,inputBackend=ctx.ClickArenaM1(position,part)
if inputSent then
sent=true;summon.MouseClicks=(summon.MouseClicks or 0)+1;state.SummonStatus="M1 input: "..inputBackend
elseif inputBackend=="text box focused"or inputBackend=="world click blocked by UI"then
state.SummonStatus="M1 paused: "..inputBackend
else
summon.InputIssue=inputBackend
sent=ctx.QuantumShoot(gun,position,root);state.SummonStatus="M1 fallback: Quantum"
if not sent then state.LastError="Arena M1 unavailable: "..tostring(inputBackend)end
end
end
end
if generation~=weaponGeneration then return end
weaponBusy=false
state.WeaponStatus=gun.Name.." M1 request #"..summon.Attempts
end)
end
local function potName(name)
local n = name:lower():gsub("[^%w]", "")
return n == "pot" or n == "pots" or n == "jars" or n == "vases" or n == "urns" or n:match("^pot%d+$") ~= nil
or n:match("^jar%d*$") ~= nil or n:match("^vase%d*$") ~= nil
or n:match("^urn%d*$") ~= nil or n == "flowerpot" or n == "breakablepot"
end
local function potGroup(object)
local name = object.Name:lower():gsub("[^%w]", "")
return name == "pots" or name == "jars" or name == "vases" or name == "urns"
end
local function objectPosition(object)
if object:IsA("BasePart") then return object.Position end
if object:IsA("Model") and object:FindFirstChildWhichIsA("BasePart", true) then
return object:GetPivot().Position
end
end
local function scanPots()
local map = workspace:FindFirstChild("Map")
local previous = pots[potIndex]
local found, seen = {}, {}
local bossArena = childPath(map, "TikiOutpost", "IslandModel", "IslandChunks", "D", "EagleBossArena")
if bossArena then
for _, object in ipairs(bossArena:GetChildren()) do
if object.Name == "Tree" and object:IsA("Model") then
local group = object:FindFirstChild("Group")
local part = group and group:GetChildren()[1]
if part and not part:IsA("BasePart")then part=group:FindFirstChildWhichIsA("BasePart",true)end
if part then found[#found + 1] = part; seen[part] = true end
end
end
end
local function consider(candidate)
if candidate:IsA("Folder") or (candidate:IsA("Model") and potGroup(candidate)) then
for _, child in ipairs(candidate:GetChildren()) do consider(child) end
return
end
if not candidate:IsA("Model") and not candidate:IsA("BasePart") then return end
local ancestor = candidate.Parent
while ancestor and ancestor ~= map do
if ancestor:IsA("Model") and potName(ancestor.Name) and not potGroup(ancestor) then candidate = ancestor end
ancestor = ancestor.Parent
end
local position = objectPosition(candidate)
if position and not seen[candidate] and (position - arena).Magnitude < 650 then
seen[candidate] = true
found[#found + 1] = candidate
end
end
if map then
for _, object in ipairs(map:GetDescendants()) do
if potName(object.Name) then
consider(object)
end
end
end
pots, state.PotCount = found, #found
potIndex=1
for index, object in ipairs(found) do
if object == previous then potIndex=index; break end
end
nextPotScan = os.clock() + 8
end
local function protection(now)
local char,hum,root=character()
if not char then return false end
local safety=ctx.Safety
local health=hum.Health/math.max(hum.MaxHealth,1)*100
if not cfg.Protection then
if state.Escaping then safety.Return=safety.Origin;clearProtection();cancelMove()end
return false
end
if not state.Escaping and health<=cfg.LowHP and now>=(safety.CooldownUntil or 0)then
state.Escaping=true;protectionCharacter=char
safety.Origin=root.CFrame;safety.LatchedReset=cfg.ResetAfterEscape
safety.Attempts,safety.NextTry=0,nil
escapePosition=root.Position+Vector3.new(0,cfg.EscapeHeight,0)
escapeStarted=now
state.Target=nil;cancelWeaponRequest();releaseKeys()
end
if not state.Escaping then return false end
if protectionCharacter~=char then clearProtection();safety.Return=nil;return false end
movement(CFrame.new(escapePosition),true)
if safety.LatchedReset then
state.Phase="Protection: reset latched; waiting for respawn"
local delay=math.max(0.5,math.min(10,tonumber(cfg.ResetDelay)or 2))
if now-escapeStarted>=delay and now>=(safety.NextTry or 0)then
if safety.Attempts>=3 then
safety.Return=safety.Origin;safety.CooldownUntil=now+5
state.LastError="Reset did not complete after 3 attempts; returning to farming"
clearProtection();cancelMove();return true
end
safety.Attempts=safety.Attempts+1;safety.NextTry=now+1.5
state.Phase="Protection: reset attempt "..safety.Attempts
pcall(function()hum.Health=0 end)
pcall(function()hum:ChangeState(Enum.HumanoidStateType.Dead)end)
if safety.Attempts>=2 then pcall(function()char:BreakJoints()end)end
end
return true
end
state.Phase="Protection: recovering"
if health>=math.max(cfg.ResumeHP,cfg.LowHP+5)then
safety.Return=safety.Origin;safety.CooldownUntil=now+3
clearProtection();cancelMove()
end
return true
end
local function fight(model, boss)
local _, part = living(model)
if not part then return end
state.Target = model
ctx.Summon.Aim,ctx.Summon.Part=nil,nil
ctx.Summon.CastUntil=0
ctx.ReleaseArenaInput()
state.Phase = boss and "Fighting Tyrant of the Skies" or ("Farming " .. baseName(model.Name))
watchTarget(model)
local offset = boss and Vector3.new(0, cfg.Distance, cfg.Distance)
or Vector3.new(0, cfg.Distance, 3)
if damageWatch and damageWatch.Model == model and damageWatch.FallbackUntil and os.clock() < damageWatch.FallbackUntil then
offset = Vector3.new(0, 3, 2)
end
movement(CFrame.lookAt(part.Position + offset, part.Position))
attack(model, part.Position)
end
local function step()
if not cfg.Enabled or state.Reconnecting then return end
if os.clock() < recoveryUntil then state.Phase = "Recovering after errors"; return end
local char, _, root = character()
if not root then
state.Phase = "Waiting for respawn"
state.Target = nil
restorePhysics()
return
end
local now = os.clock()
if protection(now) then return end
if ctx.Safety.Return then
state.Target=nil;state.Phase="Returning from protection"
local destination=ctx.Safety.Return
movement(destination)
if(root.Position-destination.Position).Magnitude<=5 then ctx.Safety.Return=nil end
return
end
if lastTravelCharacter ~= char then
lastTravelCharacter = char
if (root.Position - tikiEntry).Magnitude > 2500 then state.TravelToTiki = true end
end
if state.TravelToTiki then
state.Target = nil
state.Phase = "Travelling to Tiki Outpost at 210 studs/second"
local goal = CFrame.new(tikiEntry + Vector3.new(0, 10, 0))
movement(goal, false, 210)
if (root.Position - goal.Position).Magnitude <= 5 then state.TravelToTiki = false end
return
end
if now >= nextEyeRead then readEyeProgress() end
refreshSpawns()
local boss = findTarget(true)
if boss then
sweepUntil = 0
if cfg.KillBoss then fight(boss, true)
else state.Phase = "Boss active; boss combat disabled"; state.Target = nil; restorePhysics() end
return
end
local canSummon=eyeProgress.Found==4 and eyeProgress.Lit==4
if not canSummon then sweepUntil = 0 end
if cfg.SpawnBoss and canSummon and now >= nextSweep and sweepUntil == 0 then
sweepUntil, nextSweep = now + 35, now + 90
scanPots()
if #pots == 0 then
sweepUntil = 0
state.LastError = "No named pots detected; waiting for visible NPCs or pots."
end
end
if cfg.SpawnBoss and eyeProgress.Lit==4 then sweepUntil=math.max(sweepUntil,now+8)end
if cfg.SpawnBoss and sweepUntil > now then
state.Target = nil
if (root.Position - arena).Magnitude > 650 then
state.Phase = "Moving to the boss arena"
movement(CFrame.new(arena + Vector3.new(0, 12, 0)))
sweepUntil = now + 35
return
end
if now>=nextPotScan then scanPots();nextPotScan=now+0.25 end
local pot=pots[potIndex]
local position = pot and pot.Parent and objectPosition(pot)
if position then
state.Phase = "Breaking pots (spawn attempt)"
attackVase(position,pot:IsA("BasePart")and pot or pot:FindFirstChildWhichIsA("BasePart",true))
return
elseif #pots > 0 then
potIndex=potIndex%#pots+1
return
else
state.LastError = "No named pots found near the arena; automatic spawning needs live map inspection."
sweepUntil = 0
end
elseif sweepUntil ~= 0 then
sweepUntil = 0
end
if not cfg.FarmNPCs then
state.Target = nil
state.Phase = "Waiting; NPC farming disabled"
restorePhysics()
return
end
if eyeProgress.Lit == 4 and cfg.SpawnBoss then
state.Target = nil
state.Phase = "All four eyes lit; waiting for detectable pots"
nextSweep = math.min(nextSweep, now + 5)
restorePhysics()
return
end
local target = state.Target
local targetRoot
if target then local unused; unused, targetRoot = living(target) end
if not target or not target.Parent or not targetRoot or not isActiveEnemy(target) or not isTikiNPC(target, targetRoot) then
target = findTarget(false)
end
if target then spawnVisit = nil; fight(target, false); return end
state.Target = nil
if travelGoal and (root.Position - travelGoal.Position).Magnitude > 5 then
state.Phase = "Finishing the approach to the last target area"
movement(travelGoal)
return
end
if seekSpawn(root) then return end
state.Phase = "Waiting for Tiki NPCs to respawn"
restorePhysics()
end
local function observePlayerDeath()
local char = player.Character
local hum = char and char:FindFirstChildOfClass("Humanoid")
if hum == watchedHumanoid then return end
if deathConnection then deathConnection:Disconnect() end
watchedHumanoid, deathConnection = hum, nil
if hum then
deathConnection = hum.Died:Connect(function()
if not state.Alive then return end
stats.Deaths = stats.Deaths + 1
restorePhysics()
end)
end
end
local function maintenance()
updateStatsTime()
observePlayerDeath()
fast.MaintainBuso()
for model, connection in pairs(mobDeathConnections) do
if not model.Parent then connection:Disconnect(); mobDeathConnections[model] = nil end
end
local now = os.clock()
if cfg.Enabled and cfg.AntiAFK and now - lastAFK >= 60 then antiAFK() end
if cfg.AutoReconnect and cfg.Enabled and not state.Reconnecting and not maintenanceSuspended and CoreGui then
local ok, disconnected = pcall(function()
local prompts = CoreGui:FindFirstChild("RobloxPromptGui")
local prompt = prompts and prompts:FindFirstChild("ErrorPrompt", true)
if not prompt or not prompt.Visible then return false end
local text = ""
for _, item in ipairs(prompt:GetDescendants()) do
if item:IsA("TextLabel") then text = text .. " " .. item.Text:lower() end
end
return text:find("disconnect", 1, true) or text:find("connection", 1, true)
or text:find("kicked", 1, true) or text:find("error code", 1, true)
end)
if ok and disconnected then beginReconnect("Roblox disconnect prompt") end
end
reconnectTick()
ctx.Report.Tick()
if cfg.AutoRecovery and cfg.Enabled and not state.Reconnecting and not state.Escaping then
local target = state.Target
local hum = target and target:FindFirstChildOfClass("Humanoid")
if hum and hum.Health > 0 then
if not targetWatch or targetWatch.Model ~= target or targetWatch.Health ~= hum.Health then
targetWatch = { Model = target, Health = hum.Health, At = now }
elseif now - targetWatch.At >= 45 then
cancelMove()
cancelWeaponRequest()
releaseKeys()
state.Target, targetWatch = nil, nil
stats.Recoveries = stats.Recoveries + 1
state.RecoveryStatus = "Retargeted after 45 seconds without a health change"
end
else targetWatch = nil end
else targetWatch = nil end
saveSettings(false)
end
local function statsReport()
updateStatsTime()
local eyes=eyeProgress.Lit~=nil and(tostring(eyeProgress.Lit).."/4")or "Unknown"
return string.format(
"%s (@%s)\nSession: %s | Farming enabled: %s\nFragments: %s | Session: %s\nMoney: %s | Session: %s\nEyes: %s | Boss deaths observed: %d\nYour deaths: %d (includes resets)\nReconnect attempts: %d | Recoveries: %d\nWallet: %s",
tostring(player.DisplayName or player.Name),player.Name,formatTime(stats.ElapsedSeconds),formatTime(stats.ActiveSeconds),
ctx.Number(stats.CurrentFragments),ctx.Number(stats.NetFragments,true),ctx.Number(stats.CurrentBeli,false,"$"),ctx.Number(stats.NetBeli,true,"$"),
eyes,state.BossDefeats,stats.Deaths,stats.Reconnects,stats.Recoveries,state.WalletStatus)
end
function ctx.Report.URL(input)
local value=tostring(input or cfg.WebhookURL or ""):match("^%s*(.-)%s*$")
local host,path=value:match("^https://([^/]+)(/.*)$")
if not host or not({["discord.com"]=true,["discordapp.com"]=true,["canary.discord.com"]=true,["ptb.discord.com"]=true})[host]then return end
if not(path:match("^/api/webhooks/%d+/[^/?#%s]+")or path:match("^/api/v%d+/webhooks/%d+/[^/?#%s]+"))then return end
if value:find("[\r\n%s#]")then return end
if value:find("[?&]wait=")then return(value:gsub("([?&])wait=[^&]*","%1wait=true"))end
return value..(value:find("?",1,true)and "&"or "?").."wait=true"
end
function ctx.Report.Backend()
local fn=(syn and syn.request)or(http and http.request)or http_request or request
or(env.syn and env.syn.request)or env.http_request or env.request
return type(fn)=="function"and fn or nil
end
function ctx.Report.Payload(event)
updateStatsTime()
readEyeProgress()
local eyes=eyeProgress.Lit~=nil and(tostring(eyeProgress.Lit).."/4")or "Unknown"
local phase=state.Target and("Farm "..baseName(state.Target.Name))or state.Phase
local function plain(text)return tostring(text):gsub("[\r\n]"," "):gsub("[`*_<>]",""):sub(1,200)end
return {username="Darling's Tiki Kaitun",allowed_mentions={parse={}},embeds={{
title="Eyes Tyrant",color=11303412,description=plain(event or "Session update"),
fields={
{name="Fragments",value=ctx.Number(stats.CurrentFragments),inline=true},
{name="Session fragments",value=ctx.Number(stats.NetFragments,true),inline=true},
{name="Money",value=ctx.Number(stats.CurrentBeli,false,"$"),inline=true},
{name="Session money",value=ctx.Number(stats.NetBeli,true,"$"),inline=true},
{name="Eyes",value=eyes,inline=true},
{name="Player",value=plain(player.DisplayName or player.Name).." (@"..plain(player.Name)..")",inline=false},
{name="Status",value=plain(phase).." | Eyes "..eyes,inline=false},
},footer={text="Darling's Tiki Kaitun · Tyrant"},timestamp=os.date("!%Y-%m-%dT%H:%M:%SZ"),
}}}
end
function ctx.Report.Enqueue(event)
local report=ctx.Report
if not cfg.WebhookEnabled or not report.URL()then return false end
if not HttpService or not report.Backend()then state.WebhookStatus="Executor HTTP requests unavailable";return false end
if report.TerminalURL==cfg.WebhookURL then return false end
if #report.Queue>=3 then table.remove(report.Queue,1)end
report.Queue[#report.Queue+1]={Payload=report.Payload(event),URL=report.URL(),At=os.clock(),Attempts=0}
return true
end
function ctx.Report.Dispatch()
local report=ctx.Report
if report.Busy or #report.Queue==0 or os.clock()<report.Queue[1].At then return end
local job=table.remove(report.Queue,1)
local fn=report.Backend()
if not fn then state.WebhookStatus="Executor HTTP requests unavailable";return end
report.Busy=true;report.Job=job;report.StartedAt=os.clock()
local token=report.Generation
report.Thread=task.spawn(function()
if token~=report.Generation then return end
job.Attempts=job.Attempts+1
local ok,response=pcall(function()
local body=HttpService:JSONEncode(job.Payload)
return fn({Url=job.URL,Method="POST",Headers={["Content-Type"]="application/json"},Body=body,Timeout=15})
end)
if token~=report.Generation then return end
report.Busy,report.Job=false,nil
local status=ok and type(response)=="table"and tonumber(response.StatusCode or response.Status or response.status_code)or nil
if status and status>=200 and status<300 then
state.WebhookStatus="Report delivered";return
end
if status==401 or status==403 or status==404 then
report.TerminalURL=cfg.WebhookURL;report.Queue={}
state.WebhookStatus="Webhook HTTP "..status.."; update the URL to resume";return
end
local delay
if status==429 then
local success,data=pcall(function()return HttpService:JSONDecode(response.Body or response.body or "")end)
local headers=response.Headers or response.headers or {}
delay=success and type(data)=="table"and tonumber(data.retry_after)or tonumber(headers["Retry-After"]or headers["retry-after"])
delay=math.max(1,math.min(delay or 30,3600))
elseif not status or status>=500 then delay=5*2^(job.Attempts-1)end
if delay and job.Attempts<3 and state.Alive and not report.Closed then
job.At=os.clock()+delay;table.insert(report.Queue,1,job)
state.WebhookStatus="Report queued for retry"
else state.WebhookStatus=status and("Webhook HTTP "..status)or "Webhook request failed"end
end)
end
function ctx.Report.Tick()
local report=ctx.Report
if not report.Ready or report.Closed then return end
if not cfg.WebhookEnabled then state.WebhookStatus="Off";return end
if not report.URL()then state.WebhookStatus="Enter a Discord webhook URL";return end
if report.TerminalURL==cfg.WebhookURL then return end
local now=os.clock()
if report.Busy and now-report.StartedAt>20 then
report.Generation=report.Generation+1;cancelThread(report.Thread)
report.Busy,report.Job=false,nil;state.WebhookStatus="Webhook timed out; farming continues"
end
if not report.StartQueued then
if(stats.CurrentBeli~=nil and stats.CurrentFragments~=nil)or now-sessionStart>=15 then
report.StartQueued=report.Enqueue("Script started")
if report.StartQueued then report.NextAt=now+math.max(1,tonumber(cfg.WebhookIntervalMinutes)or 60)*60 end
end
elseif now>=report.NextAt then
report.Enqueue("Scheduled session update")
report.NextAt=now+math.max(1,tonumber(cfg.WebhookIntervalMinutes)or 60)*60
end
report.Dispatch()
end
function ctx.Report.Exit(event,close)
local report=ctx.Report
if report.Closed or(os.clock()-(report.LastExitAt or -math.huge)<10 and not close)then return end
report.LastExitAt=os.clock()
report.Generation=report.Generation+1;cancelThread(report.Thread)
report.Busy,report.Queue,report.Job=false,{},nil
if report.Enqueue(event)then report.Dispatch()end
if close then report.Closed=true end
end
local function updateESP()
if not cfg.ESPNPCs and not cfg.ESPBoss then clearESP(); return end
local char = player.Character
local playerRoot = char and char:FindFirstChild("HumanoidRootPart")
if not playerRoot then clearESP(); return end
local visible, candidates = {}, {}
for _, model in ipairs(enemies()) do
local hum, root = living(model)
local boss = isBoss(model)
if hum and ((boss and cfg.ESPBoss) or (not boss and cfg.ESPNPCs and isTikiNPC(model, root))) then
local distance = (playerRoot.Position - root.Position).Magnitude
if boss or distance <= 1400 then candidates[#candidates + 1] = { Model = model, Humanoid = hum, Root = root, Boss = boss, Distance = distance } end
end
end
table.sort(candidates, function(a, b)
if a.Boss ~= b.Boss then return a.Boss end
return a.Distance < b.Distance
end)
local npcCount = 0
for _, item in ipairs(candidates) do
local model, hum, root, boss = item.Model, item.Humanoid, item.Root, item.Boss
if boss or npcCount < 3 then
if not boss then npcCount = npcCount + 1 end
visible[model] = true
local entry = espObjects[model]
if entry and entry.Root ~= root then
entry.Highlight:Destroy(); entry.Billboard:Destroy(); espObjects[model] = nil; entry = nil
end
if not entry then
local color = boss and Color3.fromRGB(242, 191, 107) or Color3.fromRGB(176, 205, 219)
local highlight = Instance.new("Highlight")
highlight.Name, highlight.Adornee = "DarlingTikiOutline", model
highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
highlight.FillTransparency, highlight.OutlineTransparency = 1, 0.35
highlight.OutlineColor, highlight.Parent = color, model
local billboard = Instance.new("BillboardGui")
billboard.Name, billboard.Adornee, billboard.AlwaysOnTop = "DarlingTikiTag", root, true
billboard.Size, billboard.StudsOffset = UDim2.fromOffset(154, 34), Vector3.new(0, boss and 5 or 3.5, 0)
billboard.MaxDistance, billboard.Parent = boss and 6000 or 1400, root
local label = Instance.new("TextLabel")
label.BackgroundTransparency, label.Size = 1, UDim2.new(1, 0, 0, 24)
label.TextColor3, label.TextStrokeTransparency, label.TextSize = color, 0.45, 11
label.Font, label.Parent = Enum.Font.GothamMedium, billboard
local bar = Instance.new("Frame")
bar.Size, bar.Position = UDim2.new(0.72, 0, 0, 3), UDim2.new(0.14, 0, 0, 27)
bar.BackgroundColor3, bar.BackgroundTransparency, bar.BorderSizePixel = Color3.fromRGB(20, 25, 30), 0.15, 0
bar.Parent = billboard
local fill = Instance.new("Frame")
fill.Size, fill.BorderSizePixel, fill.BackgroundColor3, fill.Parent = UDim2.fromScale(1, 1), 0, color, bar
entry = { Highlight = highlight, Billboard = billboard, Label = label, HealthFill = fill, Root = root, Boss = boss }
espObjects[model] = entry
end
entry.Label.Text = (boss and "TYRANT" or baseName(model.Name)) .. "  ·  " .. math.floor(item.Distance) .. " studs"
entry.HealthFill.Size = UDim2.fromScale(math.max(0, math.min(1, hum.Health / math.max(hum.MaxHealth, 1))), 1)
end
end
for model, entry in pairs(espObjects) do
if not visible[model] then entry.Highlight:Destroy(); entry.Billboard:Destroy(); espObjects[model] = nil end
end
end
local controller = { Config = cfg, State = state, Stats = stats }
function controller:ReadEyeProgress() return readEyeProgress() end
function controller:GetStats() return statsReport() end
function controller:GetReportPayload()return ctx.Report.Payload("Preview")end
function controller:SaveSettings() return saveSettings(true) end
function controller:GetBreakableDiagnostics()
readEyeProgress()
local char,_,root=character()
local summon=ctx.Summon
local part=summon.Part
local tools={}
if char then for _,tool in ipairs(char:GetChildren())do
if tool:IsA("Tool")then
local remotes={}
for _,child in ipairs(tool:GetChildren())do
if child:IsA("RemoteEvent")or child:IsA("RemoteFunction")then remotes[#remotes+1]={Name=child.Name,Class=child.ClassName}end
end
tools[#tools+1]={Name=tool.Name,Category=tostring(tool.ToolTip),Enabled=tool.Enabled,Remotes=remotes}
end
end end
local path
if part then local ok,value=pcall(function()return part:GetFullName()end);if ok then path=value end end
return {Revision="arena-input-v2",Phase=state.Phase,Enabled=cfg.Enabled,EyesFound=eyeProgress.Found,EyesLit=eyeProgress.Lit,
Target=path,Distance=root and part and(root.Position-part.Position).Magnitude or nil,Tools=tools,
Attempts=summon.Attempts or 0,NativeRequests=summon.NativeInputs or 0,MouseRequests=summon.MouseClicks or 0,
NativeIssue=summon.NativeIssue,InputIssue=summon.InputIssue,Status=state.SummonStatus,
HeldFor=summon.TargetStarted and(os.clock()-summon.TargetStarted)or 0,
SkillCastRemaining=math.max(0,(summon.CastUntil or 0)-os.clock()),LastError=state.LastError}
end
function controller:Destroy()
if not state.Alive then return end
saveSettings(true)
ctx.Report.Exit("Script unloaded",true)
suppressSaving = true
stop()
state.Alive = false
if fast.Gate and fast.Gate.Owner==fast.Owner then fast.Gate.Allow=nil;fast.Gate.Owner=nil end
local aim=env.DarlingTikiAimBridge
if aim and aim.Owner==fast.Owner then aim.Read,aim.Owner=nil,nil end
if deathConnection then deathConnection:Disconnect() end
for _, connection in pairs(mobDeathConnections) do connection:Disconnect() end
for _, connection in ipairs(connections) do connection:Disconnect() end
if window then pcall(function() window:Destroy() end) end
if env.TikiKaitun == self then env.TikiKaitun = nil end
end
env.TikiKaitun = controller
function ctx.SetFarming(value)
if not state.Alive then return end
if not value then stop();if ctx.UI then ctx.UI:Refresh()end;return end
local thirdSea,reason=detectThirdSea()
if not thirdSea then
stop();state.Phase,state.LastError="Waiting for Third Sea detection",reason;notify(reason)
if ctx.UI then ctx.UI:Refresh()end
return
end
updateStatsTime()
cfg.Enabled,cfg.FarmNPCs,cfg.SpawnBoss,cfg.KillBoss=true,true,true,true
cfg.FastAttack,cfg.AutoBuso,cfg.ESPNPCs,cfg.ESPBoss=true,true,true,true
cfg.Protection,cfg.ResetAfterEscape=true,true
cfg.AntiAFK,cfg.AutoReconnect,cfg.AutoResume,cfg.AutoRecovery=true,true,true,true
cfg.NPCTarget,cfg.BreakableMode="Tyrant farm group","Guitar M1 + skills"
maintenanceSuspended,recoveryFailures,recoveryUntil=false,0,0
state.Phase,state.ErrorCount="Starting",0
local _,_,root=character()
state.TravelToTiki=root and(root.Position-tikiEntry).Magnitude>2500 or false
nextSweep,sweepUntil,nextEyeRead=0,0,0
setAutoV4(true);fast.MaintainBuso()
if ctx.UI then ctx.UI:Refresh()end
end
function ctx.SetWeapon(value)
cfg.WeaponType=value=="Fruit"and "Blox Fruit"or value;cfg.WeaponName=""
cancelWeaponRequest();releaseKeys()
if ctx.UI then ctx.UI:Refresh()end
end
function ctx.SaveWebhook(url,interval)
local minutes=tonumber(interval)
if not minutes or minutes~=minutes or minutes<1 or minutes>1440 then return false,"Choose an interval from 1 to 1440 minutes"end
url=tostring(url or ""):match("^%s*(.-)%s*$")
if url~=""and not ctx.Report.URL(url)then return false,"Enter a valid Discord webhook URL"end
local changed=url~=cfg.WebhookURL
local report=ctx.Report
if changed then
report.Generation=report.Generation+1;cancelThread(report.Thread)
report.Busy,report.Queue,report.Job=false,{},nil;report.TerminalURL,report.StartQueued=nil,false
end
cfg.WebhookURL=url;cfg.WebhookIntervalMinutes=math.floor(minutes)
report.NextAt=os.clock()+cfg.WebhookIntervalMinutes*60
report.Tick();saveSettings(true)
return true,url==""and "Reports disabled"or "Webhook settings saved"
end
ctx.Input = optionalService("UserInputService")
function controller:SetEnabled(value) ctx.SetFarming(value == true) end
function controller:SetWeapon(value) ctx.SetWeapon(value) end
function controller:SetWebhook(url, minutes) return ctx.SaveWebhook(url, minutes) end
function controller:SetOption(key, value)
if key == "Enabled" then return self:SetEnabled(value) end
if key == "WeaponType" then return self:SetWeapon(value) end
if cfg[key] == nil or type(cfg[key]) ~= type(value) then return false, "Unknown option or invalid type" end
cfg[key] = value; saveSettings(true); return true
end
masterToggle={Set=function(_,value)ctx.SetFarming(value)end}
connections[#connections + 1] = player.CharacterAdded:Connect(function()
restorePhysics()
cancelWeaponRequest()
cancelNativeWorkers()
ctx.Safety.Return=nil
auraGeneration = auraGeneration + 1
cancelThread(auraThread)
auraThread, auraBusy = nil, false
clearProtection()
state.Target = nil
targetWatch = nil
observePlayerDeath()
end)
if player.Idled then connections[#connections + 1] = player.Idled:Connect(antiAFK) end
if player.OnTeleport then
connections[#connections + 1] = player.OnTeleport:Connect(function(teleportState, placeId)
if teleportState==Enum.TeleportState.Started and ctx.Report.Ready then ctx.Report.Exit("Leaving server / teleporting")end
if teleportState == Enum.TeleportState.Failed then reconnectFailure("Teleport failed")
elseif placeId == reconnectPlaceId and cfg.Enabled and cfg.AutoResume and not maintenanceSuspended then queueResume() end
end)
end
if Players.PlayerRemoving then
connections[#connections+1]=Players.PlayerRemoving:Connect(function(who)
if who==player then ctx.Report.Exit("Player leaving")end
end)
end
if TeleportService and TeleportService.TeleportInitFailed then
connections[#connections + 1] = TeleportService.TeleportInitFailed:Connect(function(who, result, message)
if who == player then reconnectFailure(tostring(result) .. ": " .. tostring(message)) end
end)
end
connections[#connections + 1] = RunService.Heartbeat:Connect(function(dt)
if not state.Alive or not cfg.Enabled or not movementActive then
if hover or next(collision) then restorePhysics() end
return
end
local char, _, root = character()
if not char then return end
if movementFallback and movementFallback.Root == root then
local goal = movementFallback.Goal
local delta = goal.Position - root.Position
local range = math.max(32, math.min(tonumber(cfg.TPRange) or 320, 320))
if delta.Magnitude <= range then
root.CFrame = goal
movementFallback, travelGoal, movementWatch = nil, nil, nil
else
local distance = math.min(delta.Magnitude, movementFallback.Speed * math.max(0, math.min(tonumber(dt) or 1/60, 0.1)))
root.CFrame = CFrame.lookAt(root.Position + delta.Unit * distance, goal.Position)
end
root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
end
if not hover or hover.Parent ~= root then
if hover then hover:Destroy() end
hover = Instance.new("BodyVelocity")
hover.Name = "TikiKaitunHover"
hover.MaxForce = Vector3.new(1e8, 1e8, 1e8)
hover.Velocity = Vector3.zero
hover.Parent = root
end
for _, part in ipairs(char:GetDescendants()) do
if part:IsA("BasePart") then
if collision[part] == nil then collision[part] = part.CanCollide end
part.CanCollide = false
end
end
if cfg.FastAttack and not state.Escaping and not state.Reconnecting and state.Target and isActiveEnemy(state.Target)then
local _,part=living(state.Target)
if part then
local ok,err=pcall(attack,state.Target,part.Position)
if not ok then state.LastError="Fast attack pulse: "..tostring(err)end
end
end
end)
if window and window.OnDestroy then window:OnDestroy(function() controller:Destroy() end) end
task.spawn(function()
local nextStatus, nextESP = 0, 0
while state.Alive do
local ok, err = xpcall(step, debug.traceback)
if not ok then
state.LastError = tostring(err)
state.ErrorCount = state.ErrorCount + 1
restorePhysics()
if state.ErrorCount >= 3 then
if cfg.Enabled and cfg.AutoRecovery and recoveryFailures < 3 then
recoveryFailures = recoveryFailures + 1
stats.Recoveries = stats.Recoveries + 1
recoveryUntil = os.clock() + 30 * recoveryFailures
state.ErrorCount = 0
state.Target = nil
state.RecoveryStatus = "Error recovery pause; attempt " .. recoveryFailures .. " / 3"
else
stop()
if masterToggle.Set then masterToggle:Set(false) end
notify("Stopped after repeated errors. See Current task.")
end
end
else
state.ErrorCount = 0
end
if os.clock() >= nextMaintenance then
nextMaintenance = os.clock() + 1
local maintenanceOK, maintenanceError = xpcall(maintenance, debug.traceback)
if not maintenanceOK then state.LastError = "Overnight: " .. tostring(maintenanceError) end
end
if os.clock() >= nextESP then
nextESP = os.clock() + 0.25
local espOK, espError = xpcall(updateESP, debug.traceback)
if not espOK then
state.LastError = "ESP: " .. tostring(espError)
cfg.ESPNPCs, cfg.ESPBoss = false, false
clearESP()
end
end
if os.clock() >= nextStatus then
nextStatus = os.clock() + 1
if ctx.UI then pcall(function()ctx.UI:Refresh()end)end
end
task.wait(0.1)
end
end)
observePlayerDeath()
updateStatsTime()
state.ResumeStatus = queueFunction() and "Executor queue support detected" or "No executor queue support; manual restart required"
if type(resume) == "table" and type(resume.Config) == "table" then
for key, value in pairs(resume.Config) do
if type(cfg[key]) == type(value) and key ~= "Enabled" and key ~= "AutoV4" and key ~= "ESPNPCs" and key ~= "ESPBoss" then
cfg[key] = value
end
end
cfg.TweenSpeed = math.max(100, math.min(300, cfg.TweenSpeed))
end
cfg.WebhookIntervalMinutes=math.max(1,math.min(1440,tonumber(cfg.WebhookIntervalMinutes)or 60))
if resumeEnabled then masterToggle:Set(true) end
saveSettings(false)
ctx.Report.Ready=true;ctx.Report.Tick()
notify("Ready. Choose a weapon category and start farming; helpers run automatically.")
return controller
