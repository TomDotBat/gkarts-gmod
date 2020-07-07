
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function GM:PlayerSpawn(ply)
    local x = ents.Create("prop_physics")
    x:SetPos(ply:GetPos() + Vector(10,10,10))
    x:SetModel("models/props_borealis/bluebarrel001.mdl")
    x:Spawn()
    drive.PlayerStartDriving( ply, x, "gokart_drive" )
end