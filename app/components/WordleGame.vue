<script setup lang="ts">
import type { LetterStatus, WordlePuzzle } from '~~/shared/wordle/types'
import { formatDuration } from '~~/shared/game/date'
import { QWERTY_ROWS } from '~~/shared/game/keyboard'

const props = defineProps<{
  puzzle: WordlePuzzle
  title?: string
}>()

const {
  puzzle,
  status,
  message,
  keyStatuses,
  elapsedMs,
  result,
  addLetter,
  removeLetter,
  getTileLetter,
  getTileStatus,
} = useWordleGame(() => props.puzzle)

const rows = computed(() => Array.from({
  length: puzzle.value.maxAttempts,
}, (_, index) => index))
const cols = computed(() => Array.from({
  length: puzzle.value.wordLength,
}, (_, index) => index))

const keyboardRows = [
  ...QWERTY_ROWS.slice(0, 2),
  [
    ...QWERTY_ROWS[2],
    'backspace',
  ],
]

const showDone = computed(() => status.value !== 'playing' && result.value !== null)

useGameKeyboard({
  enabled: () => status.value === 'playing',
  onLetter: addLetter,
  onBackspace: removeLetter,
})

function onKeyClick(key: string) {
  if (key === 'backspace') {
    removeLetter()
    return
  }

  addLetter(key)
}

function keyStatusClass(key: string): LetterStatus | undefined {
  if (key === 'backspace') {
    return undefined
  }

  return keyStatuses.value[key]
}
</script>

<template>
  <div class="wordle-flow">
    <Transition
      name="wordle-slide"
      mode="out-in"
    >
      <DailyDone
        v-if="showDone && result"
        key="done"
        :result="result"
      />

      <section
        v-else
        key="play"
        class="wordle"
      >
        <div class="wordle__top">
          <h1 class="wordle__title">
            {{ title || 'Woord van vandaag' }}
          </h1>
          <p
            class="wordle__timer"
            aria-live="off"
          >
            {{ formatDuration(elapsedMs) }}
          </p>
        </div>

        <p
          class="wordle__message"
          aria-live="polite"
        >
          {{ message || '\u00A0' }}
        </p>

        <div
          class="wordle__board"
          role="grid"
          :aria-label="`Wordle bord, ${puzzle.maxAttempts} rijen van ${puzzle.wordLength} letters`"
        >
          <div
            v-for="row in rows"
            :key="row"
            class="wordle__row"
            role="row"
          >
            <div
              v-for="col in cols"
              :key="`${row}-${col}`"
              class="wordle__tile"
              :class="`wordle__tile--${getTileStatus(row, col)}`"
              role="gridcell"
            >
              {{ getTileLetter(row, col) }}
            </div>
          </div>
        </div>

        <div
          class="wordle__keyboard"
          role="group"
          aria-label="Toetsenbord"
        >
          <div
            v-for="(keyboardRow, rowIndex) in keyboardRows"
            :key="rowIndex"
            class="wordle__keyboard-row"
          >
            <button
              v-for="key in keyboardRow"
              :key="key"
              type="button"
              class="wordle__key"
              :class="[
                key === 'backspace' ? 'wordle__key--wide' : '',
                keyStatusClass(key) ? `wordle__key--${keyStatusClass(key)}` : '',
              ]"
              :disabled="status !== 'playing'"
              :aria-label="key === 'backspace' ? 'Verwijderen' : key"
              @click="onKeyClick(key)"
            >
              <template v-if="key === 'backspace'">
                ⌫
              </template>
              <template v-else>
                {{ key }}
              </template>
            </button>
          </div>
        </div>
      </section>
    </Transition>
  </div>
</template>

<style scoped lang="scss">
.wordle-flow {
  min-height: 70vh;
}

.wordle-slide-enter-active,
.wordle-slide-leave-active {
  transition:
    opacity 0.25s ease,
    transform 0.25s ease;
}

.wordle-slide-enter-from {
  opacity: 0;
  transform: translateX(2rem);
}

.wordle-slide-leave-to {
  opacity: 0;
  transform: translateX(-2rem);
}

.wordle {
  max-width: 50rem;
  margin: 0 auto;
  padding: 1.6rem;
  text-align: center;

  &__top {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    gap: 1.2rem;
    margin-bottom: 0.8rem;
  }

  &__title {
    margin: 0;
    font-size: 1.8rem;
    font-weight: 600;
    text-align: left;
  }

  &__timer {
    margin: 0;
    font-variant-numeric: tabular-nums;
    font-size: 1.6rem;
    font-weight: 600;
  }

  &__message {
    min-height: 2.4rem;
    margin: 0 0 1.6rem;
    font-size: 1.4rem;
  }

  &__board {
    display: grid;
    gap: 0.6rem;
    justify-content: center;
    margin-bottom: 2.4rem;
  }

  &__row {
    display: grid;
    grid-template-columns: repeat(5, 5.2rem);
    gap: 0.6rem;
  }

  &__tile {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 5.2rem;
    height: 5.2rem;
    border: 2px solid var(--color-border);
    font-size: 2rem;
    font-weight: 700;
    text-transform: uppercase;

    &--filled {
      border-color: var(--color-text);
      background: var(--color-filled);
    }

    &--invalid {
      border-color: var(--color-invalid);
      background: var(--color-invalid);
      color: var(--color-on-dark);
    }

    &--correct {
      border-color: var(--color-correct);
      background: var(--color-correct);
      color: var(--color-on-dark);
    }

    &--present {
      border-color: var(--color-present);
      background: var(--color-present);
      color: var(--color-on-dark);
    }

    &--absent {
      border-color: var(--color-absent);
      background: var(--color-absent);
      color: var(--color-on-dark);
    }
  }

  &__keyboard {
    display: grid;
    gap: 0.6rem;
  }

  &__keyboard-row {
    display: flex;
    justify-content: center;
    gap: 0.4rem;
  }

  &__key {
    min-width: 2.8rem;
    min-height: 4.8rem;
    padding: 0 0.6rem;
    border: 0;
    border-radius: 0.4rem;
    background: var(--color-key);
    font: inherit;
    font-size: 1.2rem;
    font-weight: 600;
    text-transform: uppercase;
    cursor: pointer;

    &:disabled {
      cursor: default;
      opacity: 0.7;
    }

    &--wide {
      min-width: 5.2rem;
      font-size: 1.1rem;
      text-transform: none;
    }

    &--correct {
      background: var(--color-correct);
      color: var(--color-on-dark);
    }

    &--present {
      background: var(--color-present);
      color: var(--color-on-dark);
    }

    &--absent {
      background: var(--color-absent);
      color: var(--color-on-dark);
    }
  }
}
</style>
