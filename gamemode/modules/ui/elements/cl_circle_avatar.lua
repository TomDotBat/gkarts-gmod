

local PANEL = {}

AccessorFunc(PANEL, "m_masksize", "MaskSize", FORCE_NUMBER)

function PANEL:Init()
    self.Avatar = vgui.Create("AvatarImage", self)
    self.Avatar:SetPaintedManually(true)
end

function PANEL:PerformLayout(w, h)
    self.Avatar:SetSize(w, h)
end

function PANEL:SetPlayer(ply, size)
    self.Avatar:SetPlayer(ply, size)
end

function PANEL:SetSteamID(id, size)
    self.Avatar:SetSteamID(id, size)
end

function PANEL:Paint(w, h)
    render.ClearStencil()
    render.SetStencilEnable(true)

    render.SetStencilWriteMask(1)
    render.SetStencilTestMask(1)

    render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
    render.SetStencilPassOperation(STENCILOPERATION_ZERO)
    render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
    render.SetStencilReferenceValue(1)

    local _m = self.m_masksize or 0

    local circle, t = {}, 0
    for i = 1, 360 do
        t = math.rad(i * 720) / 720
        circle[i] = {x = w / 2 + math.cos(t) * _m, y = h / 2 + math.sin(t) * _m}
    end

    draw.NoTexture()
    surface.SetDrawColor(color_white)
    surface.DrawPoly(circle)

    render.SetStencilFailOperation(STENCILOPERATION_ZERO)
    render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
    render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
    render.SetStencilReferenceValue(1)

    self.Avatar:SetPaintedManually(false)
    self.Avatar:PaintManual()
    self.Avatar:SetPaintedManually(true)

    render.SetStencilEnable(false)
    render.ClearStencil()
end

vgui.Register("gKarts.CircleAvatar", PANEL, "Panel")
