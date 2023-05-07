int lato1;

void setup() {
  size(600, 600);
  lato1 = 2 * width / 5;
  strokeWeight(1);
  stroke(255, 255, 255, 200);
}

boolean to_draw = true;
int actualmax = 6;
int maxlevel = 0;
float x1 = 0;
float y1 = 0;
int col = 255 / (actualmax + 1);

void skeleton(float x, float y, float side, int lvnow) {
  if (lvnow <= maxlevel) {
    x1 = x;
    y1 = y - side;
    line(x, y, x1, y1);
    ellipse(x1, y1, side / 10, side / 10);
    skeleton(x1, y1, side / 2, lvnow + 1);
    x1 = x + cos(-PI / 6) * side;
    y1 = y - sin(-PI / 6) * side;
    line(x, y, x1, y1);
    ellipse(x1, y1, side / 10, side / 10);
    skeleton(x1, y1, side / 2, lvnow + 1);
    x1 = x + cos(PI + PI / 6) * side;
    y1 = y - sin(PI + PI / 6) * side;
    ellipse(x1, y1, side / 10, side / 10);
    line(x, y, x1, y1);
    skeleton(x1, y1, side / 2, lvnow + 1);
  }
}

void draw() {
  if (to_draw) {
    background(0);
    ellipse(width / 2, height / 2, lato1 / 10, lato1 / 10);
    skeleton(width / 2, height / 2, lato1 / 2, 0);
    to_draw = false;
  }
}


void mousePressed() {
  maxlevel = maxlevel < actualmax ? maxlevel + 1 : 0; 
  to_draw = true;
}
