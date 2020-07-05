
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function GM:PreGamemodeLoaded()
    print("[G-Karts] Started Loading!")
end