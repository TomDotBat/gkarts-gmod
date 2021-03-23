
local drawPlayerAvatar

do
    local avatars = {}
    local AVATAR_SIZE = 120

    local function buildPlayerAvatar(ply)
        local pnl = vgui.Create("gKarts.CircleAvatar")

        pnl:SetPlayer(ply, AVATAR_SIZE)
        pnl:SetMaskSize(AVATAR_SIZE * .5)
        pnl:SetPos(20, 20)
        pnl:SetSize(AVATAR_SIZE, AVATAR_SIZE)
        pnl:SetPaintedManually(true)

        avatars[ply] = pnl
        return pnl
    end

    function drawPlayerAvatar(ply)
        local pnl = avatars[ply]
        if not pnl then pnl = buildPlayerAvatar(ply) end
        pnl:PaintManual()
    end

    hook.Add("PlayerDisconnected", "gKarts.CleanupDisconnectedAvatars", function(ply)
        avatars[ply] = nil
    end)
end

gKarts.RegisterFontUnscaled("Overhead.Name", 100, true)
gKarts.RegisterFontUnscaled("Overhead.Position", 180, true)
gKarts.RegisterFontUnscaled("Overhead.Position.Suffix", 80, true)
gKarts.RegisterFontUnscaled("Overhead.Lap.Title", 40, true)
gKarts.RegisterFontUnscaled("Overhead.Lap.Time", 64, true)


local meta = FindMetaTable("Player")

local localPly

local textCol = gKarts.Colors.PrimaryText
local positionCols = gKarts.Colors.Positions
local defaultPositionCol = gKarts.Colors.DefaultPosition
local backgroundCol = gKarts.Colors.Background

local callHook = hook.Call
local newAngle = Angle
local getTextSize = gKarts.GetTextSize
local start3d2d = cam.Start3D2D
local end3d2d = cam.End3D2D
local getSuffix = gKarts.GetSuffix
local drawRoundedBox = gKarts.DrawRoundedBox
local drawSimpleText = gKarts.DrawSimpleText

local textAlignCenter = TEXT_ALIGN_CENTER
local textAlignBottom = TEXT_ALIGN_BOTTOM

function meta:DrawOverhead(eyeAngle)
    if callHook("gKarts.ShouldDraw", nil, "Overhead", self) ~= nil then return end

    local pos, ang = self:LocalToWorld(self:OBBCenter()), newAngle(0, eyeAngle + 270, 90)
    pos = pos + ang:Right() * -25
    pos = pos + ang:Forward() * 18

    local name = self:Name()
    local boxW, boxH = 150 + getTextSize(name, "Overhead.Name") + 15, 300

    start3d2d(pos, ang, .15)
        drawRoundedBox(24, 0, 0, boxW, boxH, backgroundCol)

        drawPlayerAvatar(self)
        local nameW = drawSimpleText(name, "Overhead.Name", 150, 83, textCol, nil, textAlignCenter)

        local position = 3
        local positionCol = positionCols[position] or defaultPositionCol

        local posW = drawSimpleText(position, "Overhead.Position", 20, boxH + 24, positionCol, nil, textAlignBottom)
        drawSimpleText(getSuffix(position), "Overhead.Position.Suffix", 20 + posW, boxH + 0, positionCol, nil, textAlignBottom)

        local lapTimeX = 150 + nameW * .5

        local _, timeH = drawSimpleText("00:00:00", "Overhead.Lap.Time", lapTimeX, boxH - 5, textCol, textAlignCenter, textAlignBottom)
        drawSimpleText("LAST LAP", "Overhead.Lap.Title", lapTimeX, boxH - 5 - timeH, textCol, textAlignCenter, textAlignBottom)
    end3d2d()
end

hook.Add("Think", "gKarts.CacheLocalPlayer", function()
    localPly = LocalPlayer()
    if IsValid(localPly) then
        hook.Remove("Think", "gKarts.CacheLocalPlayer")

        local eyeAngle = 0
        hook.Add("PreRender", "gKarts.GetLocalPlayerEyeAngle", function()
            eyeAngle = localPly:EyeAngles()[2]
        end)

        function GAMEMODE:PostPlayerDraw(ply)
            if ply == localPly then return end
            ply:DrawOverhead(eyeAngle)
        end
    end
end)

function GM:PostPlayerDraw() end
