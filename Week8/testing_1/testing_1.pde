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
  size(1200, 400);
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
  
  shakeAmount *= 0.9; 
  
  waterfall.loadPixels();
  for(int y = height - 1;y > 0;y--){
    for(int x = 0;x < width;x++){
      waterfall.pixels[y * width+x] = waterfall.pixels[(y-1)*width + x];
    }
  }
  
  for(int i = 0; i < bands; i+=(i < 40? 1:12)){
    
  //int x = int(map(i,0,bands,0,width));
  float logIndex = pow(log(i+1),1.5);
  float logMax = pow(log(bands),1.5);
   
  
  //int x = int(map(logIndex,0,logMax,0,width));
  
  float baseX = map(logIndex,0,logMax,0,width);
  
  // Write by AI
  float offset = sin(frameRate*0.2 + i * 0.1) * shakeAmount
                 +random(-shakeAmount,shakeAmount)*0.3;
  int x = int(baseX + offset);
  
  x = constrain(x,0,width-1);
                 
  float energy = spectrum[i];
  if(i<10)energy*=1;
  if(i>40)energy*=0.03;
  
  if(energy < 0.04) continue;

  
  float fade = map(i,0,bands,1.0,0.3);
  
  int c = color(energy * 255*fade, energy * 150*fade,255*fade);
  
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
