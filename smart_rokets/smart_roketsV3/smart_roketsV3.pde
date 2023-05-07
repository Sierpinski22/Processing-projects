barrage barrage;
PVector target; //variabile globale! funziona anche sulle altre schede!
float maxvel = 0.3;
int maxpop = 100;
int life = 400;
PVector origin;
int death = 0;

void setup() {//intelligenza artificiale
  origin = new PVector (70, height / 2);
  noStroke();
  target = new PVector(width - 50, height / 2);
  fullScreen();
  //size(1200, 600);
  barrage = new barrage();
  background(0);
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


void targ() {

  fill(255,0 , 0);
  circle(target.x, target.y, 30);
  fill(255);
  circle(target.x, target.y, 20);
  fill(255, 0, 0);
  circle(target.x, target.y, 10);

}
