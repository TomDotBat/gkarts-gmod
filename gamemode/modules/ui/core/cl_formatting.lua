
local suffixes = {"st", "nd", "rd"}
function gKarts.GetSuffix(num)
    num = num % 100
    if num > 10 and num < 20 then
        return "th"
    end

    return suffixes[num % 10] or "th"
end
