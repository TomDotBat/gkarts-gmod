
function GM:ScreenScale(size)
    return (ScrH() / 1080) * size
end

function GM:DefineFont(name, size, bold, weight)
    surface.CreateFont("gKarts." .. name, {
        font = bold and "Bebas Neue" or "Bebas Neue Bold",
        size = size,
        weight = weight,
        antialias = true
    })
end

function GM:DefineScaledFont(name, size, bold, weight)
    self:DefineFont(name, self:ScreenScale(size), bold, weight)
end