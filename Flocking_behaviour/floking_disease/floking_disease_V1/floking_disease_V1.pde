ArrayList <boid> flock = new ArrayList <boid> ();

void setup() {
  colorMode(HSB);  

  size(1000, 700);

  for (int i = 0; i < 150; i++) {
    flock.add(new boid(random(0, 254), new PVector (random(width), random(height))));
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    flock.add(new boid(255, new PVector (mouseX, mouseY)));
  }
}
void draw() {
  background(255);
  //noLoop();
  for (boid m : flock) {

    m.behave(flock);
    m.edge();
    m.move();
    m.create();
  }
}
