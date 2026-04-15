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

  color c = pixels[i];

  // invert filter
  c = invert(c);

  float r = red(c);
  float g = green(c);
  float b = blue(c);

  
  r *= 0.8;
  g *= 0.9;
  b *= 1.05;

  float newR = r;
  float newG = g;
  float newB = b;

  float strength = 2.0;
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
      /*
      r *= 0.8;
      g *= 0.9;
      b *= 1.05;
      */
      
      pixels[ni] = color(
        r + errR / 8.0,
        g + errG / 8.0,
        b + errB / 8.0
      );
    }
  }
}


color invert(color pixel) {
  float r = red(pixel);
  float g = green(pixel);
  float b = blue(pixel);

  r = 255-r;
  g = 255-g;
  b = 255-b;

  return color(r, g, b);
}