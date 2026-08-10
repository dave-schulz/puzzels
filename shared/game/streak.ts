import { getPreviousAmsterdamDate } from './date'

export interface StreakState {
  current: number
  lastCompletedDate: string | null
}

export function nextStreak(
  state: StreakState,
  today: string,
  won: boolean,
): StreakState {
  if (!won) {
    return {
      current: 0,
      lastCompletedDate: today,
    }
  }

  if (state.lastCompletedDate === today) {
    return state
  }

  const continued = state.lastCompletedDate === getPreviousAmsterdamDate(today)

  return {
    current: continued ? state.current + 1 : 1,
    lastCompletedDate: today,
  }
}
