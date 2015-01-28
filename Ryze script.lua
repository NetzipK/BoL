if myHero.charName ~= "Ryze" then return end -- If our champion name is not Ryze then the script will end, not run.

require "SxOrbWalk" -- We require our Orbwalker, in this case I am using SxOrbWalk.

--[[	VALUES		]]--
-- We will make our script values below, we are saving values to variables to save time. The values can be numbers,
-- characters, nil(nothing) or a bit more advanced stuff which are not needed for now. Here we will save our spell range
-- values, our ignite (which is going to be nil for now and later set our ignite summoner to the needed slot if it's detected),
-- our ignite damage (which is also going to be set later) and our spell ready checks which are going to be set to false.
-- We can either do them in seperate lines like below:
local Qrange = 625
local Wrange = 600
local Erange = 600
local ignite = nil
local iDMG = 0
-- Or just single lines like so:
local ignite, iDMG = nil, 0 -- This will set "ignite" to nil(nothing) and "iDMG" to 0.
local QREADY, WREADY, EREADY, RREADY = false -- This will set all of them to false.

function OnLoad() -- This is called once the script is loaded in game.
	-- We can put any Callback or function we want to be loaded once the game loads, for once and only here.
	PrintChat("Ryze loaded!") -- We are printing this once when the game loads. You can change "Ryze loaded!" to whatever you want.
	
	-- We are loading our IgniteCheck function and menu once the game is loaded.
	RyzeMenu()
	IgniteCheck()
end

function RyzeMenu()
	-- The callbacks above are all Menu Callbacks. You can find the Callbacks on the API which is on Open Developers Hut section.
	
	Config = scriptConfig("My Ryze", "Ryze") -- We are setting "Config" as our script config. It will put a Menu in the game called "My Ryze".
	
	Config:addSubMenu("Key Settings", "Keys") -- Explained below.
		Config.Keys:addParam("combokey", "Combo key", SCRIPT_PARAM_ONKEYDOWN, false, 32) -- We are making Space use our Combo. It will be ON when Space is held down.
	
	Config:addSubMenu("Combo Settings", "Combo") -- We are adding a sub-menu(menu inside menu) called Combo Settings. We will add params in it using "Combo", as below.
		Config.Combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true) -- Adding Parameters, or params, which will be able to be changed manually with ON or OFF. We set the default to ON.
		Config.Combo:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true) -- We will be able to check or set them on the script, which will be done below.
		Config.Combo:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true) -- We will use UseQ, UseE and UseW to do so.
		Config.Combo:addParam("UseR", "Use R", SCRIPT_PARAM_ONOFF, true)
		
	Config:addSubMenu("Misc", "Misc") -- Adding a sub-menu again, called Misc.
		Config.Misc:addParam("KS", "Auto KS with Q", SCRIPT_PARAM_ONOFF, true) -- Adding parameters inside Misc.
		Config.Misc:addParam("iKS", "Auto KS using ignite", SCRIPT_PARAM_ONOFF, true)
		
	Config:addSubMenu("Drawings", "Draw") -- Explained above.
		Config.Draw:addParam("DrawQ", "Draw Q range", SCRIPT_PARAM_ONOFF, true) -- Param for Q Range Drawing
	
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 700)
    ts.name = "Focus"
	Config:addSubMenu("Target Selector", "TS") -- Making a sub-menu for our target selector.
		Config.TS:addTS(ts) -- We are adding the Target Selector menu inside our sub-menu.
	
	Config:addSubMenu("Orbwalker", "SxOrb") -- Making a sub-menu for our Orbwalker.
		SxOrb:LoadToMenu(Config.SxOrb) -- We are adding the Orbwalker menu inside our sub-menu. We will use our Orbwalker's callback for this.

end

function OnTick() -- Any function is under this function will be loaded every 10 or so ms. Which means it will be always loaded. We can add our Checks etc here.
	Check() -- We are adding our Checks function to be loaded all the time from the start of the game to the end.
	
	if ValidTarget(target) then -- Is our target valid, not nil? If so, do as below.
		if Config.Misc.KS then -- Is "Auto KS with Q" ON? If so, do as below.
			KS(target) -- Using the function on our target
		end
		if Config.Misc.iKS then -- Both explained above.
			AutoIgnite(target)
		end
	end
	
	if Config.Keys.combokey then -- If our Combo Key is held do as below.
		Combo()	-- Use Combo function.
	end
end

function OnDraw() -- Drawing function which is also called like OnTick.
	if Config.Draw.DrawQ and QREADY and not myHero.dead then -- If the menu is ON and Q is ready and my hero is not dead then
		DrawCircle(myHero.x, myHero.y, myHero.z, Qrange, 0x00FF00) -- Draw a circle around me with Qrange(650) The color will be Green.
	end
end

function Checks()
	ts:update() -- We are updating our Target Selector every millisecond.
	target = ts.target -- We are making a new variable called "target" which will be our target selector's target.
	SxOrb:ForceTarget(target) -- We are forcing SxOrb to change it's target to Target Selector's target.
	
	QREADY = (myHero:CanUseSpell(_Q) == READY) -- The functions below will check if a spell is ready to use.
	WREADY = (myHero:CanUseSpell(_W) == READY) -- We are giving them their own variables, called as seen.
	EREADY = (myHero:CanUseSpell(_E) == READY)
	RREADY = (myHero:CanUseSpell(_R) == READY)
  	IREADY = (ignite ~= nil and myHero:CanUseSpell(ignite) == READY) -- We are making a bit of difference here, we are checking if ignite is not nil and checking if ready.
end

function Combo()
	if ValidTarget(target) then -- Checking if our target is valid.
		if RREADY and Config.Combo.UseR then -- If R is ready and "Use R" inside Combo is enabled then
			if GetDistance(target) <= Wrange then -- If our target's distance from us is smaller than Wrange(we are checking Wrange because we will start with W skill the combo after R) then
				CastSpell(_R) -- Cast R
			end
		end
		if WREADY and Config.Combo.UseW then -- Explained above.
			if GetDistance(target) <= Wrange then -- Explained above.
				CastSpell(_W, target) -- The W is targeted spell, so we will use it on our target
			end
		end
		if QREADY and Config.Combo.UseQ then -- Explained above.
			if GetDistance(target) <= Qrange then -- Explained above.
				CastSpell(_Q, target) -- Explained above.
			end
		end
		if EREADY and Config.Combo.UseE then -- Explained above.
			if GetDistance(target) <= Erange then -- Explained above.
				CastSpell(_E, target) -- Explained above.
			end
		end
	end
end

function KS(enemy)
	if QREADY and getDmg("Q", enemy, myHero) > enemy.health then -- We are checking if our Q is ready and it's damage is more than enemy's health.
		if GetDistance(enemy) <= Qrange then -- If the above requirements are met we are checking if our enemy's distance from us is smaller than Qrange, which is 650.
			CastSpell(_Q, enemy) -- If all the above are met, we finally cast the Q spell.
		end
	end
end

function AutoIgnite(enemy)
  	iDmg = ((IREADY and getDmg("IGNITE", enemy, myHero)) or 0) -- We are setting our ignite damage to the damange it will deal to an enemy.
	if enemy.health <= iDmg and GetDistance(enemy) <= 600 and ignite ~= nil then -- If the enemy has less HP than iDmg and enemy's distance is less than 600(our ignite range) and ignite is not nil then do as below.
		if IREADY then CastSpell(ignite, enemy) end -- We are checking if ignite is ready with IREADY and if so we are casting ignite on our enemy.
	end
end

function IgniteCheck()
	-- We are checking on which Summoner Spell(D/F) ignite is. Ignite's name is "summonerdot".
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then -- If it's on D, then do as below.
		ignite = SUMMONER_1 -- Set the "ignite" variable that we made on the top of the script to SUMMONER_1 which is D
	elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then -- else if it's on f, then do as below.
		ignite = SUMMONER_2 -- Set the "ignite" variable that we made on the top of the script to SUMMONER_2 which is F
	end
end
