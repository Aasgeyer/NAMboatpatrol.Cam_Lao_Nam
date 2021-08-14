params ["_mortar"];

//["vn_mortar_m29_mag_he_x8","vn_mortar_m29_mag_he_x8","vn_mortar_m29_mag_he_x8","vn_mortar_m29_mag_he_x8","vn_mortar_m29_ma_he_x8","vn_mortar_m29_mag_he_x8","vn_mortar_m29_mag_wp_x8","vn_mortar_m29_mag_wp_x8","vn_mortar_m29_mag_chem_x8","vn_mortar_m29_mag_chem_x8","vn_mortar_m29_mag_lume_x8","vn_mortar_m29_mag_lume_x8"]
//["vn_mortar_m29_mag_he_x8","vn_mortar_m29_mag_wp_x8","vn_mortar_m29_mag_chem_x8","vn_mortar_m29_mag_lume_x8"]

(_mortar magazinesTurret [0]) apply {
    _mortar removeMagazinesTurret [_x,[0]];
};

_mortar addMagazineTurret ["vn_mortar_m29_mag_he_x8", [0], 6];
for "_a" from 1 to 2 do {
    _mortar addMagazineTurret ["vn_mortar_m29_mag_lume_x8", [0], 8];
    _mortar addMagazineTurret ["vn_mortar_m29_mag_chem_x8", [0], 8];
};