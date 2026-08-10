<script setup lang="ts">
import type { GameResult } from '~~/shared/game/types'
import { formatDuration } from '~~/shared/game/date'

defineProps<{
  result: GameResult
}>()
</script>

<template>
  <section
    class="daily-done"
    aria-live="polite"
  >
    <h2 class="daily-done__title">
      {{ result.status === 'won' ? 'Je bent klaar voor vandaag' : 'Morgen weer een kans' }}
    </h2>
    <p class="daily-done__lead">
      {{ result.status === 'won' ? 'Goed gedaan — kom morgen terug voor een nieuwe ronde.' : 'De streak is gereset. Morgen kun je opnieuw beginnen.' }}
    </p>

    <dl class="daily-done__stats">
      <div class="daily-done__stat">
        <dt>Tijd</dt>
        <dd>{{ formatDuration(result.durationMs) }}</dd>
      </div>
      <div class="daily-done__stat">
        <dt>Punten</dt>
        <dd>{{ result.score }}</dd>
      </div>
      <div class="daily-done__stat">
        <dt>Streak</dt>
        <dd>{{ result.streak }}</dd>
      </div>
      <div class="daily-done__stat">
        <dt>Pogingen</dt>
        <dd>{{ result.attemptsUsed }}</dd>
      </div>
    </dl>
  </section>
</template>

<style scoped lang="scss">
.daily-done {
  max-width: 40rem;
  margin: 0 auto;
  padding: 2.4rem 1.6rem;
  text-align: center;

  &__title {
    margin: 0 0 0.8rem;
    font-size: 2.2rem;
    font-weight: 700;
  }

  &__lead {
    margin: 0 0 2.4rem;
    color: #444;
    font-size: 1.5rem;
  }

  &__stats {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 1.2rem;
    margin: 0;
  }

  &__stat {
    padding: 1.2rem;
    border: 1px solid var(--color-border);
    background: #fff;

    dt {
      margin: 0 0 0.4rem;
      font-size: 1.2rem;
      color: #666;
    }

    dd {
      margin: 0;
      font-size: 2rem;
      font-weight: 700;
    }
  }
}
</style>
