int m, acc, offx, offy;
float ranx, rany;

void setup() {
  size(650, 650);
  colorMode(HSB);
  ranx = 1.5;
  rany = 1.5;
  m = 100;
  acc = 2000;
  offy = 0;
  offx = width / 5;
}

void draw() {
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {

      float a = map(x - offx, 0, width, -ranx, ranx);
      float b = map(y - offy, 0, height, -rany, rany);
      float pa = a;
      float pb = b;
      float n = 0;

      while (n < m) {
        float z = (a * a) - (b * b);
        float c = 2 * a * b;

        a = pa + z;
        b = pb + c;

        if (abs(a + b) > acc) {
          break;
        }
        n++;
      }
      pixels[x + y * width] = n == m ? color(0, 0, 0): color(300 * n / m, 200, 300);
    }
  }
  updatePixels();
  noLoop();
}
