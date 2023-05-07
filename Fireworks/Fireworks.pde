ArrayList <firework> f = new ArrayList <firework> ();
float plife = 80;
float flife = 175;

void setup() {
  fullScreen();
  noStroke();
  rectMode(CENTER);
  colorMode(HSB, 100);

  for (int i = 0; i < 10; i++) {
    f.add(new firework());
  }
}

void draw() {

  fill(0, 15);
  rect(width / 2, height / 2, width , height);
  
  for (int i = 0; i < f.size(); i++) {
    firework a = f.get(i);
    a.move();
    a.create();
    if (a.life + plife + flife <= 0) {
      f.remove(i);
    }
  }

  if (frameCount % 10 == 0) {
    f.add(new firework());
  }
}

void keyPressed() {
  f.add(new firework(new PVector(mouseX, mouseY)));
}
void mousePressed() {
  f.add(new firework(new PVector(mouseX, mouseY)));
}
