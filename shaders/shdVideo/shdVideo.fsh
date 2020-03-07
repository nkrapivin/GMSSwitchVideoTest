// 
// BlackWhite&YUV shader
// 
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform sampler2D v_chroma;

const float x = 1.164383;
const float y = 1.138393;
const float z = 1.138393;
const vec3 src_bias = vec3(16.0 / 255.0, 128.0 / 255.0, 128.0 / 255.0);
const mat3 src_xform = mat3(1.00000000 * x,  0.00000000 * y,  1.57480000 * z,
                            1.00000000 * x, -0.18732427 * y, -0.46812427 * z,
                            1.00000000 * x,  1.85560000 * y,  0.00000000 * z);
void main()
{
    float yy = texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y)).r;
    vec2 cbcr = texture2D(v_chroma, vec2(v_vTexcoord.x, v_vTexcoord.y)).rg;
    vec3 yuv = vec3(yy, cbcr);
    yuv -= src_bias;
    yuv *= src_xform;
    gl_FragColor = vec4(yuv, 1.0);
}