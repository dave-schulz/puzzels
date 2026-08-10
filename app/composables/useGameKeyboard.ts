import { isLatinLetterKey } from '~~/shared/game/keyboard'

interface UseGameKeyboardOptions {
  /** When false, physical keyboard input is ignored. */
  enabled?: MaybeRefOrGetter<boolean>
  onLetter: (letter: string) => void
  onBackspace: () => void
}

/**
 * Physical keyboard binding for letter puzzles.
 * On-screen keyboards stay in the puzzle component; they call the same handlers.
 */
export function useGameKeyboard(options: UseGameKeyboardOptions) {
  function onKeydown(event: KeyboardEvent) {
    if (!toValue(options.enabled ?? true)) {
      return
    }

    if (event.key === 'Backspace') {
      event.preventDefault()
      options.onBackspace()
      return
    }

    if (isLatinLetterKey(event.key)) {
      event.preventDefault()
      options.onLetter(event.key.toLowerCase())
    }
  }

  onMounted(() => {
    window.addEventListener('keydown', onKeydown)
  })

  onBeforeUnmount(() => {
    window.removeEventListener('keydown', onKeydown)
  })
}
