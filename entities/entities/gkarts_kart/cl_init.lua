
include("shared.lua")

--anims
--0	=	idle
--1	=	suspension
--2	=	turn
--3	=	spin
--4	=	wheel_fr_suspension
--5	=	wheel_fl_suspension
--6	=	wheel_rr_suspension
--7	=	wheel_rl_suspension
--8	=	turning
--9	=	wheel_fl_spin
--10	=	wheel_fr_spin
--11	=	wheel_rr_spin
--12	=	wheel_rl_spin
--13	=	speedometer

--bones
--0	gokart_groot
--1	gokart_characterplacement
--2	wishbone_RL_Top
--3	wishbone_RL_Bottom
--4	wishbone_RL_damper_base
--5	wishbone_RL_Rotato
--6	wishbone_RL_Wheel
--7	wishbone_RL_damper_top
--8	wishbone_RR_damper_top
--9	wishbone_RR_Top
--10	wishbone_RR_Bottom
--11	wishbone_RR_Rotato
--12	wishbone_RR_Wheel
--13	wishbone_RR_damper_Base
--14	wishbone_FL_Top
--15	wishbone_FL_Bottom
--16	wishbone_fl_Rotato
--17	wishbone_fl_Steering
--18	wishbone_FL_Tierod
--19	wishbone_FL_Tierod_Speen
--20	wishbone_fl_wheel
--21	suspension_FL_damper_base
--22	suspension_FL_damper_top
--23	suspension_FR_damper_top
--24	wishbone_FR_Bottom
--25	wishbone_FR_Rotato
--26	wishbone_FR_Steering
--27	wishbone_FR_Wheel
--28	wishbone_FR_Tierod
--29	wishbone_FR_Tierod_speen
--30	suspension_FR_damper_base
--31	wishbone_FR_Top
--32	gokart_dashboard_RPM
--33	gokart_dashboard_Temp
--34	gokart_dashboard_Power
--35	gokart_steeringwheel
--36	spring_RL_Base
--37	spring_RL_Top
--38	spring_RR_Top
--39	spring_RR_Base
--40	spring_FL_base
--41	spring_FL_top
--42	spring_FR_top
--43	spring_FR_Base


local thinked = false
function ENT:Think()
    if thinked then return end
    thinked = true

    --PrintTable(self:GetSequenceList())

    --print(self:GetBoneCount())

    --for i = 0, self:GetBoneCount() do
    --    print(i, self:GetBoneName(i))
    --end
end
