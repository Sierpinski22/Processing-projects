void setup(){
  
  
  size(1000, 600);
  stroke(255);
  background(0);
  //strokeWeight(2);
  noFill();
  
  fractal(width / 2, height / 2, 200);
  
  
  
}


void fractal(float x, float y, float d){
  
  circle(x, y, d);
  
  if(d >= 2){
    
   fractal(x + d / 2, y, d / 2);
   fractal(x - d / 2, y, d / 2);
   
   fractal(x, y - d / 2, d / 2);
   //fractal(x, y + d / 2, d / 2);
   //fractal(x - d / 2, y - d / 2, d / 2);
   //fractal(x + d / 2, y + d / 2, d / 2);
   //fractal(x + d / 2, y - d / 2, d / 2);
   //fractal(x - d / 2, y + d / 2, d / 2);
  }
}
  
  
