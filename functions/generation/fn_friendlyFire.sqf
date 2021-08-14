If (!isServer) exitWith {};

private _friendlyUnits = allUnits select {
    side _x == west
    && !(_x in units b_playergroup)
};

_friendlyUnits apply {
    _x addEventHandler ["Killed",{
        params ["_unit", "_killer", "_instigator", "_useEffects"];
        If (isPlayer _killer) then {
            AAS_friendlyFireKill = true; 
            publicVariableServer "AAS_friendlyFireKill";
        };
    }];
};