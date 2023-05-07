class tile {
  int x, y;
  boolean visited;
  boolean [] cor;
  ArrayList <tile> n = new ArrayList <tile>();

  tile(int x_, int y_) {
    x = x_;
    y = y_;

    visited = false;
    cor = new boolean []{true, true, true, true};//nseo
  }

  void neigh() {
    if (x + 1 < cols) {
      if (!ground[x+1][y].visited) {
        n.add(ground[x + 1][y]);
      }
    }
    if (x - 1 >= 0) {
      if (!ground[x-1][y].visited) {
        n.add(ground[x - 1][y]);
      }
    }
    if (y + 1 < rows) {
      if (!ground[x][y + 1].visited) {
        n.add(ground[x][y + 1]);
      }
    }
    if (y - 1 >= 0) {
      if (!ground[x][y - 1].visited) {
        n.add(ground[x][y - 1]);
      }
    }
  }

  void check() {
    if (n.size() > 0) {
      for (int i = n.size() - 1; i >= 0; i--) {
        if (n.get(i).visited) {
          n.remove(i);
        }
      }
    }
  }

  void noborders(tile k) {//problema: soluzione invertire roba a caso (il problema è l'asse di riferimento
    PVector bor = new PVector(x - k.x, y - k.y);

    if (bor.x == 1) {
      cor[3] = false;
      k.cor[2] = false;
    } else if (bor.x == -1) {
      cor[2] = false;
      k.cor[3] = false;
    } else if (bor.y == -1) {
      cor[1] = false;
      k.cor[0] = false;
    } else if (bor.y == 1) {
      cor[0] = false;
      k.cor[1] = false;
    }
  }

  void create() {

    int x1 = this.x * lato;
    int y1 = this.y * lato;

    fill(255);
    noStroke();
    rect(x1, y1, lato, lato);

    stroke(0);

    if (cor[0]) {
      line(x1, y1, x1 + lato, y1);
    }
    if (cor[1]) {
      line(x1, y1 + lato, x1 + lato, y1 + lato);
    }
    if (cor[2]) {
      line(x1 + lato, y1, x1 + lato, y1 + lato);
    }
    if (cor[3]) {
      line(x1, y1, x1, y1 + lato);
    }
  }
}
