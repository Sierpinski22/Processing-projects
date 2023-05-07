class cerchio{

  float x;
  float y;
  float raggio;
  float vel;
  
  cerchio(float v){
   
    x = 0;
    y = 0;
    raggio = 0;
    vel = v;
    
  }


   void create(){
    
     ellipse(x, y, raggio, raggio);
     
   }
}
