class VictoryScreen {
  VictoryScreen() {
  }
  
  void drawIt(int score, int nbLife) {
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
    text("VICTORY", width/2, height/8);
    
    //Dessiner les bulles
    stroke(color(0,0,255));
    strokeWeight(3);
    fill(color(0, 0, 0));
    rect(width/2, 3*height/8, width*0.5, height*0.1, 25);
    rect(width/2, 5*height/8, width*0.5, height*0.1, 25);
    rect(width/2, 7*height/8, width*0.5, height*0.1, 25);
    
    //Dessiner les textes    
    fill(color(255,255,0));
    textFont(f, 25);
    textAlign(CENTER, CENTER);
    text("Score : " + score, width/2, 3*height/8);
    text("Nb Life : " + nbLife, width/2, 5*height/8);
    text("Entrer le pseudo", width/2, 7*height/8);
  }
}
