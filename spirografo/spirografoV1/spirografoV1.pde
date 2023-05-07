cerchio [] spiro = new cerchio[4]; 
float angle = 0;

void setup() {
  size(600, 600);
  noFill();
  stroke(0);
  spiro[0] = new cerchio(0);
  spiro[0].raggio = width / 2;

  for (int i = 1; i < spiro.length; i++) {
    spiro[i] = new cerchio(0.01);
    spiro[i].raggio = spiro[i - 1].raggio / 3;
    spiro[i].x = spiro[i - 1].x;
    spiro[i].y = spiro[i - 1].y;
    spiro[i].x += /* cos(angle) * */ (spiro[i - 1].raggio + spiro[i].raggio) / 2;
  }
}

void draw() {
  background(255);


  fract();

  translate(width / 2, height / 2);

  for (cerchio c : spiro) {
    c.create();
  }


}


void fract() {

  for (int i = 1; i < spiro.length; i++) { 
    spiro[i].x =  cos(angle) * ((spiro[i - 1].raggio + spiro[i].raggio) / 2) + spiro[i - 1].x;
    spiro[i].y =  sin(angle) * ((spiro[i - 1].raggio + spiro[i].raggio) / 2) + spiro[i - 1].y;
  angle += spiro[i].vel;  
}
}
