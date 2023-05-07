barrage barrage;
PVector target; //variabile globale! funziona anche sulle altre schede!
float maxvel = 0.5;
int maxpop = 200;
int life = 300;
PVector origin;
int death = 0;

ArrayList <ally> tar = new ArrayList <ally> ();

void setup() {//intelligenza artificiale
  origin = new PVector (70, height / 2);
  noStroke();
  target = new PVector(width - 50, height / 2);
  fullScreen();
  //size(1200, 600);
  barrage = new barrage();
  background(0);
  death = 0;
}

void draw() {

  background(0);
  targ();
  if (death >= life) {
    barrage.evaluate();
    barrage.selection();
    death = 0;
    //background(0);
  }
  barrage.fire();
  death++;
}

void keyPressed() {

  if (key == 'a' || key == 'A') {
    tar.add(new ally(new PVector (mouseX, mouseY)));
  } else if (key == 't' || key == 'T') {
    target = new PVector(mouseX, mouseY);
  } else if ((key == 'r' || key == 'R') && tar.size() > 0) {
    tar.remove(0);
  } else if (key == 'n' || key == 'N') {   
    barrage = new barrage();
    death = 0;
    tar.clear();
    target.x = width -50;
    target.y = height / 2;
  }
}

void targ() {

  fill(255, 0, 0);
  circle(target.x, target.y, 30);
  fill(255);
  circle(target.x, target.y, 20);
  fill(255, 0, 0);
  circle(target.x, target.y, 10);

  for (ally a : tar) {
    a.create();
  }
}
