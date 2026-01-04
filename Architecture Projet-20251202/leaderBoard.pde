class LeaderBoard {
  String _fileName;
  LeaderBoard() {
    _fileName = "data/leaderboard.txt";
  }
  
  void update(String pseudo, int score) {
    print(pseudo);
    String[] lines = loadStrings(_fileName);
    ArrayList<String> all = new ArrayList<String>();
    if (lines != null) {
      for (String line : lines) {
        all.add(line);
      }
    }

    all.add(pseudo + " " + score);

    for (int i = 0; i < all.size() - 1; i++) {
      for (int j = i + 1; j < all.size(); j++) {

        int scoreI = int(split(all.get(i), ' ')[1]);
        int scoreJ = int(split(all.get(j), ' ')[1]);

        if (scoreJ > scoreI) {
          String temp = all.get(i);
          all.set(i, all.get(j));
          all.set(j, temp);
        }
      }
    }

    while (all.size() > 5) {
      all.remove(all.size() - 1);
    }


    String[] output = new String[all.size()];
    for (int i = 0; i < all.size(); i++) {
      output[i] = all.get(i);
    }

    saveStrings(_fileName, output);
  }
  
  void drawIt() {
    String[] output = loadStrings(_fileName);
    //Dessiner le fond du menu
    stroke(color(255,255,0));
    strokeWeight(5);
    fill(color(0, 0, 0));
    rectMode(CENTER);
    rect(width/2, height/2, width*0.9, height*0.9, 15);
        
    //Dessiner le titre
    fill(color(255,255,0));
    textFont(f, 50);
    textAlign(CENTER, CENTER);
    text("LeaderBoard", width/2, 1*height/8);
    
    //Dessiner les bulles
    stroke(color(0,0,255));
    strokeWeight(3);
    fill(color(0, 0, 0));
    rect(width/2, 2*height/8, width*0.5, height*0.05, 25);
    rect(width/2, 3*height/8, width*0.5, height*0.05, 25);
    rect(width/2, 4*height/8, width*0.5, height*0.05, 25);
    rect(width/2, 5*height/8, width*0.5, height*0.05, 25);
    rect(width/2, 6*height/8, width*0.5, height*0.05, 25);
    rect(width/2, 7*height/8, width*0.5, height*0.05, 25);
    
    //Dessiner les textes    
    fill(color(255,255,0));
    textFont(f, 12);
    textAlign(CENTER, CENTER);
    text(output[0], width/2, 2*height/8);
    text(output[1], width/2, 3*height/8);
    text(output[2], width/2, 4*height/8);
    text(output[3], width/2, 5*height/8);
    text(output[4], width/2, 6*height/8);
    text("Restart", width/2, 7*height/8);
  }
}
