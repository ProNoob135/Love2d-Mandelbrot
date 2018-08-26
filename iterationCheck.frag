
        uniform vec2 dimensions;

        vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){

            vec4 pixel = vec4(1.0, 0.0, 0.0, 1.0);

            for(int i = -1; i <= 1; i++){
                for(int j = -1; j <= 1; j++){
                    vec4 prevPixel = Texel(texture, vec2(screen_coords.x + i, screen_coords.y + j)/dimensions );

                    if(prevPixel.x + prevPixel.y + prevPixel.z > 0.0 || screen_coords.x < 1 || screen_coords.x > dimensions.x - 1 || screen_coords.y < 1 || screen_coords.y > dimensions.y - 1){
                        pixel.x = 0.0;
                    }
                }
            }

            return pixel;
        }
