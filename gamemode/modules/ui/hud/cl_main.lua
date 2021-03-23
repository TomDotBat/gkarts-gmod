
gKarts.RegisterScaledConstant("Padding", 30)

do
    local scrW, scrH = ScrW(), ScrH()
    hook.Add("OnScreenSizeChanged", "gKarts.HUD.CacheScreenResolution", function()
        scrW, scrH = ScrW(), ScrH()
    end)

    local localPly = LocalPlayer()
    hook.Add("Think", "gKarts.HUD.CacheLocalPlayer", function()
        localPly = LocalPlayer()
        if IsValid(localPly) then
            hook.Remove("Think", "gKarts.HUD.CacheLocalPlayer")

            local callHook = hook.Call
            function GAMEMODE:HUDPaint()
                callHook("gKarts.DrawHUD", self, scrW, scrH, localPly)
            end
        end
    end)

    function GM:HUDPaint() end
end

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
