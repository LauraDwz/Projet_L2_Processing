class DefeatScreen {
  DefeatScreen() {
  }
  
  void drawIt(int score) {
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
    text("DEFEAT", width/2, height/6);
    
    //Dessiner les bulles
    stroke(color(0,0,255));
    strokeWeight(3);
    fill(color(0, 0, 0));
    rect(width/2, 3*height/6, width*0.5, height*0.1, 25);
    rect(width/2, 5*height/6, width*0.5, height*0.1, 25);

    
    //Dessiner les textes    
    fill(color(255,255,0));
    textFont(f, 25);
    textAlign(CENTER, CENTER);
    text("Score : " + score, width/2, 3*height/6);
    text("Restart", width/2, 5*height/6);
  }
}
