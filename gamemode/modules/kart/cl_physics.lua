
do
    local kart = debug.getregistry()["gKart"]
    local GRAVITY_VECTOR = physenv.GetGravity()

    do
        local traceLine = util.TraceLine
        local GRAVITY_STICK_DISTANCE = gKarts.Constants.KART_GRAVITY_STICK_DISTANCE

        local traceData = {}

        function kart:GetGravityTrace()
            traceData["start"] = self:GetPos()
            traceData["endpos"] = self:LocalToWorld(GRAVITY_STICK_DISTANCE)
            return traceLine(traceData)
        end
    end

    function kart:GetGravityVector()
        return self:GetGravityTrace().Hit and (self:GetUp() * GRAVITY_VECTOR) or GRAVITY_VECTOR
    end

    do
        local frameTime = FrameTime

        function kart:GravityThink()
            local physObj = self:GetPhysicsObject()
            physObj:ApplyForceCenter(self:GetGravityVector() * physObj:GetMass() * frameTime())
        end
    end

    gKarts.AddKartThinkMethod("gravity", kart.GravityThink)
end

hook.Add("gKarts.KartCreated", "gKarts.PhysicsSetup", function(kart, _, isLocal)
    local physObj = kart:GetPhysicsObject()
    physObj:EnableGravity(false)
end)
