void setup(){
 
  background(0);
  size(714, 714);
  //fill(255);
  stroke(255);
  //strokeWeight(4);
  float cx = width / 2;
  float cy = height / 2;
  float raggio = 250;
  translate(0, -height);
  recursion(cx, cy, raggio, 1, 3);
   
}

//numero magico == 0,9

void recursion(float x, float y, float raggio, float lvnow, float maxlv){

  float lato = raggio * sqrt(10 - 2 * sqrt(5)) / 2;
  float apotema = raggio * (sqrt(5) + 1) / 4;
  float spazio = sqrt(lato * lato - (lato / 2 * lato / 2));
  
 // raggio = raggio / 2;
  
  
  if(lvnow == maxlv){

  pentagon(x, y, raggio, lato, apotema, spazio); 
 
  }else{
    
   recursion(x, y, raggio / 2, lvnow + 1, maxlv); 
   recursion(x + spazio, y + apotema * 0.9, raggio / 4, lvnow + 1, maxlv);
   recursion(x - spazio, y + apotema * 0.9, raggio / 4, lvnow + 1, maxlv);
   recursion(x + lato / 2, y + apotema + raggio, raggio / 4, lvnow + 1, maxlv);
   recursion(x - lato / 2, y + apotema + raggio, raggio / 4, lvnow + 1, maxlv);
    
    
  }
  
}













void pentagon(float x, float y, float raggio, float lato, float apotema, float spazio){//richiesti: vertice SUPERIORE e RAGGIO

  
  //translate(0, -apotema);
  
  //line(0, 0, width, height); 
  line(x, y, x + spazio, y + apotema * 0.9);
  line(x + spazio, y + apotema * 0.9, x + lato / 2, y + apotema + raggio);
  line(x + lato / 2, y + apotema + raggio, x - lato / 2, y + apotema + raggio);
  line(x - lato / 2, y + apotema + raggio, x - spazio, y + apotema * 0.9);
  line(x - spazio, y + apotema * 0.9, x, y);

  print(dist(x, y, x + spazio, y + apotema * 0.727));
  print('a',lato);
}
