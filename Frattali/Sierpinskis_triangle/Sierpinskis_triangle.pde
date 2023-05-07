void setup() {

  //int lato1 = 3 * width / 4;

  size(714, 714);
  //stroke(255);
  noStroke();
  //fill(0);
}

int actualmax = 8;
int maxlevel = 1;

void keyPressed() {
  if (maxlevel == actualmax) {
    maxlevel = 1;
  } else {
    maxlevel = maxlevel + 1;
  }
}


void draw() {

  int lato1 = 3 * width / 4;

  background(0);
  sierpinski(width / 2 - lato1 / 2, height / 2 + sin(PI / 3) * lato1 / 2, lato1, 1, maxlevel);
}

void sierpinski(float x, float y, float lato, float lvnow, float lvmax) {

  if (lvnow == lvmax) { //qui
    costruz(x, y, lato);
    //print(lvnow);
  } else {  

    sierpinski(x, y, lato / 2, lvnow + 1, lvmax);
    sierpinski(x + lato / 2, y, lato / 2, lvnow + 1, lvmax);
    sierpinski(x + lato / 4, y - sin(PI / 3) * lato / 2, lato / 2, lvnow + 1, lvmax);
  }
}

void costruz(float x, float y, float lato) {
  triangle(x, y, x + lato / 2, y - sin(PI / 3) * lato, x + lato, y);
}
