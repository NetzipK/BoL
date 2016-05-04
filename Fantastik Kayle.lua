if myHero.charName ~= "Kayle" then return end
--[[
'======================================================================================================================================================'
'======================================================================================================================================================'
'======================================================================================================================================================'
' _______    ___      .__   __. .___________.    ___           _______.___________. __   __  ___     __  ___      ___   ____    ____  __       _______ '
'|   ____|  /   \     |  \ |  | |           |   /   \         /       |           ||  | |  |/  /    |  |/  /     /   \  \   \  /   / |  |     |   ____|'
'|  |__    /  ^  \    |   \|  | `---|  |----`  /  ^  \       |   (----`---|  |----`|  | |  '  /     |  '  /     /  ^  \  \   \/   /  |  |     |  |__   '
'|   __|  /  /_\  \   |  . `  |     |  |      /  /_\  \       \   \       |  |     |  | |    <      |    <     /  /_\  \  \_    _/   |  |     |   __|  '
'|  |    /  _____  \  |  |\   |     |  |     /  _____  \  .----)   |      |  |     |  | |  .  \     |  .  \   /  _____  \   |  |     |  `----.|  |____ '
'|__|   /__/     \__\ |__| \__|     |__|    /__/     \__\ |_______/       |__|     |__| |__|\__\    |__|\__\ /__/     \__\  |__|     |_______||_______|'
'																																					   '
'======================================================================================================================================================'
'======================================================================================================================================================'
'======================================================================================================================================================'


					SIMPLE 
						BUT
						 EFFECTIVE

	
	VERSION: 0.1
		DATE: 05/5/2016
				PATCH: 6.9
]]


local Q = {		range = 650, ready = false		}
local W = {		range = 900, ready = false		}
local E = {		range = 525, ready = false		}
local R = {		range = 900, ready = false		}

local isSAC, isSX, isPEW = 	false
local ignite, iDmg		 = 	nil, 0
local target 			 =	nil

function FMessage(msg) print("<font color = \"#FFFFFF\">[Fantastik Kayle] </font><font color=\"#FF0000\">"..msg.."</font>") end

local sversion = "0.1"
local AUTOUPDATE = true
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/BoLFantastik/BoL/master/Fantastik Kayle.lua".."?rand="..math.random(1,10000)
local UPDATE_FILE_PATH = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH
 
if AUTOUPDATE then
		local ServerData = GetWebResult(UPDATE_HOST, "/BoLFantastik/BoL/master/version/Fantastik Kayle.version")
		if ServerData then
				ServerVersion = type(tonumber(ServerData)) == "number" and tonumber(ServerData) or nil
				if ServerVersion then
						if tonumber(sversion) < ServerVersion then
								FMessage("New version available"..ServerVersion)
								FMessage("Updating, please don't press F9")
								DelayAction(function() DownloadFile(UPDATE_URL, UPDATE_FILE_PATH, function () FMessage("Successfully updated. ("..sversion.." => "..ServerVersion.."), press F9 twice to load the updated version.") end) end, 3)
						else
								FMessage("You have got the latest version ("..ServerVersion..")")
						end
				end
		else
				FMessage("Error downloading version info")
		end
end

function OnLoad()
	
	Minions = minionManager(MINION_ENEMY, E.range, myHero, MINION_SORT_MAXHEALTH_DEC)
	JMinions = minionManager(MINION_JUNGLE, E.range, myHero, MINION_SORT_MAXHEALTH_DEC)
	
--	IgniteCheck()
	LoadMenu()
	FMessage("Fantastik Kayle by Fantastik version [0.1]: LOADED.")
end

function IgniteCheck()
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then
		ignite = SUMMONER_1
	elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then
		ignite = SUMMONER_2
	end
end

function LoadMenu()
	Config = scriptConfig("Fantastik Kayle", "FK")
	
	Config:addSubMenu("[FK]Combo Settings", "Combo")
		Config.Combo:addParam("comboQ", "Use Q Spell", SCRIPT_PARAM_ONOFF, true)
		Config.Combo:addParam("comboE", "Use E Spell", SCRIPT_PARAM_ONOFF, true)
		Config.Combo:addParam("manapls", "Min. % mana for skills", SCRIPT_PARAM_SLICE, 40, 1, 100, 0)
		
	Config:addSubMenu("[FK]Harass Settings", "Harass")
		Config.Harass:addParam("harassQ", "Use Q Spell", SCRIPT_PARAM_ONOFF, true)
		Config.Harass:addParam("harassE", "Use E Spell", SCRIPT_PARAM_ONOFF, true)
		Config.Harass:addParam("manapls", "Min. % mana for skills", SCRIPT_PARAM_SLICE, 50, 1, 100, 0)
		
	Config:addSubMenu("[FK]LastHit Settings", "LastHit")
		Config.LastHit:addParam("lasthitQ", "Use Q Spell", SCRIPT_PARAM_ONOFF, true)
		Config.LastHit:addParam("manapls", "Min. % mana for skills", SCRIPT_PARAM_SLICE, 50, 1, 100, 0)
		
	Config:addSubMenu("[FK]Wave-/Jungle Clear Settings", "Farm")
		Config.Farm:addParam("farmQ", "Use Q Spell", SCRIPT_PARAM_ONOFF, true)
		Config.Farm:addParam("farmE", "Use E Spell", SCRIPT_PARAM_ONOFF, true)
		Config.Farm:addParam("manapls", "Min. % mana for skills", SCRIPT_PARAM_SLICE, 50, 1, 100, 0)
	
	Config:addSubMenu("[FK]Key Settings", "Keys")
		Config.Keys:addParam("Combo", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		Config.Keys:addParam("Harass", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		Config.Keys:addParam("LastHit", "LastHit Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
		Config.Keys:addParam("Farm", "Wave-/Jungle Clear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
		Config.Keys:addParam("Flee", "Flee Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("Z"))
		
	Config:addSubMenu("[FK]Skill Settings", "Skills")
		Config.Skills:addParam("WSet", "W Settings", SCRIPT_PARAM_INFO, "")
		Config.Skills:addParam("AutoHeal", "Use Auto-Heal", SCRIPT_PARAM_ONOFF, true)
		Config.Skills:addParam("minhealW", "Min. % health to W", SCRIPT_PARAM_SLICE, 30, 1, 100, 0)
		Config.Skills:addSubMenu("Who to use W on", "UsesW")
			Config.Skills.UsesW:addParam("lol", "-IF ENABLED-", SCRIPT_PARAM_INFO, "")
			Config.Skills.UsesW:addParam("Me", "Myself", SCRIPT_PARAM_ONOFF, true)
			for _, ally in ipairs(GetAllyHeroes()) do
				Config.Skills.UsesW:addParam(ally.hash, ally.charName, SCRIPT_PARAM_ONOFF, true)
			end
		Config.Skills:addParam("RSet", "R Settings", SCRIPT_PARAM_INFO, "")
		Config.Skills:addParam("AutoR", "Use Auto-R", SCRIPT_PARAM_ONOFF, true)
		Config.Skills:addParam("minhealR", "Min. % health to R", SCRIPT_PARAM_SLICE, 15, 1, 100, 0)
		Config.Skills:addSubMenu("Who to use R on", "UsesR")
			Config.Skills.UsesR:addParam("lol", "-IF ENABLED-", SCRIPT_PARAM_INFO, "")
			Config.Skills.UsesR:addParam("Me", "Myself", SCRIPT_PARAM_ONOFF, true)
			for _, ally in ipairs(GetAllyHeroes()) do
				Config.Skills.UsesR:addParam(ally.hash, ally.charName, SCRIPT_PARAM_ONOFF, true)
			end
			
	Config:addSubMenu("[FK]Draw Settings", "Draw")
		Config.Draw:addParam("drawQ", "Draw Q Spell range", SCRIPT_PARAM_ONOFF, true)
		Config.Draw:addParam("drawW", "Draw W Spell range", SCRIPT_PARAM_ONOFF, true)
		Config.Draw:addParam("drawE", "Draw E Spell range", SCRIPT_PARAM_ONOFF, true)
		Config.Draw:addParam("drawR", "Draw R Spell range", SCRIPT_PARAM_ONOFF, true)
		Config.Draw:addParam("LFC", "Use Lag-free circles", SCRIPT_PARAM_ONOFF, true)
		
	Config:addSubMenu("[FK]Killsteal Settings", "Misc")
		Config.Misc:addParam("ksQ", "Use Q to KS", SCRIPT_PARAM_ONOFF, true)
		Config.Misc:addParam("ksI", "Use Ignite to KS", SCRIPT_PARAM_ONOFF, true)
		
	DelayAction(function()
		if _G.Reborn_Loaded then
			PrintChat("<font color = \"#FFFFFF\">[Fantastik Kayle] </font><font color = \"#FF0000\">SAC Status:</font> <font color = \"#FFFFFF\">Successfully integrated.</font> </font>")
			Config:addParam("SACON","[Kayle] SAC:R support is active.", 5, "")
			isSAC = true
		elseif _Pewalk then
			PrintChat("<font color = \"#FFFFFF\">[Fantastik Kayle] </font><font color = \"#FF0000\">Pewalk Status:</font> <font color = \"#FFFFFF\">Successfully integrated.</font> </font>")
			Config:addParam("PEWON","[Kayle] PeWalk support is active.", 5, "")
			isPEW = true
		elseif not _G.Reborn_Loaded or not _Pewalk then
			require "SxOrbwalk"
			PrintChat("<font color = \"#FFFFFF\">[Fantastik Kayle] </font><font color = \"#FF0000\">Orbwalker not found:</font> <font color = \"#FFFFFF\">SxOrbWalk integrated.</font> </font>")
			Config:addSubMenu("Orbwalker", "SxOrb")
			SxOrb:LoadToMenu(Config.SxOrb)
			isSX = true
		end
	end, 10)
end

function GetCustomTarget()
	if _G.Reborn_Loaded and _G.AutoCarry and ValidTarget(_G.AutoCarry.Crosshair:GetTarget()) then return _G.AutoCarry.Crosshair:GetTarget() end
	if _Pewalk and ValidTarget(_Pewalk.GetTarget()) then return _Pewalk.GetTarget() end
	if not _G.Reborn_Loaded or not _Pewalk and isSX == true then return SxOrb:GetTarget() end
end

function OnTick()
	target = GetCustomTarget()
	Checks()
	
	if Config.Keys.Combo then
		Combo()
	end
	
	if Config.Keys.Harass then
		Harass()
	end
	
	if Config.Keys.Farm then
		Farm()
	end
	
	if Config.Keys.LastHit then
		LastHit()
	end
	
	if Config.Keys.Flee then
		Flee()
	end
	
	if ValidTarget(target) then
		KillSteal(target)
	end
end

function Checks()
	Q.ready = (myHero:CanUseSpell(_Q) == READY)
	W.ready = (myHero:CanUseSpell(_W) == READY)
	E.ready = (myHero:CanUseSpell(_E) == READY)
	R.ready = (myHero:CanUseSpell(_R) == READY)
	QREADY = (myHero:CanUseSpell(_Q) == READY)
	IREADY = (ignite ~= nil and myHero:CanUseSpell(ignite) == READY)
	
	AutoW()
	AutoR()
end

function DrawCirc(x, y, z, range, color)
	if Config.Draw.LFC then
		DrawCircle2(x, y, z, range, color)
	else
		DrawCircle(x, y, z, range, color)
	end
end

function ManaManagerC()
	if myHero.mana >= myHero.maxMana * (Config.Combo.manapls / 100) then
	return true
	else
	return false
	end
end

function ManaManagerH()
	if myHero.mana >= myHero.maxMana * (Config.Harass.manapls / 100) then
	return true
	else
	return false
	end
end


function ManaManagerLH()
	if myHero.mana >= myHero.maxMana * (Config.LastHit.manapls / 100) then
	return true
	else
	return false
	end
end


function ManaManagerF()
	if myHero.mana >= myHero.maxMana * (Config.Farm.manapls / 100) then
	return true
	else
	return false
	end
end


function OnDraw()
	if myHero.dead then return end
	
	if Config.Draw.drawQ and Q.ready then
		DrawCirc(myHero.x, myHero.y, myHero.z, Q.range, 0xFF008000)
	end
	
	if Config.Draw.drawW and W.ready then
		DrawCirc(myHero.x, myHero.y, myHero.z, W.range, 0xFF00F2FF)
	end
	
	if Config.Draw.drawE and E.ready then
		DrawCirc(myHero.x, myHero.y, myHero.z, E.range, 0xFFFF0000)
	end
	
	if Config.Draw.drawR and R.ready then
		DrawCirc(myHero.x, myHero.y, myHero.z, R.range, 0xFFFFFF00)
	end
end

function Combo()
	if ValidTarget(target) then
		if Q.ready and Config.Combo.comboQ and GetDistance(target) < Q.range and ManaManagerC() then
			CastSpell(_Q, target)
		end
		
		if E.ready and Config.Combo.comboE and GetDistance(target) < E.range and ManaManagerC() then
			CastSpell(_E)
		end
	end
end

function Harass()
	if ValidTarget(target) then
		if Q.ready and Config.Harass.comboQ and GetDistance(target) < Q.range and ManaManagerH() then
			CastSpell(_Q, target)
		end
		
		if E.ready and Config.Harass.comboE and GetDistance(target) < E.range and ManaManagerH() then
			CastSpell(_E)
		end
	end
end

function LastHit()
	Minions:update()
	if not ManaManagerLH() then return end
	
	for i, minion in pairs(Minions.objects) do
		if ValidTarget(minion) and Config.LastHit.lasthitQ and GetDistance(minion) < Q.range and Q.ready then
			if getDmg("Q", minion, myHero) > minion.health then
				CastSpell(_Q, minion)
			end
		end
	end
end

function Farm()
	Minions:update()
	JMinions:update()
	if not ManaManagerF() then return end
	
	for i, minion in pairs(Minions.objects) do
		if ValidTarget(minion) and Config.Farm.farmQ and GetDistance(minion) < Q.range and Q.ready then
			if getDmg("Q", minion, myHero) > minion.health then
				CastSpell(_Q, minion)
			end
		end

		if ValidTarget(minion) and Config.Farm.farmE and GetDistance(minion) < E.range and E.ready then
			CastSpell(_E)
		end
	end
	
	for i, jminion in pairs(JMinions.objects) do
		if ValidTarget(jminion) and Config.Farm.farmQ and GetDistance(jminion) < Q.range then
			if getDmg("Q", jminion, myHero) > jminion.health then
				CastSpell(_Q, jminion)
			end
		end

		if ValidTarget(jminion) and Config.Farm.farmE and GetDistance(jminion) < E.range then
			CastSpell(_E)
		end
	end
end

function AutoW()
	if Config.Skills.AutoHeal and W.ready then
		if myHero.health < myHero.maxHealth * (Config.Skills.minhealW / 100) and Config.Skills.UsesW.Me then
			CastSpell(_W, myHero)
		end
		for _, unit in ipairs(GetAllyHeroes()) do
			if unit.health < unit.maxHealth * (Config.Skills.minhealW / 100) and GetDistance(unit) < W.range and Config.Skills.UsesW[unit.hash] and unit ~= nil then
				CastSpell(_W, unit)
			end
		end
	end
end

function AutoR()
	if Config.Skills.AutoR and R.ready then
		if myHero.health < myHero.maxHealth * (Config.Skills.minhealR / 100) and Config.Skills.UsesR.Me then
			CastSpell(_R, myHero)
		end
		for _, unit in ipairs(GetAllyHeroes()) do
			if unit.health < unit.maxHealth * (Config.Skills.minhealR / 100) and GetDistance(unit) < R.range and Config.Skills.UsesR[unit.hash] and unit ~= nil then
				CastSpell(_R, unit)
			end
		end
	end
end

function KillSteal(enemy)
	iDmg = ((IREADY and getDmg("IGNITE", enemy, myHero)) or 0)
	if Q.ready and Config.Misc.ksQ and GetDistance(enemy) < Q.range then
		if getDmg("Q", enemy, myHero) > enemy.health then
			CastSpell(_Q, enemy)
		end
	end
	
	if IREADY and Config.Misc.ksI and GetDistance(enemy) < 600 and ignite ~= nil then
		CastSpell(ignite, enemy)
	end
end

function Flee()
	if ValidTarget(target) then
		if Q.ready and GetDistance(target) < Q.range then
			CastSpell(_Q, target)
		end
	end
	if W.ready then
		CastSpell(_W, myHero)
	end
	player:MoveTo(mousePos.x, mousePos.z)
end

function DrawCircleNextLvl(x, y, z, radius, width, color, chordlength)
	radius = radius or 300
	quality = math.max(8,round(180/math.deg((math.asin((chordlength/(2*radius)))))))
	quality = 2 * math.pi / quality
	radius = radius*.92
	local points = {}
	for theta = 0, 2 * math.pi + quality, quality do
		local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
		points[#points + 1] = D3DXVECTOR2(c.x, c.y)
	end
	DrawLines2(points, width or 1, color or 4294967295)
end

function round(num)
	if num >= 0 then return math.floor(num+.5) else return math.ceil(num-.5) end
end

function DrawCircle2(x, y, z, radius, color)
	local vPos1 = Vector(x, y, z)
	local vPos2 = Vector(cameraPos.x, cameraPos.y, cameraPos.z)
	local tPos = vPos1 - (vPos1 - vPos2):normalized() * radius
	local sPos = WorldToScreen(D3DXVECTOR3(tPos.x, tPos.y, tPos.z))
	if OnScreen({ x = sPos.x, y = sPos.y }, { x = sPos.x, y = sPos.y }) then
		DrawCircleNextLvl(x, y, z, radius, 1, color, 80)
	end
end
