Game game;
int levelWidth = 23; 
int levelHeight = 22;
PFont f;
PImage sprites;

void settings() {
  size((CELL_SIZE*levelWidth + int(POSITION_BOARD.x)), (CELL_SIZE*levelHeight + int(POSITION_BOARD.y)), P2D);
}

void setup() {
  background(0);
  f = createFont("Roboto-Regular.ttf", 16, false);
  sprites = loadImage("data/img/pacman_sprites.png");
  game = new Game(levelWidth, levelHeight);   
  
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
