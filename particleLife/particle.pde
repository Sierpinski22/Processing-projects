final float r0 = 20; //repulsione
final float r1 = 40; //incremento modulo
final float r2 = 60; //trascurabile
final float MAX_REP = 0.2;
final float MAX_ATT = 0.1;
final float MAX_VEL = 1;

void convertInsert(particle [] p, quadtree q) {
  for (int i=0; i<p.length; i++) q.insertOne(p[i].x, p[i].y, i);
}


class particle {
  int type;
  float x, y, vx, vy, ax, ay, px, py, r;
  color c;

  particle(float x, float y, int type, color c) {
    this.x = x;
    this.y = y;
    this.px = x;
    this.py = y;
    this.vx = 0;
    this.vy = 0;
    this.ax = 0;
    this.ay = 0;
    this.c = c;
    this.r = 10;
    this.type = type;
  }

  void behave(quadtree q, float [][] dip, particle [] p) {
    ArrayList <float []> in = new ArrayList <float []>();
    q.toroidalQuery(this.x-r2/2, this.y-r2/2, r2, r2, in, width, height); //non funziona, la distanza è calcolata col culo
    for (float [] i : in) {
      float d = dist(this.x, this.y, i[0], i[1]);
      float fx = i[0]-this.x;
      float fy = i[1]-this.y; //attrazione
      float mod = dist(fx, fy, 0, 0);
      fx /= mod;
      fy /= mod;

      if (d==0) continue;
      else if (d<r0) {
        mod = (-1 + d/r0) * MAX_REP;
        this.applyForce(fx * mod, fy * mod);
      } else if (d<r1) {
        mod = d/r1 * dip[this.type][p[int(i[2])].type] * MAX_ATT;
        this.applyForce(fx*mod, fy*mod);
      } else if (d<r2){
        mod = (dip[this.type][p[int(i[2])].type] * MAX_ATT) * (1-d/r2);
        this.applyForce(fx*mod, fy*mod);
      }
    }
  }

  void applyForce(float fx, float fy) {
    this.ax += fx;
    this.ay += fy;
  }

  void edges() {
    this.x = (this.x + width) % width;
    this.y = (this.y + height) % height;
  }
  
  void move() {
    this.vx += this.ax;
    this.vy += this.ay;
    float d = dist(this.vy, this.vx, 0, 0);
    if(d > MAX_VEL){
     this.vx = this.vx / d * MAX_VEL;
     this.vy = this.vx / d * MAX_VEL;
    }
    this.vx *= 0.9;
    this.vy *= 0.9;
    
    this.x += this.vx;
    this.y += this.vy;
    this.ax = 0;
    this.ay = 0;
    this.edges();
  }

  void show() {
    fill(this.c);
    noStroke();
    ellipse(this.px, this.py, this.r, this.r);
    this.px = x;
    this.py = y;
  }
}
