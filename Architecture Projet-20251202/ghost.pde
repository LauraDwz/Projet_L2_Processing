class Ghost {
  
  // position on screen
  PVector _position; //position on the board in pixel
  PVector _posOffset; //_position but with the gap
  PVector _realPosition; //intermediate position to slow down the ghost
  // position on board
  int _cellX, _cellY;
  // display size
  float _size;
  
  // move data
  PVector _direction;
  boolean _moving; // is moving ? not moving in the beginning of the game
  float _speed;
  
  //hero sprites
  PImage _imgUp;
  PImage _imgDown;
  PImage _imgLeft;
  PImage _imgRight;
  PImage _imgNoDirection;
  
  Ghost(int cellX, int cellY, float size, int spriteX) {
    _cellX = cellX;
    _cellY = cellY; 
    _size = size;
    _position = setPosition();
    _posOffset = setPositionOffset();
    _realPosition = _posOffset.copy();
    
    _imgUp = sprites.get(spriteX, Y_GHOST_UP, SPRITE_SIZE, SPRITE_SIZE);
    _imgDown = sprites.get(spriteX, Y_GHOST_DOWN, SPRITE_SIZE, SPRITE_SIZE);
    _imgLeft = sprites.get(spriteX, Y_GHOST_LEFT, SPRITE_SIZE, SPRITE_SIZE);
    _imgRight = sprites.get(spriteX, Y_GHOST_RIGHT, SPRITE_SIZE, SPRITE_SIZE);
    _imgNoDirection = sprites.get(spriteX, Y_GHOST_RIGHT, SPRITE_SIZE, SPRITE_SIZE); //pas de sprite les yeux au centre
  
    _direction = new PVector(0, 0);
    _moving = false;   
    _speed = 2;
  }
  
  PVector setPosition() {
    return new PVector(_cellX*CELL_SIZE + HALF_CELL, _cellY*CELL_SIZE + HALF_CELL);
  } //renvoie le centre de la cellule ou il est
  
  PVector setPositionOffset() {
    return new PVector(_position.x + POSITION_BOARD.x, _position.y + POSITION_BOARD.y);
  } //renvoie le centre de la cellule ou il est adapté au décalage du début
  
  PVector nextCell() {
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
  
  void launchMove(PVector dir) {
    _direction = dir;
  }
  
  boolean isOnCell() {
    return PVector.dist(_realPosition, _posOffset) < _speed;
  }
  
  void moveSlowly() {
      if (PVector.dist(_realPosition, _posOffset) < _speed) {
        move();
      } else if (_realPosition.x > _posOffset.x) {
        _realPosition.x -= _speed;
      } else if (_realPosition.x < _posOffset.x) {
        _realPosition.x += _speed;
      } else if (_realPosition.y > _posOffset.y) {
        _realPosition.y -= _speed;
      } else if (_realPosition.y < _posOffset.y) {
        _realPosition.y += _speed;
      }    
  }
  
  void move() {
    boolean cross = false; //est ce que le fantome traverse pour aller de l'autre coté
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
  
