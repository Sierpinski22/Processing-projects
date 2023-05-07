class atom {

  PVector loc, vel, pseudoloc;
  int r, sight;
  boolean gone = false;

  atom() {
    r = 10;
    loc = new PVector(random(r, width - r), random(r, height - r));
    pseudoloc = loc.copy();
    vel = new PVector(random(-velatom, velatom), random(-velatom, velatom));
    sight = 50;
  }

  PVector repulsion() {
    PVector sep = new PVector();
    int counter = 0;
    for (atom a : uranium) {
      float d = loc.dist(a.loc);
      if (d != 0 && d < 2*sight/3) {
        sep.add(PVector.sub(loc, a.loc).div(d * d));
        counter++;
      }
    }

    if (counter > 0) {
      sep.setMag(velatom / 4);
      sep.sub(vel);
      sep.div(counter);
      sep.limit(velatom);
    }
    return sep;
  }

  void collision() {
    for (neutron n : radicals) {
      if (loc.dist(n.loc) <= r + n.r) {
        gone = true;
      }
    }
  }

  void fission() {
    for (int i = 0; i < maxneutron; i++) {
      radicals.add(new neutron(new PVector(loc.x, loc.y)));
    }
  }

  void edge() {
    vel.x *= loc.x > width || loc.x < 0 ? -1 : 1;
    vel.y *= loc.y > height || loc.y < 0 ? -1 : 1;
  }

  void move() {
    collision();
    if (!gone) {
      vel.add(repulsion());
      edge();
      pseudoloc.add(vel);
    }
  }

  void create() {
    if (!gone) {
      loc = pseudoloc.copy();
      noStroke();
      fill(255, 0, 0);
      ellipse(loc.x + random(-1, 1), loc.y + random(-1, 1), r, r);
      noFill();
      stroke(0, 255, 0);
      ellipse(loc.x+ random(-2, 2), loc.y+ random(-2, 2), sight, sight);
    } else {
      fission();
    }
  }
}
