<script setup lang="ts">
const {
  data,
  error,
  pending,
} = await useFetch('/api/puzzles/today')
</script>

<template>
  <div class="page">
    <p
      v-if="pending"
      class="page__status"
    >
      Puzzel laden…
    </p>

    <p
      v-else-if="error"
      class="page__status page__status--error"
    >
      {{ error.statusMessage || 'Kon de puzzel van vandaag niet laden.' }}
    </p>

    <WordleGame
      v-else-if="data"
      :puzzle="data.puzzle"
      :title="data.title"
    />
  </div>
</template>

<style scoped lang="scss">
.page {
  &__status {
    margin: 4rem auto;
    max-width: 40rem;
    padding: 0 1.6rem;
    text-align: center;
    font-size: 1.6rem;

    &--error {
      color: var(--color-invalid);
    }
  }
}
</style>
