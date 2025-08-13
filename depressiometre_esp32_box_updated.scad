
// Boîtier dépressiomètre ESP32 avec écran TFT 3.5", boutons, USB, SD et 4 capteurs en haut

$fn = 60;

// Dimensions générales
boitier_largeur = 120;
boitier_hauteur = 80;
boitier_profondeur = 35;

// Épaisseur des parois
epaisseur = 3;

// Découpe écran
ecran_largeur = 85;
ecran_hauteur = 55;
ecran_x = (boitier_largeur - ecran_largeur) / 2;
ecran_y = 15;

// Boutons sous l'écran
bouton_diametre = 6;
bouton_espacement = 20;
bouton_y = ecran_y + ecran_hauteur + 10;
bouton_x_start = (boitier_largeur - 2 * bouton_espacement) / 2;

// Fente USB en dessous
usb_largeur = 12;
usb_hauteur = 6;
usb_x = (boitier_largeur - usb_largeur) / 2;
usb_y = 5;

// Fente carte SD sur le côté droit
sd_largeur = 18;
sd_hauteur = 3;
sd_x = boitier_largeur - epaisseur;
sd_y = boitier_hauteur / 2;

// Trous capteurs sur le dessus
capteur_diametre = 8;
capteur_espacement = 20;
capteur_x_start = (boitier_largeur - 3 * capteur_espacement) / 2;
capteur_y = boitier_hauteur - epaisseur;

module boitier() {
    difference() {
        // Corps principal
        cube([boitier_largeur, boitier_hauteur, boitier_profondeur]);

        // Creux intérieur
        translate([epaisseur, epaisseur, epaisseur])
            cube([boitier_largeur - 2*epaisseur, boitier_hauteur - 2*epaisseur, boitier_profondeur - epaisseur]);

        // Découpe écran
        translate([ecran_x, ecran_y, -1])
            cube([ecran_largeur, ecran_hauteur, epaisseur + 2]);

        // Boutons
        for (i = [0:2]) {
            translate([bouton_x_start + i*bouton_espacement, bouton_y, -1])
                cylinder(h = epaisseur + 2, r = bouton_diametre/2);
        }

        // Fente USB
        translate([usb_x, 0, 5])
            cube([usb_largeur, epaisseur + 1, usb_hauteur]);

        // Fente carte SD
        translate([sd_x, sd_y, 10])
            rotate([0,90,0])
                cube([sd_largeur, epaisseur + 1, sd_hauteur]);

        // Trous capteurs sur le dessus
        for (i = [0:3]) {
            translate([capteur_x_start + i*capteur_espacement, capteur_y, boitier_profondeur - 5])
                rotate([90,0,0])
                    cylinder(h = epaisseur + 2, r = capteur_diametre/2);
        }
    }
}

boitier();
