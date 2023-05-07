ArrayList <boid> flock = new ArrayList <boid> ();
float [] dati = new float [100];
float perc;
void setup() {//idea: immunità momentanea dall'infezione
  colorMode(HSB);  

  fullScreen();
  // size(1200, 700);

  for (int i = 0; i < 255; i++) {
    float h = random(1);
    if (h < 0.6) {
      flock.add(new boid(random(0, 254), new PVector (random(width), random(height))));
    } else {
      flock.add(new boid(0, new PVector (random(width), random(height))));
    }
  }
}

void keyPressed() {
  if (key == 'i' || key == 'I') {
    flock.add(new boid(255, new PVector (mouseX, mouseY)));
  } else if (key == 'b' || key == 'B') {
    flock.add(new boid(0, new PVector (mouseX, mouseY)));
  } else if (key == 'r' || key == 'R') {
    if (flock.size() > 0) {
      flock.remove(0);
    }
  }
}

int infcount;

void draw() {
  background(255);  
  infcount = 0;
  for (boid m : flock) {

    m.behave(flock);
    m.edge();
    m.move();
    m.create();

    if (m.infection > 0) {

      infcount++;
    }
  }

  if (infcount != 0) { 
    perc = float(infcount) / float(flock.size());
  } else {
    perc = 0;
  }

  for (int k = dati.length -1; k > 0; k--) {
    dati[k] = dati[k - 1];
  }
  if (frameCount % 5 == 0) {
    dati[0] = perc;
  }
  if (frameCount > dati.length + 5) {
    for (int n = 1; n < dati.length; n++) {
      stroke(0, 255, 300, 100);
      line(n * width / (dati.length - 1), abs(height * dati[n] - height), (n - 1) * width / (dati.length - 1), abs( height * dati[n - 1]- height));
    }
  }
}
