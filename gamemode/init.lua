
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function GM:PlayerSpawn(ply)

end

local data =  {
    Name = "Go-Kart",
    Class = "prop_gokart",
    Category = "gokart",
    Author = "z",
    Information = "Go-Kart made by SligWolf",
    Model = "models/sligwolf/gokart/sw_gokart.mdl",
    SW_Values_GoKart = {},
    SW_GoKart_Cams = {
        C1 = {},
        C2 = {},
        C3 = {},
        C4 = {}
    },
    SW_GoKart_Helper = {
        H1 = {}
    },
    SW_GoKart_Smoke = {
        S1 = {}
    },
    KeyValues = {
        vehiclescript = "scripts/vehicles/sligwolf/sw_gokart_new.txt"
    }
}
list.Set( "Vehicles", "gokart", data)

concommand.Add("asd", function(ply)
    local ent = ents.Create("gkarts_powerup")
    print(ent)
    ent:SetPos(ply:GetPos())
    ent:Spawn()
end)
