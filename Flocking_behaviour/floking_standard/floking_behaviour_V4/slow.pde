class slow extends boid{
  
 slow(PVector origin){ 
  
   super(origin);
  
  maxvel = 1;
  maxfor = 0.15;
  
 }

  void create() {//classico
    noStroke();
    fill(189, 183, 107, 150);
    ellipse(loc.x, loc.y, 20, 20);
  }
}
