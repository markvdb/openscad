/*Attempt at rendering of the 25000€ DIY timber frame house plans by Dominic Stevens at http://irishvernacular.com
*/

//common size of most of the wood used
wood_width=44;
wood_height=225;
column_height=175;

batten_width=44;
batten_height=44;

//specific frame parts
column_base_length=300;
column_base_width=wood_width;
column_base_height=wood_height;

column_center_length=3846;
column_center_width=wood_width;
column_center_height=column_height;

column_center_batten_length=3321;
column_center_batten_width=batten_width;
column_center_batten_height=batten_height;

column_middle_length=2470;
column_middle_width=wood_width;
column_middle_height=column_height;

column_top_length=626;
column_top_width=wood_width;
column_top_height=column_height;

cross_piece_height=wood_height;
cross_piece_length=3950;

floor_joist_length=2860;
floor_joist_width=wood_width;
floor_joist_height=wood_height;

frames_core_distance=3000;

floor_joist_perimeter_length=frames_core_distance;

nogging_length=556;
nogging_width=wood_width;
nogging_height=wood_height;

roof_joist_length=2837;
roof_joist_width=wood_width;
roof_joist_height=wood_height;

wall_plate_length=frames_core_distance;
wall_plate_width=wood_width;
wall_plate_height=wood_height;

wall_strut_side_length=3321;
wall_strut_width=wood_width;
wall_strut_height=wood_height;

wall_strut_short_length=2470;

/*-----------------------------------------------------------------
Individual parts
------------------------------------------------------------------*/
module column_base(){
    cube([wood_width, column_base_height, column_base_length]);
}

module column_center(){
    cube([wood_width, column_center_height, column_center_length]);
}

module column_center_batten(){
    cube([column_center_batten_width, column_center_batten_height, column_center_batten_length]);
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

module floor_joist(){
    cube([floor_joist_length,wood_width,wood_height]);
}

module floor_joist_perimeter(){
    cube([floor_joist_perimeter_length,wood_width,wood_height]);
}

module nogging(){
    cube([nogging_length, nogging_height, nogging_width]);
}

module roof_joist_left(){
    render(convexity = 2)
    difference(){
        rotate([0,45,0]){
            difference(){
                cube([roof_joist_height, roof_joist_width, roof_joist_length]);
                translate([0,0,roof_joist_length]) rotate([0,45,0]) cube([2*wood_height, wood_width, wood_height]);
            }
        }
        translate([0,0,-wood_height]) cube([wood_height,wood_width,wood_height]);
    }
}

module roof_joist_right(){
    mirror([1,0,0]) roof_joist_left();
}

module wall_plate(){
    cube([wall_plate_length,wall_plate_height,wall_plate_width]);
}

module wall_strut_side(){
    cube([wall_strut_width,wall_strut_height,wall_strut_side_length]);
}

module wall_strut_short(){
    cube([wall_strut_height,wall_strut_width,wall_strut_short_length]);
}


/*-----------------------------------------------------------------
Assemblies of individual parts
------------------------------------------------------------------*/
module column(){
    column_center();
    color("green") translate([0,column_center_height,column_base_length+cross_piece_height]) column_center_batten();
    color("red") translate([-wood_width,0,0]) column_base();
    color("red") translate([-wood_width,0,column_center_length-column_top_length]) column_top();
    color("red") translate([-wood_width,0,column_base_length+cross_piece_height]) column_middle();
    color("red") translate([wood_width,0,0]) column_base();
    color("red") translate([wood_width,0,column_center_length-column_top_length]) column_top();
    color("red") translate([wood_width,0,column_base_length+cross_piece_height]) column_middle();
}

module frame(){
        translate([0,column_height,0]) mirror([0,1,0]) column();
        translate([-wood_width,0,column_base_length]) cross_piece();
        translate([wood_width,0,column_base_length]) cross_piece();
        translate([-wood_width,0,column_center_length-column_top_length-cross_piece_height]) cross_piece();
        translate([wood_width,0,column_center_length-column_top_length-cross_piece_height]) cross_piece();
        translate([0,cross_piece_length-column_height,0]) column();
}

module frames(){
    for (i=[0:4]) translate([frames_core_distance*i,0,0]) frame();
}

module floor_joists(){
    for (i=[0:3]){
        //inner perimeter ground floor joists
        color("blue") translate([wood_width/2+(frames_core_distance-floor_joist_length)/2+frames_core_distance*i,column_height-wood_width,column_base_length]) floor_joist();
        color("blue") translate([wood_width/2+(frames_core_distance-floor_joist_length)/2+frames_core_distance*i,cross_piece_length-column_height,column_base_length]) floor_joist();
        //60 cm spaced ground floor joists
        for (j=[-2:2]){
            color("blue") translate([wood_width/2+(frames_core_distance-floor_joist_length)/2+frames_core_distance*i,cross_piece_length/2+j*600,column_base_length]) floor_joist();
        }
    }
    for (i=[0:1]){
        //inner perimeter mezzanine floor joists
        color("blue") translate([wood_width/2+(frames_core_distance-floor_joist_length)/2+frames_core_distance*i,column_height,column_center_length-column_top_length-wood_height]) floor_joist();
        color("blue") translate([wood_width/2+(frames_core_distance-floor_joist_length)/2+frames_core_distance*i,cross_piece_length-column_height-wood_width,column_center_length-column_top_length-wood_height]) floor_joist();
        //60 cm spaced mezzanine floor joists
        for (j=[-2:2]){
            color("blue") translate([wood_width/2+(frames_core_distance-floor_joist_length)/2+frames_core_distance*i,cross_piece_length/2+j*600,column_center_length-column_top_length-wood_height]) floor_joist();
        }
    }
}

module floor_joists_perimeter(){
    for (i=[0:3]){
        color("blue") translate([wood_width/2+frames_core_distance*i,-wood_width,column_base_length])floor_joist_perimeter();
        color("blue") translate([wood_width/2+frames_core_distance*i,cross_piece_length,column_base_length])floor_joist_perimeter();
    }
}

module noggings_long_side(){
    nogging();
}

module roof_joists(){
    for(i=[0:21]){
        translate([i*600+wood_width,-50,column_center_length+wall_plate_width]) rotate([0,0,90]){
        roof_joist_left();
        translate([4050,0,0]) roof_joist_right();
        }
    }
}

module wall_plates(){
    for (i=[0:3]){
        for (j=[0:1]){
            color("orange") translate([wood_width/2+frames_core_distance*i,j*(cross_piece_length-wood_height+2*wood_width)-wood_width,column_center_length]) wall_plate();
        }
    }
}

module wall_struts_side(){
    color("green") for (i=[0:1]){
        translate([0,(cross_piece_length-3*wood_width)*i,0]) for (j=[0:3]){
            translate([frames_core_distance*j,0,0]){
                for (k=[1:4]) translate([frames_core_distance*k/5,-wood_width,column_base_length+cross_piece_height]) wall_strut_side();
            }
        }
    }
}

module wall_struts_short(){
    color("orange") for (i=[0:1]){
        translate([frames_core_distance*4*i,0,0]){
            for (i=[-2:2]){
                translate([-2*wood_width,cross_piece_length/2+600*i,column_base_length+cross_piece_height]) wall_strut_short();
            }
        }
    }
}

frames();
floor_joists();
floor_joists_perimeter();
wall_plates();
wall_struts_side();
wall_struts_short();
noggings_long_side();
roof_joists();
