class wall {
  PVector loc;
  PVector vel;
  float wid, heigh;
  PVector ploc;

  wall(PVector origin, PVector v, float w, float h) {

    ploc = origin.copy();
    loc = origin.copy();
    vel = v.copy();

    wid = w;
    heigh = h;
  }

  void move(boolean b) {
    PVector a;
    a = vel.copy(); 
    if (!b) {
      a.mult(-1);
    }

    PVector c = loc.copy().add(a);

    if (c.x <= width - lato && c.y <= height - lato && c.x >= 0 && c.y >= 0) {
      loc.add(a);
    }
  }

  void create() {

    fill(int(255 / 2), 0, int(255 / 2));
    rect(loc.x, loc.y, wid, heigh);
  }
}
