// Bed box, inspired by http://www.instructables.com/id/Box-Bed/?ALLSTEPS
// (but metric units, not medieval)

// Global variables

// Standard panel sizes
full_panel_length=2440;
full_panel_width=1220;
saw_width=2.8;

// The mattress itself
mattress_width=1600;
mattress_length=2000;
mattress_height=200;

// Wood panels
panel_length=2440;
panel_width=1220;
panel_thick_height=18;
panel_thin_height=12;

// Box dimensions
box_width=800;
box_length=1000;
box_inner_height=360;
box_outer_height=box_inner_height+panel_thick_height;
box_inner_length=box_length-panel_thin_height-panel_thick_height;


// Panel modules
dado_offset_1=25;
dado_offset_2=45;
dado_width=4;//will require two difficult parallell circular saw cuts!!

door_track_height=panel_thick_height;
door_track_length=box_inner_length;
door_track_width=76;
door_track_dado_height=3;
door_track_dado_width=dado_width;
door_track_dado_offset_1=dado_offset_1;
door_track_dado_offset_2=dado_offset_2;

panel_side_thick_height=panel_thick_height;
panel_side_thick_width=box_inner_height;
panel_side_thick_length=box_width;

panel_side_thin_height=panel_thin_height;
panel_side_thin_width=box_inner_height;
panel_side_thin_length=box_width;

panel_top_height=panel_thick_height;
panel_top_width=box_width;
panel_top_length=box_length;
panel_top_dado_offset_1=dado_offset_1;
panel_top_dado_offset_2=dado_offset_2;
panel_top_dado_height=9;
panel_top_dado_width=dado_width;

shelf_height=panel_thin_height;
shelf_width=460;
shelf_length=box_inner_length;

stiffening_rib_height=panel_thin_height;
stiffening_rib_width=box_inner_height;
stiffening_rib_length=box_inner_length;

door_height=3;
door_width=box_inner_height-door_track_height+(panel_top_dado_height-door_track_dado_height);;
door_length=box_inner_length/2+40; // 40mm overlap between door panels


/*---------------------------------------
Parts
---------------------------------------*/
// Mattress
module mattress(){
    color("white") cube([mattress_width,mattress_length,mattress_height]);
}
// Box parts 2D
module door_left_2d(){
    difference(){
        square([door_length,door_width]);
        translate([50,door_width/2,0])
            circle(d=40);   
    }
}
module door_track_2d(){
    square([door_track_length,door_track_width]);
}
module panel_side_thick_2d(){
    square([panel_side_thick_length,panel_side_thick_width]);
}
module panel_side_thin_2d(){
    square([panel_side_thin_length,panel_side_thin_width]);
}
module panel_top_2d(){
    square([panel_top_length,panel_top_width]);
}
module shelf_2d(){
    square([shelf_length,shelf_width]);
}
module stiffening_rib_2d(){
    square([stiffening_rib_length,stiffening_rib_width]);
}
// Box parts 3D
module door_left(){
    % linear_extrude(door_height) door_left_2d();
}
module door_right(){
    translate([door_length,0,0])
        mirror([1,0,0])
            % door_left();
}
module door_track(){
    difference(){
        color("brown") linear_extrude(door_track_height) door_track_2d();
        translate([0,door_track_dado_offset_1,door_track_height-door_track_dado_height])
            cube([door_track_length,door_track_dado_width,door_track_dado_height]);
        translate([0,door_track_dado_offset_2,door_track_height-door_track_dado_height])
            cube([door_track_length,door_track_dado_width,door_track_dado_height]);
    }
    text=str("door track:",door_track_length,"mm* ",door_track_width,"mm *",door_track_height,"mm");
    translate([door_track_length/2, door_track_width/2, door_track_height])
        color("yellow") {
            text(halign="center", valign="center", text=text, size=20);
   }
}
module panel_side_thick(){
    color("brown") linear_extrude(panel_side_thick_height) panel_side_thick_2d();
    text=str("panel side thick:",panel_side_thick_length,"mm* ",panel_side_thick_width,"mm *",panel_side_thick_height,"mm");
    translate([panel_side_thick_length/2, panel_side_thick_width/2, panel_side_thick_height])
        color("yellow") {
            text(halign="center", valign="center", text=text, size=20);
   }
}
module panel_side_thin(){
    linear_extrude(panel_side_thin_height) panel_side_thin_2d();
}
module panel_top(){
    difference(){
        color("brown") linear_extrude(panel_top_height) panel_top_2d();
        translate([0,panel_top_dado_offset_1,0])
            cube([panel_top_length, panel_top_dado_width,panel_top_dado_height]);
        translate([0,panel_top_dado_offset_2,0])
            cube([panel_top_length, panel_top_dado_width,panel_top_dado_height]);
    }
    text=str("panel top:",panel_top_length,"mm* ",panel_top_width,"mm *",panel_top_height,"mm");
    translate([panel_top_length/2, panel_top_width/2, panel_top_height])
        color("yellow") {
            text(halign="center", valign="center", text=text, size=20);
   }
}
module shelf(){
    linear_extrude(shelf_height) shelf_2d();
}
module stiffening_rib(){
    linear_extrude(stiffening_rib_height) stiffening_rib_2d();
}

// One box 3D
module box(){
    translate([panel_thick_height,0,0])
        door_track();
    rotate([90,0,90])
        panel_side_thick();
    translate([box_length-panel_side_thin_height,0,0])
        rotate([90,0,90])
            panel_side_thin();
    translate([0,0,box_inner_height])
        panel_top();
    translate([panel_side_thick_height,door_track_width,(box_inner_height+shelf_height)/2])
        shelf();
    translate([panel_thick_height,door_track_width+shelf_width+stiffening_rib_height,0])
        rotate([90,0,0])
            stiffening_rib();
    translate([panel_side_thick_height,door_track_dado_offset_1+(door_height+dado_width)/2,door_track_height-door_track_dado_height])
        rotate([90,0,0])
            door_left();
    translate([box_inner_length-door_length+panel_side_thick_height,door_track_dado_offset_2+(door_height+dado_width)/2,door_track_height-door_track_dado_height])
        rotate([90,0,0])
            door_right();
}
// All four boxes 3D
module boxes(){
    box();
    translate([2*box_length,0,0])
        mirror([1,0,0])
            box();
    translate([0,2*box_width,0]){
        mirror([0,1,0]){
            box();
            translate([2*box_length,0,0])
                mirror([1,0,0])
                    box();
        }
    }
}

/*----------------------------------------
Build it!
----------------------------------------*/
3d=1;
if (3d){
    boxes();
    translate([mattress_length,0,box_outer_height])
        rotate([0,0,90])
            mattress();    
} else {
    // first thick panel
    % square([full_panel_length,full_panel_width]);
    translate([panel_top_width,0]) rotate([0,0,90]) panel_top();
    translate([2*panel_top_width+ saw_width,0]) rotate([0,0,90]) panel_top();
    translate([3*panel_top_width+ 2*saw_width,0]) rotate([0,0,90]) panel_top();
    translate([0,panel_top_length+saw_width]) door_track();
    translate([0,panel_top_length+2*saw_width+door_track_width]) door_track();
    translate([door_track_length+saw_width,panel_top_length+saw_width]) door_track();
    translate([door_track_length+saw_width,panel_top_length+2*saw_width+door_track_width]) door_track();        

    % translate([full_panel_length+20,0]){
        square([full_panel_length,full_panel_width]);
        panel_top();
            translate([0,panel_top_width+saw_width]) panel_side_thick();
            translate([panel_top_length+saw_width,0]){
                panel_side_thick();
                translate([0,panel_side_thick_width+saw_width]) panel_side_thick();
                translate([0,2*(panel_side_thick_width+saw_width)]) panel_side_thick();
            }
    }   
}
