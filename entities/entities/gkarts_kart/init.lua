
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/freeman/vehicles/electric_go-kart.mdl")
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
    end

    hook.Add("PlayerLeaveVehicle", self, self.DestroySeat)

    self:BuildSeat()
end

function ENT:Use(ply)
    if not ply:IsPlayer() then return end
    self:BuildSeat(ply)
end

function ENT:BuildSeat(driver)
    if IsValid(self.Driver) and IsValid(self.Chair) then return end

    if not IsValid(self.Chair) then
        self.Chair = ents.Create("prop_vehicle_prisoner_pod")
        self.Chair:SetParent(self)

        self.Chair:SetModel("models/nova/airboat_seat.mdl")
        self.Chair:SetNoDraw(true)

        self.Chair:SetMoveType(MOVETYPE_NONE)
        self.Chair:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod.txt")
        self.Chair:SetKeyValue("limitview", "0")

        self.Chair:Spawn()
        self.Chair:Activate()
    end

    local chairBone = self:LookupBone("gokart_characterplacement")
    if not chairBone then return end

    local chairPos, chairAngs = self:GetBonePosition(chairBone)
    if chairPos == self:GetPos() then
        chairPos = self:GetBoneMatrix(chairBone):GetTranslation()
    end

    chairAngs:RotateAroundAxis(chairAngs:Up(), -90) --The bone angles are off on this axis but it works perfectly on vehicle scripts, no idea why

    self.Chair:SetPos(self:WorldToLocal(chairPos) + Vector(0, 14, 0)) --The bone position also has the same problem
    self.Chair:SetAngles(chairAngs)

    if not IsValid(driver) then return end
    self.Driver = driver
    driver:EnterVehicle(self.Chair)
end

function ENT:DestroySeat()
    if IsValid(self.Chair) then
        self.Chair:Remove()
        self.Driver = nil
    end
end
