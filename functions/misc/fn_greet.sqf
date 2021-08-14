If !(isServer) exitWith {};
params ["_unit"];
_unit lockInventory true;
[_unit, 
    [
        "Greet",
        "params ['_target', '_caller', '_actionId', '_arguments'];
        _target directSay 'greet_engineer_dock';
        _target lockInventory false;
        ""[_target, _actionId] remoteexec ['removeAction']"";",
        nil,1.5,false,false, "", "true",5,false, "", ""
    ]
] remoteExec ["addaction"];
