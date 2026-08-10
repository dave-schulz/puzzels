import type { LetterResult, WordlePuzzle } from '~~/shared/wordle/types'
import { normalizeLetterKey } from '~~/shared/game/keyboard'
import { calculateScore } from '~~/shared/game/score'
import { createInvalidGuessRow, evaluateGuess, getBestKeyStatuses, isValidGuess } from '~~/shared/wordle/logic'

export function useWordleGame(puzzleSource: MaybeRefOrGetter<WordlePuzzle>) {
  const puzzle = computed(() => toValue(puzzleSource))
  const guesses = ref<LetterResult[][]>([])
  const currentGuess = ref('')

  const {
    todaysResult,
    recordResult,
  } = useLocalProgress()

  const {
    status,
    message,
    isPlaying,
    clearMessage,
    setMessage,
    setStatus,
  } = useGameFeedback(todaysResult.value?.status ?? 'playing')

  const {
    start: startTimer,
    stop: stopTimer,
    elapsedMs,
  } = useGameTimer()

  const result = ref(todaysResult.value)
  const keyStatuses = computed(() => getBestKeyStatuses(guesses.value))

  if (todaysResult.value) {
    setMessage(todaysResult.value.status === 'won' ? 'Gewonnen!' : 'Helaas')
  }

  function finish(nextStatus: 'won' | 'lost') {
    stopTimer()
    setStatus(nextStatus)

    const score = calculateScore({
      won: nextStatus === 'won',
      durationMs: elapsedMs.value,
      attemptsUsed: guesses.value.length,
    })

    result.value = recordResult({
      status: nextStatus,
      puzzleType: 'wordle',
      attemptsUsed: guesses.value.length,
      durationMs: elapsedMs.value,
      score,
    })

    setMessage(
      nextStatus === 'won'
        ? 'Gewonnen!'
        : `Het woord was ${puzzle.value.word.toUpperCase()}`,
    )
  }

  function commitRow(row: LetterResult[]) {
    guesses.value.push(row)
    currentGuess.value = ''
    clearMessage()

    if (row.every(item => item.status === 'correct')) {
      finish('won')
      return
    }

    if (guesses.value.length >= puzzle.value.maxAttempts) {
      finish('lost')
    }
  }

  function addLetter(letter: string) {
    if (!isPlaying.value) {
      return
    }

    const normalized = normalizeLetterKey(letter)
    if (!normalized) {
      return
    }

    if (currentGuess.value.length >= puzzle.value.wordLength) {
      return
    }

    startTimer()
    clearMessage()
    currentGuess.value += normalized

    if (currentGuess.value.length === puzzle.value.wordLength) {
      submitGuess()
    }
  }

  function removeLetter() {
    if (!isPlaying.value) {
      return
    }

    currentGuess.value = currentGuess.value.slice(0, -1)
    clearMessage()
  }

  function submitGuess() {
    if (!isPlaying.value) {
      return
    }

    if (currentGuess.value.length !== puzzle.value.wordLength) {
      setMessage(`Voer ${puzzle.value.wordLength} letters in`)
      return
    }

    if (!isValidGuess(currentGuess.value, puzzle.value.wordLength, puzzle.value.allowedWords)) {
      setMessage('Onbekend woord')
      commitRow(createInvalidGuessRow(currentGuess.value))
      return
    }

    commitRow(evaluateGuess(currentGuess.value, puzzle.value.word))
  }

  function getTileLetter(rowIndex: number, colIndex: number): string {
    if (rowIndex < guesses.value.length) {
      return guesses.value[rowIndex]?.[colIndex]?.letter ?? ''
    }

    if (rowIndex === guesses.value.length) {
      return currentGuess.value[colIndex] ?? ''
    }

    return ''
  }

  function getTileStatus(rowIndex: number, colIndex: number) {
    if (rowIndex < guesses.value.length) {
      return guesses.value[rowIndex]?.[colIndex]?.status ?? 'empty'
    }

    if (rowIndex === guesses.value.length && currentGuess.value[colIndex]) {
      return 'filled'
    }

    return 'empty'
  }

  return {
    puzzle,
    guesses,
    currentGuess,
    status,
    message,
    keyStatuses,
    elapsedMs,
    result,
    addLetter,
    removeLetter,
    submitGuess,
    getTileLetter,
    getTileStatus,
  }
}
