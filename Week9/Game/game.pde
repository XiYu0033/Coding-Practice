
// ----- global variable -----

ArrayList<Obstacle> obstacles;
ArrayList<Boost> boosts;

ArrayList<Mountain> farMountains;
ArrayList<Mountain> midMountains;
ArrayList<Mountain> nearMountains;

PVector pos, vel, acc;

float groundY;

int score = 0;
boolean gameOver = false;

float baseSpeed = 4;
float speed = 3;

int boostTimer = 0;  
int boostDuration = 120; //Using AI,framerate 60z = 1s


// Using AI:Character PNG, character refer: https://pixlab24.com/character/55725/

PImage[] runImgs = new PImage[4];
PImage jumpImg;

int frameIndex = 0;
int frameDelay = 10; 
int frameCounter = 0;

// Using AI:Obstacle PNG
PImage[] obstacleImgs = new PImage[3];

PImage boostImg;

PFont pixelFont;



void setup() {
  size(800, 600);
  
  pos = new PVector(150, 300);
  vel = new PVector(0, 0);
  acc = new PVector(0, 0.6);
  
  groundY = height - 80;
  
  obstacles = new ArrayList<Obstacle>();
  boosts = new ArrayList<Boost>();
  
  // setup mountain
  farMountains = new ArrayList<Mountain>();
  midMountains = new ArrayList<Mountain>();
  nearMountains = new ArrayList<Mountain>();

  for (int i = 0; i < 6; i++) {
    farMountains.add(new Mountain(i * 200, 0.3, color(20, 100, 20)));
    midMountains.add(new Mountain(i * 200, 0.5, color(34, 139, 34)));
    nearMountains.add(new Mountain(i * 200, 0.8, color(50, 180, 50)));
  }
  
  for (int i = 0; i < 4; i++) {
    runImgs[i] = loadImage("run" + i + ".png");
  }
  
  jumpImg = loadImage("jump.png");
  
  for (int i = 0;i < 3;i++){
    obstacleImgs[i] = loadImage("obstacle" + i + ".png");
  }
  
  pixelFont = createFont("PressStart2P-Regular.ttf",32);
  textFont(pixelFont);
  
  boostImg = loadImage("boost.png");
 
}


void draw() {
  background(135, 206, 235);
  
  drawMountains();
  drawGround();
  
  if (!gameOver) {
    
    if (boostTimer > 0) {
      boostTimer--;
    } else {
      speed = baseSpeed; 
    }
    
    updateAnimation();
    
    updatePlayer();
    spawnObjects();
    updateObjects();
    checkCollision();
    
    speed = lerp(speed, (boostTimer > 0 ? 7 : baseSpeed), 0.1);
  }
  
  drawPlayer();
  drawScore();
  
  if (gameOver) {
    textAlign(CENTER);
    textSize(60);
    fill(255, 255, 255);
    text("Game Over!", width/2, height/2);
    textSize(30);
    text("Press 'r' to reset",width/2,height/2 + 50);
  }
}


boolean isOnGround() {
  return pos.y >= groundY;
}


void updateAnimation() {
  if (isOnGround()) {
    frameCounter++;
    
    if (frameCounter >= frameDelay) {
      frameCounter = 0;
      frameIndex = (frameIndex + 1) % 4;
    }
  } else {
    frameIndex = 0;
  }
}


// player


void updatePlayer() {
  vel.add(acc);
  pos.add(vel);
  
  if (pos.y > groundY) {
    pos.y = groundY;
    vel.y = 0;
  }
}


void drawPlayer() {
  imageMode(CENTER);
  
  if (isOnGround()) {
    image(runImgs[frameIndex], pos.x, pos.y, 50, 50);// "frameIndex":using AI to revise
  } else {
    image(jumpImg, pos.x, pos.y, 50, 50);
  }
}

void keyPressed() {
  if (key == ' ' && !gameOver) {
    if (pos.y >= groundY) {
      vel.y = -12;
    }
  }
  
  if (key == 'r') {
    resetGame();
  }
}

// draw ground
void drawGround() {
  noStroke();
  fill(139, 69, 19);
  rect(0, groundY + 20, width, height);
}


// draw background mountain
void drawMountains() {
  for (Mountain m : farMountains) {
    m.update();
    m.display();
  }

  for (Mountain m : midMountains) {
    m.update();
    m.display();
  }

  for (Mountain m : nearMountains) {
    m.update();
    m.display();
  }
}

// draw score
void drawScore() {
  fill(0);
  textSize(24);
  textAlign(LEFT);
  text("Score: " + score, 20, 40);
}


void spawnObjects() {
  if (frameCount % 90 == 0) {
    obstacles.add(new Obstacle(width));
  }
  
  if (frameCount % 300 == 0) {
    boosts.add(new Boost(width));
  }
}

void updateObjects() {
  for (Obstacle o : obstacles) {
    o.update();
    o.display();
    
    //score
    if (!o.passed && o.x < pos.x) {
      o.passed = true;
      score++;
    }
  }
  
  for (Boost b : boosts) {
    b.update();
    b.display();
  }
}



// collision obstacle and boost
void checkCollision() {
  for (Obstacle o : obstacles) {
    if (o.hit(pos.x, pos.y, 20)) {
      gameOver = true;
    }
  }
  
  for(int i = boosts.size() - 1;i >= 0;i--){
    Boost b = boosts.get(i);
    
    if(b.hit(pos.x,pos.y,20)){
      
     score += 5;
     
     boostTimer = max(boostTimer,boostDuration);
     boosts.remove(i);
    } else if (b.x < -50){
     boosts.remove(i); 
    }
  }
}



void resetGame() {
  pos = new PVector(150, 300);
  vel = new PVector(0, 0);
  
  obstacles.clear();
  boosts.clear();
  
  score = 0;
  speed = 4;
  gameOver = false;
}



// obstacle
class Obstacle {
  int type;
  float x;
  float w = 30;
  float h = random(40, 80);
  boolean passed = false;
  
  Obstacle(float startX) {
    x = startX;
    type = int(random(3));
  }
  
  void update() {
    x -= speed;
  }
  
  void display() {
    imageMode(CORNER);
    image(obstacleImgs[type],x,groundY + 20 - h,w,h);
  }
  
  boolean hit(float px, float py, float r) {
    float hitX = x + w * 0.2;
    float hitW = w * 0.6;
    return (px + r > hitX && 
            px - r < hitX + hitW &&
            py + r > groundY + 20 - h);
  }
}

// boost
class Boost {
  float x;
  float size = 20;
  
  Boost(float startX) {
    x = startX;
  }
  
  void update() {
    x -= speed;
  }
  
  void display() {
    imageMode(CENTER);
    image(boostImg,x + size/2, groundY, size, size);
  }
  
  boolean hit(float px, float py, float r) {
    return dist(px, py, x + size/2, groundY) < r + size/2;
  }
}

// mountain
class Mountain {
  float x;
  float w = 200;
  float h;
  
  float layerSpeed;
  color col; 
  
  Mountain(float startX, float speedFactor, color c) {
    x = startX;
    layerSpeed = speedFactor;
    col = c;
    h = random(80, 400);
  }
  
  void update() {
    x -= speed * layerSpeed;
    
    if (x < -w) {
      x = width + w;
      h = random(80, 400);
    }
  }
  
  void display() {
    fill(col);
    noStroke();
    triangle(x, groundY + 20,
             x + w/2, groundY + 20 - h,
             x + w, groundY + 20);
  }
}