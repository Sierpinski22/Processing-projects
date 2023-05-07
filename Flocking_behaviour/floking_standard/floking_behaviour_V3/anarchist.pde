class anarchist extends boid{
  
  
  anarchist(PVector origin){
  
  super(origin);
  
  coeffc = -1;
 
  }
  




  void create() {//classico
    noStroke();
    fill(0, 100);
    ellipse(loc.x, loc.y, 20, 20);
  }
}
