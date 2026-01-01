shader_type canvas_item;

//Controls movement direction
uniform float movementLeft: hint_range(0.0, 2.0, 0.1) = 0.1;
uniform float movementUp: hint_range(0.0, 2.0, 0.1) = 0.1;
//Main star shine adjustments
uniform float starFrequency: hint_range(0.0, 1.0, 0.01) = 0.1;
uniform float sizeStar: hint_range(10.0, 200.0, 10.0) = 100.0;
uniform float brightness: hint_range(1.0, 5.0, 1.0) = 3.0;
uniform float shineFrequency: hint_range(1.0, 20.0, 1.0) = 8.0;
uniform float starTransparency: hint_range(0.0, 1.0, 0.01) = 1.0;
uniform int starIterations: hint_range(1, 10, 1) = 3;
//Background star adjustments
uniform float backgroundStarFrequency: hint_range(0.950, 1.0, 0.001) = 0.996;
uniform float backgroundStarShineFrequency: hint_range(0.0, 5.0, 1.0) = 1.0;
//Gradient for regular stars
uniform sampler2D gradientA;
//Gradient for background stars
uniform sampler2D gradientB;
//Background color
uniform vec4 backgroundColor: source_color = vec4(0.05, 0.04, 0.20, 1.0);
uniform float backgroundtransparency: hint_range(0.0, 1.0, 0.01) = 1.0;
//Seeding for different noise generation
uniform float seed: hint_range(0.0, 100.0, 1.0) = 0.0;

float rand(vec2 st) {
	return fract(sin(dot(st.xy, vec2(seed+12.9898,78.233))) * 43758.5453123);
	}

float remap(float prob, float starValue) {
	return (starValue - prob)/(1.0-prob);
	} //return (starValue - prob)/(1.0-prob)

void fragment() {
	float prob = 1.0 - starFrequency;
	float travelx = TIME*movementLeft;
	float travely = TIME*movementUp;
	float color = 0.0;
	COLOR = vec4(backgroundColor.rgb, backgroundtransparency);

	for(int i = 1; i < 1 + starIterations; i++) {
		float size = sizeStar/float(i);
		vec2 pos = vec2(floor((1.0 / size * FRAGCOORD.x)+travelx), floor((1.0 / size * FRAGCOORD.y)+travely));
		float starValue = rand(pos);

		if (starValue > prob)
		{
			vec2 center = size * pos + vec2(size, size) * 0.5;
			float t = 0.9 + 0.2 * sin(TIME * shineFrequency + (starValue - prob) / (1.0 - prob) * 45.0);
			vec2 modifiedCoords = vec2(FRAGCOORD.x + travelx*size, FRAGCOORD.y + travely*size);
			color = 1.0 - distance(modifiedCoords, center) / (0.5 * size);
			color = t*t*brightness/float(i) / (clamp(distance(modifiedCoords.y, center.y), 0.5, size/2.0-1.0)) / (clamp(distance(modifiedCoords.x, center.x), 0.5, size/2.0-1.0));
			vec4 colormapA = texture(gradientA, vec2(remap(prob, starValue)));
			COLOR.rgb += colormapA.rgb * color * starTransparency;
		}
	}

	if (rand(SCREEN_UV.xy / 20.0) > backgroundStarFrequency)
		{
			float r = rand(SCREEN_UV.xy);
			color = r * (0.85 * sin(TIME * backgroundStarShineFrequency * (r * 5.0) + 720.0 * r) + 0.95);
			vec4 colormapB = texture(gradientB, vec2(r));
			COLOR.rgb += color * colormapB.rgb * starTransparency;
		}
	}