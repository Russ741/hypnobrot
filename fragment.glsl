#version 100

void main() {
    /* TODO: Provide and use iResolution rather than hardcoded numbers. */
    gl_FragColor = vec4(gl_FragCoord.x / 300.0, gl_FragCoord.y / 150.0, 0.0, 1.0);
}
