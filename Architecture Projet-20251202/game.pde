class Game 
{
  Board _board;
  Hero _hero;
  Ghost _redGhost;
  Ghost _pinkGhost;
  Ghost _blueGhost;
  Ghost _orangeGhost;
  
  String _levelName;
  
  int _score;
  int _nbLife;
  
  int _count; //représente le nombre de tours de jeu : combien de fois pacman a changé de case ou eu le temps le faire
  
  Game() {
    _board = new Board(BOARD_WIDTH, BOARD_HEIGHT, CELL_SIZE);
    _hero = new Hero(11, 16, CELL_SIZE*0.8);
    _levelName = "Level 1";
    _score = 0;
    _nbLife = 2;
    _count = 0;
    _pinkGhost = new Ghost(10, 10, CELL_SIZE*0.8, SPRITE_PINK_X);
    _blueGhost = new Ghost(12, 10, CELL_SIZE*0.8, SPRITE_BLUE_X);
    _redGhost = new Ghost(9, 10, CELL_SIZE*0.8, SPRITE_RED_X);
    _orangeGhost = new Ghost(13, 10, CELL_SIZE*0.8, SPRITE_ORANGE_X);
  }
  
  void update() {   
    //Gestion du héros
    //Avancée progressive
    if ( !(_hero._realPosition.equals(_hero._posOffset)) ) {
      if (_hero._realPosition.x > _hero._posOffset.x) {
        _hero._realPosition.x -= _hero._speed;
      } else if (_hero._realPosition.x < _hero._posOffset.x) {
        _hero._realPosition.x += _hero._speed;
      } else if (_hero._realPosition.y > _hero._posOffset.y) {
        _hero._realPosition.y -= _hero._speed;
      } else if (_hero._realPosition.y < _hero._posOffset.y) {
        _hero._realPosition.y += _hero._speed;
      }
    }
    else { //Il est arrivé à sa case - capture de la DOT
      if (_count >= 1) _count += 1;      
      PVector heroCell = _hero.currentCell();
      if (_board.isDot(heroCell)) {
        _board.takeDot(heroCell);
        _score += SCORE_DOT;
      } else if (_board.isSuperDot(heroCell)) {
        _board.takeDot(heroCell);
        _score += SCORE_SUPER_DOT;
      }
      
      if (_hero._waitingDirection != null) {
        PVector nextCellWaiting = _hero.nextCellWaiting();
        if (movePossible(nextCellWaiting)) {
          _hero.changeDirection();
        }
      }      
      
      PVector nextCell = _hero.nextCellDirection();
      if (movePossible(nextCell)) {
        _hero.move();
      }
    }
    println(_count);
    //Gestion des fantomes - lancement et update du fantome rose
    if (_count == 10) {
      _pinkGhost.launchMove(new PVector(1, 0));
      _pinkGhost.moveSlowly();
      println("Coordonnées x y " + _pinkGhost._cellX + "puis " + _pinkGhost._cellY);
    } else if (_count == 11) {
      _pinkGhost.launchMove(new PVector(0,-1));
      _pinkGhost.moveSlowly();
    } else if (_count >= 12) {      
      _pinkGhost.moveSlowly();  
      if (_pinkGhost.isOnCell()) {
        PVector nextCell = _pinkGhost.nextCell();
        if (!movePossible(nextCell)) {
          _pinkGhost.launchMove(new PVector(1, 0));
        }
      }
   }
 }
  
  boolean movePossible(PVector cell) {
    return !(_board.isWall(cell));
  }
  
  void drawIt() {
    _board.drawIt();
    fill(255);
    textFont(f, 40);
    textAlign(CENTER);
    text(_levelName, width/2, POSITION_BOARD.y/2);
    textAlign(RIGHT); 
    text("Score : " + _score, width/3, 3*POSITION_BOARD.y/4);
    textAlign(LEFT);
    text("Life : " + _nbLife, width - width/3, 3*POSITION_BOARD.y/4);
    
    _hero.drawIt();
    _redGhost.drawIt();
    _pinkGhost.drawIt();
    _blueGhost.drawIt();
    _orangeGhost.drawIt();
  }
  
  void handleKey(int k) {
    if (_count == 0) _count = 1;
    if (k=='Z' || k=='z' || k == UP) {
      _hero.launchMove(new PVector(0, -1));
    } else if (k=='Q' || k=='q' || k == LEFT) {
      _hero.launchMove(new PVector(-1, 0));
    } else if (k=='S' || k=='s' || k == DOWN) {
      _hero.launchMove(new PVector(0, 1));
    } else if (k=='D' || k == 'd' || k == RIGHT) {
      _hero.launchMove(new PVector(1, 0));
    }
      
  }
}
