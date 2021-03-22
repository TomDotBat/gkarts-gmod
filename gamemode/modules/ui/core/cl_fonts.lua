
gKarts.RegisteredFonts = gKarts.RegisteredFonts or {}
local registeredFonts = gKarts.RegisteredFonts

do
    gKarts.SharedFonts = gKarts.SharedFonts or {}
    local sharedFonts = gKarts.SharedFonts

    function gKarts.RegisterFontUnscaled(name, size, bold, weight)
        weight = weight or 500

        local font = bold and "Bebas Neue" or "Bebas Neue Bold"
        local identifier = font .. size .. ":" .. weight

        local fontName = "gKarts:" .. identifier
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
    gKarts.ScaledFonts = gKarts.ScaledFonts or {}
    local scaledFonts = gKarts.ScaledFonts

    function gKarts.RegisterFont(name, font, size, weight)
        scaledFonts[name] = {
            font = font,
            size = size,
            weight = weight
        }

        gKarts.RegisterFontUnscaled(name, font, gKarts.Scale(size), weight)
    end

    hook.Add("OnScreenSizeChanged", "gKarts.ReRegisterFonts", function()
        for k,v in pairs(scaledFonts) do
            gKarts.RegisterFont(k, v.font, v.size, v.weight)
        end
    end)
end

do
    local setFont = surface.SetFont
    local function setgKartsFont(font)
        local gKartsFont = registeredFonts[font]
        if gKartsFont then
            setFont(gKartsFont)
            return
        end

        setFont(font)
    end

    gKarts.SetFont = setgKartsFont

    local getTextSize = surface.GetTextSize
    function gKarts.GetTextSize(text, font)
        if font then setgKartsFont(font) end
        return getTextSize(text)
    end

    function gKarts.GetRealFont(font)
        return registeredFonts[font]
    end
end
