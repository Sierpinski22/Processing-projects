ArrayList <boid> flock = new ArrayList <boid> ();
float [] dati = new float [100];
float perc;
float r;
PVector gr;
void setup() {//idea: immunità momentanea dall'infezione
  colorMode(HSB);  
  fullScreen();
  // size(1200, 700);

  gr = new PVector(width / 2, height / 2);

  r = height / 6;

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

void mouseDragged() {
  float d = dist(mouseX, mouseY, gr.x, gr.y);

  if (d <= r) {
    if (mouseX - r / 2 > 0 && mouseX + r / 2 < width && mouseY + r / 2 < height && mouseY - r / 2 > 0) {
      gr = new PVector(mouseX, mouseY);
    }
  }
}

float infcount;
float severe;

void draw() {
  background(255);  
  infcount = 0;
  severe = 0;
  for (boid m : flock) {

    m.behave(flock);
    m.edge();
    m.move();
    m.create();

    if (m.infection > 0 && m.infection < 250) {
      infcount++;
    } else if (m.infection >= 250) {
      severe++;
    }
  }

  graph(infcount / float(flock.size()), severe / float(flock.size()));
  lingraph(infcount);
}

void graph(float ill, float sev) {
  float arci = ill * 360;
  float arcs = sev * 360;

  strokeWeight(1);
  stroke(150, 100);
  fill(255, 50);
  arc(gr.x, gr.y, r, r, 0, radians(360));
  fill(255, 75, 300);
  arc(gr.x, gr.y, r, r, 0, radians(arci));
  fill(255, 255, 300);
  arc(gr.x, gr.y, r, r, 0, radians(arcs));
}

void lingraph(float infcount) {
  if (infcount != 0) { 
    perc = infcount / float(flock.size());
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
