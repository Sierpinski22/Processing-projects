int n = 6;
final float angle = TWO_PI / n;
int maxlev = 1;
int actualmax;

void setup() {
  size(700, 700);
  background(0);
  strokeWeight(0.5);
  stroke(255);

  if (n < 6) {
    actualmax = 8;
  } else if (n < 10) {
    actualmax = 7;
  } else {
    actualmax = 4;
  }

  fractal(width / 2, height / 2, width / 2, 1, maxlev);
}

void fractal(float x, float y, float r, int now, int max) {


  if (now == max) {
    polygon(x, y, r);
  } else {
    for (int i = 0; i < n; i++) {
      fractal(x + cos(i * angle) * r / 2, y + sin(i * angle) * r / 2, r / 2, now + 1, max);
    }
  }
}

void draw() {
}

void mousePressed() {
  background(0);
  maxlev = maxlev < actualmax ? maxlev + 1 : 1;
  fractal(width / 2, height / 2, width / 2, 1, maxlev);
}

void keyPressed() {
  saveFrame();
  print("done");
}

void polygon(float x, float y, float r) {

  noFill();
  beginShape();
  for (int i = 0; i <= n; i++) {
    float x1 = x + (cos(i * angle) * r);
    float y1 = y + (sin(i * angle) * r);
    vertex(x1, y1);
  }
  endShape();
}
