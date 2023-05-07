class particle {

  PVector loc, vel, acc, ploc;
  int r;
  float maxvel, maxfor, sight, temp, ptemp;;

  particle() {

    loc = new PVector(random(2 * lato, width - 2 * lato), random(2 * lato, height - 2 * lato));
    vel = new PVector (int(random(2, -2)), int(random(2, 2)));
    acc = new PVector (0, 0);
    ploc = loc.copy();

    r = 27;
    temp = loc.x < width / 2 ? 10 : 255;
    ptemp = temp;
    sight = r;
    maxvel = 1.7;
    maxfor = 0.5;
  }

  PVector separate() {
    PVector sep = new PVector ();
    int counter = 0;

    for (particle par : p) {
      if (par != this) {
        float d = dist(loc.x, loc.y, par.loc.x, par.loc.y);
        if (d < sight && d != 0) {
          PVector diff = PVector.sub(loc, par.loc);
          diff.div(d * d);
          sep.add(diff);
          counter++;
          if (d <= r) {
            ptemp = (temp + par.temp) / 2;
            ptemp = constrain(ptemp, 0, 255);
          }
        }
      }
    }

    if (counter > 0) {

      sep.setMag(maxvel);
      sep.sub(vel);
      sep.limit(maxfor);
    }
    return sep;
  }

  PVector edge() {
    PVector fix = new PVector();
    if (loc.x < edges[0].loc.x + lato * 2) {
      fix.add(new PVector (maxvel, 0));
    } else if (loc.x > edges[2].loc.x - lato) {
      fix.add(new PVector (-maxvel, 0));
    }

    if (loc.y < edges[1].loc.y + lato * 2) {
      fix.add(new PVector (0, maxvel));
    } else if (loc.y > edges[3].loc.y - lato) {
      fix.add(new PVector (0, -maxvel));
    }
    return fix;
  }

  void move() {

    PVector sep = separate().mult(1);
    PVector ed = edge();

    acc.add(sep);
    acc.add(ed);
    vel.add(acc);
    vel.mult(map(ptemp, 0, 255, 1, 1.3)); 
    vel.limit(maxvel);
    ploc.add(vel);
    acc.mult(0);
  }

  void create() {
    loc = ploc.copy();
    temp = ptemp;
    float t = 255 - temp;
    fill(temp, 0, t);
    ellipse(loc.x, loc.y, r, r);
  }
}
