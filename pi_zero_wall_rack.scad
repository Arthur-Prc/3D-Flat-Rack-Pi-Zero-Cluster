
// Raspberry Pi Zero Flat Wall Rack for 4 units + USB Hub
// Dimensions in mm

// Parameters
pi_length = 65;
pi_width = 30;
pi_hole_spacing_x = 58;
pi_hole_spacing_y = 23;
pi_hole_diameter = 3; // screw hole size
pi_spacing = 5; // spacing between boards

hub_length = 100; // adjust to your hub size
hub_width = 40;
hub_hole_diameter = 3;

// Tray dimensions
tray_length = 4*pi_length + 3*pi_spacing;
tray_width = pi_width + hub_width + 20;
tray_thickness = 3;

// Module for screw hole
module hole(d=3) {
    cylinder(d=d, h=10, center=true);
}

// Module for one Pi Zero mount
module pi_mount(x_offset, y_offset) {
    translate([x_offset, y_offset, tray_thickness/2])
        for (x=[0, pi_hole_spacing_x])
            for (y=[0, pi_hole_spacing_y])
                translate([x, y, 0])
                    hole(pi_hole_diameter);
}

// Module for USB Hub mount (2 screw holes)
module hub_mount(x_offset, y_offset) {
    translate([x_offset, y_offset, tray_thickness/2]) {
        translate([10, 10, 0]) hole(hub_hole_diameter);
        translate([hub_length-10, hub_width-10, 0]) hole(hub_hole_diameter);
    }
}

// Main tray
difference() {
    // Base plate
    cube([tray_length, tray_width, tray_thickness]);

    // Corner mounting holes for wall screws
    translate([5, 5, tray_thickness/2]) hole(4);
    translate([tray_length-5, 5, tray_thickness/2]) hole(4);
    translate([5, tray_width-5, tray_thickness/2]) hole(4);
    translate([tray_length-5, tray_width-5, tray_thickness/2]) hole(4);

    // Pi Zero screw holes
    for (i=[0:3]) {
        x_pos = i*(pi_length+pi_spacing)+ (pi_length-pi_hole_spacing_x)/2;
        y_pos = 10;
        pi_mount(x_pos, y_pos);
    }

    // USB Hub screw holes
    hub_mount((tray_length-hub_length)/2, pi_width+20);
}
