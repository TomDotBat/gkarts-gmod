
local toggled = true
function GM:ScoreboardShow()
    toggled = not toggled

    if not IsValid(self.Scoreboard) then
        self.Scoreboard = vgui.Create("gKarts.Scoreboard")
    end

    if toggled then
        self:FadeScoreboard(0, .2, function(scoreboard)
            scoreboard:SetVisible(false)
        end)
    else
        self.Scoreboard:SetVisible(true)
        self.Scoreboard:ShowHint()
        self:FadeScoreboard(255, .2)
    end
end

function GM:FadeScoreboard(targetAlpha, time, callback)
    local scoreboard = self.Scoreboard
    if not IsValid(scoreboard) then return end

    local progress = 0
    local startAlpha = scoreboard:GetAlpha()

    local frameTime = FrameTime
    local isValid = IsValid
    local lerp = Lerp

    hook.Add("PreRender", "gKarts.Scoreboard.FadeAnimation", function()
        if not isValid(scoreboard) then return end
        progress = progress + (frameTime() / time)
        scoreboard:SetAlpha(lerp(progress, startAlpha, targetAlpha))

        if progress >= 1 then
            if callback then callback(scoreboard) end
            hook.Remove("PreRender", "gKarts.Scoreboard.FadeAnimation")
        end
    end)
end

function GM:ScoreboardHide() end
