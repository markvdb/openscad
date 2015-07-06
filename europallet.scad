//Europallet

/*---------------------------
Global variables
---------------------------*/
// General pallet dimensions
pallet_width=800;
pallet_length=1200;
pallet_height=144;
plank_height=22;

// Top layer elements
top_gap_small=40;
top_gap_wide=42.5;

top_plank_small_width=100;
top_plank_small_length=pallet_length;
top_plank_small_height=plank_height;
top_plank_wide_width=145;
top_plank_wide_length=pallet_length;
top_plank_wide_height=plank_height;

// Second layer elements
under_top_plank_width=145;
under_top_plank_length=pallet_width;
under_top_plank_height=plank_height;
under_top_layer_height=under_top_plank_height;

// Third layer elements
block_length=145;
block_height=100;
side_block_width=100;
side_block_length=block_length;
side_block_height=block_height;
center_block_width=145;
center_block_length=block_length;
center_block_height=block_height;
block_width_gap=227.5;
block_length_gap=382.5;
block_layer_height=block_height;

// Bottom layer elements
bottom_center_plank_width=center_block_width;
bottom_center_plank_length=pallet_length;
bottom_center_plank_height=plank_height;
bottom_side_plank_width=side_block_width;
bottom_side_plank_length=pallet_length;
bottom_side_plank_height=plank_height;
bottom_plank_gap=227.5;
bottom_layer_height=plank_height;

// Generate the elements
// bottom layer
module bottom_side_plank(){
    cube([bottom_side_plank_width,bottom_side_plank_length,bottom_side_plank_height]);
}

module bottom_center_plank(){
    cube([bottom_center_plank_width,bottom_center_plank_length,bottom_center_plank_height]);
}
// block layer
module center_block(){
    cube([center_block_width,center_block_length,center_block_height]);
}
module side_block(){
    cube([side_block_width,side_block_length,side_block_height]);
}
module under_top_plank(){
    cube([under_top_plank_width, under_top_plank_length,under_top_plank_height]);
}
// top layer
module top_plank_wide(){
    cube([top_plank_wide_width,top_plank_wide_length,top_plank_wide_height]);
}
module top_plank_small(){
    cube([top_plank_small_width,top_plank_small_length,top_plank_small_height]);
}
// Generate the layers
module bottom_layer(){
    bottom_side_plank();
    translate([(pallet_width-bottom_center_plank_width)/2,0,0])bottom_center_plank();
    translate([pallet_width-bottom_side_plank_width,0,0]) bottom_side_plank();
}

module block_layer(){
    translate([0,0,bottom_layer_height]) side_block();
    translate([0,(pallet_length-side_block_length)/2,bottom_layer_height]) side_block();
    translate([0,(pallet_length-side_block_length),bottom_layer_height]) side_block();
    translate([(pallet_width-center_block_width)/2,0,bottom_layer_height]) center_block();
    translate([(pallet_width-center_block_width)/2,(pallet_length-center_block_length)/2,bottom_layer_height]) center_block();
    translate([(pallet_width-center_block_width)/2,(pallet_length-center_block_length),bottom_layer_height]) center_block();
    translate([pallet_width-side_block_width,0,bottom_layer_height]) side_block();
    translate([pallet_width-side_block_width,(pallet_length-side_block_length)/2,bottom_layer_height]) side_block();
    translate([pallet_width-side_block_width,(pallet_length-side_block_length),bottom_layer_height]) side_block();
}
module under_top_layer(){
    translate([under_top_plank_length,0,bottom_layer_height+block_layer_height])
        rotate([0,0,90])
            under_top_plank();
    translate([under_top_plank_length,(pallet_length-under_top_plank_width)/2,bottom_layer_height+block_layer_height])
        rotate([0,0,90])
            under_top_plank();
    translate([under_top_plank_length,pallet_length-under_top_plank_width,bottom_layer_height+block_layer_height])
        rotate([0,0,90])
            under_top_plank();
}
module top_layer(){
    translate([0,0,bottom_layer_height+block_layer_height+under_top_layer_height]) top_plank_wide();
    translate([top_plank_wide_width+top_gap_wide,0,bottom_layer_height+block_layer_height+under_top_layer_height]) top_plank_small();
    translate([(pallet_width-top_plank_wide_width)/2,0,bottom_layer_height+block_layer_height+under_top_layer_height])
        top_plank_wide();
    translate([pallet_width-top_plank_wide_width-top_gap_wide-top_plank_small_width,0,bottom_layer_height+block_layer_height+under_top_layer_height]) top_plank_small();
    translate([pallet_width-top_plank_wide_width,0,bottom_layer_height+block_layer_height+under_top_layer_height])
        top_plank_wide();
}
// Generate the pallet
bottom_layer();
block_layer();
under_top_layer();
