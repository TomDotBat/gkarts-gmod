
local toggled = false
function GM:ScoreboardShow()
    toggled = not toggled

    if toggled then
        if IsValid(self.Scoreboard) then
            if self.Scoreboard.Fading then return end

            self.Scoreboard:SetVisible(true)
            self.Scoreboard.CreateTime = CurTime()
            self.Scoreboard.Fading = true

            self.Scoreboard:AlphaTo(255, .3, 0, function(anim, pnl)
                self.Scoreboard.Fading = false
            end)

            return
        end

        self.Scoreboard = vgui.Create("gKarts.Scoreboard")
    else
        if IsValid(self.Scoreboard) then
            if self.Scoreboard.Fading then return end

            self.Scoreboard.Fading = true
            self.Scoreboard:AlphaTo(0, .3, 0, function(anim, pnl)
                self.Scoreboard.Fading = false
                self.Scoreboard:SetVisible(false)
            end)
        end
    end
end

function GM:ScoreboardHide() end
