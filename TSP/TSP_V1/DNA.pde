class DNA {

  int [] genes;
  float mutchan = 0.27;

  DNA() {

    genes = new int[maxcit];

    for (int i = 0; i < maxcit; i++) {
      genes[i] = i;
    }

    for (int w = 0; w < maxcit; w++) {    
      randomize();
    }
  }

  DNA(int [] newgenes) {
    genes = newgenes;
  }

  void randomize() {
    int r1 = floor(random(maxcit));
    int r2 = floor(random(maxcit));
    int temp = genes[r1];

    while (r1 == r2 || r1 == 0 || r2 == 0) {
      r1 = int(random(maxcit));
      r2 = int(random(maxcit));
      temp = genes[r1];
    }
    genes[r1] = genes[r2];
    genes[r2] = temp;
  }

  DNA crossover(DNA patner) {//eventuali problemi qui

    int [] newgenes = new int[maxcit];
    newgenes[0] = 0;
    for (int i = 1; i < maxcit; i++) {

      if (i <= maxcit / 2) {
        newgenes[i] = genes[i];
      } else {

        for (int y = 1; y < maxcit; y++) {
          if (!numin(newgenes, patner.genes[y])) {
            newgenes[i] = patner.genes[y];
            break;
          }
        }
      }
    }
    return new DNA(newgenes);
  }

  boolean numin(int [] newg, int n) {

    for (int i : newg) {
      if (i == n) {
        return true;
      }
    }

    return false;
  }


  void mutate() {

    if (random(1) <= mutchan) {
      randomize();
    }
  }
}


//void mutate() {

//   if (random(1) <= mutchan) {
//     for (int w = 0; w < floor(maxcit / 2); w++) {    
//       randomize();
//     }
//   }
// }
