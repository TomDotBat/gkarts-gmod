
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

    function kart:GetGravityVector(gravityTrace)
        if not gravityTrace then gravityTrace = self:GetGravityTrace() end
        return gravityTrace.Hit and (self:GetUp() * GRAVITY_VECTOR) or GRAVITY_VECTOR
    end

    function kart:GetGroundDistance(gravityTrace)
        if not gravityTrace then gravityTrace = self:GetGravityTrace() end
        return self:GetPos() - gravityTrace.HitPos
    end

    do
        local frameTime = FrameTime

        function kart:GetGravityForce(physObj, gravityTrace)
            if not physObj then physObj = self:GetPhysicsObject() end
            if not gravityTrace then gravityTrace = self:GetGravityTrace() end
            return self:GetGravityVector(gravityTrace) * physObj:GetMass() * frameTime()
        end
    end

    function kart:GravityThink()
        local gravityTrace = self:GetGravityTrace()
        local physObj = self:GetPhysicsObject()
        physObj:ApplyForceCenter(self:GetGravityForce(physObj, gravityTrace))
    end

    gKarts.AddKartThinkMethod("gravity", kart.GravityThink)
end

hook.Add("gKarts.KartCreated", "gKarts.PhysicsSetup", function(kart)
    local physObj = kart:GetPhysicsObject()
    physObj:EnableGravity(false)
end)
