void convertAndInsert(particle [] p, quadtree q) {
  for (int i=0; i<p.length; i++) {
    q.insertOne(p[i].x, p[i].y, i);
  }
}


void convertAndInsert2(particle [] p, spatialHash s) {
  for (int i=0; i<p.length; i++) {
    s.insertOne(p[i].x, p[i].y, i);
  }
}


class particle {
  float x, y, vx, vy, r;
  particle(int x, int y) {
    this.x = x;
    this.y = y;
    this.vx = random(-1, 1);
    this.vy = random(-1, 1);
    this.r = 5;
  }

  void bounce(quadtree q) {
    ArrayList<float []> a = new ArrayList<float []>();
    q.toroidalQuery(this.x-30, this.y-30, 60, 60, a, width, height); //intelligente
    //q.query(this.x-30, this.y-30, 60, 60, a); //intelligente
    //q.toroidalQuery(0, 0, width, height, a, width, height); //stupido

    for (float [] in : a) {
      float d = dist(this.x, this.y, in[0], in[1]);
      if (d < this.r * 2 && d!=0) {
        this.vx *= -1;
        this.vy *= -1;
      }
    }
  }

  void bounce2(spatialHash s, particle [] p) {
    ArrayList<Integer> a = new ArrayList<Integer>();
    s.query(this.x, this.y, a); //intelligente
    //q.query(this.x-30, this.y-30, 60, 60, a); //intelligente
    //q.toroidalQuery(0, 0, width, height, a, width, height); //stupido

    for (Integer in : a) {
      float d = dist(this.x, this.y, p[in].x, p[in].y);
      if (d < this.r * 2 && d!=0) {
        this.vx *= -1;
        this.vy *= -1;
      }
    }
  }


  void edges() {
    this.x = (this.x + width) % width;
    this.y = (this.y + height) % height;
  }

  void move(quadtree q) {
    this.bounce(q);
    this.x += this.vx;
    this.y += this.vy;
    this.edges();
    this.show();
  }

  void move2(spatialHash s, particle [] p) {
    this.bounce2(s, p);
    this.x += this.vx;
    this.y += this.vy;
    this.edges();
    this.show();
  }

  void show() {
    fill(255, 0, 0);
    circle(this.x, this.y, this.r*2);
  }
}
