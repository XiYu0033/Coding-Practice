PImage img;
color[] c = new color[5];

void setup() {
  size(600, 200);
  
  img = loadImage("color.jpg");
  img.loadPixels();
  
  // ramdomly extract 5 colors
  for (int i = 0; i < 5; i++) {
    int index = int(random(img.pixels.length));
    c[i] = img.pixels[index];
  }
  
  background(255);
  
  // 5 color block
  for (int i = 0; i < 5; i++) {
    fill(c[i]);
    rect(i * width/5, 0, width/5, 80);
  }
  
  // color gradient
  for (int x = 0; x < width; x++) {
    float seg = width / 4.0;
    int i = int(x / seg);
    i = constrain(i, 0, 3);
    
    float t = map(x, i*seg, (i+1)*seg, 0, 1);
    stroke(lerpColor(c[i], c[i+1], t));
    line(x, 100, x, 180);
  }
  
  noLoop();
}
