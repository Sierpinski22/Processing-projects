class barrage {//funzioni: selezione e accoppiamento

  missile [] population;

  obstacle [] field;
  ArrayList <missile> matingpool;

  barrage() {

    field = new obstacle [int(random (5, 10))];

    for (int r = 0; r < field.length; r++) {

      field[r] = new obstacle();
    }

    matingpool = new ArrayList <missile>();
    population = new missile [maxpop];

    for (int i = 0; i < maxpop; i++) {

      population[i] = new missile();
    }
  }

  void evaluate() {
    float maxfit = 0;
    float avfit = 0;
    for (missile n : population) {
      n.fitness();
      avfit += n.fitness;
      if (n.fitness > maxfit) {
        maxfit = n.fitness;
      }
    }

    avfit /= population.length;
    print(' ', avfit);
    
    for (missile m : population) {  
      m.fitness /= maxfit;
    }

    matingpool = new ArrayList <missile> ();

    for (missile m : population) {

      float chance = m.fitness * 100;

      for (int i = 0; i <= chance; i++) {
        matingpool.add(m);
      }
    }
  }


  missile rand(ArrayList <missile> popul) {

    int rand = int(random((popul.size() - 1))); 
    return popul.get(rand);
  }


  void selection() {

    missile [] newgener = new missile [maxpop];

    for (int i = 0; i < maxpop; i++) {  

      missile A = rand(matingpool);
      missile B = rand(matingpool);

      DNA newdna = A.dna.crossover(B.dna);
      newdna.mutate();
      newgener[i] = new missile(newdna);
    }

    population = newgener;
  }

  void fire() {

    for (missile m : population) {

      m.check(field);
      m.move();
      m.create();
    }

    for (obstacle o : field) {
      o.show();
    }
  }
}
