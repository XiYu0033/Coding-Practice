PImage img;
color[] c = new color[5];

void setup() {
  size(600, 800);
  
  img = loadImage("color.jpg");
  img.loadPixels();
  
  // ramdomly extract 5 color
  for (int i = 0; i < 5; i++) {
    c[i] = img.pixels[int(random(img.pixels.length))];
  }

  // verticle gradient(for loop using ChatGPT)
  
  float seg = height / 4.0;
  
  for (int y = 0; y < height; y++) {
    int i = int(y / seg);
    i = constrain(i, 0, 3);
    
    float t = map(y, i*seg, (i+1)*seg, 0, 1);
    stroke(lerpColor(c[i], c[i+1], t));
    line(0, y, width, y);
  }
  
  noLoop();
}
