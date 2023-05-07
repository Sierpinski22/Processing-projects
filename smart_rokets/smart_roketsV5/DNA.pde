float mutchan = 0.001;
class DNA {//funzioni: crossover e mutazione

  PVector [] genes;
  DNA() {
    genes = new PVector [life];
    for (int i = 0; i < life; i++) {
      genes[i] = PVector.random2D();
      genes[i].setMag(maxvel);
    }
  }  


  DNA(PVector [] newgenes) {
    genes = newgenes;
  }

  DNA crossover(DNA patner) {
    PVector [] newgenes = new PVector [life];
    int mid = floor(life / 2);
    for (int i = 0; i < life; i++) {
      if (i <= mid) {
        newgenes[i] = genes[i];
      } else {
        newgenes[i] = patner.genes[i];
      }
    }

    return new DNA (newgenes);
  }

  void mutate() {
    for (int i = 0; i < life; i++) {
      if (mutchan >= random(1)) {
        genes[i] = PVector.random2D();
      }
    }
  }
}
