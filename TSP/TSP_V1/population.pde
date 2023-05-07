class population {

  ArrayList <travmer> matingpool;
  travmer [] popul;
  travmer best;
  travmer alltbest;
  boolean first = true;

  population() {

    best = new travmer();
    alltbest = new travmer();
    popul = new travmer [maxpop];
    matingpool = new ArrayList <travmer> ();

    for (int i = 0; i < maxpop; i++) {
      popul[i] = new travmer();
    }
  }


  void evaluate() {

    float maxfit = 0;

    for (travmer t : popul) {
      t.fitness();
      if (t.fitness > maxfit) {
        maxfit = t.fitness;
        best.fitness = maxfit;
        best.dna.genes = t.dna.genes;
        best.sum = t.sum;
      }
    }

    for (travmer t : popul) {
      t.fitness /= maxfit;
    }

    matingpool.clear(); //complimenti...

    for (travmer t : popul) {
      double chance = t.fitness * 100;
      for (int i = 0; i <= chance; i++) {

        matingpool.add(t);
      }
    }
  }

  void selection() {

    travmer [] newpop = new travmer[maxpop];

    for (int i = 0; i < maxpop; i++) {

      travmer A = rand(matingpool);
      travmer B = rand(matingpool);

      DNA newdna = A.dna.crossover(B.dna);
      newdna.mutate();
      newpop[i] = new travmer(newdna);
    }

    popul = newpop;
  }

  travmer rand(ArrayList <travmer> p) {
    int rand = int(random((p.size() - 1)));
    return p.get(rand);
  }

  void write() {
    strokeWeight(2);

    if (first) {
      alltbest.dna.genes = best.dna.genes;
      alltbest.fitness = best.fitness;
      alltbest.sum = best.sum;
      first = false;
    } else if (alltbest.fitness < best.fitness) {
      alltbest.dna.genes = best.dna.genes;
      alltbest.fitness = best.fitness;
      alltbest.sum = best.sum;
    }

    stroke(0, 0, 140);
    best.move();
    stroke(255, 140, 0);
    alltbest.move();
  }
}
