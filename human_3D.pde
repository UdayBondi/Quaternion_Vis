PVector pos = new PVector(0, 0, 0);
PVector gridPos = new PVector(0, 0, 0);

float camYAng, camXAng;

float camYAngV, camXAngV;

boolean showText = true;
float transparancy;
boolean transparancyUp;

taillessMonkey human;

void setup() {
  size(500, 500, P3D);
  smooth();
  human = new taillessMonkey(new PVector(0,0,0),180,0.15,0.07,20,0.37,0.115,0.11,0.1,0.06,0.05,0.06,0.01,0.05,0.0525,0.055,0.05,0.0525,0.05,0.035,0.04,0.035,0.03,0.035,0.035,0.1,0.01,0.035,0.1,0.1,0.05);
}

void draw() {
  background(0);
  
  pushMatrix();
  world();
  human.be();
  popMatrix();
  
  human.userControl();
  
}