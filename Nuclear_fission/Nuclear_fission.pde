float velatom = 1.5;
ArrayList <atom> uranium;
ArrayList <neutron> radicals;
int maxatoms = 10;
int maxneutron = 3;
void setup() {
  //size(650, 650);
  fullScreen();
  reset();
}

void draw() {
  background(255, 255, 255);

  for (neutron n : radicals) {
    n.move();
    n.create();
  }
  if (uranium.size() > 0) {
    for (int i = uranium.size() - 1; i >= 0; i--) {
      atom a = uranium.get(i);
      if (!a.gone) {
        a.move();
        a.create();
      } else {
        uranium.remove(a);
      }
    }
  }
}
void keyPressed() {//due metodi per personalizzare la posozione
  if (key == 'n' || key == 'N') {
    radicals.add(new neutron(new PVector(mouseX, mouseY)));
  } else if (key == 'a' || key == 'A') {
    atom u = new atom();
    u.loc.x = mouseX;
    u.loc.y = mouseY;
    u.pseudoloc.x = mouseX;
    u.pseudoloc.y = mouseY;
    uranium.add(u);
  } else if (key == ' ') {
    reset();
  }
}

void reset() {
  uranium = new ArrayList <atom>();
  radicals = new ArrayList <neutron>();
  for (int i = 0; i < maxatoms; i++) {
    uranium.add(new atom());
  }
}
