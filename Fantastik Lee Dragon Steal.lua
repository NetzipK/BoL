if myHero.charName ~= "LeeSin" then return end

--[[		Auto Update		]]
local sversion = "0.16"
local AUTOUPDATE = true
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/BoLFantastik/BoL/master/Fantastik Lee Dragon Steal.lua".."?rand="..math.random(1,10000)
local UPDATE_FILE_PATH = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH

function AutoupdaterMsg(msg) print("<font color=\"#6699ff\"><b>Fantastik Lee Dragon Steal:</b></font> <font color=\"#FFFFFF\">"..msg..".</font>") end
if AUTOUPDATE then
	local ServerData = GetWebResult(UPDATE_HOST, "/BoLFantastik/BoL/master/version/Fantastik Lee Dragon Steal.version")
	if ServerData then
		ServerVersion = type(tonumber(ServerData)) == "number" and tonumber(ServerData) or nil
		if ServerVersion then
			if tonumber(sversion) < ServerVersion then
				AutoupdaterMsg("New version available "..ServerVersion)
				AutoupdaterMsg("Updating, please don't press F9")
				DelayAction(function() DownloadFile(UPDATE_URL, UPDATE_FILE_PATH, function () AutoupdaterMsg("Successfully updated. ("..sversion.." => "..ServerVersion.."), press F9 twice to load the updated version.") end) end, 3)
			else
				AutoupdaterMsg("You have got the latest version ("..ServerVersion..")")
			end
		end
	else
		AutoupdaterMsg("Error downloading version info")
	end
end

--- BoL Script Status Connector --- 
local ScriptKey = "SFIFEJIKGFN" -- Fantastik Lee Dragon Steal auth key
local ScriptVersion = "0.16" -- Your .version file content

-- Thanks to Bilbao for his socket help & encryption
assert(load(Base64Decode("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"), nil, "bt", _ENV))() BolBoost( ScriptKey, ScriptVersion )
-----------------------------------
-----------------------------------

local sauthor = "Fantastik"
local QREADY, WREADY, SREADY = false
local smite = nil
local Drake = nil
local target = nil
local Qable = false
local LastWard = nil
BackToWardable = false

local Spots = {
			["DrakeDraw"] = { ["x"] = 8581, ["y"] = 55.5, ["z"] = 4371 },
			["DrakeCast"] = { ["x"] = 9395, ["y"] = 4215 },
			["WardInDrake"] = { ["x"] = 8645, ["y"] =  55.8, ["z"] = 4165 },
}

function OnLoad()
	AddDrawCallback(StealDraw)
	AddTickCallback(KeyCheck)
	AddTickCallback(Checks)
	AddTickCallback(FindDrake)
	Menu()
	SmiteCheck()
	Init()
	
	jungleMonsters = minionManager(MINION_JUNGLE, 1000000000)
	
	PrintChat("<font color=\"#00FF00\">Fantastik Lee Dragon Steal version ["..sversion.."] by Fantastik loaded.</font>")
end

function KeyCheck()
	if LeeMenu.steal then
		JungleSteal()
	end
end

function Checks()
	QREADY = (myHero:CanUseSpell(_Q) == READY)
	WREADY = (myHero:CanUseSpell(_W) == READY)
	SREADY = (smite ~= nil and myHero:CanUseSpell(smite) == READY)
	
	jungleMonsters:update()
	
	for i,monster in pairs(jungleMonsters.objects) do
		if monster ~= nil and monster.valid and not monster.dead and monster.visible and monster.x ~= nil and monster.health > 0 then
			if monster.charName == "Dragon" then
				Drake = monster
			end
		end
	end	
	if Drake then
		qDmg = ((getDmg("Q", Drake, myHero)) or 0)
		sDmg = math.max(20*myHero.level+370,30*myHero.level+330,40*myHero.level+240,50*myHero.level+100)
		cDmg = (qDmg + sDmg)
	end
	BackToWard()
	
	if GetGame().isOver then
		UpdateWeb(false, ScriptName, id, HWID)
	end
end

function SmiteCheck()
	if myHero:GetSpellData(SUMMONER_1).name:find("summonersmite") then
		smite = SUMMONER_1
	elseif myHero:GetSpellData(SUMMONER_2).name:find("summonersmite") then
		smite = SUMMONER_2
	end
end

function OnDraw()
	if LeeMenu.debug then
	DrawText("X: "..myHero.x.."", 18, 100, 100, 0xFFFF0000)
	DrawText("Y: "..myHero.y.."", 18, 100, 120, 0xFFFFFF00)
	DrawText("Z: "..myHero.z.."", 18, 100, 140, 0xFFFF0000)
	end
end

function StealDraw()
	if GetDistance(Spots.DrakeDraw) < 125 or GetDistance(Spots.DrakeDraw, mousePos) < 125 then
		DrawCircle(Spots.DrakeDraw.x, Spots.DrakeDraw.y, Spots.DrakeDraw.z, 100, 0x107458)
	else
		DrawCircle(Spots.DrakeDraw.x, Spots.DrakeDraw.y, Spots.DrakeDraw.z, 100, 0x80FFFF)
	end
end

function JungleSteal()
		if QREADY and WREADY and SREADY then
			if GetDistance(Spots.DrakeDraw) <= 25 and LeeMenu.steal then
				wardSlot = getWardSlot()
				if myHero:GetSpellData(_Q).name == "BlindMonkQOne" then
					if ValidTarget(Drake) and wardSlot then
						if cDmg >= Drake.health and GetDistance(Drake) >= 1000 then
							CastSpell(wardSlot, Spots.WardInDrake.x, Spots.WardInDrake.z)
							CastSpell(_Q, Drake.x, Drake.z)
							if LeeMenu.debug then
								PrintChat("Casted Q")
							end
							DelayAction(function() ComboSteal() if LeeMenu.debug then PrintChat("Casted 2 Q") end end, 1)
						end
					end
				end
				myHero:HoldPosition()
				LeeMenu.steal = false
			elseif GetDistance(Spots.DrakeDraw) > 25 and GetDistance(Spots.DrakeDraw, mousePos) < 125 then 
				myHero:MoveTo(Spots.DrakeDraw.x, Spots.DrakeDraw.z)
			end
		end
end

function Menu()
	LeeMenu = scriptConfig("Lee jungle steal", "LSJS")
	LeeMenu:addParam("steal", "Jungle steal key", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("N"))
	LeeMenu:addParam("debug", "Debug", SCRIPT_PARAM_ONOFF, false)
	LeeMenu:addParam("Version", "Version", SCRIPT_PARAM_INFO, sversion)
	LeeMenu:addParam("Author", "Author", SCRIPT_PARAM_INFO, sauthor)
end

function getWardSlot()
    local WardSlot = nil
    if GetInventorySlotItem(2045) ~= nil and myHero:CanUseSpell(GetInventorySlotItem(2045)) == READY then
        WardSlot = GetInventorySlotItem(2045)
    elseif GetInventorySlotItem(2049) ~= nil and myHero:CanUseSpell(GetInventorySlotItem(2049)) == READY then
        WardSlot = GetInventorySlotItem(2049)
    elseif myHero:CanUseSpell(ITEM_7) == READY and myHero:getItem(ITEM_7).id == 3340 or myHero:CanUseSpell(ITEM_7) == READY and myHero:getItem(ITEM_7).id == 3350 or myHero:CanUseSpell(ITEM_7) == READY and myHero:getItem(ITEM_7).id == 3361 or myHero:CanUseSpell(ITEM_7) == READY and myHero:getItem(ITEM_7).id == 3362 then
        WardSlot = ITEM_7
    elseif GetInventorySlotItem(2044) ~= nil and myHero:CanUseSpell(GetInventorySlotItem(2044)) == READY then
        WardSlot = GetInventorySlotItem(2044)
    elseif GetInventorySlotItem(2043) ~= nil and myHero:CanUseSpell(GetInventorySlotItem(2043)) == READY then
        WardSlot = GetInventorySlotItem(2043)
    end
    return WardSlot
end

function ComboSteal()
	if sDmg >= Drake.health then
		if LeeMenu.debug then
			PrintChat("Smite damage >= Drake health")
		end
		CastSpell(_Q)
		CastSpell(smite, Drake)
		BackToWardable = true
	end
end

function OnCreateObj(object)
	if myHero.dead then return end
	if object ~= nil and object.valid and (object.name == "VisionWard" or object.name == "SightWard") then
		lastWard = object
	end
end

function BackToWard()
	if WREADY and BackToWardable then
		CastSpell(_W, lastWard)
		BackToWardable = false
	end
end

function Init()
HWID = Base64Encode(tostring(os.getenv("PROCESSOR_IDENTIFIER")..os.getenv("USERNAME")..os.getenv("COMPUTERNAME")..os.getenv("PROCESSOR_LEVEL")..os.getenv("PROCESSOR_REVISION")))
id = 95
ScriptName = "FantastikLeeDragonSteal"
assert(load(Base64Decode("G0x1YVIAAQQEBAgAGZMNChoKAAAAAAAAAAAAAQIDAAAAJQAAAAgAAIAfAIAAAQAAAAQKAAAAVXBkYXRlV2ViAAEAAAACAAAADAAAAAQAETUAAAAGAUAAQUEAAB2BAAFGgUAAh8FAAp0BgABdgQAAjAHBAgFCAQBBggEAnUEAAhsAAAAXwAOAjMHBAgECAgBAAgABgUICAMACgAEBgwIARsNCAEcDwwaAA4AAwUMDAAGEAwBdgwACgcMDABaCAwSdQYABF4ADgIzBwQIBAgQAQAIAAYFCAgDAAoABAYMCAEbDQgBHA8MGgAOAAMFDAwABhAMAXYMAAoHDAwAWggMEnUGAAYwBxQIBQgUAnQGBAQgAgokIwAGJCICBiIyBxQKdQQABHwCAABcAAAAECAAAAHJlcXVpcmUABAcAAABzb2NrZXQABAcAAABhc3NlcnQABAQAAAB0Y3AABAgAAABjb25uZWN0AAQQAAAAYm9sLXRyYWNrZXIuY29tAAMAAAAAAABUQAQFAAAAc2VuZAAEGAAAAEdFVCAvcmVzdC9uZXdwbGF5ZXI/aWQ9AAQHAAAAJmh3aWQ9AAQNAAAAJnNjcmlwdE5hbWU9AAQHAAAAc3RyaW5nAAQFAAAAZ3N1YgAEDQAAAFteMC05QS1aYS16XQAEAQAAAAAEJQAAACBIVFRQLzEuMA0KSG9zdDogYm9sLXRyYWNrZXIuY29tDQoNCgAEGwAAAEdFVCAvcmVzdC9kZWxldGVwbGF5ZXI/aWQ9AAQCAAAAcwAEBwAAAHN0YXR1cwAECAAAAHBhcnRpYWwABAgAAAByZWNlaXZlAAQDAAAAKmEABAYAAABjbG9zZQAAAAAAAQAAAAAAEAAAAEBvYmZ1c2NhdGVkLmx1YQA1AAAAAgAAAAIAAAACAAAAAgAAAAIAAAACAAAAAgAAAAMAAAADAAAAAwAAAAMAAAAEAAAABAAAAAUAAAAFAAAABQAAAAYAAAAGAAAABwAAAAcAAAAHAAAABwAAAAcAAAAHAAAABwAAAAgAAAAHAAAABQAAAAgAAAAJAAAACQAAAAkAAAAKAAAACgAAAAsAAAALAAAACwAAAAsAAAALAAAACwAAAAsAAAAMAAAACwAAAAkAAAAMAAAADAAAAAwAAAAMAAAADAAAAAwAAAAMAAAADAAAAAwAAAAGAAAAAgAAAGEAAAAAADUAAAACAAAAYgAAAAAANQAAAAIAAABjAAAAAAA1AAAAAgAAAGQAAAAAADUAAAADAAAAX2EAAwAAADUAAAADAAAAYWEABwAAADUAAAABAAAABQAAAF9FTlYAAQAAAAEAEAAAAEBvYmZ1c2NhdGVkLmx1YQADAAAADAAAAAIAAAAMAAAAAAAAAAEAAAAFAAAAX0VOVgA="), nil, "bt", _ENV))()
UpdateWeb(true, ScriptName, id, HWID)
end

function OnBugsplat()
	UpdateWeb(false, ScriptName, id, HWID)
end

function OnUnload()
	UpdateWeb(false, ScriptName, id, HWID)
end
