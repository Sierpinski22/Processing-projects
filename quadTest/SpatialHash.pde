class spatialHash {
  float w, h, sidex, sidey;
  int n;
  ArrayList<Integer> [][] content;
  spatialHash(float w, float h, int n) {
    this.w = w;
    this.h = h;
    this.n = n;
    this.sidex = w / n;
    this.sidey = h / n;
    this.content = new ArrayList[n][n];
    this.initLists();
  }
  void insertOne(float x, float y, int index) {
    this.content[floor(y / this.sidey)][floor(x / this.sidex)].add(index);
  }
  void eliminate() {
    this.content = new ArrayList[n][n]; //lo avrà eliminato con efficienza? mah
    this.initLists();
  }
  void initLists() {
    for (int y=0; y<n; y++) for (int x=0; x<n; x++) this.content[y][x] = new ArrayList<Integer>();
  }

  void query(float x, float y, ArrayList<Integer> inside) {
    int cx = floor(x / this.sidex);
    int cy = floor(y / this.sidey);
    for (int i=-1; i<=1; i++) {
      for (int j=-1; j<=1; j++) {
        this.give((cx+j+n)%n, (cy+i+n)%n, inside);
      }
    }
    //this.give(cx, cy, inside);
  }

  void give(int x, int y, ArrayList<Integer> inside) {
    if (x<0 || x>=n || y<0 || y>=n) return;
    for (int i : this.content[y][x]) inside.add(i);
  }

  void show() {
    noFill();
    stroke(0, 255, 0);
    for (int y=0; y<n; y++) {
      for (int x=0; x<n; x++) {
        rect(x * this.sidex, y * this.sidey, this.sidex, this.sidey);
      }
    }
  }
}
