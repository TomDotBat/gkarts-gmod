
local materials = {}

file.CreateDir("gkarts")
function gKarts.GetImgur(id, callback, useproxy)
    if materials[id] then return callback(materials[id]) end

    if file.Exists("gkarts/" .. id .. ".png", "DATA") then
        materials[id] = Material("../data/gkarts/" .. id .. ".png", "noclamp smooth")
        return callback(materials[id])
    end

    http.Fetch(useproxy and "https://proxy.duckduckgo.com/iu/?u=https://i.imgur.com" or "https://i.imgur.com/" .. id .. ".png",
        function(body, len, headers, code)
            file.Write("gkarts/" .. id .. ".png", body)
            materials[id] = Material("../data/gkarts/" .. id .. ".png", "noclamp smooth")
            return callback(materials[id])
        end,
        function(error)
            if useproxy then
                materials[id] = Material("nil")
                return callback(materials[id])
            end
            return gKarts.GetImgur(id, callback, true)
        end
    )
end
