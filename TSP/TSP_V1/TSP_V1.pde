travmer t;
population p;
PVector [] cities;
int maxcit = 20;

float perfect;
int maxpop = 25;
float r;
int gen = 0;
float ratio = 0;

float angle = TWO_PI / maxcit;
String tex = "Finding best path... ";

void setup() {
  size(650, 650);
  r = (width / 10) * maxcit;
  r = constrain(r, 0, width / 2 - 20);
  cities = new PVector[maxcit];
  // frameRate(10);
  p = new population();

  t = new travmer();
  for (int i = 0; i < maxcit; i++) {
    PVector c = new PVector((cos(i * angle) * r) + width / 2, (sin(i * angle) * r) + height / 2);
    // c.add(new PVector(width / 2, height / 2));
    cities[i] = c;
  }

  perfect = dist(cities[0].x, cities[0].y, cities[1].x, cities[1].y) * maxcit;
}    

void draw() {
  background(255);
  p.evaluate();
  p.selection();
  p.write();
  build();
  gen++;
  // print(gen, ' ');
  ratio = perfect / p.alltbest.sum;
  tex = tex + str(round(ratio * 100)) +"%";
  textSize(30);
  fill(0, 0, 140);
  text(tex, width / 2 - 200, height / 2); 
  tex = "Finding best path... ";
  if (round(ratio * 100) == 100) {
    print("done ");
    noLoop();
  }
}


void build() {
  fill(0);
  noStroke();
  rotate(radians(-angle));

  for (int i = 0; i < maxcit; i++) {
    circle(cities[i].x, cities[i].y, 20);
  }
}

void keyPressed() {

  if (key == ' ') {
    p = new population();
    loop();
  }
}
