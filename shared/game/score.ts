export interface ScoreInput {
  won: boolean
  durationMs: number
  attemptsUsed: number
}

/**
 * Simple v1 scoring — keep tunable later.
 * Win: start at 1000, lose points for time and extra attempts.
 * Lose: 0 points.
 */
export function calculateScore(input: ScoreInput): number {
  if (!input.won) {
    return 0
  }

  const seconds = Math.floor(input.durationMs / 1000)
  const attemptPenalty = Math.max(0, input.attemptsUsed - 1) * 75
  const timePenalty = seconds * 2

  return Math.max(50, 1000 - attemptPenalty - timePenalty)
}
