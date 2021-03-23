
local PANEL = {}

AccessorFunc(PANEL, "nMaskSize", "MaskSize", FORCE_NUMBER)

function PANEL:Init()
    self.Avatar = vgui.Create("AvatarImage", self)
    self.Avatar:SetPaintedManually(true)

    self.CirclePoly = {}
    self.nMaskSize = 1
end

do
    local rad = math.rad
    local sin, cos = math.sin, math.cos

    function PANEL:PerformLayout(w, h)
        self.Avatar:SetSize(w, h)

        local centerX, centerY = w * .5, h * .5
        local maskSize = self.nMaskSize

        local t = 0
        for i = 1, 360 do
            t = rad(i * 720) / 720
            self.CirclePoly[i] = {x = centerX + cos(t) * maskSize, y = centerY + sin(t) * maskSize}
        end
    end
end

function PANEL:SetPlayer(ply, size)
    self.Avatar:SetPlayer(ply, size)
end

function PANEL:SetSteamID(id, size)
    self.Avatar:SetSteamID(id, size)
end

do
    local clearStencil = render.ClearStencil
    local setStencilEnable = render.SetStencilEnable
    local setStencilWriteMask = render.SetStencilWriteMask
    local setStencilTestMask = render.SetStencilTestMask
    local setStencilFailOperation = render.SetStencilFailOperation
    local setStencilPassOperation = render.SetStencilPassOperation
    local setStencilZFailOperation = render.SetStencilZFailOperation
    local setStencilCompareFunction = render.SetStencilCompareFunction
    local setStencilReferenceValue = render.SetStencilReferenceValue

    local setTexture = surface.SetTexture
    local setDrawColor = surface.SetDrawColor
    local drawPoly = surface.DrawPoly

    local stencilOperationReplace = STENCILOPERATION_REPLACE
    local stencilOperationZero = STENCILOPERATION_ZERO
    local stencilOperationNever = STENCILCOMPARISONFUNCTION_NEVER
    local stencilOperationEqual = STENCILCOMPARISONFUNCTION_EQUAL

    local whiteTexture = surface.GetTextureID("vgui/white")

    function PANEL:Paint(w, h)
        clearStencil()
        setStencilEnable(true)

        setStencilWriteMask(1)
        setStencilTestMask(1)

        setStencilFailOperation(stencilOperationReplace)
        setStencilPassOperation(stencilOperationZero)
        setStencilZFailOperation(stencilOperationZero)
        setStencilCompareFunction(stencilOperationNever)
        setStencilReferenceValue(1)

        setTexture(whiteTexture)
        setDrawColor(255, 255, 255, 255)
        drawPoly(self.CirclePoly)

        setStencilFailOperation(stencilOperationZero)
        setStencilPassOperation(stencilOperationReplace)
        setStencilZFailOperation(stencilOperationZero)
        setStencilCompareFunction(stencilOperationEqual)
        setStencilReferenceValue(1)

        self.Avatar:SetPaintedManually(false)
        self.Avatar:PaintManual()
        self.Avatar:SetPaintedManually(true)

        setStencilEnable(false)
        clearStencil()
    end
end

vgui.Register("gKarts.CircleAvatar", PANEL, "Panel")
