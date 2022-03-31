
local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
EventFrame:SetScript("OnEvent", function(self, event, ...)
	
	if(event == "PLAYER_EQUIPMENT_CHANGED") then
	--Initializing flag to check if Holy Shield buff is active
	HShield = false
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
		--Calculating effective avoidance based on whether or not Holy Shield is currently active and displaying results as if it were.	
		if(HShield==true) then
			print("Avoidance is at:", GetDodgeChance()+GetBlockChance()+GetParryChance()+5+(GetCombatRating(CR_DEFENSE_SKILL)*150/355+20)*0.04)
		else
			print("Avoidance is at:", (GetDodgeChance()+GetBlockChance()+GetParryChance()+5+(GetCombatRating(CR_DEFENSE_SKILL)*150/355+20)*0.04)+30)
		end
	end
end)