-- File: gmtools.lua
-- Addon: GMTools
-- Description: Custom slash command addon for World of Warcraft

-- Create the addon namespace
local addonName, addon = ...
local GMTOOLS = {}

-- Slash command registration
local function RegisterSlashCommands()
    -- Register main slash command
    SLASH_GMTOOLS1 = "/gmtools"
    SLASH_GMTOOLS2 = "/gmt"

    -- Define slash command handler
    SlashCmdList["GMTOOLS"] = function(input)
        GMTOOLS:HandleCommand(input)
    end
end

-- Command handling function
function GMTOOLS:HandleCommand(input)
    -- Split input into arguments
    local args = {}
    for arg in string.gmatch(input, "%S+") do
        table.insert(args, arg)
    end

    -- Default behavior when no arguments provided
    if #args == 0 then
        self:ShowHelp()
        return
    end

    -- Process commands
    local command = string.lower(args[1])

    if command == "help" or command == "h" then
        self:ShowHelp()
    elseif command == "version" or command == "v" then
        self:ShowVersion()
    elseif command == "test" then
        self:TestCommand()
    elseif command == "unbind" then
        addon:UnbindInstancesCommand()
    else
        print("|cFF00FF00GMTools|r: Unknown command. Type |cFFFF0000/gmt help|r for available commands.")
    end
end

-- Show help information
function GMTOOLS:ShowHelp()
    print("|cFF00FF00GMTools Addon Help|r")
    print("Available commands:")
    print("  |cFFFF0000/gmt help|h|cFFFFFFFF - Show this help message|r")
    print("  |cFFFF0000/gmt version|h|cFFFFFFFF - Show addon version|r")
    print("  |cFFFF0000/gmt test|h|cFFFFFFFF - Test command|r")
    print("  |cFFFF0000/gmt unbind|h|cFFFFFFFF - Initialize unbind macro|r")
end

-- Show version information
function GMTOOLS:ShowVersion()
    print("|cFF00FF00GMTools|r v1.0")
end

-- Example test command
function GMTOOLS:TestCommand()
    print("|cFF00FF00GMTools|r: Test command executed successfully!")
end

-- Initialize addon
function GMTOOLS:Initialize()
    -- Register slash commands
    RegisterSlashCommands()

    -- Print initialization message
    print("|cFF00FF00GMTools|r addon loaded successfully!")
end

-- Event handling (optional)
local function OnEvent(self, event, ...)
    if event == "PLAYER_LOGIN" then
        GMTOOLS:Initialize()
    end
end

-- Create frame for event handling
local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", OnEvent)

-- Register events
frame:RegisterEvent("PLAYER_LOGIN")

-- Initialize addon on load
GMTOOLS:Initialize()
