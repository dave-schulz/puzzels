<template>
  <div>
    <header class="site-header">
      <p class="site-header__brand">
        Puzzels
      </p>
    </header>
    <main>
      <NuxtPage />
    </main>
  </div>
</template>

<style lang="scss">
@use '~/assets/scss/main';

.site-header {
  padding: 1.2rem 1.6rem;
  border-bottom: 1px solid var(--color-border);
  text-align: center;

  &__brand {
    margin: 0;
    font-size: 2rem;
    font-weight: 700;
  }
}
</style>
