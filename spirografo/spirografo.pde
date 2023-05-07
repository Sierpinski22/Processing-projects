cerchio [] spiro = new cerchio[2]; 

void setup() {
  size(600, 600);
  noFill();
  stroke(0);
  spiro[0] = new cerchio(0, 0, width / 3);
  spiro[1] = new cerchio(0, 0, width / 6);
  spiro[1].x += (spiro[1].raggio + spiro[0].raggio) / 2;  
}

void draw() {
  background(255);
  translate(width / 2, height / 2);
  spiro[0].create();
  spiro[1].create();
}
