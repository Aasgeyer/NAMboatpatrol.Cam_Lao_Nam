If (!isServer) exitWith {};

params ["_boat"];
//create addaction on boat for vehicle radio
[
    _boat, ["Vehicle Radio",
    "params ['_target', '_caller', '_actionId', '_arguments'];
    ['open'] call vn_fnc_music;",
    nil,1.5,false,true, "", 
    "_this in _target",
    5,false, "", ""]
] remoteExec ["addaction"];