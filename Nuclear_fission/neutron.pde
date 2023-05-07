class neutron {

  PVector loc, vel, pseudo;
  int r = 3;


  neutron(PVector origin) {
    loc = origin.copy(); 
    pseudo = loc.copy();
    vel = PVector.random2D();
    vel.setMag(3);
  }

  neutron () {
    this(new PVector(random(10, width - 10), random(10, height - 10)));
  }

  void edge() {
    vel.x *= loc.x + r/2 > width || loc.x - r/2 < 0 ? -1 : 1;
    vel.y *= loc.y + r/2 > height || loc.y - r/2 < 0 ? -1 : 1;
  }

  void move() {
    edge(); 
    pseudo.add(vel);
  }

  void create() {
    loc = pseudo.copy();
    noStroke();
    fill(50, 50, 50);
    ellipse(loc.x + random(-1, 1), loc.y + random(-1, 1), r, r);
  }
}
