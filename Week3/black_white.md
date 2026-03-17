void setup() {
  size(400,400);
  noStroke();
  
  background(0, 0, 120); // color reference: https://www.codeeeee.com/color/rgb.html

  for (int x = 0; x < width; x += 40) {
    for (int y = 0; y < height; y += 40) {
      int p = (x + y) / 40 % 2;  
      if (p == 0) fill(0);      
      else fill(255);           
      ellipse(x + 20, y + 20, 30, 30); 
    }
  }
}