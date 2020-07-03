
print("ASFDASD GAY")

local colors = GM.Colors

function GM:DrawPosition()
    draw.RoundedBox(20, 0, 0, self:ScreenScale(100), self:ScreenScale(100), colors.PrimaryBackground)
end

function GM:HUDPaint()
    print("asdasd")

    surface.SetDrawColor(255, 255, 255)
    surface.DrawRect(0, 0, 100, 100)

    self:DrawPosition()

    draw.RoundedBox(20, 0, 0, 1000, 1000, colors.PrimaryBackground)
end

local hideElements = {
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
    ["CHudSuitPower	"] = true
}

function GM:HUDShouldDraw(name)
    --if hideElements[name] then return false end
end

function GM:HUDDrawTargetID()
    return false
end