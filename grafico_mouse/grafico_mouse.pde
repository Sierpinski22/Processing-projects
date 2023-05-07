int [] y;
int k;

void setup (){ 
  size (1366, 768); 
  y = new int[width]; 
}
  
  void draw(){
    
    background(204);; //qui, così il prompt si pulisce dopo la stampa dell'array
    
    for( k = y.length - 1; k > 0; k--){ //y.length - 1 perchè gli array partono da 0 e con length da solo si eccede il limite dell'array stesso. wow 
        y[k] = y[k - 1]; //spostamento valori verso "destra" per la stampa mobile
    }
    
    y[0] = mouseY;
    
    for( k = 1; k  < y.length; k++){  
              line(k, y[k], k - 1, y[k - 1]);
    }      
  }
