int lato = 20;
int cols, rows, tot;
tile [][] ground;
PVector c = new PVector (0, 0);
ArrayList <tile> stack = new ArrayList <tile>();
tile t, m;

void setup() {
  size(700, 700);
  //noStroke();
  //strokeWeight(1);
  cols = width / lato;
  rows = height / lato;
  tot = cols * rows;
  ground = new tile [cols][rows];

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      ground[x][y] = new tile(x, y);
    }
  }

  ground[int(c.x)][int(c.y)].visited = true;
  t =  ground[int(c.x)][int(c.y)];

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      ground[x][y].neigh();
    }
  }
}

void draw() {
  t.check();
  if (t.n.size() > 0) {
    m = t.n.get(int(random(t.n.size())));
    m.visited = true;
    stack.add(t);
    m.noborders(t);
    t = m;
  } else if (stack.size() > 0) {
    t = stack.remove(stack.size()-1);
  }

  make();

  if (stack.size() == 0) {
    noLoop();
    make();
    //saveFrame();
    objective();
  }
}

void objective(){
 noStroke();
 fill(0, 255, 0);
 ellipse(lato / 2, lato / 2, lato / 2, lato / 2);
 fill(255, 0, 0);
 ellipse(width - lato / 2, height - lato / 2, lato / 2, lato / 2);
}

void make() {
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      ground[x][y].create();
    }
  }
  if (stack.size() > 0) {
    fill(0, 255, 0);
    rect(t.x * lato, t.y * lato, lato, lato);
  }
}
