
local PANEL = {}

AccessorFunc(PANEL, "pPlayer", "Player", FORCE_NUMBER)
AccessorFunc(PANEL, "nPosition", "Position", FORCE_NUMBER)

function PANEL:SetPosition(pos)
    self.nPosition = pos
    self.sPosition = "#" .. self.nPosition
end

function PANEL:SetPlayer(ply)
    if self.pPlayer then return end

    self.pPlayer = ply
    self.sName = ply:Name()
    self:SetPosition(1)

    self.Avatar = vgui.Create("gKarts.CircleAvatar", self)

    self.nNextThink = 0

    gameevent.Listen("player_disconnect")
    hook.Add("player_disconnect", self, self.OnPlayerDisconnect)
end

function PANEL:OnPlayerDisconnect(data)
    if not IsValid(self.pPlayer) then return end
    if data.networkid ~= self.pPlayer:SteamID() then return end
    self:Remove()
end

do
    local curTime = CurTime

    function PANEL:Think()
        local time = curTime()
        if time < self.nNextThink then return end

        self.nNextThink = time + 3

        local newPos = math.random(1, 8)
        if newPos == self.nPosition then return end

        self:SetPosition(newPos)
        self:GetParent():ReorderPlayers()
    end
end

function PANEL:PerformLayout(w, h)
    if not self.pPlayer then return end

    local avatarSize = h * .8
    local avatarPad = h * .1

    self.Avatar:SetPlayer(self.pPlayer, avatarSize)
    self.Avatar:SetMaskSize(avatarSize * .49)
    self.Avatar:SetPos(avatarPad, avatarPad)
    self.Avatar:SetSize(avatarSize, avatarSize)
end

gKarts.RegisterFont("Scoreboard.Name", 26, true)
gKarts.RegisterFont("Scoreboard.Position", 38, true)

gKarts.RegisterScaledConstant("Scoreboard.Rounding", 8)
gKarts.RegisterScaledConstant("Scoreboard.PositionPadding", 10)

do
    local nameCol = gKarts.Colors.PrimaryText
    local positionCols = gKarts.Colors.Positions
    local defaultPositionCol = gKarts.Colors.DefaultPosition
    local backgroundCol = gKarts.Colors.Background

    local isValid = IsValid
    local getScaledConstant = gKarts.GetScaledConstant

    local textAlignLeft = TEXT_ALIGN_LEFT
    local textAlignCenter = TEXT_ALIGN_CENTER
    local textAlignRight = TEXT_ALIGN_RIGHT

    function PANEL:Paint(w, h)
        if not self.pPlayer then return end
        if not isValid(self.pPlayer) then
            self:Remove()
            return
        end

        gKarts.DrawRoundedBox(getScaledConstant("Scoreboard.Rounding"), 0, 0, w, h, backgroundCol)

        gKarts.DrawSimpleText(self.sName, "Scoreboard.Name", h, h * .5, nameCol, textAlignLeft, textAlignCenter)
        gKarts.DrawSimpleText(self.sPosition, "Scoreboard.Position", w - getScaledConstant("Scoreboard.PositionPadding"), h * .5, positionCols[self.nPosition] or defaultPositionCol, textAlignRight, textAlignCenter)
    end
end

vgui.Register("gKarts.Scoreboard.Player", PANEL, "Panel")
