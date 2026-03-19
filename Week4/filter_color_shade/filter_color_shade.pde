PImage picture;

void setup() {
  size(500, 500);
  picture = loadImage("sample.jpg");
}

void draw() {
  image(picture, 0, 0, width, height);

  loadPixels();
  
//Using AI to revise
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {

      int loc = x + y * width;

      float d = dist(mouseX, mouseY, x, y);

      if (d < 150) { 
        pixels[loc] = invert(pixels[loc]);
      }
    }
  }

  updatePixels();
}

color invert(color pixel) {
  float r = red(pixel);
  float g = green(pixel);
  float b = blue(pixel);

  r = 255 - r;
  g = 255 - g;
  b = 255 - b;

  return color(r, g, b);
}