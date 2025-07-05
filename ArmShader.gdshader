shader_type canvas_item;

uniform float cutoff : hint_range(0.0, 1.0) = 0.5;

void fragment() {
    vec2 uv = UV;

    if (uv.y > cutoff) {
        discard;
    }

    vec4 tex_color = texture(TEXTURE, uv);

    // Tint the texture red
    tex_color.rgb = vec3(1.0, 0.0, 0.0); // RGB for pure red

    COLOR = tex_color * COLOR;
}
