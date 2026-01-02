Game game;
PFont f;
PImage sprites;

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
  game.update();
  game.drawIt();
}

void keyPressed() {
  game.handleKey(key);
}

void mousePressed() {
}
