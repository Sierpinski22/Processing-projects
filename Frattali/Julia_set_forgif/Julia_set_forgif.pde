int m, acc, offx, offy, counter = 0;
float ranx, rany, ca, cb, angle;

void setup() {
  size(400, 400);
  colorMode(HSB);
  frameRate(20);
  ranx = 1.5;
  rany = 1.5;
  m = 20;
  acc = 5;
  ca = 0.285;
  cb =  0;
  angle = 0.1;
}

void draw() {
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {

      float a = map(x - offx, 0, width, -ranx, ranx);
      float b = map(y - offy, 0, height, -rany, rany);
      float n = 0;

      while (n < m) {
        float z = (a * a) - (b * b);
        float c = 2 * a * b;

        a = z + sin(angle);
        b = c + cos(angle);

        if (abs(a + b) > acc) {
          break;
        }
        n++;
      }
      pixels[x + y * width] = n == m ? color(0): color(300 * n / m, 200, 300);
    }
  }
  updatePixels();
  angle += 0.1;
  if(counter == 63){
   noLoop(); 
  }else{
    counter++;
    saveFrame("result/re-####.png");
  }
}
