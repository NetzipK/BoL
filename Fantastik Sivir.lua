if myHero.charName ~= "Sivir" then return end
--[[
	
/$$$$$$$$                   /$$                           /$$     /$$ /$$              /$$$$$$  /$$            /$$          
| $$_____/                  | $$                          | $$    |__/| $$             /$$__  $$|__/           |__/          
| $$    /$$$$$$  /$$$$$$$  /$$$$$$    /$$$$$$   /$$$$$$$ /$$$$$$   /$$| $$   /$$      | $$  \__/ /$$ /$$    /$$ /$$  /$$$$$$ 
| $$$$$|____  $$| $$__  $$|_  $$_/   |____  $$ /$$_____/|_  $$_/  | $$| $$  /$$/      |  $$$$$$ | $$|  $$  /$$/| $$ /$$__  $$
| $$__/ /$$$$$$$| $$  \ $$  | $$      /$$$$$$$|  $$$$$$   | $$    | $$| $$$$$$/        \____  $$| $$ \  $$/$$/ | $$| $$  \__/
| $$   /$$__  $$| $$  | $$  | $$ /$$ /$$__  $$ \____  $$  | $$ /$$| $$| $$_  $$        /$$  \ $$| $$  \  $$$/  | $$| $$      
| $$  |  $$$$$$$| $$  | $$  |  $$$$/|  $$$$$$$ /$$$$$$$/  |  $$$$/| $$| $$ \  $$      |  $$$$$$/| $$   \  $/   | $$| $$      
|__/   \_______/|__/  |__/   \___/   \_______/|_______/    \___/  |__/|__/  \__/       \______/ |__/    \_/    |__/|__/      



Credits: Fantastik - Scripting the most parts, original creator 
         CrazyDud - Ideas, helping me to create
         QQQ - Also helping, fixing problems and teaching me stuff
		 Honda7 - Common Honda7 stuff
		 Anyone else that I might have forgotten

How to install: Go to Custom Scripts tab and press New Script. Paste the script inside there and click Save Script.
!ATTENTION!: Name it exactly "Fantastik Sivir".

Features:

   Key   |                  What it does
------------------------------------------------------------------------------------
Spacebar | Combo key - Uses Q, W and R. Spell usage can be disabled.
------------------------------------------------------------------------------------
    Z    | Poke key - Uses Q to poke the enemy. Can be disabled.
------------------------------------------------------------------------------------
    X    | Last Hit - Last hits the minions with AA.
------------------------------------------------------------------------------------
    C	 | Mixed Mode - Both last hit and poke.
------------------------------------------------------------------------------------
    V    | Lane Clear - Lane clear with AA, Q and W.
------------------------------------------------------------------------------------

Other features:

*	Free users & VIP users support!
*	Slice for minimum amount of enemies for R!
*	Slice for Q range!
*	Slice for mana manager for combo!
*	Smart lane clear using Q!
*	Slice for mana manager for farm!
*	Evadeee integration for E!
*	Auto Ignite in combo and if killable(KS)!
*	Auto Q kill if killable!
*	In-Game skin changer(Sadly VIP only)!
*	Auto level spells!
*	More to come soon!


Changelog:	

* v 0.82 
 Fixed a mistype error.

* v 0.81
 Remade Auto Level Spell function to a better one.

* v 0.8
 Added Manual HitChance settings
 Added use W on Lane Clear
 Fixed a little mistype on Poke

* v 0.65
 Fixed the range of Q which would change instead of only Combo
 Minor improvements

* v 0.6
 Added In-Game skin changer, thanks to shalzuth
 Added Auto spell leveler

* v 0.5
 Added Q for farm, will check for best pos to Q
 Added Q farm mana manager

* v 0.4
 Added AA reset with W

* v 0.3
 Added reqiured Libs download.
 Combo Q fix for free users.

* v 0.2:
 Added Auto Update
 Minor fixes
 Improvements

* v 0.1:
 Release
]]

--[[		Auto Update		]]
local sversion = "0.82"
local AUTOUPDATE = true
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/BoLFantastik/BoL/master/Fantastik Sivir.lua".."?rand="..math.random(1,10000)
local UPDATE_FILE_PATH = SCRIPT_PATH.."Fantastik Sivir.lua"
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH

function AutoupdaterMsg(msg) print("<font color=\"#6699ff\"><b>Fantastik Sivir:</b></font> <font color=\"#FFFFFF\">"..msg..".</font>") end
if AUTOUPDATE then
	local ServerData = GetWebResult(UPDATE_HOST, "/BoLFantastik/BoL/master/version/Fantastik Sivir.version")
	if ServerData then
		ServerVersion = type(tonumber(ServerData)) == "number" and tonumber(ServerData) or nil
		if ServerVersion then
			if tonumber(sversion) < ServerVersion then
				AutoupdaterMsg("New version available"..ServerVersion)
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

local REQUIRED_LIBS = 
	{
		["VPrediction"] = "https://raw.github.com/Hellsing/BoL/master/common/VPrediction.lua",
		["SOW"] = "https://raw.github.com/Hellsing/BoL/master/common/SOW.lua",
	}		
local DOWNLOADING_LIBS = false
local DOWNLOAD_COUNT = 0
local SELF_NAME = GetCurrentEnv() and GetCurrentEnv().FILE_NAME or ""

for DOWNLOAD_LIB_NAME, DOWNLOAD_LIB_URL in pairs(REQUIRED_LIBS) do
	if FileExist(LIB_PATH .. DOWNLOAD_LIB_NAME .. ".lua") then
		require(DOWNLOAD_LIB_NAME)
	else
		DOWNLOADING_LIBS = true
		DOWNLOAD_COUNT = DOWNLOAD_COUNT + 1

		print("<font color=\"#00FF00\">Fantastik Sivir:</font><font color=\"#FFDFBF\"> Not all required libraries are installed. Downloading: <b><u><font color=\"#73B9FF\">"..DOWNLOAD_LIB_NAME.."</font></u></b> now! Please don't press [F9]!</font>")
		print("Download started")
		DownloadFile(DOWNLOAD_LIB_URL, LIB_PATH .. DOWNLOAD_LIB_NAME..".lua", AfterDownload)
		print("Download finished")
	end
end

function AfterDownload()
	DOWNLOAD_COUNT = DOWNLOAD_COUNT - 1
	if DOWNLOAD_COUNT == 0 then
		DOWNLOADING_LIBS = false
		print("<font color=\"#00FF00\">Fantastik Sivir:</font><font color=\"#FFDFBF\"> Required libraries downloaded successfully, please reload (double [F9]).</font>")
	end
end
if DOWNLOADING_LIBS then return end

--[[		Code		]]
local sauthor = "Fantastik"
local QREADY, WREADY, EREADY, RREADY = false
local Qrange, Qwidth, Qspeed, Qdelay = 1075, 85, 1350, 0.250
local Rrange = 1000
local ignite = nil
local iDmg = 0
local target = nil
local ts
local ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, Qrange, DAMAGE_PHYSICAL, true)
local oldlvl = 0

----------------------------------------------

function OnLoad()
	PrintChat("<font color=\"#00FF00\">Fantastik Sivir version ["..sversion.."] by Fantastik loaded.</font>")
	if _G.Evadeee_Loaded then
	PrintChat("<font color=\"##58D3F7\"><b>Evadeee</b> found! You can use Evadeee integration!")
	_G.Evadeee_Enabled = true
	end
  	IgniteCheck()
	SLoadLib()
end


function OnTick()
  	ts:update()
  	target = ts.target
  	Checks()
	
  if ValidTarget(target) then
		if SivMenu.Extra.KS then KS(target) end
		if SivMenu.Extra.Ignite then AutoIgnite(target) end
	end
	
   if SivMenu.combokey then
		Combo()
   end
   if SivMenu.pokekey then
		Poke()
   end
   if SivMenu.farmkey then
		FarmQ()
		FarmW()
   end
   if SivMenu.Extra.Evade then
       EvadeeeHelper()
   end
end

function Checks()
	QREADY = (myHero:CanUseSpell(_Q) == READY)
	WREADY = (myHero:CanUseSpell(_W) == READY)
	EREADY = (myHero:CanUseSpell(_E) == READY)
	RREADY = (myHero:CanUseSpell(_R) == READY)
  	IREADY = (ignite ~= nil and myHero:CanUseSpell(ignite) == READY)
	
	Qrangec = SivMenu.Combo.Qrangemin
	
	SkinHack()
	AutoLevel()
end

function IgniteCheck()
	if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") then
			ignite = SUMMONER_1
	elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then
			ignite = SUMMONER_2
	end
end

function OnDraw()
	if SivMenu.Drawing.DrawAA then
	 SOWi:DrawAARange()
	end
   
   if SivMenu.Drawing.DrawQ then
	 if QREADY then
	 DrawCircle(myHero.x, myHero.y, myHero.z, Qrangec, 0xF7FE2E)
	 end
   end
end

function SLoadLib()
	EnemyMinions = minionManager(MINION_ENEMY, Qrange, myHero, MINION_SORT_MAXHEALTH_DEC)
	VP = VPrediction(true)
	SOWi = SOW(VP)
	SMenu()
	CurSkin = 0
end

function SMenu()

	SivMenu = scriptConfig("Fantastik Sivir", "Sivir")
	SivMenu:addParam("combokey", "Combo key(Space)", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	SivMenu:addParam("pokekey", "Poke key(Z)", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("Z"))
	SivMenu:addParam("farmkey", "Farm key(V)", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
	SivMenu:addParam("Version", "Version", SCRIPT_PARAM_INFO, sversion)
	SivMenu:addParam("Author", "Author", SCRIPT_PARAM_INFO, sauthor)
	
	SivMenu:addTS(ts)
	
	SivMenu:addSubMenu("Combo", "Combo")
	SivMenu.Combo:addParam("comboQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	SivMenu.Combo:addParam("Qrangemin", "Min. range for Q ", SCRIPT_PARAM_SLICE, 950, 600, 1075, 0)
	SivMenu.Combo:addParam("comboW", "Use W", SCRIPT_PARAM_ONOFF, true)
	SivMenu.Combo:addParam("comboR", "Use R", SCRIPT_PARAM_ONOFF, true)
	SivMenu.Combo:addParam("minEnemiesR", "Min. no. of enemies for R ", SCRIPT_PARAM_SLICE, 1, 1, 5, 0)
	SivMenu.Combo:addParam("manapls", "Min. % mana for spells ", SCRIPT_PARAM_SLICE, 30, 1, 100, 0)
	
	SivMenu:addSubMenu("Poke", "Poke")
	SivMenu.Poke:addParam("pokeQ", "Use Q", SCRIPT_PARAM_ONOFF, true)

	SivMenu:addSubMenu("Farm", "Farm")
	SivMenu.Farm:addParam("farmQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	SivMenu.Farm:addParam("farmW", "Use W", SCRIPT_PARAM_ONOFF, true)
	SivMenu.Farm:addParam("manafarm", "Min. % mana to farm", SCRIPT_PARAM_SLICE, 30, 1, 100, 0)
	
	SivMenu:addSubMenu("Drawing", "Drawing")
	SivMenu.Drawing:addParam("DrawAA", "Draw AA Range", SCRIPT_PARAM_ONOFF, true)
	SivMenu.Drawing:addParam("DrawQ", "Draw Q Range", SCRIPT_PARAM_ONOFF, true)
	
	SivMenu:addSubMenu("Orbwalker", "Orbwalker")
	SOWi:LoadToMenu(SivMenu.Orbwalker)
	
	SivMenu:addSubMenu("Extra", "Extra")
	SivMenu.Extra:addParam("KS", "Auto Killsteal", SCRIPT_PARAM_ONOFF, true)
	SivMenu.Extra:addParam("Ignite", "Use Auto Ignite", SCRIPT_PARAM_ONOFF, true)
	SivMenu.Extra:addParam("Hitchance", "Hitchance", SCRIPT_PARAM_LIST, 2, {"Very Low - 20%", "Low - 40%", "Medium - 60%", "High - 80%", "Very High - 99%"})
	SivMenu.Extra:addSubMenu("Auto level spells", "autolev")
	SivMenu.Extra.autolev:addParam("enabled", "Enable auto level spells", SCRIPT_PARAM_ONOFF, false)
	SivMenu.Extra.autolev:addParam("lvlseq", "Select your auto level sequence: ", SCRIPT_PARAM_LIST, 1, {"R>Q>W>E", "R>W>Q>E", "R>E>Q>W"})
	SivMenu.Extra:addSubMenu("Skin Hack - VIP ONLY", "skinhax")
	SivMenu.Extra.skinhax:addParam("enabled", "Enable Skin Hack", SCRIPT_PARAM_ONOFF, false)
	SivMenu.Extra.skinhax:addParam("skinid", "Choose skin: ", SCRIPT_PARAM_LIST, 1, {"No Skin", "Warrior Princess", "Spectacular", "Huntress", "Bandit", "PAX", "Snowstorm"})
	if _G.Evadeee_Loaded then
		SivMenu.Extra:addParam("Evade", "Use Evadeee Integration", SCRIPT_PARAM_ONOFF, true)
	end
	SivMenu:permaShow("combokey")
	SivMenu:permaShow("pokekey")
	SivMenu:permaShow("farmkey")
end

function KS(Target)
	if QREADY and getDmg("Q", Target, myHero) > Target.health then
		local CastPos = VP:GetLineCastPosition(Target, Qdelay, Qwidth, Qrange, Qspeed, myHero, true)
		if GetDistance(Target) <= Qrange and QREADY then
		CastSpell(_Q, CastPos.x, CastPos.z)
		end
	end
end
  
function AutoIgnite(enemy)
  	iDmg = ((IREADY and getDmg("IGNITE", enemy, myHero)) or 0) 
	if enemy.health <= iDmg and GetDistance(enemy) <= 600 and ignite ~= nil
		then
			if IREADY then CastSpell(ignite, enemy) end
	end
end

function EvadeeeHelper()
	if _G.Evadeee_impossibleToEvade then
		CastSpell(_E)
	end
end

function Combo()
if ValidTarget(target) and ManaManager() then
		if QREADY and SivMenu.Combo.comboQ then
			local CastPosition, HitChance, CastPos = VP:GetLineCastPosition(target, Qdelay, Qwidth, Qrangec, Qspeed, myHero, true)
			if HitChance >= SivMenu.Extra.Hitchance and GetDistance(CastPosition) <= Qrangec and QREADY then
				CastSpell(_Q, CastPosition.x, CastPosition.z)
			end
		end
	if RREADY and SivMenu.Combo.comboR and GetDistance(target) <= 600 then
		CastR()
	end
end
end

function Poke()
  if ValidTarget(target) then
		if SivMenu.Poke.pokeQ and QREADY then
			local CastPosition, HitChance, CastPos = VP:GetLineCastPosition(target, Qdelay, Qwidth, Qrange, Qspeed, myHero, true)
			if HitChance >= SivMenu.Extra.Hitchance and GetDistance(CastPosition) <= Qrange and QREADY then
				CastSpell(_Q, CastPosition.x, CastPosition.z)
			end
		end
	end
end

function GetBestQPositionFarm()
  local MaxQPos
  local MaxQ = 0
  for i, minion in pairs(EnemyMinions.objects) do
    local hitQ = CountMinionsHit(minion)
    if hitQ > MaxQ or MaxQPos == nil then
      MaxQPos = minion
      MaxQ = hitQ
    end
  end

  if MaxQPos then
    return MaxQPos
  else
    return nil
  end
end

function CastQFarm(to)
  CastSpell(_Q, to.x, to.z)
end

function FarmQ()
	if ManaManagerFarm() then
	EnemyMinions:update()
	if SivMenu.Farm.farmQ then
		if QREADY and #EnemyMinions.objects > 0 then
			for i, minion in pairs(EnemyMinions.objects) do
		    if GetDistance(minion) < Qrange then
				local QPos = GetBestQPositionFarm()
				if QPos then
					CastQFarm(QPos)
				end
			end
		end
	end
	end
end
end

function FarmW()
	if ManaManagerFarm() then
	EnemyMinions:update()
	if SivMenu.Farm.farmW then
		if WREADY and #EnemyMinions.objects > 3 then
			for i, minion in pairs(EnemyMinions.objects) do
			if GetDistance(minion) < 500 then
				CastSpell(_W)
			end
		end
	end
	end
end
end

function OnProcessSpell(unit, spell)
if unit == myHero and spell.name:lower():find("attack") then
    if SivMenu.combokey and WREADY and SivMenu.Combo.comboW and GetDistance(target) <= 600 then
		DelayAction(function() CastSpell(_W) end, spell.windUpTime + GetLatency() / 2000)
	end
end

function ManaManagerFarm()
	if myHero.mana >= myHero.maxMana * (SivMenu.Farm.manafarm / 100) then
	return true
	else
	return false
	end	 
end

function ManaManager()
	if myHero.mana >= myHero.maxMana * (SivMenu.Combo.manapls / 100) then
	return true
	else
	return false
	end	 
end

function CastR()
	if SivMenu.Combo.minEnemiesR <= CountEnemyHeroInRange(600) then
		CastSpell(_R)
	end
end
end

function CountMinionsHit(QPos)
  local LineEnd = Vector(myHero) + Qrange * (Vector(QPos) - Vector(myHero)):normalized()
  local n = 0
  for i, minion in pairs(EnemyMinions.objects) do
    local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(Vector(myHero), LineEnd, minion)
    if isOnSegment and GetDistance(minion, pointSegment) <= 85*1.25 then
      n = n + 1
    end
  end
  return n
end

function AutoLevel()
	if SivMenu.Extra.autolev.enabled then
		if SivMenu.Extra.autolev.lvlseq == 1 then seq = {1, 2, 1, 3, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3}
		elseif SivMenu.Extra.autolev.lvlseq == 2 then seq = {2, 1, 2, 3, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3}
		elseif SivMenu.Extra.autolev.lvlseq == 3 then seq = {3, 1, 3, 2, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2,}
		end
	end
	autoLevelSetSequence(seq)
end

function SkinHack()
	if SivMenu.Extra.skinhax.enabled and CurSkin ~= SivMenu.Extra.skinhax.skinid then
		local SkinIdSwap = { [1] = 7, [2] = 1, [3] = 2, [4] = 3, [5] = 4, [6] = 5, [7] = 6 }
		CurSkin = SivMenu.Extra.skinhax.skinid
		SkinChanger(myHero.charName, SkinIdSwap[CurSkin])
	end
end

function SkinChanger(champ, skinId) -- Credits to shalzuth
    p = CLoLPacket(0x97)
    p:EncodeF(myHero.networkID)
    p.pos = 1
    t1 = p:Decode1()
    t2 = p:Decode1()
    t3 = p:Decode1()
    t4 = p:Decode1()
    p:Encode1(t1)
    p:Encode1(t2)
    p:Encode1(t3)
    p:Encode1(bit32.band(t4,0xB))
    p:Encode1(1)
    p:Encode4(skinId)
    for i = 1, #champ do
        p:Encode1(string.byte(champ:sub(i,i)))
    end
    for i = #champ + 1, 64 do
        p:Encode1(0)
    end
    p:Hide()
    RecvPacket(p)
end
