int k = -4; //n lobi / punte = abs(k) + 1

class cerchio {

  float x;
  float y;
  float radius;
  cerchio parent;
  cerchio child = null;
  float vel;
  int n;
  float angle = 0;

  cerchio(float x_, float y_, float r_, int level, cerchio p) {

    x = x_;
    y = y_;
    n = level;
    radius = r_;
    parent = p;
    vel = radians(pow(k, n-1))/resolution;
    angle = - PI / 2;
  }


  cerchio(float x_, float y_, float r_) {   
    this(x_, y_, r_, 0, null);
  }

  cerchio addChild() {

    float newrad = radius / 3.0;
    float newx = x + radius + newrad;
    float newy = y;
    child = new cerchio(newx, newy, newrad, n + 1, this);
    return child;
  }

  void move() {

    if (parent != null) {
      angle += vel;
      float sum = parent.radius + radius;
      x =  parent.x + cos(angle) * sum;
      y =  parent.y + sin(angle) * sum;
    }
  }



  void create() {
    
   stroke(0); 
   strokeWeight(1);
    if (parent != null) {
      line(parent.x, parent.y, x, y);
    }
    fill(100, 100);
    ellipse(x, y, radius * 2, radius * 2);
  }
}
