
local newColor = Color

function gKarts.CopyColor(col)
    return newColor(col.r, col.g, col.b, col.a)
end

do
    local clamp = math.Clamp
    function gKarts.OffsetColor(col, amount)
        return newColor(
            clamp(col.r + amount, 0, 255),
            clamp(col.g + amount, 0, 255),
            clamp(col.b + amount, 0, 255)
        )
    end
end

do
    local lerp = Lerp
    function gKarts.LerpColor(t, from, to)
        return newColor(
            lerp(t, from.r, to.r),
            lerp(t, from.g, to.g),
            lerp(t, from.b, to.b),
            lerp(t, from.a, to.a)
        )
    end
end
