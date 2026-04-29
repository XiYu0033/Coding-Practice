import processing.video.*;

Capture cam;

void setup() {
  size(600, 600);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    //cam = new Capture(this, 640,480,cameras[0], 30);
    cam = new Capture(this, cameras[1]); 
    
    cam.start();     
  }      
}

void draw() {
  // every frame, if the camera is ready, we update `cam` to have
  // the latest data from it
  if (cam.available() == true) {
    cam.read();
  }
  
  // this next line is for TESTING
  // once the image appears on screen, delete it, and uncomment the code below
  image(cam,0,0,width, height);
  
  loadPixels();
  cam.loadPixels();

  for (int i = 0; i < pixels.length; i++) {
    //pixels[i] = threshold(pixels[i],100);
    pixels[i] = invert(pixels[i]);// invert() / posterize()
  }
  updatePixels();
}


void keyPressed() {
  // pressing S will save the current frame to disk
  if(key == 's') {
    saveFrame("frame-######.jpg");
  }
}

color invert(color pixel) {
  float r = red(pixel);
  float g = green(pixel);
  float b = blue(pixel);

  r = 255-r;
  g = 255-g;
  b = 255-b;

  return color(r, g, b);
}


color posterize(color pixel, int levels) {
  float r = red(pixel);
  float g = green(pixel);
  float b = blue(pixel);

  r = floor(r / 255 * levels) * (255 / levels);
  g = floor(g / 255 * levels) * (255 / levels);
  b = floor(b / 255 * levels) * (255 / levels);

  return color(r,g,b);
}

/*

import processing.video.*;

Capture cam;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();
  printArray(cameras);

  cam = new Capture(this, cameras[1]); 
  cam.start();
}

/*void draw() {
  if (cam.available()) {
    cam.read();
  }
  image(cam, 0, 0);
}
void draw() {
  if (cam.available()) {
    cam.read();
    image(cam, 0, 0);
  } else {
    background(0);
    fill(255);
    text("Waiting for camera...", 20, 20);
  }
}
*/