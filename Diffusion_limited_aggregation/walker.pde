class walker {

  PVector loc;
  PVector vel;
  boolean stuck;
  float radius; //è un diametro...

  walker(PVector origin, boolean s) {

    loc = origin.copy();
    stuck = s;
    radius = int(random(7, 12));
  }

  void move() {

    vel = new PVector (random(-10, 10), random(-10, 10));
    loc.add(vel);

    loc.x = constrain(loc.x, 0, width);
    loc.y = constrain(loc.y, 0, height);
  }


  void check(ArrayList <walker> petri) {


    for (walker m : petri) {

      if (m != this) {

        if (m.stuck) {

          if (this.loc.dist(m.loc) < (radius + m.radius) / 2) {

            stuck = true;
          }
        }
      }
    }
  }

  void create() {

    if (stuck) {
      fill(50, loc.dist(new PVector (width / 2, height / 2)) % width, 100);
    } else {
      fill(100);
    }

    circle(loc.x, loc.y, radius);
  }
}
