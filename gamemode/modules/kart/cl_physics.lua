
hook.Add("gKarts.KartCreated", "gKarts.PhysicsSetup", function(kart, _, isLocal)
    local physObj = kart:GetPhysicsObject()
    physObj:EnableGravity(false)
end)
