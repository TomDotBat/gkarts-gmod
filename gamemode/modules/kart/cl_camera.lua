
local thirdPersonMode = CreateClientConVar("gkarts_thirdperson_enable", "0", true, false, "Should we use 3rd person camera mode?", 0, 1):GetBool()

cvars.AddChangeCallback("gkarts_thirdperson_enable", function(_, oldVal, newVal)
    if oldVal == newVal then return end

    thirdPersonMode = tobool(newVal)

    if thirdPersonMode then
        gKarts.SetThirdPersonZoomListener()
    else
        gKarts.UnsetThirdPersonZoomListener()
    end

    hook.Run("gKarts.ThirdPersonToggled", newVal)
end)

do
    function gKarts.EnableThirdPerson()
        GetConVar("gkarts_thirdperson_enable"):SetBool(true)
    end

    function gKarts.DisableThirdPerson()
        GetConVar("gkarts_thirdperson_enable"):SetBool(false)
    end

    function gKarts.ToggleThirdPerson()
        local cVar = GetConVar("gkarts_thirdperson_enable")
        cVar:SetBool(not cVar:GetBool())
    end

    local zoomCvar = CreateClientConVar("gkarts_thirdperson_zoom", "1", true, false, "How far should the zoom be in 3rd person mode?", -1)
    local clamp = math.Clamp

    function gKarts.SetThirdPersonZoomListener()
        hook.Add("Move", "gKarts.ThirdPersonZoomListener", function(ply, mv)
            local scrollAmount = ply:GetCurrentCommand():GetMouseWheel()
            if scrollAmount == 0 then return end

            local zoom = zoomCvar:GetInt()
            zoomCvar:SetInt(clamp(zoom - scrollAmount * 0.03 * (1.1 + zoom), -1, 10))
        end)
    end
    gKarts.SetThirdPersonZoomListener()
    function gKarts.UnsetThirdPersonZoomListener()
        hook.Remove("Move", "gKarts.ThirdPersonZoomListener")
    end
end

local handleCamera

do
    local kart

    function gKarts.AttachCamera(newKart)
        kart = newKart
        hook.Add("CalcView", newKart, handleCamera)
    end

    function gKarts.DetachCamera()
        hook.Remove("CalcView", kart)
    end
end

do
    local getThirdPersonCameraPosition

    do
        local orbitRadius

        local function getOrbitRadius(kart)
            local renderMins, renderMaxs = kart:GetRenderBounds()
            orbitRadius = (renderMins - renderMaxs):Length()
            return orbitRadius
        end

        local WALL_OFFSET = 4

        local traceResult = {}
        local traceData = {
            mins = Vector(-WALL_OFFSET, -WALL_OFFSET, -WALL_OFFSET),
            maxs = Vector(WALL_OFFSET, WALL_OFFSET, WALL_OFFSET),
            filter = function(ent) --https://github.com/Facepunch/garrysmod/blob/3baf462af85c7a5589bcadd8ab61cd288640c807/garrysmod/gamemodes/base/gamemode/cl_init.lua#L321-L323
                local c = ent:GetClass()
                return not (ent:IsVehicle() or c:StartWith("prop_physics") or c:StartWith("prop_dynamic") or c:StartWith("phys_bone_follower") or c:StartWith("prop_ragdoll") or c:StartWith("gmod_"))
            end,
            output = traceResult
        }

        local traceHull = util.TraceHull
        local zoom = GetConVar("gkarts_thirdperson_zoom"):GetInt() or 0

        cvars.AddChangeCallback("gkarts_thirdperson_zoom", function(_, _, val)
            zoom = val
        end)

        function getThirdPersonCameraPosition(kart, orbitPosition, viewAngles)
            traceData["start"] = orbitPosition
            traceData["endpos"] = orbitPosition + (viewAngles:Forward() * -(orbitRadius or getOrbitRadius(kart))) * zoom
            traceHull(traceData)

            if traceResult.Hit and not traceResult.StartSolid then
                return traceResult.HitPos + traceResult.HitNormal * WALL_OFFSET
            end

            return traceResult.HitPos
        end
    end

    local camData = {
        drawviewer = false
    }

    local function getFirstPersonCameraPosition(kart)
        return kart:GetPos() + (kart:GetUp() * 35) + (kart:GetRight() * 12)
    end

    function handleCamera(kart, ply, pos, ang, fov, zNear, zFar)
        camData["origin"] = thirdPersonMode and getThirdPersonCameraPosition(kart, getFirstPersonCameraPosition(kart), ang) or getFirstPersonCameraPosition(kart)

        camData["angles"] = ang
        camData["fov"] = fov

        return camData
    end
end
