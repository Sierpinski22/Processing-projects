class particle {
  PVector loc;
  PVector vel;
  float life;
  float radius = random(4, 7);
  boolean alive = true;
  float maxvel = 4;
  float col;

  particle(PVector origin) {
    loc = origin.copy();
    //vel = new PVector (random(-maxvel, maxvel), random(-maxvel, maxvel));
    vel = PVector.random2D();
    vel.setMag(random(-maxvel, maxvel));
    life = random(50, plife);
    col = random(100);
  }

  void move() {
    if (life > 0) {
      vel.add(new PVector(0, 0.05));
      loc.add(vel);
      life--;
    } else {
      alive = false;
    }
  }

  void show() {
    if (alive) {
      fill(random(100), 100, 2 * life);
      circle(loc.x, loc.y, radius);
    }
  }
}
