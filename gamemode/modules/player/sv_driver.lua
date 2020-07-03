local _P = FindMetaTable("Player")

function _P:SetScore(sco)
    self:SetNWInt("score", sco)
end

function _P:SetCar(car)
    self:SetNWInt("car", car)
end
