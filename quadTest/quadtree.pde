/*IDEA: la struttura in ingresso deve essere un array formato da array a tre elementi: [x, y, index] */
int MAX_INSIDE = 20;
int MAX_DEPTH = 10;
boolean ANGLES = false;

class quadtree {
  int depth;
  float x, y, w, h;
  boolean collapsed;
  quadtree q1, q2, q3, q4; //come i quadranti di un piano cartesiano
  ArrayList <float[]> inside;
  quadtree(float x, float y, float w, float h, int d) {//il semplice costruttore
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    this.q1 = null; //alto a destra
    this.q2 = null; //alto a sinistra
    this.q3 = null; //basso a sinistra
    this.q4 = null; //basso a destra

    this.depth = d;
    this.collapsed = false;
    this.inside = new ArrayList<float[]>();
  }

  boolean insideRect(float x, float y) {
    return (x>=this.x && x<this.x+this.w) && (y>=this.y && y<this.y+this.h);
  }

  void insertOne(float x, float y, float index) {//assumendo nessun collasso
    if (this.insideRect(x, y)) {
      if (!this.collapsed) {
        this.inside.add(new float[]{x, y, index});
        this.collapsed = this.inside.size() == MAX_INSIDE && this.depth < MAX_DEPTH;
        if (this.collapsed) this.collapse();
      } else {
        this.q1.insertOne(x, y, index);
        this.q2.insertOne(x, y, index);
        this.q3.insertOne(x, y, index);
        this.q4.insertOne(x, y, index);
      }
    }
  }

  void auxInsert(float [] in) {
    this.insertOne(in[0], in[1], in[2]);
  }

  void insertMultiple(float [][] points) {
    for (int i=0; i<points.length; i++) this.auxInsert(points[i]);
  }

  void collapse() {//genera i figli, dai loro i tuoi contenuti e svuota l'arraylist
    this.q1 = new quadtree(this.x+this.w/2, this.y, this.w / 2, this.h / 2, this.depth+1);
    this.q2 = new quadtree(this.x, this.y, this.w / 2, this.h / 2, this.depth+1);
    this.q3 = new quadtree(this.x, this.y+this.h/2, this.w / 2, this.h / 2, this.depth+1);
    this.q4 = new quadtree(this.x+this.w/2, this.y+this.h/2, this.w / 2, this.h / 2, this.depth+1);

    for (float [] in : this.inside) {
      this.q1.auxInsert(in);
      this.q2.auxInsert(in);
      this.q3.auxInsert(in);
      this.q4.auxInsert(in);
    }
    this.inside.clear();
  }

  void eliminate() {
    if (this.collapsed) {
      this.collapsed = false;
      this.q1.eliminate();
      this.q2.eliminate();
      this.q3.eliminate();
      this.q4.eliminate();
      this.q1 = null;
      this.q2 = null;
      this.q3 = null;
      this.q4 = null;
    }
    this.inside.clear();
  }

  boolean overlap(float x, float y, float w, float h, float dx, float dy) {
    this.x += dx;
    this.y += dy;
    boolean ris = (x - this.x > 0? x - this.x < this.w: -(x - this.x)<w) && (y - this.y > 0? y - this.y < this.h: -(y - this.y)<h);
    this.x -= dx;
    this.y -= dy;
    return ris;
  }

  void query(float x, float y, float w, float h, ArrayList <float[]> toReturn) {
    if (!this.collapsed) {
      if (overlap(x, y, w, h, 0, 0)) for (float [] in : this.inside) toReturn.add(in);
    } else {
      this.q1.query(x, y, w, h, toReturn);
      this.q2.query(x, y, w, h, toReturn);
      this.q3.query(x, y, w, h, toReturn);
      this.q4.query(x, y, w, h, toReturn);
    }
  }
  
  void addToList(ArrayList <float[]> toReturn, float [] toAdd, float dx, float dy){
   float [] ta = new float[]{toAdd[0] + dx, toAdd[1] + dy, toAdd[2]};
   toReturn.add(ta);
  }

  void maskedQuery(float x, float y, float w, float h, ArrayList <float[]> toReturn, float dx, float dy) {
    if (!this.collapsed) {
      if (overlap(x, y, w, h, dx, dy)) for (float [] in : this.inside) addToList(toReturn, in, dx, dy);
    } else {
      this.q1.maskedQuery(x, y, w, h, toReturn, dx, dy);
      this.q2.maskedQuery(x, y, w, h, toReturn, dx, dy);
      this.q3.maskedQuery(x, y, w, h, toReturn, dx, dy);
      this.q4.maskedQuery(x, y, w, h, toReturn, dx, dy);
    }
  }

  void toroidalQuery(float x, float y, float w, float h, ArrayList <float[]> toReturn, float dx, float dy) {
    this.maskedQuery(x, y, w, h, toReturn, 0, 0);

    this.maskedQuery(x, y, w, h, toReturn, dx, 0);
    this.maskedQuery(x, y, w, h, toReturn, -dx, 0);
    this.maskedQuery(x, y, w, h, toReturn, 0, dy);
    this.maskedQuery(x, y, w, h, toReturn, 0, -dy);
    if (ANGLES) {
      this.maskedQuery(x, y, w, h, toReturn, -dx, -dy);
      this.maskedQuery(x, y, w, h, toReturn, dx, dy);
      this.maskedQuery(x, y, w, h, toReturn, -dx, dy);
      this.maskedQuery(x, y, w, h, toReturn, dx, -dy);
    }
  }

  void showContent() {
    if (!this.collapsed) for (float [] in : this.inside) print("x:", in[0], " y:", in[1], " index:", in[2], "\n");
    else {
      if (this.depth != MAX_DEPTH) print("Tree is collapsed:\n");
      this.q1.showContent();
      this.q2.showContent();
      this.q3.showContent();
      this.q4.showContent();
    }
  }

  void showStructure() {
    if (this.collapsed) {
      this.q1.showStructure();
      this.q2.showStructure();
      this.q3.showStructure();
      this.q4.showStructure();
    } else {
      noFill();
      stroke(0, 255, 0);
      strokeWeight(1);
      rect(this.x, this.y, this.w, this.h);
    }
  }
}
