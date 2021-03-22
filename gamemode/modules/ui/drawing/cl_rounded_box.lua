
do
    local cornerTex8 = surface.GetTextureID("gui/corner8")
    local cornerTex16 = surface.GetTextureID("gui/corner16")
    local cornerTex32 = surface.GetTextureID("gui/corner32")
    local cornerTex64 = surface.GetTextureID("gui/corner64")
    local cornerTex512 = surface.GetTextureID("gui/corner512")

    local round = math.Round
    local min = math.min
    local floor = math.floor

    local setDrawColor = surface.SetDrawColor
    local drawRect = surface.DrawRect
    local drawTexturedRectUV = surface.DrawTexturedRectUV
    local setTexture = surface.SetTexture

    local function drawRoundedBoxEx(borderSize, x, y, w, h, col, topLeft, topRight, bottomLeft, bottomRight)
        setDrawColor(col.r, col.g, col.b, col.a)

        if borderSize <= 0 then
            drawRect(x, y, w, h)
            return
        end

        x = round(x)
        y = round(y)
        w = round(w)
        h = round(h)
        borderSize = min(round(borderSize), floor(w / 2))

        drawRect(x + borderSize, y, w - borderSize * 2, h)
        drawRect(x, y + borderSize, borderSize, h - borderSize * 2)
        drawRect(x + w - borderSize, y + borderSize, borderSize, h - borderSize * 2)

        local tex = cornerTex8
        if borderSize > 8 then tex = cornerTex16 end
        if borderSize > 16 then tex = cornerTex32 end
        if borderSize > 32 then tex = cornerTex64 end
        if borderSize > 64 then tex = cornerTex512 end

        setTexture(tex)

        if topLeft then drawTexturedRectUV(x, y, borderSize, borderSize, 0, 0, 1, 1)
        else drawRect(x, y, borderSize, borderSize) end

        if topRight then drawTexturedRectUV(x + w - borderSize, y, borderSize, borderSize, 1, 0, 0, 1)
        else drawRect(x + w - borderSize, y, borderSize, borderSize) end

        if bottomLeft then drawTexturedRectUV(x, y + h -borderSize, borderSize, borderSize, 0, 1, 1, 0)
        else drawRect(x, y + h - borderSize, borderSize, borderSize) end

        if bottomRight then drawTexturedRectUV(x + w - borderSize, y + h - borderSize, borderSize, borderSize, 1, 1, 0, 0)
        else drawRect(x + w - borderSize, y + h - borderSize, borderSize, borderSize) end
    end
    RPGM.DrawRoundedBoxEx = drawRoundedBoxEx
end

function RPGM.DrawRoundedBox(borderSize, x, y, w, h, col)
	return drawRoundedBoxEx(borderSize, x, y, w, h, col, true, true, true, true)
end
