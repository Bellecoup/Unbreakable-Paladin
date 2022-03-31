
local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
EventFrame:SetScript("OnEvent", function(self, event, ...)
	
	if(event == "PLAYER_EQUIPMENT_CHANGED") then
	HShield = false
		for x=1,40,1 do
			local _,_,_,_,_,_,_,_,_,s= UnitAura("player", x)
			if(s==27179) then
				HShield = true
				break
			else
				HShield = false
			end
		end
			
		if(HShield==true) then
			print("Avoidance is at:", GetDodgeChance()+GetBlockChance()+GetParryChance()+5+(GetCombatRating(CR_DEFENSE_SKILL)*150/355+20)*0.04)
		else
			print("Avoidance is at:", (GetDodgeChance()+GetBlockChance()+GetParryChance()+5+(GetCombatRating(CR_DEFENSE_SKILL)*150/355+20)*0.04)+30)
		end
	end
end)