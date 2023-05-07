class lover extends boid{
  
 lover(PVector origin){ 
  
  super(origin);
   
  coeffc = 1.5;
   
 }
 
 void create() {//classico
    noStroke();
    fill(255, 192, 203, 100);
    ellipse(loc.x, loc.y, 20, 20);
  }
}
