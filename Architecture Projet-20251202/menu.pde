class Menu {
  Menu() {
  }
  
  void drawIt() {
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
    text("Menu", width/2, height/8);
    
    //Dessiner la bulle continuer
    stroke(color(0,0,255));
    strokeWeight(3);
    fill(color(0, 0, 0));
    rect(width/2, 2*height/8, width*0.5, height*0.1, 25);
    fill(color(255,255,0));
    textFont(f, 25);
    textAlign(CENTER, CENTER);
    text("Continue", width/2, 2*height/8);
    
    //Dessiner la bulle recommencer
    stroke(color(0,0,255));
    strokeWeight(3);
    fill(color(0, 0, 0));
    rect(width/2, 3*height/8, width*0.5, height*0.1, 25);
    fill(color(255,255,0));
    textFont(f, 25);
    textAlign(CENTER, CENTER);
    text("Restart the level", width/2, 3*height/8);
    
    //Dessiner la bulle charger
    stroke(color(0,0,255));
    strokeWeight(3);
    fill(color(0, 0, 0));
    rect(width/2, 4*height/8, width*0.5, height*0.1, 25);
    fill(color(255,255,0));
    textFont(f, 25);
    textAlign(CENTER, CENTER);
    text("Load the saved level", width/2, 4*height/8);
    
    //Dessiner la bulle sauvegarder
    stroke(color(0,0,255));
    strokeWeight(3);
    fill(color(0, 0, 0));
    rect(width/2, 5*height/8, width*0.5, height*0.1, 25);
    fill(color(255,255,0));
    textFont(f, 25);
    textAlign(CENTER, CENTER);
    text("Save the level", width/2, 5*height/8);
    
    //Dessiner la bulle Show the best scores
    stroke(color(0,0,255));
    strokeWeight(3);
    fill(color(0, 0, 0));
    rect(width/2, 6*height/8, width*0.5, height*0.1, 25);
    fill(color(255,255,0));
    textFont(f, 25);
    textAlign(CENTER, CENTER);
    text("Show the best scores", width/2, 6*height/8);
    
    //Dessiner la bulle Quitter le jeu
    stroke(color(0,0,255));
    strokeWeight(3);
    fill(color(0, 0, 0));
    rect(width/2, 7*height/8, width*0.5, height*0.1, 25);
    fill(color(255,255,0));
    textFont(f, 25);
    textAlign(CENTER, CENTER);
    text("Leave the game", width/2, 7*height/8);
  }
}
