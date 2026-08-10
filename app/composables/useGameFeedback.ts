import type { GameStatus } from '~~/shared/game/types'

/**
 * Lightweight feedback state shared by puzzle UIs (status line + win/lose).
 */
export function useGameFeedback(initialStatus: GameStatus = 'playing') {
  const status = ref<GameStatus>(initialStatus)
  const message = ref('')

  const isPlaying = computed(() => status.value === 'playing')

  function clearMessage() {
    message.value = ''
  }

  function setMessage(text: string) {
    message.value = text
  }

  function setStatus(next: GameStatus) {
    status.value = next
  }

  return {
    status,
    message,
    isPlaying,
    clearMessage,
    setMessage,
    setStatus,
  }
}
