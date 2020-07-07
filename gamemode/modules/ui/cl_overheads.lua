
local avatars = {}

local function buildPlayerAvatar(ply)
    local pnl = vgui.Create("gKarts.CircleAvatar")

    local avatarSize = 120
    pnl:SetPlayer(ply, avatarSize)
    pnl:SetMaskSize(avatarSize * .5)
    pnl:SetPos(20, 20)
    pnl:SetSize(avatarSize, avatarSize)
    pnl:SetPaintedManually(true)

    avatars[ply] = pnl
    return pnl
end

local function drawPlayerAvatar(ply)
    local pnl = avatars[ply]
    if not pnl then pnl = buildPlayerAvatar(ply) end
    pnl:PaintManual()
end

hook.Add("PlayerDisconnected", "gKarts.CleanupDisconnectedAvatars", function(ply)
    avatars[ply] = nil
end)

local meta = FindMetaTable("Player")
local localPly

GM:DefineFont("Overhead.Name", 100, true)
GM:DefineFont("Overhead.Position", 180, true)
GM:DefineFont("Overhead.Position.Suffix", 80, true)
GM:DefineFont("Overhead.Lap.Title", 40, true)
GM:DefineFont("Overhead.Lap.Time", 64, true)

function meta:DrawOverhead()
    local pos, ang = self:LocalToWorld(self:OBBCenter()), Angle(0, localPly:EyeAngles().y + 270, 90)

    pos = pos + ang:Right() * -25
    pos = pos + ang:Forward() * 18

    local name = self:Name()

    surface.SetFont("gKarts.Overhead.Name")
    local boxW, boxH = 150 + surface.GetTextSize(name) + 15, 300

    cam.Start3D2D(pos, ang, .15)
        draw.RoundedBox(24, 0, 0, boxW, boxH, GAMEMODE.Colors.PrimaryBackground)

        drawPlayerAvatar(self)
        local nameW = draw.SimpleText(name, "gKarts.Overhead.Name", 150, 83, GAMEMODE.Colors.PrimaryText, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        local position = 3
        local positionCol = GAMEMODE.Colors.Positions[position] or GAMEMODE.Colors.DefaultPosition

        local posW = draw.SimpleText(position, "gKarts.Overhead.Position", 20, boxH + 24, positionCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText(GAMEMODE:GetSuffix(position), "gKarts.Overhead.Position.Suffix", 20 + posW, boxH + 0, positionCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

        local lapTimeX = 150 + nameW / 2

        local timeH = select(2, draw.SimpleText("00:00:00", "gKarts.Overhead.Lap.Time", lapTimeX, boxH - 5, GAMEMODE.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM))
        draw.SimpleText("LAST LAP", "gKarts.Overhead.Lap.Title", lapTimeX, boxH - 5 - timeH, GAMEMODE.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
    cam.End3D2D()
end

function GM:PostPlayerDraw(ply)
    if not localPly then localPly = LocalPlayer() end
    ply:DrawOverhead()
end
