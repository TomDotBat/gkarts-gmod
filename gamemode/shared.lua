GM.Name = "gKarts"
GM.Author = "MagmaPlex Team - Tom.bat & NoSharp"
GM.Email = "N/A"
GM.Website = "http://magmanet.co/"

function GM:LoadDirectory(dir)
    local fil, fol = file.Find(dir .. "/*", "LUA")

    for k, v in pairs(fol) do
        self:LoadDirectory(dir .. "/" .. v)
        print("[G-Karts] Loaded folder: \"" .. dir .. "/" .. v .. "\"")
    end

    for k, v in ipairs(fil) do
        local dirs = dir .. "/" .. v

        if v:StartWith("cl_") then
            if SERVER then
                AddCSLuaFile(dirs)
            else
                include(dirs)
            end
        elseif v:StartWith("sh_") then
            AddCSLuaFile(dirs)
            include(dirs)
        else
            if SERVER then
                include(dirs)
            end
        end
    end
end

print("[G-Karts] Loading...")
print("[G-Karts] GKarts is property of Magma Networks (Tom.bat and NoSharp)")

GKarts = {}
team.SetUp(1, "drivers", Color(255, 255, 255))

GM:LoadDirectory(GM.FolderName .. "/gamemode/modules")

