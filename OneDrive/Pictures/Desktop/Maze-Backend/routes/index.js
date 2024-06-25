const express = require('express');
const { generateMaze, solveMaze } = require('../controllers/mazeController');

const router = express.Router();

router.post('/generate', generateMaze);
router.post('/solve', solveMaze);

module.exports = router;
