class obstacle {

  PVector topoint;
  float lx;
  float ly;

  obstacle() {
    topoint = new PVector (random(170, width - 200), random(0, height));
    lx = 10;
    ly = random(20, 500);
  }

  void show() {
    noStroke();
    fill(100, 100, 200);
    rectMode(CORNER);
    rect(topoint.x, topoint.y, lx, ly);
  }
}
