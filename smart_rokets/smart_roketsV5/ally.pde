class ally {
  PVector position; 

  ally(PVector orig) {
    position = orig.copy();
  }

  void create() {
      
  fill(0, 255, 0);
  circle(position.x, position.y, 30);
  fill(255);
  circle(position.x, position.y, 20);
  fill(0, 255, 0);
  circle(position.x, position.y, 10); 
         
    }
  }
