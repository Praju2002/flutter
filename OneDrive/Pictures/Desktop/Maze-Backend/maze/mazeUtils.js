class Cell {
    constructor(row, col) {
      this.row = row;
      this.col = col;
      this.visited = false;
      this.walls = { top: true, right: true, bottom: true, left: true };
    }
  }
  
  class Maze {
    constructor(rows, cols) {
      this.rows = rows;
      this.cols = cols;
      this.grid = this.createGrid();
    }
  
    createGrid() {
      const grid = [];
      for (let row = 0; row < this.rows; row++) {
        const rowCells = [];
        for (let col = 0; col < this.cols; col++) {
          rowCells.push(new Cell(row, col));
        }
        grid.push(rowCells);
      }
      return grid;
    }
  
    getNeighbors(cell) {
      const { row, col } = cell;
      const neighbors = [];
      if (row > 0) neighbors.push(this.grid[row - 1][col]);
      if (row < this.rows - 1) neighbors.push(this.grid[row + 1][col]);
      if (col > 0) neighbors.push(this.grid[row][col - 1]);
      if (col < this.cols - 1) neighbors.push(this.grid[row][col + 1]);
      return neighbors;
    }
  
    removeWalls(current, next) {
      const x = current.col - next.col;
      const y = current.row - next.row;
      if (x === 1) {
        current.walls.left = false;
        next.walls.right = false;
      } else if (x === -1) {
        current.walls.right = false;
        next.walls.left = false;
      }
      if (y === 1) {
        current.walls.top = false;
        next.walls.bottom = false;
      } else if (y === -1) {
        current.walls.bottom = false;
        next.walls.top = false;
      }
    }
  }
  
  module.exports = { Cell, Maze };
  