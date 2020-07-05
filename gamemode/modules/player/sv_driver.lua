local _P = FindMetaTable("Player")

function _P:SetScore(sco)
    self:SetNWInt("score", sco)
end

function _P:SetRank(rank)
    self:SetNWInt("rank", rank)
end
