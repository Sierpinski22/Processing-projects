class lover extends boid{
  
 lover(PVector origin){ 
  
  super(origin);
   
  coeffc = 1.5;
   
 }
 
 void create() {//classico
float angle = vel.heading() + radians(90);

fill(255, 170, 203);
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
