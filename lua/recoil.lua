local GUN = {};

CreateClientConVar("nospread", 1);

// test nospread
GUN.NoSpread = function()    
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
hook.Add("Think", "NoSpread", GUN.NoSpread)