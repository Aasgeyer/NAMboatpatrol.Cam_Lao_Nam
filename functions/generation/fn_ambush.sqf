If (!isServer) exitWith {};

//get all ambush markers
private _ambushMarkerArray = ["marker_ambush_"] call BIS_fnc_getMarkers;

//parnet task for group elimination
private _task_parent = [
    west, "Tsk_AmbGrp_Parent",
    ["Enemy Guerillas have been harrasing our supply lines. On your way to deliver the supplies, engage any enemy forces along the way. It is sufficient to eliminate around 80% of the group","Engage Enemy Groups",""],
    objNull, "CREATED", 0, false, "attack"
] call BIS_fnc_taskCreate;
{
    //find suitable position for group
    private _shorepos = [markerpos _x, 0, selectMax markerSize _x, 2, 0, 0.0, 1] call BIS_fnc_findSafePos;
    private _ambushpos = selectBestPlaces [_shorepos, 25, "forest+trees-5*hills", 2.5, 1];
    _ambushpos = (_ambushpos#0)#0;
    _ambushpos pushBack 0;
    If (AAS_debugMode) then {
        private _ambushposmarker = createMarker [format ["markerambush_%1",_ambushpos],_ambushpos];
        _ambushposmarker setMarkerType "o_inf";
        systemChat str _ambushpos;
    };
    //create the enemy group with a balanced number of units depending on player count or SP
    //_grpcfg = (configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_local" >> (format ["vn_o_group_men_vc_local_0%1",selectRandom [1,2]]));
    private _numberofunits = [8,linearConversion [0,8,count units b_playerGroup,2,16]] select isMultiplayer;
    private _ambushGroup = createGroup [east,true];
    _ambushGroup enableDynamicSimulation true;
    If (isNil "EnemyAmbushGroupArray") then {EnemyAmbushGroupArray = [];};
    EnemyAmbushGroupArray pushBack _ambushGroup;
    _ambushGroup setBehaviour "COMBAT";
    missionNamespace setVariable [format ["AAS_ambushGroup_%1",_foreachindex+1], _ambushGroup];
    
    //"vn_o_men_vc_local_32";
    //create single units of the group
    for "_u" from 1 to _numberofunits do {
        private _vcNumber = ceil random 32;
        //put a 0 before numbers smaller 10
        private _zeroorno = ["",0] select (_vcNumber < 10);
        private _className = format ["vn_o_men_vc_local_%2%1",_zeroorno,_vcNumber];
        private _createdUnit = _ambushGroup createUnit [_className, _ambushpos, [], 25, "NONE"];
        doStop _createdUnit;
        private _watchDir = (_ambushpos getDir markerpos _x);
        _createdUnit setdir _watchDir;
        _createdUnit setFormDir _watchDir;
    };
    missionNamespace setVariable [format ["AAS_groupInitialStrength_%1",_foreachindex+1], count units _ambushGroup];
    private _wp = _ambushGroup addWaypoint [_ambushpos getpos [2,_ambushpos getdir markerpos _x],0];

    //task for eliminating single group
    private _descr_task = format ["Eliminate the group around mapgrid %1 or drive them out of the area.", mapGridPosition markerpos _x];
    private _task_grp = [
        west, [format ["Tsk_AmbGrp_%1",groupId _ambushGroup],"Tsk_AmbGrp_Parent"],
        [_descr_task,format ["Enemy Group #%1",_foreachindex+1],""],
        markerpos _x, "CREATED", 100-_foreachindex, false, "attack"
    ] call BIS_fnc_taskCreate;

    //create the trigger for task completion
    private _trg = createTrigger ["EmptyDetector", _ambushpos];
    _trg setTriggerArea [75, 75, 0, false];
    _trg setTriggerActivation ["EAST", "NOT PRESENT", false];
    //sufficient to bring group below 20% of initial strength
    //{!fleeing && alive} count units _enemyGrp_1 < ceil (_intialStrength_1*0.2)
    private _trgCond = format ["this OR ({!fleeing _x && alive _x} count units AAS_ambushGroup_%1 < AAS_groupInitialStrength_%1*0.2)", _foreachindex+1];
    private _trgAct = format ["[%1, 'SUCCEEDED', true] call BIS_fnc_taskSetState;", str _task_grp];
    _trg setTriggerStatements [_trgCond, _trgAct, ""];
    _trg setTriggerTimeout [10, 15, 30, true];
    missionNamespace setVariable [format ["Trg_ambushGrp_%1",_foreachindex+1],_trg];
    If (isNil "AAS_trgArray") then {AAS_trgArray = [];};
    AAS_trgArray pushBack _trg;

} forEach _ambushMarkerArray;

publicVariable "EnemyAmbushGroupArray";
