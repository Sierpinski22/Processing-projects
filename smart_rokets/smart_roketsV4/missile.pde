class missile {//funzioni: calcolo fitness

  DNA dna;
  PVector loc;
  PVector vel;
  PVector acc;
  boolean arrived;
  boolean crushed;
  float fitness;
  int counter = 0;
  float lx = 10;
  float ly = 30;


  missile() {//doppio costurttore, se il missile non eredita un dna ne crea uno casuale

    this(new DNA());
  }

  missile(DNA erdna) {

    dna = erdna;
    fitness = 0;
    loc = origin.copy();
    vel = new PVector ();
    acc = new PVector ();
    arrived = false;
    crushed = false;
  }

  void appfor(PVector f) {

    acc.add(f.copy());
  }

  void fitness() {

    float d = distancet();

    if (d != 0) {
      fitness = 1 / (d * d); //notevlomente migliorato
    } else {
      fitness = 1;
      arrived = true;
    }

    if (arrived) {
      fitness *= 10;
    } else if (crushed) {
      fitness /= 4;
    }
  }

  float distancet() {

    return dist(loc.x, loc.y, target.x, target.y);
  }

  void check(obstacle [] field) {

    if (!arrived && !crushed) {

      if ((loc.x < 0 || loc.x > width) || (loc.y < 0 || loc.y > height)) {
        crushed = true;
        boom();
      } else {

        for (int i = 0; i < field.length; i++) {

          if (!crushed && !arrived) {
            if (loc.x > field[i].topoint.x && loc.x <= (field[i].topoint.x + field[i].lx)
              && (loc.y > field[i].topoint.y && loc.y < field[i].topoint.y + field[i].ly)) {
              crushed = true;
              boom();
            }
          }
        }
      }
    }
  }

  void boom() {
    fill(255, 110, 100);
    circle(loc.x, loc.y, 50);
    fill(255, 200, 150);
    circle(loc.x, loc.y, 40);
    fill(255);
    circle(loc.x, loc.y, 30);
  }

  void move() {


    if (!arrived && !crushed) {
      if (counter > 0) {
        appfor(dna.genes [counter]);
      }

      counter++;

      vel.add(acc);
      loc.add(vel);
      acc.mult(0);

      if (distancet() < 20) {

        arrived = true;
        loc = target.copy();
      }
    }
  }

  void create() {
    rectMode(CENTER);
    pushMatrix();
    noStroke();
    fill(255, 200);
    translate(loc.x, loc.y);
    rotate(vel.heading() + radians(90));
    rect(0, 0, lx, ly);
    triangle(lx / 2, -ly / 2, 0, -ly + 5, -lx / 2, -ly / 2);

    if (!crushed && !arrived) {
      float yp = random(0, 30) + (ly / 2); 
      fill(255, 140 + random(100), random(200));
      triangle(- lx / 2, yp, 0, +ly / 2, lx / 2, yp);
    }
    popMatrix();
  }
}
