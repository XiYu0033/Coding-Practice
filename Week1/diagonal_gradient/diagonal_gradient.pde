//Using AI
PImage img;
color[] c = new color[5];

void setup() {
  size(600, 800);
  colorMode(HSB); //（AI）
  
  img = loadImage("color.jpg");
  img.loadPixels();
  
  for (int i = 0; i < 5; i++) {
    c[i] = img.pixels[int(random(img.pixels.length))];
  }
  
  loadPixels();
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      
      float tAll = (x + y) / float(width + height);
      
      float seg = 1.0 / 4.0;
      int i = int(tAll / seg);
      i = constrain(i, 0, 3);
      
      float t = map(tAll, i*seg, (i+1)*seg, 0, 1);
      
      pixels[x + y*width] = lerpColor(c[i], c[i+1], t);
    }
  }
  
  updatePixels();
  noLoop();
}