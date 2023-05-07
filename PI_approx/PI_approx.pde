double approx;
int count = 0;
int countin = 0;

void setup() {

  size(650, 650);
  background(0);
  noFill();
  strokeWeight(4);

  stroke(255);
  int side = width;
  square(0, 0, side);
  circle(width / 2, height / 2, side);
}


void draw() {

  for (int i = 0; i < 100; i++) {

    float x = random(width);
    float y = random(height);

    if (dist(x, y, width / 2, height / 2) < width / 2) {

      countin++;
      stroke(0, 255, 0);
    } else if (dist(x, y, width / 2, height / 2) == width / 2) {
      stroke(0, 0, 255);
    } else {
      stroke(255, 0, 0);
    }

    count++;

    point(x, y);
  } 

  approx = 4 * float(countin) / float(count);
  println(approx);
}
