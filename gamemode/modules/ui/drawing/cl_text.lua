
local ceil = math.ceil
local getTextSize = gKarts.GetTextSize

do
    local setTextPos = surface.SetTextPos
    local setTextColor = surface.SetTextColor
    local drawText = surface.DrawText

    function gKarts.DrawSimpleText(text, font, x, y, col, xAlign, yAlign)
        local w, h = getTextSize(text, font)

        if xAlign == 1 then
            x = x - w / 2
        elseif xAlign == 2 then
            x = x - w
        end

        if yAlign == 1 then
            y = y - h / 2
        elseif yAlign == 4 then
            y = y - h
        end

        setTextPos(ceil(x), ceil(y))
        setTextColor(col.r, col.g, col.b, col.a)
        drawText(text)

        return w, h
    end
end

do
    local drawSimpleText = gKarts.DrawSimpleText

    function gKarts.SimpleTextOutlined(text, font, x, y, col, xAlign, yAlign, outlineWidth, outlineCol)
        local steps = (outlineWidth * 2) / 3
        if steps < 1 then steps = 1 end

        for _x = -outlineWidth, outlineWidth, steps do
            for _y = -outlineWidth, outlineWidth, steps do
                drawSimpleText(text, font, x + _x, y + _y, outlineCol, xAlign, yAlign)
            end
        end

        return drawSimpleText(text, font, x, y, col, xAlign, yAlign)
    end

    local gmatch = string.gmatch
    local find = string.find
    local max = math.max
    local select = select

    function gKarts.DrawText(text, font, x, y, col, xAlign, yAlign)
        local curX = x
        local curY = y

        local lineHeight = select(2, getTextSize("\n", font))
        local tabWidth = 50

        for str in gmatch(text, "[^\n]*") do
            if #str > 0 then
                if find(str, "\t") then
                    for tabs, str2 in gmatch(str, "(\t*)([^\t]*)") do
                        curX = ceil((curX + tabWidth * max(#tabs - 1, 0 )) / tabWidth) * tabWidth

                        if #str2 > 0 then
                            drawSimpleText(str2, font, curX, curY, col, xAlign)
                            curX = curX + getTextSize(str2)
                        end
                    end
                else
                    drawSimpleText(str, font, curX, curY, col, xAlign)
                end
            else
                curX = x
                curY = curY + lineHeight / 2
            end
        end
    end
end

do
    local function charWrap(text, remainingWidth, maxWidth)
        local totalWidth = 0

        text = text:gsub(".", function(char)
            totalWidth = totalWidth + getTextSize(char)

            if totalWidth >= remainingWidth then
                totalWidth = getTextSize(char)
                remainingWidth = maxWidth
                return "\n" .. char
            end

            return char
        end)

        return text, totalWidth
    end

    local subString = string.sub
    function gKarts.WrapText(text, width, font)
        local textWidth = getTextSize(text, font)

        if textWidth <= width then
            return text
        end

        local totalWidth = 0
        local spaceWidth = getTextSize(" ")
        text = text:gsub("(%s?[%S]+)", function(word)
            local char = subString(word, 1, 1)
            if char == "\n" or char == "\t" then
                totalWidth = 0
            end

            local wordLen = getTextSize(word)
            totalWidth = totalWidth + wordLen

            if wordLen >= width then
                local splitWord, splitPoint = charWrap(word, width - (totalWidth - wordLen), width)
                totalWidth = splitPoint
                return splitWord
            elseif totalWidth < width then
                return word
            end

            if char == " " then
                totalWidth = wordLen - spaceWidth
                return "\n" .. subString(word, 2)
            end

            totalWidth = wordLen
            return "\n" .. word
        end)

        return text
    end
end

do
    local left = string.Left
    function gKarts.EllipsesText(text, width, font)
        local textWidth = getTextSize(text, font)

        if textWidth <= width then
            return text
        end

        repeat
            text = left(text, #text - 1)
            textWidth = getTextSize(text .. "...")
        until textWidth <= width

        text = text .. "..."

        return text
    end
end
