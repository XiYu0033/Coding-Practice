PImage picture;

void setup() {
  size(500, 500);
  background(0);
  picture = loadImage("sample3.jpg");
  //picture.loadPixels();
  
}

void draw() {
  image(picture,0,0,width,height);

  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    //pixels[i] = threshold(pixels[i],100);
    pixels[i] = invert(pixels[i]);
  }
  updatePixels();
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