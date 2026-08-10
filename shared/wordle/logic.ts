import type { LetterResult, LetterStatus } from './types'

/**
 * Evaluate a guess against the solution, handling duplicate letters correctly.
 */
export function evaluateGuess(guess: string, solution: string): LetterResult[] {
  const normalizedGuess = guess.toLowerCase()
  const normalizedSolution = solution.toLowerCase()
  const length = normalizedSolution.length
  const result: LetterResult[] = Array.from({
    length,
  }, (_, index) => ({
    letter: normalizedGuess[index] ?? '',
    status: 'absent' as LetterStatus,
  }))

  const remaining: Record<string, number> = {}

  for (let i = 0; i < length; i++) {
    const solutionLetter = normalizedSolution[i]
    const guessLetter = normalizedGuess[i]

    if (guessLetter === solutionLetter) {
      result[i].status = 'correct'
    }
    else {
      remaining[solutionLetter] = (remaining[solutionLetter] ?? 0) + 1
    }
  }

  for (let i = 0; i < length; i++) {
    if (result[i].status === 'correct') {
      continue
    }

    const guessLetter = normalizedGuess[i]
    if ((remaining[guessLetter] ?? 0) > 0) {
      result[i].status = 'present'
      remaining[guessLetter] -= 1
    }
  }

  return result
}

export function isValidGuess(
  guess: string,
  wordLength: number,
  allowedWords: string[],
): boolean {
  if (guess.length !== wordLength) {
    return false
  }

  const normalized = guess.toLowerCase()
  return allowedWords.includes(normalized)
}

/** Commit an unknown word as a red row (consumes an attempt). */
export function createInvalidGuessRow(guess: string): LetterResult[] {
  return guess.toLowerCase().split('').map(letter => ({
    letter,
    status: 'invalid' as const,
  }))
}

export function getBestKeyStatuses(
  evaluations: LetterResult[][],
): Record<string, LetterStatus> {
  const rank: Record<LetterStatus, number> = {
    correct: 3,
    present: 2,
    absent: 1,
    invalid: 0,
  }

  const best: Record<string, LetterStatus> = {}

  for (const row of evaluations) {
    for (const {
      letter,
      status,
    } of row) {
      if (status === 'invalid') {
        continue
      }

      const current = best[letter]
      if (!current || rank[status] > rank[current]) {
        best[letter] = status
      }
    }
  }

  return best
}
