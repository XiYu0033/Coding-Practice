PImage img;

int[] histR = new int[256];
int[] histG = new int[256];
int[] histB = new int[256];

void setup() {

  size(600,600);
  
  img = loadImage("sample1.jpg");
}

void draw() {
  background(0);
  image(img,0,0,width,height);

//clean up the histrogram

  for(int i=0;i<256;i++){
    histR[i] = 0;
    histG[i] = 0;
    histB[i] = 0;
  }
  img.loadPixels();

  for(int i=0;i<img.pixels.length;i++){
    int c = img.pixels[i];
    
    int r = int(red(c));
    int g = int(green(c));
    int b = int(blue(c));

    histR[r]++;
    histG[g]++;
    histB[b]++;
  }

//finding the maximun
  int maxVal = 0;

  for(int i=0;i<256;i++){
    maxVal = max(maxVal, histR[i]);
    maxVal = max(maxVal, histG[i]);
    maxVal = max(maxVal, histB[i]);
  }

//draw histrogram(Using AI to revise the code)
  float histHeight = height/3.0;

  for(int i=0;i<256;i++){

    float x = map(i,0,255,0,width);

    float rHeight = map(histR[i],0,maxVal,0,histHeight);
    float gHeight = map(histG[i],0,maxVal,0,histHeight);
    float bHeight = map(histB[i],0,maxVal,0,histHeight);
//red
    stroke(255,0,0,150);
    line(x,height, x,height-rHeight);
//green
    stroke(0,255,0,150);
    line(x,height, x,height-gHeight);
//blue
    stroke(0,0,255,150);
    line(x,height, x,height-bHeight);
  }
}