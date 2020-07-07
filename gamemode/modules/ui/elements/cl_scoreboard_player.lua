
local PANEL = {}

function PANEL:SetPlayer(ply)
    if self.Player then return end

    self.Player = ply
    self.Name = ply:Name()
    self.Position = 1

    self.Avatar = vgui.Create("gKarts.CircleAvatar", self)

    self.NextThink = 0
end

function PANEL:Think()
    if CurTime() < self.NextThink then return end
    self.NextThink = CurTime() + 3

    local newPosition = math.random(1, 8)

    if newPosition == self.Position then return end
    self.Position = newPosition
    self:GetParent():ReorderPlayers()
end

function PANEL:PerformLayout(w, h)
    if not self.Player then return end

    local avatarSize = h * .8
    local avatarPad = h * .1

    self.Avatar:SetPlayer(self.Player, avatarSize)
    self.Avatar:SetMaskSize(avatarSize * .49)
    self.Avatar:SetPos(avatarPad, avatarPad)
    self.Avatar:SetSize(avatarSize, avatarSize)
end

GM:DefineScaledFont("Scoreboard.Name", 26, true)
GM:DefineScaledFont("Scoreboard.Position", 38, true)

function PANEL:Paint(w, h)
    if not self.Player then return end
    if not IsValid(self.Player) then
        self:Remove()
        return
    end

    draw.RoundedBox(GAMEMODE:ScreenScale(8), 0, 0, w, h, GAMEMODE.Colors.PrimaryBackground)

    draw.SimpleText(self.Name, "gKarts.Scoreboard.Name", h, h / 2, GAMEMODE.Colors.PrimaryText, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    draw.SimpleText("#" .. self.Position, "gKarts.Scoreboard.Position", w - GAMEMODE:ScreenScale(10), h / 2, GAMEMODE.Colors.Positions[self.Position] or GAMEMODE.Colors.DefaultPosition, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
end

vgui.Register("gKarts.Scoreboard.Player", PANEL, "Panel")
