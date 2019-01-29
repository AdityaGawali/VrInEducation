import processing.vr.*;

PShape sphere;                                       // 1
PImage[] textures = new PImage[11];  
int k=0;
int flag;
void setup() {

  //fullScreen(P3D);
  fullScreen(PVR.MONO);
  noStroke();
  fill(255);

  textures[0] = loadImage("sun.jpg");
  textures[1] = loadImage("mercury.jpg");
  textures[2] = loadImage("venus.jpg");
  textures[3] = loadImage("earth.jpg");
  textures[4] = loadImage("moon.jpg");
  textures[5] = loadImage("mars.jpg");
  textures[6] = loadImage("jupiter.jpg");
  textures[7] = loadImage("saturn.jpg");
  textures[8] = loadImage("uranus.jpg");
  textures[9] = loadImage("neptune.jpg");
  textures[10] = loadImage("pluto.jpg");
           
         
  sphere = createShape(SPHERE, 150);           // 4
  sphere.setTexture(textures[0]);                 // 5
}

void draw() {
 // background(0);
  background(0);
  pushMatrix();
  translate(width/2, height/2, 0);  
  rotateY(TWO_PI * frameCount / 600);                    // 6
  shape(sphere);
  popMatrix();
}
 
 void setNewTexture(int ind)
  {
   PShape ssphere = createShape(SPHERE, 150);           // 4
   println(ind);
   ssphere.setTexture(textures[ind]);  
   sphere= ssphere;
  }
  void mousePressed()
  { 
    flag=1;
    if(mouseX>width/2 && flag==1)
    {
      k = k!=(textures.length-1)?k+1:k;
      // println(k);
      setNewTexture(k);
      flag=0;
      //println(k);
    }
    else if(mouseX<width/2 && flag==1)
    {
       k = k!=0?k-1:k;
      // println(k);
      setNewTexture(k);
      flag=0;
      //println(k);
    }
  }
 //println(width/2);