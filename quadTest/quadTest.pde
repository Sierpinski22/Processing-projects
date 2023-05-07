quadtree q;
spatialHash s;
int x=0, y=0, w=100, h=100;
int n = 3000;

particle [] p;

void setup() {
  size(600, 600);
  q = new quadtree(0, 0, width, height, 0);
  s = new spatialHash(width, height, 10);
  p = new particle[n];

  for (int i=0; i<n; i++) p[i] = new particle(int(random(0, width)), int(random(0, height)));
}

void quadThing() {
  convertAndInsert(p, q);
  noStroke();
  ArrayList <float []> in = new ArrayList <float []>();
  q.toroidalQuery(mouseX-100, mouseY-100, 200, 200, in, width, height);
  for (int j=0; j<n; j++) p[j].move(q);
  for (float [] i : in) {
    fill(0, 0, 255);
    circle(i[0], i[1], 10);
  }
  
  q.showStructure();
  q.eliminate();
}

void hashThing() {
  noStroke();
  convertAndInsert2(p, s);
  ArrayList <Integer> in = new ArrayList <Integer>();
  for (int j=0; j<n; j++) p[j].move2(s, p);
  s.query(mouseX, mouseY, in);
  for (int i : in) {
    fill(0, 0, 255);
    
    circle(p[i].x, p[i].y, 10);
  }
  s.show();
  s.eliminate();
}


void draw() {
  background(0);
  quadThing();

  noStroke();
  noFill();
  stroke(0, 0, 255);
  rect(mouseX-100, mouseY-100, 200, 200);
  print(frameRate, '\n');
}
