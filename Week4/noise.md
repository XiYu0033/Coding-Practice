PImage img;

void setup() {
  size(600, 600);
  img = loadImage("sample.jpg");
  img.resize(width, height);
}

void draw() {

  loadPixels();
  img.loadPixels();
  float scale = 0.02;

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      float n = noise(x * scale, y * scale);
      int offset = int(n * 100);
      int new_xpos = constrain(x + offset, 0, width-1);

      pixels[x + y*width] = img.pixels[new_xpos + y*width];
    }
  }
  
  
  updatePixels();
}