
gKarts.RegisteredFonts = gKarts.RegisteredFonts or {}
local registeredFonts = gKarts.RegisteredFonts

do
    gKarts.SharedFonts = gKarts.SharedFonts or {}
    local sharedFonts = gKarts.SharedFonts

    function gKarts.RegisterFontUnscaled(name, size, bold, weight)
        weight = weight or 500

        local identifier = string.format("%i:%s:%i", size, tostring(bold), weight)

        local fontName = "gKarts:" .. identifier
        registeredFonts[name] = fontName

        if sharedFonts[identifier] then return end
        sharedFonts[identifier] = true

        surface.CreateFont(fontName, {
            font = bold and "Bebas Neue" or "Bebas Neue Bold",
            size = size,
            weight = weight,
            antialias = true
        })
    end
end

do
    gKarts.ScaledFonts = gKarts.ScaledFonts or {}
    local scaledFonts = gKarts.ScaledFonts

    function gKarts.RegisterFont(name, size, bold, weight)
        scaledFonts[name] = {bold, size, weight}
        gKarts.RegisterFontUnscaled(name, gKarts.Scale(size), bold, weight)
    end

    hook.Add("OnScreenSizeChanged", "gKarts.ReRegisterFonts", function()
        for _, font in pairs(scaledFonts) do
            gKarts.RegisterFont(k, font[1], font[2], font[3])
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
