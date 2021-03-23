
do
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
        return not hideElements[name]
    end
end

function GM:DrawDeathNotice() end

function GM:HUDDrawTargetID()
    return false
end
