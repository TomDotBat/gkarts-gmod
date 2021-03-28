
local drawHalfParallelogram

do
    local setNoTexture = draw.NoTexture
    local setDrawColor = surface.SetDrawColor
    local drawPoly = surface.DrawPoly

    function drawHalfParallelogram(x, y, w, h, lineOffset, col, invert)
        setNoTexture()
        setDrawColor(col)
        drawPoly({
            [1] = {x = x + w, y = y},
            [2] = {x = x + w - (invert and lineOffset or 0), y = y + h},
            [3] = {x = x, y = y + h},
            [4] = {x = x + (invert and 0 or lineOffset), y = y}
        })
    end
    gKarts.DrawHalfParallelogram = drawHalfParallelogram
end

function gKarts.DrawParallelogram(x, y, w, h, lineOffset, col)
    local halfW = w * .5
    drawHalfParallelogram(x, y, halfW, h, lineOffset, col)
    drawHalfParallelogram(x + halfW, y, halfW, h, lineOffset, col, true)
end
