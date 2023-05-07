class boid {

  PVector loc;
  PVector vel;
  PVector acc;
  float sight;
  float maxvel;
  float maxfor;
  float coeffc;
  float coeffa;
  float coeffs;

  boid(PVector origin) {
    loc = origin;
    vel = new PVector (random(-2, 2), random(-2, 2));
    acc = new PVector (0, 0);
    sight = 100;
    maxvel = 2;
    maxfor = 0.3;
    coeffc = 1;
    coeffa = 1;
    coeffs = 1.5;
  }

  PVector cohese(ArrayList <boid> flock) {//regola: la direzione di ogni "boid" è la media della posizione dei compagni di stormo
    float csight = sight;
    int close = 0;
    PVector avloc = new PVector();

    for (boid c : flock) {

      if (this != c) {

        if (loc.dist(c.loc) < csight) {

           if (flock.size() <= 100) {
           stroke(0, 255, 0);
            strokeWeight(1);
           line(loc.x, loc.y, c.loc.x, c.loc.y);
           }
            
          avloc.add(c.loc);
          close++;
        }
      }
    }

    if (close > 0) {

      avloc.div(close); //media
      avloc.sub(loc);//direzione
      avloc.setMag(maxvel);//velocità di spostamento momentanea
      avloc.sub(vel);//velocità di spostamento finale    
      avloc.limit(maxfor);//forza di coesione limitata (altrimenti i "boids" si attaccano istantaneamente)
    }
    return avloc;
  }

  PVector allign(ArrayList <boid> flock) {//regola: la velocità di ogni "boid" è la velocità media dei compagni di stormo

    float asight = sight / 2;
    int close = 0;
    PVector avvel = new PVector();

    for (boid a : flock) {

      if (this != a) {

        if (loc.dist(a.loc) < asight) {
      
          avvel.add(a.vel);
          close++;
        }
      }
    }

    if (close > 0) {

      avvel.div(close);
      avvel.setMag(maxvel);
      avvel.sub(vel);
      avvel.limit(maxfor);
    }
    return avvel;
  }

  PVector separate(ArrayList <boid> flock) {//regola: ogni "boid" si allontana dai compagni di stormo vicini. la forza di allonatnamento è porporzionale alla distanza dei "boid"

    float ssight = sight / 2;
    int close = 0;
    PVector closep = new PVector ();


    for (boid s : flock) {
      if (this != s) {
        float d = loc.dist(s.loc);
        if (d < ssight) {
       if (flock.size() <= 100) {
           stroke(255, 0, 0);
            strokeWeight(1);
           line(loc.x, loc.y, s.loc.x, s.loc.y);
           }
          PVector diff = PVector.sub(loc, s.loc);
          diff.div(d * d);
          closep.add(diff);
          close++;
        }
      }
    }

    if (close > 0) {

      closep.div(close);
      closep.setMag(maxvel);
      closep.sub(vel);
      closep.limit(maxfor);
    }
    return closep;
  }
  void behave(ArrayList <boid> flock) {//ogni forza imposta dalle regole viene applicata

    PVector cohesion = cohese(flock);
    PVector allignement = allign(flock);
    PVector separation = separate(flock);

    cohesion.mult(coeffc);
    allignement.mult(coeffa);
    separation.mult(coeffs);

    acc.add(cohesion);
    acc.add(allignement);
    acc.add(separation);
  }




  void edge() {//effetto pac-man

    if (loc.x < 0) {
      loc.x = width;
    } else if (loc.x > width) {
      loc.x = 0;
    }

    if (loc.y < 0) {
      loc.y = height;
    } else if (loc.y > height) {
      loc.y = 0;
    }
  }

  void move() {//classico
    loc.add(vel);
    vel.add(acc);
    vel.limit(maxvel);
    acc.mult(0);
  }

  void create() {//classico
    noStroke();
    fill(100, 50);
    ellipse(loc.x, loc.y, 20, 20);
  }
}
