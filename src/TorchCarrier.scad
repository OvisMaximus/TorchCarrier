dTorch = 36.5;
dHead = 41.6;
hRing = 12;
lWall = 2.3;
lEar = 3.0;

module endOfConfig() {}

$fn = 250;
cadFix = 0.005;

dRingOutside = dHead + 2*lWall;

module ring() {
    difference() {
        cylinder(hRing, d = dRingOutside);
        translate([0, 0, - cadFix])
            cylinder(hRing + 2 * cadFix, d1 = dTorch, d2 = dHead);
    }
}

module ear(xOffset) {
    module earSolid() {
        cylinder(lEar, d = hRing);
        translate([0, - hRing / 2, 0])
            cube([hRing / 2, hRing, lEar]);
    }
    module earRaw() difference() {
        earSolid();
        translate([0, 0, - cadFix])
            cylinder(lEar + 2 * cadFix, d = hRing / 2);
    }
    xPosNeutral = hRing / 2;
    translate([xPosNeutral+xOffset, lEar/2, hRing / 2])
        rotate([90, 180, 0])
            earRaw();

}

ring();
ear((dRingOutside)/2 - lWall);
mirror([1,0,0])ear((dRingOutside)/2 - lWall);