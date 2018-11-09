
uniform vec2 dimensions;
uniform vec2 scale;
uniform vec2 offset;
uniform vec2 mousecoords;
uniform int iterations;
uniform int type;
uniform int petals;
uniform float rainbowssss;

vec4 HSLtoRGB(in vec4 HSLA){
    vec3 RGB;
	if(HSLA.y<=0){
        return vec4(HSLA.z, HSLA.z, HSLA.z, HSLA.w);
    }
	HSLA.x = HSLA.x*6;
	float c = (1-abs(2*HSLA.z-1))*HSLA.y;
	float x = (1-abs(mod(HSLA.x, 2)-1 ) )*c;
	float m = (HSLA.z-0.5*c);
	if(HSLA.x < 1)     {RGB = vec3(c, x, 0);}
	else if(HSLA.x < 2){RGB = vec3(x, c, 0);}
	else if(HSLA.x < 3){RGB = vec3(0, c, x);}
	else if(HSLA.x < 4){RGB = vec3(0, x, c);}
	else if(HSLA.x < 5){RGB = vec3(x, 0, c);}
	else               {RGB = vec3(c, 0, x);}
	return vec4( (RGB.x+m), (RGB.y+m), (RGB.z+m), HSLA.w);
}

vec4 effect( vec4 color, sampler2D texture, vec2 texture_coords, vec2 screen_coords ){

    vec4 pixel;
    lowp vec2 coords = vec2( ( screen_coords.x/dimensions.x - 0.5)*scale.x*2 - offset.x,
    ( screen_coords.y/dimensions.x - 0.5*(dimensions.y/dimensions.x) )*scale.y*2*-1 + offset.y * (dimensions.y/dimensions.x) );

    lowp vec2 z;
    lowp vec2 c;
    int totalIterations;

    if(type ==  0){
        c = coords;
    }
    else{
        z = coords;
        c = mousecoords;
    }

    for(int i = 1; i < iterations; i++){
        z = vec2(z.x * z.x + -z.y * z.y + c.x, z.x * z.y + z.x * z.y + c.y);
        if(petals == 0){
            if(pow(pow(z.x, 2) + pow(z.y, 2), 0.5) > 2 || pow(pow(z.x, 2) + pow(z.y, 2), 0.5) < -2){
                totalIterations = i;
                break;
            }
        }
        else if(petals == 1){
            if(abs(z.x) > 2){
                totalIterations = i;
                break;
            }
        }
        else if(petals == 2){
            if(z.x > 2){
                totalIterations = i;
                break;
            }
        }
    }

    pixel = HSLtoRGB(vec4(mod(totalIterations/(2.7182818284590452353602874713527*10) + 0.5 + rainbowssss, 1), 1, 0.5, 1)  );
    if (totalIterations == 0){
        pixel = vec4(0, 0, 0, 1);
    }

    return pixel;
}
