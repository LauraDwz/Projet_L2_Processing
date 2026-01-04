Game game;
PFont f;
PImage sprites;
boolean showMenu = false;
boolean lost = false;
boolean win = false;
boolean pseudo = false;
String pseudoname = "";
boolean showLeaderBoard = false;
Menu menu = new Menu();
VictoryScreen victoryScreen = new VictoryScreen();
DefeatScreen defeatScreen = new DefeatScreen();
PseudoScreen pseudoScreen = new PseudoScreen();
LeaderBoard leaderBoard = new LeaderBoard();

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
  if (showLeaderBoard) {    
    leaderBoard.drawIt();
  } else if (! showMenu && ! game.isFinished()) {
    game.update();
    game.drawIt();
  } else if (showMenu) {
    menu.drawIt();
  } else if (game.isFinished() && game.isWin() && ! pseudo) {
    win = true;
    victoryScreen.drawIt(game._score, game._nbLife);
  } else if (pseudo) {
    pseudoScreen.drawIt(pseudoname);
  } else {
    lost = true;
    defeatScreen.drawIt(game._score);
  }
}

void keyPressed() {
  if (! game.isFinished()) {
    if (key == CODED) {
      game.handleKey(keyCode);
    } else {
      if (key == ESC) {
        key = 0; //pour éviter qu'il sorte automatiquement
        showMenu = true;
        menu.drawIt();
      } else {
        game.handleKey(key);
      }
   }
  } else if (pseudo) {
    if (key == ENTER || key == RETURN) {
      if (pseudoname.length() > 0) {
        pseudo = false;
        leaderBoard.update(pseudoname, game._score);
        showLeaderBoard = true;
      }
    } else if (key == BACKSPACE) {
      if (pseudoname.length() > 0) {
        pseudoname = pseudoname.substring(0, pseudoname.length() - 1);
      }
    } else if (key >= 32 && key <= 126) {
      pseudoname += key;
    }
  } 
}

void mousePressed() {
  if (showMenu) {
    if (mouseX >= width*0.25 && mouseX <= width*0.75) {
      if (mouseY >= 2*height/8 - 0.05*height && mouseY <= 2*height/8 + 0.05*height) {
        showMenu = false; //on reprend
      } else if (mouseY >= 3*height/8 - 0.05*height && mouseY <= 3*height/8 + 0.05*height) {
        game.restartLevel();
        showMenu = false;
      } else if (mouseY >= 4*height/8 - 0.05*height && mouseY <= 4*height/8 + 0.05*height) {
        game.loadLevel();
        showMenu = false;
      } else if (mouseY >= 5*height/8 - 0.05*height && mouseY <= 5*height/8 + 0.05*height) {
        game.saveLevel(); //on laisse le menu ouvert => quitter le jeu ou continuer etc
      } else if (mouseY >= 6*height/8 - 0.05*height && mouseY <= 6*height/8 + 0.05*height) {
        leaderBoard.drawIt();
        showLeaderBoard = true;
        showMenu = false;
      } else if (mouseY >= 7*height/8 - 0.05*height && mouseY <= 7*height/8 + 0.05*height) {
        exit(); //on laisse le menu ouvert => quitter le jeu ou continuer etc
      }
    }
  }
  else if (lost) {
    if (mouseX >= width*0.25 && mouseX <= width*0.75) {
      if (mouseY >= 5*height/6 - 0.05*height && mouseY <= 5*height/6 + 0.05*height) {
        lost = false;
        game = new Game();//on reprend
      }
    }
  } else if (win)  {
    if (mouseX >= width*0.25 && mouseX <= width*0.75) {
      if (mouseY >= 5*height/6 - 0.05*height && mouseY <= 5*height/6 + 0.05*height) {
        pseudo = true;
        win = false;
      }
    }
  } else if (showLeaderBoard) {
    if (mouseX >= width*0.25 && mouseX <= width*0.75) {
      if (mouseY >= 7*height/8 - 0.025*height && mouseY <= 7*height/8 + 0.25*height) {
        game = new Game();
        win = false;
        pseudo = false;
        showLeaderBoard = false;
      }
    }
  }
}
