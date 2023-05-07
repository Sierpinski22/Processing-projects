class travmer {

  DNA dna;
  float sum = 0;
  float fitness = 0;

  travmer(DNA d) {
    dna = d;
  }

  travmer() {
    this(new DNA());
  }


  void fitness() {
    sum = 0;
    for (int i = 1; i < maxcit; i++) {
      sum += dist(cities[dna.genes[i-1]].x, cities[dna.genes[i-1]].y, 
        cities[dna.genes[i]].x, cities[dna.genes[i]].y);
    }

    sum += dist(cities[0].x, cities[0].y, cities[dna.genes[maxcit-1]].x, cities[dna.genes[maxcit-1]].y);
    fitness =  1 / (pow(sum, 8) + 1);
    if (sum <= perfect + 1) {
      fitness *= 1000;
      
    }
  }


  void move() {

    noFill();
    strokeWeight(4);
    beginShape();
    for (int i = 0; i < maxcit; i++) {
      vertex(cities[dna.genes[i]].x, cities[dna.genes[i]].y);
    }
    vertex(cities[0].x, cities[0].y); 
    endShape();
  }
}
