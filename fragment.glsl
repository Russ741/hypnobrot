void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    /* TODO: Provide and use iResolution rather than hardcoded numbers. */
    fragColor = vec4(fragCoord.x / 300.0, fragCoord.y / 150.0, 0.0, 1.0);
}
