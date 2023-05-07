particle [] p; 
wall [] edges;
int lato = 20;
int velo = 3;

void setup() {
  //fullScreen();
  size(1000, 650);
  noStroke();
  // background(255);
  reset();
}

void draw() {
  fill(0, 75);
  rect(0, 0, width, height);
  for (wall e : edges) {
    e.create();
  }
  for (int i = 0; i < p.length; i++) {
    p[i].move();
  }
  for (int i = 0; i < p.length; i++) {
    p[i].create();
  }
}

void keyPressed() {

  if (key == 'd' || key == 'D') {
    for (wall e : edges) {
      e.move(true);
    }
  } else if (key == 'a' || key == 'A') {
    for (wall e : edges) {
      e.move(false);
    }
  } else {
    reset();
  }
}

void reset() {
  edges = new wall[]{
    new wall(new PVector(0, 0), new PVector(velo, 0), lato, height), 
    new wall(new PVector(0, 0), new PVector(0, velo), width, lato), 
    new wall(new PVector(width - lato, 0), new PVector(-velo, 0), lato, height), 
    new wall(new PVector(0, height - lato), new PVector(0, -velo), width, lato), 
  };

  p = new particle [width / 2];

  for (int i = 0; i < p.length; i++) {
    p[i] = new particle();
  }
}
