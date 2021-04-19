
do
    local kart = debug.getregistry()["gKart"]
    local GRAVITY_VECTOR = physenv.GetGravity()
    local GRAVITY = GRAVITY_VECTOR[3]

    do
        local traceLine = util.TraceLine
        local GRAVITY_STICK_DISTANCE = gKarts.Constants.KART_GRAVITY_STICK_DISTANCE

        local traceData = {}

        function kart:GetGravityTrace()
            debugoverlay.Sphere(self:GetPos(), 4, 1, HSVToColor((CurTime() * 50) % 360, 1, 1), true)
            traceData["start"] = self:GetPos()
            traceData["endpos"] = self:LocalToWorld(GRAVITY_STICK_DISTANCE)
            return traceLine(traceData)
        end
    end

    function kart:GetGravityVector(gravityTrace)
        return (gravityTrace or self:GetGravityTrace()).Hit
            and (GRAVITY * gravityTrace.HitNormal)
            or GRAVITY_VECTOR
    end

    function kart:GetGroundDistance(gravityTrace)
        if not gravityTrace then gravityTrace = self:GetGravityTrace() end
        if not gravityTrace.Hit then return end
        return self:GetPos()[3] - gravityTrace.HitPos[3]
    end

    do
        local HOVER_HEIGHT = gKarts.Constants.KART_HOVER_HEIGHT

        function kart:GetHoverHeight()
            return HOVER_HEIGHT
        end
    end

    function kart:IsBelowHoverHeight(height, gravityTrace)
        return height < self:GetHoverHeight()
    end

    do
        local frameTime = FrameTime

        function kart:GetGravityForce(physObj, gravityTrace)
            return self:GetGravityVector(gravityTrace or self:GetGravityTrace())
                * (physObj or self:GetPhysicsObject()):GetMass()
                * frameTime()
        end
    end

    function kart:ApplyGravityForce(gravityTrace)
        local physObj = self:GetPhysicsObject()
        physObj:ApplyForceCenter(self:GetGravityForce(physObj, gravityTrace))
    end

    do
        local lerp = Lerp
        local HOVER_FORCE = gKarts.Constants.KART_HOVER_FORCE

        function kart:ApplyHoverForce(gravityTrace)
            local groundDistance = self:GetGroundDistance(gravityTrace)
            if not groundDistance then return end
            if not self:IsBelowHoverHeight(groundDistance, gravityTrace) then return end

            print(1 - (groundDistance / self:GetHoverHeight()), lerp(1 - (groundDistance / self:GetHoverHeight()), 0, HOVER_FORCE) * self:GetUp())
            self:GetPhysicsObject():ApplyForceCenter(lerp(groundDistance / self:GetHoverHeight(), HOVER_FORCE, 0) * self:GetUp())
            return true
        end
    end

    function kart:PhysicsThink()
        local gravityTrace = self:GetGravityTrace()

        --self:ApplyHoverForce(gravityTrace)
        self:ApplyGravityForce(gravityTrace)
    end

    gKarts.AddKartThinkMethod("physics", kart.PhysicsThink)
end

hook.Add("gKarts.KartCreated", "gKarts.PhysicsSetup", function(kart)
    local physObj = kart:GetPhysicsObject()
    physObj:EnableGravity(false)
    physObj:SetMass(gKarts.Constants.KART_MASS)
    --physObj:SetDamping(100, 100)
    kart:SetFriction(.5)
end)
