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
    //Afficher le menu
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
}
