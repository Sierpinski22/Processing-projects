ArrayList <boid> flock = new ArrayList <boid> ();

void setup(){
    size(1000, 700);
    strokeWeight(10);
    for(int i = 0; i < 100; i++){
      flock.add(new boid());
    }
}


void draw(){
 background(255);
  //noLoop();
  for(boid m : flock){
  
    m.behave(flock);
    m.edge();
    m.move();
    m.create();
  
  }
}
