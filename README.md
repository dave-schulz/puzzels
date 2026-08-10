# Puzzels

Nederlandse daily-puzzle app. Eerste mijlpaal: speelbare Wordle met Postgres.

## Setup

```bash
pnpm install
cp .env.example .env
pnpm db:up
pnpm db:migrate
pnpm db:seed
```

## Development

```bash
pnpm dev
```

Open [http://localhost:3000](http://localhost:3000).

## Database

```bash
pnpm db:up        # start Postgres (Docker)
pnpm db:migrate   # migrations
pnpm db:seed      # woordenlijst + woord van vandaag
pnpm db:studio    # Prisma Studio
```

Default connection (see `.env.example`):

`postgresql://puzzels:puzzels@localhost:5432/puzzels`

## Notes

- Styling: eenvoudige SCSS (geen Tailwind)
- Daily Wordle via `GET /api/puzzles/today` (Prisma)
- Game logic: pure TypeScript in `shared/wordle/`
- Progress/streak voorlopig in `localStorage`

## Lint

```bash
pnpm lint
pnpm lint:fix
pnpm lint:style
```
