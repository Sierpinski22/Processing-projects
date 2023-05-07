class firework {

  PVector loc;
  float vel = random(1, 5);
  float life;
  boolean alive = true;
  ArrayList <particle> p = new ArrayList <particle> ();

  firework(PVector origin) {
    loc = origin.copy();
    life = random(50, flife);
  }

  firework() {
    this(new PVector(random(width), height));
  }

  void move() {

    if (life >= 0) {
      loc.y -= vel;
    } else {
      alive = false;
      gen();
    }
    life--;
  }

  void gen() {
    if (p.size() == 0) {
      for (int i = 0; i < 150; i++) {
        p.add(new particle(loc));
      }
    }
  }

  void explode() {
    for (particle n : p) {
      n.move();
      n.show();
    }
  }

  void create() {
    if (alive) {
      fill(255, 255, 100);
      square(loc.x, loc.y + 5, 5);
      fill(255, 0, 100);
      square(loc.x, loc.y, 5);
      fill(255, 255, 100);
      square(loc.x, loc.y - 5, 5);
    } else {
      explode();
    }
    //life--;
  }
}
