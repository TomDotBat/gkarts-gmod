
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/ns/karts/questionmark.mdl")
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
    end

    self:SetModelScale(.7)

    self.InitialPos = self:GetPos()
    self.InitialAngs = self:GetAngles()
end

function ENT:Think()
    self:NextThink(CurTime())

    self:SetPos(self.InitialPos + Vector(0, 0, math.sin(CurTime() * 2) * 4))
    self:SetAngles(self.InitialAngs + Angle(0, CurTime() * 100, 0))

    return true
end