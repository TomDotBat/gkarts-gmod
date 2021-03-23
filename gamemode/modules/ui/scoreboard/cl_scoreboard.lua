
local PANEL = {}

function PANEL:Init()
    self:Place()

    self:ShowHint()
    self.pPlayers = {}

    for _, ply in ipairs(player.GetAll()) do
        self:AddPlayer(ply)
    end
end

function PANEL:ShowHint()
    self.nTimeCreated = CurTime()
end

function PANEL:AddPlayer(ply)
    local pnl = vgui.Create("gKarts.Scoreboard.Player", self)
    pnl:SetPlayer(ply)
    pnl:SetPos(0, self:GetPlayerY(1))

    pnl.OnRemove = function(s)
        self.pPlayers[ply] = nil
    end

    self.pPlayers[ply] = pnl
end

function PANEL:ReorderPlayers()
    for _, ply in pairs(self.pPlayers) do
        local pos = ply:GetPosition()
        ply:MoveTo(0, self:GetPlayerY(pos), .8)
        ply:SetZPos(-pos)
    end
end

gKarts.RegisterScaledConstant("Scoreboard.PlayerSpacing", 10)
gKarts.RegisterScaledConstant("Scoreboard.PlayerHeight", 50)

do
    local getScaledConstant = gKarts.GetScaledConstant

    function PANEL:GetPlayerY(position)
        return gKarts.GetScaledConstant("Padding") + (position - 1) * (getScaledConstant("Scoreboard.PlayerSpacing") + getScaledConstant("Scoreboard.PlayerHeight"))
    end

    function PANEL:PerformLayout(w, h)
        local playerH = getScaledConstant("Scoreboard.PlayerHeight")
        for _, ply in pairs(self.pPlayers) do
            ply:SetSize(w, playerH)
        end
    end
end

gKarts.RegisterScaledConstant("Scoreboard.Width", 280)
gKarts.RegisterScaledConstant("Scoreboard.BottomPadding", 180)

function PANEL:Place()
    self:SetPos(gKarts.GetScaledConstant("Padding"), 0)
    self:SetSize(gKarts.GetScaledConstant("Scoreboard.Width"), ScrH() - gKarts.GetScaledConstant("Scoreboard.BottomPadding"))
end

PANEL.OnScreenSizeChanged = PANEL.Place

gKarts.RegisterFont("Scoreboard.Hint", 24)

do
    local hintTextCol = gKarts.Colors.PrimaryText
    local hintShadowTextCol = color_black

    local getAlphaMultiplier = surface.GetAlphaMultiplier
    local setAlphaMultiplier = surface.SetAlphaMultiplier
    local drawSimpleTextOutlined = gKarts.SimpleTextOutlined
    local min = math.min
    local curTime = CurTime

    local textAlignCenter = TEXT_ALIGN_CENTER

    function PANEL:Paint(w, h)
        if curTime() > self.nTimeCreated + 3 then
            self.Paint = nil
            return
        end

        local startAlpha = getAlphaMultiplier()
        setAlphaMultiplier(min(startAlpha, 1 - (curTime() - self.nTimeCreated - 2) / 1))

        drawSimpleTextOutlined("Press TAB to toggle player list", "Scoreboard.Hint", w * .5, gKarts.GetScaledConstant("Padding") * .52, hintTextCol, textAlignCenter, textAlignCenter, 1, hintShadowTextCol)

        setAlphaMultiplier(startAlpha)
    end
end

vgui.Register("gKarts.Scoreboard", PANEL, "EditablePanel")
