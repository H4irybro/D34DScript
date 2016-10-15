D34D                           	= 	 {}
D34D.g                          =    table.Copy( _G )
D34D.Settings                  	= 	 {}
D34D.Settings['rage_aim']       =    false
D34D.Settings['rapidfire']      =    true
D34D.Settings['rainbow']        =    true
D34D.Settings.Whitelist         =    {
	"STEAM_0:1:67760178"
}

CreateClientConVar("rage_ignore_whitelist", 1)
CreateClientConVar("rage_rain_speed", 0.5)

D34D.Settings['rainbow_speed'] = GetConVarNumber("rage_rain_speed")

function LocalChat( msg )
	D34D.g.chat.AddText(Color(0,0,255),"(", Color(255,0,0), "chat", Color(0,0,255),")D34DB33F: ", Color(255,255,255), msg)
end

function LocalConPrint( msg )
	D34D.g.MsgC(Color(0,0,255),"(", Color(255,0,0), "con", Color(0,0,255),")D34DB33F: ", Color(0,255,0), msg, "\n" )
end

function rage_aim( cmd )
	if (!LocalPlayer():Alive()) then
		if (D34D.Settings['rage_aim'] == true && LocalPlayer():GetActiveWeapon():GetClass() != "weapon_physgun") then
			// find closest target first
			local allply = table.Copy(player.GetAll())
	        local plyDist = 100000

	        if (GetConVarNumber("rage_ignore_whitelist") == 1) then
	        	for _,v in pairs(D34D.Settings.Whitelist) do
	        		for a,b in pairs(allply) do
	        			if (b:SteamID() == v) then
	        				table.RemoveByValue(allply, b)
	        			end
	        		end
	        	end
	        end

	        for i = 1, #allply do
	            v = allply[i]
				if v:Alive() && v != LocalPlayer() then
	            	local plyDist2 = LocalPlayer():GetPos():Distance(v:GetPos())
	            	if plyDist2 < plyDist then
	               		plyDist = plyDist2
	               		target = v
	            	end
				end
			end

			local targetpos = target:GetBonePosition(target:LookupBone("ValveBiped.Bip01_Head1"))
			local shootpos = LocalPlayer():GetShootPos()
			if (cmd:KeyDown(IN_ATTACK)) then
				cmd:SetViewAngles((targetpos - shootpos):Angle())
			end
		end
	end
end
hook.Add("CreateMove", "aimbot", rage_aim)

local toggler = 0

local function rapidfire(cmd)
	if (D34D.Settings['rapidfire'] == true) then
		if LocalPlayer():KeyDown(IN_ATTACK) then
			if LocalPlayer():Alive() then
				if IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() != "weapon_physgun" then
					if toggler == 0 then
						cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_ATTACK))
						toggler = 1
					else
						cmd:SetButtons(bit.band(cmd:GetButtons(), bit.bnot(IN_ATTACK)))
						toggler = 0
					end
				end
			end
		end
	end
end
hook.Add("CreateMove", "rapidfire", rapidfire)

function SetPhysgunRainbow( )
	if (D34D.Settings['rainbow'] == true) then
		if (LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physgun") then
			local time = CurTime()
			local r = math.abs(math.sin(time * D34D.Settings['rainbow_speed']) * 255);
			local g = math.abs(math.sin(time * D34D.Settings['rainbow_speed'] + 4) * 255);
			local b = math.abs(math.sin(time * D34D.Settings['rainbow_speed'] + 8) * 255);
			LocalPlayer():SetWeaponColor( Vector(r,g,b) )
		end
	end
end
hook.Add("RenderScene", "rainbow_phys", SetPhysgunRainbow)

concommand.Add("rage_aim", function ( )
	if (D34D.Settings['rage_aim'] == true) then
		D34D.Settings['rage_aim'] = false
		LocalChat("Rage Aim off!")
	else
		D34D.Settings['rage_aim'] = true
		LocalChat("Rage Aim on!")
	end
end)

concommand.Add("rage_rapid", function ( )
	if (D34D.Settings['rapidfire'] == true) then
		D34D.Settings['rapidfire'] = false
		LocalChat("Rapid Fire off!")
	else
		D34D.Settings['rapidfire'] = true
		LocalChat("Rapid Fire on!")
	end
end)

// update convars
hook.Add("Think", "UpdateConVars", function ( )
	D34D.Settings['rainbow_speed'] = GetConVarNumber("rage_rain_speed")
end)

// test norecoil
local function NoSpread()    
	if GetConVarNumber("nospread") == 1 and LocalPlayer().GetActiveWeapon != nil then
		local wep = LocalPlayer():GetActiveWeapon()
		if wep.data then
			wep.data.Recoil = 0
			wep.data.Cone = 0
			wep.data.Spread = 0
		end
		if wep.Primary then
			wep.Primary.Recoil = 0
			wep.Primary.Cone = 0
			wep.Primary.Spread = 0
		end
	end
end
hook.Add("RenderScene", "NoSpread", NoSpread)

CreateClientConVar( "nospread", 0, true, false)