
local _R = debug.getregistry()

local kart = _R["gKart"] or {}
kart.__index = kart

AccessorFunc(kart, "pDriver", "Driver")

AccessorFunc(kart, "nSpeed", "Speed", FORCE_NUMBER)
AccessorFunc(kart, "nThrottle", "Throttle", FORCE_NUMBER)
AccessorFunc(kart, "nSteering", "Steering", FORCE_NUMBER)

AccessorFunc(kart, "nTargetThrottle", "TargetThrottle", FORCE_NUMBER)
AccessorFunc(kart, "nTargetSteering", "TargetSteering", FORCE_NUMBER)

_R["gKart"] = kart


gKarts.Karts = gKarts.Karts or setmetatable({}, {
    __mode = "k"
})

function _R.Player:GetKart()
    return gKarts.Karts[self]
end

function gKarts.CreateKart(ply)
    if IsValid(gKarts.Karts[ply]) then return gKarts.Karts[ply] end

    local ent = ents.CreateClientProp("models/freeman/vehicles/electric_go-kart.mdl")

    for key, value in pairs(kart) do
        ent[key] = value
    end

    ent:SetSpeed(0)

    ent:SetThrottle(0)
    ent:SetSteering(0)

    ent:SetTargetThrottle(0)
    ent:SetTargetSteering(0)

    ent:SetDriver(ply)

    local isLocalKart = ply == LocalPlayer()
    hook.Run("gKarts.KartCreated", ent, ply, isLocalKart)

    gKarts.Karts[ply] = ent

    if isLocalKart then
        gKarts.LocalKart = ent
    end

    return ent
end
