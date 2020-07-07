
local suffixes = {
    "ST",
    "ND",
    "RD",
    "TH"
}

function GM:GetSuffix(num)
    return num > 4 and suffixes[4] or suffixes[num]
end

file.CreateDir("gkarts")
function GM:GetImgur(imgurID, callback)
    if file.Exists("gkarts/" .. imgurID .. ".png", "DATA") then
        callback(Material("../data/gkarts/" .. imgurID .. ".png", "noclamp smooth"))
        return
    end

    http.Fetch("https://i.imgur.com/" .. imgurID .. ".png", function(body)
        file.Write("gkarts/" .. imgurID .. ".png", body)
        callback(Material("../data/gkarts/" .. imgurID .. ".png", "noclamp smooth"))
    end, function(err)
        callback(Material("nil"))
    end)
end

function GM:StartCutOut(drawMask)
    render.ClearStencil()
    render.SetStencilEnable(true)
    render.SetStencilCompareFunction(STENCIL_ALWAYS)
    render.SetStencilPassOperation(STENCIL_REPLACE)
    render.SetStencilFailOperation(STENCIL_KEEP)
    render.SetStencilZFailOperation(STENCIL_KEEP)
    render.SetStencilWriteMask(1)
    render.SetStencilTestMask(1)
    render.SetStencilReferenceValue(1)
    render.OverrideColorWriteEnable(true, false)

    drawMask()

    render.OverrideColorWriteEnable(false, false)
    render.SetStencilCompareFunction(STENCIL_EQUAL)
end

function GM:FinishCutOut()
    render.SetStencilEnable(false)
end

function GM:ScreenScale(size)
    return (ScrH() / 1080) * size
end

GM.Padding = GM:ScreenScale(30)

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
