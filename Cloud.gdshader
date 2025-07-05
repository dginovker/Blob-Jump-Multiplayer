shader_type canvas_item;

uniform sampler2D cloud_texture; // No hint needed!

uniform vec2 scale = vec2(1.0, 1.0);

void fragment() {
    vec2 uv = UV * scale;
    COLOR = texture(cloud_texture, fract(uv));
}
 