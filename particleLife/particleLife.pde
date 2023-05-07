final int types = 7;
final int n = 20 * types; 
final color [] palette = new color[types];
final float [][] diplomacy = new float [types][types];
quadtree q;
particle [] p;

void setup() {
  size(600, 600);
  colorMode(HSB);
  p = new particle[n];
  for(int i=0; i<types; i++) palette[i] = color(300 / types * i, 300, 300);
  for(int i=0; i<n; i++) p[i] = new particle(random(0, width), random(0, height), i%types, palette[i%types]);
  for(int i=0; i<types * types; i++) diplomacy[i/types][i%types] = random(-2, 2);
  for(int i=0; i<types * types; i++) print(diplomacy[i/types][i%types], i%types == types-1?'\n':' ');
  q = new quadtree(0, 0, width, height, 0);
}

void draw() {
  background(0);
  convertInsert(p, q);
   for(int i=0; i<n; i++) {
     p[i].behave(q, diplomacy, p);
     p[i].move();
     p[i].show();
   }
   q.showStructure();
   q.eliminate();
   
}
