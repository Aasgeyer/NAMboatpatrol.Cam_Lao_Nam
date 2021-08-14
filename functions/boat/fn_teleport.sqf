If (!IsServer) exitWith {};

params ["_teleporter"];

[
	_teleporter,											// Object the action is attached to
	"Teleport into boat",										// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 5 && alive b_boat",						// Condition for the action to be shown
	"_caller distance _target < 5 && alive b_boat",						// Condition for the action to progress
	{ // Code executed when action starts
        params ["_target", "_caller", "_actionId", "_arguments"];
        _target directSay "teleport_start";
    },													
	{},													// Code executed on every progress tick
	{ // Code executed on completion
        params ["_target", "_caller", "_actionId", "_arguments"];
        _target directSay "teleport_go";
        _caller moveInCargo b_boat;
    },				
	{ // Code executed on interrupted
        params ["_target", "_caller", "_actionId", "_arguments"];
        _target directSay "teleport_cancel";
    },													
	[],													// Arguments passed to the scripts as _this select 3
	4,													// Action duration [s]
	0,													// Priority
	false,												// Remove on completion
	false												// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, _teleporter];	// MP compatible implementation