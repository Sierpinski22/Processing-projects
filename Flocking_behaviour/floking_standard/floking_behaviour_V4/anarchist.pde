class anarchist extends boid{
  
  
  anarchist(PVector origin){
  
  super(origin);
  
  coeffc = -1;
 
  }

  void create() {//classico
float angle = vel.heading2D() + radians(90);

fill(0, 150);
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
