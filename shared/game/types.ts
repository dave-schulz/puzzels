export type GameStatus = 'playing' | 'won' | 'lost'

/** Puzzle kinds we plan to support; expand as types are added. */
export type PuzzleType = 'wordle' | 'connections'

export interface DailyPuzzleBase {
  id: string
  type: PuzzleType
  /** Calendar date in Europe/Amsterdam, YYYY-MM-DD */
  date: string
  title: string
}

export interface GameResult {
  status: Exclude<GameStatus, 'playing'>
  puzzleType: PuzzleType
  attemptsUsed: number
  durationMs: number
  score: number
  streak: number
  date: string
  completedAt: string
}
