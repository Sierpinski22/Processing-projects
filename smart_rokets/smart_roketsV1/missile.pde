class missile {

  PVector loc;
  PVector vel;
  PVector acc;
  DNA code;
  int counter = 0;

  missile(PVector origin) {

    loc = origin.copy();
    vel = new PVector();
    acc = new PVector();
    code = new DNA();
    
  
}


  void appgen(PVector f) {
    
    acc.add(f.copy());
     
  }


  void move() {
     
    if(counter < code.genes.length - 1){
     
      counter++;
      
    }
    
    appgen(code.genes[counter]);
    
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
    
  }


  void create() {

    pushMatrix();
    translate(loc.x, loc.y);
    rotate(vel.heading() + radians(90));
    fill(255, 150);
    rect(0, 0, 10, 40);
    popMatrix();
    
  }
}
