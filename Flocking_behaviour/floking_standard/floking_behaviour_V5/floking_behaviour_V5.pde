ArrayList <boid> flock = new ArrayList <boid> ();

void setup() {//idea: simulare la diffusione di una malattia
  //rectMode(CENTER);
  //frameRate(100);
  fullScreen();
  //size(1000, 700);
  strokeWeight(10);
  for (int i = 0; i < 100; i++) {
    flock.add(new boid(new PVector (random(width), random(height))));
  }
}

void keyPressed() {
  PVector spawn = new PVector (mouseX, mouseY);
  if (key == 'a' || key == 'A') { 
    flock.add(new anarchist(spawn));
  } else if (key == 'l' || key == 'L') {
    flock.add(new lover(spawn));
  } else if (key == 's' || key == 'S') {  
    flock.add(new slow(spawn));
  } else if (key == 'b' || key == 'B') {
    flock.add(new boid(spawn));
  } else if (key == 'r' || key == 'R') {
    if (flock.size() > 0) {
      flock.remove(0);
    }
  }
}

void draw() {
 
  
 //fill(0, 75); rect(0, 0, width, height);
 background(0);
  
  
  //noLoop();
  for (boid m : flock) {

    m.behave(flock);
    m.edge();
    m.move();
    //stroke(50, 100);
    m.create();
  }
}
