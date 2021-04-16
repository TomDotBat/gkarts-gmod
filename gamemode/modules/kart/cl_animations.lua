
local kart = debug.getregistry()["gKart"]
local STEER_POSE = "vehicle_steer"

function kart:AnimationThink()
    self:SetPoseParameter(STEER_POSE, self.nSteering)
end

gKarts.AddKartThinkMethod("animations", kart.AnimationThink)
