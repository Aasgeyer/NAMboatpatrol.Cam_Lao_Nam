If (!isServer) exitWith {};

params ["_boat"];

[
    _boat,
    "Treat Wounds",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",
    "_this in (fullCrew [_target, 'cargo', false] apply {_x#0}) && 'vn_b_item_firstaidkit' in items _this && damage _this > 0.25",
    "_this in (fullCrew [_target, 'cargo', false] apply {_x#0}) && 'vn_b_item_firstaidkit' in items _this && damage _this > 0.25",
    {},
    {
        //Code Progress
        params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
        titleText [format ["Healing... %1%2",round (_progress/_maxProgress*100),"%"], "PLAIN DOWN"];
    },
    {
        //Code Completed
        params ["_target", "_caller", "_actionId", "_arguments"];
        _caller setDamage 0.25;
        _caller removeItem "vn_b_item_firstaidkit";
    },
    {
        //Code Interrupted
        titleText ["Healing interrupted!", "PLAIN DOWN"];
    },
    [],
    12,
    99,
    false,
    false,
    true
] call BIS_fnc_holdActionAdd;