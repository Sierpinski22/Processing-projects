final int dimension = 4; //il sogno della generalizzazione è andato in frantumi in fretta
final int scaleFactor = 350;
final int n = int(pow(2, dimension));
float [][] points;

int index = 0;
void buildPoints(float [][] p, int start, int lim, int depth) {//questa funzione è STATA un incubo, crea i punti iniziali del cubo ricorsivamente
  if (depth == dimension) return;
  for (int i=0; i<lim; i++) p[i+start][depth] = i < lim/2? 1: -1;
  buildPoints(p, start, lim/2, depth+1);
  buildPoints(p, lim/2+start, lim/2, depth+1);
}

float [][] matMult(float [][] a, float [][] b) {//moltiplicazione tra matrici
  int m1 = a[0].length, m2 = b[0].length;
  int n1 = a.length, n2 = b.length;
  if (m1 != n2) print("Errore, le matrici hanno dimensioni incompatibili\n");
  float [][] result = new float [n1][m2];
  for (int i=0; i<n1; i++) {
    for (int j=0; j<m2; j++) {
      result[i][j] = 0;
      for (int k=0; k<m1; k++) {
        result[i][j] += a[i][k] * b[k][j];
      }
    }
  }
  return result;
}

float distance(float [] a, float [] b) {//pitagora in n dimensioni
  float sum = 0;
  for (int i=0; i<a.length; i++) {
    sum += pow(a[i]-b[i], 2);
  }
  return pow(sum, 0.5);
}

float [][] wrap(float [] l) {//rende un vettore riga un vettore colonna
  float [][] w = new float[dimension][1];
  for (int dim=0; dim<dimension; dim++) w[dim][0] = l[dim];
  return w;
}

float [][] computeProjection2(float[]p) {//proiezione dalla quarta dimensione alla terza
  float z = 1 / (3-p[3]);
  float [][] projection = {{z, 0, 0, 0}, {0, z, 0, 0}, {0, 0, z, 0}};
  return matMult(projection, wrap(p));
}

float [][] computeProjection(float[]p) {//proiezione dalla terza dimensione alla seconda
  float pjr[][] = computeProjection2(p);
  float z = 1 / (2-pjr[2][0]);
  float [][] projection = {{z, 0, 0}, {0, z, 0}};
  return matMult(projection, pjr);
}
float tol = 0.01;
void show(float[][] p) {//calcola la proiezione e disegna ogni punto

  float [][] proj;

  for (int i=0; i<n; i++) {
    proj = computeProjection(p[i]);
    strokeWeight(0.01);
    point(proj[0][0], proj[1][0]);

    for (int j=0; j<n; j++) {
      if (j!=i && abs(distance(p[i], p[j]) -2) < tol) {//calcola la distanza tra tutti i punti e disegna una riga tra le proiezioni di quelli vicini il giusto
        float [][] proj2 = computeProjection(p[j]);
        strokeWeight(0.01);
        line(proj[0][0], proj[1][0], proj2[0][0], proj2[1][0]);
      }
    }
  }
}

void setup() {
  size(600, 600);
  points = new float [n][dimension];
  buildPoints(points, 0, n, 0);
  stroke(255);
}

//-------------gli angoli e le matrici di rotazione------------
float rho = 0.0;
float phi = 0.0;

float minr = 0.1;
float minp = 0.1;

float [][] rotateXZ = {{1, 0, 0, 0}, {0, cos(phi), 0, -sin(phi)}, {0, 0, 1, 0}, {0, sin(phi), 0, cos(phi)}};
float [][] rotateYW = {{cos(rho), 0, -sin(rho), 0}, {0, 1, 0, 0}, {sin(rho), 0, cos(rho), 0}, {0, 0, 0, 1}};
//-------------------------------------------------------------

void mouseDragged() {//roba carina
  if (pmouseX!=mouseX) rho+=pmouseX<mouseX? 0.001: -0.001;
  if (pmouseY!=mouseY) phi+=pmouseY<mouseY? 0.001: -0.001;
}

void updatePar(){//attrito
  if (abs(rho)>0.07) rho *= 0.99;
  if (abs(phi)>0.07) phi *= 0.99;
}

void updateMat() {//dopo aver modificato gli angoli
  float [][] rotateXZ2 = {{1, 0, 0, 0}, {0, cos(phi), 0, -sin(phi)}, {0, 0, 1, 0}, {0, sin(phi), 0, cos(phi)}};
  float [][] rotateYW2 = {{cos(rho), 0, -sin(rho), 0}, {0, 1, 0, 0}, {sin(rho), 0, cos(rho), 0}, {0, 0, 0, 1}};
  arrayCopy(rotateXZ2, rotateXZ);
  arrayCopy(rotateYW2, rotateYW);
}

void draw() {//dove avviene la magia...
  background(0);
  translate(width/2, height/2);
  scale(scaleFactor);
  points = matMult(points, rotateYW);
  points = matMult(points, rotateXZ);
  show(points);
  
  updatePar();
  updateMat();
  
}
