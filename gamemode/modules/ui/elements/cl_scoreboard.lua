
local PANEL = {}

function PANEL:Init()
    self:SetPos(GAMEMODE.Padding, 0)
    self:SetSize(GAMEMODE:ScreenScale(280), ScrH() - GAMEMODE:ScreenScale(180))

    self.CreateTime = CurTime()
    self.Players = {}

    for k,v in ipairs(player.GetAll()) do
        self:AddPlayer(v)
    end
end

function PANEL:GetPlayerY(position)
    return GAMEMODE.Padding + (position - 1) * GAMEMODE:ScreenScale(60)
end

function PANEL:AddPlayer(ply)
    local pnl = vgui.Create("gKarts.Scoreboard.Player", self)
    pnl:SetPlayer(ply)
    pnl:SetPos(0, self:GetPlayerY(1))

    pnl.OnRemove = function(s)
        table.RemoveByValue(self.Players, s)
    end

    self.Players[#self.Players + 1] = pnl
end

function PANEL:ReorderPlayers()
    for k,v in ipairs(self.Players) do
        v:MoveTo(0, self:GetPlayerY(v.Position), .8)
        v:SetZPos(-v.Position)
    end
end

function PANEL:PerformLayout(w, h)
    local playerH = GAMEMODE:ScreenScale(50)
    for k,v in ipairs(self.Players) do
        v:SetSize(w, playerH)
    end
end

GM:DefineFont("Scoreboard.Hint", 24)

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
