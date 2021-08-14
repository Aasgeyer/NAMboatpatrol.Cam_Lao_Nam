If (!isServer) exitWith {};

//get markers of ambush
private _ambushMarkerArray = ["marker_ambush_"] call BIS_fnc_getMarkers;
//don't want units to spawn in there
private _blacklistBuildings = ["Land_vn_o_tower_01","Land_vn_o_tower_02","Land_vn_o_tower_03"];
{
    private _nearbuildings = markerpos _x nearObjects ["House",selectMax markerSize _x];
    _nearbuildings = _nearbuildings select {
        count (_x buildingPos -1) > 2
        && !(typeOf _x in _blacklistBuildings)
    };
    private _listBuildingPos = [];
    _nearbuildings apply {
        _listBuildingPos append (_x buildingPos -1)
    };
    _listBuildingPos = _listBuildingPos call BIS_fnc_arrayShuffle;

    //"vn_c_men_32"
    //spawn in 5% of houses units
    for "_u" from 1 to (ceil ((count _listBuildingPos)*0.05)) do {
        private _cNumber = ceil random 32;
        private _zeroorno = ["",0] select (_cNumber < 10);
        private _className = format ["vn_c_men_%2%1",_zeroorno,_cNumber];
        private _civPos = _listBuildingPos#_u;
        If (AAS_debugMode) then {
            _civposmarker = createMarker [format ["markerciv_%1",_civPos],_civPos];
            _civposmarker setMarkerTypeLocal "c_unknown";
            _civposmarker setMarkerColorLocal "ColorCivilian";
            _civposmarker setMarkerSizeLocal [0.5,0.5];
        };
        private _civGroup = createGroup [civilian,true];
        _civGroup enableDynamicSimulation true;
        //make unit patrol, if not on building over water. Otherwise static.
        If (!surfaceIsWater _civPos && random 1 < 0.65) then {
            private _posaround = _civPos vectorAdd [random [-25,0,25],random [-25,0,25],0];
            _posaround set [2,0];
            private _createdUnit = _civGroup createUnit [_className, _posaround, [], 0, "CAN_COLLIDE"];
            [_civGroup,_civPos,50] call BIS_fnc_taskPatrol;
            If (AAS_debugMode) then {_civposmarker setMarkerText "Patrol";};
        } else {
            private _createdUnit = _civGroup createUnit [_className, _civPos, [], 0, "CAN_COLLIDE"];
            removeBackpackGlobal _createdUnit;
            If (AAS_debugMode) then {_civposmarker setMarkerText "Static";};
            doStop _createdUnit;
            private _watchDir = random 360;
            _createdUnit setdir _watchDir;
            _createdUnit setFormDir _watchDir;
        };
    };
} forEach _ambushMarkerArray;

//spawn boats on the river
private _boatpool = [
    "vn_c_boat_01_00", "vn_c_boat_02_00", "vn_c_boat_08_02", 
    "vn_c_boat_08_01", "vn_c_boat_07_02", "vn_c_boat_07_01"
];
//_rivermarker = "marker_river";
//5 boats to spawn
for "_b" from 1 to 5 do {
    //pos on water, not in building and deep enough water
    private _waterpos = [
        ["marker_river"],
        ["ground"],
        {
            _nearbuildings = _this nearObjects ["House",200];
            {
                count (_x buildingPos -1) > 2
            } count _nearbuildings > 0
            && abs (getTerrainHeightASL _this) > 5
        }
    ] call BIS_fnc_randomPos;
    //destiantion of the boat, deep enough water
    private _destinationWater = [
        ["marker_river"],
        ["ground", [_waterpos, 400]],
        {
            abs (getTerrainHeightASL _this) > 5
        }
    ] call BIS_fnc_randomPos;
    //create boat
    private _vehicleArray = [_waterpos, _waterpos getDir _destinationWater, selectRandom _boatpool, civilian] call BIS_fnc_spawnVehicle;
    _vehicleArray params ["_boatCreated","_crew","_boatGroup"]; 
    //slow down, otherwise will ram into bends
    _boatGroup setSpeedMode "LIMITED";
    //create passengers
    private _nrEmptySeats = _boatCreated emptyPositions "cargo";
    for "_b" from 1 to (ceil random [1,_nrEmptySeats*0.25, _nrEmptySeats]) do {
        private _cNumber = ceil random 32;
        private _zeroorno = ["",0] select (_cNumber < 10);
        private _className = format ["vn_c_men_%2%1",_zeroorno,_cNumber];
        private _createdUnit = _boatGroup createUnit [_className, [0,0,0], [], 0, "CAN_COLLIDE"];
        _createdUnit moveInAny _boatCreated;
    };
    //static or patrolling
    If (random 1 < 0.75) then {
        private _wpmove = _boatGroup addWaypoint [_destinationWater,20];
        //on reaching waypoint turn ship
        _wpmove setWaypointStatements ["true","vehicle this setdir (getdir vehicle this - 180)"];
        private _wpcycle = _boatGroup addWaypoint [_waterpos, 20];
        _wpcycle setWaypointType "CYCLE";
        _wpcycle setWaypointStatements ["true","vehicle this setdir (getdir vehicle this - 180)"];
    };

};