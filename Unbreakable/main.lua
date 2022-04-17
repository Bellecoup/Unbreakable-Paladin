local function AvoidanceCalc(LibramCheck, HShield)
	local DodgePer = GetDodgeChance()
	local BlockPer = GetBlockChance()
	local ParryPer = GetParryChance()
	local CRDef = (GetCombatRating(CR_DEFENSE_SKILL)*150/355+20)
	if (LibramCheck == false) then
		if(HShield == true) then
			local Avoidance = (DodgePer+BlockPer+ParryPer+5+(CRDef*0.04))
		else
			Avoidance = (DodgePer+BlockPer+ParryPer+5+(CRDef*0.04))+30
		end
	else
		if(HShield == true) then
			Avoidance = (DodgePer+BlockPer+ParryPer+5+(CRDef*0.04))
		else
			Avoidance = (DodgePer+BlockPer+ParryPer+5+(CRDef*0.04))+30+5.326455696202532
		end
	end
return Avoidance
end

local function AvoidanceCheck()
--Initializing flags to check for Holy Shield and Libram of Repentance
	local HShield = false
		--Loop to check all active buffs
		for x=1,40,1 do
			--Fetching information on currently selected buff
			local _,_,_,_,_,_,_,_,_,s= UnitAura("player", x)
			--Checking if the current buff is Holy Shield
			if(s==27179) then
				HShield = true
				break
			else
				HShield = false
			end
		end
		local Avoidance = 0
		--Checking if Libram of Repentance is equipped
		local Libram,_ = GetInventoryItemID("player", 18)
		if(Libram ~= 29388) then
			--Calculating effective avoidance based on whether or not Holy Shield is currently active and displaying results as if it were.	
			if(HShield==true) then
				Avoidance = AvoidanceCalc(false, true)
				local AvoOutput = string.format("%.2f %%", Avoidance)
				print("Avoidance is at:", AvoOutput)
			else
				Avoidance = AvoidanceCalc(false, false)
				AvoOutput = string.format("%.2f %%", Avoidance)
				print("Avoidance is at:", AvoOutput)
			end
		else
			if(HShield==true) then
				Avoidance = AvoidanceCalc(true, true)
				AvoOutput = string.format("%.2f %%", Avoidance)
				print("Avoidance is at:", AvoOutput)
			else
				Avoidance = AvoidanceCalc(true, false) 
				AvoOutput = string.format("%.2f %%", Avoidance)
				print("Avoidance is at:", AvoOutput)
			end
		end
end



SlashCmdList['UNBREAKABLE'] = function(msg)
	AvoidanceCheck()
end
SLASH_UNBREAKABLE1 = '/unbp'

local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
EventFrame:SetScript("OnEvent", function(self, event, ...)
	
	if(event == "PLAYER_EQUIPMENT_CHANGED") then
	AvoidanceCheck()
	end
end)