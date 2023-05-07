class cerchio{

  float x;
  float y;
  float raggio;
  
  cerchio(float x_, float y_, float r){
   
    x = x_;
    y = y_;
    raggio = r;
    
    
  }


   void create(){
    
     circle(x, y, raggio);
     
   }
}
