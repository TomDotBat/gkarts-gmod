
GKarts.RegisteredFonts = GKarts.RegisteredFonts or {}
local registeredFonts = GKarts.RegisteredFonts

do
    GKarts.SharedFonts = GKarts.SharedFonts or {}
    local sharedFonts = GKarts.SharedFonts

    function GKarts.RegisterFontUnscaled(name, font, size, weight)
        weight = weight or 500

        local identifier = font .. size .. ":" .. weight

        local fontName = "GKarts:" .. identifier
        registeredFonts[name] = fontName

        if sharedFonts[identifier] then return end
        sharedFonts[identifier] = true

        surface.CreateFont(fontName, {
            font = font,
            size = size,
            weight = weight,
            antialias = true
        })
    end
end

do
    GKarts.ScaledFonts = GKarts.ScaledFonts or {}
    local scaledFonts = GKarts.ScaledFonts

    function GKarts.RegisterFont(name, font, size, weight)
        scaledFonts[name] = {
            font = font,
            size = size,
            weight = weight
        }

        GKarts.RegisterFontUnscaled(name, font, GKarts.Scale(size), weight)
    end

    hook.Add("OnScreenSizeChanged", "GKarts.ReRegisterFonts", function()
        for k,v in pairs(scaledFonts) do
            GKarts.RegisterFont(k, v.font, v.size, v.weight)
        end
    end)
end

do
    local setFont = surface.SetFont
    local function setGKartsFont(font)
        local GKartsFont = registeredFonts[font]
        if GKartsFont then
            setFont(GKartsFont)
            return
        end

        setFont(font)
    end

    GKarts.SetFont = setGKartsFont

    local getTextSize = surface.GetTextSize
    function GKarts.GetTextSize(text, font)
        if font then setGKartsFont(font) end
        return getTextSize(text)
    end

    function GKarts.GetRealFont(font)
        return registeredFonts[font]
    end
end
