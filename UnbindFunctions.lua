-- File: UnbindFunctions.lua
-- Contains instance unbind functionality for GMTools addon

local addonName, addon = ...

-- 1. Create the persistent global secure button frame
local secureButton = CreateFrame("Button", "GMToolsSecureMacroButton", UIParent, "SecureActionButtonTemplate")

-- 2. This is the logic that scans the raid and writes the macro text
function addon:UpdateRosterMacro()
    local namesToProcess = {}
    
    if GetNumRaidMembers() > 0 then
        for i = 1, GetNumRaidMembers() do
            local name = GetRaidRosterInfo(i)
            if name then table.insert(namesToProcess, name) end
        end
    elseif GetNumPartyMembers() > 0 then
        table.insert(namesToProcess, GetUnitName("player"))
        for i = 1, GetNumPartyMembers() do
            if UnitExists("party" .. i) then
                local name = GetUnitName("party" .. i)
                if name then table.insert(namesToProcess, name) end
            end
        end
    else
        -- If you are solo, just process yourself
        table.insert(namesToProcess, GetUnitName("player"))
    end

    -- Build the massive multi-target macro string
    local macroBody = ""
    for _, name in ipairs(namesToProcess) do
        macroBody = macroBody .. "/targetexact " .. name .. "\n"
        macroBody = macroBody .. ".instance unbind all\n"
    end
    macroBody = macroBody .. "/cleartarget"

    -- Inject the compiled text directly into the secure hardware template
    secureButton:SetAttribute("type", "macro")
    secureButton:SetAttribute("macrotext", macroBody)
end

-- 3. This function creates the initial macro placeholder if it doesn't exist
function addon:UnbindInstancesCommand()
    local macroIndex = GetMacroIndexByName("GM_Unbind")
    
    -- This execution string forces the client to run your Lua update script *first*, 
    -- and then instantly triggers the secure frame click on the exact same frame.
    local executionString = "/script GMTools_UpdateAndRun()\n/click GMToolsSecureMacroButton"

    local chosenIconIndex = 135 

    if macroIndex == 0 then
        CreateMacro("GM_Unbind", chosenIconIndex, executionString, 1)
        print("|cFF00FF00GMTools|r: Unbind macro created! Drag '|cFFFF0000GM_Unbind|r' to your action bar.")
    else
        EditMacro(macroIndex, "GM_Unbind", chosenIconIndex, executionString)
        print("|cFF00FF00GMTools|r: Unbind macro reset. Drag '|cFFFF0000GM_Unbind|r' to your action bar.")
    end
end

-- 4. Global bridge function so the macro can talk back to the addon script
_G["GMTools_UpdateAndRun"] = function()
    addon:UpdateRosterMacro()
end
