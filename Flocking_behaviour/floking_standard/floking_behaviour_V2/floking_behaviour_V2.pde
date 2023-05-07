ArrayList <boid> flock = new ArrayList <boid> ();

void setup() {
  size(1000, 700);
  strokeWeight(10);
  for (int i = 0; i < 70; i++) {
    flock.add(new boid(new PVector (random(width), random(height))));
  }
}

void mousePressed() {

  if (mouseButton == LEFT) { 

    flock.add(new boid(new PVector(mouseX, mouseY)));
    
  }
}



void draw() {
  background(255);
  //noLoop();
  for (boid m : flock) {

    m.behave(flock);
    m.edge();
    m.move();
    stroke(50, 100);
    m.create();
  }
}
