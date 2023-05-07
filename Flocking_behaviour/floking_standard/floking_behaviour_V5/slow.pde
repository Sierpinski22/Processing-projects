class slow extends boid{
  
 slow(PVector origin){ 
  
   super(origin);
  
  maxvel = 1;
  maxfor = 0.15;
  
 }

  void create() {//classico
float angle = vel.heading() + radians(90);

noStroke();
fill(189, 183, 107);
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
