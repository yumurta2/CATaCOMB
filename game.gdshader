shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// Random function to generate pseudo-random values
float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void fragment() {
    vec4 color = texture(screen_texture, SCREEN_UV);

    // Use the random function to generate a random value between 0.0 and 1.0
    float rand_value = random(SCREEN_UV);

    // Example usage of the random value: Modifying the red channel
    color.r = max(min(round(rand_value* 4.0) / 4.0, 1.0), 0.0);;

    color.g = max(min(round(color.g * 4.0) / 4.0, 1.0), 0.0);
    color.b = max(min(round(color.b * 4.0) / 4.0, 1.0), 0.0);

    COLOR = color;
}

void vertex() {
	//VERTEX += vec2(cos(TIME)*100.0, sin(TIME)*100.0);
}
