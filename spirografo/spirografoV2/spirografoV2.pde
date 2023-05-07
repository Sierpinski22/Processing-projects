cerchio c;
cerchio end;

ArrayList <PVector> path;
int maxc = 15;
int resolution = 50;

boolean done = false;

void setup() {
  size(600, 600);
  //background(0);
  // noFill();
  maxc--;
  c = new cerchio(width / 2, height / 2, width / 4);
  path = new ArrayList ();
  cerchio next = c.addChild();

  for (int i = 0; i < maxc; i++) {    
    next = next.addChild();
  }

  end = next;
}

void mousePressed() {

  done = !done;
}


void draw() {
  background(51);


  for (int i = 0; i < resolution; i++) {
    cerchio next = c;
    while (next != null) {
      next.move();
      next = next.child;
    }
    if (!done) {
      path.add(new PVector(end.x, end.y));
    }
  }

  //print(done);
  cerchio next = c;
  while (next != null) {
    next.create();
    next = next.child;
  }



  beginShape();
  stroke(255);
  noFill();
  for (PVector pos : path) {
    vertex(pos.x, pos.y);
  }
  endShape();
}
