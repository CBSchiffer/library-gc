shader_type spatial;
render_mode unshaded, cull_back;

uniform vec3 fill_color = vec3(0.9, 0.8, 0.6);
uniform vec3 line_color = vec3(0.0, 0.0, 0.0);
uniform float thickness : hint_range(0.5, 5.0) = 1.5;

varying vec2 uv2_face;

void vertex() {
    uv2_face = UV2;
}

void fragment() {
    vec2 d = min(uv2_face, 1.0 - uv2_face);
    float dist = min(d.x, d.y);

    float w = fwidth(dist) * thickness;
    float edge = smoothstep(0.0, w, dist);

    ALBEDO = mix(line_color, fill_color, edge);
}