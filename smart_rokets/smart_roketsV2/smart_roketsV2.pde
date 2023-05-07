barrage barrage;
PVector target; //variabile globale! funziona anche sulle altre schede!
float maxvel = 0.3;
int maxpop = 200;
int life = 200;
PVector origin;
int death = 0;

void setup(){//intelligenza artificiale
  origin = new PVector (0, height / 2);
  noStroke();
  target = new PVector(width - 50, height / 2);
  size(600, 600);
  background(0);
  rectMode(CENTER);
  
  barrage = new barrage();
}

void draw(){
 
  background(0);
  fill(255,0,0);
 circle(target.x, target.y, 30);
 if(death >= life){
 
   barrage.evaluate();
   barrage.selection();
   death = 0;
 }
  
  barrage.fire();
  
  
  death++;
}
