PImage picture;

void setup(){
  size(500, 500);
  background(0);
  picture = loadImage("sample.jpg");
}

void draw() {
  image(picture,0,0,width,height);

  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    //pixels[i] = threshold(pixels[i],100);
    pixels[i] = posterize(pixels[i],3);
  }
  updatePixels();
}

color posterize(color pixel, int levels) {
  float r = red(pixel);
  float g = green(pixel);
  float b = blue(pixel);

  r = floor(r / 255 * levels) * (255 / levels);
  g = floor(g / 255 * levels) * (255 / levels);
  b = floor(b / 255 * levels) * (255 / levels);

  return color(r,g,b);
}