import processing.sound.*;

// ------------ parameter control ------------ 

// --- sound ---

SinOsc main_audio;
SinOsc modulator;
LowPass lp_filter;
HighPass hp_filter;
boolean filter_enabled = true;

Amplitude amp_analyze; // get current amplitude

// --- partical ---

int particle_count = 400;
Particle[] particles;

// --- parameters that can be modified ---

float base_freq = 400;
float mod_freq = 2;
float mod_depth = 250;
float amp = 0.5;
boolean paused = false;

// ------------ particle class ------------

class Particle {
 float x;
 float y;
 float base_x;
 float base_y;
 float size;
 
 Particle(){
   base_x = random(width);
   base_y = random(height);
   size = random(2,5);
 }
 
 // revise by AI
 void update(float amp){
   
   float vibration = amp * 100;
   x = base_x + random(-vibration,vibration);
   y = base_y + random(-vibration,vibration);
   
   // --- (add) push particles ---
   float d = dist(x,y,mouseX,mouseY);
   
   if (d < 150){
    float dx = mouseX - x;
    float dy = mouseY - y;
    
    float strength = (10 - d) * -0.5;
    
    x += dx * strength;
    y += dy * strength;
    
    // using AI to write unit vector
    
   float len = sqrt(dx * dx + dy * dy);
   if (len != 0){
    dx /= len;
    dy /= len;
    }
   }
 }
 
 void display(){
   noStroke();
   fill(255,255,255);
   //ellipse(x,y,size,size);
   ellipse(x,y,size,size);
 }
}

// ------------ setup ------------

void setup(){
 size(800,800);
 
 // --- sound ---
 main_audio = new SinOsc(this);
 modulator = new SinOsc(this);
 lp_filter = new LowPass(this);
 amp_analyze = new Amplitude(this);
 hp_filter = new HighPass(this);
 
 // --- particle ---
 particles = new Particle[particle_count];
 
 for(int i = 0; i < particle_count; i++){
   particles[i] = new Particle();
 }
 
 start_sound();
}

// ------------ main loop ------------

void draw(){
  if(paused)return;
  background(0);
  
  update_sound();
  
  float current_amp = amp_analyze.analyze();
  
  for(Particle p : particles){
    p.update(current_amp);
    p.display();
  }
}

// ------------ sound production ------------

void start_sound(){
  main_audio.play();
  modulator.play();
  
  amp_analyze.input(main_audio);
  
  if (filter_enabled){
   hp_filter.process(main_audio); 
   lp_filter.process(main_audio);
  }
}


void update_sound(){
  
  amp = map(mouseY,height,0,0,1); // using mouseY to control amplitude
  main_audio.amp(amp);
  
  float freq = map(mouseX,0,width,100,1000); // using mouseX to control frequency
  
  float mod = sin(frameCount * 0.05 * mod_freq) * mod_depth; // FM modify
  
  main_audio.freq(base_freq + freq + mod);
  
  // --- filter control ---
  if(filter_enabled){
   float cutoff = map(mouseX,0,width,200,5000); // using AI 
   //hp_filter.freq(cutoff);
  }
}



// ------------ interaction ------------

void keyPressed(){
 if (key == 'f'){
  filter_enabled = !filter_enabled;
  start_sound(); // AI revise
 }
 
 if(key == ' '){
  paused = !paused; 
 }
}