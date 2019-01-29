class Point
{
  float px,py,pz,x, y, z, depthpt,depthln;
  Point(float x_, float y_, float z_)
  {
    x = x_;
    y = y_; 
    z = z_;
  }
  Point(Point pt)
  {
    this.x=pt.x;
    this.y=pt.y;
    this.z=pt.z;
  }
  void drawLine(Point pt)
  {
    depthln=map(z,0,640,255,0);
    //stroke(255,depthln,0);
    strokeWeight(3);
    line(this.x,this.y,this.z,pt.x,pt.y,pt.z);
    /*PShape lines = createShape();
   lines.beginShape(POINTS);
   lines.vertex(this.x,this.y,this.z);
   lines.vertex(pt.x,pt.y,pt.z);
   lines.endShape();
   shape(lines);*/
  }

  void display()
  {
    pushMatrix();
    depthpt=map(z, 0, 640, 255, 0);
    strokeWeight(1);
    translate(x, y, z);
    fill(255, depthpt, 0);
    //lights();
    box(20);
    popMatrix();
    noFill();
  }
}                       