# Hypnobrot

A fragment shader depicting an animated Mandelbrot curve, lovingly rendered in Lisa Frank-esque hypercolor.

Check it out **[here](https://russ741.github.io/hypnobrot/)**.

## Developer Notes

I originally developed it on [ShaderToy](https://www.shadertoy.com/view/dl2yWW), a great environment for learning how to write fragment shaders in GLSL.\n
Migrating off of ShaderToy involved a fair amount of scaffolding:
* A HTML host page
* JavaScript code to set up WebGL, compile shaders, etc.
* More JavaScript code to provide (a subset of) the bespoke shader uniform variables that ShaderToy provides (e.g. viewport resolution, elapsed time)
* A basic vertex shader to give the fragment shader a surface to render onto.
* Boilerplate fragment shader code to couple the code from a ShaderToy fragment shader to a plain WebGL setup
  * In particular, override the floating-point precision to fix jitter and banding on mobile devices
