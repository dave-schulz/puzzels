import type { GameResult, PuzzleType } from '~~/shared/game/types'
import { useLocalStorage } from '@vueuse/core'
import { getAmsterdamDate } from '~~/shared/game/date'
import { nextStreak } from '~~/shared/game/streak'

interface LocalProgressState {
  streak: number
  lastCompletedDate: string | null
  /** Result for the Amsterdam calendar day currently stored, if any. */
  todayResult: GameResult | null
}

const STORAGE_KEY = 'puzzels:progress:v1'

/**
 * Local-only progress (streak + today's result). Later replace with API/user accounts.
 */
export function useLocalProgress() {
  const progress = useLocalStorage<LocalProgressState>(STORAGE_KEY, {
    streak: 0,
    lastCompletedDate: null,
    todayResult: null,
  })

  const today = computed(() => getAmsterdamDate())

  const todaysResult = computed(() => {
    if (progress.value.todayResult?.date === today.value) {
      return progress.value.todayResult
    }

    return null
  })

  function recordResult(input: {
    status: GameResult['status']
    puzzleType: PuzzleType
    attemptsUsed: number
    durationMs: number
    score: number
  }): GameResult {
    const date = today.value
    const streakState = nextStreak({
      current: progress.value.streak,
      lastCompletedDate: progress.value.lastCompletedDate,
    }, date, input.status === 'won')

    const result: GameResult = {
      status: input.status,
      puzzleType: input.puzzleType,
      attemptsUsed: input.attemptsUsed,
      durationMs: input.durationMs,
      score: input.score,
      streak: streakState.current,
      date,
      completedAt: new Date().toISOString(),
    }

    progress.value = {
      streak: streakState.current,
      lastCompletedDate: streakState.lastCompletedDate,
      todayResult: result,
    }

    return result
  }

  return {
    progress,
    today,
    todaysResult,
    recordResult,
  }
}
