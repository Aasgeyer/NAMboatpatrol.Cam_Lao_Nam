class greet_engineer_dock
	{
		// how the sound is referred to in the editor (e.g. trigger effects)
		name = "";

		// filename, volume, pitch, distance (optional)
		sound[] = { "", db - 100, 1.0 };

		// subtitle delay in seconds, subtitle text
		title = "Hey man. I got some spare Toolkits with me. Just take them from my backpack if y'all need them.";
	};


class teleport_start
	{
		name	= "teleport_start";
		sound[]	= { "", db - 100, 1.0 }; // .wss implied
		title	= "Preparing for deployment.";
	};
class teleport_go
	{
		name	= "teleport_go";
		sound[]	= { "", db - 100, 1.0 }; // .wss implied
		title	= "Deploying.";
	};
class teleport_cancel
	{
		name	= "teleport_cancel";
		sound[]	= { "", db - 100, 1.0 }; // .wss implied
		title	= "Deployment canceled.";
	};