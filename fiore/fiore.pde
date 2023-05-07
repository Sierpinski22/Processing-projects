int n = 0;
float c = 10;

void setup(){
   size(1000, 1000); 
   background(0);
   noStroke();
}
    float px = 0;
    float py = 0;
    boolean g = false;
    float r2 = 30;
    
    void keyPressed(){    
     saveFrame();
     print("done");
        
    }
       
 void draw(){
  
   float r = c * sqrt(n);
   float a = n * 20.2; //qui 50
   float x = r * cos(a) + width / 2;
   float y = r * sin(a) + height / 2;
   
   float dis = dist(x, y, width / 2, height / 2);
   
   float v = 4 * dis  % (width / 2)  + 10;
   
  if(n <= 255){
   fill(n);
   circle(width / 2, height / 2, r2);
  }
   //float v = (n % 255) + 10;
  // v = constrain(v, 50, 230);
   
   fill(0, 0, v, 200); 
   //fill(255 % x, 255 % y, 255 % r); //chrome??
   circle(x, y, 17);
   fill(v, 140, 0, 200);
   circle(y, x, 17);

   n++;
   px = x;
   py = y;
   
   if(r2 > 0){
   r2 -= 0.2;
   }
      
}
