-- Copyright phobowarrior 2025
local mainframe = CreateFrame("Frame",nil,UIParent)

local TrollSpells = {
	[28148]="Portal: Karazhan",
	[49361]="Portal: Stonard",
	[11420]="Portal: Thunder Bluff",
	[32267]="Portal: Silvermoon",
	[11417]="Portal: Orgrimmar",
	[35717]="Portal: Shattrath",
	[11416]="Portal: Ironforge",
	[11419]="Portal: Darnassus",
	[10059]="Portal: Stormwind"
}

local lastsay = 0
local saytimer = 5

mainframe:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
mainframe:SetScript("OnEvent", function(self, event, ...)
	inInstance, instanceType = IsInInstance()
	if not inInstance or instanceType ~= "pvp" then 
		return 
	end
	local arg={...}
	local casterID=arg[1]
	local spellID=arg[3]
	if casterID == "player" then 
		--no point in asking people to report yourself
		return 
	end
	local time = GetTime()
	--print(UnitName casterID), spellID)
	if TrollSpells[spellID] ~= nil and time - lastsay >= saytimer  then
			lastsay = time
			local name = UnitName(casterID)
			PhoboSay(name .. " HAS CAST " .. TrollSpells[spellID].." TARGET "..name.." RIGHT CLICK THE TARGET PORTRAIT -> REPORT PLAYER -> GAMEPLAY SABOTAGE", "SAY")
			PhoboSay(name .. " HAS CAST " .. TrollSpells[spellID].." TARGET "..name.." RIGHT CLICK THE TARGET PORTRAIT -> REPORT PLAYER -> GAMEPLAY SABOTAGE", "YELL")
		end
	end
	
) -- end function


-- the PhoboSay function exists because you cannot use an addon to yell or say outside of an instance
-- if this function is called outside of an instance with SAY or YELL as the action then the player 
-- will instead emote the message 

local actions = {}
actions["SAY"] = "says "
actions["YELL"] = "yells "

function PhoboSay (msg, action)
	if actions[action] ~= nil then
		if inInstance then 
			SendChatMessage(msg, action)
		else
			SendChatMessage(actions[action]..msg,EMOTE)
		end
	else
		SendChatMessage(msg, action)
	end
end
