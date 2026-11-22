local H=game:GetService('HttpService')
local F={LastReport='No flags executed.'}
local originals={}
local function functions()
local e=getgenv and getgenv()or _G
return setfflag or set_fflag or e.setfflag or e.set_fflag,getfflag or get_fflag or e.getfflag or e.get_fflag
end
local function candidates(name)
local short=name:gsub('^DFFlag',''):gsub('^FFlag',''):gsub('^DFInt',''):gsub('^FInt',''):gsub('^DFString',''):gsub('^FString','')
if short~=name then return {short,name}end
return {name,'FFlag'..name,'DFFlag'..name,'DFInt'..name,'FInt'..name,'FString'..name}
end
local function normalized(v)return tostring(v):lower()end
function F.Apply(text)
assert(type(text)=='string'and #text<=65536,'JSON must be under 64 KB')
local flags=H:JSONDecode(text);assert(type(flags)=='table','Expected a JSON object')
local setter,getter=functions();assert(type(setter)=='function','This executor does not expose setfflag / set_fflag')
local count=0;for name,value in pairs(flags)do
assert(type(name)=='string'and name:match('^[%w_]+$'),'Flag names must be strings')
assert(type(value)=='boolean'or type(value)=='string'or(type(value)=='number'and value==value and math.abs(value)<math.huge),'Flag values must be finite primitives')
count=count+1
end
assert(count>0 and count<=256,'Expected 1–256 flags')
local verified,accepted,failed=0,0,0;local details={}
for name,value in pairs(flags)do
local did,unverified=false,false
for _,key in ipairs(candidates(name))do
local priorOK,prior=false,nil;if getter then priorOK,prior=pcall(getter,key)end
local ok,result=pcall(setter,key,tostring(value))
if ok and result~=false then
if priorOK and prior~=nil and originals[key]==nil then originals[key]={Value=prior}end
if getter then
local readOK,read=pcall(getter,key)
if readOK and normalized(read)==normalized(value)then did=true;break end
else unverified=true;break end
end
end
if did then verified=verified+1;details[#details+1]=name..': verified'
elseif unverified then accepted=accepted+1;details[#details+1]=name..': accepted, no readback'
else failed=failed+1;details[#details+1]=name..': unsupported / unchanged'end
end
F.LastReport=string.format('%d verified · %d accepted without readback · %d failed\n',verified,accepted,failed)..table.concat(details,'\n')
return F.LastReport
end
function F.Restore()
local setter=functions();assert(setter,'setfflag is unavailable')
local restored,failed=0,0
for key,entry in pairs(originals)do local ok,result=pcall(setter,key,tostring(entry.Value));if ok and result~=false then restored=restored+1;originals[key]=nil else failed=failed+1 end end
F.LastReport=string.format('%d original values restored · %d failed',restored,failed);return F.LastReport
end
return F
