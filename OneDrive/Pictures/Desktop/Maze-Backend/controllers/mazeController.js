const { generateKruskalMaze, generatePrimMaze } = require('../maze/mazeGenerator');
const { solveMazeDFS } = require('../maze/mazeSolver');

exports.generateMaze = (req, res) => {
  const { algorithm, rows, cols } = req.body;
  let maze;

  if (algorithm === 'kruskal') {
    maze = generateKruskalMaze(rows, cols);
  } else if (algorithm === 'prim') {
    maze = generatePrimMaze(rows, cols);
  } else {
    return res.status(400).json({ error: 'Invalid algorithm' });
  }

  res.json(maze);
};

exports.solveMaze = (req, res) => {
  const { maze, start, end } = req.body;
  const solution = solveMazeDFS(maze, start, end);
  res.json(solution);
};
