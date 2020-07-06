
local colors = GM.Colors

GM:DefineFont("Position.No", 140, true)
GM:DefineFont("Position.Suffix", 50, true)
GM:DefineFont("Position.Lap", 54, true)

function GM:DrawPosition(x, y, w, h)
    draw.RoundedBox(self:ScreenScale(20), x, y, w, h, colors.PrimaryBackground)

    local px = x + self:ScreenScale(20)

    local pw, ph = draw.SimpleText("7", "gKarts.Position.No", px, y + h * .54, colors.PrimaryText, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    draw.SimpleText("TH", "gKarts.Position.Suffix", px + pw, y + h * .54 + ph * .348, colors.PrimaryText, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

    draw.SimpleText("LAP 1/3", "gKarts.Position.Lap", x + w - self:ScreenScale(20), y + h / 2, colors.PrimaryText, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
end

local logoMat = Material("")
GM:GetImgur("TUpLWE3", function(mat)
    logoMat = mat
end)

GM:DefineFont("Timer.Primary", 54, true)
GM:DefineFont("Timer.Secondary", 32, true)

function GM:DrawTimer(x, y, w, h)
    draw.RoundedBoxEx(self:ScreenScale(20), x, y, w, h, colors.PrimaryBackground, false, true, false, true)

    local logoSize = self:ScreenScale(165)
    local halfLSize = logoSize / 2

    surface.SetMaterial(logoMat)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(x - halfLSize, y + h / 2 - halfLSize, logoSize, logoSize)

    local timeSpent = "01:58:36"
    local lapTime = "03:02:21"
    local bestTime = "00:00:00"

    surface.SetFont("gKarts.Timer.Primary")
    local th = select(2, surface.GetTextSize(timeSpent))

    surface.SetFont("gKarts.Timer.Secondary")
    local lh = select(2, surface.GetTextSize(lapTime))
    local bh = select(2, surface.GetTextSize(bestTime))

    local textX = x + w - self:ScreenScale(20)
    local textY = y + h / 2 - (th + lh + bh) / 2

    draw.SimpleText(timeSpent, "gKarts.Timer.Primary", textX, textY, colors.PrimaryText, TEXT_ALIGN_RIGHT)
    draw.SimpleText("LAP: " ..lapTime, "gKarts.Timer.Secondary", textX, textY + th, colors.PrimaryText, TEXT_ALIGN_RIGHT)
    draw.SimpleText("BEST: " ..bestTime, "gKarts.Timer.Secondary", textX, textY + th + lh, colors.PrimaryText, TEXT_ALIGN_RIGHT)
end

function GM:HUDPaint()
    local scrw, scrh = ScrW(), ScrH()

    local positionH = self:ScreenScale(130)
    self:DrawPosition(self.Padding, scrh - self.Padding - positionH, self:ScreenScale(280), positionH)

    local timerW = self:ScreenScale(225)
    self:DrawTimer(scrw - self.Padding - timerW, self.Padding, timerW,  self:ScreenScale(145))
end

local hideElements = {
    ["CHudDeathNotice"] = true,
    ["CHudBattery"] = true,
    ["CHudAmmo"] = true,
    ["CHudCrosshair"] = true,
    ["CHudCloseCaption"] = true,
    ["CHudDamageIndicator"] = true,
    ["CHudGeiger"] = true,
    ["CHudHealth"] = true,
    ["CHudPoisonDamageIndicator"] = true,
    ["CHudSecondaryAmmo"] = true,
    ["CHudSquadStatus"] = true,
    ["CHudTrain"] = true,
    ["CHudVehicle"] = true,
    ["CHudWeapon"] = true,
    ["CHudWeaponSelection"] = true,
    ["CHudZoom"] = true,
    ["CHUDQuickInfo"] = true,
    ["CHudSuitPower"] = true
}

function GM:HUDShouldDraw(name)
    if hideElements[name] then return false end
    return true
end

function GM:DrawDeathNotice() end

function GM:HUDDrawTargetID()
    return false
end
