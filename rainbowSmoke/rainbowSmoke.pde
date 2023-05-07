final int side = 10;
final int n = 16;
final int cols = floor(n * sqrt(n));
final int rows = floor(n * sqrt(n));
final int inc = floor(255 / (n));

int x_, y_;
int [][][][] cube = new int [n][n][n][4];
int [][][] grid = new int[rows][cols][3]; //da cambiare
ArrayList <data> avail = new ArrayList();


int [][][][] build_cube() {


  for (int r = 0; r < n; r++) {
    for (int g = 0; g < n; g++) {
      for (int b = 0; b < n; b++) {
        cube[r][g][b][0] = r;
        cube[r][g][b][1] = g;
        cube[r][g][b][2] = b;
        cube[r][g][b][3] = 1;
      }
    }
  }
  return cube;
}

void init_grid() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      grid[i][j][0] = -1;
      grid[i][j][1] = -1;
      grid[i][j][2] = -1;
    }
  }
}

boolean available(int x, int y) {
  return (x >= 0 && x < grid[0].length) && (y >= 0 && y < grid.length);
}

void update_state(int x, int y, int r, int g, int b) {
  //modifica il cubo
  cube[r][g][b][3] = 0;

  //modifica i disponibili - inserimento intelligente ==> prendi quelli più vicini al centro di diffusione
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if ((i == 0 && j != 0) || (i != 0 && j == 0)) {
        if (available(x+j, y+i) && grid[y+i][x+j][0] == -1) avail.add(new data(x+j, y+i, r, g, b));
      }
    }
  }

  //modifica la griglia - mi interessa averla colorata?
  grid[y][x][0] = cube[r][g][b][0];
  grid[y][x][1] = cube[r][g][b][1];
  grid[y][x][2] = cube[r][g][b][2];


  //disega l'assegnamento
  fill(grid[y][x][0]*inc, grid[y][x][1]*inc, grid[y][x][2]*inc);
  //print(grid[y][x][0]*inc, grid[y][x][1]*inc, grid[y][x][2]*inc);
  rect(x * side, y * side, side, side);
}

void show_grid() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (grid[i][j][0] != -1) {
        fill(grid[i][j][0]*inc, grid[i][j][1]*inc, grid[i][j][2]*inc);
        rect(j * side, i * side, side, side);
      }
    }
  }
}

boolean available3d(int r, int g, int b) {
  return (r >= 0 && r < n) && (g >= 0 && g < n) && (b >= 0 && b < n);
}

data fetch_color(int r, int g, int b) {
  ArrayList <data> temp = new ArrayList();
  int rad = 0;
  //croce
  if (available3d(r+1, g, b) && cube[r+1][g][b][3]==1) temp.add(new data(0, 0, cube[r+1][g][b][0], cube[r+1][g][b][1], cube[r+1][g][b][2]));
  if (available3d(r-1, g, b) && cube[r-1][g][b][3]==1) temp.add(new data(0, 0, cube[r-1][g][b][0], cube[r-1][g][b][1], cube[r-1][g][b][2]));
  if (available3d(r, g+1, b) && cube[r][g+1][b][3]==1) temp.add(new data(0, 0, cube[r][g+1][b][0], cube[r][g+1][b][1], cube[r][g+1][b][2]));
  if (available3d(r, g-1, b) && cube[r][g-1][b][3]==1) temp.add(new data(0, 0, cube[r][g-1][b][0], cube[r][g-1][b][1], cube[r][g-1][b][2]));
  if (available3d(r, g, b+1) && cube[r][g][b+1][3]==1) temp.add(new data(0, 0, cube[r][g][b+1][0], cube[r][g][b+1][1], cube[r][g][b+1][2]));
  if (available3d(r, g, b-1) && cube[r][g][b-1][3]==1) temp.add(new data(0, 0, cube[r][g][b-1][0], cube[r][g][b-1][1], cube[r][g][b-1][2]));

  //cubi vuoti
  while (temp.size()==0) {
    rad++;

    for (int i = -rad; i <= rad; i++) {
      for (int j = -rad; j <= rad; j++) {
        for (int k = -rad; k <= rad; k++) {
          if (i != 0 || j != 0 || k != 0) {
            if (available3d(r+i, g+j, b+k) && cube[r+i][g+j][b+k][3] == 1) {
              temp.add(new data(0, 0, cube[r+i][g+j][b+k][0], cube[r+i][g+j][b+k][1], cube[r+i][g+j][b+k][2]));
            }
          }
        }
      }
    }
  }
  //restituisci uno a caso
  //print(temp.size());
  return temp.get(floor(random(0, temp.size())));
}

int closest() {
  int index = 0;
  float di = sqrt(cols*cols + rows*rows);
  for (int i = 0; i < avail.size(); i++) {
    float ds = dist(avail.get(i).x, avail.get(i).y, x_, y_);
    if (ds < di) {
      di = ds;
      index = i;
    }
  }
  return index;
}

void choice() {
  //scegli un candidato dalla lista
  int index = floor(random(0, avail.size())); //selezioni la cella canditata
  //trova colore
  data output = fetch_color(avail.get(index).r, avail.get(index).g, avail.get(index).b);
  //print(output.r, output.g, output.b, avail.get(index).r, avail.get(index).g, avail.get(index).b);

  //aggiorna il tutto
  update_state(avail.get(index).x, avail.get(index).y, output.r, output.g, output.b);

  //elimina l'elemento scelto e tutte le sue varianti
  int x = avail.get(index).x, y = avail.get(index).y;
  for (int i=avail.size()-1; i>=0; i--) if (avail.get(i).x == x && avail.get(i).y == y) avail.remove(i);
}

void setup() {
  size(640, 640);
  background(0);
  noStroke();
  build_cube();
  init_grid();
  x_ = floor(random(0, cols));
  y_ = floor(random(0, rows));
  avail.add(new data(x_, y_, floor(random(0, n)), floor(random(0, n)), floor(random(0, n))));
  update_state(avail.get(0).x, avail.get(0).y, avail.get(0).r, avail.get(0).g, avail.get(0).b);
  avail.remove(0);
}

void draw() { //scegli una posizione disponibile
  choice();
  //noLoop();
  if (avail.size() == 0) noLoop();
}
