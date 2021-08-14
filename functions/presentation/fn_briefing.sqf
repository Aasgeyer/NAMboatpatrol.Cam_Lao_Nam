params ["_playerUnit"];

private _briefText = "Field repair: If boat is damaged go to a passenger seat, toolkit required!<br/>
Field treatment: If you are wounded go to a passenger seat, first aid kit required!<br/>
In Multiplayer: If you respawn at base at the HQ there is an officer with an action to teleport you back into the boat.";
_playerUnit createDiaryRecord ["Diary", ["Hints",_briefText]];

private _briefText = "Slick-1 - Nasty Boat (your squad)<br/>
Brimstone - HQ<br/>
Carver - Mortar Team<br/>
Alpha 1-2 - team at the <marker name='marker_7'>dock</marker><br/>
CP - Checkpoint";
_playerUnit createDiaryRecord ["Diary", ["Signal",_briefText]];

private _briefText = "1. Gear up and get in the boat.<br/>
2. Pass CP 1 to 3.<br/>
3. Reach the <marker name='marker_0'>Patrol End</marker>.<br/>
4. Deliver the supplies to the <marker name='marker_7'>dock</marker>.";
_playerUnit createDiaryRecord ["Diary", ["Execution",_briefText]];

private _briefText = "Deliver the supplies and engage any enemies along the way!";
_playerUnit createDiaryRecord ["Diary", ["Mission",_briefText]];

private _briefText = "Enemy forces of the <marker name='marker_3'>PAVN</marker> in company size are being pushed back
 half a kilometer south of Attapeu. Along the <marker name='marker_river'>Mekong</marker> between Kiem Tra and Bi Mat
 the Viet Cong employ guerilla tactics to disrupt the supply lines.<br/>
<marker name='marker_4'>Friendly forces</marker> of 2nd Battalion, 3rd Marines
 are advancing towards Attapeu.
 They are currently holding hill 75 against an enemy counter offensive.
 Your team is stationed at the <marker name='respawn_west'>FSB Quan Loi</marker> with one boat of the Nasty class
 filled with supplies for the frontline.<br/>
You have support from mortar team Carver at th FSB at your disposal. It is limited to 12 HE, 32 Smoke and 32 Lume rounds.";
_playerUnit createDiaryRecord ["Diary", ["Situation",_briefText]];

