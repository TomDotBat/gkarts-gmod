
local kart = debug.getregistry()["gKart"]

function kart:GetDriverModel()
    return self.sDriverModel
end

function kart:SetDriverModel(modelPath)
    if not util.IsValidModel(modelPath) then return end

    self.sDriverModel = modelPath
    self:SetUpDriverRagdoll(modelPath)
end

function kart:SetUpDriverRagdoll(modelPath)
    self:RemoveDriverRagdoll()
    if not modelPath then return end

    local ragdoll = ClientsideRagdoll(modelPath)
    if not IsValid(ragdoll) then return end

    ragdoll:SetPos(self:GetPos())
    --ragdoll:SetParent(self)
    ragdoll:SetNoDraw(false)
    ragdoll:DrawShadow(true)

    self.eDriverRagdoll = ragdoll
    --self.nDriverRagdollSequence = self:FindDriverRagdollSequenceId(ragdoll)
end

do
    local SIT_SEQUENCES = {"sit_chair"}

    function kart:FindDriverRagdollSequenceId(ragdoll)
        for _, seq in ipairs(SIT_SEQUENCES) do
            local id = ragdoll:LookupSequence(seq)
            if id then return id end
        end

        for id, seq in ipairs(ragdoll:GetSequenceList()) do
            if string.find(seq, "sit") then return id end
        end

        return 0
    end
end

function kart:RemoveDriverRagdoll()
    if not IsValid(self.eDriverRagdoll) then return end
    self.eDriverRagdoll:Remove()
end
