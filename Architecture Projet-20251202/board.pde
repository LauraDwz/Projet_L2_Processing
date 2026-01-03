enum TypeCell 
{
  EMPTY, WALL, DOT, SUPER_DOT
}

class Board 
{
  TypeCell _cells[][];
  PVector _position;
  int _nbCellsX;
  int _nbCellsY;
  int _cellSize; // cells should be square
  int _nbDot;
  int _nbSuperDot;
  
  Board(int nbCellsX, int nbCellsY, int cellSize, String levelFile) {
    _nbCellsX = nbCellsX;
    _nbCellsY = nbCellsY;
    _cellSize = cellSize;   
    _cells = new TypeCell[_nbCellsY][_nbCellsX];// array of cells
    _position = POSITION_BOARD;
    _nbDot = 0;
    _nbSuperDot = 0;
    String[] lines = loadStrings(levelFile);
    for (int j = 1; j<lines.length; j++) { //Je ne prends pas la première ligne qui correspond au titre du niveau
      for (int i = 0; i<lines[j].length(); i++) {
        char CellType = lines[j].charAt(i);
        switch (CellType) {
          case 'x': 
            _cells[j-1][i] = TypeCell.WALL;
            break;
          case 'o': 
            _cells[j-1][i] = TypeCell.DOT;
            _nbDot ++;
            break;
          case 'O':
            _cells[j-1][i] = TypeCell.SUPER_DOT;
            _nbSuperDot ++;
            break;
          default:
            _cells[j-1][i] = TypeCell.EMPTY;
            break;
        }
      }
    }
  }
  
  PVector getCellCenter(int i, int j) {
    return new PVector((i+0.5)*_cellSize + _position.x, (j+0.5)*_cellSize + _position.y);
  }
  
  
  boolean isWall(PVector cell) {
    return (_cells[int(cell.y)][int(cell.x)] == TypeCell.WALL);
  }
  
  boolean isDot(PVector cell) {
    return (_cells[int(cell.y)][int(cell.x)] == TypeCell.DOT);
  }
  
  boolean isSuperDot(PVector cell) {
    return (_cells[int(cell.y)][int(cell.x)] == TypeCell.SUPER_DOT);
  }
  
  void takeDot(PVector cell) {
    if (_cells[int(cell.y)][int(cell.x)] == TypeCell.DOT) _nbDot --;
    else _nbSuperDot--;
    _cells[int(cell.y)][int(cell.x)] = TypeCell.EMPTY;
  }
  
  void drawIt() {
    background(0);
    for (int y = 0; y<_cells.length; y++) {
      for (int x = 0; x < _cells[y].length; x++ ) {
        TypeCell cell=_cells[y][x];
        rectMode(CENTER);
        fill(255);
        PVector cellCenter = getCellCenter(x, y);   
        if (cell == TypeCell.WALL){
          noStroke();
          stroke(color(0, 0, 255));
          strokeWeight(4);
          //On examine la cellule juste à gauche
          if (x == 0) {
             line(cellCenter.x - HALF_CELL, cellCenter.y - HALF_CELL, cellCenter.x - HALF_CELL, cellCenter.y + HALF_CELL);
          } else if (!(_cells[y][x-1] == TypeCell.WALL)) {
             line(cellCenter.x - HALF_CELL, cellCenter.y - HALF_CELL, cellCenter.x - HALF_CELL, cellCenter.y + HALF_CELL);
          } 
          
          //On examine la cellule juste à droite
          if (x == _cells[y].length - 1 ) {
             line(cellCenter.x + HALF_CELL, cellCenter.y - HALF_CELL, cellCenter.x + HALF_CELL, cellCenter.y + HALF_CELL);            
          } else if (!(_cells[y][x+1] == TypeCell.WALL)) {
             line(cellCenter.x + HALF_CELL, cellCenter.y - HALF_CELL, cellCenter.x + HALF_CELL, cellCenter.y + HALF_CELL);
          }
          
          //On examine la cellule juste au dessus
          if (y == 0) {
             line(cellCenter.x - HALF_CELL, cellCenter.y - HALF_CELL, cellCenter.x + HALF_CELL, cellCenter.y - HALF_CELL);
          } else if (!(_cells[y-1][x] == TypeCell.WALL)) {
             line(cellCenter.x - HALF_CELL, cellCenter.y - HALF_CELL, cellCenter.x + HALF_CELL, cellCenter.y - HALF_CELL);
          }
          
          
          //On examine la cellule juste en dessous
          if (y == _cells.length - 1 ) {
             line(cellCenter.x - HALF_CELL, cellCenter.y + HALF_CELL, cellCenter.x + HALF_CELL, cellCenter.y + HALF_CELL);            
          } else if (!(_cells[y+1][x] == TypeCell.WALL)) {
             line(cellCenter.x - HALF_CELL, cellCenter.y + HALF_CELL, cellCenter.x + HALF_CELL, cellCenter.y + HALF_CELL);
          }
        }
        else if (cell == TypeCell.EMPTY){
          noStroke();
          fill(color(0, 0, 0));
          rect(cellCenter.x, cellCenter.y, _cellSize, _cellSize);
        }
        else if (cell == TypeCell.DOT){
          noStroke();
          fill(color(255, 255, 0));
          circle(cellCenter.x, cellCenter.y, _cellSize/5);
        }
        else if (cell == TypeCell.SUPER_DOT){
          noStroke();
          fill(color(255, 255, 0));
          circle(cellCenter.x, cellCenter.y, _cellSize/2);
        }       
      }
    }
  }
}
