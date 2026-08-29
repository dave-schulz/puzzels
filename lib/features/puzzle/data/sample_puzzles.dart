import '../models/puzzle.dart';
import '../models/puzzle_type.dart';

const samplePuzzles = <Puzzle>[
  Puzzle(
    id: 'sequence-1',
    type: PuzzleType.sequence,
    prompt: 'What comes next?',
    sequence: ['2', '4', '6', '?'],
    options: ['8', '10', '12', '14'],
    correctIndex: 0,
  ),
  Puzzle(
    id: 'sequence-2',
    type: PuzzleType.sequence,
    prompt: 'What comes next?',
    sequence: ['3', '6', '12', '?'],
    options: ['18', '24', '15', '20'],
    correctIndex: 1,
  ),
  Puzzle(
    id: 'logic-1',
    type: PuzzleType.multipleChoice,
    prompt: 'Who is shortest?',
    statements: [
      'Tom is taller than Lisa.',
      'Lisa is taller than Mark.',
    ],
    options: ['Tom', 'Lisa', 'Mark'],
    correctIndex: 2,
  ),
];
