//Using AI
PImage img;
color[] c = new color[5];

void setup() {
  size(600, 800);
  colorMode(HSB);   // 推荐开启
  
  img = loadImage("color.jpg");
  img.loadPixels();
  
  // 随机提取5个颜色
  for (int i = 0; i < 5; i++) {
    c[i] = img.pixels[int(random(img.pixels.length))];
  }
  
  float cx = width / 2;
  float cy = height / 2;
  
  loadPixels();
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      
      float angle = atan2(y - cy, x - cx);   // -PI ~ PI
      
      // 转换到 0 ~ 1
      float tAll = map(angle, -PI, PI, 0, 1);
      
      // 5色分段
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