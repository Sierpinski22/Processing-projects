class anarchist extends boid{
  
  
  anarchist(PVector origin){
  
  super(origin);
  sight = 150;
  coeffc = -1;
  coeffa = -1;
  }

  void create() {//classico
float angle = vel.heading() + radians(90);

fill(150);
noStroke();

pushMatrix();
translate(loc.x, loc.y);
rotate(angle);
beginShape(TRIANGLES);
vertex(0, -r*2);
vertex(-r, r*2);
vertex(r, r*2);
endShape();
popMatrix();

  }
}
