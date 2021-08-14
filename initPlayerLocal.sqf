[player] call AAS_fnc_briefing;

waitUntil {alive player};

sleep 2;
private _milDate = [] call AAS_fnc_militaryDate;
private _groupID = groupId group player;
private _textToDisplay = format ["<t font='PuristaBold' size='1.6'>%1</t><br />by Aasgeyer",briefingName];
private _textTiles = [parseText _textToDisplay, true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;
private _textToDisplay = format ["<t font='PuristaBold' size='1.0'>%1</t><br />%2<br />%3",worldName,_milDate,_groupID];
waitUntil {scriptDone _textTiles};
private _textTiles = [parseText _textToDisplay, true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;