
// Dépressiomètre ESP32 - Boîtier OpenSCAD
// Auteur : Copilot
// Écran TFT 3.5" ILI9488, ESP32-S3, boutons, SD, USB, inserts filetés

$fn = 60;

// Dimensions générales
boitier_largeur = 120;
boitier_hauteur = 80;
boitier_profondeur = 35;
epaisseur_paroi = 3;

// Découpe écran (centré)
ecran_largeur = 85;
ecran_hauteur = 55;
ecran_profondeur = 3;

// Boutons (3 sous l'écran)
bouton_diametre = 6;
bouton_espacement = 20;
bouton_y = 15;

// Fente carte SD (côté droit)
sd_largeur = 14;
sd_hauteur = 3;

// USB (dessous)
usb_largeur = 12;
usb_hauteur = 5;

// Inserts filetés (coins)
insert_diametre = 4;
insert_offset = 6;

module boitier() {
    difference() {
        // Boîtier principal
        cube([boitier_largeur, boitier_hauteur, boitier_profondeur]);

        // Creux intérieur
        translate([epaisseur_paroi, epaisseur_paroi, epaisseur_paroi])
            cube([boitier_largeur - 2*epaisseur_paroi,
                  boitier_hauteur - 2*epaisseur_paroi,
                  boitier_profondeur]);

        // Découpe écran
        translate([(boitier_largeur - ecran_largeur)/2,
                   (boitier_hauteur - ecran_hauteur)/2 + 10,
                   0])
            cube([ecran_largeur, ecran_hauteur, ecran_profondeur + 1]);

        // Boutons
        for (i = [-1, 0, 1]) {
            translate([(boitier_largeur/2) + i*bouton_espacement - bouton_diametre/2,
                       bouton_y,
                       0])
                cylinder(h = 5, d = bouton_diametre);
        }

        // Fente carte SD (côté droit)
        translate([boitier_largeur - 1,
                   boitier_hauteur/2 - sd_largeur/2,
                   10])
            rotate([0,90,0])
                cube([sd_hauteur, sd_largeur, 10]);

        // USB (dessous)
        translate([boitier_largeur/2 - usb_largeur/2,
                   -1,
                   5])
            cube([usb_largeur, 1.5, usb_hauteur]);

        // Inserts filetés (4 coins)
        for (x = [insert_offset, boitier_largeur - insert_offset])
            for (y = [insert_offset, boitier_hauteur - insert_offset])
                translate([x, y, boitier_profondeur - 5])
                    cylinder(h = 6, d = insert_diametre);
    }
}

boitier();
