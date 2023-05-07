void setup() {

  int lato1 = width / 3;

  size(714, 714);
  noStroke();
  background(255);
  //strokeWeight(2);
  fill(0);
  rectMode(CENTER);
  carpet(width / 2, height / 2, lato1);
}


void carpet(float x, float y, float lato) {

  rect(x, y, lato, lato);

  if (lato > 4) {

    carpet(x + lato, y + lato, lato / 3);
    carpet(x + lato, y, lato / 3);
    carpet(x - lato, y, lato / 3);
    carpet(x, y + lato, lato / 3);
    carpet(x, y - lato, lato / 3);
    carpet(x - lato, y - lato, lato / 3);
    carpet(x - lato, y + lato, lato / 3);
    carpet(x + lato, y - lato, lato / 3);
  }
}
