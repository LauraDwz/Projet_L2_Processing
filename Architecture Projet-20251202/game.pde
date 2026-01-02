class Game 
{
  Board _board;
  Hero _hero;
  
  String _levelName;
  
  int _score;
  int _nbLife;
  
  Game() {
    _board = new Board(BOARD_WIDTH, BOARD_HEIGHT, CELL_SIZE);
    _hero = new Hero(11, 16, CELL_SIZE*0.8);
    _levelName = "Level 1";
    _score = 0;
    _nbLife = 3;
  }
  
  void update() {    
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
    else { //Il est arrivé à sa case
      PVector heroCell = _hero.currentCell();
      if (_board.isDot(heroCell)) {
        _board.takeDot(heroCell);
        _score += SCORE_DOT;
      } else if (_board.isSuperDot(heroCell)) {
        _board.takeDot(heroCell);
        _score += SCORE_SUPER_DOT;
      }
      
      PVector nextCell = _hero.nextCell();
      if (movePossible(nextCell)) {
        _hero.move();
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
  }
  
  void handleKey(int k) { // VERIFIER ICI SI LE DEPLACEMENT EST POSSIBLE
    if (k=='Z' || k=='z') {
      _hero.launchMove(new PVector(0, -1));
    } else if (k=='Q' || k=='q') {
      _hero.launchMove(new PVector(-1, 0));
    } else if (k=='S' || k=='s') {
      _hero.launchMove(new PVector(0, 1));
    } else if (k=='D' || k == 'd') {
      _hero.launchMove(new PVector(1, 0));
    }
      
  }
}
