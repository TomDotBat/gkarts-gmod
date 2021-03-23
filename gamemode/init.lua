
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function GM:PlayerSpawn(ply)

end

concommand.Add("asd", function(ply)
    local ent = ents.Create("gkarts_powerup")
    print(ent)
    ent:SetPos(ply:GetPos())
    ent:SetAngles(angle_zero)
    ent:Activate()
    ent:Spawn()
end)
