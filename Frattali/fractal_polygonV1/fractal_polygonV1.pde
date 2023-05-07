final int n = 3;
final float angle = TWO_PI / n;


void setup() {
  size(600, 600);
  background(0);
  fractal(width / 2, height / 2, width / 3);
}

void fractal(float x, float y, float r) {

  polygon(x, y, r);

  if (r > 10) {
    for (int i = 0; i < n; i++) {
    fractal(x + cos(i * angle) * r / 2, y + sin(i * angle) * r / 2, r / 2);
    }
  }
}

void polygon(float x, float y, float r) {
  stroke(255);
  strokeWeight(0.1);
  noFill();
  beginShape();
  for (int i = 0; i < n; i++) {
    float x1 = x + (cos(i * angle) * r);
    float y1 = y + (sin(i * angle) * r);
    vertex(x1, y1);
  }
  vertex(x + r, y);
  endShape();
}
