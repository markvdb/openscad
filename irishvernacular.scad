/*Attempt at rendering of the 25000€ DIY timber frame house plans by Dominic Stevens at http://irishvernacular.com
*/

//common size of most of the wood used
wood_width=44;
wood_height=225;
column_height=175;

//specific frame parts
column_base_length=300;
column_base_width=wood_width;
column_base_height=wood_height;

column_center_length=3846;
column_center_width=wood_width;
column_center_height=column_height;

column_middle_length=2470;
column_middle_width=wood_width;
column_middle_height=column_height;

column_top_length=626;
column_top_width=wood_width;
column_top_height=column_height;

cross_piece_height=wood_height;
cross_piece_length=3950;

roof_joist_length=2850;
roof_joist_width=wood_width;
roof_joist_height=wood_height;

wall_plate_lenght=3000;
wall_plate_width=wood_width;
wall_plate_height=wood_height;

module column_base(){
    cube([wood_width, column_base_height, column_base_length]);
}

module column_center(){
    cube([wood_width, column_center_height, column_center_length]);
}

module column_middle(){
    cube([wood_width, column_middle_height, column_middle_length]);
}

module column_top(){
    cube([wood_width, column_top_height, column_top_length]);
}

module cross_piece(){
    cube([wood_width, cross_piece_length, cross_piece_height]);
}

module column(){
    column_center();
    % translate([-wood_width,0,0]) column_base();
    % translate([-wood_width,0,column_center_length-column_top_length]) column_top();
    % translate([-wood_width,0,column_base_length+cross_piece_height]) column_middle();
    % translate([wood_width,0,0]) column_base();
    % translate([wood_width,0,column_center_length-column_top_length]) column_top();
    % translate([wood_width,0,column_base_length+cross_piece_height]) column_middle();
}

module frame(){
        translate([0,column_height,0]) mirror([0,1,0]) column();
        translate([-wood_width,0,column_base_length]) cross_piece();
        translate([wood_width,0,column_base_length]) cross_piece();
        translate([-wood_width,0,column_center_length-column_top_length-cross_piece_height]) cross_piece();
        translate([wood_width,0,column_center_length-column_top_length-cross_piece_height]) cross_piece();
        translate([0,cross_piece_length-column_height,0]) column();
}

//TODO: for loop
frame();
translate([3000,0,0]) frame();
translate([6000,0,0]) frame();
translate([9000,0,0]) frame();
translate([12000,0,0]) frame();
