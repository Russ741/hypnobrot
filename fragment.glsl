float scale(float src, float minSrc, float maxSrc, float minDst, float maxDst) {
    float srcRange = maxSrc - minSrc;
    float dstRange = maxDst - minDst;

    float dstPerSrc = dstRange / srcRange;
    return (src - minSrc) * dstPerSrc + minDst;
}

float scaleX(float src, float minDst, float maxDst) {
    return scale(src, 0., float(iResolution.x), minDst, maxDst);
}

float scaleY(float src, float minDst, float maxDst) {
    return scale(src, 0., float(iResolution.y), minDst, maxDst);
}

vec2 mult(vec2 a, vec2 b) {
    return vec2(a.x * b.x - a.y * b.y,
                a.x * b.y + a.y * b.x);
}

float countIterations(vec2 xy) {
    vec2 z = vec2(0, 0);
    int count = 0;

    int maxCount = 50;
    while (length(z) < 20. && count < maxCount) {
        z = mult(z, z) + xy;
        ++count;
    }
    // return float(count);
    return float(count) / float(maxCount);
}

vec2 midRangeToMinMax(float mid, float range) {
    return vec2(mid - (range / 2.0), mid + (range / 2.0));
}

float phaseToColor(float phase) {
    return 0.5 * sin(phase) + 0.5;
}

float timeToPhaseOffset() {
    float colorCycleLength = 3.;
    float cyclePhaseOffset = radians(360.) * iTime / colorCycleLength;
    return cyclePhaseOffset;
}

float countToPhaseOffset(float count) {
    float inOutCycles = 2.;
    return radians(360.) * count * inOutCycles;
}

vec3 color(float count) {
    float cyclePhaseOffset = timeToPhaseOffset();
    float countPhaseOffset = countToPhaseOffset(count);
    float phaseOffset = cyclePhaseOffset + countPhaseOffset;
    return count * vec3(phaseToColor(phaseOffset),
                        phaseToColor(phaseOffset + radians(120.)),
                        phaseToColor(phaseOffset - radians(120.)));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float middleU = -1.5;
    float middleV = 0.;

    float startURange = 3.;
    float startVRange = 3.;

    float uFrameScale = pow(0.99, float(iTime) / 60.0);
    float vFrameScale = pow(0.99, float(iTime) / 60.0);

    float uRange = startURange * uFrameScale;
    float vRange = startVRange  * vFrameScale;

    vec2 uMinMax = midRangeToMinMax(middleU, uRange);
    vec2 vMinMax = midRangeToMinMax(middleV, vRange);

    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = vec2(scaleX(fragCoord.x, uMinMax.x, uMinMax.y), scaleY(fragCoord.y, vMinMax.x, vMinMax.y));

    float count = countIterations(uv);
    vec3 col = color(count);

    // Output to screen
    fragColor = vec4(col,1.0);
}
