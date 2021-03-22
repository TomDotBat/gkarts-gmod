
do
    local scrh = ScrH
    local max = math.max
    function gKarts.Scale(value)
        return max(value * (scrh() / 1080), 1)
    end
end

do
    local constants = {}
    local scaledConstants = {}
    function gKarts.RegisterScaledConstant(varName, size)
        constants[varName] = size
        scaledConstants[varName] = gKarts.Scale(size)
    end

    function gKarts.GetScaledConstant(varName)
        return scaledConstants[varName]
    end

    hook.Add("OnScreenSizeChanged", "gKarts.StoreScaledConstants", function()
        for varName, size in pairs(constants) do
            scaledConstants[varName] = gKarts.Scale(size)
        end
    end)
end
