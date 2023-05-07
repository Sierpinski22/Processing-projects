ArrayList <walker> petri = new ArrayList ();

void setup() {
  background(0);

  fullScreen();

  //frameRate(80);
  //size(600, 600);
  noStroke();
  petri.add(new walker(new PVector (width / 2, height / 2), true));

  for (int i = 1; i < 2000; i++) {

    petri.add(new walker(new PVector (random(0, width), random(0, height)), false));
  }
}


void draw() { 
  background(0);

  for (walker o : petri) {
    o.check(petri);
    if (!o.stuck) {  
      o.move();
    } else {
      o.create();
    }
  }
  if (frameCount % 4 == 0 && petri.size() < 2500) {

    petri.add(new walker(new PVector (random(0, width), random(0, height)), false));
  }
}
