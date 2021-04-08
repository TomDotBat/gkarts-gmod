

gKarts.RegisterFont("Position.Number", 140, true)
gKarts.RegisterFont("Position.Suffix", 50, true)
gKarts.RegisterFont("Position.Lap", 54, true)

gKarts.RegisterScaledConstant("HUD.Position.Width", 280)
gKarts.RegisterScaledConstant("HUD.Position.Height", 130)
gKarts.RegisterScaledConstant("HUD.Position.Rounding", 20)

local lapCol = gKarts.Colors.PrimaryText
local positionCols = gKarts.Colors.Positions
local defaultPositionCol = gKarts.Colors.DefaultPosition
local backgroundCol = gKarts.Colors.Background

local callHook = hook.Call
local getScaledConstant = gKarts.GetScaledConstant
local getSuffix = gKarts.GetSuffix
local drawSimpleText = gKarts.DrawSimpleText
local drawRoundedBox = gKarts.DrawRoundedBox

local textAlignRight = TEXT_ALIGN_RIGHT
local textAlignCenter = TEXT_ALIGN_CENTER
local textAlignBottom = TEXT_ALIGN_BOTTOM

hook.Add("gKarts.DrawHUD", "gKarts.HUD.DrawPosition", function(scrW, scrH, localPly)
    if true then return end
    if callHook("gKarts.ShouldDraw", nil, "Position", localPly) ~= nil then return end

    local rounding = getScaledConstant("HUD.Position.Rounding")
    local width = getScaledConstant("HUD.Position.Width")
    local height = getScaledConstant("HUD.Position.Height")
    local screenPadding = getScaledConstant("Padding")

    local x, y = screenPadding, scrH - screenPadding - height

    drawRoundedBox(rounding, x, y, width, height, backgroundCol)

    do
        local position = 3
        local positionCol = positionCols[position] or defaultPositionCol

        local numX = x + rounding
        local centerY = height * .54

        local numW, numH = drawSimpleText(position, "Position.Number", numX, y + centerY, positionCol, nil, textAlignCenter)
        drawSimpleText(getSuffix(position), "Position.Suffix", numX + numW, y + centerY + numH * .348, positionCol, nil, textAlignBottom)
    end

    drawSimpleText("LAP 1/3", "Position.Lap", x + width - rounding, y + height * .5, lapCol, textAlignRight, textAlignCenter)
end)
