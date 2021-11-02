class CustomDoomPlayer : DoomPlayer 
{
	Default
	{
		Speed 0.8;
		Health 100;
		Radius 16;
		Height 56;
		Mass 100;
		PainChance 255;
		Player.DisplayName "CustomDoomPlayer";
		Player.CrouchSprite "PLYC";
		Player.MaxHealth 300;
		Player.StartItem "Pistol";
		Player.StartItem "Shotgun";
		Player.StartItem "Fist";
		Player.StartItem "Clip", 50;
		Player.WeaponSlot 1, "Fist", "Chainsaw";
		Player.WeaponSlot 2, "Pistol";
		Player.WeaponSlot 3, "Shotgun", "SuperShotgun";
		Player.WeaponSlot 4, "Chaingun";
		Player.WeaponSlot 5, "RocketLauncher";
		Player.WeaponSlot 6, "PlasmaRifle";
		Player.WeaponSlot 7, "BFG9000";
		
		Player.ColorRange 112, 127;
		Player.Colorset 0, "$TXT_COLOR_GREEN",		0x70, 0x7F,  0x72;
		Player.Colorset 1, "$TXT_COLOR_GRAY",		0x60, 0x6F,  0x62;
		Player.Colorset 2, "$TXT_COLOR_BROWN",		0x40, 0x4F,  0x42;
		Player.Colorset 3, "$TXT_COLOR_RED",		0x20, 0x2F,  0x22;
		// Doom Legacy additions
		Player.Colorset 4, "$TXT_COLOR_LIGHTGRAY",	0x58, 0x67,  0x5A;
		Player.Colorset 5, "$TXT_COLOR_LIGHTBROWN",	0x38, 0x47,  0x3A;
		Player.Colorset 6, "$TXT_COLOR_LIGHTRED",	0xB0, 0xBF,  0xB2;
		Player.Colorset 7, "$TXT_COLOR_LIGHTBLUE",	0xC0, 0xCF,  0xC2;
	}

	override
	void BeginPlay() {
		Super.BeginPlay();
		// Setting up the chasecam 
		A_GiveInventory("CameraRunner");
	}

	States
	{
	Spawn:
		MAR1 ABC 14;
		Loop;
	Idle:
		MAR1 ABC 5;
		Loop;
	See:
		MAR1 DFG 6;
		Loop;
	Running:
		MAR1 HIJ 6;
		Loop;
	Missile:
		MAR1 L 14 BRIGHT;
		Goto Spawn;
	Melee:
		MAR1 L 14 BRIGHT;
		Goto Missile;
	Pain:
		MAR1 ABC 14;
		Goto Spawn;
	Death:
		MAR1 K -1;
	Death1:
		MAR1 K -1;
	XDeath:
		MAR1 K -1;
	XDeath1:
		MAR1 K -1;
	AltSkinDeath:
		MAR1 K -1;
	AltSkinXDeath:
		MAR1 K -1;
	}
}