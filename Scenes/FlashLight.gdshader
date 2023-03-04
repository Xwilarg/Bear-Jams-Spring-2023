shader_type canvas_item;

uniform vec2 mouse_position;
uniform vec4 color : source_color = vec4(0.305, 0.298, 0.341, 1); //dark color
uniform float dis1 = 0.1;
uniform float dis2 = 0.15;

uniform float mult = 0.56; //res 16/19 -> mult = 9/16

void fragment() {
	// Place fragment code here.
	float transp = 0.0;
	
	float val = distance(vec2(UV.x, UV.y * mult), vec2(mouse_position.x, mouse_position.y * mult));
	
	if(val < dis1){
		transp = 0.0;
	}else if(val < dis2){
		transp = 0.5;
	}else{
		transp = 1.0;
	}
	COLOR = vec4(color.x, color.y, color.z, transp);
}
