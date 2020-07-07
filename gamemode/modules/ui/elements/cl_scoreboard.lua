
local PANEL = {}

function PANEL:Init()
    self:SetPos(GAMEMODE.Padding, 0)
    self:SetSize(GAMEMODE:ScreenScale(280), ScrH() - GAMEMODE:ScreenScale(180))

    self:DockPadding(0, GAMEMODE.Padding, 0, 0)

    self.CreateTime = CurTime()
    self.Players = {}

    for k,v in ipairs(player.GetAll()) do
        self:AddPlayer(v)
    end
end

function PANEL:Think()
    self:UpdatePlayers()
end

function PANEL:AddPlayer(ply)
    local pnl = vgui.Create("gKarts.Scoreboard.Player", self)
    pnl:SetPlayer(ply)
    pnl:Dock(TOP)
    pnl:DockMargin(0, 0, 0, GAMEMODE:ScreenScale(10))
    pnl:SetTall(GAMEMODE:ScreenScale(50))

    self.Players[#self.Players + 1] = pnl
end

function PANEL:UpdatePlayers()
    --for k,v in ipairs(self.Players) do
    --end
end

GAMEMODE:DefineFont("Scoreboard.Hint", 24)

function PANEL:Paint(w, h)
    if CurTime() > self.CreateTime + 3 then return end

    local startAlpha = surface.GetAlphaMultiplier()
    surface.SetAlphaMultiplier(math.min(startAlpha, 1 - (CurTime() - self.CreateTime - 2) / 1))

    draw.SimpleTextOutlined("Press TAB to toggle player list", "gKarts.Scoreboard.Hint", w / 2, GAMEMODE.Padding * .52, GAMEMODE.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)

    surface.SetAlphaMultiplier(startAlpha)
end

vgui.Register("gKarts.Scoreboard", PANEL, "EditablePanel")

if IsValid(GAMEMODE.Scoreboard) then
    GAMEMODE.Scoreboard:Remove()
end
