If (!isServer) exitWith {};

params ["_boat"];

[
    _boat,
    "Field Repair",
    "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa",
    "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa",
    "_this in _target && 'vn_b_item_toolkit' in items _this && damage _target > 0.25",
    "_this in _target && 'vn_b_item_toolkit' in items _this && damage _target > 0.25",
    {},
    {
        //Code Progress
        params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
        titleText [format ["Repairing... %1%2",round (_progress/_maxProgress*100),"%"], "PLAIN DOWN"];
    },
    {
        //Code Completed
        params ["_target", "_caller", "_actionId", "_arguments"];
        _target setDamage 0.25;
        If (fuel _target < 0.1) then {_target setFuel 0.25};
    },
    {
        //Code Interrupted
        titleText ["Repairing interrupted!", "PLAIN DOWN"];
    },
    [],
    24,
    99,
    false,
    false,
    true
] call BIS_fnc_holdActionAdd;