shader_type canvas_item;

uniform vec2 position;
uniform float arc = 0.75;
uniform vec4 color : source_color = vec4(0.0, 0.0, 0.0, 1); //dark color
uniform float max_darkness = 0.99;
uniform float start = 0.02;
uniform float end = 0.25;

void fragment() {
	// Place fragment code here.
	float transp = 0.0;
	
	float val = distance(vec2(UV.x, UV.y * arc), vec2(position.x, position.y * arc)) / 2.0;
	
	if(val < start){
		transp = 0.0;
	}else if(val < end){
		transp = smoothstep(start * 2.2, max_darkness, val / end);
	}else{
		transp = max_darkness;
	}
	COLOR = vec4(color.x, color.y, color.z, transp);
}
