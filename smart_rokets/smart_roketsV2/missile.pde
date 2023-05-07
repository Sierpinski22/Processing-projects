class missile {//funzioni: calcolo fitness

  DNA dna;
  PVector loc;
  PVector vel;
  PVector acc;
  boolean arrived;
  boolean crushed;
  float fitness;
  int counter = 0;
 

  missile() {//doppio costurttore, se il missile non eredita un dna ne crea uno casuale

    this(new DNA());
  }

  missile(DNA erdna) {

    dna = erdna;
    fitness = 0;
    loc = origin.copy();
    vel = new PVector ();
    acc = new PVector ();
    arrived = false;
    crushed = false;
  }

  void appfor(PVector f) {
    
    acc.add(f.copy());
  
}

  void fitness(){
    
    float d = distancet();
   fitness = map(d, 0, width, width, 0); //quando la distanza è 0 la fitness è uguale a width, e viceversa
   
  if(arrived){
    fitness *= 1000;
  }else if((loc.x < 0 || loc.x > width) || (loc.y < 0 || loc.y > height)){
   fitness = 0; 
  }

}

float distancet(){
  
 return dist(loc.x, loc.y, target.x, target.y); 
  
  
}

  void move() {

   if(!arrived){
    if(counter > 0){
      appfor(dna.genes [counter]);
    }
    
    counter++;
    
    vel.add(acc);
    loc.add(vel);
    
    acc.mult(0);
    
    if(distancet() < 20){
      
      arrived = true;
      loc = target.copy();
    }
   }
  }

  void create() {
    
    pushMatrix();
    fill(255, 100);
    translate(loc.x, loc.y);
    rotate(vel.heading() + radians(90));
    rect(0, 0, 10, 50);
    popMatrix();
    
  }
}
