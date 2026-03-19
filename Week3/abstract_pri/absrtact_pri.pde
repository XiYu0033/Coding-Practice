void setup() {
  size(600, 600);
  background(20);
  noStroke();

//elipse
  for (int i = 0; i < 15; i++) {
    fill(random(255), random(255), random(255), 120);
    ellipse(random(width), random(height), random(50, 150), random(50, 150));
  }
  
//rect
  for (int i = 0; i < 10; i++) {
    fill(random(255), random(255), random(255), 150);
    rect(random(width), random(height), random(40, 120), random(40, 120));
  }

//triangle
  for (int i = 0; i < 8; i++) {
    fill(random(255), random(255), random(255), 180);
    triangle(
      random(width), random(height),
      random(width), random(height),
      random(width), random(height)
    );
  }

//arc
  noFill();
  strokeWeight(3);
  for (int i = 0; i < 8; i++) {
    stroke(random(255), random(255), random(255), 200);
    arc(
      random(width), random(height),
      random(50, 150), random(50, 150),
      random(TWO_PI), random(TWO_PI)
    );
  }

//Line
  strokeWeight(1);
  for (int i = 0; i < 20; i++) {
    stroke(random(255), random(255), random(255), 120);
    line(
      random(width), random(height),
      random(width), random(height)
    );
  }
}