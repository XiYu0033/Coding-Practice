void setup() {
  size(600,600);
  background(0);
  rectMode(CENTER);
  noStroke();

  blendMode(DIFFERENCE);

//loop to bespread the canvas
  for (int x = 50; x < width; x += 100) {
    for (int y = 50; y < height; y += 100) {

      fill(random(255), random(255), random(255));
      rect(x, y, 80, 80);

      fill(random(255), random(255), random(255));
      ellipse(x+20, y+20, 80, 80);

      fill(random(255), random(255), random(255));
      triangle(
        x-30, y+40,
        x+30, y+40,
        x, y-40
      );
    }
  }
}