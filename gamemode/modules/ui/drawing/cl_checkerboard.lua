

local checkerMat = Material("nil")
gKarts.GetImgur("aJaIkkS", function(mat)
    checkerMat = mat
end, "noclamp")

function gKarts.DrawCheckerboard(x, y, w, h, scroll, tileSize)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(checkerMat)
    surface.DrawTexturedRectUV(x, y, w, h, scroll, scroll, scroll + tileSize, scroll + tileSize)
end
