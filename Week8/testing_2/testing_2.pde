import processing.sound.*;

SoundFile sample_drum1;
SoundFile sample_drum2;
SoundFile sample_main;
SoundFile sample_drum3;

FFT fft;
int bands = 256;
float[] spectrum = new float[bands];

PImage waterfall;

float bpm = 120;
float beatInterval;
float lastBeatTime = 0;
int step = 0;
// float myFrameRate = bpm / 60;

float flash = 0;
float shakeAmount = 0;


void setup() {
  size(800, 400);
  //background(255);

  sample_drum1 = new SoundFile(this, "high_drum.wav");
  sample_drum2 = new SoundFile(this, "low_drum.wav");
  sample_main = new SoundFile(this, "main.wav");
  sample_drum3 = new SoundFile(this, "drum3.wav");
  
  fft = new FFT(this,bands);
  fft.input(sample_main);
  waterfall = createImage(width,height,RGB);
  
  frameRate(60);
  beatInterval = 60000.0 / bpm;
  //frameRate(bpm);
  
  sample_main.amp(0.5);
  sample_main.play();
}

void draw(){
  fft.analyze(spectrum);
  
  float bass = 0;
  
  for(int i = 0;i < 10;i++){
    bass += spectrum[i];
  }
  
  if(bass > 0.5){
   flash = 255; 
   shakeAmount = 20;
  }
  
  waterfall.loadPixels();
  for(int y = height - 1;y > 0;y--){
    for(int x = 0;x < width;x++){
      waterfall.pixels[y * width+x] = waterfall.pixels[(y-1)*width + x];
    }
  }
  
  for(int i = 0; i < bands; i++){
    
  //int x = int(map(i,0,bands,0,width));
  float logIndex = log(i+1);
  float logMax = log(bands);
  
    shakeAmount *= 0.9; 
  
  
  int x = int(map(logIndex,0,logMax,0,width));
  float energy = spectrum[i] * (i < 20? 5:1);
  
  int c = color(energy * 255, energy * 150,255);
  waterfall.pixels[x] = c;
  }
  
  waterfall.updatePixels();
  
  image(waterfall,0,0);
  
  /*if(flash > 20){
   fill(255,flash);
   rect(0,0,width,height);
   
   flash *= 0.85;
  }
  */
  
  /*if (frameCount % 4 == 0){
    //sample_drum1.play();
    sample_drum3.play();
  }*/
  
  // Revise by AI(ChatGPT)
  if(millis() - lastBeatTime > beatInterval){
    if(step % 4 == 0){
      sample_drum3.play();
    }
    
    step++;
    lastBeatTime = millis();
  }
  //sample_drum1.play();
}
