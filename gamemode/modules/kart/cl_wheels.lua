
local WHEEL_SETTINGS = {
    {
        bone = "wishbone_fl_wheel",
        offsets = {
            Vector(),
            Angle()
        },
        fallback = {
            Vector(-27.672939, 31.062479, 9.551808),
            Angle(0, 180, 180)
        }
    },
    {
        bone = "wishbone_RL_Wheel",
        offsets = {
            Vector(),
            Angle()
        },
        fallback = {
            Vector(-24.104847 -32.875622, 12.152410),
            Angle(0, 180, 0)
        }
    },
    {
        bone = "wishbone_FR_Wheel",
        offsets = {
            Vector(),
            Angle()
        },
        fallback = {
            Vector(27.821394, 30.929714, 9.552115),
            Angle(0, 0, 180)
        }
    },
    {
        bone = "wishbone_RR_Wheel",
        offsets = {
            Vector(),
            Angle()
        },
        fallback = {
            Vector(23.947189, -32.989258, 12.152708),
            Angle(0, 0, 180)
        }
    }
}

do
    local kart = debug.getregistry()["gKart"]

    AccessorFunc(kart, "eWheels", "Wheels")

    function kart:GetWheel(index) return self.eWheels[index] end
    function kart:SetWheel(index, wheel)
        self.eWheels[index] = wheel
        self:UpdateWheelPosition(index)


        wheel:Spawn()

        local phys = wheel:GetPhysicsObject()
        if IsValid(phys) then
            phys:SetMaterial("jeeptire")
        end
        --wheel:SetPredictable(true)
        --wheel:SetParent(self, self:GetWheelBone(index))
        --wheel:PhysicsDestroy()
        --wheel:PhysicsInit(SOLID_VPHYSICS)
    end

    function kart:GetWheelSettings(index)
        if index then
            return WHEEL_SETTINGS[index]
        else
            return WHEEL_SETTINGS
        end
    end

    function kart:GetWheelBone(index)
        return self:GetCachedBoneId(self:GetWheelSettings(index).bone)
    end

    function kart:GetWheelPosition(index)
        local wheelSettings = self:GetWheelSettings(index)

        local boneId = self:GetCachedBoneId(wheelSettings.bone)
        if not boneId then
            local fallback = wheelSettings.fallback
            return fallback[1], fallback[2]
        end

        return self:GetBonePosition(boneId)
        --if not boneMatrix then continue end
        --bonePos, boneAngles = boneMatrix:GetTranslation(), boneMatrix:GetAngles()
    end

    function kart:UpdateWheelPosition(index)
        local pos, angles = self:GetWheelPosition(index)
        local wheel = self.eWheels[index]
        wheel:SetPos(pos)
        wheel:SetAngles(angles)
    end

    function kart:UpdateWheelPositions()
        for i = 1, #self.eWheels do
            self:UpdateWheelPosition(i)
        end
    end
end

hook.Add("gKarts.KartCreated", "gKarts.WheelCreation", function(kart)
    kart:SetWheels({})

    kart:SetPoseParameter("vehicle_wheel_fl_height", .5)
    kart:SetPoseParameter("vehicle_wheel_fr_height", .5)
    kart:SetPoseParameter("vehicle_wheel_rl_height", .5)
    kart:SetPoseParameter("vehicle_wheel_rr_height", .5)

    --for i = 1, #WHEEL_SETTINGS do
    --    kart:SetWheel(i, ents.CreateClientProp("models/props_vehicles/tire001c_car.mdl"))
    --end

    --hook.Add("PreRender", kart, kart.UpdateWheelPositions)
end)


hook.Add("gKarts.KartRemoved", "gKarts.WheelRemoval", function(kart)
    for _, wheel in ipairs(kart:GetWheels()) do
        wheel:Remove()
    end
end)
