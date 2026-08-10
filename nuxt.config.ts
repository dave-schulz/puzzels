// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: {
    enabled: true,
  },
  modules: [
    '@vueuse/nuxt',
  ],
  ignore: [
    '.pnpm-store/**',
  ],
  app: {
    head: {
      title: 'Puzzels',
      htmlAttrs: {
        lang: 'nl',
      },
      meta: [
        {
          name: 'viewport',
          content: 'width=device-width, initial-scale=1',
        },
      ],
    },
  },
  vite: {
    server: {
      watch: {
        ignored: [
          '**/node_modules/**',
          '**/.pnpm-store/**',
          '**/.git/**',
        ],
      },
    },
  },
})
