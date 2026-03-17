PImage picture;

void setup() {
  size(500, 500);
  picture = loadImage("sample.jpg");
}

void draw() {
  image(picture,0,0,width,height);
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    int x = i % width ;
    int y = i / width ;
    pixels[i] = color_mulfunction(x,y);
  }
  updatePixels();
}

color color_mulfunction(int x, int y) {

  float r = red(get(x+5,y));
  float g = green(get(x,y));
  float b = blue(get(x-5,y));

  return color(r,g,b);
}