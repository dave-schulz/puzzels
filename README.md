# Puzzels

Nederlandse daily-puzzle app. Eerste mijlpaal: een speelbare Wordle.

## Setup

```bash
pnpm install
```

## Development

```bash
pnpm dev
```

Open [http://localhost:3000](http://localhost:3000).

## Notes

- Styling: eenvoudige SCSS (geen Tailwind)
- Puzzeldata: hardcoded in `shared/wordle/mockPuzzle.ts`
- Game logic: pure TypeScript in `shared/wordle/logic.ts`

## Lint

```bash
pnpm lint
pnpm lint:fix
pnpm lint:style
```

Lint-setup volgt Crime: `@antfu/eslint-config` + Stylelint.
