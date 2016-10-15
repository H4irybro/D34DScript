D34D                           	= 	 {}
D34D.g                          =    table.Copy( _G ) // kinda pointless
D34D.g_GAMEMODE                 =    gmod.GetGamemode()

D34D.Settings                  	= 	 {}
D34D.Settings['plugins_loc']    =    "https://github.com/H4irybro/D34DPlugins"
D34D.Settings['enabled_plugs']  =    "d34d/plugs/plugs.json"
D34D.Settings['bhop']          	= 	 true
D34D.Settings['esp']           	= 	 true
D34D.Settings['esp_box']       	= 	 true
D34D.Settings['aimbot']        	= 	 false
D34D.Settings['aimBone']   	   	= 	 "ValveBiped.Bip01_Head1"
D34D.Settings['DoorHider']     	=    false
D34D.Settings['printer_show']  	=    true
D34D.Settings['printer_colour']	=    Color(0,0,255)
D34D.Settings['money_colour']   =    Color(255,255,255)
D34D.Settings['Xray']           =    true
D34D.Settings['D34DBeets']      =    true
D34D.Settings['title']          =    [[

 ____  ____   ___  ____  ____  ____  ____  ____ 
(    \( __ \ / _ \(    \(  _ \( __ \( __ \(  __)
 ) D ( (__ ((__  ( ) D ( ) _ ( (__ ( (__ ( ) _) 
(____/(____/  (__/(____/(____/(____/(____/(__)  By H4iryBro
]]
D34D.Settings['title_chat']     =    ""
D34D.Settings['launch']         =    "D34DB33F Hack running on client: '" .. LocalPlayer():GetName() .. "'; Contact them for more info..."
D34D.Settings['spam_def']       =    "D34D is fun..."
D34D.Settings['spam_on']        =    false
D34D.Settings['cross']          =    true
D34D.Settings['cross_colour']   =    Color(255,255,255)
D34D.Settings['rapidfire']      =    true
D34D.Settings['propHack']       =    false
D34D.Settings['moneyHack']      =    true
D34D.Settings['rainbow_phys']   =    true
D34D.Settings['rage_aim']       =    false
D34D.Settings['chatsound']      =    "garrysmod/ui_click.wav"

D34D.Bones = {
	["righth"] = "ValveBiped.Bip01_R_Hand", // 1
	["lefth"]  = "ValveBiped.Bip01_L_Hand", // 2
	["chest"]  = "ValveBiped.Bip01_Spine",  // 3
	["head"]   = "ValveBiped.Bip01_Head1"   // 4
}

CreateClientConVar("d_r", 255)
CreateClientConVar("d_g", 255)
CreateClientConVar("d_b", 255)
CreateClientConVar("rage_ignore_friends", 0)
CreateClientConVar("rage_faze", 0)
CreateClientConVar("aim_bone", "head")

function SetAimBone( id )
	RunConsoleCommand("aim_bone", D34D.Bones[id])
end

function GetPluginState(plugin)
	f = file.Read(D34D.Settings['enabled_plugs'], "LUA")
	if (!f) then
		print("fukkkk") 
		return 
	end
	o = util.JSONToTable(f)

	return o[plugin]
end


function GetTC( ent )
	return GAMEMODE:GetTeamColor( ent )
end

function Chat( bTeam )
	GAMEMODE:StartChat( bTeam )
end

function TeamColourPrint(txt)
	D34D.g.MsgC(GetTC(LocalPlayer()), txt .. "\n")
end

TeamColourPrint("test")

function ColPrint(col, text)
	D34D.g.MsgC(col, text .. "\n")
end 

function LocalChat( msg )
	D34D.g.chat.AddText(Color(0,0,255),"(", Color(255,0,0), "chat", Color(0,0,255),")D34DB33F: ", Color(255,255,255), msg);surface.PlaySound(D34D.Settings['chatsound'])
end

function LocalConPrint( msg )
	D34D.g.MsgC(Color(0,0,255),"(", Color(255,0,0), "con", Color(0,0,255),")D34DB33F: ", Color(0,255,0), msg, "\n" );surface.PlaySound(D34D.Settings['chatsound'])
end

function SendKeys( bitButton )
	GAMEMODE:CreateMove( bitButton )
end

function beets_()
	if (GetPluginState("d34dbeets") == "on") then
		include("d34d/plugs/d34dbeets.lua")
	else
		ColPrint(Color(255,0,0), "Plugin is not enabled!")
	end
end

function SettingOn(var)
	MsgC(var)
end

function x_plug()

end

local t
function GetPlayerByName( name )
	name = string.lower(name)
	t = player.GetHumans()
	
	for i = 1, #t do
		if ( t[i]:Nick():lower():find( name, 1, true ) ) then
			return ply
		end
	end
end

function GetKey( s ) // takes string
	if (s == "a") then
		return KEY_A
	elseif (s == "b") then
		return KEY_B
	elseif (s == "c") then
		return KEY_C
	elseif (s == "d") then
		return KEY_D
	elseif (s == "e") then
		return KEY_E
	elseif (s == "f") then
		return KEY_F
	elseif (s == "g") then
		return KEY_G
	elseif (s == "h") then
		return KEY_H
	elseif (s == "i") then
		return KEY_I
	elseif (s == "j") then
		return KEY_J
	elseif (s == "k") then
		return KEY_K
	elseif (s == "l") then
		return KEY_L
	elseif (s == "m") then
		return KEY_M
	elseif (s == "n") then
		return KEY_N
	elseif (s == "o") then
		return KEY_O
	elseif (s == "p") then
		return KEY_P
	elseif (s == "q") then
		return KEY_Q
	elseif (s == "r") then
		return KEY_R
	elseif (s == "s") then
		return KEY_S
	elseif (s == "t") then
		return KEY_T
	elseif (s == "u") then
		return KEY_U
	elseif (s == "v") then
		return KEY_V
	elseif (s == "w") then
		return KEY_W
	elseif (s == "x") then
		return KEY_X
	elseif (s == "y") then
		return KEY_Y
	elseif (s == "z") then
		return KEY_Z
	else
		return 10000
	end
end

--------------------------TAKEN FROM MY CHAT SYSTEM-----------------------------

local chatcommands = {};
local chatcommandss= {};

function BPC(ply, text, teamc, alive)
	local chat_string = string.Explode(" ", text);
	
	for k, v in pairs( chatcommands ) do
		if( chat_string[1] == k ) then
			table.remove(chat_string, 1);
			v(ply, chat_string);
			
			return "";
		end
		
		if( string.find(k, chat_string[1]) != nil ) then
			local start, endp, word = string.find(k, chat_string[1]);
			
			if( endp - (start - 1) > 2 ) then
				ply:ChatPrint("Invalid command! Did you mean '"..tostring( k ).."'?");
				
				return "";
			end
		end
	end
	
	return text;
end
hook.Add("PlayerSay", "BackupPlayerCommands", BPC)

function RegisterChatCommand(strCommand, Func, desc)
	if( !strCommand || !Func ) then return; end
	
	for k, v in pairs( chatcommands ) do
		if( strCommand == k ) then
			return;
		end
	end
	
	chatcommands[ tostring( strCommand ) ] = Func;
	chatcommandss[ tostring( strCommand ) ] = tostring( desc );
end
--------------------------------------------------------------------------------

surface.CreateFont("DF", {
	font = "Arial",
	size = 13,
	weight = 800
})
D34D.Font = "DF"
lp = LocalPlayer()

function box( _pos, sizex, sizey, inflationx, inflationy )
	if (inflationy == nil) then
		inflationy = 1
	end
	if (inflationx == nil) then
		inflationx = 1
	end
	pos = _pos:ToScreen()
	surface.SetDrawColor(255,255,255,255)
	surface.DrawLine(pos.x-25-sizex*inflationx,pos.y-25-sizey*inflationy,pos.x+25+sizex*inflationx,pos.y-25-sizey*inflationy) // |-----|
	surface.DrawLine(pos.x+25+sizex*inflationx,pos.y-25-sizey*inflationy,pos.x+25+sizex*inflationx,pos.y+25+sizey*inflationy) // |     |
	surface.DrawLine(pos.x+25+sizex*inflationx,pos.y+25+sizey*inflationy,pos.x-25-sizex*inflationx,pos.y+25+sizey*inflationy) // |     |
	surface.DrawLine(pos.x-25-sizex*inflationx,pos.y+25+sizey*inflationy,pos.x-25-sizex*inflationx,pos.y-25-sizey*inflationy) // |-----|
	
end

function dead_bhop()
	if (D34D.Settings['bhop'] == true) then
		if (input.IsKeyDown(KEY_SPACE)) then
			if (lp:IsOnGround()) then
				RunConsoleCommand("+jump")
				timer.Create("bhop", 0, 0.01, function ( )
					RunConsoleCommand("-jump")
				end)
			end
		end
	end
end
hook.Add("Think", "DeadBhop", dead_bhop)

function dead_esp()
	if (D34D.Settings['esp'] == true) then
		for k,v in pairs(player.GetAll()) do
			pos     = (v:GetPos() + Vector(0,0,80)):ToScreen()
			dist    = (math.Round(v:GetPos():Distance(LocalPlayer():GetPos())))
			if (v != LocalPlayer()) then
				// hp bar
				if (LocalPlayer():GetPos():Distance(v:GetPos()) < 1000) then // prevent screen from being too full
					draw.RoundedBox(0,pos.x - 50,pos.y - 30,100, 10,Color(255,0,0))
					if (v:Health() > 100) then
						draw.RoundedBox(0,pos.x - 50,pos.y - 30,100, 10,Color(0,255,0))
					else
						draw.RoundedBox(0,pos.x - 50,pos.y - 30,v:Health(), 10,Color(0,255,0))
					end
				end

				// normal esp
				draw.DrawText("[" .. v:GetName() .. "]", "DF", pos.x, pos.y, Color(255,255,255,255), 1)
				draw.DrawText("D: " .. dist, "DF", pos.x, pos.y - 10, Color(255,255,255,255), 1)
			end
		end
		for k,v in pairs(ents.GetAll()) do
			if (v:IsNPC()) then
				pos     = (v:GetPos() + Vector(0,0,80)):ToScreen()
				distPos = (v:GetPos() + Vector(0,0,60)):ToScreen()
				dist    = (math.Round(v:GetPos():Distance(LocalPlayer():GetPos())))
				draw.DrawText("[NPC]", "DF", pos.x, pos.y, Color(255,255,255,255), 1)
				draw.DrawText("D: " .. dist, "DF", distPos.x, distPos.y, Color(255,255,255,255), 1)
			end
		end
	end
end
hook.Add("HUDPaint", "DeadEsp", dead_esp)

local function MESPCheck(v)
	if v:Alive() == true && v:Health() ~= 0 && v:Health() >= 0 && v ~= LocalPlayer() && LocalPlayer():Alive() then
		return true
	else
		return false
	end
end
// NOT MY WORK
hook.Add( "HUDPaint", "aimbot.Wallhack", function()
for k,v in pairs ( player.GetAll() ) do
 
        local Position = ( v:GetPos() + Vector( 0,0,80 ) ):ToScreen()
        local Name = ""
 
        if v == LocalPlayer() then Name = "" else Name = v:Name() end
end
end )
local shouldDraw = true
local hzCross = CreateClientConVar("HZ_Crosshair","0",false)
local function coordinates( ent )
local min, max = ent:OBBMins(), ent:OBBMaxs()
local corners = {
        Vector( min.x, min.y, min.z ),
        Vector( min.x, min.y, max.z ),
        Vector( min.x, max.y, min.z ),
        Vector( min.x, max.y, max.z ),
        Vector( max.x, min.y, min.z ),
        Vector( max.x, min.y, max.z ),
        Vector( max.x, max.y, min.z ),
        Vector( max.x, max.y, max.z )
}
local minX, minY, maxX, maxY = ScrW() * 2, ScrH() * 2, 0, 0
for _, corner in pairs( corners ) do
        local onScreen = ent:LocalToWorld( corner ):ToScreen()
        minX, minY = math.min( minX, onScreen.x ), math.min( minY, onScreen.y )
        maxX, maxY = math.max( maxX, onScreen.x ), math.max( maxY, onScreen.y )
end
return minX, minY, maxX, maxY
end
hook.Add("HUDPaint", "Example", function()
for k,v in pairs(player.GetAll()) do
        local x1,y1,x2,y2 = coordinates(v)
         surface.SetDrawColor(color_white)
        surface.DrawLine( x1, y1, math.min( x1 + 5, x2 ), y1 )
        surface.DrawLine( x1, y1, x1, math.min( y1 + 5, y2 ) )
        surface.DrawLine( x2, y1, math.max( x2 - 5, x1 ), y1 )
        surface.DrawLine( x2, y1, x2, math.min( y1 + 5, y2 ) )
        surface.DrawLine( x1, y2, math.min( x1 + 5, x2 ), y2 )
        surface.DrawLine( x1, y2, x1, math.max( y2 - 5, y1 ) )
        surface.DrawLine( x2, y2, math.max( x2 - 5, x1 ), y2 )
        surface.DrawLine( x2, y2, x2, math.max( y2 - 5, y1 ) )
end
end)
local struc = {}
struc.pos = {}
struc.pos[1] = 100 -- x pos
struc.pos[2] = 200 -- y pos
struc.color = Color(255,0,0,255) -- Red
struc.text = "Hello World" -- Text
struc.font = "DefaultFixed" -- Font
struc.xalign = TEXT_ALIGN_CENTER -- Horizontal Alignment
struc.yalign = TEXT_ALIGN_CENTER -- Vertical Alignment
draw.Text( struc )

--NOW RETURNING TO MY WORK--

// Aimbot, FINALLY STARTING WORK ON IT :D //
local function HasHead(ent)
	local bone = ent:LookupBone(D34D.Settings['aimBone'])
	if bone then
		return true 
	else
		return false
	end
end
function rage_aim( cmd )
	if (D34D.Settings['rage_aim'] == true) then
		// find closest target first
		local allply = player.GetAll()
        local plyDist = 100000
        local possibleTargets = {}
        local target
        for _,v in pairs(allply) do
        	table.insert(possibleTargets, v)

	        if (GetConVarNumber("rage_ignore_friends") == 1) then
	        	if (v:GetFriendStatus() != "none") then
	        		table.RemoveByValue(possibleTargets, v)
	        	end
	    	end

	    	if (!v:Alive()) then
	    		table.RemoveByValue(possibleTargets, v)
	    	end
   		end
	    for i = 1, #possibleTargets do
	        v = possibleTargets[i]
			if v:Alive() && v != LocalPlayer() then
	        	local plyDist2 = LocalPlayer():GetPos():Distance(v:GetPos())
	        	if plyDist2 < plyDist then
	           		plyDist = plyDist2
	           		target = v
	        	end
			end
		end

		if(target != nil) then

			local targetpos = target:GetBonePosition(target:LookupBone(D34D.Bones[GetConVarString("aim_bone")]))
			local shootpos = lp:GetShootPos()
			if (cmd:KeyDown(IN_ATTACK)) then
				print ("aim t: ".. target:Nick())
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

// gui - cmd to start is beefy_gui
concommand.Add("beefy_gui", function ()
	// Main Gui
	local p = vgui.Create("DFrame")
	p:SetTitle("D34DB33F")
	p:SetPos(50, ScrH() / 2 / 2)
	p:SetWidth(ScrW() - 100)
	p:SetHeight(ScrH() / 2)
	p:SetDraggable(false)
	p:MakePopup()
	p.Paint = function()
		draw.RoundedBox( 8, 0, 0, p:GetWide(), p:GetTall(), Color( 0, 0, 0, 150 ) )
	end

	// Hack Label
	local DLabel = vgui.Create( "DLabel", p )
	DLabel:SetPos( 25, 25 )
	DLabel:SetText( "WH etc" )

	// Door Hider
	local b1 = vgui.Create("DButton")
	b1:SetParent( p )
	b1:SetText( "Hide Doors" )
	b1:SetPos( 25, 50 )
	b1:SetSize( 75, 25 )
	b1.DoClick = function ()
    	RunConsoleCommand( "toggle_door" )
	end

	// Printer Hack
	local b2 = vgui.Create("DButton")
	b2:SetParent( p )
	b2:SetText( "Printer Hack" )
	b2:SetPos( 25, 100 )
	b2:SetSize( 75, 25 )
	b2.DoClick = function ()
    	RunConsoleCommand( "toggle_printer" )
	end

	local b7 = vgui.Create("DButton")
	b7:SetParent( p )
	b7:SetText( "Money Hack" )
	b7:SetPos( 25, 200 )
	b7:SetSize( 75, 25 )
	b7.DoClick = function ()
    	RunConsoleCommand( "toggle_money" )
	end

	// Printer Hack
	local b3 = vgui.Create("DButton")
	b3:SetParent( p )
	b3:SetText( "Player Xray" )
	b3:SetPos( 25, 150 )
	b3:SetSize( 75, 25 )
	b3.DoClick = function ()
    	RunConsoleCommand( "toggle_player" )
	end

	local b9 = vgui.Create("DButton")
	b9:SetParent( p )
	b9:SetText( "Rage Aimbot" )
	b9:SetPos( 25, 250 )
	b9:SetSize( 75, 25 )
	b9.DoClick = function ()
    	RunConsoleCommand( "toggle_rage" )
	end

	// Utility Label
	local l1 = vgui.Create( "DLabel", p )
	l1:SetPos( 150, 25 )
	l1:SetText( "Utility Hacks" )

	// Spammer
	local b4 = vgui.Create("DButton")
	b4:SetParent( p )
	b4:SetText( "Spammer" )
	b4:SetPos( 150, 50 )
	b4:SetSize( 75, 25 )
	b4.DoClick = function ()
		RunConsoleCommand("d_spam")
	end

	local t1 = vgui.Create("DTextEntry")
	t1:SetParent( p )
	t1:SetText(D34D.Settings['spam_def'])
	t1:SetPos( 150, 75 )
	t1:SetSize( 75, 20 )
	t1.OnEnter = function(self) 
		D34D.Settings['spam_def'] = t1:GetValue()
	end

	// Custom Crosshair
	local b5 = vgui.Create("DButton")
	b5:SetParent(p)
	b5:SetText("Crosshair")
	b5:SetPos( 150, 100 )
	b5:SetSize( 75, 25 )
	b5.DoClick = function ()
		RunConsoleCommand( "d_cross" )
	end

	// Aimbot toggle
	local b8 = vgui.Create("DButton")
	b8:SetParent( p )
	b8:SetText( "Rapidfire" )
	b8:SetPos( 150, 150 )
	b8:SetSize( 75, 25 )
	b8.DoClick = function ()
    	RunConsoleCommand( "toggle_rapid" )
	end

	// rainbow physgun toggle
	local b9 = vgui.Create("DButton")
	b9:SetParent( p )
	b9:SetText( "Rainbow Physgun" )
	b9:SetPos( 150, 200 )
	b9:SetSize( 125, 25 )
	b9.DoClick = function ()
    	RunConsoleCommand( "toggle_rainbow" )
	end


	// Settings panel
	local DermaListView = vgui.Create("DListView")
	DermaListView:SetParent(p)
	DermaListView:SetPos(ScrW() - 600, 25)
	DermaListView:SetSize(450, 400)
	DermaListView:SetMultiSelect(false)
	DermaListView:AddColumn("Player Name") -- Add column
	DermaListView:AddColumn("Kills")
	DermaListView:AddColumn("Deaths")
	DermaListView:AddColumn("Connection")

	for k,v in pairs(player.GetAll()) do
		DermaListView:AddLine(v:Nick(), v:Frags(), v:Deaths(), v:Ping())
	end

	local l2 = vgui.Create( "DLabel", p )
	l2:SetPos( ScrW() - 600 - 300, 25 )
	l2:SetSize(100, 25)
	l2:SetText( "Crosshair Color" )

	local Mixer = vgui.Create( "DColorMixer", p )
	Mixer:SetPos(ScrW() - 600 - 300, 50)
	Mixer:SetPalette( true ) 		--Show/hide the palette			DEF:true
	Mixer:SetAlphaBar( true ) 		--Show/hide the alpha bar		DEF:true
	Mixer:SetWangs( true )			--Show/hide the R G B A indicators 	DEF:true
	Mixer:SetColor( Color( 30, 100, 160 ) )	--Set the default color

	local b6 = vgui.Create("DButton")
	b6:SetParent(p)
	b6:SetText("Update")
	b6:SetPos( ScrW() - 600 - 300, 310 )
	b6:SetSize( 75, 25 )
	b6.DoClick = function ()
		D34D.Settings['cross_colour'] = Mixer:GetColor()
	end

	// Server / client info //
	local i1 = vgui.Create( "DLabel", p )
	i1:SetPos( ScrW() - 600 - 700, 25 )
	i1:SetSize(300, 25)
	i1:SetText( "SERVER / CLIENT INFO" )
	i1:SetColor(Color(255,0,0))
	local i2 = vgui.Create( "DLabel", p )
	i2:SetPos( ScrW() - 600 - 700, 50 )
	i2:SetSize(300, 25)
	i2:SetText( "Exploiting: " .. GetHostName() )
	local i3 = vgui.Create( "DLabel", p )
	i3:SetPos( ScrW() - 600 - 700, 75 )
	i3:SetSize(300, 25)
	i3:SetText( "Your visible name: " .. lp:Nick() )
	local i4 = vgui.Create( "DLabel", p )
	i4:SetPos( ScrW() - 600 - 700, 100 )
	i4:SetSize(300, 25)
	i4:SetText( "Your Steam name: " .. steamworks.GetPlayerName(lp:SteamID64()) )
	local i5 = vgui.Create( "DLabel", p )
	i5:SetPos( ScrW() - 600 - 700, 125 )
	i5:SetSize(300, 25)
	i5:SetText( "Host IP address: " .. game.GetIPAddress() )

	// copy info button
	local ib1 = vgui.Create("DButton")
	ib1:SetParent(p)
	ib1:SetText("Copy")
	ib1:SetPos( ScrW() - 600 - 700 - 75 - 5, 50 )
	ib1:SetSize( 75, 20 )
	ib1.DoClick = function ()
		SetClipboardText(GetHostName())
	end
	local ib2 = vgui.Create("DButton")
	ib2:SetParent(p)
	ib2:SetText("Copy")
	ib2:SetPos( ScrW() - 600 - 700 - 75 - 5, 75 )
	ib2:SetSize( 75, 20 )
	ib2.DoClick = function ()
		SetClipboardText(lp:Nick())
	end
	local ib3 = vgui.Create("DButton")
	ib3:SetParent(p)
	ib3:SetText("Copy")
	ib3:SetPos( ScrW() - 600 - 700 - 75 - 5, 100 )
	ib3:SetSize( 75, 20 )
	ib3.DoClick = function ()
		SetClipboardText(steamworks.GetPlayerName(lp:SteamID64()))
	end
	local ib4 = vgui.Create("DButton")
	ib4:SetParent(p)
	ib4:SetText("Copy")
	ib4:SetPos( ScrW() - 600 - 700 - 75 - 5, 125 )
	ib4:SetSize( 75, 20 )
	ib4.DoClick = function ()
		SetClipboardText(game.GetIPAddress())
	end
end)

// Spammer
hook.Add("RenderScene", "ChatSpammer",function ( )
	if (D34D.Settings['spam_on'] == true) then
		RunConsoleCommand("say", D34D.Settings['spam_def'])
	end
end)

// WH for many things
doormats = {}
hook.Add("RenderScene", "DoorHider", function ()
	if (D34D.Settings['DoorHider'] == true) then
		for k,v in pairs(ents.GetAll()) do
			class = string.lower(v:GetClass())
			if (string.match(class, "door")) then
				doormats[k] = v:GetMaterial()
				v:SetMaterial("Models/effects/vol_light001", true)
			end
		end
	else
		for k,v in pairs(ents.GetAll()) do
			class = string.lower(v:GetClass())
			if (string.match(class, "door")) then
				v:SetMaterial(doormats[k], true)
			end
		end
	end
end)

printermats = {}
hook.Add("RenderScene", "PrinterHack", function ()
	if (D34D.Settings['printer_show'] == true) then
		for k,v in pairs(ents.GetAll()) do
			class = string.lower(v:GetClass())
			if (string.match(class, "printer")) then
				printermats[k] = v:GetMaterial()
				v:SetMaterial("D34DB33F/xray.vmt", true)
				v:SetColor(Color(0,0,255))
				v:SetRenderMode(RENDERMODE_TRANSALPHA) 
			end
		end
	else
		for k,v in pairs(ents.GetAll()) do
			class = string.lower(v:GetClass())
			if (string.match(class, "printer")) then
				v:SetMaterial(printermats[k], true)
				v:SetColor(Color(255,255,255))
				v:SetRenderMode(RENDERMODE_NORMAL)
			end
		end
	end
end)

playermats = {}
hook.Add("RenderScene", "Xray", function ()
	if (D34D.Settings['Xray'] == true) then
		for k,v in pairs(player.GetAll()) do
			class = string.lower(v:GetClass())
			if (string.match(class, "player")) then
				if (v:Nick() != LocalPlayer():Nick()) then
					playermats[k] = v:GetMaterial()
					v:SetMaterial("D34DB33F/xray.vmt", true)
					v:SetColor(Color(255,0,0))
					v:SetRenderMode(RENDERMODE_TRANSALPHA)
				end
			end
		end
	else
		for k,v in pairs(player.GetAll()) do
			class = string.lower(v:GetClass())
			if (string.match(class, "player")) then
				v:SetMaterial(playermats[k], true)
				v:SetColor(Color(255,255,255))
				v:SetRenderMode(RENDERMODE_NORMAL)
			end
		end
	end
end)

propmats = {}
hook.Add("RenderScene", "PropFinder", function ()
	if (D34D.Settings['propHack'] == true) then
		for k,v in pairs(ents.GetAll()) do
			class = string.lower(v:GetClass())
			if (string.match(class, "prop")) then
				propmats[k] = v:GetMaterial()
				v:SetMaterial("D34DB33F/xray.vmt", true)
				v:SetColor(Color(0,255,0))
				v:SetRenderMode(RENDERMODE_TRANSALPHA)
			end
		end
	else
		for k,v in pairs(ents.GetAll()) do
			class = string.lower(v:GetClass())
			if (string.match(class, "prop")) then
				v:SetMaterial(propmats[k], true)
				v:SetColor(Color(255,255,255))
				v:SetRenderMode(RENDERMODE_NORMAL)
			end
		end
	end
end)

moneymats = {}
moneymsgsent = false
hook.Add("RenderScene", "MoneyFinder", function ()
	if (D34D.Settings['moneyHack'] == true) then
		if (moneymsgsent == false) then
			LocalConPrint("--------------------------------------");
		end
		for k,v in pairs(ents.GetAll()) do
			class = string.lower(v:GetClass())
			if (string.match(class, "money")) then
				moneymats[k] = v:GetMaterial()
				v:SetMaterial("D34DB33F/xray.vmt", true)
				v:SetColor(Color(0,255,0))
				v:SetRenderMode(RENDERMODE_TRANSALPHA)

				if (moneymsgsent == false) then
					LocalConPrint("Money detected at: ("..math.Round(v:GetPos().x).." : "..math.Round(v:GetPos().y).." : "..math.Round(v:GetPos().z)..")")
				end

				pos2d = (v:GetPos() + Vector(0,0,0)):ToScreen()
				draw.DrawText("MONEY", D34D.Font, pos2d.x,pos2d.y - 20, Color(255,255,255), 1)
			end
		end
		if (moneymsgsent == false) then
			LocalConPrint("--------------------------------------");
		end
		moneymsgsent = true
	else
		for k,v in pairs(ents.GetAll()) do
			class = string.lower(v:GetClass())
			if (string.match(class, "money")) then
				v:SetMaterial(moneymats[k], true)
				v:SetColor(Color(255,255,255))
				v:SetRenderMode(RENDERMODE_NORMAL)
			end
		end
	end
end)

hook.Add("HUDPaint", "cross", function ( )
	if (D34D.Settings['cross'] == true) then
		surface.SetDrawColor(D34D.Settings['cross_colour'])
		surface.DrawLine(ScrW() / 2 - 10, ScrH() / 2, ScrW() / 2 + 10, ScrH() / 2)
		surface.DrawLine(ScrW() / 2 , ScrH() / 2 - 10, ScrW() / 2 , ScrH() / 2 + 10)
	end
end)

function SetPhysgunRainbow( )
	if (D34D.Settings['rainbow_phys'] == true) then
		if (LocalPlayer():Alive()) then
			if (LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physgun") then
				local time = CurTime()
				local r = math.abs(math.sin(time * 0.5) * 255);
				local g = math.abs(math.sin(time * 0.5 + 2) * 255);
				local b = math.abs(math.sin(time * 0.5 + 4) * 255);
				lp:SetWeaponColor( Vector(r,g,b) )
			end
		end
	end
end
hook.Add("RenderScene", "rainbow_phys", SetPhysgunRainbow)

concommand.Add("toggle_rainbow", function ( )
	if (D34D.Settings['rainbow_phys'] == true) then
		D34D.Settings['rainbow_phys'] = false
		LocalChat("Rainbow Physgun off!")
	else
		D34D.Settings['rainbow_phys'] = true
		LocalChat("Rainbow Physgun on!")
	end
end)

concommand.Add("toggle_rage", function ( )
	if (D34D.Settings['rage_aim'] == true) then
		D34D.Settings['rage_aim'] = false
		LocalChat("Rage Aim off!")
	else
		D34D.Settings['rage_aim'] = true
		LocalChat("Rage Aim on!")
	end
end)

concommand.Add("d_spam", function ()
	if (D34D.Settings['spam_on'] == true) then
		D34D.Settings['spam_on'] = false
		LocalChat("Chat Spammer off!")
	else
		D34D.Settings['spam_on'] = true
		LocalChat("Chat Spammer on!")
	end
end)

concommand.Add("toggle_door", function ( )
	if (D34D.Settings['DoorHider'] == true) then
		D34D.Settings['DoorHider'] = false
		LocalChat("Door Hider off!")
	else
		D34D.Settings['DoorHider'] = true
		LocalChat("Door Hider on!")
	end
end)

concommand.Add("toggle_printer", function ( )
	if (D34D.Settings['printer_show'] == true) then
		D34D.Settings['printer_show'] = false
		LocalChat("Printer Hack off!")
	else
		D34D.Settings['printer_show'] = true
		LocalChat("Printer Hack on!")
	end
end)

concommand.Add("toggle_player", function ( )
	if (D34D.Settings['Xray'] == true) then
		D34D.Settings['Xray'] = false
		LocalChat("Player Xray off!")
	else
		D34D.Settings['Xray'] = true
		LocalChat("Player Xray on!")
	end
end)

concommand.Add("toggle_prop", function ( )
	if (D34D.Settings['propHack'] == true) then
		D34D.Settings['propHack'] = false
		LocalChat("Prop WH off!")
	else
		D34D.Settings['propHack'] = true
		LocalChat("Prop WH on!")
	end
end)

concommand.Add("toggle_money", function ( )
	if (D34D.Settings['moneyHack'] == true) then
		D34D.Settings['moneyHack'] = false
		LocalChat("Money WH off!")
	else
		D34D.Settings['moneyHack'] = true
		LocalChat("Money WH on!")
	end
end)

concommand.Add("d_cross", function ( )
	if (D34D.Settings['cross'] == true) then
		D34D.Settings['cross'] = false
		LocalChat("Crosshair off!")
	else
		D34D.Settings['cross'] = true
		LocalChat("Crosshair on!")
	end
end)

concommand.Add("d34d_beets_launch", function ( )
	beets_()
end)

concommand.Add("toggle_rapid", function ( )
	if (D34D.Settings['rapidfire'] == true) then
		D34D.Settings['rapidfire'] = false
		LocalChat("Rapid Fire off!")
	else
		D34D.Settings['rapidfire'] = true
		LocalChat("Rapid Fire on!")
	end
end)

concommand.Add("join_svr", function ( ply, cmd, args )
	local pserver = args[1];
	RunConsoleCommand("connect", pserver);
	// JoinServer( pserver ) MENU ONLY!
end)

concommand.Add("start_chat", function ( ply, cmd, args )
	Chat(false);
end)

concommand.Add("d34d_unload", function ()
	D34D.Settings['rapidfire'] 		= false; LocalConPrint("RapidFire off");
	D34D.Settings['bhop'] 			= false; LocalConPrint("Bhop off");
	D34D.Settings['esp']			= false; LocalConPrint("ESP off");
	D34D.Settings['esp_box'] 		= false; LocalConPrint("ESP Box off");
	D34D.Settings['aimbot'] 		= false; LocalConPrint("AimBot off");
	D34D.Settings['doorhider'] 		= false; LocalConPrint("DoorHider off");
	D34D.Settings['printer_show'] 	= false; LocalConPrint("Printer Hack off");
	D34D.Settings['Xray'] 			= false; LocalConPrint("Xray off");
	D34D.Settings['spam_on'] 		= false; LocalConPrint("Spammer off");
	D34D.Settings['cross'] 			= false; LocalConPrint("Crosshair off");
	D34D.Settings['rainbow_phys'] 	= false; LocalConPrint("Rainbow Physgun off");
	D34D.Settings['rage_aim'] 		= false; LocalConPrint("Rage Aim off");
	D34D.Settings['moneyHack'] 		= false; LocalConPrint("Money Hack off");
	D34D.Settings['propHack'] 		= false; LocalConPrint("Prop Hack off");
end)

--Load all chat commands (WIP)
RegisterChatCommand("!d34d", function (ply, args) 
	RunConsoleCommand("beefy_gui")
end, "topkek")

// if no errors then this will run
if CLIENT then
	LocalChat("D34DB33F Loaded, type 'beefy_gui' in console to launch the GUI.")
	LocalConPrint(D34D.Settings['title'])
	for k,v in pairs(D34D.Settings) do
		if (isbool(v)) then
			MsgC(Color(255,255,255), k .. " :: " .. tostring(v) .. "\n")
		end
	end
end

/* -- This Version -- /*
Words: 2,611
Characters: 26,224
*/ -- ------------ -- */