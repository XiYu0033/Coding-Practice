PImage sample;

void setup() {
  size(600, 600);
  sample = loadImage("sample.jpg");
  sample.resize(width,height);
}

void draw() {
  
  image(sample, 0, 0);
  loadPixels();
  

  for (int i = 0; i < pixels.length; i++) {

  float r = red(pixels[i]);
  float g = green(pixels[i]);
  float b = blue(pixels[i]);
  
  // Make the color tone of the picture lean towards blue
      /*r *= 0.8;
      g *= 0.8;
      b *= 1.0;*/


  float levels = 1.8;
  float step = 255.0 / (levels - 1);

  // each color channel
  float newR = round(r / step) * step;
  float newG = round(g / step) * step;
  float newB = round(b / step) * step;


  float strength = 1.3;
  float errR = (r - newR) * strength;
  float errG = (g - newG) * strength;
  float errB = (b - newB) * strength;


  pixels[i] = color(newR, newG, newB);

  colorDither(i, errR, errG, errB);
}

  updatePixels();
}


void colorDither(int i, float errR, float errG, float errB) {

  // Using AI to ensure the variable
  int[] offsets = 
  {
    1, 2, width-1, width, width+1, width*2
  };

  for (int j = 0; j < offsets.length; j++) {
    int ni = i + offsets[j];

    if (ni < pixels.length) {
      float r = red(pixels[ni]);
      float g = green(pixels[ni]);
      float b = blue(pixels[ni]);
      
      // Make the color tone of the picture lean towards blue
      r *= 0.8;
      g *= 0.9;
      b *= 1.05;

      pixels[ni] = color(
        r + errR / 8.0,
        g + errG / 8.0,
        b + errB / 8.0
      );
    }
  }
}