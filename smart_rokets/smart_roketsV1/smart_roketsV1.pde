missile [] population;
int totpop = 20;
int life = 200;

void setup() {

  noStroke();
  size(600, 600);
  rectMode(CENTER);

  population = new missile [totpop];

  for (int i = 0; i < population.length; i++) {

    population [i] = new missile(new PVector(0, height / 2));
  }
}


void draw() {

  background(0);
  for (missile m : population) {
    m.move();
    m.create();
  }
}

class DNA {

  PVector [] genes;

  DNA(){

    genes = new PVector [life];

    for (int t = 0; t < genes.length; t++) {
      genes [t] = PVector.random2D();
      genes [t].setMag(0.3);
    
   }
  }
}
