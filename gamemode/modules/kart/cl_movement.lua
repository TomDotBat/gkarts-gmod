
hook.Add("gKarts.KartCreated", "gKarts.MovementInput", function(kart, driver, isLocal)
    if not isLocal then return end

    hook.Add("Move", kart, function(_,  _, mv)
        kart:SetTargetThrottle(mv:GetForwardSpeed() / 10000)
        kart:SetTargetSteering(mv:GetSideSpeed() / 10000)

        kart:MovementThink()
    end)
end)

do
    local kart = debug.getregistry()["gKart"]
    local lerp = Lerp
    local frameTime = FrameTime
    local CONSTANTS = gKarts.Constants

    AccessorFunc(kart, "nSpeed", "Speed", FORCE_NUMBER)
    AccessorFunc(kart, "nThrottle", "Throttle", FORCE_NUMBER)
    AccessorFunc(kart, "nSteering", "Steering", FORCE_NUMBER)

    AccessorFunc(kart, "nTargetThrottle", "TargetThrottle", FORCE_NUMBER)
    AccessorFunc(kart, "nTargetSteering", "TargetSteering", FORCE_NUMBER)

    function kart:MovementThink()
        local ft = frameTime()
        self.nThrottle = lerp(ft * CONSTANTS.KART_THROTTLE_SENSITIVITY, self.nThrottle, self.nTargetThrottle)
        self.nSteering = lerp(ft * CONSTANTS.KART_STEERING_SENSITIVITY, self.nSteering, self.nTargetSteering)

        --debugoverlay.Sphere(self:LocalToWorld(CONSTANTS.KART_STEER_FORCE_ORIGIN), 4, 1, HSVToColor((CurTime() * 50) % 360, 1, 1), true)

        local physObj = self:GetPhysicsObject()
        physObj:ApplyForceCenter(self:GetRight() * -200000 * self.nThrottle * FrameTime())
        physObj:ApplyTorqueCenter(self:GetUp() * -40000 * self.nSteering * FrameTime())
        --physObj:ApplyForceCenter(self:GetForward() * 1000 * self.nSteering, self:LocalToWorld(CONSTANTS.KART_STEER_FORCE_ORIGIN))
    end
end

hook.Add("gKarts.KartCreated", "gKarts.MovementDefaults", function(kart)
    kart:SetSpeed(0)

    kart:SetThrottle(0)
    kart:SetSteering(0)

    kart:SetTargetThrottle(0)
    kart:SetTargetSteering(0)
end)
