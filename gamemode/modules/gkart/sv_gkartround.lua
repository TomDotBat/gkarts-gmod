--[[
    Starts a new round, lays out spawn positions etc.    
]]
function GM:StartNewRound()
    hook.Run("GKart.PreStartNewRound") -- Called when we start a new round.

    self:IncrementRound()

    hook.Run("GKart.PostStartNewRound") -- Called after starting a new round.
end

--[[
    Called to stop the current round and put everyone into "spectate mode"
]]
function GM:StopRound()
end