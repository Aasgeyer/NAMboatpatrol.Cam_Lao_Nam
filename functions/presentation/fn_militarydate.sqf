// DDHHMM(Z)MONYY

// [year, month, day, hour, minute]
date params ["_year", "_month", "_day", "_hour", "_minute"];
//convert month
_yearstr = (str _year) select [2];
_monthstr = switch (_month) do {
    case 1: {"JAN"};
    case 2: {"FEB"};
    case 3: {"MAR"};
    case 4: {"APR"};
    case 5: {"MAI"};
    case 6: {"JUN"};
    case 7: {"JUL"};
    case 8: {"AUG"};
    case 9: {"SEP"};
    case 10: {"OCT"};
    case 11: {"NOV"};
    case 12: {"DEC"};
};
//convert day
_daystr = format ["%1%2", ["","0"] select (_day < 10), _day];
//convert hour
_hourstr = format ["%1%2", ["","0"] select (_hour < 10), _hour];
//convert minute
_minutestr = format ["%1%2", ["","0"] select (_minute < 10), _minute];
//find timezone (only vanilla maps supported)
_timezone = switch (tolower worldname) do {
    case "altis": {"B"};
    case "enoch": {"B"};
    case "malden": {"N"};
    case "stratis": {"B"};
    case "tanoa": {"M"};
    case "cam_lao_nam": {"G"};
    default {"Z"};
};

// DDHHMM(Z)MONYY
_militarydatestr = format ["%1%2%3%4%5%6",_daystr,_hourstr,_minutestr,_timezone,_monthstr,_yearstr];

//return
_militarydatestr