
local PANEL = {}

function PANEL:Init()
end

function PANEL:SetPlayer(ply)
end

function PANEL:Think()
end

function PANEL:PerformLayout(w, h)
end

function PANEL:Paint(w, h)
    draw.RoundedBox(GAMEMODE:ScreenScale(8), 0, 0, w, h, GAMEMODE.Colors.PrimaryBackground)
end

vgui.Register("gKarts.Scoreboard.Player", PANEL, "Panel")
