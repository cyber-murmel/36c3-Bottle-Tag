TAU = 2*PI;

// text to put on tag
string = "name";
// upper inner diameter
upper_id = 26; // [26, 26, 26]
// lower inner diameter
lower_id = 35; // [30, 35, 45]
// height of the clip
height = 26; // [26, 26, 26]
// wall thickness
shell = 3; // [1:0.1:5]
// outdentation of the text
raise = 1; // [0.1:0.1:3]
// number of fragments per 360 deg
$fn = 180; // [45:360]

module bottle_tag(string="text", h=30, uid=40, lid=50, shell=3, raise=2, font="Blackout MidnightUmlauts:style=Regular") {
  r_text = max(uid, lid)/2+shell+raise;
  w_text = TAU*r_text;

  difference() {
    union() {
      cylinder(h=h, d1=lid+2*shell, d2=uid+2*shell, center=true);
      intersection() {
        rotate([90])
          for (i = [-0.5:1/$fn:0.5])
            rotate([0,i*360])
              linear_extrude(height=r_text, scale=[100, 1])
                scale([1/100, 1])
                  intersection() {
                    translate([-i*w_text, 0]) {
                      translate([0, h/4])
                        resize([0, 3*h/7], auto=true)
                            import("assets/dxf/Fairydust.dxf", center=true);
                      translate([0, -h/4])
                        resize(newsize=[0, h/3], auto=true)
                          text(string, font=font, valign="center", halign="center");
                    }
                    square([w_text*1/$fn, 100], center=true);
                  }
        cylinder(h=h, d1=lid+2*shell+2*raise, d2=uid+2*shell+2*raise, center=true);
      }
    }
    cylinder(h=h+0.01, d1=lid, d2=uid, center=true);
    rotate(45)
      translate([0, 0, -h/2-1])
        cube([lid, lid, h]+[2, 2, 2]);
  }
}

bottle_tag(string=string, h=height, uid=upper_id, lid=lower_id, shell=shell, raise=raise);
