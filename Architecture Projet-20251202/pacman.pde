Game game;
PFont f;
PImage sprites;
boolean pause = false;
Menu menu = new Menu();

void settings() {
  size((CELL_SIZE*BOARD_WIDTH + int(POSITION_BOARD.x)), (CELL_SIZE*BOARD_HEIGHT + int(POSITION_BOARD.y)), P2D);
}

void setup() {
  background(0);
  f = createFont("Roboto-Regular.ttf", 16, false);
  sprites = loadImage("data/img/pacman_sprites.png");
  game = new Game();   
  
}

void draw() {
  if (! pause && ! game.isFinished()) {
    game.update();
    game.drawIt();
  } else if (pause) {
    menu.drawIt();
  } else if (game.isFinished() && game.isWin()) {
    //Afficher le tableau des victoires etc
  } else {
    //Proposer de recommencer
  }
}

void keyPressed() {
  if (key == CODED) {
    game.handleKey(keyCode);
  } else {
    if (key == ESC) {
      key = 0; //pour éviter qu'il sorte automatiquement
      pause = true;
      menu.drawIt();
    } else {
      game.handleKey(key);
    }
  }
}

void mousePressed() {
  if (pause) {
    if (mouseX >= width*0.25 && mouseX <= width*0.75) {
      if (mouseY >= 2*height/8 - 0.05*height && mouseY <= 2*height/8 + 0.05*height) {
        pause = false; //on reprend
      } else if (mouseY >= 3*height/8 - 0.05*height && mouseY <= 3*height/8 + 0.05*height) {
        game.restartLevel();
        pause = false;
      } else if (mouseY >= 4*height/8 - 0.05*height && mouseY <= 4*height/8 + 0.05*height) {
        game.loadLevel();
        pause = false;
      } else if (mouseY >= 5*height/8 - 0.05*height && mouseY <= 5*height/8 + 0.05*height) {
        game.saveLevel(); //on laisse le menu ouvert => quitter le jeu ou continuer etc
      } else if (mouseY >= 6*height/8 - 0.05*height && mouseY <= 6*height/8 + 0.05*height) {
        //afficher le leaderbord
      } else if (mouseY >= 7*height/8 - 0.05*height && mouseY <= 7*height/8 + 0.05*height) {
        exit(); //on laisse le menu ouvert => quitter le jeu ou continuer etc
      }
    }
  }
    
    
}
