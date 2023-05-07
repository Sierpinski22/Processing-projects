int n = 5;
int cols, rows, side, interval;
float [] cx;
float radius, angle, da;
boolean lines = false;

void setup() {
  size(600, 600);
  background(0);
  colorMode(HSB);
  side = width / (n + 1); 
  radius = 1.5 * side / 4; 
  interval = 100;

  cx = new float [n];
  angle = 0;
  da = TWO_PI / 300;

  for (int i = 0; i < n; i++) {
    cx[i] = 0;
  }
}

int c = 0;

void draw() {
  fill(0, 2);
  rect(0, 0, width, height);
  float off1, off2;


  //aggiorna i cerchi
  for (int i = 0; i < n; i++) {
    off1 = (i + 1.5) * side;
    off2 = 0.5 * side;

    cx[i] += da * (i + 1); 

    noFill();
    strokeWeight(4);
    stroke(255);
    //cerchi guida
    circle(off1, off2, radius * 2);
    circle(off2, off1, radius * 2);

    noStroke();
    fill(300, 0, 300);
    //cerchi mobili
    circle(off1 + cos(cx[i]) * radius, off2 + sin(cx[i]) * radius, radius / 3);
    circle(off2 + cos(cx[i]) * radius, off1 + sin(cx[i]) * radius, radius / 3);
  }

  for (int i = 0; i < n; i++) {
    for (int k = 0; k < n; k++) {

      //linee
      if (k == n-1 && lines) {
        stroke(c, 300, 300);
        line((i + 1.5) * side + cos(cx[i]) * radius, 0.5 * side + sin(cx[i]) * radius, (i + 1.5) * side + cos(cx[i]) * radius, (k + 1.5) * side + sin(cx[k]) * radius);
      }
      if (i == n-1 && lines) {
        stroke(c, 300, 300);
        line(0.5 * side + cos(cx[k]) * radius, (k + 1.5) * side + sin(cx[k]) * radius, (i + 1.5) * side + cos(cx[i]) * radius, (k + 1.5) * side + sin(cx[k]) * radius);
      }
      
      // curve
      noStroke();
      fill(c, 300, 300);
      circle((i + 1.5) * side + cos(cx[i]) * radius, (k + 1.5) * side + sin(cx[k]) * radius, 7);
    }
  }
  c = (c + 3) % 300;
}
