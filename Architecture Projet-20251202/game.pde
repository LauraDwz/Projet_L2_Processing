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
  int _frameCount;
  
  boolean _superMode = false;
  
  boolean pinkOut = false;
  boolean pinkMove = false;
  boolean blueOut = false;
  boolean blueMove = false;
  boolean redOut = false;
  boolean redMove = false;
  boolean orangeOut = false;
  boolean orangeMove = false;
      
  Game() {
    _board = new Board(BOARD_WIDTH, BOARD_HEIGHT, CELL_SIZE);
    _hero = new Hero(HERO_X, HERO_Y, CELL_SIZE*0.8);
    _levelName = "Level 1";
    _score = 0;
    _nbLife = 2;
    _frameCount = 0;
    _count = 0;
    _pinkGhost = new Ghost(10, 10, CELL_SIZE*0.8, SPRITE_PINK_X);
    _blueGhost = new Ghost(12, 10, CELL_SIZE*0.8, SPRITE_BLUE_X);
    _redGhost = new Ghost(9, 10, CELL_SIZE*0.8, SPRITE_RED_X);
    _orangeGhost = new Ghost(13, 10, CELL_SIZE*0.8, SPRITE_ORANGE_X);
  }
  
  
  void respawn () {
    _hero.respawn();
    _pinkGhost.respawn();
    _redGhost.respawn();
    _blueGhost.respawn();
    _orangeGhost.respawn();
    
    _frameCount = 0;
    _count = 0;
    
    pinkOut = false;
    pinkMove = false;
    blueOut = false;
    blueMove = false;
    redOut = false;
    redMove = false;
    orangeOut = false;
    orangeMove = false;
    
    //remet tout le monde à leur position etc
  }
  void update() {   
    if (_frameCount >= 1) {
      _frameCount ++;
      if (_frameCount %10 == 0) _count ++;
    }
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
      PVector heroCell = _hero.currentCell();
      if (_board.isDot(heroCell)) {
        _board.takeDot(heroCell);
        _score += SCORE_DOT;
        if (_score >= 10000 && _score <10000 + SCORE_DOT) _nbLife ++; 
      } else if (_board.isSuperDot(heroCell)) {
        _board.takeDot(heroCell);
        _score += SCORE_SUPER_DOT;
        if (_score >= 10000 && _score <10000 + SCORE_SUPER_DOT) _nbLife ++; 
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
    //Gestion des fantomes - lancement et update du fantome rose
    if (_count >= 10 && ! pinkOut) {
      _pinkGhost.moveSlowly();
      if (_pinkGhost._cellX == 11) {
        _pinkGhost.launchMove(new PVector(0, -1));
        if (_pinkGhost._cellY < 10) {
          pinkOut = true;
        }
      } else {
        _pinkGhost.launchMove(new PVector(1, 0));
      }
    } else if (pinkOut) {      
      _pinkGhost.moveSlowly();  
      if (_pinkGhost.isOnCell()) {
        PVector nextCell = _pinkGhost.nextCell();
        if (!movePossible(nextCell)) {
          _pinkGhost.chooseDirection(_board);
        }
      }
   }
   //Gestion des fantomes - lancement et update du fantome bleu
   
   if (_count >= 20 && ! blueOut) {
      _blueGhost.moveSlowly();
      if (_blueGhost._cellX == 11) {
        _blueGhost.launchMove(new PVector(0, -1));
        if (_blueGhost._cellY < 10) {
          blueOut = true;
        }
      } else {
        _blueGhost.launchMove(new PVector(-1, 0));
      }
    } else if (blueOut) {      
      _blueGhost.moveSlowly();  
      if (_blueGhost.isOnCell()) {
        PVector nextCell = _blueGhost.nextCell();
        if (!movePossible(nextCell)) {
          _blueGhost.chooseDirection(_board);
        }
      }
   }
   
   //Gestion des fantomes - lancement et update du fantome rouge
   if (_count >= 30 && ! redOut) {
      _redGhost.moveSlowly();
      if (_redGhost._cellX == 11) {
        _redGhost.launchMove(new PVector(0, -1));
        if (_redGhost._cellY < 10) {
          redOut = true;
        }
      } else {
        _redGhost.launchMove(new PVector(1, 0));
      }
    } else if (redOut) {      
      _redGhost.moveSlowly();  
      if (_redGhost.isOnCell()) {
        PVector nextCell = _redGhost.nextCell();
        if (!movePossible(nextCell)) {
          _redGhost.chooseDirection(_board);
        }
      }
   }
   //Gestion des fantomes - lancement et update du fantome orange
   if (_count >= 40 && ! orangeOut) {
      _orangeGhost.moveSlowly();
      if (_orangeGhost._cellX == 11) {
        _orangeGhost.launchMove(new PVector(0, -1));
        if (_orangeGhost._cellY < 10) {
          orangeOut = true;
        }
      } else {
        _orangeGhost.launchMove(new PVector(-1, 0));
      }
    } else if (blueOut) {      
      _orangeGhost.moveSlowly();  
      if (_orangeGhost.isOnCell()) {
        PVector nextCell = _orangeGhost.nextCell();
        if (!movePossible(nextCell)) {
          _orangeGhost.chooseDirection(_board);
        }
      }
   }
   //Gestion des vies
   if (! _superMode) {
     if (_hero._cellX == _redGhost._cellX && _hero._cellY == _redGhost._cellY) {
       _nbLife -=1;
       respawn();
     } else if (_hero._cellX == _pinkGhost._cellX && _hero._cellY == _pinkGhost._cellY) {
       _nbLife -=1;
       respawn();
     } else if (_hero._cellX == _orangeGhost._cellX && _hero._cellY == _orangeGhost._cellY) {
       _nbLife -=1 ;
       respawn();
     } else if (_hero._cellX == _blueGhost._cellX && _hero._cellY == _blueGhost._cellY) {
       _nbLife -= 1;
       respawn();
     }
   }
   println(_nbLife);
   
   // Gestion de fin de partie
   if (_board._nbDot == 0 && _board._nbSuperDot == 0){
     print("Gagné");
     //LANCER LE PROCHAIN LEVEL ETC
     exit();
   } else if (_nbLife <= 0) {
     print("Perdu"); 
     //Faire la sortie
     exit();
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
    if (_frameCount == 0) _frameCount = 1;
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
