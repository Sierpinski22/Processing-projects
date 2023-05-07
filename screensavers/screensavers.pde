float inc = 0.005;
int r1 = 200, n = 22, amp = 10;
float boost1 = 0.5, boost2 = 0.25;
int r2 = 125, r3 = 50;
int t = 0;

void setup() {
  size(600, 600);
  blendMode(BLEND);
  stroke(255);
  strokeWeight(2);
  background(0);
}

void draw() {
  background(0);
  fill(255);
  translate(width / 2, height / 2);
  for (int i = 0; i < n; i++) {
    
    stroke(#94F08C);
    line(r3 * sin(3*(-t)*inc*boost2+i*amp+HALF_PI), r3 * sin(2*(-t)*inc*boost2+i*amp), r3 * sin((-2*t)*inc*boost2+HALF_PI+i*amp), r3 * sin((-3*t)*inc*boost2+i*amp));
    stroke(#2FB224);
    line(r2 * sin(3*(-t)*inc*boost1+i*amp+HALF_PI), r2 * sin(2*(-t)*inc*boost1+i*amp), r2 * sin((-2*t)*inc*boost1+HALF_PI+i*amp), r2 * sin((-3*t)*inc*boost1+i*amp)); //linea principale bella
    stroke(#178B8E);
    line(r1 * sin(3*(t)*inc+ i*amp+HALF_PI), r1 * sin(2*(t)*inc+ i*amp), r1 * sin(2*(t)*inc +HALF_PI+i*amp), r1 * sin(3*(t)*inc+ i*amp)); //linea elliyica
  }

  t = t!=10000?t+1:0;
}
