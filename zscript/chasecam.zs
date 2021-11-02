// Script originally created by Cacodemon345 (Zdoom Forums)
// This is a modified version by RederickDeathwill (Zdoom Forums)

const C_TID	= 1000;

class InvisiblePuffAlways : Actor
{
	Default
	{
		-ALLOWPARTICLES
		+ALWAYSPUFF
		+THRUACTORS
		+ALLOWTHRUFLAGS
	}
}
class ChaseCam2 : Actor
{
	Default
	{
		+NOCLIP
		+NOINTERACTION
		+NOGRAVITY
		Radius 0;
		Height 16;
	}
	States
	{
	Spawn:
		TNT1 A -1;
		Stop;
	}
}
class CameraRunner : Inventory
{
	static bool, Actor CheckForCamera(class<Actor> classname,int tidnum)
	{
		ActorIterator at = ActorIterator.Create(tidnum);
		Actor a = at.Next();
		if (a != NULL && a.GetClassName() == classname) return true, a;
		return false, null;
	}
	static void SetActorAngle(int tidnum, double angle)
	{
		ActorIterator at = ActorIterator.Create(tidnum);
		Actor a = at.Next();
		if (a != NULL) a.angle = angle;
	}
	static void SetActorPitch(int tidnum, double pitch)
	{
		ActorIterator at = ActorIterator.Create(tidnum);
		Actor a = at.Next();
		if (a != NULL) a.pitch = pitch;
	}
	static void SetActorRoll(int tidnum, double roll)
	{
		ActorIterator at = ActorIterator.Create(tidnum);
		Actor a = at.Next();
		if (a != NULL) a.roll = roll;
	}
	static bool, Actor ExtSpawn(class<Actor> classname,Vector3 pos,int tid,double angle)
	{
		Actor a = Spawn(classname,pos,ALLOW_REPLACE);
		if (a != NULL)
		{
			a.ChangeTid(tid);
			a.angle = angle;
			return true, a;
		}
		return false, null;
	}
	static bool SetActorPosition(int tidnum, Vector3 pos)
	{
		bool boolean;
		Actor a;
		[boolean, a] = CheckForCamera("ChaseCam2",tidnum);
		if (a != NULL)
		{
			a.SetOrigin(pos,true);
			if (a.pos == pos) return true;
		}
		return false;
	}
	void TerminateCamera()
	{
		owner.SetCamera(null);
		bool boolean;
		actor a;
		[boolean, a] = CheckForCamera("ChaseCam2",C_TID + PlayerPawn(owner).PlayerNumber());
		if (a != NULL) a.Destroy();
	}
	Vector3, double, double ReturnCamPos(Actor a)
	{
        // Getting the precise crosshair custom EventHandler
        // in order to access custom global variables
        pc_EventHandler Event = pc_EventHandler(EventHandler.Find("pc_EventHandler"));
        int playerAngle = Event.playerAngle;
        int cameraDistance = Event.cameraDistance;
    
		Actor linepuff = a.LineAttack(a.angle - playerAngle,cameraDistance + (a.radius*2),-a.pitch,0,'None',"InvisiblePuffAlways",LAF_NOINTERACT|LAF_NORANDOMPUFFZ,null,-(a.height/2) + a.player.viewheight);
		if (linepuff)
		{
			let vec3 = linepuff.pos;
			let anglevalue = linepuff.angle;
			let pitchvalue = linepuff.pitch;
			linepuff.Destroy();
			return vec3, anglevalue, pitchvalue;
		}
		return a.pos, a.angle, a.pitch;
	}
	void RunCameraNew()
	{
		if (!owner.player || !owner) return; //Don't start camera if the owner isn't a player or if nothing owns the inventory.
		Double anglevalue, pitchvalue;
		Double actualpitch = owner.pitch;
		Vector3 campos;
		int plrnum = PlayerPawn(owner).PlayerNumber();
		[campos, anglevalue, pitchvalue] = ReturnCamPos(owner);
		if (!CheckForCamera("ChaseCam2",C_TID + plrnum))
		{
			
			pc_EventHandler Event = pc_EventHandler(EventHandler.Find("pc_EventHandler"));
			[Event.cameraSpawned, Event.cameraActor] = self.ExtSpawn ("ChaseCam2", campos, C_TID+plrnum, angle);
			if (CheckForCamera ("ChaseCam2", C_TID + plrnum))
			owner.SetCamera(Event.cameraActor);
			else
			{
				Console.MidPrint ("INDEXFONT_DOOM","Camera script failed to initialize.");
				return;
			}
		}
		else
		{
			while (!SetActorPosition(C_TID + plrnum, campos))
			{
			}
			self.SetActorAngle (C_TID + plrnum, anglevalue);
			self.SetActorPitch (C_TID + plrnum, actualpitch);
			self.SetActorRoll  (C_TID + plrnum, owner.roll);
		}
	}
	override void AttachToOwner(Actor other)
	{
		Super.AttachToOwner(other);
		if (owner)
		{
			self.RunCameraNew();
		}
	}
	override void DoEffect()
	{
		let p = PlayerPawn(owner);
		if (p)
		{
			self.RunCameraNew();
		}
	}
	override void OnDestroy()
	{
		let p = PlayerPawn(owner);
		if (p)
		{
			self.TerminateCamera();
		}
		Super.OnDestroy();
	}
}