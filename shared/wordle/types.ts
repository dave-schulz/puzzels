import type { GameStatus } from '../game/types'

export type LetterStatus = 'correct' | 'present' | 'absent' | 'invalid'

export type { GameStatus }

export interface LetterResult {
  letter: string
  status: LetterStatus
}

export interface WordlePuzzle {
  word: string
  allowedWords: string[]
  maxAttempts: number
  wordLength: number
}
