--[[ Gamemode got leaked. Old gamemode anyway hahahaha ]]--
-- CREATED BY JACKOOL (and darkrp base obviously)


GM.Version = "1"
GM.Name = "Liquid DarkRP"
GM.Author = "Jackool + DarkRP Creators and Deadman123/Derp"

CUR = "$"

include("modules/von.lua") --Temporary until I figure out how to officially bundle lua modules
AddCSLuaFile("modules/von.lua")
include("language_sh.lua") -- Had to move this
include("MakeThings.lua") -- this
include("shared.lua") -- and this up here to load before LDRP
AddCSLuaFile("client/help.lua")

include("liquiddrp/sv_playerfuncs.lua") -- Player functions for LiquidDRP; load it early rather than later
include("liquiddrp/sh_liquiddrp.lua") -- Same with shared LDRP
-----[[ Liquid DarkRP (BY JACKOOL) ]]-----------
local function LoadLiquidDarkRP()
	local function LiquidInclude(typ,fle)
		local realf = "liquiddrp/" .. fle .. ".lua"
		if typ == "sh" then
			include(realf)
			AddCSLuaFile(realf)
		elseif typ == "cl" then
			AddCSLuaFile(realf)
		elseif typ == "sv" then
			include(realf)
		end
	end

	LiquidInclude("sv","sv_resources")
	LiquidInclude("sv","sv_playerfuncs")
	LiquidInclude("sh","sh_chat")
	LiquidInclude("cl","sh_liquiddrp")
	LiquidInclude("sv","sv_inventory")
	LiquidInclude("sv","sv_printers")
	LiquidInclude("sv","sv_bank")
	LiquidInclude("sv","sv_skills")
	LiquidInclude("sv","sv_npcs")
	LiquidInclude("sv","sv_mining")
	LiquidInclude("cl","cl_hud")
	LiquidInclude("cl","cl_dermaskin")
	LiquidInclude("cl","cl_stores")
	
	LiquidInclude("sv","sv_crafting")
	LiquidInclude("cl","cl_crafting")
	
	LiquidInclude("sh","sh_qmenu")
	LiquidInclude("cl","cl_qmenu")
	LiquidInclude("sv","sv_qmenu")
	
	LiquidInclude("cl","cl_chat")
	
	LiquidInclude("sv","sv_trading")
	LiquidInclude("cl","cl_trading")
	
	LiquidInclude( "cl", "cl_skills" )
end
-------------------------------------------------

-- Checking if counterstrike is installed correctly
if table.Count(file.Find("*", "cstrike")) == 0 and table.Count(file.Find("cstrike_*", "GAME")) == 0 then
	timer.Create("TheresNoCSS", 10, 0, function()
	for k,v in pairs(player.GetAll()) do
		v:ChatPrint("Counter Strike: Source is incorrectly installed!")
		v:ChatPrint("You need it for DarkRP to work!")
		//print("Counter Strike: Source is incorrectly installed!\nYou need it for DarkRP to work!")
		end
	end)
end

-- RP Name Overrides
local meta = FindMetaTable("Player")

meta.SteamName = meta.SteamName or meta.Name --Fix for stack overflow?
function meta:Name()
	return GAMEMODE.Config.allowrpnames and self.DarkRPVars and self:getDarkRPVar("rpname")
		or self:SteamName()
end
meta.Nick = meta.Name
meta.GetName = meta.Name
-- End

RPArrestedPlayers = {}

DeriveGamemode("sandbox")
AddCSLuaFile("libraries/fn.lua")
AddCSLuaFile("sh_interfaceloader.lua")
AddCSLuaFile("language_sh.lua")
AddCSLuaFile("MakeThings.lua")
AddCSLuaFile("addentities.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("config.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("ammotypes.lua")
AddCSLuaFile("cl_vgui.lua")
AddCSLuaFile("entity.lua")
AddCSLuaFile("showteamtabs.lua")
AddCSLuaFile("sh_commands.lua")
AddCSLuaFile("client/help.lua")
AddCSLuaFile("sh_animations.lua")
AddCSLuaFile("Workarounds.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("shared/player_class.lua")

game.ConsoleCommand("sv_alltalk 0\n")

DB = DB or {}
GM.Config = GM.Config or {}
GM.NoLicense = GM.NoLicense or {}

include("_MySQL.lua")
include("config.lua")
include("licenseweapons.lua")

include("sh_interfaceloader.lua")

include("chat.lua")
include("admincc.lua")

include("shared/player_class.lua")
include("sh_animations.lua")
include("server/commands.lua")
include("sh_commands.lua")
include("entity.lua")

include("Workarounds.lua")

include("addentities.lua")
include("ammotypes.lua")
include("libraries/fn.lua")
include("server/database.lua")
MySQLite.initialize()
include("server/data.lua")
include("sv_gamemode_functions.lua")
include("main.lua")
include("player.lua")
include("questions.lua")
include("util.lua")
include("votes.lua")

include("client/help.lua")

LoadLiquidDarkRP() -- Load before FPP and FAdmin because they're annoying

-- Falco's prop protection
local BlockedModelsExist = sql.QueryValue("SELECT COUNT(*) FROM FPP_BLOCKEDMODELS1;") ~= false
if not BlockedModelsExist then
	sql.Query("CREATE TABLE IF NOT EXISTS FPP_BLOCKEDMODELS1(model VARCHAR(140) NOT NULL PRIMARY KEY);")
	include("fpp/fpp_defaultblockedmodels.lua") -- Load the default blocked models
end
AddCSLuaFile("fpp/sh_cppi.lua")
AddCSLuaFile("fpp/sh_settings.lua")
AddCSLuaFile("fpp/client/fpp_menu.lua")
AddCSLuaFile("fpp/client/fpp_hud.lua")
AddCSLuaFile("fpp/client/fpp_buddies.lua")
if UseFadmin then
	AddCSLuaFile("fadmin_darkrp.lua")
	include("fadmin_darkrp.lua")
end
if UseFPP then
	include("fpp/sh_settings.lua")
	include("fpp/sh_cppi.lua")
	include("fpp/server/fpp_settings.lua")
	include("fpp/server/fpp_core.lua")
	include("fpp/server/fpp_antispam.lua")
end

/*---------------------------------------------------------------------------
Loading modules
---------------------------------------------------------------------------*/
local fol = GM.FolderName.."/gamemode/modules/"
local files, folders = file.Find(fol .. "*", "LUA")
for k,v in pairs(files) do
	if GM.Config.DisabledModules[k] then continue end

	include(fol .. v)
end

for _, folder in SortedPairs(folders, true) do
	if folder ~= "." and folder ~= ".." and not GM.Config.DisabledModules[folder] then
		for _, File in SortedPairs(file.Find(fol .. folder .."/sh_*.lua", "LUA"), true) do
			if File == "sh_interface.lua" then continue end

			AddCSLuaFile(fol..folder .. "/" ..File)
			include(fol.. folder .. "/" ..File)
		end

		for _, File in SortedPairs(file.Find(fol .. folder .."/sv_*.lua", "LUA"), true) do
			if File == "sv_interface.lua" then continue end
			include(fol.. folder .. "/" ..File)
		end

		for _, File in SortedPairs(file.Find(fol .. folder .."/cl_*.lua", "LUA"), true) do
			if File == "cl_interface.lua" then continue end
			AddCSLuaFile(fol.. folder .. "/" ..File)
		end
	end
end

DarkRP.finish()

local function GetAvailableVehicles(ply)
	if not ply:IsAdmin() then return end
	ServerLog("Available vehicles for custom vehicles:")
	print("Available vehicles for custom vehicles:")
	for k,v in pairs(list.Get("Vehicles")) do
		ServerLog("\""..k.."\"")
		print("\""..k.."\"")
	end
end
concommand.Add("rp_getvehicles_sv", GetAvailableVehicles)

-- Vehicle fix from tobba!
function debug.getupvalues(f)
	local t, i, k, v = {}, 1, debug.getupvalue(f, 1)
	while k do
		t[k] = v
		i = i+1
		k,v = debug.getupvalue(f, i)
	end
	return t
end

--[[glon.encode_types = debug.getupvalues(glon.Write).encode_types
glon.encode_types["Vehicle"] = glon.encode_types["Vehicle"] or {10, function(o)
		return (IsValid(o) and o:EntIndex() or -1).."\1"
	end}]]
	
for k,v in pairs(LDRP_DLC.SV) do
	if v == "after" then include(k) end
end