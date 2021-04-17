
do
    local kart = debug.getregistry()["gKart"]
    local GRAVITY_VECTOR = physenv.GetGravity()
    local GRAVITY = GRAVITY_VECTOR[3]

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
        return (gravityTrace or self:GetGravityTrace()).Hit
            and (GRAVITY * self:GetUp())
            or GRAVITY_VECTOR
    end

    function kart:GetGroundDistance(gravityTrace)
        return self:GetPos() - (gravityTrace or self:GetGravityTrace()).HitPos
    end

    do
        local frameTime = FrameTime

        function kart:GetGravityForce(physObj, gravityTrace)
            return self:GetGravityVector(gravityTrace or self:GetGravityTrace())
                * (physObj or self:GetPhysicsObject()):GetMass()
                * frameTime()
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
