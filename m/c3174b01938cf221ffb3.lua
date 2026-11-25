local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local KeybindsSystem = {
List = {},
Bindables = {},
ListeningForIndex = nil,
OnChanged = nil,
Loaded = false,
}
local CONFIG_FILE = "DarlingX_Keybinds.json"
local inputBeganConn = nil
local inputEndedConn = nil
local exIsFile = isfile or is_file
local exReadFile = readfile or read_file
local exWriteFile = writefile or write_file

local function normalizeKey(k)
if not k then return "" end
local s = tostring(k):gsub("^Enum%.KeyCode%.", "")
local numMap = {["1"]="One", ["2"]="Two", ["3"]="Three", ["4"]="Four", ["5"]="Five", ["6"]="Six", ["7"]="Seven", ["8"]="Eight", ["9"]="Nine", ["0"]="Zero"}
return numMap[s] or s
end

function KeybindsSystem.RegisterBindable(name, kind, data)
if not name or name == "" then return end
KeybindsSystem.Bindables[name] = {
name = name,
kind = kind or "Toggle",
get = data and data.get or function() return false end,
set = data and data.set or function(v) end,
toggle = data and data.toggle or function() end,
trigger = data and data.trigger or function() end,
}
end

function KeybindsSystem.GetBindable(name)
if not name or name == "" or name == "None" then return nil end
local cleanName = tostring(name):gsub("^.*·%s*", "")

local sources = {
KeybindsSystem.Bindables,
_G.DarlingX_Bindables,
_G.UI_BINDABLES,
_G.SweetBindables,
}
for _, src in ipairs(sources) do
if type(src) == "table" then
if src[name] then return src[name] end
if src[cleanName] then return src[cleanName] end
for k, v in pairs(src) do
if tostring(k):lower() == tostring(name):lower() or tostring(k):lower() == cleanName:lower() then
return v
end
local strippedK = tostring(k):gsub("^.*·%s*", "")
if strippedK:lower() == cleanName:lower() or strippedK:lower() == tostring(name):lower() then
return v
end
end
end
end

local toggleSources = {_G.UI_TOGGLES}
for _, toggles in ipairs(toggleSources) do
if type(toggles) == "table" then
local t = toggles[cleanName] or toggles[name]
if not t then
for k, v in pairs(toggles) do
if tostring(k):lower() == cleanName:lower() or tostring(k):lower() == tostring(name):lower() then
t = v
break
end
end
end
if t then
return {
name = name,
kind = "Toggle",
get = t.get or function() return false end,
set = function(v) if t.set then t.set(v, true) end end,
toggle = function()
if t.get and t.set then
t.set(not t.get(), true)
end
end,
}
end
end
end

local tab = tostring(name):match("^([^·]+)%s*·")
if tab then
tab = tab:gsub("%s+", "")
local loadFn = _G.LoadFeatures or _G.DarlingX_LoadFeatures or _G.SweetExploit_LoadFeatures
if type(loadFn) == "function" then
local ok = pcall(loadFn, tab)
if ok then
for _, src in ipairs(sources) do
if type(src) == "table" and (src[name] or src[cleanName]) then
return src[name] or src[cleanName]
end
end
end
end
end

return nil
end

function KeybindsSystem.GetAllBindablesList()
local names = {}
local seen = {}
local function add(n)
if n and n ~= "" and not seen[n] then
seen[n] = true
names[#names + 1] = n
end
end
for name, _ in pairs(KeybindsSystem.Bindables) do add(name) end
if type(_G.DarlingX_Bindables) == "table" then for name, _ in pairs(_G.DarlingX_Bindables) do add(name) end end
if type(_G.UI_BINDABLES) == "table" then for name, _ in pairs(_G.UI_BINDABLES) do add(name) end end
if type(_G.SweetBindables) == "table" then for name, _ in pairs(_G.SweetBindables) do add(name) end end
if type(_G.UI_TOGGLES) == "table" then for name, _ in pairs(_G.UI_TOGGLES) do add(name) end end
table.sort(names, function(a, b) return a:lower() < b:lower() end)
return names
end

function KeybindsSystem.AddKeybind(targetName, keyName, mode)
if not targetName or not keyName then return end
local b = KeybindsSystem.GetBindable(targetName)
local defaultMode = (b and b.kind == "Button") and "Press" or "Toggle"
table.insert(KeybindsSystem.List, {
target = targetName,
key = keyName,
mode = mode or defaultMode,
isHeld = false,
})
KeybindsSystem.Save()
if KeybindsSystem.OnChanged then
pcall(KeybindsSystem.OnChanged)
end
end

function KeybindsSystem.RemoveKeybind(index)
if KeybindsSystem.List[index] then
table.remove(KeybindsSystem.List, index)
KeybindsSystem.Save()
if KeybindsSystem.OnChanged then
pcall(KeybindsSystem.OnChanged)
end
end
end

function KeybindsSystem.ClearAll()
KeybindsSystem.List = {}
KeybindsSystem.Save()
if KeybindsSystem.OnChanged then
pcall(KeybindsSystem.OnChanged)
end
end

function KeybindsSystem.SetKey(index, keyName)
if KeybindsSystem.List[index] and keyName then
KeybindsSystem.List[index].key = keyName
KeybindsSystem.Save()
if KeybindsSystem.OnChanged then
pcall(KeybindsSystem.OnChanged)
end
end
end

function KeybindsSystem.SetMode(index, mode)
if KeybindsSystem.List[index] and mode then
KeybindsSystem.List[index].mode = mode
KeybindsSystem.Save()
if KeybindsSystem.OnChanged then
pcall(KeybindsSystem.OnChanged)
end
end
end

function KeybindsSystem.Save()
if not exWriteFile then return end
local data = {}
for _, item in ipairs(KeybindsSystem.List) do
table.insert(data, {
target = item.target,
key = item.key,
mode = item.mode or "Toggle",
})
end
pcall(function()
local encoded = HttpService:JSONEncode(data)
if makefolder and not (isfolder and isfolder("SweetExploit")) then
pcall(makefolder, "SweetExploit")
end
pcall(function() exWriteFile("SweetExploit/keybinds.json", encoded) end)
pcall(function() exWriteFile(CONFIG_FILE, encoded) end)
end)
end

function KeybindsSystem.Load()
if KeybindsSystem.Loaded then return end
KeybindsSystem.Loaded = true
if not exIsFile or not exReadFile then return end
local content = nil
pcall(function()
if exIsFile("SweetExploit/keybinds.json") then
content = exReadFile("SweetExploit/keybinds.json")
elseif exIsFile(CONFIG_FILE) then
content = exReadFile(CONFIG_FILE)
end
end)
if content and #content > 2 then
local okDecode, decoded = pcall(function()
return HttpService:JSONDecode(content)
end)
if okDecode and type(decoded) == "table" then
KeybindsSystem.List = {}
for _, item in ipairs(decoded) do
if type(item) == "table" and item.target and item.key then
table.insert(KeybindsSystem.List, {
target = tostring(item.target),
key = tostring(item.key),
mode = item.mode or "Toggle",
isHeld = false,
})
end
end
end
end
end

function KeybindsSystem.Init()
KeybindsSystem.Load()
if inputBeganConn then inputBeganConn:Disconnect(); inputBeganConn = nil end
if inputEndedConn then inputEndedConn:Disconnect(); inputEndedConn = nil end
inputBeganConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
if UserInputService:GetFocusedTextBox() then return end
if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
local keyName = input.KeyCode.Name
for _, item in ipairs(KeybindsSystem.List) do
if normalizeKey(item.key):upper() == keyName:upper() then
local b = KeybindsSystem.GetBindable(item.target)
if b then
if item.mode == "Toggle" then
if b.kind == "Toggle" then
b.toggle()
else
b.trigger()
end
elseif item.mode == "Hold" then
item.isHeld = true
if b.kind == "Toggle" then
b.set(true)
else
b.trigger()
end
elseif item.mode == "Press" then
if b.kind == "Button" then
b.trigger()
else
b.toggle()
end
end
end
end
end
end)
inputEndedConn = UserInputService.InputEnded:Connect(function(input, gameProcessed)
if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
local keyName = input.KeyCode.Name
for _, item in ipairs(KeybindsSystem.List) do
if normalizeKey(item.key):upper() == keyName:upper() and item.mode == "Hold" then
item.isHeld = false
local b = KeybindsSystem.GetBindable(item.target)
if b and b.kind == "Toggle" then
b.set(false)
end
end
end
end)
end
_G.DarlingX_KeybindsSystem = KeybindsSystem
_G.SweetKeybindsSystem = KeybindsSystem
return KeybindsSystem
