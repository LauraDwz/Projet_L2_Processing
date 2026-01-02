class Hero {
  // position on screen
  PVector _position; //position on the board in pixel
  PVector _posOffset; //_position but with the gap
  PVector _realPosition; //intermediate position to slow down pacman
  // position on board
  int _cellX, _cellY;
  // display size
  float _size;
  
  // move data
  PVector _direction;
  PVector _waitingDirection;
  boolean _moving; // is moving ? 
  float _speed;
  
  //hero sprites
  PImage _imgUp;
  PImage _imgDown;
  PImage _imgLeft;
  PImage _imgRight;
  PImage _imgNoDirection;
    
  Hero(int cellX, int cellY, float size) {
    _cellX = cellX;
    _cellY = cellY; 
    _size = size;
    _position = setPosition();
    _posOffset = setPositionOffset();
    _realPosition = _posOffset.copy();
    
    _imgUp = sprites.get(SPRITE_HERO_X, Y_HERO_UP, SPRITE_HERO_SIZE, SPRITE_HERO_SIZE);
    _imgDown = sprites.get(SPRITE_HERO_X, Y_HERO_DOWN, SPRITE_HERO_SIZE, SPRITE_HERO_SIZE);
    _imgLeft = sprites.get(SPRITE_HERO_X, Y_HERO_LEFT, SPRITE_HERO_SIZE, SPRITE_HERO_SIZE);
    _imgRight = sprites.get(SPRITE_HERO_X, Y_HERO_RIGHT, SPRITE_HERO_SIZE, SPRITE_HERO_SIZE);
    _imgNoDirection = sprites.get(SPRITE_HERO_X, Y_HERO_NODIRECTION, SPRITE_HERO_SIZE, SPRITE_HERO_SIZE);
  
    _direction = new PVector(0, 0);
    _waitingDirection = null;
    _moving = false;   
    _speed = 2;
  }
  
  PVector setPosition() {
    return new PVector(_cellX*CELL_SIZE + HALF_CELL, _cellY*CELL_SIZE + HALF_CELL);
  } //renvoie le centre de la cellule ou il est
  
  PVector setPositionOffset() {
    return new PVector(_position.x + POSITION_BOARD.x, _position.y + POSITION_BOARD.y);
  } //renvoie le centre de la cellule ou il est adapté au décalage du début
  
  
  void launchMove(PVector dir) {
    _waitingDirection = dir;
  }
  
  void move() {
    boolean cross = false; //est ce que pacman traverse pour aller de l'autre coté
    _cellX += _direction.x;
    if (_cellX == BOARD_WIDTH) {
      _cellX = 0;
      cross = true;
    } else if (_cellX == -1) {
      _cellX = BOARD_WIDTH -1;
      cross = true;
    }
    _cellY += _direction.y;
    if (_cellY == BOARD_HEIGHT) {
      _cellY = 0;
      cross = true;
    } else if (_cellY == -1) {
      _cellY = BOARD_HEIGHT -1;
      cross = true;
    }
    _position = setPosition();
    _posOffset = setPositionOffset();
    if (cross) {
      _realPosition = _posOffset.copy();
    }
  }
  
  void update() {      
  }
  
  void changeDirection() {
    _direction = _waitingDirection;
    _waitingDirection = null;
  }
  
  PVector currentCell() {
    return new PVector(_cellX, _cellY);
  }
  
  PVector nextCellDirection() {
    float x = _cellX + _direction.x; 
    float y = _cellY + _direction.y;
    if (x == BOARD_WIDTH) {
      x = 0;
    } else if (x == -1 ) {
      x = BOARD_WIDTH -1;
    }
    if (y == BOARD_HEIGHT) {
      y = 0;
    } else if (y == -1 ) {
      y = BOARD_HEIGHT -1;
    }
    return new PVector(x, y);
  }
  
  PVector nextCellWaiting() {
    float x = _cellX + _waitingDirection.x; 
    float y = _cellY + _waitingDirection.y;
    if (x == BOARD_WIDTH) {
      x = 0;
    } else if (x == -1 ) {
      x = BOARD_WIDTH -1;
    }
    if (y == BOARD_HEIGHT) {
      y = 0;
    } else if (y == -1 ) {
      y = BOARD_HEIGHT -1;
    }
    return new PVector(x, y);
  }
    
  void drawIt() {
    imageMode(CENTER);
    if (_direction.equals(new PVector(0, 1))) { //il va en bas
      image(_imgDown, _realPosition.x, _realPosition.y, _size, _size);
    } else if (_direction.equals(new PVector(0, -1))) { //il va en haut
      image(_imgUp, _realPosition.x, _realPosition.y, _size, _size);
    } else if (_direction.equals(new PVector(1, 0))) { //il va a droite
      image(_imgRight, _realPosition.x, _realPosition.y, _size, _size);
    } else if (_direction.equals(new PVector(-1, 0))) { //il va à gauche
      image(_imgLeft, _realPosition.x, _realPosition.y, _size, _size);
    } else {
      image(_imgNoDirection, _realPosition.x, _realPosition.y, _size, _size);
    }
  }
}
