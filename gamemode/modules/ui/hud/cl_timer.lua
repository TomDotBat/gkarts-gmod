
gKarts.RegisterFont("Timer.Primary", 54, true)
gKarts.RegisterFont("Timer.Secondary", 32, true)

gKarts.RegisterScaledConstant("HUD.Timer.Width", 225)
gKarts.RegisterScaledConstant("HUD.Timer.Height", 145)
gKarts.RegisterScaledConstant("HUD.Timer.Rounding", 20)
gKarts.RegisterScaledConstant("HUD.Timer.LogoSize", 165)

local textCol = gKarts.Colors.PrimaryText
local backgroundCol = gKarts.Colors.Background
local logoCol = color_white

local callHook = hook.Call
local getScaledConstant = gKarts.GetScaledConstant
local drawImgur = gKarts.DrawImgur
local getTextSize = gKarts.GetTextSize
local drawSimpleText = gKarts.DrawSimpleText
local drawRoundedBoxEx = gKarts.DrawRoundedBoxEx

local textAlignRight = TEXT_ALIGN_RIGHT

hook.Add("gKarts.DrawHUD", "gKarts.DrawTimer", function(scrW, scrH, localPly)
    if callHook("gKarts.ShouldDraw", nil, "Timer", localPly) ~= nil then return end

    local rounding = getScaledConstant("HUD.Timer.Rounding")
    local width = getScaledConstant("HUD.Timer.Width")
    local height = getScaledConstant("HUD.Timer.Height")
    local screenPadding = getScaledConstant("Padding")

    local x, y = scrW - screenPadding - width, screenPadding
    local halfHeight = height * .5

    drawRoundedBoxEx(rounding, x, y, width, height, backgroundCol, false, true, false, true)

    local logoSize = getScaledConstant("HUD.Timer.LogoSize")
    local halfLogoSize = logoSize * .5

    drawImgur(x - halfLogoSize, y + halfHeight - halfLogoSize, logoSize, logoSize, "TUpLWE3", logoCol)

    local timeSpent = "01:58:36"
    local lapTime = "03:02:21"
    local bestTime = "00:00:00"

    local _, spentHeight = getTextSize(timeSpent, "Timer.Primary")
    local _, lapHeight = getTextSize(lapTime, "Timer.Secondary")
    local _, bestHeight = getTextSize(bestTime, "Timer.Secondary")

    local textX = x + width - rounding
    local textY = y + halfHeight - (spentHeight + lapHeight + bestHeight) * .5

    drawSimpleText(timeSpent, "Timer.Primary", textX, textY, textCol, textAlignRight)
    drawSimpleText("LAP: " .. lapTime, "Timer.Secondary", textX, textY + spentHeight, textCol, textAlignRight)
    drawSimpleText("BEST: " .. bestTime, "Timer.Secondary", textX, textY + spentHeight + lapHeight, textCol, textAlignRight)
end)
