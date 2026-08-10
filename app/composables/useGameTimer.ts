import { useTimestamp } from '@vueuse/core'

/**
 * Puzzle stopwatch based on VueUse timestamps.
 * Starts on first interaction; stops when the puzzle ends.
 */
export function useGameTimer() {
  const startedAt = ref<number | null>(null)
  const endedAt = ref<number | null>(null)
  const timestamp = useTimestamp({
    interval: 250,
    controls: true,
  })

  timestamp.pause()

  const hasStarted = computed(() => startedAt.value !== null)
  const isRunning = computed(() => hasStarted.value && endedAt.value === null)

  const elapsedMs = computed(() => {
    if (startedAt.value === null) {
      return 0
    }

    const end = endedAt.value ?? timestamp.timestamp.value
    return Math.max(0, end - startedAt.value)
  })

  function start() {
    if (startedAt.value !== null) {
      return
    }

    startedAt.value = Date.now()
    timestamp.resume()
  }

  function stop() {
    if (startedAt.value === null || endedAt.value !== null) {
      return
    }

    endedAt.value = Date.now()
    timestamp.pause()
  }

  onScopeDispose(() => {
    timestamp.pause()
  })

  return {
    start,
    stop,
    elapsedMs,
    hasStarted,
    isRunning,
  }
}
