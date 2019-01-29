import processing.vr.*;

Planet sun;



PImage sunTexture;
PImage moonTexture;

PImage[] textures = new PImage[4];

void setup() {
//fullScreen(P3D);
  fullScreen(PVR.MONO);
  sunTexture = loadImage("sun.jpg");
  moonTexture = loadImage("moon.jpg");
  textures[0] = loadImage("mars.jpg");
  textures[1] = loadImage("earth.jpg");
  textures[2] = loadImage("mercury.jpg");
 
  sun = new Planet(100, 0, 0, sunTexture);
  sun.spawnMoons(4, 1);
}

void draw() {
    translate(width/2,height/2);

  background(0);
  ambientLight(255,255,255);
  pointLight(255, 255, 255, 0, 0, 0);
  sun.show();
  sun.orbit();
}